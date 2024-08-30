Return-Path: <cgroups+bounces-4641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D63966736
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B82B250A6
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B751BF310;
	Fri, 30 Aug 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nm9BrIb+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E51BE226;
	Fri, 30 Aug 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036105; cv=none; b=uTmj1dKrQ3KzKic0XL4lrzVvzZ83aHFIm7EP1ETIrDtF9sqN0UA8vGbxv/fQ5YD5LAVegurMaFapbBiHDTYUtBOjSr7vpVNrDur3LSQgJu3SOAN3MBlVaxHfzyhasUqFZqKjDs2wfr4W7C0k9N0wxhu5MFWd2sTYPFAlxhdRS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036105; c=relaxed/simple;
	bh=HW08YzCMbDUlzWibsu2BQT7zCWQmJ38zDrn1Sj5hFek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuSpDlUlWezjrRLau70zEKqKjb3t/Ks2AJYsIc9zYj/7qyj0N9RMYZvZ87uHSWdrg+sZCv5tFydNcg1r3ZBHzI5ICPiJ6U7FvtDMs6FXzJmsTONXWd2jERaB+gAT8DrVoyHn5Gjzrusu1KZQnp5K2k0ha7JnI0pJpv89EBYWyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nm9BrIb+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036103; x=1756572103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HW08YzCMbDUlzWibsu2BQT7zCWQmJ38zDrn1Sj5hFek=;
  b=Nm9BrIb+b3oN3BQ71Gffuuj+w/TKKKHaBeDTsPFmVlMhHhPUViim+ncD
   QlrJWjANYhDvq4Hf2EpshRlzUtwQl63j64keN4MYEWhyQ9q42AeW4rPmh
   0sQl5Nw5eDrtHsCI8LCLd0eSc+oPKjeo6JhXTtmHzDm26gsl37zZjlsCK
   3fVr4pwnpECDHf/7xtRA9n40axLm0GLUP45C/jJp5RlkgTso1f4sa48Ms
   BB32L8CRIJno4n6WamI32HJSpUJSuMhtvRiyz2JSugHfi8djhfg/r+ctg
   7h2VN2kzkpB2indG8yFa/FNBPeq1D0RxpvsS7uAoBZDpM4d0NLN54zlOH
   g==;
X-CSE-ConnectionGUID: tWayIOc+Tz+yk1em0JXupQ==
X-CSE-MsgGUID: BKKg3dMPSXqzJ96HTVQAaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300082"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:53 -0700
X-CSE-ConnectionGUID: TPFkUI+ITH2jiQyafg6qrA==
X-CSE-MsgGUID: 5OkrLE2qQ0Sf0F7vOEFmtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440494"
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
Subject: [PATCH v17 14/16] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Fri, 30 Aug 2024 09:40:35 -0700
Message-ID: <20240830164038.39343-15-haitao.huang@linux.intel.com>
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

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Previous patches have implemented all infrastructure needed for
per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
pages are still tracked in the global LRU as sgx_epc_page_lru() always
returns reference to the global LRU.

Change sgx_epc_page_lru() to return the LRU of the cgroup in which the
given EPC page is allocated.

Update sgx_can_reclaim_global(), to check emptiness of LRUs of all
cgroups, and update sgx_reclaim_pages_global(), to utilize
sgx_cgroup_reclaim_pages_global(), when EPC cgroup is enabled.

With these changes, the global reclamation and per-cgroup reclamation
both work properly with all pages tracked in per-cgroup LRUs.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
V16:
- Separated out the global and direct reclamation to earlier patch.(Kai)

V14:
- Update global reclamation to use the new sgx_cgroup_reclaim_pages() to
iterate cgroups at lower level if the top cgroups are too busy.

V13:
- Use IS_ENABLED(CONFIG_CGROUP_MISC) in sgx_can_reclaim_global(). (Kai)

