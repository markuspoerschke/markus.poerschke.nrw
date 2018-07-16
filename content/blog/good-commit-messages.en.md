---
title: "Good Commit Messages"
date: 2018-07-15
---

Personally I like to look at the commit history of different projects.
Often I find that the commit messages provide only little information about the actual changes in the code.

Good commit messages help

1. in the review process,
2. when creating changelogs,
3. to be capable of tracking the changes to the source code made by other software developers.

This means that good commit messages show whether you are a team player or not.
In general: source code is mainly there for other people to read and understand.

From practical experience, the following form of commit message has proven to be optimal for me:

```text
WEB-123 Summary of the commit (less than 50 chars)

The commit message should begin with the task ID of the ticket system 
followed by a short summary. The first line may not exceed 50 
characters because some software like GitHub will strip the rest of 
the line.

The following text can be structured into paragraphs.
```

The first line is the summary of the change and is limited to 50 characters, so that the content is not shortened if possible.
For more comprehensive changes, a more detailed description can be given in several paragraphs.

I work with [Jira](https://www.atlassian.com/software/jira) on most projects.
There, the ticket number consists of a sequence of letters followed by a hyphen and a number.
If this key is placed in front of the commit message, the search for the tasks belonging to this commit is simplified a lot.

The summary in the first line and the description text should refer to the changes to the source code. You should answer 

The summary in the first line and the description text should refer to the change of the commit.
You should explain *what* was changed and *why* it was changed instead of *how* it was changed.

### Seven Rules

In his blog article ["How to Write a Git Commit Message"](https://chris.beams.io/posts/git-commit/) Chris Beams sets out seven rules for commit messages:

1. separate the subject from the body with a blank line
2. limit the subject line to 50 characters
3. start the first line with a capital letter
4. omit the dot at the end of the first line
5. use the imperative in the subject line
6. wrap the body after 72 characters
7. use the body to explain *what* and *why* instead of *how*

### Language

English is the [Lingua Franca](https://en.wikipedia.org/wiki/Lingua_franca) of computer science. 
Functions, variables and comments are written in English in most software projects.
The same should apply to commit messages.
The version history can still be important for a developer even years later.
Even if all employees currently speak German, for example, English should still be used.
This guarantees working in an international team.

### Prepend ticket number

Especially in large projects, the use of ticket numbers in commit messages is a big advantage.
Usually the tickets contain additional information that can help with later research in the source code.
In Jira, for example, a ticket number consists of a sequence of letters followed by a hyphen and a number.
This makes it easier for other developers to search for the corresponding tasks in the ticket system.

In addition, the ticket numbers can be used to check which tasks exist in a release.
With a simple command on the prompt you can list all tickets that are available in a release.
The following command lists all ticket numbers in Git that have been implemented in a release:

```bash
git log 2.4.0..2.5.0 --pretty=oneline | perl -ne '{ /(\w+)-(\d+)/ && print "$1-$2,"}'
```

In the example, `2.5.0` represents the version to be looked at and `2.4.0` is the previous version.
In this way, for example, the *develop* branch can also be compared with the *master*:

```bash
git log 2.4.0..2.5.0 --pretty=oneline | perl -ne '{ /(\w+)-(\d+)/ && print "$1-$2,"}'
```

The result is a comma-separated list of keys (e.g. `WEB-123,WEB-456,WEB-789`), which can then be used in a JQL query in Jira.
The query then looks like this:

```JQL
key IN (WEB-123,WEB-456,WEB-789)
```

### Set up pre-receive hook

Some of the rules described here can be forced by a pre-receive hook.
In GitLab, so-called "push rules" can be defined for this purpose.
To force the prefix of a Jira ticket number, the following regular expression can be used:

```regexp
[A-Z]{2,6}-\d+
```

If the project key is known, the concrete key can be set instead of `[A-Z]{3,6}`.
In our example for the project `WEB` the expression would look like this:

```regexp
WEB-\d+
```

The push rules can be set in GitLab (requires Starter/Bronze) under *Repository* &gt; *Repository* &gt; *Push Rules*.

### Summary

Good commit messages help to create software.
So be sure to write your messages in a way that they will help other developers and, if in a moment of doubt, you, too.

1. follow the seven rules
2. always write commit messages in English
3. always add a ticket number
4. check that rules for commit messages are being followed automatically
