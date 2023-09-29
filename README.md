# Monaspace

The Monaspace type system: a monospaced type superfamily with some modern tricks up its sleeves. It is comprised of five variable axis typefaces. Each one has a distinct voice, but they are all metrics-compatible with one another, allowing you to mix and match them for a more expressive typographical palette.

Letters on a grid is how we see our code. Why not make those letters better?

✨ An exploration from [GitHub Next](https://githubnext.com). ✨

![Title cards for faces in the Monaspace Superfamily](https://github.com/githubnext/monaspace/assets/22723/29070472-5a92-470d-b63e-e3bf8f9f8598)

## Renamer utility

This is a convenience utility which renames moves the built fonts into the respective directories. You will need [Deno](https://deno.land) installed, and invoke it thus:

```bash
$ ./util/renamer.ts --src="~/path/to/the/built/fonts"
```