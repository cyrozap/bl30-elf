ENTRY(EntryPoint)

PHDRS
{
  text   PT_LOAD AT (0x10000000) FLAGS (0x7) ;
  rodata PT_LOAD AT (0x10005aac) FLAGS (0x4) ;
  data   PT_LOAD AT (0x10008000) FLAGS (0x6) ;
}

SECTIONS
{
  .text   0x10000000 : { *(.bl30) } :text
  .rodata 0x10005aac : { *(.rodata) } :rodata
  .data   0x10008000 : { *(.sram) } :data
  .note.gnu.build-id 0x0 (NOLOAD) : { *(.note.gnu.build-id) } :NONE
}
