#!/bin/env python3
"""
Convert a binary file to a comma separated sequence of bytes

bin_to_u8.py <in_path> <out_path>
"""

import sys
from pathlib import Path

in_path = Path(sys.argv[1])
out_path = Path(sys.argv[2])

in_bytes = memoryview(in_path.read_bytes())

out_path.write_text(
    ",\n".join(
        ", ".join(f"0x{b:02X}" for b in in_bytes[i : i + 16])
        for i in range(0, len(in_bytes), 16)
    )
)
