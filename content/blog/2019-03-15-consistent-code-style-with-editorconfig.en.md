---
title: "Consistent code style with editor configuration"
date: 2019-03-15
slug: "consistent-code-style-with-editor-configuration"
---

There are many code styles. Is indented with tabs or with spaces? How many spaces? –
A uniform [code style](https://en.wikipedia.org/wiki/Programming_style) facilitates the work in the team,
but this is made more difficult by incorrect default settings in the editor.
The [EditorConfig](https://editorconfig.org) offers help when dealing with different code styles.

<!--more-->

The project describes itself as follows:

> “EditorConfig helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs.
> The EditorConfig project consists of a file format for defining coding styles and a collection of text editor plugins that enable editors to read the file format and adhere to defined styles.
> EditorConfig files are easily readable and they work nicely with version control systems.”
> – <cite>[editorconfig.org](https://editorconfig.org)</cite>

EditorConfig is a file called `.editorconfig` that is added to the project.
The following settings can be defined:

* line breaks: `lf` (Unix, Linux, macOS), `crlf` (Windows), `cr` (Windows)
* indentation character: `space` (space) or `tab` (tab)
* size of the indentation: e.g. `4` 
* character set: e.g. `latin1` (ISO-8859-1) or `utf-8` (Unicode).

The settings can be assigned to different file types based on the file name.
So it would be possible to indent PHP files with 4 spaces, whereas HTML files are indented with a single tab.

## Integration into the project

The `.editorconfig` file is always placed in the root directory of the project.
The following source code shows the contents of an example file:

```ini
# Top-most EditorConfig file:
# No further files will be searched for in parent directories.
root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = true

# Indentation with four spaces
[*.php]
indent_style = space
indent_size = 4

# Indentation with tabs
[*.html]
indent_style = tab
```

Multiple files can be used in a project if different standards apply in different directories.
This is especially useful for legacy projects, where the code style is usually changed in individual subdirectories.

## Editor support

The configuration is supported by many IDEs, such as [IntelliJ](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/).
The project's website lists [supported IDEs](https://editorconfig.org/#download).
Some programs come with support by default, others require an additional plugin to be installed.

The code editor automatically recognizes the `.editorconfig` and adjusts the number and type of indentation when using the tab key or when formatting the source code automatically.

## Conclusion

Using EditorConfig makes it easier to get started with a project, as the most important settings for the code style are automatically adopted.
