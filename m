Return-Path: <cgroups+bounces-3204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D690AE57
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FD8B24FB0
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB6197A61;
	Mon, 17 Jun 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AG9OePGa"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8841990BB;
	Mon, 17 Jun 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628829; cv=none; b=LGAsxAiTkVm7AOztIzZfFny0dxzhQWI1yF5YICpkIQQ1Mm3zRDLlAoXvA975BgzfS2LAF+g8G4/IC8TkgT/QtiNvyIalgsygKpgt3zOVKQkMIfaQj2F8Ixc6FLkZNbj2L0LOB/aGDRr7CLlxAUNa/jEAPOU6PkzyhvBwjnq0kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628829; c=relaxed/simple;
	bh=eL+sH+CT4pmUEI/qpckfiAXaMLZfUhrtHmESnQ8hdX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx0OEeCuiWSGGOMElxvIRxik/WqWkK1J/kVxulw0H+mbMEDiLgNwmTsPpKlOY3xHGoHCgFUlJvcuSQd64K8AI39YbzwkQ1VF8m0LT/OUgB+k1CsB3IUyDS7snvJyyJc6UOi5SgkVxaziy0yuGJOkO+lU3Pmx1wLRkbmiMweDNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AG9OePGa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628827; x=1750164827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eL+sH+CT4pmUEI/qpckfiAXaMLZfUhrtHmESnQ8hdX8=;
  b=AG9OePGaAOoWvBBWM9KAnzxgrV0nxIeLY89UeAh/9M56+WrOa7QRJdsc
   o4uOHXrqdj6+4QgyDOKzcRjobkFZd8JBZ1+PxRDGIzw8VUWKByR5DDU5D
   QGBb7hjTryZqESuFEa32mPUTUhl4qBeMsTtWtfD3y2H7JyoPDWqejIInf
   pm2XFZb/L/BgwK5nkONSTYp9BcW+D8xPVUlYdd5KNhTR9bmWlpJW7WLPC
   mBXP3/T7U1/RMVvPGnuUDAVVqvDgWa0IopZ5/cwsKxMLnt1sb4/D++DqO
   trqrmhm6weIVOpddjGmBDqNzbKPVQbAlZPHWg4/+zGN5Ksk6S+1OVb3k3
   A==;
