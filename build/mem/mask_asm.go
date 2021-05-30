// +build ignore

package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/segmentio/asm/build/internal/x86"
)

func main() {
	gen := Copy{
		CopyB:   ANDB,
		CopyW:   ANDW,
		CopyL:   ANDL,
		CopyQ:   ANDQ,
		CopySSE: PAND,
		CopyAVX: VPAND,
	}

	gen.Generate("Mask", "set bits of dst to zero and copies the one-bits of src to dst, returning the number of bytes written.")
}
