Return-Path: <cgroups+bounces-2208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86AF88F394
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AD22A2364
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74DF2C1A9;
	Thu, 28 Mar 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ex/suwHI"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249C25761;
	Thu, 28 Mar 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585371; cv=none; b=IJOhu6hFZOA6Y1/xLUOhxK7UKfg8HK4MZVJDOnEu0qJPvpuOBzFboHndMmop7g9PdX07cCn622+rCl2xtthZ4ps+XeTdok4jBVzbzU2tcXbl/S9n5UyzE8TMTNbycwFKi0zEOIkALT2LjiIrvUEh/zZAKBb2frzJQHphL6tS92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585371; c=relaxed/simple;
	bh=gnJd8Sek1bYmfxijFNiS01CCdkjnlFiVLY0leIcO10I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhWyWoBrMlxFX3e4XSWa8fsiyzmImN6/wgvqLmfsRma1pLN88+HxkUyu45nt7mchrWkXd+v3/0dc03PYdWzmzehJI8Rs66Gy1Q5qf57nUK4NWU5r4A5b7Tpmjm3MrDM5Sbem/Z5oZ1yzBc2yxA3kQ5Qozhf8wYB8hxwpGpvgGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ex/suwHI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711585369; x=1743121369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gnJd8Sek1bYmfxijFNiS01CCdkjnlFiVLY0leIcO10I=;
  b=ex/suwHIi3G5bEe9N0iT91oDb/9VhTjB8LLD9tLDusFtBHno6adEVt2B
   WZ0Im560ePhcUY1fYkifofhHGrlMmIQIQygtj8mdQcKZj6icG/IN63eei
   +zB1PZUKEv3rvugT7xUtdOhWaTC8PBa4LliWTa1N0GgTmI++Bj2luBjuH
   CIuyCL3ld9XIYi47I4cdUccf2TRUzYJOmNRr2dpERpXekXxDmVyqppD2q
   WmLq/wpJQyqe/4vc+xFFlA3ISPGxzDWInLQ0ukBKPmMIEsEDC1kBhV7p0
   DoR4YRo72E6vXd21i0hDq7YFhYHwdT/RJUIB3djr8xYpP5//JJvilPxIk
   A==;
X-CSE-ConnectionGUID: 1z9gXznrRYSOolGwc8zTmg==
X-CSE-MsgGUID: vrxni3LlToaKn85aZCiAiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6580710"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6580710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16411808"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2024 17:22:31 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
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
Subject: [PATCH v10 09/14] x86/sgx: Implement async reclamation for cgroup
Date: Wed, 27 Mar 2024 17:22:24 -0700
Message-Id: <20240328002229.30264-10-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328002229.30264-1-haitao.huang@linux.intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

In cases EPC pages need be allocated during a page fault and the cgroup
usage is near its limit, an asynchronous reclamation needs be triggered
to avoid blocking the page fault handling.

Create a workqueue, corresponding work item and function definitions
for EPC cgroup to support the asynchronous reclamation.

In case the workqueue allocation is failed during init, disable cgroup.

In sgx_cgroup_try_charge(), if caller does not allow synchronous
reclamation, queue an asynchronous work into the workqueue.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V10:
- Split asynchronous flow in separate patch. (Kai)
- Consider cgroup disabled when the workqueue allocation fail during
init. (Kai)
- Abstract out sgx_cgroup_should_reclaim().

V9:
- Add comments for static variables. (Jarkko)

V8:
- Remove alignment for substructure variables. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 134 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   1 +
 arch/x86/kernel/cpu/sgx/main.c       |   8 +-
 3 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index f7a487a29ed1..3ca89b1fb7e2 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -5,9 +5,63 @@
 #include <linux/kernel.h>
 #include "epc_cgroup.h"
 
