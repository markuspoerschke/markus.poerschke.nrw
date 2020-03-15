---
title: "Ein Agiler Arbeitsablauf für Menschen"
date: 2020-03-15
slug: "ein-agiler-arbeitsablauf-fuer-menschen"
---

Die Entwicklung von Software ist eine Herausforderung.
Viele Arbeitsabläufe sind einfach zu kompliziert und nicht intuitiv genug.
Individuen und die Interaktion zwischen Menschen stehen kaum noch im Vordergrund.
Es entsteht der Eindruck, dass der perfekte Prozess keine Entscheidungen der beteiligten Personen mehr zulässt.
Ist das noch im Sinne des Agilen Manifests?
In diesem Artikel möchte ich einen einfachen agilen Entwicklungsprozess vorstellen, der den Menschen in den Mittelpunkt stellt.

<!--more-->

Viele Arbeitsabläufe versuchen, alle denkbaren Situationen und Zustände abzudecken, die vielleicht irgendwann einmal auftreten könnten.
Dies führt oft zu Verwirrung und Frustration bei den beteiligten Personen.
Am Ende geht es nicht mehr darum, einen Wert für das Produkt zu schaffen, sondern das „Ticket“ einfach weiter zu schieben.
Spätestens es dann soweit kommt, dass das Zuweisen an einen Kollegen von der eigenen Verantwortung „befreit“, sollte die „Agilität“ des Projektvorgehens in Frage gestellt werden.

Die nachfolgende Grafik zeigt eine überspitzte Darstellung eines hochgradig komplizierten Arbeitsablauf.
Jeder der gezeigten Zustände ist mir bereits bei der Arbeit in unterschiedlichen Projekten begegnet.
Es wird versucht, jeden einzelnen Schritt im Prozess zu definieren und abzubilden.
Dabei entstehen immer neue Wege innerhalb des Prozesses, die die Außnahmen von Außnahmen behandeln.

<figure>
    <a href="/images/2019-02-29-agile-workflow/anti-agile-workflow.svg">
        <img src="/images/2019-02-29-agile-workflow/anti-agile-workflow.svg" alt="Darstellung eines Prozesses mit über 20 Zuständen und vielen Schleifen">
    </a>
    <figcaption>
        Die überspitzte Darstellung eines zu komplizierten Arbeitsablaufes.
    </figcaption>
</figure>

Die agilen Vorgehensmodelle stützen sich in der Regel auf das „[Manifest für Agile Softwareentwicklung][1]“.
Dort heißt es, dass „Individuen und Interaktionen mehr als Prozesse und Werkzeuge“ geschätzt werden.
Daher stellt sich die Frage, wo die Interaktion der Individuen bei einem solchen Ablauf bleibt, wo die Kommunikation nur noch über das Ändern des Status oder das Zuweisen an eine Person stattfindet.

## Glossar

Bevor ich einen alternativen Ablauf vorstelle, möchte ich zunächst die Begrifflichkeiten klären, die in diesem Zusammenhang wichtig sind.

* **Eintrag:**
    Ein Eintrag (engl. „item“) ist die Einheit, die durch das Team vorbereitet, geplant und umgesetzt wird.
    Andere Begriffe sind Ticket oder Issue. Liegt eine spezielle Form vor, wird auch oft von einer „User-Story” oder einfach nur von einer „Story” gesprochen.
    Um keiner Methode einen Vorrang zu geben, wird hier einfach nur der Begriff Eintrag verwendet.

* **Arbeitsablauf:**
    The workflow, defines the steps that an item must go through until it adds value to the product.

* **Übergang:**
    Der Wechsel zwischen zwei Status wird als Übergang bezeichnet.
    Oft wird der Übergang an bestimmte Bedingungen geknüpft, die zuvor erfüllt sein müssten.

## Der Arbeitsablauf

Der agile Arbeitsablauf benötigt nicht viel.
Er kommt mit vier Status und drei Übergängen aus.
Er ist einfach, einprägsam und auf das notwendigste reduziert.
Das Prinzip „Einfachheit -- die Kunst, die Menge nicht getaner Arbeit zu maximieren -- ist essenziell“ aus dem Agilen Manifest wird so erfüllt.

<figure>
    <a href="/images/2019-02-29-agile-workflow/agile-workflow.svg">
        <img src="/images/2019-02-29-agile-workflow/agile-workflow.svg" alt="Darstellung eines Prozesses mit den Status Backlog, Ready, In Progress und Done.">
    </a>
    <figcaption>
        Der agile Arbeitsablauf kommt mit vier Status und drei Übergängen aus.
    </figcaption>
</figure>

Der agile Arbeitsablauf besteht also aus den Status

