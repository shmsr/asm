// Code generated by command: go run valid_print_asm.go -pkg ascii -out ../ascii/valid_print_amd64.s -stubs ../ascii/valid_print_amd64.go. DO NOT EDIT.

//go:build !purego
// +build !purego

package ascii

// validPrintString returns true if s contains only printable ASCII characters.
func validPrintString(s string, abi uint64) bool
