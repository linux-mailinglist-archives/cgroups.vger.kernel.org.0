Return-Path: <cgroups+bounces-4907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6997CEE4
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 23:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141D81C21CF8
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08920197A99;
	Thu, 19 Sep 2024 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jb92EuqE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E82195FFA;
	Thu, 19 Sep 2024 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782760; cv=none; b=Wrf0sLnhdMOpeqfq35L/yF/nPdt9Zxh+gXMNnLA8yifhG7UXWpXGFRkLzivqJ2Kr8JnQVtyZkQ7DaksY1+4guFN58+MmUTIt40Nkw6QOQwmCmjpN3iEZCVLNYPQ9fU6GeBlXksWcbRu3CXuRY7wfJqERewT+eOxBDbzdf98tglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782760; c=relaxed/simple;
	bh=UJlvI3BLrvCtEcxuIXgu90RvWcQGFXzPnXpX3uO9fsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/X/3bKxUjYr8bTdnwLIxl2P2ftvHztdJy3SLNCbSHwNETRzis7ES8VDhoR2A/5jAyI14MtgG8j+wgTjVVsrfzqhMg7QUE+MIVG1/rQJ3E+FTMWv0OwSE5G0NYhCMbAC1Ixt4R+uRezvPAhjoemJJjQMN+1N/nyBiQZV6bADLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jb92EuqE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782760; x=1758318760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJlvI3BLrvCtEcxuIXgu90RvWcQGFXzPnXpX3uO9fsE=;
  b=Jb92EuqERQ/y98sbZIGZTp9G9SCf2DkBF/BixA6FPngXTW/n75o+NCjE
   5xstMTdt0e+mIwVauYR2U0ldrdGKCrYKNzKCmb0qxufJ8pNYO71gZ9e9z
   rkNF22ckddLDuZxdzdAcEUx9rSWPhtSVJkyEp8Anic5FjQ8Vhv5qpYJSV
   oquNh4h8lsrDPP2q8joepK6rAFBdkoqp7UI75+0J1JSoh2Ifv/topW+1h
   TjuoffEM/zDA936IATVx8zuYunUpFAzmUbAkxEsSJTDHSsT/iKcY/mztS
   PP/AT9IRulBPQQI25XZLdGKm3RnbaGJrGwXlDi8AhGkSiKcW0ZkOxkpyD
   g==;
X-CSE-ConnectionGUID: FibWjQMbTJivFt0YBMHP9g==
X-CSE-MsgGUID: Lpxw2o9IQu6prBagKFU6QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25870761"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25870761"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:39 -0700
X-CSE-ConnectionGUID: rFtaqb5YRYeQzOSunm3i9Q==
X-CSE-MsgGUID: pH7XZBTZSFWMqmbMFdb8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74862551"
Received: from trevorcr-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.197])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:39 -0700
Date: Thu, 19 Sep 2024 14:52:37 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Kaplan <David.Kaplan@amd.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH RFC 1/2] x86/entry_64: Add a separate unmitigated entry/exit
 path
Message-ID: <20240919-selective-mitigation-v1-1-1846cf41895e@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>

CPU mitigations are deployed system-wide, but usually not all of the
userspace is malicious. Yet, they suffer from the performance impact
of the mitigations. This all or nothing approach is due to lack of a
way for kernel to know which userspace can be trusted and which cannot.

For scenarios where an admin can decide which processes to trust, an
interface to tell the kernel to possibly skip the mitigation would be
useful.

In preparation for kernel to be able to selectively apply mitigation
per-process add a separate kernel entry/exit path that skips the
mitigations.

Originally-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S     | 66 +++++++++++++++++++++++++++++++++++--------
 arch/x86/include/asm/proto.h  | 15 +++++++---
 arch/x86/include/asm/ptrace.h | 15 +++++++---
 arch/x86/kernel/cpu/common.c  |  2 +-
 4 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1b5be07f8669..eeaf4226d09c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -84,7 +84,7 @@
  * with them due to bugs in both AMD and Intel CPUs.
  */
 
-SYM_CODE_START(entry_SYSCALL_64)
+.macro __entry_SYSCALL_64 mitigated=0
 	UNWIND_HINT_ENTRY
 	ENDBR
 
@@ -94,7 +94,12 @@ SYM_CODE_START(entry_SYSCALL_64)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
-SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
+.if \mitigated
+SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack_mitigated, SYM_L_GLOBAL)
+.else
+SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack_unmitigated, SYM_L_GLOBAL)
+.endif
+
 	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
@@ -103,7 +108,11 @@ SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
 	pushq	%r11					/* pt_regs->flags */
 	pushq	$__USER_CS				/* pt_regs->cs */
 	pushq	%rcx					/* pt_regs->ip */
+
+.if \mitigated
 SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
+.endif
+
 	pushq	%rax					/* pt_regs->orig_ax */
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
@@ -113,10 +122,12 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	/* Sign extend the lower 32bit as syscall numbers are treated as int */
 	movslq	%eax, %rsi
 
+.if \mitigated
 	/* clobbers %rax, make sure it is after saving the syscall nr */
 	IBRS_ENTER
 	UNTRAIN_RET
 	CLEAR_BRANCH_HISTORY
