Return-Path: <cgroups+bounces-1152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC8830AC8
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EA7287DDF
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C822EEF;
	Wed, 17 Jan 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyvIhOFN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400E22636;
	Wed, 17 Jan 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508111; cv=none; b=t8OkREobosDG6Hps8HgvmVN9wfPGM3IYcd6+vEh1mHdZVklwK3x9FNURZJf4GiLeiFvTiqNOyo2aO1LaXXUdYvP/t+YGZThnx74tHaDEqWF75mcOqjcFHISKXw+3uxUVpAvkdlpvsUeDgXhqhuEUTIJjBkMaeE8Cy4DtcKb6grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508111; c=relaxed/simple;
	bh=SbzlSXpRvsUpXUW2hg2vsE65KIFNDSoztygwRFd62Iw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=FN2Vgt/5iJ/EQx3gi6+Rb5k6K2yl10IwLS7e4fM6amsa8W7BTbmRM9jTVGyD+NvIsJqTZQAv+oWtKdJQMuhTy4xA5Qz5fSrAZt7dauf2sMBJlHeRyut3a/XnWXB7D6TgrMPL4CFvq5UN95AoptssMaQpRrxUWnuOhLNYisHWvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyvIhOFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CBFC43394;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705508109;
	bh=SbzlSXpRvsUpXUW2hg2vsE65KIFNDSoztygwRFd62Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyvIhOFND4/d9lgtxET6AjQNr+5TfCtZM72YHaWKxkzrkGQQiTjsV9vryPHqzZ+YD
	 nikLvgD8vIOlWx2dg/RxMbT9yTi45l0If5wWqleb9NUPwrIO7Utw2dFYRv9BbQ5thl
	 oq/k8a+Xpp96kJTTRTzadt3PiWBxGR07IUBye6LrA5ZURe8VwAF63VYK3YQt7Hx0V7
	 0LZkLVxG9ySD0LuEtsK2rtOov5hIK6A5yzj1J1gM0ttDApF6T1dTp2+rCc3mgQq7h5
	 Ny6MIwcEY3L/zvvsiGDImPueYgg9GbH32KR0/avBtRTZs1r727xCk6NKUACNQutpU8
	 a+3aeBum1musA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RFC 3/4] mitigations: Expand 'mitigations=off' to include optional software mitigations
Date: Wed, 17 Jan 2024 08:14:45 -0800
Message-ID: <c9b3d9cf9d6eac76daadd0a0b224e69607a1da3d.1705507931.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705507931.git.jpoimboe@kernel.org>
References: <cover.1705507931.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'mitigations=off' cmdline option disables all CPU mitigations at
runtime.  It's intended for users who are running with trusted user
space and don't want the performance impact associated with all the
mitigations.

Up until now, it was only used for CPU mitigations.  However, there can
also be optional software mitigations which have performance impact.

Expand 'mitigations=' to include optional software mitigations.  After
all there's nothing in the "mitigations" name which limits it to CPU
vulnerabilities.

In theory we could introduce separate {cpu,sw}_mitigations= options, but
for the time being there's no need to separate them out.

It's simpler to have them combined since the use case of "I have trusted
user space and don't want the performance impacts of unneeded
mitigations" is the same, regardless of the source of the bug.

Move the interfaces around and rename them to reflect the new broader
impact of mitigations=off.

No functional changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 27 ++++++----
 arch/arm64/kernel/cpufeature.c                |  2 +-
 arch/arm64/kernel/proton-pack.c               |  6 +--
 arch/powerpc/kernel/security.c                | 14 +++---
 arch/s390/kernel/nospec-branch.c              |  2 +-
 arch/x86/kernel/cpu/bugs.c                    | 35 ++++++-------
 arch/x86/kvm/mmu/mmu.c                        |  2 +-
 arch/x86/mm/pti.c                             |  3 +-
 include/linux/bpf.h                           |  5 +-
 include/linux/cpu.h                           |  3 --
 include/linux/mitigations.h                   |  4 ++
 kernel/Makefile                               |  3 +-
 kernel/cpu.c                                  | 43 ----------------
 kernel/mitigations.c                          | 50 +++++++++++++++++++
 14 files changed, 109 insertions(+), 90 deletions(-)
 create mode 100644 include/linux/mitigations.h
 create mode 100644 kernel/mitigations.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91987b06bc52..24e873351368 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3391,16 +3391,23 @@
 			https://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			[X86,PPC,S390,ARM64] Control optional mitigations for
