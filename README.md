This repository features a build system demonstrating one way multi-version handling for decomps may be done, both in code and in assets.

The target "rom" here is entirely made up, and has its original source in `real_baserom`.

The target rom exists in two versions "0" and "1".

The repo structure more or less follows the one of the oot decomp, to keep it somewhat familiar.

## Building

1) Build the two baserom versions from its source in `real_baserom`:

`./build_real_baseroms.sh`

2) Pick a version, 0 or 1. Run the "setup":

`make setup VERSION=0`

3) Build:

`make VERSION=0`

4) Observe:

```
diff rom.bin baseroms/baserom_v0.bin -s
Files rom.bin and baseroms/baserom_v0.bin are identical
```

(it may not match on your machine, due to how the real_baserom is built, idk)

5) Build the other version:

`export VERSION=1 && make versionclean && make setup && make`

## Build system notes

The (main) files fed to the compiler are *all* committed, including assets files.

However files like `assets/art/art.c` use `#include` to include content that is extracted from the rom, and not committed (typically for copyright reasons).

This content is extracted from the rom as described by xml files such as `assets/art/art.xml`. The user friendly / useful data is exposed under `assets/_extracted/` (which is not commited).

It is very easy to create custom assets, using extracted data or not. Just create a folder in assets/, put and commit your own stuff in it, possibly reference extracted data such as images.

For versioning, all files are preprocessed (with cpp) with the `VERSION` macro expanding to the version 0 or 1. Including .c, .h and .xml files. The versioning in .xml files may be done differently, for example handled in the tools/extract_assets.py script.

This build system also handles dependencies properly (I think).
