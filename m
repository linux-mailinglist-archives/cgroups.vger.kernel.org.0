Return-Path: <cgroups+bounces-4637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70896672D
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F200E1C24412
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553D1BDA95;
	Fri, 30 Aug 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C59t0xkK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8691BCA1E;
	Fri, 30 Aug 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036102; cv=none; b=mqb7IlaNoaf2AHltTTT5fYnUc2MQ8bRccoT246o3iXhUSrAf8s1waicdU70VIDbAYsdX/SwKNmTV0CotPuV5+UPRbqoYvToi9N63JE4xEkRXkqpzuoTTuS1M1XWQnXziuD5j4093hAWO1iSyx/bD3H/oAHgPSf1MhdKIwJ+rosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036102; c=relaxed/simple;
	bh=YUKariCmlfVCxX2JHHjkResiD6JNgD6M4hXa3h5e0FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtOdFBwmDtNgQN4z3OyzbFEeEBjNnS01OR/oK3azf8EKdF6DyJhUI9bp6prr4PtfrAbRNELSuDkyoyTIroTCcoLwQsGjPSfaFYQD2/k4zVrEmoXEsZUvnaKr7EC/i2BJ7s2zynTdAlE3JRP2+pi2L6dosArRQ1Y41swN4t4KW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C59t0xkK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036100; x=1756572100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUKariCmlfVCxX2JHHjkResiD6JNgD6M4hXa3h5e0FA=;
  b=C59t0xkKda7/iFfllRmr6u0FAlecNN3oof9PohTuulQnVXqKyrv3nFiq
   +mCEe+SPG0LmVUCORALN5rBc1bEMYT3yYD7QD4XT6Cw1FfQoKxnP+MUyL
   Ul+hzT8UArfK627/9wR/tXdcU9PC7QlciSI5AM6tw7+k959Dhg10CrH/g
   YtyRC3EIYb7H3kaqLHTEgRv1BGPwvkxVaD5YA9rniytmys+k5nXOavxSE
   XcMXatmYyiATqUO/hhgO5AVTH909+yoUUBklgQ3i1L39CgRewE0WaCpKr
   EzppeGeR/z4hb3LTto3ujiPqioxGT3iiUbrA74Qq5ol2fmxE8Flws0p9v
   g==;
X-CSE-ConnectionGUID: bPNPjF2OSoC/phbSeVDeOQ==
X-CSE-MsgGUID: LkVxBFFkRLKTS1JGPoyXlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300029"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300029"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: kFxoRvDKQlqtdLTpIGtf4g==
X-CSE-MsgGUID: w/LfNAl2RnmoZVGifFjhzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440491"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:53 -0700
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
Subject: [PATCH v17 13/16] x86/sgx: Revise global reclamation for EPC cgroups
Date: Fri, 30 Aug 2024 09:40:34 -0700
Message-ID: <20240830164038.39343-14-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830164038.39343-1-haitao.huang@linux.intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
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
sgx_cgroup_reclaim_pages() passing in the root cgroup.  The wrapper will
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
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V17:
- Add comments in sgx_can_reclaim_global(). (Kai)
- Remove inaccurate comments in commit msg. (Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 12 ++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  2 ++
 arch/x86/kernel/cpu/sgx/main.c       | 14 ++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 7394f78dec49..c85ec1a6ebf0 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -255,6 +255,18 @@ void sgx_cgroup_reclaim_direct(void)
 	sgx_put_cg(sgx_cg);
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
index a530c9611332..08cee70d975d 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -36,6 +36,7 @@ static inline int __init sgx_cgroup_wq_init(void)
 static inline void __init sgx_cgroup_wq_deinit(void) { }
 
 static inline void sgx_cgroup_reclaim_direct(void) { }
+static inline void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm) { }
 
 #else /* CONFIG_CGROUP_MISC */
 
@@ -89,6 +90,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 void sgx_cgroup_reclaim_direct(void);
+void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
 void __init sgx_cgroup_init(void);
 int __init sgx_cgroup_wq_init(void);
 void __init sgx_cgroup_wq_deinit(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6f293115b75e..24dbcbc0f596 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -42,6 +42,13 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
  */
 static inline bool sgx_can_reclaim_global(void)
 {
+	/*
+	 * Now all EPC pages are still tracked in the @sgx_global_lru, so only
+	 * check @sgx_global_lru.
+	 *
+	 * When EPC pages are tracked in the actual per-cgroup LRUs,
+	 * replace with sgx_cgroup_lru_empty(misc_cg_root()).
+	 */
 	return !list_empty(&sgx_global_lru.reclaimable);
 }
 
@@ -404,6 +411,13 @@ static bool sgx_should_reclaim_global(unsigned long watermark)
 
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