+/*
+ * The minimal free pages maintained by per-cgroup reclaimer
+ * Set this to the low threshold used by the global reclaimer, ksgxd.
+ */
+#define SGX_CG_MIN_FREE_PAGE	(SGX_NR_LOW_PAGES)
+
+/*
+ * If the cgroup limit is close to SGX_CG_MIN_FREE_PAGE, maintaining the minimal
+ * free pages would barely leave any page for use, causing excessive reclamation
+ * and thrashing.
+ *
+ * Define the following limit, below which cgroup does not maintain the minimal
+ * free page threshold. Set this to quadruple of the minimal so at least 75%
+ * pages used without being reclaimed.
+ */
+#define SGX_CG_LOW_LIMIT	(SGX_CG_MIN_FREE_PAGE * 4)
+
 /* The root SGX EPC cgroup */
 static struct sgx_cgroup sgx_cg_root;
 
+/*
+ * The work queue that reclaims EPC pages in the background for cgroups.
+ *
+ * A cgroup schedules a work item into this queue to reclaim pages within the
+ * same cgroup when its usage limit is reached and synchronous reclamation is not
+ * an option, i.e., in a page fault handler.
+ */
+static struct workqueue_struct *sgx_cg_wq;
+
+static inline u64 sgx_cgroup_page_counter_read(struct sgx_cgroup *sgx_cg)
+{
+	return atomic64_read(&sgx_cg->cg->res[MISC_CG_RES_SGX_EPC].usage) / PAGE_SIZE;
+}
+
+static inline u64 sgx_cgroup_max_pages(struct sgx_cgroup *sgx_cg)
+{
+	return READ_ONCE(sgx_cg->cg->res[MISC_CG_RES_SGX_EPC].max) / PAGE_SIZE;
+}
+
+/*
+ * Get the lower bound of limits of a cgroup and its ancestors. Used in
+ * sgx_cgroup_should_reclaim() to determine if EPC usage of a cgroup is
+ * close to its limit or its ancestors' hence reclamation is needed.
+ */
+static inline u64 sgx_cgroup_max_pages_to_root(struct sgx_cgroup *sgx_cg)
+{
+	struct misc_cg *i = sgx_cg->cg;
+	u64 m = U64_MAX;
+
+	while (i) {
+		m = min(m, READ_ONCE(i->res[MISC_CG_RES_SGX_EPC].max));
+		i = misc_cg_parent(i);
+	}
+
+	return m / PAGE_SIZE;
+}
+
 /**
  * sgx_cgroup_lru_empty() - check if a cgroup tree has no pages on its LRUs
  * @root:	Root of the tree to check
@@ -99,6 +153,61 @@ static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
 	rcu_read_unlock();
 }
 
+/**
+ * sgx_cgroup_should_reclaim() - check if EPC reclamation is needed for a cgroup
+ * @sgx_cg: The cgroup to be checked.
+ *
+ * This function can be used to guard a call to sgx_cgroup_reclaim_pages() where
+ * the minimal number of free page needs be maintained for the cgroup to make
+ * good forward progress.
+ *
+ * Return: %true if number of free pages available for the cgroup below a
+ * threshold (%SGX_CG_MIN_FREE_PAGE) and there are reclaimable pages within the
+ * cgroup.
+ */
+static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
+{
+	u64 cur, max;
+
+	if (sgx_cgroup_lru_empty(sgx_cg->cg))
+		return false;
+
+	max = sgx_cgroup_max_pages_to_root(sgx_cg);
+
+	/*
+	 * Unless the limit is very low, maintain a minimal number of free pages
+	 * so there is always a few pages available to serve new allocation
+	 * requests quickly.
+	 */
+	if (max > SGX_CG_LOW_LIMIT)
+		max -= SGX_CG_MIN_FREE_PAGE;
+
+	cur = sgx_cgroup_page_counter_read(sgx_cg);
+
+	return (cur >= max);
+}
+
+/*
+ * Asynchronous work flow to reclaim pages from the cgroup when the cgroup is
+ * at/near its maximum capacity.
+ */
+static void sgx_cgroup_reclaim_work_func(struct work_struct *work)
+{
+	struct sgx_cgroup *sgx_cg = container_of(work, struct sgx_cgroup, reclaim_work);
+
+	/*
+	 * This work func is scheduled by sgx_cgroup_try_charge() when it cannot
+	 * directly reclaim, i.e., EPC allocation in a fault handler. Waiting to
+	 * reclaim until the cgroup is actually at its limit is less performant,
+	 * as it means the task scheduling this asynchronous work is effectively
+	 * blocked until a worker makes its way through the global work queue.
+	 */
+	while (sgx_cgroup_should_reclaim(sgx_cg)) {
+		sgx_cgroup_reclaim_pages(sgx_cg->cg);
+		cond_resched();
+	}
+}
+
 static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
 {
 	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
@@ -125,14 +234,24 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
 	int ret;
 
+	/* cgroup disabled due to wq allocation failure during sgx_cgroup_init(). */
+	if (!sgx_cg_wq)
+		return 0;
+
+	/* Should not happen if the wq is allocated and SGX cgroup initialized properly. */
+	if (WARN_ON_ONCE(!sgx_cg))
+		return 0;
+
 	for (;;) {
 		ret = __sgx_cgroup_try_charge(sgx_cg);
 
 		if (ret != -EBUSY)
 			return ret;
 
-		if (reclaim == SGX_NO_RECLAIM)
-			return -ENOMEM;
+		if (reclaim == SGX_NO_RECLAIM) {
+			queue_work(sgx_cg_wq, &sgx_cg->reclaim_work);
+			return -EBUSY;
+		}
 
 		sgx_cgroup_reclaim_pages(sgx_cg->cg);
 		cond_resched();
@@ -147,7 +266,8 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
  */
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg)
 {
-	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
+	if (sgx_cg)
+		misc_cg_uncharge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
 }
 
 static void sgx_cgroup_free(struct misc_cg *cg)
@@ -158,6 +278,7 @@ static void sgx_cgroup_free(struct misc_cg *cg)
 	if (!sgx_cg)
 		return;
 
+	cancel_work_sync(&sgx_cg->reclaim_work);
 	kfree(sgx_cg);
 }
 
