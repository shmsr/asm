// Code generated by command: go run swap64_asm.go -pkg bswap -out ../bswap/swap64_amd64.s -stubs ../bswap/swap64_amd64.go. DO NOT EDIT.

// +build !purego

#include "textflag.h"

// func swap64(b []byte)
// Requires: AVX, AVX2
TEXT ·swap64(SB), NOSPLIT, $0-24
	MOVQ    b_base+0(FP), AX
	MOVQ    b_len+8(FP), CX
	MOVQ    AX, DX
	ADDQ    CX, DX
	BTQ     $0x08, github·com∕segmentio∕asm∕cpu·X86+0(SB)
	JCC     x86_loop
	VMOVDQU shuffle_mask<>+0(SB), Y0

avx2_loop:
	MOVQ    AX, CX
	ADDQ    $0x80, CX
	CMPQ    CX, DX
	JAE     x86_loop
	VMOVDQU (AX), Y1
	VMOVDQU 32(AX), Y2
	VMOVDQU 64(AX), Y3
	VMOVDQU 96(AX), Y4
	VPSHUFB Y0, Y1, Y1
	VPSHUFB Y0, Y2, Y2
	VPSHUFB Y0, Y3, Y3
	VPSHUFB Y0, Y4, Y4
	VMOVDQU Y1, (AX)
	VMOVDQU Y2, 32(AX)
	VMOVDQU Y3, 64(AX)
	VMOVDQU Y4, 96(AX)
	MOVQ    CX, AX
	JMP     avx2_loop

x86_loop:
	MOVQ   AX, CX
	ADDQ   $0x20, CX
	CMPQ   CX, DX
	JAE    slow_loop
	MOVQ   (AX), BX
	MOVQ   8(AX), SI
	MOVQ   16(AX), DI
	MOVQ   24(AX), R8
	BSWAPQ BX
	BSWAPQ SI
	BSWAPQ DI
	BSWAPQ R8
	MOVQ   BX, (AX)
	MOVQ   SI, 8(AX)
	MOVQ   DI, 16(AX)
	MOVQ   R8, 24(AX)
	MOVQ   CX, AX
	JMP    x86_loop

slow_loop:
	CMPQ   AX, DX
	JAE    done
	MOVQ   (AX), CX
	BSWAPQ CX
	MOVQ   CX, (AX)
	ADDQ   $0x08, AX
	JMP    slow_loop

done:
	RET

DATA shuffle_mask<>+0(SB)/8, $0x0001020304050607
DATA shuffle_mask<>+8(SB)/8, $0x08090a0b0c0d0e0f
DATA shuffle_mask<>+16(SB)/8, $0x0001020304050607
DATA shuffle_mask<>+24(SB)/8, $0x08090a0b0c0d0e0f
GLOBL shuffle_mask<>(SB), RODATA|NOPTR, $32