V12:
- Remove CONFIG_CGROUP_SGX_EPC, conditional compile SGX Cgroup for
CONFIGCONFIG_CGROUPMISC. (Jarkko)

V11:
- Reword the comments for global reclamation for allocation failure
after passing cgroup charging. (Kai)
- Add stub functions to remove ifdefs in c file (Kai)
- Add more detailed comments to clarify each page belongs to one cgroup, or the
root. (Kai)

V10:
- Add comment to clarify each page belongs to one cgroup, or the root by
default. (Kai)
- Merge the changes that expose sgx_cgroup_* functions to this patch.
- Add changes for sgx_reclaim_direct() that was missed previously.

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  2 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  6 ++++
 arch/x86/kernel/cpu/sgx/main.c       | 45 ++++++++++++++++++----------
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index c85ec1a6ebf0..af6e4dfbf1af 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -162,7 +162,7 @@ static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
  *
  * Return: %true if all cgroups under the specified root have empty LRU lists.
  */
-static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+bool sgx_cgroup_lru_empty(struct misc_cg *root)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 08cee70d975d..ddc0e7bd8ce3 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -27,6 +27,11 @@ static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_recl
 
 static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
 
+static inline bool sgx_cgroup_lru_empty(struct misc_cg *root)
+{
+	return true;
+}
+
 static inline void __init sgx_cgroup_init(void) { }
 static inline int __init sgx_cgroup_wq_init(void)
 {
@@ -89,6 +94,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+bool sgx_cgroup_lru_empty(struct misc_cg *root);
 void sgx_cgroup_reclaim_direct(void);
 void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
 void __init sgx_cgroup_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 24dbcbc0f596..ec6c068aaf5d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -32,9 +32,30 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+/*
+ * Get the per-cgroup or global LRU list that tracks the given reclaimable page.
+ */
 static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc_page)
 {
+#ifdef CONFIG_CGROUP_MISC
+	/*
+	 * epc_page->sgx_cg here is never NULL during a reclaimable epc_page's
+	 * life between sgx_alloc_epc_page() and sgx_free_epc_page():
+	 *
+	 * In sgx_alloc_epc_page(), epc_page->sgx_cg is set to the return from
+	 * sgx_get_current_cg() which is the misc cgroup of the current task, or
+	 * the root by default even if the misc cgroup is disabled by kernel
+	 * command line.
+	 *
+	 * epc_page->sgx_cg is only unset by sgx_free_epc_page().
+	 *
+	 * This function is never used before sgx_alloc_epc_page() or after
+	 * sgx_free_epc_page().
+	 */
+	return &epc_page->sgx_cg->lru;
+#else
 	return &sgx_global_lru;
+#endif
 }
 
 /*
@@ -42,14 +63,10 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
  */
 static inline bool sgx_can_reclaim_global(void)
 {
-	/*
-	 * Now all EPC pages are still tracked in the @sgx_global_lru, so only
-	 * check @sgx_global_lru.
-	 *
-	 * When EPC pages are tracked in the actual per-cgroup LRUs,
-	 * replace with sgx_cgroup_lru_empty(misc_cg_root()).
-	 */
-	return !list_empty(&sgx_global_lru.reclaimable);
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
+		return !sgx_cgroup_lru_empty(misc_cg_root());
+	else
+		return !list_empty(&sgx_global_lru.reclaimable);
 }
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
@@ -411,14 +428,10 @@ static bool sgx_should_reclaim_global(unsigned long watermark)
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
-	/*
-	 * Now all EPC pages are still tracked in the @sgx_global_lru.
-	 * Still reclaim from it.
-	 *
-	 * When EPC pages are tracked in the actual per-cgroup LRUs,
-	 * sgx_cgroup_reclaim_pages_global() will be called.
-	 */
-	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
+		sgx_cgroup_reclaim_pages_global(charge_mm);
+	else
+		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
 /*
-- 
2.43.0