-			CPU vulnerabilities.  This is a set of curated,
-			arch-independent options, each of which is an
-			aggregation of existing arch-specific options.
+			[KNL] Control optional mitigations for CPU
+			vulnerabilities and performance-impacting
+			software vulnerabilities.  This is a set of
+			curated, arch-independent options, each of which
+			is an aggregation of existing arch-specific
+			options.
 
 			off
-				Disable all optional CPU mitigations.  This
-				improves system performance, but it may also
-				expose users to several CPU vulnerabilities.
-				Equivalent to: if nokaslr then kpti=0 [ARM64]
+				Disable all optional mitigations.  This
+				improves system performance, but may also
+				expose users to several vulnerabilities.
+
+				Equivalent to:
+
+					       CPU mitigations:
+					       ----------------
+					       if nokaslr then kpti=0 [ARM64]
 					       gather_data_sampling=off [X86]
 					       kvm.nx_huge_pages=off [X86]
 					       l1tf=off [X86]
@@ -3426,7 +3433,7 @@
 					       kvm.nx_huge_pages=force.
 
 			auto (default)
-				Mitigate all CPU vulnerabilities, but leave SMT
+				Enable all optional mitigations, but leave SMT
 				enabled, even if it's vulnerable.  This is for
 				users who don't want to be surprised by SMT
 				getting disabled across kernel upgrades, or who
@@ -3434,7 +3441,7 @@
 				Equivalent to: (default behavior)
 
 			auto,nosmt
-				Mitigate all CPU vulnerabilities, disabling SMT
+				Enable all optional mitigations, disabling SMT
 				if needed.  This is for users who always want to
 				be fully mitigated, even if it means losing SMT.
 				Equivalent to: l1tf=flush,nosmt [X86]
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 01a4c1d7fc09..ae37898e5b1a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1719,7 +1719,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		}
 	}
 
