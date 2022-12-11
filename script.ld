SECTIONS
{
  _codeSegment : ALIGN(0x100) {
    _codeSegmentRomStart = .;
    build/src/code.o(.text)
  }
  _codeSegmentRomEnd = .;

  _math_constsSegment : ALIGN(0x100) {
    _math_constsSegmentRomStart = .;
    build/assets/math_consts/math_consts.o(.data)
  }
  _math_constsSegmentRomEnd = .;

  _artSegment : ALIGN(0x100) {
    _artSegmentRomStart = .;
    build/assets/art/art.o(.data)
  }
  _artSegmentRomEnd = .;

  /DISCARD/ : { *(*) }
}
