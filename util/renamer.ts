#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env

import { parse } from "https://deno.land/std@0.203.0/path/mod.ts";
import { walk, WalkEntry } from "https://deno.land/std@0.203.0/fs/mod.ts";
import { parse as parseFlags } from "https://deno.land/std@0.202.0/flags/mod.ts";

const nameRE = /(?<name>argon|neon|xenon|radon|krypton)/i

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
      return `${dst}/fonts/variable/web/${base}`
    }
    // desktop variable fonts (ttf)
    if (ext.match(/\.ttf/)) {
      return `${dst}/fonts/variable/desktop/${base}`
    }
  } else {
    const family = name.match(nameRE)?.groups?.name.toLowerCase();
    if (!family) {
      console.error(`Could not find family name for ${font.path}`);
      Deno.exit(1);
    }
    // web static fonts (woff and woff2)
    if (ext.match(/\.woff2?/)) {
      return `${dst}/fonts/static/web/${family}/${base}`
    }
    // desktop static fonts (otf)
    if (ext.match(/\.otf/)) {
      return `${dst}/fonts/static/desktop/${family}/${base}`
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
  await Deno.copyFile(f.path, dstPath);
  console.log(dstPath)
}
