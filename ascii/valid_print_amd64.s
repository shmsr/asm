// Code generated by command: go run valid_print_asm.go -pkg ascii -out ../ascii/valid_print_amd64.s -stubs ../ascii/valid_print_amd64.go. DO NOT EDIT.

// +build !purego

#include "textflag.h"

// func validPrintString(s string, abi uint64) bool
// Requires: AVX, AVX2, SSE4.1
TEXT ·validPrintString(SB), NOSPLIT, $0-25
	MOVQ abi+16(FP), AX
	MOVQ s_base+0(FP), CX
	MOVQ s_len+8(FP), DX
	CMPQ DX, $0x10
	JB   init_x86
	BTQ  $0x08, AX
	JCS  init_avx

init_x86:
	CMPQ DX, $0x08
	JB   cmp4
	MOVQ $0xdfdfdfdfdfdfdfe0, AX
	MOVQ $0x0101010101010101, BX
	MOVQ $0x8080808080808080, SI

cmp8:
	MOVQ  (CX), DI
	MOVQ  DI, R8
	LEAQ  (DI)(AX*1), R9
	NOTQ  R8
	ANDQ  R8, R9
	LEAQ  (DI)(BX*1), R8
	ORQ   R8, DI
	ORQ   R9, DI
	ADDQ  $0x08, CX
	SUBQ  $0x08, DX
	TESTQ SI, DI
	JNE   done
	CMPQ  DX, $0x08
	JB    cmp4
	JMP   cmp8

cmp4:
	CMPQ  DX, $0x04
	JB    cmp3
	MOVL  (CX), AX
	MOVL  AX, BX
	LEAL  3755991008(AX), SI
	NOTL  BX
	ANDL  BX, SI
	LEAL  16843009(AX), BX
	ORL   BX, AX
	ORL   SI, AX
	ADDQ  $0x04, CX
	SUBQ  $0x04, DX
	TESTL $0x80808080, AX
	JNE   done

cmp3:
	CMPQ    DX, $0x03
	JB      cmp2
	MOVWLZX (CX), AX
	MOVBLZX 2(CX), CX
	SHLL    $0x10, CX
	ORL     AX, CX
	ORL     $0x20000000, CX
	JMP     final

cmp2:
	CMPQ    DX, $0x02
	JB      cmp1
	MOVWLZX (CX), CX
	ORL     $0x20200000, CX
	JMP     final

cmp1:
	CMPQ    DX, $0x00
	JE      done
	MOVBLZX (CX), CX
	ORL     $0x20202000, CX

final:
	MOVL  CX, AX
	LEAL  3755991008(CX), DX
	NOTL  AX
	ANDL  AX, DX
	LEAL  16843009(CX), AX
	ORL   AX, CX
	ORL   DX, CX
	TESTL $0x80808080, CX

done:
	SETEQ ret+24(FP)
	RET

init_avx:
	MOVB         $0x1f, BL
	PINSRB       $0x00, BX, X8
	VPBROADCASTB X8, Y8
	MOVB         $0x7e, BL
	PINSRB       $0x00, BX, X9
	VPBROADCASTB X9, Y9

cmp128:
	CMPQ      DX, $0x80
	JB        cmp64
	VMOVDQU   (CX), Y0
	VMOVDQU   32(CX), Y1
	VMOVDQU   64(CX), Y2
	VMOVDQU   96(CX), Y3
	VPCMPGTB  Y8, Y0, Y4
	VPCMPGTB  Y9, Y0, Y0
	VPANDN    Y4, Y0, Y0
	VPCMPGTB  Y8, Y1, Y5
	VPCMPGTB  Y9, Y1, Y1
	VPANDN    Y5, Y1, Y1
	VPCMPGTB  Y8, Y2, Y6
	VPCMPGTB  Y9, Y2, Y2
	VPANDN    Y6, Y2, Y2
	VPCMPGTB  Y8, Y3, Y7
	VPCMPGTB  Y9, Y3, Y3
	VPANDN    Y7, Y3, Y3
	VPAND     Y1, Y0, Y0
	VPAND     Y3, Y2, Y2
	VPAND     Y2, Y0, Y0
	ADDQ      $0x80, CX
	SUBQ      $0x80, DX
	VPMOVMSKB Y0, AX
	XORL      $0xffffffff, AX
	JNE       done
	JMP       cmp128

cmp64:
	CMPQ      DX, $0x40
	JB        cmp32
	VMOVDQU   (CX), Y0
	VMOVDQU   32(CX), Y1
	VPCMPGTB  Y8, Y0, Y2
	VPCMPGTB  Y9, Y0, Y0
	VPANDN    Y2, Y0, Y0
	VPCMPGTB  Y8, Y1, Y3
	VPCMPGTB  Y9, Y1, Y1
	VPANDN    Y3, Y1, Y1
	VPAND     Y1, Y0, Y0
	ADDQ      $0x40, CX
	SUBQ      $0x40, DX
	VPMOVMSKB Y0, AX
	XORL      $0xffffffff, AX
	JNE       done

cmp32:
	CMPQ      DX, $0x20
	JB        cmp16
	VMOVDQU   (CX), Y0
	VPCMPGTB  Y8, Y0, Y1
	VPCMPGTB  Y9, Y0, Y0
	VPANDN    Y1, Y0, Y0
	ADDQ      $0x20, CX
	SUBQ      $0x20, DX
	VPMOVMSKB Y0, AX
	XORL      $0xffffffff, AX
	JNE       done

cmp16:
	CMPQ      DX, $0x10
	JLE       cmp_tail
	VMOVDQU   (CX), X0
	VPCMPGTB  X8, X0, X1
	VPCMPGTB  X9, X0, X0
	VPANDN    X1, X0, X0
	ADDQ      $0x10, CX
	SUBQ      $0x10, DX
	VPMOVMSKB X0, AX
	XORL      $0x0000ffff, AX
	JNE       done

cmp_tail:
	SUBQ      $0x10, DX
	ADDQ      DX, CX
	VMOVDQU   (CX), X0
	VPCMPGTB  X8, X0, X1
	VPCMPGTB  X9, X0, X0
	VPANDN    X1, X0, X0
	VPMOVMSKB X0, AX
	XORL      $0x0000ffff, AX
	JMP       done