+.endif
 
 	call	do_syscall_64		/* returns with IRQs disabled */
 
@@ -127,15 +138,26 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * In the Xen PV case we must use iret anyway.
 	 */
 
-	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode", \
-		"jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+.if \mitigated
+	push %rax
+	IBRS_EXIT
+	CLEAR_CPU_BUFFERS
+	pop %rax
+.endif
+
+	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode_from_syscall", \
+		"jmp swapgs_restore_regs_and_return_to_usermode_from_syscall", X86_FEATURE_XENPV
 
 	/*
 	 * We win! This label is here just for ease of understanding
 	 * perf profiles. Nothing jumps here.
 	 */
-syscall_return_via_sysret:
-	IBRS_EXIT
+.if \mitigated
+syscall_return_via_sysret_mitigated:
+.else
+syscall_return_via_sysret_unmitigated:
+.endif
+
 	POP_REGS pop_rdi=0
 
 	/*
@@ -159,15 +181,36 @@ syscall_return_via_sysret:
 
 	popq	%rdi
 	popq	%rsp
-SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
+
+.if \mitigated
+SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack_mitigated, SYM_L_GLOBAL)
+.else
+SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack_unmitigated, SYM_L_GLOBAL)
+.endif
+
 	ANNOTATE_NOENDBR
 	swapgs
-	CLEAR_CPU_BUFFERS
+
+.if \mitigated
+SYM_INNER_LABEL(entry_SYSRETQ_end_mitigated, SYM_L_GLOBAL)
+.else
+SYM_INNER_LABEL(entry_SYSRETQ_end_unmitigated, SYM_L_GLOBAL)
+.endif
 	sysretq
-SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
+
+.endm /* __entry_SYSCALL_64 */
+
+SYM_CODE_START(entry_SYSCALL_64_unmitigated)
+	__entry_SYSCALL_64 mitigated=0
 	ANNOTATE_NOENDBR
 	int3
-SYM_CODE_END(entry_SYSCALL_64)
+SYM_CODE_END(entry_SYSCALL_64_unmitigated)
+
+SYM_CODE_START(entry_SYSCALL_64_mitigated)
+	__entry_SYSCALL_64 mitigated=1
+	ANNOTATE_NOENDBR
+	int3
+SYM_CODE_END(entry_SYSCALL_64_mitigated)
 
 /*
  * %rdi: prev task
@@ -559,6 +602,8 @@ __irqentry_text_end:
 SYM_CODE_START_LOCAL(common_interrupt_return)
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	IBRS_EXIT
+	CLEAR_CPU_BUFFERS
+SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode_from_syscall, SYM_L_GLOBAL)
 #ifdef CONFIG_XEN_PV
 	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 #endif
@@ -573,7 +618,6 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 .Lswapgs_and_iret:
 	swapgs
-	CLEAR_CPU_BUFFERS
 	/* Assert that the IRET frame indicates user mode. */
 	testb	$3, 8(%rsp)
 	jnz	.Lnative_iret
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 484f4f0131a5..0936e0e70659 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -11,10 +11,17 @@ struct task_struct;
 void syscall_init(void);
 
 #ifdef CONFIG_X86_64
-void entry_SYSCALL_64(void);
-void entry_SYSCALL_64_safe_stack(void);
-void entry_SYSRETQ_unsafe_stack(void);
-void entry_SYSRETQ_end(void);
+
+void entry_SYSCALL_64_unmitigated(void);
+void entry_SYSCALL_64_safe_stack_unmitigated(void);
+void entry_SYSRETQ_unsafe_stack_unmitigated(void);
+void entry_SYSRETQ_end_unmitigated(void);
+
+void entry_SYSCALL_64_mitigated(void);
+void entry_SYSCALL_64_safe_stack_mitigated(void);
+void entry_SYSRETQ_unsafe_stack_mitigated(void);
+void entry_SYSRETQ_end_mitigated(void);
+
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5a83fbd9bc0b..74a13c76d241 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -261,11 +261,18 @@ static inline bool any_64bit_mode(struct pt_regs *regs)
 
 static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 {
-	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
-		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
+	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64_unmitigated &&
+		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack_unmitigated);
+
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETQ_unsafe_stack_unmitigated &&
+		      regs->ip <  (unsigned long)entry_SYSRETQ_end_unmitigated);
+
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSCALL_64_mitigated &&
+		      regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack_mitigated);
+
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETQ_unsafe_stack_mitigated &&
+		      regs->ip <  (unsigned long)entry_SYSRETQ_end_mitigated);
 
-	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETQ_unsafe_stack &&
-		      regs->ip <  (unsigned long)entry_SYSRETQ_end);
 #ifdef CONFIG_IA32_EMULATION
 	ret = ret || (regs->ip >= (unsigned long)entry_SYSCALL_compat &&
 		      regs->ip <  (unsigned long)entry_SYSCALL_compat_safe_stack);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..e72c37f3a437 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2026,7 +2026,7 @@ static void wrmsrl_cstar(unsigned long val)
 
 static inline void idt_syscall_init(void)
 {
-	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
+	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64_unmitigated);
 
 	if (ia32_enabled()) {
 		wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);

-- 
2.34.1



