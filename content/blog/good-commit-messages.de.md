---
title: "Gute Commit-Messages"
date: 2018-07-08
slug: "gute-commit-messages"
---

Persönlich schaue ich mir gerne die Commit-History von verschiedenen Projekten an. 
Häufig stelle ich fest, dass die Commit-Messages nur wenig Aufschluss über die tatsächlichen Änderungen im Code geben.

<!--more-->

Gute Commit-Messages helfen

1. beim Code-Review-Prozess,
2. beim Erstellen von Changelogs,
3. anderen Software-Entwicklern die Änderungen am Quellcode nachvollziehen zu können.

Gute Commit-Messages zeigen also, ob man ein Teamplayer ist oder nicht. 
Generell gilt: Quellcode ist vor allem dafür da, damit dieser von anderen Menschen gelesen und verstanden wird.
Die Commit-Message stellt also eine Hilfe dar, um eine Änderung einfacher verstehen zu können.

Aus der Praxis hat sich dabei für mich folgende Form der Commit-Message als optimal herausgestellt:

```text
WEB-123 Summary of the commit (less than 50 chars)

The commit message should begin with the task ID of the ticket system 
followed by a short summary. The first line may not exceed 50 
characters because some software like GitHub will strip the rest of 
the line.

The following text can be structured into paragraphs.
```

Die erste Zeile ist die Zusammenfassung der Änderung und ist auf 50 Zeichen beschränkt, damit der Inhalt möglichst nicht abgeschnitten wird.
Bei umfassenderen Änderungen kann eine detailliertere Beschreibung in mehreren Paragraphen erfolgen.

Bei den meisten Projekten arbeite ich mit [Jira](https://www.atlassian.com/software/jira). 
Dort setzt sich die Ticket-Nummer aus einer Buchstabenfolge, gefolgt von einem Bindestrich und einer Zahl zusammen.
Wird dieser Key der Commit-Message vorangestellt, erleichtert das die Suche nach den Tasks, die zu diesem Commit gehören, ungemein.

Die Zusammenfassung in der ersten Zeile und der Beschreibungstext sollte sich dabei auf die Änderungen des Commits beziehen. 
Erklärt werden, sollten vor allem *was* und *warum*, statt *wie* etwas geändert wurde.

### Sieben Regeln

In seinem Blog-Artikel [„How to Write a Git Commit Message“](https://chris.beams.io/posts/git-commit/) stellt Chris Beams sieben Regeln für Commit-Messages auf:

1. Separiere den Betreff vom Body mit einer Leerzeile
2. Begrenze die Betreffzeile auf 50 Zeichen
3. Beginne die erste Zeile mit einem Großbuchstaben
4. Lasse den Punkt am Ende der ersten Zeile weg
5. Verwende den Imperativ in der Betreffzeile
6. Füge ein Umbruch nach 72 Zeichen im Body ein
7. Verwende den Body, um zu erklären *was* und *warum* statt *wie*

### Sprache

Englisch ist die [Lingua Franca](https://en.wikipedia.org/wiki/Lingua_franca) der Informatik. 
Funktionen, Variablen und Kommentare sind bei den meisten Softwareprojekten in Englisch verfasst.
Das gleiche sollte auch für Commit-Messages gelten.
Die Versionshistorie kann auch Jahre später für einen Entwickler noch wichtig sein.
Auch wenn alle Mitarbeiter derzeit z. B. Deutsch sprechen, sollte trotzdem Englisch verwendet werden.
Das gewährleistet das Arbeiten in einem internationalen Team.

### Ticket-Nummer voranstellen

Besonders in großen Projekten stellt sich die Verwendung von Ticket-Nummern in den Commit-Messages als ein großer Vorteil dar.
In der Regel enthalten die Tickets weitere Zusatzinformationen, die bei späteren Recherchen im Quelltext helfen können.
In Jira Beispielsweise besteht eine Ticket-Nummer aus einer folge von Buchstaben gefolgt von einem Bindestrich und einer Zahl.
Anderen Entwicklern erleichtert das die Suche nach den Entsprechenden Aufgaben im Ticket-System.

Zudem können die Ticket-Nummern verwendet werden, um zu prüfen, welche Aufgaben in einem Release vorhanden sind.
Mit einem einfachen Befehl auf der Kommandozeile lassen sich so alle Tickets auflisten, die in einem Release vorhanden sind.
Mit folgendem Befehl lassen sich in Git alle Ticket-Nummern auflisten, die in einem Release implementiert wurden:

```bash
git log 2.4.0..2.5.0 --pretty=oneline | perl -ne '{ /(\w+)-(\d+)/ && print "$1-$2,"}'
```

In dem Beispiel stellt `2.5.0` die zu betrachtende Version dar und `2.4.0` ist die unmittelbar vorhergehende Version.
Auf diese weise lassen sich z. B. auch der *develop*-Branch mit dem *master* vergleichen:

```bash
git log 2.4.0..2.5.0 --pretty=oneline | perl -ne '{ /(\w+)-(\d+)/ && print "$1-$2,"}'
```

Das Ergebnis ist eine Kommaseparierte Liste von Keys (bspw. `WEB-123,WEB-456,WEB-789`), die dann in einem JQL-Query in Jira verwendet werden kann.
Der Query sieht dann in etwa so aus:

```JQL
key IN (WEB-123,WEB-456,WEB-789)
```

### Pre-Receive-Hook einrichten

Die Einhaltung einiger Regeln, die hier beschrieben worden sind, können durch einen Pre-Receive-Hook erzwungen werden.
Bei GitLab lassen sich dazu so genannte „Push Rules“ anlegen.
Um das voranstellen einer Jira-Ticket-Nummer zu erzwingen kann folgender regulärer Ausdruck hinterlegt werden:

```regexp
[A-Z]{2,6}-\d+
```

Ist der Projekt-Key bekannt, kann statt `[A-Z]{3,6}` auch der konkrete Key gesetzt werden.
In unserem Beispiel für das Projekt `WEB` würde der Ausdruck dann so aussehen:

```regexp
WEB-\d+
```

Die Push-Regeln lassen sich in GitLab unter dem Punkt *Repository* &gt; *Repository* &gt; *Push Rules* einstellen.

### Zusammenfassung

Gute Commit-Messages helfen bei der Erstellung von Software.
Schreibe Deine Messages also immer so, dass sie anderen Entwicklern und im Zweifel später auch Dir helfen.

1. Halte Dich an die sieben Regeln
2. Schreibe Commit-Messages stets auf Englisch
3. Füge immer eine Ticket-Nummer hinzu
4. Lasse die Einhaltung durch automatisierte Regeln überwachen
