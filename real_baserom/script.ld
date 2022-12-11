SECTIONS
{
  _codeSegment : ALIGN(0x100) {
    _codeSegmentRomStart = .;
    build/code.o(.text)
  }
  _codeSegmentRomEnd = .;

  _math_constsSegment : ALIGN(0x100) {
    _math_constsSegmentRomStart = .;
    build/math_consts.o(.data)
  }
  _math_constsSegmentRomEnd = .;

  _artSegment : ALIGN(0x100) {
    _artSegmentRomStart = .;
    build/art/art.o(.data)
  }
  _artSegmentRomEnd = .;

  /DISCARD/ : { *(*) }
}