X-CSE-ConnectionGUID: rX2nXzCnQrWH0vt9PBNX2Q==
X-CSE-MsgGUID: kIRly26DR2ONsMkr/Y5Z2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570951"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570951"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:44 -0700
X-CSE-ConnectionGUID: k57wfwH0TCiMRnjAUk4NBA==
X-CSE-MsgGUID: SQVruJD+T/mZQ4xRBoDhKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387568"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:43 -0700
From: "Huang, Haitao" <haitao.huang@linux.intel.com>
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
Subject: [PATCH v15 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Mon, 17 Jun 2024 05:53:19 -0700
Message-ID: <20240617125321.36658-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617125321.36658-1-haitao.huang@linux.intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
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

This makes all EPC pages tracked in per-cgroup LRUs and the global
reclaimer (ksgxd) will not be able to reclaim any pages from the global
LRU. However, in cases of over-committing, i.e., the sum of cgroup
limits greater than the total capacity, cgroups may never reclaim but
the total usage can still be near the capacity. Therefore a global
reclamation is still needed in those cases and it should be performed
from the root cgroup.

Modify sgx_reclaim_pages_global(), to reclaim from the root EPC cgroup
when cgroup is enabled. Similar to sgx_cgroup_reclaim_pages(), return
the next cgroup so callers can use it as the new starting node for next
round of reclamation if needed.

Also update sgx_can_reclaim_global(), to check emptiness of LRUs of all
cgroups when EPC cgroup is enabled, otherwise only check the global LRU.

Finally, change sgx_reclaim_direct(), to check and ensure there are free
pages at cgroup level so forward progress can be made by the caller.

With these changes, the global reclamation and per-cgroup reclamation
both work properly with all pages tracked in per-cgroup LRUs.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  8 +--
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 32 +++++++++++
 arch/x86/kernel/cpu/sgx/main.c       | 80 +++++++++++++++++++++++++---
 3 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index ec7f267d3e7a..04d156848cf1 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -67,7 +67,7 @@ static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
  *
  * Return: %true if all cgroups under the specified root have empty LRU lists.
  */
-static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+bool sgx_cgroup_lru_empty(struct misc_cg *root)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
@@ -127,8 +127,8 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
  * release the reference if the returned is not used as %start for a subsequent
  * call.
  */
-static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct misc_cg *start,
-						struct mm_struct *charge_mm)
+struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct misc_cg *start,
+					 struct mm_struct *charge_mm)
 {
 	struct cgroup_subsys_state *css_root, *pos;
 	struct cgroup_subsys_state *next = NULL;
@@ -181,7 +181,7 @@ static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mis
  * threshold (%SGX_CG_MIN_FREE_PAGE) and there are reclaimable pages within the
  * cgroup.
  */
-static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
 {
 	u64 cur, max;
 
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 2f4ed046b1b5..4601cd507eaf 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -13,6 +13,11 @@
 #define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
 struct sgx_cgroup;
 
+static inline struct misc_cg *misc_from_sgx(struct sgx_cgroup *sgx_cg)
+{
+	return NULL;
+}
+
 static inline struct sgx_cgroup *sgx_get_current_cg(void)
 {
 	return NULL;
@@ -27,8 +32,25 @@ static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_recl
 
 static inline void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg) { }
 
+static inline bool sgx_cgroup_lru_empty(struct misc_cg *root)
+{
+	return true;
+}
+
+static inline bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+{
+	return false;
+}
+
 static inline void sgx_cgroup_init(void) { }
 
+static inline struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root,
+						       struct misc_cg *next_cg,
+						       struct mm_struct *charge_mm)
+{
+	return NULL;
+}
+
 #else /* CONFIG_CGROUP_MISC */
 
 struct sgx_cgroup {
@@ -37,6 +59,11 @@ struct sgx_cgroup {
 	struct work_struct reclaim_work;
 };
 
+static inline struct misc_cg *misc_from_sgx(struct sgx_cgroup *sgx_cg)
+{
+	return sgx_cg->cg;
+}
+
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
 {
 	return (struct sgx_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
@@ -67,6 +94,11 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+bool sgx_cgroup_lru_empty(struct misc_cg *root);
+bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg);
+struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root,
+					 struct misc_cg *next_cg,
+					 struct mm_struct *charge_mm);
 int __init sgx_cgroup_init(void);
 
 #endif /* CONFIG_CGROUP_MISC */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e91fa5f5348d..894adf6922f8 100644
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
@@ -42,7 +63,10 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
  */
 static inline bool sgx_can_reclaim_global(void)
 {
-	return !list_empty(&sgx_global_lru.reclaimable);
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
+		return !sgx_cgroup_lru_empty(misc_cg_root());
+	else
+		return !list_empty(&sgx_global_lru.reclaimable);
 }
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
@@ -402,9 +426,14 @@ static bool sgx_should_reclaim_global(unsigned long watermark)
 		sgx_can_reclaim_global();
 }
 
-static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
+static struct misc_cg *sgx_reclaim_pages_global(struct misc_cg *next_cg,
+						struct mm_struct *charge_mm)
 {
+	if (IS_ENABLED(CONFIG_CGROUP_MISC))
+		return sgx_cgroup_reclaim_pages(misc_cg_root(), next_cg, charge_mm);
+
 	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
+	return NULL;
 }
 
 /*
@@ -414,12 +443,35 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
  */
 void sgx_reclaim_direct(void)
 {
+	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
+	struct misc_cg *cg = misc_from_sgx(sgx_cg);
+	struct misc_cg *next_cg = NULL;
+
+	/*
+	 * Make sure there are some free pages at both cgroup and global levels.
+	 * In both cases, only make one attempt of reclamation to avoid lengthy
+	 * block on the caller.
+	 */
+	if (sgx_cg && sgx_cgroup_should_reclaim(sgx_cg))
+		next_cg = sgx_cgroup_reclaim_pages(cg, next_cg, current->mm);
+
+	if (next_cg != cg)
+		put_misc_cg(next_cg);
+
+	next_cg = NULL;
 	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages_global(current->mm);
+		next_cg = sgx_reclaim_pages_global(next_cg, current->mm);
+
+	if (next_cg != misc_cg_root())
+		put_misc_cg(next_cg);
+
+	sgx_put_cg(sgx_cg);
 }
 
 static int ksgxd(void *p)
 {
+	struct misc_cg *next_cg = NULL;
+
 	set_freezable();
 
 	/*
@@ -437,11 +489,15 @@ static int ksgxd(void *p)
 				     kthread_should_stop() ||
 				     sgx_should_reclaim_global(SGX_NR_HIGH_PAGES));
 
-		if (sgx_should_reclaim_global(SGX_NR_HIGH_PAGES))
+		while (!kthread_should_stop() && sgx_should_reclaim_global(SGX_NR_HIGH_PAGES)) {
 			/* Indirect reclaim, no mm to charge, so NULL: */
-			sgx_reclaim_pages_global(NULL);
+			next_cg = sgx_reclaim_pages_global(next_cg, NULL);
+			cond_resched();
+		}
 
-		cond_resched();
+		if (next_cg != misc_cg_root())
+			put_misc_cg(next_cg);
+		next_cg = NULL;
 	}
 
 	return 0;
@@ -583,6 +639,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  */
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 {
+	struct misc_cg *next_cg = NULL;
 	struct sgx_cgroup *sgx_cg;
 	struct sgx_epc_page *page;
 	int ret;
@@ -616,10 +673,19 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages_global(current->mm);
+		/*
+		 * At this point, the usage within this cgroup is under its
+		 * limit but there is no physical page left for allocation.
+		 * Perform a global reclaim to get some pages released from any
+		 * cgroup with reclaimable pages.
+		 */
+		next_cg = sgx_reclaim_pages_global(next_cg, current->mm);
 		cond_resched();
 	}
 
+	if (next_cg != misc_cg_root())
+		put_misc_cg(next_cg);
+
 	if (!IS_ERR(page)) {
 		WARN_ON_ONCE(sgx_epc_page_get_cgroup(page));
 		/* sgx_put_cg() in sgx_free_epc_page() */
-- 
2.43.0


