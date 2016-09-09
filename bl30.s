.section .bl30, "ax"
.incbin "bl30.bin"
.global _bl30_start
.set _bl30_start, 0x10000169
