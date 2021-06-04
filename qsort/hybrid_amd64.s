// Code generated by command: go run hybrid_asm.go -pkg qsort -out ../qsort/hybrid_amd64.s -stubs ../qsort/hybrid_amd64.go. DO NOT EDIT.

#include "textflag.h"

// func insertionsort32(data *byte, lo int, hi int)
// Requires: AVX, AVX2
TEXT ·insertionsort32(SB), NOSPLIT, $0-24
	MOVQ     data+0(FP), AX
	MOVQ     lo+8(FP), CX
	MOVQ     hi+16(FP), DX
	SHLQ     $0x05, CX
	SHLQ     $0x05, DX
	LEAQ     (AX)(CX*1), CX
	LEAQ     (AX)(DX*1), AX
	VPCMPEQB Y0, Y0, Y0
	MOVQ     CX, DX

outer:
	ADDQ    $0x20, DX
	CMPQ    DX, AX
	JA      done
	VMOVDQU (DX), Y1
	MOVQ    DX, SI

inner:
	VMOVDQU   -32(SI), Y2
	VPCMPEQB  Y1, Y2, Y3
	VPXOR     Y3, Y0, Y3
	VPMINUB   Y1, Y2, Y4
	VPCMPEQB  Y1, Y4, Y4
	VPAND     Y4, Y3, Y4
	VPMOVMSKB Y3, DI
	VPMOVMSKB Y4, R8
	TESTL     DI, DI
	JZ        outer
	BSFL      DI, BX
	BTSL      BX, R8
	JCC       outer
	VMOVDQU   Y2, (SI)
	VMOVDQU   Y1, -32(SI)
	SUBQ      $0x20, SI
	CMPQ      SI, CX
	JA        inner
	JMP       outer

done:
	VZEROUPPER
	RET

// func distributeForward32(data *byte, scratch *byte, limit int, lo int, hi int, pivot int) int
// Requires: AVX, AVX2, CMOV
TEXT ·distributeForward32(SB), NOSPLIT, $0-56
	MOVQ     data+0(FP), AX
	MOVQ     scratch+8(FP), CX
	MOVQ     limit+16(FP), DX
	MOVQ     lo+24(FP), BX
	MOVQ     hi+32(FP), SI
	MOVQ     pivot+40(FP), DI
	SHLQ     $0x05, DX
	SHLQ     $0x05, BX
	SHLQ     $0x05, SI
	SHLQ     $0x05, DI
	LEAQ     (AX)(BX*1), BX
	LEAQ     (AX)(SI*1), SI
	LEAQ     -32(CX)(DX*1), CX
	VPCMPEQB Y0, Y0, Y0
	VMOVDQU  (AX)(DI*1), Y1
	XORQ     DI, DI
	XORQ     R9, R9
	NEGQ     DX

loop:
	VMOVDQU   (BX), Y2
	VPCMPEQB  Y2, Y1, Y3
	VPXOR     Y3, Y0, Y3
	VPMINUB   Y2, Y1, Y4
	VPCMPEQB  Y2, Y4, Y4
	VPAND     Y4, Y3, Y4
	VPMOVMSKB Y3, R10
	VPMOVMSKB Y4, R11
	TESTL     R10, R10
	SETNE     R12
	BSFL      R10, R8
	BTSL      R8, R11
	SETCS     R9
	ANDB      R12, R9
	XORB      $0x01, R9
	MOVQ      BX, R10
	CMOVQNE   CX, R10
	VMOVDQU   Y2, (R10)(DI*1)
	SHLQ      $0x05, R9
	SUBQ      R9, DI
	ADDQ      $0x20, BX
	CMPQ      BX, SI
	JA        done
	CMPQ      DI, DX
	JNE       loop

done:
	SUBQ AX, BX
	ADDQ DI, BX
	SHRQ $0x05, BX
	DECQ BX
	MOVQ BX, ret+48(FP)
	VZEROUPPER
	RET

// func distributeBackward32(data *byte, scratch *byte, limit int, lo int, hi int, pivot int) int
// Requires: AVX, AVX2, CMOV
TEXT ·distributeBackward32(SB), NOSPLIT, $0-56
	MOVQ     data+0(FP), AX
	MOVQ     scratch+8(FP), CX
	MOVQ     limit+16(FP), DX
	MOVQ     lo+24(FP), BX
	MOVQ     hi+32(FP), SI
	MOVQ     pivot+40(FP), DI
	SHLQ     $0x05, DX
	SHLQ     $0x05, BX
	SHLQ     $0x05, SI
	SHLQ     $0x05, DI
	LEAQ     (AX)(BX*1), BX
	LEAQ     (AX)(SI*1), SI
	VPCMPEQB Y0, Y0, Y0
	VMOVDQU  (AX)(DI*1), Y1
	XORQ     DI, DI
	XORQ     R9, R9
	CMPQ     SI, BX
	JBE      done

loop:
	VMOVDQU   (SI), Y2
	VPCMPEQB  Y2, Y1, Y3
	VPXOR     Y3, Y0, Y3
	VPMINUB   Y2, Y1, Y4
	VPCMPEQB  Y2, Y4, Y4
	VPAND     Y4, Y3, Y4
	VPMOVMSKB Y3, R10
	VPMOVMSKB Y4, R11
	TESTL     R10, R10
	SETNE     R12
	BSFL      R10, R8
	BTSL      R8, R11
	SETCS     R9
	ANDB      R12, R9
	MOVQ      CX, R10
	CMOVQEQ   SI, R10
	VMOVDQU   Y2, (R10)(DI*1)
	SHLQ      $0x05, R9
	ADDQ      R9, DI
	SUBQ      $0x20, SI
	CMPQ      SI, BX
	JBE       done
	CMPQ      DI, DX
	JNE       loop

