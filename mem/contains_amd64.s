// Code generated by command: go run contains_asm.go -pkg mem -out ../mem/contains_amd64.s -stubs ../mem/contains_amd64.go. DO NOT EDIT.

// +build !purego

#include "textflag.h"

// func ContainsByte(haystack []byte, needle byte) bool
// Requires: AVX, AVX2, SSE2, SSE4.1
TEXT ·ContainsByte(SB), NOSPLIT, $0-33
	MOVQ haystack_base+0(FP), AX
	MOVQ haystack_len+8(FP), CX
	XORQ DX, DX
	MOVB needle+24(FP), DL
	MOVQ DX, BX
	SHLQ $0x08, BX
	ORQ  BX, DX
	MOVQ DX, BX
	SHLQ $0x10, BX
	ORQ  BX, DX
	MOVQ DX, BX
	SHLQ $0x20, BX
	ORQ  BX, DX
	MOVQ $0x0101010101010101, BX
	MOVQ $0x8080808080808080, SI
	MOVB $0x00, ret+32(FP)
	JMP  start

found:
	MOVB $0x01, ret+32(FP)
	JMP  done

avx2_found:
	MOVB $0x01, ret+32(FP)
	JMP  avx2_done

start:
	CMPQ   CX, $0x10
	JBE    tail
	PXOR   X1, X1
	PINSRQ $0x00, DX, X0
	PINSRQ $0x01, DX, X0

tail:
	CMPQ         CX, $0x00
	JE           done
	CMPQ         CX, $0x01
	JE           handle1
	CMPQ         CX, $0x03
	JBE          handle2to3
	CMPQ         CX, $0x04
	JE           handle4
	CMPQ         CX, $0x08
	JB           handle5to7
	JE           handle8
	CMPQ         CX, $0x10
	JBE          handle9to16
	CMPQ         CX, $0x20
	JBE          handle17to32
	CMPQ         CX, $0x40
	JBE          handle33to64
	BTQ          $0x08, github·com∕segmentio∕asm∕cpu·X86+0(SB)
	JCC          generic
	VZEROUPPER
	VPBROADCASTQ X0, Y0
	CMPQ         CX, $0x00000100
	JB           avx2_tail
	JMP          avx2

generic:
	MOVOU   (AX), X2
	MOVOU   16(AX), X3
	MOVOU   32(AX), X4
	MOVOU   48(AX), X5
	PCMPEQB X0, X2
	PCMPEQB X0, X3
	PCMPEQB X0, X4
	PCMPEQB X0, X5
	POR     X2, X3
	POR     X4, X5
	POR     X3, X5
	PTEST   X5, X1
	JCC     found
	ADDQ    $0x40, AX
	SUBQ    $0x40, CX
	CMPQ    CX, $0x40
	JBE     tail
	JMP     generic

done:
	RET

handle1:
	MOVB (AX), AL
	CMPB AL, DL
	JE   found
	RET

handle2to3:
	MOVW (AX), DI
	MOVW -2(AX)(CX*1), AX
	XORW DX, DI
	MOVW DI, CX
	XORW DX, AX
	MOVW AX, DX
	SUBW BX, CX
	NOTW DI
	ANDW DI, CX
	SUBW BX, DX
	NOTW AX
	ANDW AX, DX
	ORW  CX, DX
	ANDW SI, DX
	JNZ  found
	RET

handle4:
	MOVL (AX), AX
	XORL DX, AX
	MOVL AX, CX
	SUBL BX, CX
	NOTL AX
	ANDL AX, CX
	ANDL SI, CX
	JNZ  found
	RET

handle5to7:
	MOVL (AX), DI
	MOVL -4(AX)(CX*1), AX
	XORL DX, DI
	MOVL DI, CX
	XORL DX, AX
	MOVL AX, DX
	SUBL BX, CX
	NOTL DI
	ANDL DI, CX
	SUBL BX, DX
	NOTL AX
	ANDL AX, DX
	ORL  CX, DX
	ANDL SI, DX
	JNZ  found
	RET

handle8:
	MOVQ (AX), AX
	XORQ DX, AX
	MOVQ AX, CX
	SUBQ BX, CX
	NOTQ AX
	ANDQ AX, CX
	ANDQ SI, CX
	JNZ  found
	RET

