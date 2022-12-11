#!/bin/env python3
"""
Extract assets from baserom files

extract_assets.py <baserom_files_dir> <xml_path>
xml contents on stdin
"""

VERBOSE = True

from pathlib import Path
import sys
from xml.etree import ElementTree

baserom_files_dir = Path(sys.argv[1])
xml_path = Path(sys.argv[2])

extracted_folder_path = Path("assets/_extracted").joinpath(*xml_path.parent.parts[1:])

print(xml_path, "->", extracted_folder_path)

extracted_folder_path.mkdir(parents=True, exist_ok=True)

xml_tree = ElementTree.parse(sys.stdin)

e_root = xml_tree.getroot()
assert e_root.tag == "Root"

for e_file in e_root:
    assert e_file.tag == "File"
    file_name = e_file.attrib["Name"]
    file_path = baserom_files_dir / file_name
    file_bytes = file_path.read_bytes()

    for e_resource in e_file:
        if e_resource.tag == "Png":
            out_name = e_resource.attrib["OutName"]
            offset_str = e_resource.attrib["Offset"]
            size_str = e_resource.attrib["Size"]
            offset = int(offset_str, 0)
            size = int(size_str, 0)

            out_path = extracted_folder_path / f"{out_name}.png"

            if VERBOSE:
                print(
                    f"Png out_name={out_name!r} offset=0x{offset:X} size=0x{size:X} -> {out_path}"
                )

            png_bytes = file_bytes[offset : offset + size]
            assert len(png_bytes) == size, (
                len(png_bytes),
                len(file_bytes),
                offset,
                size,
            )

            out_path.write_bytes(png_bytes)
        else:
            # Unknown resource tag
            assert False, e_resource.tag
