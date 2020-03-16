---
title: "Run Ackee on a self-hosted Dokku server"
date: 2019-10-20
slug: "run-ackee-on-dokku"
description: "Tutorial: For the range measurement on websites, the analysis tool Ackee can be installed on a self-hosted docu server."
---

[Ackee](https://ackee.electerious.com) is an analytics tool that captures statistics about website visits.
Unlike other applications in this area, Ackee does not use cookies at all.
With the help of the provided Docker image, the tool can easily be installed on a self-hosted Dokku server.

<!--more-->

The analytics software was written in NodeJS and uses MongoDB to store the data.
It can optionally be run directly on a server if Node is present and is also offered as a [Docker Image](https://hub.docker.com/r/electerious/ackee).
This means that the application can be run on a Dokku server.
[Dokku](http://dokku.viewdocs.io/dokku/) is a <abbr title="Platform as a Service implementation">PaaS</abbr> that can be run on an own server.

<figure>
    <a href="/images/2019-10-20-install-ackee-on-dokku-server/ackee.png">
        <img src="/images/2019-10-20-install-ackee-on-dokku-server/ackee.png" alt="Ackee’s User Interface">
    </a>
    <figcaption>
        Ackee's user interface allows you to view statistics for multiple websites.
    </figcaption>
</figure>

Ackee can be seen as an alternative to Google Analytics or Matomo (formerly known as Piwik).
However, it does not use cookies, so there is no need to display a cookie banner.
To prevent page views from being counted twice, a hash is calculated for each visitor.
The hash consists of the IP address and the user agent of the visitor as well as a random salt that changes daily.
By updating the salt daily, it is impossible to track the visitor over a longer period of time.

## Prerequisites

For the installation to be successful, the following prerequisites must be fulfilled:

* Server with a freshly installed Ubuntu with SSH access and root privileges
* Website on which the tracker code can be integrated

## Installation

If a Dokku server has already been set up, step 1 can be skipped and started directly with [step 2](#step-2-create-application).

### Step 1: Install Dokku

Before Dokku can be installed, a domain (or subdomain) must be set up as a wildcard domain so that the subdomains can be used for the individual applications.

Dokku itself is installed from the command line.
Dokku provides a bash script, which automatically performs the installation.

But first, a public-private key pair must be created for the root user:

```bash
ssh-keygen -t rsa -P "" -b 4096 -f ~/.ssh/id_rsa
```

The installation script by Dokku can then be executed.
This process takes a few minutes.

```bash
wget https://raw.githubusercontent.com/dokku/dokku/v0.18.5/bootstrap.sh;
sudo DOKKU_TAG=v0.18.5 bash bootstrap.sh
```

The `wget ...` command downloads the installation script and the second command executes this script on the server.
The version, here `0.18.5`, should be replaced by the current version. 
(At the time of writing, the [version `0.19.2` of Dokku was not installable](https://github.com/dokku/dokku/issues/3717).)
An overview of the [available Dokku versions](https://github.com/dokku/dokku/releases) can be found on the GitHub page of the project.


After the installation script has been run, the installation has to be finished via the web interface. 
To do this, the Dokku domain is opened in the web browser.
It is important that this step is fully completed, otherwise it is possible that the Dokku server is taken over, as the web interface is not protected by any password until the installation is completed.

### Step 2: Create Application

For Ackee a new application is created in Dokku.
This happens with this command:

```bash
dokku apps:create ackee
```

In this example `ackee` is the name of the application and will be used in the next steps of the installation.
If necessary, a different name can also be specified; then it must also be adapted in the following steps.

### Step 3: Define login credentials

The statistics are protected by a login procedure.
The username and password are set via environment variables:

```bash
dokku config:set ackee ACKEE_USERNAME=admin ACKEE_PASSWORD=password
```

The values `admin` and `password` should be replaced by any user name and a secure password.

### Step 4: Create database

Before the application can be started, the database must first be set up.
To use MongoDB together with Dokku, the [MongoDB-Plugin](https://github.com/dokku/dokku-mongo) is installed:

```bash
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo
```

Now a new database with the name `ackee` can be created:

```bash
dokku mongo:create ackee
```

So that the database can also be used by the `ackee` application, the database must be linked to the application:

```bash
dokku mongo:link ackee ackee
```

The command creates an environment variable called `MONGO_URL`, but the variable Ackee uses is called `ACKEE_MONGODB`.
For this reason, the value of `MONGO_URL` is copied to the variable `ACKEE_MONGODB`:

```bash
dokku config:set ackee ACKEE_MONGODB=`dokku config:get ackee MONGO_URL`
```

### Step 5: Start application

First, the current version number is determined on the [Release page](https://github.com/electerious/Ackee/releases).
At the time of this writing, the most recent version is `1.3.0`.
Then the following commands are executed one after the other:

```bash
docker pull electerious/ackee:1.3.0
docker tag electerious/ackee:1.3.0 dokku/ackee:1.3.0
dokku tags:deploy ackee 1.3.0
```

Explanation:

* `docker pull electerious/ackee:1.3.0` downloads the docker image from the docker hub.
* `docker tag electerious/ackee:1.3.0 dokku/ackee:1.3.0` creates a local tag `dokku/ackee:1.3.0` for the Docker image.
  Applications in Dokku are locally tagged in the format `dokku/[NAME DER ANWENDUNG]:[VERSION]`.
* `dokku tags:deploy ackee 1.3.0` instructs Dokku to deploy the application.

### Step 6: Port mapping

Ackee is executed on port `3000`.
Since this does not correspond to the standard HTTP port `80`, a port mapping from port `80` to port `3000` must be established:

````bash
dokku proxy:ports-set ackee http:80:3000
````

### Step 7: Enable HTTPS encryption

The application should be secured by HTTPS to reflect the current state of security.
Certificates can be stored in Dokku, but the process can also be automated.
The [Let's Encrypt Plugin for Dokku](https://github.com/dokku/dokku-letsencrypt) provides an easy way to do this.

The plugin must first be installed:

```bash
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
```

The application is then configured for HTTPS.
The value `DOKKU_LETSENCRYPT_EMAIL` must be set to a real contact address.
Let’s Encrypt sends notifications to this e-mail, for example, when the certificate expires and needs to be renewed.

```bash
dokku config:set --no-restart ackee DOKKU_LETSENCRYPT_EMAIL=contact@example.org
dokku letsencrypt ackee
``` 

### Step 8: Set up the CORS header

Since browsers prevent ajax requests to other domains - so-called "cross origin requests" - a corresponding HTTP header must be set.
A more detailed description of the [needed CORS header]((https://github.com/electerious/Ackee/blob/master/docs/CORS%20headers.md)) can be found in the documentation.

The following content must be written to the file `/home/dokku/ackee/nginx.conf.d/cors-headers.conf`.
This will change the Nginx configuration for the application to always send the CORS headers.

```nginx
# /home/dokku/ackee/nginx.conf.d/cors-headers.conf
add_header  Access-Control-Allow-Origin "*" always;
add_header  Access-Control-Allow-Methods "POST, PATCH, OPTIONS" always;
add_header  Access-Control-Allow-Headers "DNT, X-CustomHeader, Keep-Alive, User-Agent, X-Requested-With, If-Modified-Since, Cache-Control, Content-Type" always;
```

After the file is created, the Nginx server must be restarted:

````bash
service nginx restart
````

### Step 9: Create tracking script

The installation of Ackee is now complete.
In order to obtain statistics, a tracking script must be added to the respective website.
To do so the following steps have to be performed:

1. Login to the Ackee interface.
   The command `dokku domains:report ackee` shows the correct URL.
2. Enter the access data (user name and password).
   The data for this were deposited in step 3.
3. Under "Settings" in the section "Domains" add a new domain with the button "New domain".
After the new domain has been created, the script snippet can be displayed by clicking on the domain.
5. Insert the `<script>` tag with the label "Embeded code" on the website.

The statistics are now recorded in Ackee.

## Update Ackee

To update Ackee, the procedure is about the same as in step 5.
First the new version is downloaded from the Docker hub, tagged and then started.

In our example, the newer version is `1.4.0`, this value must be replaced by the version to which it shall be updated.

```bash
docker pull electerious/ackee:1.4.0
docker day electerious/ackee:1.4.0 dokku/ackee:1.4.0
dokku tags:deploy ackee 1.4.0
```

If you want to switch back to an older version, you can proceed accordingly.
The information about [current releases](https://github.com/electerious/Ackee/releases) is available on the GitHub page.


## Weblinks

* [Ackee Projekt-Website](https://ackee.electerious.com/)
* [Dokku Projekt-Website](http://dokku.viewdocs.io/dokku/)
