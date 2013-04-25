# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ffi}
  s.version = "1.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wayne Meissner"]
  s.date = %q{2013-04-23}
  s.description = %q{Ruby FFI library}
  s.email = %q{wmeissner@gmail.com}
  s.extensions = ["ext/ffi_c/extconf.rb"]
  s.files = ["ffi.gemspec", "History.txt", "LICENSE", "COPYING", "COPYING.LESSER", "README.md", "Rakefile", "ext/ffi_c/AbstractMemory.c", "ext/ffi_c/AbstractMemory.h", "ext/ffi_c/ArrayType.c", "ext/ffi_c/ArrayType.h", "ext/ffi_c/Buffer.c", "ext/ffi_c/Call.c", "ext/ffi_c/Call.h", "ext/ffi_c/ClosurePool.c", "ext/ffi_c/ClosurePool.h", "ext/ffi_c/compat.h", "ext/ffi_c/cruby-ext.iml", "ext/ffi_c/DataConverter.c", "ext/ffi_c/DynamicLibrary.c", "ext/ffi_c/DynamicLibrary.h", "ext/ffi_c/extconf.rb", "ext/ffi_c/ffi.c", "ext/ffi_c/Function.c", "ext/ffi_c/Function.h", "ext/ffi_c/FunctionInfo.c", "ext/ffi_c/LastError.c", "ext/ffi_c/LastError.h", "ext/ffi_c/libffi/acinclude.m4", "ext/ffi_c/libffi/aclocal.m4", "ext/ffi_c/libffi/build-ios.sh", "ext/ffi_c/libffi/ChangeLog", "ext/ffi_c/libffi/ChangeLog.libffi", "ext/ffi_c/libffi/ChangeLog.libgcj", "ext/ffi_c/libffi/ChangeLog.v1", "ext/ffi_c/libffi/compile", "ext/ffi_c/libffi/config.guess", "ext/ffi_c/libffi/config.sub", "ext/ffi_c/libffi/configure", "ext/ffi_c/libffi/configure.ac", "ext/ffi_c/libffi/configure.host", "ext/ffi_c/libffi/depcomp", "ext/ffi_c/libffi/doc/libffi.info", "ext/ffi_c/libffi/doc/libffi.texi", "ext/ffi_c/libffi/doc/stamp-vti", "ext/ffi_c/libffi/doc/version.texi", "ext/ffi_c/libffi/fficonfig.h.in", "ext/ffi_c/libffi/fficonfig.hw", "ext/ffi_c/libffi/include/ffi.h.in", "ext/ffi_c/libffi/include/ffi.h.vc", "ext/ffi_c/libffi/include/ffi.h.vc64", "ext/ffi_c/libffi/include/ffi_common.h", "ext/ffi_c/libffi/include/Makefile.am", "ext/ffi_c/libffi/include/Makefile.in", "ext/ffi_c/libffi/install-sh", "ext/ffi_c/libffi/libffi.pc.in", "ext/ffi_c/libffi/libtool-version", "ext/ffi_c/libffi/LICENSE", "ext/ffi_c/libffi/ltmain.sh", "ext/ffi_c/libffi/m4/ax_cc_maxopt.m4", "ext/ffi_c/libffi/m4/ax_cflags_warn_all.m4", "ext/ffi_c/libffi/m4/ax_check_compiler_flags.m4", "ext/ffi_c/libffi/m4/ax_compiler_vendor.m4", "ext/ffi_c/libffi/m4/ax_configure_args.m4", "ext/ffi_c/libffi/m4/ax_enable_builddir.m4", "ext/ffi_c/libffi/m4/ax_gcc_archflag.m4", "ext/ffi_c/libffi/m4/ax_gcc_x86_cpuid.m4", "ext/ffi_c/libffi/m4/libtool.m4", "ext/ffi_c/libffi/m4/ltoptions.m4", "ext/ffi_c/libffi/m4/ltsugar.m4", "ext/ffi_c/libffi/m4/ltversion.m4", "ext/ffi_c/libffi/m4/lt~obsolete.m4", "ext/ffi_c/libffi/Makefile.am", "ext/ffi_c/libffi/Makefile.in", "ext/ffi_c/libffi/Makefile.vc", "ext/ffi_c/libffi/Makefile.vc64", "ext/ffi_c/libffi/man/ffi.3", "ext/ffi_c/libffi/man/ffi_call.3", "ext/ffi_c/libffi/man/ffi_prep_cif.3", "ext/ffi_c/libffi/man/Makefile.am", "ext/ffi_c/libffi/man/Makefile.in", "ext/ffi_c/libffi/mdate-sh", "ext/ffi_c/libffi/missing", "ext/ffi_c/libffi/msvcc.sh", "ext/ffi_c/libffi/README", "ext/ffi_c/libffi/src/alpha/ffi.c", "ext/ffi_c/libffi/src/alpha/ffitarget.h", "ext/ffi_c/libffi/src/alpha/osf.S", "ext/ffi_c/libffi/src/arm/ffi.c", "ext/ffi_c/libffi/src/arm/ffitarget.h", "ext/ffi_c/libffi/src/arm/gentramp.sh", "ext/ffi_c/libffi/src/arm/sysv.S", "ext/ffi_c/libffi/src/arm/trampoline.S", "ext/ffi_c/libffi/src/avr32/ffi.c", "ext/ffi_c/libffi/src/avr32/ffitarget.h", "ext/ffi_c/libffi/src/avr32/sysv.S", "ext/ffi_c/libffi/src/closures.c", "ext/ffi_c/libffi/src/cris/ffi.c", "ext/ffi_c/libffi/src/cris/ffitarget.h", "ext/ffi_c/libffi/src/cris/sysv.S", "ext/ffi_c/libffi/src/debug.c", "ext/ffi_c/libffi/src/dlmalloc.c", "ext/ffi_c/libffi/src/frv/eabi.S", "ext/ffi_c/libffi/src/frv/ffi.c", "ext/ffi_c/libffi/src/frv/ffitarget.h", "ext/ffi_c/libffi/src/ia64/ffi.c", "ext/ffi_c/libffi/src/ia64/ffitarget.h", "ext/ffi_c/libffi/src/ia64/ia64_flags.h", "ext/ffi_c/libffi/src/ia64/unix.S", "ext/ffi_c/libffi/src/java_raw_api.c", "ext/ffi_c/libffi/src/m32r/ffi.c", "ext/ffi_c/libffi/src/m32r/ffitarget.h", "ext/ffi_c/libffi/src/m32r/sysv.S", "ext/ffi_c/libffi/src/m68k/ffi.c", "ext/ffi_c/libffi/src/m68k/ffitarget.h", "ext/ffi_c/libffi/src/m68k/sysv.S", "ext/ffi_c/libffi/src/mips/ffi.c", "ext/ffi_c/libffi/src/mips/ffitarget.h", "ext/ffi_c/libffi/src/mips/n32.S", "ext/ffi_c/libffi/src/mips/o32.S", "ext/ffi_c/libffi/src/moxie/eabi.S", "ext/ffi_c/libffi/src/moxie/ffi.c", "ext/ffi_c/libffi/src/pa/ffi.c", "ext/ffi_c/libffi/src/pa/ffitarget.h", "ext/ffi_c/libffi/src/pa/hpux32.S", "ext/ffi_c/libffi/src/pa/linux.S", "ext/ffi_c/libffi/src/powerpc/aix.S", "ext/ffi_c/libffi/src/powerpc/aix_closure.S", "ext/ffi_c/libffi/src/powerpc/asm.h", "ext/ffi_c/libffi/src/powerpc/darwin.S", "ext/ffi_c/libffi/src/powerpc/darwin_closure.S", "ext/ffi_c/libffi/src/powerpc/ffi.c", "ext/ffi_c/libffi/src/powerpc/ffi_darwin.c", "ext/ffi_c/libffi/src/powerpc/ffitarget.h", "ext/ffi_c/libffi/src/powerpc/linux64.S", "ext/ffi_c/libffi/src/powerpc/linux64_closure.S", "ext/ffi_c/libffi/src/powerpc/ppc_closure.S", "ext/ffi_c/libffi/src/powerpc/sysv.S", "ext/ffi_c/libffi/src/prep_cif.c", "ext/ffi_c/libffi/src/raw_api.c", "ext/ffi_c/libffi/src/s390/ffi.c", "ext/ffi_c/libffi/src/s390/ffitarget.h", "ext/ffi_c/libffi/src/s390/sysv.S", "ext/ffi_c/libffi/src/sh/ffi.c", "ext/ffi_c/libffi/src/sh/ffitarget.h", "ext/ffi_c/libffi/src/sh/sysv.S", "ext/ffi_c/libffi/src/sh64/ffi.c", "ext/ffi_c/libffi/src/sh64/ffitarget.h", "ext/ffi_c/libffi/src/sh64/sysv.S", "ext/ffi_c/libffi/src/sparc/ffi.c", "ext/ffi_c/libffi/src/sparc/ffitarget.h", "ext/ffi_c/libffi/src/sparc/v8.S", "ext/ffi_c/libffi/src/sparc/v9.S", "ext/ffi_c/libffi/src/types.c", "ext/ffi_c/libffi/src/x86/darwin.S", "ext/ffi_c/libffi/src/x86/darwin64.S", "ext/ffi_c/libffi/src/x86/ffi.c", "ext/ffi_c/libffi/src/x86/ffi64.c", "ext/ffi_c/libffi/src/x86/ffitarget.h", "ext/ffi_c/libffi/src/x86/freebsd.S", "ext/ffi_c/libffi/src/x86/sysv.S", "ext/ffi_c/libffi/src/x86/unix64.S", "ext/ffi_c/libffi/src/x86/win32.S", "ext/ffi_c/libffi/src/x86/win64.S", "ext/ffi_c/libffi/testsuite/config/default.exp", "ext/ffi_c/libffi/testsuite/lib/libffi-dg.exp", "ext/ffi_c/libffi/testsuite/lib/libffi.exp", "ext/ffi_c/libffi/testsuite/lib/target-libpath.exp", "ext/ffi_c/libffi/testsuite/lib/wrapper.exp", "ext/ffi_c/libffi/testsuite/libffi.call/call.exp", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn0.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn1.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn2.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn3.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn4.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn5.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_fn6.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_loc_fn0.c", "ext/ffi_c/libffi/testsuite/libffi.call/closure_stdcall.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_12byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_16byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_18byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_19byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_1_1byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_20byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_20byte1.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_24byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_2byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_3_1byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_3byte1.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_3byte2.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_4_1byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_4byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_5_1_byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_5byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_64byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_6_1_byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_6byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_7_1_byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_7byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_8byte.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_9byte1.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_9byte2.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_double.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_float.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_longdouble.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_longdouble_split.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_longdouble_split2.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_pointer.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_sint16.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_sint32.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_sint64.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_uint16.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_uint32.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_align_uint64.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_dbls_struct.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_double.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_double_va.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_float.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_longdouble.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_longdouble_va.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_multi_schar.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_multi_sshort.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_multi_sshortchar.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_multi_uchar.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_multi_ushort.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_multi_ushortchar.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_pointer.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_pointer_stack.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_schar.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_sint.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_sshort.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_uchar.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_uint.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_ulonglong.c", "ext/ffi_c/libffi/testsuite/libffi.call/cls_ushort.c", "ext/ffi_c/libffi/testsuite/libffi.call/err_bad_abi.c", "ext/ffi_c/libffi/testsuite/libffi.call/err_bad_typedef.c", "ext/ffi_c/libffi/testsuite/libffi.call/ffitest.h", "ext/ffi_c/libffi/testsuite/libffi.call/float.c", "ext/ffi_c/libffi/testsuite/libffi.call/float1.c", "ext/ffi_c/libffi/testsuite/libffi.call/float2.c", "ext/ffi_c/libffi/testsuite/libffi.call/float3.c", "ext/ffi_c/libffi/testsuite/libffi.call/float4.c", "ext/ffi_c/libffi/testsuite/libffi.call/huge_struct.c", "ext/ffi_c/libffi/testsuite/libffi.call/many.c", "ext/ffi_c/libffi/testsuite/libffi.call/many_win32.c", "ext/ffi_c/libffi/testsuite/libffi.call/negint.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct1.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct10.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct2.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct3.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct4.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct5.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct6.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct7.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct8.c", "ext/ffi_c/libffi/testsuite/libffi.call/nested_struct9.c", "ext/ffi_c/libffi/testsuite/libffi.call/problem1.c", "ext/ffi_c/libffi/testsuite/libffi.call/promotion.c", "ext/ffi_c/libffi/testsuite/libffi.call/pyobjc-tc.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_dbl.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_dbl1.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_dbl2.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_fl.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_fl1.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_fl2.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_fl3.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_ldl.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_ll.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_ll1.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_sc.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_sl.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_uc.c", "ext/ffi_c/libffi/testsuite/libffi.call/return_ul.c", "ext/ffi_c/libffi/testsuite/libffi.call/stret_large.c", "ext/ffi_c/libffi/testsuite/libffi.call/stret_large2.c", "ext/ffi_c/libffi/testsuite/libffi.call/stret_medium.c", "ext/ffi_c/libffi/testsuite/libffi.call/stret_medium2.c", "ext/ffi_c/libffi/testsuite/libffi.call/strlen.c", "ext/ffi_c/libffi/testsuite/libffi.call/strlen_win32.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct1.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct2.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct3.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct4.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct5.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct6.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct7.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct8.c", "ext/ffi_c/libffi/testsuite/libffi.call/struct9.c", "ext/ffi_c/libffi/testsuite/libffi.call/testclosure.c", "ext/ffi_c/libffi/testsuite/libffi.special/ffitestcxx.h", "ext/ffi_c/libffi/testsuite/libffi.special/special.exp", "ext/ffi_c/libffi/testsuite/libffi.special/unwindtest.cc", "ext/ffi_c/libffi/testsuite/libffi.special/unwindtest_ffi_call.cc", "ext/ffi_c/libffi/testsuite/Makefile.am", "ext/ffi_c/libffi/testsuite/Makefile.in", "ext/ffi_c/libffi/texinfo.tex", "ext/ffi_c/libffi.bsd.mk", "ext/ffi_c/libffi.darwin.mk", "ext/ffi_c/libffi.gnu.mk", "ext/ffi_c/libffi.mk", "ext/ffi_c/libffi.vc.mk", "ext/ffi_c/libffi.vc64.mk", "ext/ffi_c/LongDouble.c", "ext/ffi_c/LongDouble.h", "ext/ffi_c/MappedType.c", "ext/ffi_c/MappedType.h", "ext/ffi_c/MemoryPointer.c", "ext/ffi_c/MemoryPointer.h", "ext/ffi_c/MethodHandle.c", "ext/ffi_c/MethodHandle.h", "ext/ffi_c/Platform.c", "ext/ffi_c/Platform.h", "ext/ffi_c/Pointer.c", "ext/ffi_c/Pointer.h", "ext/ffi_c/rbffi.h", "ext/ffi_c/rbffi_endian.h", "ext/ffi_c/Struct.c", "ext/ffi_c/Struct.h", "ext/ffi_c/StructByReference.c", "ext/ffi_c/StructByReference.h", "ext/ffi_c/StructByValue.c", "ext/ffi_c/StructByValue.h", "ext/ffi_c/StructLayout.c", "ext/ffi_c/Thread.c", "ext/ffi_c/Thread.h", "ext/ffi_c/Type.c", "ext/ffi_c/Type.h", "ext/ffi_c/Types.c", "ext/ffi_c/Types.h", "ext/ffi_c/Variadic.c", "ext/ffi_c/win32/stdbool.h", "ext/ffi_c/win32/stdint.h", "gen/log", "gen/Rakefile", "lib/ffi/autopointer.rb", "lib/ffi/buffer.rb", "lib/ffi/callback.rb", "lib/ffi/enum.rb", "lib/ffi/errno.rb", "lib/ffi/ffi.iml", "lib/ffi/ffi.rb", "lib/ffi/io.rb", "lib/ffi/library.rb", "lib/ffi/managedstruct.rb", "lib/ffi/memorypointer.rb", "lib/ffi/platform/arm-linux/types.conf", "lib/ffi/platform/i386-cygwin/types.conf", "lib/ffi/platform/i386-darwin/types.conf", "lib/ffi/platform/i386-freebsd/types.conf", "lib/ffi/platform/i386-linux/types.conf", "lib/ffi/platform/i386-netbsd/types.conf", "lib/ffi/platform/i386-openbsd/types.conf", "lib/ffi/platform/i386-solaris/types.conf", "lib/ffi/platform/i386-windows/types.conf", "lib/ffi/platform/i486-gnu/types.conf", "lib/ffi/platform/ia64-linux/types.conf", "lib/ffi/platform/mips-linux/types.conf", "lib/ffi/platform/mipsel-linux/types.conf", "lib/ffi/platform/powerpc-aix/types.conf", "lib/ffi/platform/powerpc-darwin/types.conf", "lib/ffi/platform/powerpc-linux/types.conf", "lib/ffi/platform/s390-linux/types.conf", "lib/ffi/platform/s390x-linux/types.conf", "lib/ffi/platform/sparc-linux/types.conf", "lib/ffi/platform/sparc-solaris/types.conf", "lib/ffi/platform/sparcv9-solaris/types.conf", "lib/ffi/platform/x86_64-darwin/types.conf", "lib/ffi/platform/x86_64-freebsd/types.conf", "lib/ffi/platform/x86_64-linux/types.conf", "lib/ffi/platform/x86_64-netbsd/types.conf", "lib/ffi/platform/x86_64-openbsd/types.conf", "lib/ffi/platform/x86_64-solaris/types.conf", "lib/ffi/platform/x86_64-windows/types.conf", "lib/ffi/platform.rb", "lib/ffi/pointer.rb", "lib/ffi/struct.rb", "lib/ffi/struct_layout_builder.rb", "lib/ffi/tools/const_generator.rb", "lib/ffi/tools/generator.rb", "lib/ffi/tools/generator_task.rb", "lib/ffi/tools/struct_generator.rb", "lib/ffi/tools/types_generator.rb", "lib/ffi/types.rb", "lib/ffi/union.rb", "lib/ffi/variadic.rb", "lib/ffi/version.rb", "lib/ffi.rb", "spec/ffi/async_callback_spec.rb", "spec/ffi/bool_spec.rb", "spec/ffi/buffer_spec.rb", "spec/ffi/callback_spec.rb", "spec/ffi/custom_param_type.rb", "spec/ffi/custom_type_spec.rb", "spec/ffi/dup_spec.rb", "spec/ffi/enum_spec.rb", "spec/ffi/errno_spec.rb", "spec/ffi/ffi_spec.rb", "spec/ffi/function_spec.rb", "spec/ffi/library_spec.rb", "spec/ffi/long_double.rb", "spec/ffi/managed_struct_spec.rb", "spec/ffi/number_spec.rb", "spec/ffi/pointer_spec.rb", "spec/ffi/rbx/attach_function_spec.rb", "spec/ffi/rbx/memory_pointer_spec.rb", "spec/ffi/rbx/spec_helper.rb", "spec/ffi/rbx/struct_spec.rb", "spec/ffi/spec.iml", "spec/ffi/spec_helper.rb", "spec/ffi/string_spec.rb", "spec/ffi/strptr_spec.rb", "spec/ffi/struct_by_ref_spec.rb", "spec/ffi/struct_callback_spec.rb", "spec/ffi/struct_initialize_spec.rb", "spec/ffi/struct_packed_spec.rb", "spec/ffi/struct_spec.rb", "spec/ffi/typedef_spec.rb", "spec/ffi/union_spec.rb", "spec/ffi/variadic_spec.rb", "spec/spec.opts", "libtest/Benchmark.c", "libtest/BoolTest.c", "libtest/BufferTest.c", "libtest/ClosureTest.c", "libtest/EnumTest.c", "libtest/FunctionTest.c", "libtest/GlobalVariable.c", "libtest/GNUmakefile", "libtest/LastErrorTest.c", "libtest/NumberTest.c", "libtest/PointerTest.c", "libtest/ReferenceTest.c", "libtest/StringTest.c", "libtest/StructTest.c", "libtest/UnionTest.c", "libtest/VariadicTest.c"]
  s.homepage = %q{http://wiki.github.com/ffi/ffi}
  s.licenses = ["LGPL-3"]
  s.rdoc_options = ["--exclude=ext/ffi_c/.*\\.o$", "--exclude=ffi_c\\.(bundle|so)$"]
  s.require_paths = ["lib", "ext/ffi_c"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby FFI}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0.6.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rubygems-tasks>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rake-compiler>, [">= 0.6.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rubygems-tasks>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rake-compiler>, [">= 0.6.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rubygems-tasks>, [">= 0"])
  end
end
