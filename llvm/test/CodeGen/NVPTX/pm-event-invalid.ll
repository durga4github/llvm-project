; RUN: not llc < %s -mtriple=nvptx64 -mcpu=sm_20 -o /dev/null 2>&1 | FileCheck %s

declare void @llvm.nvvm.pm.event.idx(i32 immarg %idx)

define void @test_invalid_pm_event() {
  ; CHECK: immarg value 16 out of range [0, 16)
  call void @llvm.nvvm.pm.event.idx(i32 16)

  ret void
}
