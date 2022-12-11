#!/bin/env python3
"""
Extract files from the baserom

extract_baserom.py <baserom_bin> <baserom_files_dir> <version>
"""

import sys
from pathlib import Path

baserom_bin = Path(sys.argv[1])
baserom_files_dir = Path(sys.argv[2])
version = int(sys.argv[3])

baserom_bytes = memoryview(baserom_bin.read_bytes())

# These names and offsets come from researching the baserom binary
if version == 0:
    files = (
        ("code.bin", 0x0, 0xF),
        ("math_consts.bin", 0x100, 0x140),
        ("art.bin", 0x200, 0x5DC8),
    )
elif version == 1:
    files = (
        ("code.bin", 0x0, 0xF),
        ("math_consts.bin", 0x100, 0x160),
        ("art.bin", 0x200, 0x5DC8),
    )
else:
    assert False, version

for name, start, end in files:
    (baserom_files_dir / name).write_bytes(baserom_bytes[start:end])