done:
	SUBQ AX, SI
	ADDQ DI, SI
	SHRQ $0x05, SI
	MOVQ SI, ret+48(FP)
	VZEROUPPER
	RET

// func insertionsort16(data *byte, lo int, hi int)
// Requires: AVX
TEXT ·insertionsort16(SB), NOSPLIT, $0-24
	MOVQ     data+0(FP), AX
	MOVQ     lo+8(FP), CX
	MOVQ     hi+16(FP), DX
	SHLQ     $0x04, CX
	SHLQ     $0x04, DX
	LEAQ     (AX)(CX*1), CX
	LEAQ     (AX)(DX*1), AX
	VPCMPEQB X0, X0, X0
	MOVQ     CX, DX

outer:
	ADDQ    $0x10, DX
	CMPQ    DX, AX
	JA      done
	VMOVDQU (DX), X1
	MOVQ    DX, SI

inner:
	VMOVDQU   -16(SI), X2
	VPCMPEQB  X1, X2, X3
	VPXOR     X3, X0, X3
	VPMINUB   X1, X2, X4
	VPCMPEQB  X1, X4, X4
	VPAND     X4, X3, X4
	VPMOVMSKB X3, DI
	VPMOVMSKB X4, R8
	TESTL     DI, DI
	JZ        outer
	BSFL      DI, BX
	BTSL      BX, R8
	JCC       outer
	VMOVDQU   X2, (SI)
	VMOVDQU   X1, -16(SI)
	SUBQ      $0x10, SI
	CMPQ      SI, CX
	JA        inner
	JMP       outer

done:
	RET

// func distributeForward16(data *byte, scratch *byte, limit int, lo int, hi int, pivot int) int
// Requires: AVX, CMOV
TEXT ·distributeForward16(SB), NOSPLIT, $0-56
	MOVQ     data+0(FP), AX
	MOVQ     scratch+8(FP), CX
	MOVQ     limit+16(FP), DX
	MOVQ     lo+24(FP), BX
	MOVQ     hi+32(FP), SI
	MOVQ     pivot+40(FP), DI
	SHLQ     $0x04, DX
	SHLQ     $0x04, BX
	SHLQ     $0x04, SI
	SHLQ     $0x04, DI
	LEAQ     (AX)(BX*1), BX
	LEAQ     (AX)(SI*1), SI
	LEAQ     -16(CX)(DX*1), CX
	VPCMPEQB X0, X0, X0
	VMOVDQU  (AX)(DI*1), X1
	XORQ     DI, DI
	XORQ     R9, R9
	NEGQ     DX

loop:
	VMOVDQU   (BX), X2
	VPCMPEQB  X2, X1, X3
	VPXOR     X3, X0, X3
	VPMINUB   X2, X1, X4
	VPCMPEQB  X2, X4, X4
	VPAND     X4, X3, X4
	VPMOVMSKB X3, R10
	VPMOVMSKB X4, R11
	TESTL     R10, R10
	SETNE     R12
	BSFL      R10, R8
	BTSL      R8, R11
	SETCS     R9
	ANDB      R12, R9
	XORB      $0x01, R9
	MOVQ      BX, R10
	CMOVQNE   CX, R10
	VMOVDQU   X2, (R10)(DI*1)
	SHLQ      $0x04, R9
	SUBQ      R9, DI
	ADDQ      $0x10, BX
	CMPQ      BX, SI
	JA        done
	CMPQ      DI, DX
	JNE       loop

done:
	SUBQ AX, BX
	ADDQ DI, BX
	SHRQ $0x04, BX
	DECQ BX
	MOVQ BX, ret+48(FP)
	RET

// func distributeBackward16(data *byte, scratch *byte, limit int, lo int, hi int, pivot int) int
// Requires: AVX, CMOV
TEXT ·distributeBackward16(SB), NOSPLIT, $0-56
	MOVQ     data+0(FP), AX
	MOVQ     scratch+8(FP), CX
	MOVQ     limit+16(FP), DX
	MOVQ     lo+24(FP), BX
	MOVQ     hi+32(FP), SI
	MOVQ     pivot+40(FP), DI
	SHLQ     $0x04, DX
	SHLQ     $0x04, BX
	SHLQ     $0x04, SI
	SHLQ     $0x04, DI
	LEAQ     (AX)(BX*1), BX
	LEAQ     (AX)(SI*1), SI
	VPCMPEQB X0, X0, X0
	VMOVDQU  (AX)(DI*1), X1
	XORQ     DI, DI
	XORQ     R9, R9
	CMPQ     SI, BX
	JBE      done

loop:
	VMOVDQU   (SI), X2
	VPCMPEQB  X2, X1, X3
	VPXOR     X3, X0, X3
	VPMINUB   X2, X1, X4
	VPCMPEQB  X2, X4, X4
	VPAND     X4, X3, X4
	VPMOVMSKB X3, R10
	VPMOVMSKB X4, R11
	TESTL     R10, R10
	SETNE     R12
	BSFL      R10, R8
	BTSL      R8, R11
	SETCS     R9
	ANDB      R12, R9
	MOVQ      CX, R10
	CMOVQEQ   SI, R10
	VMOVDQU   X2, (R10)(DI*1)
	SHLQ      $0x04, R9
	ADDQ      R9, DI
	SUBQ      $0x10, SI
	CMPQ      SI, BX
	JBE       done
	CMPQ      DI, DX
	JNE       loop

done:
	SUBQ AX, SI
	ADDQ DI, SI
	SHRQ $0x04, SI
	MOVQ SI, ret+48(FP)
	RET