* Backlog
* Ready (dt. „bereit“)
* In Progress (dt. „in Bearbeitung“)
* und Done (dt. „fertig“).

Vergleicht man diese Status mit dem [Scrum-Guide][2], so stellt man fest, dass diese dort teilweise ebenfalls erwähnt und von dort abgeleitet werden können.
Dieser Arbeitsablauf eignet sich somit vor allem, wenn Scrum als Vorgehensmodell verfolgt wird.

Nachfolgend werden alle Status beschrieben.

### Backlog

Einträge im Backlog müssen noch verbessert werden, bevor mit der Arbeit an ihnen begonnen werden kann.
In Planungsmeetings, wie beispielsweise bei einem Backlog-Refinement, werden die Einträge angepasst, sodass sie die Definiton of Ready erfüllen.
Diese Einträge werden unter Umständen noch umgeschrieben oder in mehrere Einträge aufgeteilt, wenn diese zu groß sind.

### Ready

Einträge, die sich im Status „Ready“ befinden, sind bereit, dass an ihnen gearbeitet werden kann.
Die Teammitglieder können sich gemäß dem „Pull-Prinzip“ an diesen Tickets bedienen, sobald sie vorhergehende Einträge abschlossen haben und Zeit für neue Arbeit haben.

### In Progress

Sobald ein Teammitglied an einem Eintrag arbeitet, erhält der Eintrag den Status „In Progress“.
Der Eintrag verbleibt in diesem Status bis alle Kriterien der Definition of Done erfüllt sind.
Ein zurücklegen in einen vorherigen Status ist nicht mehr möglich.
Eine einmal begonnene Arbeit muss abgeschlossen werden.

### Done

Die Definition of Done stellt Regeln auf, die erfüllt sein müssen, um ein Eintrag als abgeschlossen anzusehen.
Ein Eintrag wird als „Done“ angesehen, sobald alle diese Kriterien erfüllt sind.

## Die Übergänge

Die drei notwendigen Übergänge werden nachfolgend beschrieben.
Jeder dieser Übergänge stellt eigene Anforderungen, die Erfüllt sein müssen, damit ein Eintrag seinen Status wechseln kann.
Gennerell gibt es keine Schleifen oder Wiederholungen.
Ein Eintrag kann den Arbeitsablauf also nur linear in eine Richtung durchlaufen.

### Backlog zu Ready

Nur Einträge, die die Definition-of-Ready erfüllen, können vom Status Backlog zu Ready wechseln.
Die Definition, welche Regeln erfüllt sein müssen, werden dabei vom Team aufgestellt. 

### Ready zu In Progress

Ob mit der Arbeit an einem neuen Eintrag begonnen werden darf, regelt meist ein so genanntes Work-in-Progress-Limit (WIP-Limit).
Dieses bestimmt, wie viele Einträge sich maximal in einem Status befinden dürfen.
Dies ist für einige Teams auch der Grund neue Status einzuführen, um dieses Limit zu umgehen.
Das WIP-Limit soll jedoch dafür sorgen, dass bereits begonnene Arbeit abgeschlossen wird, bevor mit neuer Arbeit begonnen wird. 

### In Progress zu Done

Ähnlich wie beim Übergang von Backlog zu Ready bestimmt die Definition-of-Done, welche Einträge als abgeschlossen betrachtet werden können.
Erst wenn alle Regeln erfüllt sind, darf der Eintrag seinen Status zu „Done“ wechseln.
Mit dem Übergang von In Progress zu Done endet der Lebenszyklus eines Eintrages.
Das erneute „Öffnen“ -- also das Zurückgehen in einen vorherigen Status -- eines bereits abgeschlossenen Eintrages ist nicht erlaubt.
Werden weitere Änderungen am Produkt benötigt, so muss ein neuer Eintrag erstellt werden.

## Mit dem Arbeitsablauf arbeiten

Am einfachsten gestaltet sich die Arbeit mit dem Ablauf, wenn ein physisches Board verwendet wird.
Dafür wird auf einem Whiteboard ein Kanbanboard, wie in der nachfolgenden Grafik dargestellt aufgemalt.
Bunte Klebezettel fungieren als Einträge und können auf dem Board bewegt werden.

<figure>
    <a href="/images/2019-02-29-agile-workflow/board.svg">
        <img src="/images/2019-02-29-agile-workflow/board.svg" alt="Kanban-Board">
    </a>
    <figcaption>
        Die Status können als Spalten auf einem kanban-ähnlichen Board dargestellt werden.
    </figcaption>
</figure>

Die Einträge durchlaufen das Board von links nach rechts.
Die Sortierung von oben nach unten gibt die Reihenfolge an, in der die Einträge abgearbeitet werden sollen.
Dies ist vor allem für die Backlog-Spalte entscheidend, da dort die wertvollsten Einträge weiter oben stehen sollten.

