#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env

import { parse,  } from "https://deno.land/std@0.203.0/path/mod.ts";
import { walk, WalkEntry } from "https://deno.land/std@0.203.0/fs/mod.ts";
import { parse as parseFlags } from "https://deno.land/std@0.202.0/flags/mod.ts";


async function findFonts (src: string): Promise<WalkEntry[]> {
  const fonts: WalkEntry[] = [];
  const fontsIter = walk(src, {maxDepth: 10, includeFiles: true, includeDirs: false, match: [/\.(ttf|otf|woff|woff2)$/]});

  for await (const font of fontsIter) {
    fonts.push(font)
  } 
  return fonts;
}

function getDstPath (font: WalkEntry): string {
  const { name, ext, base } = parse(font.path);
  if (name.match(/Var(VF)?$/) ) {
    // web variable fonts (woff and woff2)
    if (ext.match(/\.woff2?/)) {
      return `${dst}/fonts/webfonts/${name}[wght,wdth,slnt]${ext}`
    }
    // desktop variable fonts (ttf)
    if (ext.match(/\.ttf/)) {
      return `${dst}/fonts/variable/${name}[wght,wdth,slnt]${ext}`
    }
  } else {
    // web static fonts (woff and woff2)
    if (ext.match(/\.woff2?/)) {
      return `${dst}/fonts/webfonts/${base}`
    }
    // desktop static fonts (otf)
    if (ext.match(/\.otf/)) {
      return `${dst}/fonts/otf/${base}`
    }
  }
  throw new Error(`Could not find destination path for ${font.path}`);
}

const flags = parseFlags(Deno.args, {
  boolean: ["verbose"],
  string: ["src", "dst"],
  alias: {
    "src": "s",
    "dst": "d",
  },
  default: {
    verbose: false,
    dst: ".", // Current directory
  },

})

if (!flags.src) {
  console.error("No source directory specified");
  Deno.exit(1);
}

const HOME = Deno.env.get("HOME");
const src = await Deno.realPath(flags.src.replace("~", HOME!));
const dst = await Deno.realPath(flags.dst.replace("~", HOME!));
console.log("Source: ", src);
console.log("Destination: ", dst);

const fonts = await findFonts(src);
for (const f of fonts) {
  const dstPath = getDstPath(f)
  await Deno.mkdir(parse(dstPath).dir, {recursive: true});
  await Deno.copyFile(f.path, dstPath);
  console.log(dstPath)
}
