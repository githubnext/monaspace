# Monaspace

The Monaspace type system: a monospaced type superfamily with some modern tricks up its sleeves. It is comprised of five variable axis typefaces. Each one has a distinct voice, but they are all metrics-compatible with one another, allowing you to mix and match them for a more expressive typographical palette.

Letters on a grid is how we see our code. Why not make those letters better?

✨ An exploration from [GitHub Next](https://githubnext.com). ✨

![Title cards for faces in the Monaspace Superfamily](https://github.com/githubnext/monaspace/assets/22723/29070472-5a92-470d-b63e-e3bf8f9f8598)

## Overview

Monaspace is made available as both a variable-axis font and as static builds. You can install them both side-by-side; their family names are distinct. For example:

- `Monaspace _____`: the static family
- `Monaspace _____ VF`: the variable family

The variable fonts have one file per family (Neon, Argon, etc). Modern and convenient!

The static fonts have one file per cut per family. The variable axes have named stops for each of the axes, like `light` or `bold` for weight, `italic` for italics, and `semiwide` and `wide` for width. The combinatoric explosion of all these properties means that the full installation of static fonts involves hundreds of font files. But for situations which don't yet support variable fonts, the static builds give you a wide variety of stops throughout the range of each axis.

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

## Utilities

### Renamer utility

This is a convenience utility which renames moves the built fonts into the respective directories. You will need [Deno](https://deno.land) installed, and invoke it thus:

```bash
$ ./util/renamer.ts --src="~/path/to/the/built/fonts"
```