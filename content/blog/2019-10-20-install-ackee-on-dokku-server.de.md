---
title: "Ackee auf dem eigenen Dokku-Server installieren"
date: 2019-10-20
slug: "ackee-auf-dem-eigenen-dokku-server-installieren"
description: "Anleitung: Für die Reichweitenmessung auf Webseiten, kann das Analyse-Tool Ackee auf einem self-hosted Dokku-Server installiert werden."
---

[Ackee](https://ackee.electerious.com) ist ein Analyse-Tool, mit dem Statistiken über Webseitenbesuche erfasst werden können.
Anders als andere Anwendungen in diesem Bereich, kommt Ackee ganz ohne die Verwendung von Cookies aus.
Mit Hilfe des bereitgestellten Docker-Images kann das Tool ganz leicht auf dem eigenen Dokku-Server installiert werden.

<!--more-->

Die Analysesoftware wurde in NodeJS geschrieben und nutzt MongoDB zum speichern der Daten.
Sie kann wahlweise direkt auf einem Server ausgeführt werden, wenn Node vorhanden ist und wird auch als [Docker Image](https://hub.docker.com/r/electerious/ackee) angeboten.
Dadurch kann die Anwendung auf einem Dokku-Server ausgeführt werden.
[Dokku](http://dokku.viewdocs.io/dokku/) ist eine PaaS-Implementierung, die auf dem eigenen Server betrieben werden kann.

<figure>
    <a href="/images/2019-10-20-install-ackee-on-dokku-server/ackee.png">
        <img src="/images/2019-10-20-install-ackee-on-dokku-server/ackee.png" alt="Ackees Benutzeroberfläche">
    </a>
    <figcaption>
        Auf der Benutzeroberfläche von Ackee lassen sich die Statistiken zu mehreren Websites darstellen.
    </figcaption>
</figure>

Ackee kann als Alternative zu Google Analytics oder Matomo (ehemals Piwik) gesehen werden.
Es verwendet jedoch keine Cookies, daher muss somit auch kein Cookie-Banner angezeigt werden.
Um zu verhindern, dass Seitenaufrufe doppelt gezählt werden, wird ein Hash für jeden Besucher berechnet.
Der Hash besteht aus der IP-Adresse und dem User-Agent des Besuchers sowie einem zufälligen Salt, der täglich wechselt.
Durch das tägliche Aktualisieren des Salts ist längerfristiges Tracking unmöglich.  

## Vorraussetzungen

Damit die Installation gelingt, müssen folgende Vorrsaussetzungen erfüllt sein:

* Server mit einem frisch installiertem Ubuntu mit SSH-Zugriff und Root-Rechten
* Website, auf der der Tracker-Code eingebunden werden kann

## Installation

Wenn ein Dokku-Server bereits eingerichtet ist, dann kann der Schritt 1 übersprungen werden und direkt mit [Schritt 2](#schritt-2-anwendung-erstellen) begonnen werden.

### Schritt 1: Dokku installieren

Bevor Dokku installiert werden kann, muss eine Domain (oder Subdomain) als Wildcard-Domain eingerichtet werden, damit die Subdomains für die einzelnen Anwendungen verwendet werden können.

Die Installation von Dokku selbst erfolgt über die Kommandozeile.
Dokku liefert ein Bash-Script, welches die Installation automatisch übernimmt.

Zunächst muss ein Public-Private-Key-Paar für den Root-Benutzer erstellt werden:

```bash
ssh-keygen -t rsa -P "" -b 4096 -f ~/.ssh/id_rsa
```

Danach kann das Installationsskript von Dokku ausgeführt werden.
Dieser Vorgang dauert einige Minuten.

```bash
wget https://raw.githubusercontent.com/dokku/dokku/v0.18.5/bootstrap.sh;
sudo DOKKU_TAG=v0.18.5 bash bootstrap.sh
```

Der Befehl `wget ...` lädt das Installationsscript herunter und der zweite Befehl führt dieses Script auf dem Server aus.
Die Version, hier `0.18.5`, sollte durch die gerade aktuelle Version ersetzt werden. 
(Zum Zeitpunkt des Artikel war die [Version `0.19.2` von Dokku nicht installierbar](https://github.com/dokku/dokku/issues/3717).)
Eine Übersicht der [verfügbaren Dokku-Versionen](https://github.com/dokku/dokku/releases) finden sich auf der GitHub-Seite des Projektes.

Nachdem das Installationsskript durchgelaufen ist, muss die Installation noch über die Weboberfläche beendet werden. 
Dazu wird die Domain von Dokku im Browser aufgerufen.
Es ist wichtig, dass dieser Schritt vollständig abgeschlossen wird, da es sonst möglich ist den Dokku-Server zu übernehmen, da die Weboberfläche bis zum Abschluss der Installation nicht durch ein Passwort geschützt ist.

### Schritt 2: Anwendung erstellen

Für Ackee wird eine neue Anwendung in Dokku angelegt.
Dies passiert mit diesem Befehl:

```bash
dokku apps:create ackee
```

In diesem Beispiel ist `ackee` der Name der Anwendung und wird in den weiteren Schritten der Installation verwendet.
Bei Bedarf kann auch ein anderer Name angegeben werden; dann muss dieser auch in den nachfolgenden Schritten angepasst werden.

### Schritt 3: Zugangsdaten hinterlegen

Die Statistiken werden über einen Login-Mechanismus gesichert.
Der Benutzername und das Passwort werden über Umgebungsvariablen gesetzt:

```bash
dokku config:set ackee ACKEE_USERNAME=admin ACKEE_PASSWORD=password
```

Die Werte `admin` und `password` sollten durch einen beliebigen Benutzernamen und ein sicheres Passwort ausgetauscht werden.

### Schritt 4: Datenbank erstellen

Bevor die Anwendung gestartet werden kann, muss zunächst die Datenbank eingerichtet werden.
Um MongoDB zusammen mit Dokku zu verwenden, wird das [MongoDB-Plugin](https://github.com/dokku/dokku-mongo) installiert:

```bash
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo
```

Jetzt kann eine neue Datenbank mit dem Namen `ackee` angelegt werden:

```bash
dokku mongo:create ackee
```

Damit die Datenbank auch von der `ackee`-Anwendung verwendet werden kann, muss die Datenbank noch mit der Anwendung verknüpft werden:

```bash
dokku mongo:link ackee ackee
```

Der Befehl erstellt eine Umgebungsvariable mit dem Namen `MONGO_URL`, jedoch heißt die Variable, die von Ackee beachtet wird `ACKEE_MONGODB`.
Aus diesem Grund wird der Inhalt von `MONGO_URL` in die Variable `ACKEE_MONGODB` kopiert:

```bash
dokku config:set ackee ACKEE_MONGODB=`dokku config:get ackee MONGO_URL`
```

### Schritt 5: Anwendung starten

Zunächst wird auf der [Release-Seite](https://github.com/electerious/Ackee/releases) die aktuellen Versionsnummer ermittelt.
Zum Zeitpunkt dieses Artikels ist die aktuellste Version `1.3.0`.
Dann werden folgende Befehle hintereinander ausgeführt:

```bash
docker pull electerious/ackee:1.3.0
docker tag electerious/ackee:1.3.0 dokku/ackee:1.3.0
dokku tags:deploy ackee 1.3.0
```

Erläuterung:

* `docker pull electerious/ackee:1.3.0` lädt das Docker-Image aus dem Docker-Hub herunter.
* `docker tag electerious/ackee:1.3.0 dokku/ackee:1.3.0` erstellt lokal einen Tag `dokku/ackee:1.3.0` für das Docker-Image.
  Die Anwendungen in Dokku werden lokal immer im Format `dokku/[NAME DER ANWENDUNG]:[VERSION]` getaggt.
* `dokku tags:deploy ackee 1.3.0` weist Dokku an, die Anwendung auszurollen.

### Schritt 6: Port-Mapping

Ackee wird auf dem Port `3000` ausgeführt.
Da dies nicht dem Standard-HTTP-Port `80` entspricht, muss ein Port-Mapping von Port `80` auf Port `3000` eingerichtet werden:

````bash
dokku proxy:ports-set ackee http:80:3000
````

### Schrit 7: HTTPS-Verschlüsselung aktivieren

Die Anwendung sollte per HTTPS gesichert werden, um dem aktuellen Stand der Sicherheit zu entsprechen.
In Dokku können Zertifikate hinterlegt werden, jedoch kann der Prozess auch automatisiert erfolgen.
Das [Let’s Encrypt Plugin für Dokku](https://github.com/dokku/dokku-letsencrypt) bietet eine einfache Möglichkeit dies umzusetzen.

Es muss zunächst das Plugin installiert werden:

```bash
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
```

Danach wird die Anwendung konfiguriert.
Für den Wert `DOKKU_LETSENCRYPT_EMAIL` muss eine Kontakt-E-Mail hinterlegt werden.
Dorthin sendet Let’s Encrypt beispielsweise Benachrichtigungen, wenn das Zertifikat abläuft und erneuert werden muss.

```bash
dokku config:set --no-restart ackee DOKKU_LETSENCRYPT_EMAIL=contact@example.org
dokku letsencrypt ackee
``` 

### Schritt 8: CORS-Header einrichten

Da Browser Ajax-Anfragen an andere Domains – sogenannte „Cross Origin Requests“ – verhindern, muss ein entsprechender HTTP-Header gesetzt werden.
Eine genauere Beschreibung zum Thema [CORS-Header liefert die Dokumentation](https://github.com/electerious/Ackee/blob/master/docs/CORS%20headers.md).

Der folgende Inhalt muss in die Datei `/home/dokku/ackee/nginx.conf.d/cors-headers.conf` geschrieben werden.
Dadurch wird die Nginx-Konfiguration für die Anwendung so angepasst, dass immer die CORS-Header mitgeschickt werden.

```nginx
# /home/dokku/ackee/nginx.conf.d/cors-headers.conf
add_header  Access-Control-Allow-Origin "*" always;
add_header  Access-Control-Allow-Methods "POST, PATCH, OPTIONS" always;
add_header  Access-Control-Allow-Headers "DNT, X-CustomHeader, Keep-Alive, User-Agent, X-Requested-With, If-Modified-Since, Cache-Control, Content-Type" always;
```

Nachdem die Datei erstellt wurde, muss der Nginx-Server neugestartet werden:

````bash
service nginx restart
````

### Schritt 9: Trackingscript erstellen

Die Installation von Ackee ist jetzt abgeschlossen.
Damit Statisktiken erhoben werden können, wird ein Tracking-Script auf der jeweilgen Website eingebunden.
Hierzu werden die folgenden Schritte vorgenommen:

1. Login in die Ackee-Oberfläche.
   Die richtige URL kann der Befehl `dokku domains:report ackee` anzeigen.
2. Die Zugangsdaten (Benutzername und Passwort) eingeben.
   Die Daten hierfür wurden in Schritt 3 hinterlegt.
3. Unter „Settings“ im Abschnitt „Domains“ eine neue Domain mit dem Button „New domain“ hinzufügen.
4. Nachdem die neue Domain angelegt wurde, kann das Script-Snippet durch Klick auf die Domain angezeigt werden.
5. Das `<script>`-Tag mit dem Label „Embeded code“ auf der Website einfügen.

Die Statistiken werden jetzt in Ackee erfasst.

## Ackee aktualisieren

Um Ackee zu aktualisieren wird in etwa genauso vorgegangen, wie in Schritt 5.
Zunächst wird die neue Version aus dem Docker-Hub heruntergeladen, getaggt und dann gestartet.

In unserem Beispiel ist die neuere Version `1.4.0`, dieser Wert muss durch die Version ausgetauscht werden, auf die aktualisiert werden soll.

```bash
docker pull electerious/ackee:1.4.0
docker tag electerious/ackee:1.4.0 dokku/ackee:1.4.0
dokku tags:deploy ackee 1.4.0
```

Falls auf eine ältere Version zurückgewechselt werden soll, kann entsprechend verfahren werden.
Die Informationen zu [aktuellen Releases](https://github.com/electerious/Ackee/releases) hält die GitHub-Seite bereit.

## Weblinks

* [Ackee Projekt-Website](https://ackee.electerious.com/)
* [Dokku Projekt-Website](http://dokku.viewdocs.io/dokku/)