handle9to16:
	MOVQ (AX), DI
	MOVQ -8(AX)(CX*1), AX
	XORQ DX, DI
	MOVQ DI, CX
	XORQ DX, AX
	MOVQ AX, DX
	SUBQ BX, CX
	NOTQ DI
	ANDQ DI, CX
	SUBQ BX, DX
	NOTQ AX
	ANDQ AX, DX
	ORQ  CX, DX
	ANDQ SI, DX
	JNZ  found
	RET

handle17to32:
	MOVOU   (AX), X2
	MOVOU   -16(AX)(CX*1), X3
	PCMPEQB X0, X2
	PCMPEQB X0, X3
	POR     X2, X3
	PTEST   X3, X1
	JCC     found
	RET

handle33to64:
	MOVOU   (AX), X2
	MOVOU   16(AX), X3
	MOVOU   -32(AX)(CX*1), X4
	MOVOU   -16(AX)(CX*1), X5
	PCMPEQB X0, X2
	PCMPEQB X0, X3
	PCMPEQB X0, X4
	PCMPEQB X0, X5
	POR     X2, X3
	POR     X4, X5
	POR     X3, X5
	PTEST   X5, X1
	JCC     found
	RET

	// AVX optimized version for medium to large size inputs.
avx2:
	VPCMPEQB (AX), Y0, Y2
	VPCMPEQB 32(AX), Y0, Y3
	VPCMPEQB 64(AX), Y0, Y4
	VPCMPEQB 96(AX), Y0, Y5
	VPCMPEQB 128(AX), Y0, Y6
	VPCMPEQB 160(AX), Y0, Y7
	VPCMPEQB 192(AX), Y0, Y8
	VPCMPEQB 224(AX), Y0, Y9
	VPOR     Y2, Y3, Y3
	VPOR     Y4, Y5, Y5
	VPOR     Y6, Y7, Y7
	VPOR     Y8, Y9, Y9
	VPOR     Y3, Y5, Y5
	VPOR     Y7, Y9, Y9
	VPOR     Y5, Y9, Y9
	VPTEST   Y9, Y1
	JCC      avx2_found
	ADDQ     $0x00000100, AX
	SUBQ     $0x00000100, CX
	JZ       avx2_done
	CMPQ     CX, $0x00000100
	JAE      avx2

avx2_tail:
	CMPQ     CX, $0x40
	JBE      avx2_tail_1to64
	CMPQ     CX, $0x80
	JBE      avx2_tail_65to128
	VPCMPEQB (AX), Y0, Y2
	VPCMPEQB 32(AX), Y0, Y3
	VPCMPEQB 64(AX), Y0, Y4
	VPCMPEQB 96(AX), Y0, Y5
	VPCMPEQB -128(AX)(CX*1), Y0, Y6
	VPCMPEQB -96(AX)(CX*1), Y0, Y7
	VPCMPEQB -64(AX)(CX*1), Y0, Y8
	VPCMPEQB -32(AX)(CX*1), Y0, Y0
	VPOR     Y2, Y3, Y3
	VPOR     Y4, Y5, Y5
	VPOR     Y6, Y7, Y7
	VPOR     Y8, Y0, Y0
	VPOR     Y3, Y5, Y5
	VPOR     Y7, Y0, Y0
	VPOR     Y5, Y0, Y0
	VPTEST   Y0, Y1
	JCC      avx2_found
	JMP      avx2_done

avx2_tail_65to128:
	VPCMPEQB (AX), Y0, Y2
	VPCMPEQB 32(AX), Y0, Y3
	VPCMPEQB -64(AX)(CX*1), Y0, Y4
	VPCMPEQB -32(AX)(CX*1), Y0, Y0
	VPOR     Y2, Y3, Y3
	VPOR     Y4, Y0, Y0
	VPOR     Y3, Y0, Y0
	VPTEST   Y0, Y1
	JCC      avx2_found
	JMP      avx2_done

avx2_tail_1to64:
	VPCMPEQB -64(AX)(CX*1), Y0, Y2
	VPCMPEQB -32(AX)(CX*1), Y0, Y0
	VPOR     Y2, Y0, Y0
	VPTEST   Y0, Y1
	JCC      avx2_found

avx2_done:
	VZEROUPPER
	RET
