; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_20 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_20 | %ptxas-verify %}

declare void @llvm.nvvm.pm.event.idx(i32 %idx)
declare void @llvm.nvvm.pm.event.mask(i16 %mask)

; CHECK-LABEL: test_pm_event
define void @test_pm_event() {
  ; CHECK: pmevent 15;
  call void @llvm.nvvm.pm.event.idx(i32 15)

  ; CHECK: pmevent.mask 255;
  call void @llvm.nvvm.pm.event.mask(i16 u0xff)

  ret void
}
