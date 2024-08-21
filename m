Return-Path: <cgroups+bounces-4395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C995927A
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41CD1C227DF
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD8152E1C;
	Wed, 21 Aug 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFRGn6YV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FD14D435;
	Wed, 21 Aug 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205270; cv=none; b=UzGOdUvArt1FoQJtGV3ej+gffaOO19p1cYAb8Gl6SjuTZbjSPpWN97AZvZq4+CQlhRKNlejscqDL/7zomE4u0mAIvGJJ+wBJGgaaLBg2X6XTu8++RGXfcWH9WRXwX46UchrqRHIiPZcIL7g+362hXhfvZiFuym3zwd1s4EF5jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205270; c=relaxed/simple;
	bh=04/rpulk6x/ndFy1V0HtSQEpYU0yBLB3rRXnj7Oz3Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/ReiRFlm4eIZ9o/9R5RC5S85tUIAaUHHvWAUSrcmx4VPXf5OgL+vLQeFxLjYaFIJT1TQxtC5QSOt6cIy1FXAW9RfolzJvk9Fa31HeidGXjrimoOjI42J9wFmcWnirpirK+7dwwgikJd3clSnMHKbNY9EbQt/3qf96TF/Ewqb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFRGn6YV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205269; x=1755741269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=04/rpulk6x/ndFy1V0HtSQEpYU0yBLB3rRXnj7Oz3Ic=;
  b=GFRGn6YVr8aKWnhxcbDhC70m8+DbVSzCAdSx+OWNoiEUxTO++bLTs+sC
   JE7tSBxPVWxeKVU6MGdZDemNEGrL+qY8XHdxKqMnayYMujH4ol9NRQB9P
   6xZrbL9u523U7eJghsjx8l7rB8LqvrwqE9EXEIQwcvS5W4pnqODYznE9/
   GxNmVNqA6R2B8pk/Gt8jSEqFlPGtq39jjpofEM1rUpTSaWdHHl8Ok5A3X
   RFosE1ttHg1P/EZxK4q41+ejg9UN3nWZEu/Im/Ee0MmhYUFOPRjlOVQzz
   In+DBFuyePLnBGLO6cm55I869Xwx2E31w0TR4MpVuBj357bgE3GVqeG3r
   w==;
X-CSE-ConnectionGUID: kH4qgBHKRnqUGW3cQG/1Rg==
X-CSE-MsgGUID: 44CJ+INGQXy9FyEWVOQaBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107946"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107946"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:21 -0700
X-CSE-ConnectionGUID: P9WEGBGFSPS9aV7RM/IA6Q==
X-CSE-MsgGUID: mEpHAGsnQcioNtbmGZ27WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078616"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:21 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v16 12/16] x86/sgx: Revise global reclamation for EPC cgroups
Date: Tue, 20 Aug 2024 18:54:00 -0700
Message-ID: <20240821015404.6038-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821015404.6038-1-haitao.huang@linux.intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With EPC cgroups, the global reclamation function,
sgx_reclaim_pages_global(), can no longer apply to the global LRU as
pages are now in per-cgroup LRUs.

Create a wrapper, sgx_cgroup_reclaim_global() to invoke
sgx_cgroup_reclaim_pages() passing in the root cgroup. Call this wrapper
from sgx_reclaim_pages_global() when cgroup is enabled. The wrapper will
scan and attempt to reclaim SGX_NR_TO_SCAN pages just like the current
global reclaim.

Note this simple implementation doesn't _exactly_ mimic the current
global EPC reclaim (which always tries to do the actual reclaim in batch
of SGX_NR_TO_SCAN pages): in rare cases when LRUs have less than
SGX_NR_TO_SCAN reclaimable pages, the actual reclaim of EPC pages will
be split into smaller batches _across_ multiple LRUs with each being
smaller than SGX_NR_TO_SCAN pages.

A more precise way to mimic the current global EPC reclaim would be to
have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
_across_ the given EPC cgroup _AND_ its descendants, and then do the
actual reclaim in one batch.  But this is unnecessarily complicated at
this stage to address such rare cases.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 12 ++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  3 +++
 arch/x86/kernel/cpu/sgx/main.c       |  7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index ae65cac858f8..23a61689e0d9 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -240,6 +240,18 @@ static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
 	return (cur >= max);
 }
 
+/**
+ * sgx_cgroup_reclaim_pages_global() - Perform one round of global reclamation.
+ *
+ * @charge_mm:	The mm to be charged for the backing store of reclaimed pages.
+ *
+ * Try to scan and attempt reclamation from root cgroup for %SGX_NR_TO_SCAN pages.
+ */
+void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm)
+{
+	sgx_cgroup_reclaim_pages(&sgx_cg_root, charge_mm, SGX_NR_TO_SCAN);
+}
+
 /*
  * Asynchronous work flow to reclaim pages from the cgroup when the cgroup is
  * at/near its maximum capacity.
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 37364bdb797f..c0390111e28c 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -36,6 +36,8 @@ static inline void __init sgx_cgroup_deinit(void) { }
 
 static inline void __init sgx_cgroup_register(void) { }
 
+static inline void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm) { }
+
 #else /* CONFIG_CGROUP_MISC */
 
 struct sgx_cgroup {
@@ -87,6 +89,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
 int __init sgx_cgroup_init(void);
 void __init sgx_cgroup_register(void);
 void __init sgx_cgroup_deinit(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index fa00ed5e884d..d00cb012838b 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -411,6 +411,13 @@ static bool sgx_should_reclaim_global(unsigned long watermark)
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
+	/*
+	 * Now all EPC pages are still tracked in the @sgx_global_lru.
+	 * Still reclaim from it.
+	 *
+	 * When EPC pages are tracked in the actual per-cgroup LRUs,
+	 * sgx_cgroup_reclaim_pages_global() will be called.
+	 */
 	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
-- 
2.43.0


