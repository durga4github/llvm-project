; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=riscv64-unknown-linux-gnu < %s | FileCheck %s
; RUN: llc -mtriple=riscv32-unknown-linux-gnu < %s | FileCheck %s

; Dag-combine used to improperly combine a vector vselect of 0 and 2 into
; 2 + condition(0/1) because one of the two args was transformed from an i32->i64.

define i16 @foo() {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    ret
entry:
  %insert.0 = insertelement <4 x i16> zeroinitializer, i16 2, i64 0
  %all.two = shufflevector <4 x i16> %insert.0, <4 x i16> zeroinitializer, <4 x i32> zeroinitializer
  %sel.0 = select <4 x i1> <i1 true, i1 false, i1 false, i1 false>, <4 x i16> zeroinitializer, <4 x i16> %all.two
  %mul.0 = call i16 @llvm.vector.reduce.mul.v4i16(<4 x i16> %sel.0)
  ret i16 %mul.0
}

declare i16 @llvm.vector.reduce.mul.v4i32(<4 x i16>)
