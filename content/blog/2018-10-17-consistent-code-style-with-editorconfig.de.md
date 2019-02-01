---
title: "Konsequenter Code-Style mit Editor-Konfiguration"
date: 2019-02-02
slug: "editorconfig"
---

Ein einheitlicher [Code-Style](https://de.wikipedia.org/wiki/Programmierstil) erleichtert die Arbeit im Team.
Die [EditorConfig](https://editorconfig.org) erleichtert das arbeiten mit unterschiedlichen Code-Styles.

Das Projekt beschreibt sich selbst wie folgt:

> EditorConfig hilft Entwicklern bei der Definition und Pflege konsistenter Programmierstile zwischen verschiedenen Editoren und IDEs.
> Das EditorConfig-Projekt besteht aus einem Dateiformat zur Definition von Codierstilen und einer Sammlung von Texteditor-Plugins, die es den Editoren ermöglichen, das Dateiformat zu lesen und sich an definierte Stile zu halten.
> EditorConfig-Dateien sind leicht lesbar und funktionieren gut im zusammenspiel mit Versionskontrollsystemen.
> ([editorconfig.org](https://editorconfig.org))

Bei der EditorConfig handelt es sich um eine Datei mit dem Namen `.editorconfig`, die dem Projekt hinzugefügt wird.
Definiert werden können unter anderem

* die Zeilenumbrüche: `lf` (Unix, Linux, macOS), `crlf` (Windows), `cr`
* das Zeichen für die Einrückung: `space` (Leerzeichen) oder `tab` (Tab)
* die Größe der Einrückung: z. B. `4` 
* der Zeichensatz: z. B. `latin1` (ISO-8859-1), `utf-8` (Unicode).

Die Einstellungen lassen sich verschiedenen Dateitypen, basierend auf dem Dateinamen, zuweisen.
So wäre es möglich PHP-Dateien mit 4 Spaces einzurücken, wohingegen HTML-Dateien mit nur einem Tab eingerückt werden.

## Einbindung ins Projekt

Die `.editorconfig` Datei wird immer in das Root-Verzeichnis des Projekts platziert.
Der folgende Quelltext zeigt den Inhalt einer Beispiel-Datei.

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
Dies ist vor allem bei Legacy-Projekten hilfreich, wenn dort der Code-Style geändert wurde, aber noch nicht alle Dateien angepasst wurden.

## Quelltexteditor-Unterstützung

Untersützt wird die Konfiguration von vielen IDEs, wie z. B. [IntelliJ](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/) oder [Atom](https://atom.io/).
Die Website des Projekts listet [unterstützte IDEs](https://editorconfig.org/#download).
Einige Programme liefern die Unterstüzung von Hause aus, bei anderen muss ein zusätzliches Plugin installiert werden.

Der Code-Editor erkennt die `.editorconfig` automatisch und passt die Anzahl und Art der Einrückung an, wenn man  die Tab-Taste verwendet oder wenn man den Quelltext automatisch formatiert.