-	if (cpu_mitigations_off() && !__kpti_forced) {
+	if (mitigations_off() && !__kpti_forced) {
 		str = "mitigations=off";
 		__kpti_forced = -1;
 	}
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 6268a13a1d58..00242edf1885 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -91,7 +91,7 @@ early_param("nospectre_v2", parse_spectre_v2_param);
 
 static bool spectre_v2_mitigations_off(void)
 {
-	bool ret = __nospectre_v2 || cpu_mitigations_off();
+	bool ret = __nospectre_v2 || mitigations_off();
 
 	if (ret)
 		pr_info_once("spectre-v2 mitigation disabled by command line option\n");
@@ -421,7 +421,7 @@ early_param("ssbd", parse_spectre_v4_param);
  */
 static bool spectre_v4_mitigations_off(void)
 {
-	bool ret = cpu_mitigations_off() ||
+	bool ret = mitigations_off() ||
 		   __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
 
 	if (ret)
@@ -1000,7 +1000,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		/* No point mitigating Spectre-BHB alone. */
 	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
 		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
-	} else if (cpu_mitigations_off() || __nospectre_bhb) {
+	} else if (mitigations_off() || __nospectre_bhb) {
 		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
 		state = SPECTRE_MITIGATED;
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4856e1a5161c..52cf79b5d87a 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -64,7 +64,7 @@ void __init setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	if (!no_nospec && !cpu_mitigations_off())
+	if (!no_nospec && !mitigations_off())
 		enable_barrier_nospec(enable);
 }
 
@@ -135,7 +135,7 @@ early_param("nospectre_v2", handle_nospectre_v2);
 #ifdef CONFIG_PPC_E500
 void __init setup_spectre_v2(void)
 {
-	if (no_spectrev2 || cpu_mitigations_off())
+	if (no_spectrev2 || mitigations_off())
 		do_btb_flush_fixups();
 	else
 		btb_flush_enabled = true;
@@ -331,7 +331,7 @@ void setup_stf_barrier(void)
 
 	stf_enabled_flush_types = type;
 
-	if (!no_stf_barrier && !cpu_mitigations_off())
+	if (!no_stf_barrier && !mitigations_off())
 		stf_barrier_enable(enable);
 }
 
@@ -530,7 +530,7 @@ void setup_count_cache_flush(void)
 {
 	bool enable = true;
 
-	if (no_spectrev2 || cpu_mitigations_off()) {
+	if (no_spectrev2 || mitigations_off()) {
 		if (security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED) ||
 		    security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED))
 			pr_warn("Spectre v2 mitigations not fully under software control, can't disable\n");
@@ -700,13 +700,13 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 
 	enabled_flush_types = types;
 
-	if (!cpu_mitigations_off() && !no_rfi_flush)
+	if (!mitigations_off() && !no_rfi_flush)
 		rfi_flush_enable(enable);
 }
 
 void setup_entry_flush(bool enable)
 {
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		return;
 
 	if (!no_entry_flush)
@@ -715,7 +715,7 @@ void setup_entry_flush(bool enable)
 
 void setup_uaccess_flush(bool enable)
 {
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		return;
 
 	if (!no_uaccess_flush)
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index d1b16d83e49a..75ec4ad4198b 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -59,7 +59,7 @@ early_param("nospectre_v2", nospectre_v2_setup_early);
 
 void __init nospec_auto_detect(void)
 {
-	if (test_facility(156) || cpu_mitigations_off()) {
+	if (test_facility(156) || mitigations_off()) {
 		/*
 		 * The machine supports etokens.
 		 * Disable expolines and disable nobp.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..45d4c2664011 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/mitigations.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -243,7 +244,7 @@ static const char * const mds_strings[] = {
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || mitigations_off()) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
@@ -255,7 +256,7 @@ static void __init mds_select_mitigation(void)
 		static_branch_enable(&mds_user_clear);
 
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		    (mds_nosmt || mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
 	}
 }
@@ -317,7 +318,7 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
+	if (mitigations_off()) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
 	}
@@ -358,7 +359,7 @@ static void __init taa_select_mitigation(void)
 	 */
 	static_branch_enable(&mds_user_clear);
 
-	if (taa_nosmt || cpu_mitigations_auto_nosmt())
+	if (taa_nosmt || mitigations_auto_nosmt())
 		cpu_smt_disable(false);
 }
 
@@ -408,7 +409,7 @@ static void __init mmio_select_mitigation(void)
 
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_mitigations_off()) {
+	     mitigations_off()) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
@@ -451,7 +452,7 @@ static void __init mmio_select_mitigation(void)
 	else
 		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
 
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+	if (mmio_nosmt || mitigations_auto_nosmt())
 		cpu_smt_disable(false);
 }
 
@@ -481,7 +482,7 @@ early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
 static void __init md_clear_update_mitigation(void)
 {
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		return;
 
 	if (!static_key_enabled(&mds_user_clear))
@@ -611,7 +612,7 @@ static void __init srbds_select_mitigation(void)
 		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
 	else if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
 		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
-	else if (cpu_mitigations_off() || srbds_off)
+	else if (mitigations_off() || srbds_off)
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 
 	update_srbds_msr();
@@ -742,7 +743,7 @@ static void __init gds_select_mitigation(void)
 		goto out;
 	}
 
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
 
@@ -841,7 +842,7 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || mitigations_off()) {
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 		return;
 	}
@@ -974,7 +975,7 @@ static void __init retbleed_select_mitigation(void)
 {
 	bool mitigate_smt = false;
 
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || mitigations_off())
 		return;
 
 	switch (retbleed_cmd) {
@@ -1068,7 +1069,7 @@ static void __init retbleed_select_mitigation(void)
 	}
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
-	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
+	    (retbleed_nosmt || mitigations_auto_nosmt()))
 		cpu_smt_disable(false);
 
 	/*
@@ -1391,7 +1392,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	int ret, i;
 
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
-	    cpu_mitigations_off())
+	    mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
@@ -1885,7 +1886,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	int ret, i;
 
 	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
-	    cpu_mitigations_off()) {
+	    mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
 	} else {
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
@@ -2283,9 +2284,9 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		l1tf_mitigation = L1TF_MITIGATION_OFF;
-	else if (cpu_mitigations_auto_nosmt())
+	else if (mitigations_auto_nosmt())
 		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
 
 	override_cache_bits(&boot_cpu_data);
@@ -2410,7 +2411,7 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		return;
 
 	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0b1f991b9a31..f0d105f740ed 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6819,7 +6819,7 @@ static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp)
 static bool get_nx_auto_mode(void)
 {
 	/* Return true when CPU has the bug, and mitigations are ON */
-	return boot_cpu_has_bug(X86_BUG_ITLB_MULTIHIT) && !cpu_mitigations_off();
+	return boot_cpu_has_bug(X86_BUG_ITLB_MULTIHIT) && !mitigations_off();
 }
 
 static void __set_nx_huge_pages(bool val)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 669ba1c345b3..16a63c241e1e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/cpu.h>
+#include <linux/mitigations.h>
 
 #include <asm/cpufeature.h>
 #include <asm/hypervisor.h>
@@ -84,7 +85,7 @@ void __init pti_check_boottime_disable(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
+	if (mitigations_off())
 		pti_mode = PTI_FORCE_OFF;
 	if (pti_mode == PTI_FORCE_OFF) {
 		pti_print_if_insecure("disabled on command line.");
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e30100597d0a..04356b9fa82a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -30,6 +30,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <linux/mitigations.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -2214,12 +2215,12 @@ static inline bool bpf_allow_uninit_stack(void)
 
 static inline bool bpf_bypass_spec_v1(void)
 {
-	return cpu_mitigations_off() || perfmon_capable();
+	return mitigations_off() || perfmon_capable();
 }
 
 static inline bool bpf_bypass_spec_v4(void)
 {
-	return cpu_mitigations_off() || perfmon_capable();
+	return mitigations_off() || perfmon_capable();
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fc8094419084..b8c81d924a62 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -212,7 +212,4 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
-extern bool cpu_mitigations_off(void);
-extern bool cpu_mitigations_auto_nosmt(void);
-
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/linux/mitigations.h b/include/linux/mitigations.h
new file mode 100644
index 000000000000..5acc80d49230
--- /dev/null
+++ b/include/linux/mitigations.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern bool mitigations_off(void);
+extern bool mitigations_auto_nosmt(void);
diff --git a/kernel/Makefile b/kernel/Makefile
index ce105a5558fc..d1514432bbc7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,8 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
+	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o \
+	    mitigations.o
 
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..e273478cd437 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3195,46 +3195,3 @@ void __init boot_cpu_hotplug_init(void)
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
-
-/*
- * These are used for a global "mitigations=" cmdline option for toggling
- * optional CPU mitigations.
- */
-enum cpu_mitigations {
-	CPU_MITIGATIONS_OFF,
-	CPU_MITIGATIONS_AUTO,
-	CPU_MITIGATIONS_AUTO_NOSMT,
-};
-
-static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	CPU_MITIGATIONS_AUTO;
-
-static int __init mitigations_parse_cmdline(char *arg)
-{
-	if (!strcmp(arg, "off"))
-		cpu_mitigations = CPU_MITIGATIONS_OFF;
-	else if (!strcmp(arg, "auto"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO;
-	else if (!strcmp(arg, "auto,nosmt"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
-	else
-		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
-			arg);
-
-	return 0;
-}
-early_param("mitigations", mitigations_parse_cmdline);
-
-/* mitigations=off */
-bool cpu_mitigations_off(void)
-{
-	return cpu_mitigations == CPU_MITIGATIONS_OFF;
-}
-EXPORT_SYMBOL_GPL(cpu_mitigations_off);
-
-/* mitigations=auto,nosmt */
-bool cpu_mitigations_auto_nosmt(void)
-{
-	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
-}
-EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
diff --git a/kernel/mitigations.c b/kernel/mitigations.c
new file mode 100644
index 000000000000..2828a755a719
--- /dev/null
+++ b/kernel/mitigations.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cache.h>
+#include <linux/init.h>
+#include <linux/mitigations.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+enum mitigations {
+	MITIGATIONS_OFF,
+	MITIGATIONS_AUTO,
+	MITIGATIONS_AUTO_NOSMT,
+};
+
+static enum mitigations mitigations __ro_after_init =
+	MITIGATIONS_AUTO;
+
+/*
+ * The "mitigations=" cmdline option is for toggling optional CPU or software
+ * mitigations which may impact performance.  Mitigations should only be turned
+ * off if user space and VMs are running trusted code.
+ */
+static int __init mitigations_parse_cmdline(char *arg)
+{
+	if (!strcmp(arg, "off"))
+		mitigations = MITIGATIONS_OFF;
+	else if (!strcmp(arg, "auto"))
+		mitigations = MITIGATIONS_AUTO;
+	else if (!strcmp(arg, "auto,nosmt"))
+		mitigations = MITIGATIONS_AUTO_NOSMT;
+	else
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n", arg);
+
+	return 0;
+}
+early_param("mitigations", mitigations_parse_cmdline);
+
+/* mitigations=off */
+bool mitigations_off(void)
+{
+	return mitigations == MITIGATIONS_OFF;
+}
+EXPORT_SYMBOL_GPL(mitigations_off);
+
+/* mitigations=auto,nosmt */
+bool mitigations_auto_nosmt(void)
+{
+	return mitigations == MITIGATIONS_AUTO_NOSMT;
+}
+EXPORT_SYMBOL_GPL(mitigations_auto_nosmt);
-- 
2.43.0


