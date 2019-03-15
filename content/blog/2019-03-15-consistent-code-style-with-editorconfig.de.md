---
title: "Konsequenter Code-Style mit Editor-Konfiguration"
date: 2019-03-15
slug: "konsequenter-code-style-mit-editor-konfiguration"
---

Code-Styles gibt es viele. Wird mit Tabs eingerückt oder mit Leerzeichen? Wie viele Leerzeichen? –
Ein einheitlicher [Code-Style](https://de.wikipedia.org/wiki/Programmierstil) erleichtert die Arbeit im Team,
jedoch wird dies durch falsche Voreinstellungen im Editor erschwert.
Die [EditorConfig](https://editorconfig.org) bietet Abhilfe bei der arbeit mit unterschiedlichen Code-Styles.

<!--more-->

Das Projekt beschreibt sich selbst wie folgt:

> »EditorConfig hilft Entwicklern bei der Definition und Pflege konsistenter Programmierstile zwischen verschiedenen Editoren und IDEs.
> Das EditorConfig-Projekt besteht aus einem Dateiformat zur Definition von Codierstilen und einer Sammlung von Texteditor-Plugins, die es den Editoren ermöglichen, das Dateiformat zu lesen und sich an definierte Stile zu halten.
> EditorConfig-Dateien sind leicht lesbar und funktionieren gut im zusammenspiel mit Versionskontrollsystemen.«
> – <cite>[editorconfig.org](https://editorconfig.org)</cite>

Bei der EditorConfig handelt es sich um eine Datei mit dem Namen `.editorconfig`, die dem Projekt hinzugefügt wird.
Definiert werden können unter anderem

* die Zeilenumbrüche: `lf` (Unix, Linux, macOS), `crlf` (Windows), `cr`
* das Zeichen für die Einrückung: `space` (Leerzeichen) oder `tab` (Tab)
* die Größe der Einrückung: z. B. `4` 
* der Zeichensatz: z. B. `latin1` (ISO-8859-1) oder `utf-8` (Unicode).

Die Einstellungen lassen sich verschiedenen Dateitypen, basierend auf dem Dateinamen, zuweisen.
So wäre es möglich PHP-Dateien mit 4 Spaces einzurücken, wohingegen HTML-Dateien mit nur einem Tab eingerückt werden.

## Einbindung ins Projekt

Die `.editorconfig` Datei wird immer in das Root-Verzeichnis des Projekts platziert.
Der folgende Quelltext zeigt den Inhalt einer Beispiel-Datei:

```ini
# Äußerste EditorConfig-Datei.
# Es wird nicht nach weiteren Dateien in überliegenden Verzeichnissen gesucht.
root = true

# Zeilenumbrüche im Unix-Stil mit einem Zeilenumbruch am Ende jeder Datei
[*]
end_of_line = lf
insert_final_newline = true

# Einrückung mit vier Leerzeichen
[*.php]
indent_style = space
indent_size = 4

# Einrückung mit Tab
[*.html]
indent_style = tab
```

Es können in einem Projekt auch mehrere Dateien verwendet werden, falls in verschiedenen Verzeichnissen andere Standards gelten.
Dies ist vor allem bei Legacy-Projekten hilfreich, denn dort wird der Code-Style in der Regel in einzelnen Unterverzeichnissen geändert.

## Quelltext-Editor-Unterstützung

Untersützt wird die Konfiguration von vielen IDEs, wie z. B. [IntelliJ](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/) oder [Atom](https://atom.io/).
Die Website des Projekts listet [unterstützte IDEs](https://editorconfig.org/#download).
Einige Programme liefern die Unterstüzung von Hause aus mit, bei anderen muss ein zusätzliches Plugin installiert werden.

Der Code-Editor erkennt die `.editorconfig` automatisch und passt die Anzahl und Art der Einrückung an, wenn man  die Tab-Taste verwendet oder wenn man den Quelltext automatisch formatiert.

## Fazit

Die Verwendung der EditorConfig erleichtert den Einstieg in ein Projekt, da die wichtigsten Einstellungen für den Code-Style automatisch übernommen werden.