Generell sollten die Einträge in der Reihenfolge von oben rechts nach unten links bearbeitet werden.
Dadurch werden die Einträge, die den meisten Wert erzeugen als erstes bearbeitet und bereits begonnene Arbeit wird fertiggestellt, bevor neue Arbeit begonnen wird.

Als Merksatz kann hierfür folgender Satz verwendet werden:

> „Start finishing, stop starting.“

Mit einer roten Linie (wie in der Grafik dargestellt) kann sich das Team darauf einigen, erst die wichtigsten Einträge abzuschließen.
Eine solche Linie kann z. B. der Umfang eines Sprints in Scrum sein. 

## „Aber wir brauchen doch...“

Manchmal gibt es einen guten Grund einen extra Status zu verwenden.
Oft ist dies aber nicht notwendig.
In diesem Kapitel möchte ich einige Beispiele für Status geben, die besser nicht verwendet werden sollten.

### Blocked

An Einträgen, die sich im Status "Blocked" befinden, kann nicht weiter gearbeitet werden.
Eine solche Situation sollte eigentlich die Ausnahme darstellen.
Warum sollte also dafür ein dedizierter Status geschaffen werden?
Oft sind es Situationen, die sich mit einer Defintion of Ready bereits im Vorfeld verhindern ließen.
Einträge, bei denen schon absehbar ist, dass sie „blockieren“, sollten gar nicht erst in „Ready“ oder gar „In Progress“ wandern.

Angenommen es wird eine Vorarbeit eines anderen Teams wie die Beschaffung eines Servers oder die Bereitstellung von Informationen benötigt,
dann sollte der Eintrag erst in „Ready“ geschoben werden, wenn diese Vorarbeiten abgeschlossen sind.

Sollte es doch zu einem Blocker kommen, kann auf einem physischen Board ein solcher Eintrag mit einem roten Post-It markiert werden.

Um bereits ein Teil der Arbeit abschließen zu können, kann ein Eintrag auch geteilt werden.
Dazu wird für die verbleibende Arbeit einfach ein neuer Eintrag erstellt, der dann ins Backlog verschoben wird.

### Warte auf...

Zwischenschritte und Wartepositionen brauchen nicht extra festgehalten werden, wenn sich das Team untereinander abspricht.
Tester und Entwickler sollten daher besser miteinander kommunizieren, welche Aufgaben zur Erfüllung eines Eintrages noch erledigt werden müssen.
Dadurch können dann Status, wie „Warte auf Test“ oder „Warte auf Code-Review“ entfallen.

In Software für Code-Reviews ist es oft möglich verschiedene Arten der Freigabe zu definieren.
Dadurch kann dann aktiv nach den Aufgaben gesucht werden, die noch anstehen.

### Feedback

Der Feedback-Status ist eine beliebte Art, Rückfragen an den Product-Owner oder Projektmanager zu richten.
Oft wird der Eintrag dem Projektleiter direkt zugewiesen und verschwindet so von der eigenen Agenda.
Ähnlich, wie bei blockierten Einträgen resultiert dies oft darin, dass der Eintrag noch nicht „Ready“ war.
Letztendlich ist der Status „Feedback“ eine konkretisierung von „Blocked“.
Bei einem physischen Board kann wieder mit einem Post-It mit einem Fragezeichen gearbeitet werden, um anzuzeigen, dass Rückfragen offen sind.

### Ready for Rollout / Deployed to X

Ob die Arbeit eines Eintrages bereits ausgerollt wurde, wird besser mit einem Feld für die Versionen festgehalten.
Taucht der Eintrag im Changelog auf, so weiß man, dass die Änderungen enthalten sind.
Ein extra Status ist hierfür nicht notwendig.

## Verwendung eines physischen Boards

Für den Anfang bietet es sich an, ein physisches Board zu verwenden.
Das funktioniert natürlich nur, wenn alle Team-Mitglieder vor Ort im gleichen Büro arbeiten.
Für Remote-Arbeit empfiehlt es sich, einfache Tools, wie Trello zu verwenden.
Es ist aber auch möglich komplexe Software, wie Jira zu verwenden, wo der Workflow eingestellt werden kann.

## TLDR;

1. Reduziere die Status der Einträge auf
    * Backlog
    * Ready
    * In Progress
    * Done
2. Startet, wenn möglich, mit einem physischen Board
3. Nutzt die Definition of Done und Definition of Ready
4. Nutzt direkte Kommunikation, um Fragen zu beantworten

[1]: https://agilemanifesto.org/iso/de/manifesto.html
[2]: https://www.scrumguides.org/docs/scrumguide/v2017/2017-Scrum-Guide-German.pdf
