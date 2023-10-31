# Monaspace

The Monaspace type system: a monospaced type superfamily with some modern tricks up its sleeves. It is comprised of five variable axis typefaces. Each one has a distinct voice, but they are all metrics-compatible with one another, allowing you to mix and match them for a more expressive typographical palette.

Letters on a grid is how we see our code. Why not make those letters better?

✨ An exploration from [GitHub Next](https://githubnext.com). ✨

![image](https://github.com/githubnext/monaspace/assets/22723/963edc2a-626b-4591-aea2-b5d8c4a12ac6)


## Overview

Monaspace is made available as both a variable-axis font and as static builds. You can install them both side-by-side; their family names are distinct. For example:

- `Monaspace _____`: the static family
- `Monaspace _____ VF`: the variable family

The variable fonts have one file per family (Neon, Argon, etc). Modern and convenient!

The static fonts have one file per cut per family. The variable axes have named stops for each of the axes, like `light` or `bold` for weight, `italic` for italics, and `semiwide` and `wide` for width. The combinatoric explosion of all these properties means that the full installation of static fonts involves hundreds of font files. But for situations which don't yet support variable fonts, the static builds give you a wide variety of stops throughout the range of each axis.

## Coding Ligatures

There are eight groups of coding ligatures, separated into stylistic sets. You may be able to selectively enable or disable individual sets:

* `ss01`: ligatures related to the equals glyph like `!=` and `===`.
* `ss02`: ligatures related to the greater than or less than operators.
* `ss03`: ligatures related to arrows like `->` and `=>`.
* `ss04`: ligatures related to markup, like `</` and `/>`. 
* `ss05`: ligatures related to the F♯ programming language, like `|>`.
* `ss06`: ligatures related to repeated uses of `#` such as `##` or `###`.
* `ss07`: ligatures related to the asterisk like `***`.
* `ss08`: ligatures related to combinations like `.=` or `.-`.

You must enable discrectionary ligatures first, often using the `dlig` setting. See below for editor-specific instructions.

![image](https://github.com/githubnext/monaspace/assets/22723/785c03e1-0c9c-421c-ae3c-c107a3c08c33)


## Desktop Installation

### MacOS
You can manually drag the fonts from the `fonts/otf` and `fonts/variable` directory into Font Book.

There is also a script which automates the deletion of all Monaspace fonts from `~/Library/Fonts` and then copies over the latest versions. Invoke it from the root of the repo like:

```bash
$ bash ./util/install_macos.sh
```

### Webfonts

All files with a `.woff` or `.woff2` suffix are intended for use on the web. You do not install them with your operating system, but rather add them to your web development project.

As with the desktop fonts, they are made availabe both as variable and static fonts.

```
TODO: add more instructions about usage of fonts on the web, and include sample CSS for loading fonts in web projects
```

## Editors

### Visual Studio Code

Texture healing and coding ligatures are controlled by the same setting. You can enable either, or both.

If you only want texture healing and basic coding ligatures, add the following line to your `settings.json`:

```
  "editor.fontLigatures": true,
```

> [!NOTE]
> This setting is not available from the graphical settings editor, you must create it manually.

If you want more coding ligatures, you must customize that setting to specify all of the sets you want enabled:

```
  "editor.fontLigatures": "'calt', 'liga', 'dlig', 'ss01', 'ss02', ... (more stylistic sets) ...",
```
> [!NOTE]
> You must start the setting with `'calt', 'liga', 'dlig'`! The stylistic sets will not have any effect without enabling contextual alternates, ligatures, and discretionary ligatures.

If you want coding ligatures but do _not_ want texture healing, you can elide the `calt` setting:

```
  "editor.fontLigatures": "'liga', 'dlig', 'ss01', 'ss02', ... (more stylistic sets) ...",
```

## Utilities

### Renamer utility

This is a convenience utility which renames moves the built fonts into the respective directories. You will need [Deno](https://deno.land) installed, and invoke it thus:

```bash
$ ./util/renamer.ts --src="~/path/to/the/built/fonts"
```