@@ -171,6 +292,7 @@ const struct misc_res_ops sgx_cgroup_ops = {
 static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
 {
 	sgx_lru_init(&sgx_cg->lru);
+	INIT_WORK(&sgx_cg->reclaim_work, sgx_cgroup_reclaim_work_func);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
 	sgx_cg->cg = cg;
 }
@@ -190,6 +312,12 @@ static int sgx_cgroup_alloc(struct misc_cg *cg)
 
 void sgx_cgroup_init(void)
 {
+	sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE, WQ_UNBOUND_MAX_ACTIVE);
+
+	/* All Cgroups functionalities are disabled. */
+	if (WARN_ON(!sgx_cg_wq))
+		return;
+
 	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
 	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
 }
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index f62dce0cac51..f66570d3ef42 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -32,6 +32,7 @@ static inline void sgx_cgroup_init(void) { }
 struct sgx_cgroup {
 	struct misc_cg *cg;
 	struct sgx_epc_lru_list lru;
+	struct work_struct reclaim_work;
 };
 
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index aaf341abc641..9f6594317ce4 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -650,11 +650,9 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	struct sgx_numa_node *node = section->node;
 
 #ifdef CONFIG_CGROUP_SGX_EPC
-	if (page->sgx_cg) {
-		sgx_cgroup_uncharge(page->sgx_cg);
-		sgx_put_cg(page->sgx_cg);
-		page->sgx_cg = NULL;
-	}
+	sgx_cgroup_uncharge(page->sgx_cg);
+	sgx_put_cg(page->sgx_cg);
+	page->sgx_cg = NULL;
 #endif
 
 	spin_lock(&node->lock);
-- 
2.25.1


