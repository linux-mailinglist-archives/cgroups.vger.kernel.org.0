Return-Path: <cgroups+bounces-131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D67DBFBA
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F77B21154
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770E31A27E;
	Mon, 30 Oct 2023 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrqlDpG5"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406E1A589
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698169E;
	Mon, 30 Oct 2023 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690037; x=1730226037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7aYQKR9soC/IW9SQPYWpLsPWDLbgwW6uzudMrK7y0o=;
  b=FrqlDpG5x9EIYlM+17Ggw3lZmR82k95trqIElly5ZAsOtESv8ha6ktqi
   M4HTQVNAo9+Sc+8GmCsrQox7Orgnpe/3Da6ZPjAW4t1vgpxrJt7raHefl
   13byxcMbeT+DgHN1YOSSgnM7Hh94H7DdDxYfZeMy8Ll5K1kNqA9PJ8aRO
   ITQ8C9IKXuyK513evVts7JhE0on3wRD9m7GCAP6jcZuIthatYI2NjOaYT
   Rfg5R90/RIPndPuCcrQFFh4LDoT5ob+4Zl/vMkCDiPzPbE3hyhQcDC+Lh
   JUaxVvsrD/W04YEUqdhrZf0I7aBjcgQmiiknWNx3EKVdb1UoIA2vWZd4Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479627"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479627"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529531"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529531"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:30 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
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
	sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	Sean Christopherson <sean.j.christopherson@intel.com>,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 10/12] x86/sgx: Implement EPC reclamation for cgroup
Date: Mon, 30 Oct 2023 11:20:11 -0700
Message-Id: <20231030182013.40086-11-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Currently all reclaimable pages are tracked only in the global LRU list,
and only the global reclaimer(ksgxd) performs reclamation when the
global free page counts are lower than a threshold. When a cgroup limit
is reached, cgroup need also try to reclaim pages allocated within the
group. This patch enables per-cgroup reclamation.

Add a helper function sgx_lru_list(), that for a given EPC page, returns
the LRU list of the cgroup that is assigned to the EPC page at
allocation time. This helper is used to replace the hard coded global
LRU wherever appropriate: modify sgx_mark/unmark_page_reclaimable() to
track EPCs in the LRU list of the appropriate cgroup; modify
sgx_do_epc_reclamation() to return unreclaimed pages back to proper
cgroup.

Implement the reclamation flow for cgroup, encapsulated in the top-level
function sgx_epc_cgroup_reclaim_pages(). Just like the global reclaimer,
the cgroup reclaimer first isolates candidate pages for reclaim, then
invokes sgx_do_epc_reclamation(). The only difference is that a cgroup
does a pre-order walk on its subtree to scan for candidate pages from
its own LRU and LRUs in its descendants.

In some contexts, e.g. page fault handling, only asynchronous
reclamation is allowed. Create a workqueue, 'sgx_epc_cg_wq',
corresponding work item and function definitions to support the
asynchronous reclamation. Add a Boolean parameter for
sgx_epc_cgroup_try_charge() to indicate whether synchronous reclaim is
allowed or not. Both synchronous and asynchronous flows invoke the same
top level reclaim function, sgx_epc_cgroup_reclaim_pages().

All reclaimable pages are tracked in per-cgroup LRUs when cgroup is
enabled. Update the original global reclaimer to reclaim from the root
cgroup when cgroup is enabled, also calling
sgx_epc_cgroup_reclaim_pages().

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V6:
- Drop EPC OOM killer.(Dave, Michal)
- Patch restructuring: this includes part split from the patch, "Limit process EPC usage with
misc cgroup controller", and combined with "Prepare for multiple LRUs"
- Removed force reclamation ignoring 'youngness' of the pages
- Removed checking for capacity in reclamation loop.
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 224 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  19 ++-
 arch/x86/kernel/cpu/sgx/main.c       |  71 ++++++---
 3 files changed, 289 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 500627d0563f..110d44c0ef7c 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -5,6 +5,38 @@
 #include <linux/kernel.h>
 #include "epc_cgroup.h"
 
+#define SGX_EPC_RECLAIM_MIN_PAGES		16U
+
+static struct workqueue_struct *sgx_epc_cg_wq;
+
+static inline u64 sgx_epc_cgroup_page_counter_read(struct sgx_epc_cgroup *epc_cg)
+{
+	return atomic64_read(&epc_cg->cg->res[MISC_CG_RES_SGX_EPC].usage) / PAGE_SIZE;
+}
+
+static inline u64 sgx_epc_cgroup_max_pages(struct sgx_epc_cgroup *epc_cg)
+{
+	return READ_ONCE(epc_cg->cg->res[MISC_CG_RES_SGX_EPC].max) / PAGE_SIZE;
+}
+
+/*
+ * Get the lower bound of limits of a cgroup and its ancestors.  Used in
+ * sgx_epc_cgroup_reclaim_work_func() to determine if EPC usage of a cgroup is over its limit
+ * or its ancestors' hence reclamation is needed.
+ */
+static inline u64 sgx_epc_cgroup_max_pages_to_root(struct sgx_epc_cgroup *epc_cg)
+{
+	struct misc_cg *i = epc_cg->cg;
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
 static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct misc_cg *cg)
 {
 	return (struct sgx_epc_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
@@ -15,12 +47,188 @@ static inline bool sgx_epc_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(misc_cgrp_subsys);
 }
 
+/**
+ * sgx_epc_cgroup_lru_empty() - check if a cgroup tree has no pages on its LRUs
+ * @root:	root of the tree to check
+ *
+ * Return: %true if all cgroups under the specified root have empty LRU lists.
+ * Used to avoid livelocks due to a cgroup having a non-zero charge count but
+ * no pages on its LRUs, e.g. due to a dead enclave waiting to be released or
+ * because all pages in the cgroup are unreclaimable.
+ */
+bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
+{
+	struct cgroup_subsys_state *css_root;
+	struct cgroup_subsys_state *pos;
+	struct sgx_epc_cgroup *epc_cg;
+	bool ret = true;
+
+	/*
+	 * Caller ensure css_root ref acquired
+	 */
+	css_root = &root->css;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, css_root) {
+		if (!css_tryget(pos))
+			break;
+
+		rcu_read_unlock();
+
+		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
+
+		spin_lock(&epc_cg->lru.lock);
+		ret = list_empty(&epc_cg->lru.reclaimable);
+		spin_unlock(&epc_cg->lru.lock);
+
+		rcu_read_lock();
+		css_put(pos);
+		if (!ret)
+			break;
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/**
+ * sgx_epc_cgroup_isolate_pages() - walk a cgroup tree and scan LRUs to select pages for
+ * reclamation
+ * @root:	root of the tree to start walking
+ * @nr_to_scan: The number of pages to scan
+ * @dst:	Destination list to hold the isolated pages
+ */
+void sgx_epc_cgroup_isolate_pages(struct misc_cg *root,
+				  unsigned int nr_to_scan, struct list_head *dst)
+{
+	struct cgroup_subsys_state *css_root;
+	struct cgroup_subsys_state *pos;
+	struct sgx_epc_cgroup *epc_cg;
+
+	if (!nr_to_scan)
+		return;
+
+	 /* Caller ensure css_root ref acquired */
+	css_root = &root->css;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, css_root) {
+		if (!css_tryget(pos))
+			break;
+		rcu_read_unlock();
+
+		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
+		nr_to_scan = sgx_isolate_epc_pages(&epc_cg->lru, nr_to_scan, dst);
+
+		rcu_read_lock();
+		css_put(pos);
+		if (!nr_to_scan)
+			break;
+	}
+
+	rcu_read_unlock();
+}
+
+static unsigned int sgx_epc_cgroup_reclaim_pages(unsigned int nr_pages,
+						 struct misc_cg *root)
+{
+	LIST_HEAD(iso);
+	/*
+	 * Attempting to reclaim only a few pages will often fail and is inefficient, while
+	 * reclaiming a huge number of pages can result in soft lockups due to holding various
+	 * locks for an extended duration.
+	 */
+	nr_pages = max(nr_pages, SGX_EPC_RECLAIM_MIN_PAGES);
+	nr_pages = min(nr_pages, SGX_NR_TO_SCAN_MAX);
+	sgx_epc_cgroup_isolate_pages(root, nr_pages, &iso);
+
+	return sgx_do_epc_reclamation(&iso);
+}
+
+/*
+ * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the cgroup when the cgroup is
+ * at/near its maximum capacity
+ */
+static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
+{
+	struct sgx_epc_cgroup *epc_cg;
+	u64 cur, max;
+
+	epc_cg = container_of(work, struct sgx_epc_cgroup, reclaim_work);
+
+	for (;;) {
+		max = sgx_epc_cgroup_max_pages_to_root(epc_cg);
+
+		/*
+		 * Adjust the limit down by one page, the goal is to free up
+		 * pages for fault allocations, not to simply obey the limit.
+		 * Conditionally decrementing max also means the cur vs. max
+		 * check will correctly handle the case where both are zero.
+		 */
+		if (max)
+			max--;
+
+		/*
+		 * Unless the limit is extremely low, in which case forcing
+		 * reclaim will likely cause thrashing, force the cgroup to
+		 * reclaim at least once if it's operating *near* its maximum
+		 * limit by adjusting @max down by half the min reclaim size.
+		 * This work func is scheduled by sgx_epc_cgroup_try_charge
+		 * when it cannot directly reclaim due to being in an atomic
+		 * context, e.g. EPC allocation in a fault handler.  Waiting
+		 * to reclaim until the cgroup is actually at its limit is less
+		 * performant as it means the faulting task is effectively
+		 * blocked until a worker makes its way through the global work
+		 * queue.
+		 */
+		if (max > SGX_NR_TO_SCAN_MAX)
+			max -= (SGX_EPC_RECLAIM_MIN_PAGES / 2);
+
+		cur = sgx_epc_cgroup_page_counter_read(epc_cg);
+
+		if (cur <= max || sgx_epc_cgroup_lru_empty(epc_cg->cg))
+			break;
+
+		/* Keep reclaiming until above condition is met. */
+		sgx_epc_cgroup_reclaim_pages((unsigned int)(cur - max), epc_cg->cg);
+	}
+}
+
+static int __sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg,
+				       bool reclaim)
+{
+	for (;;) {
+		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
+					PAGE_SIZE))
+			break;
+
+		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
+			return -ENOMEM;
+
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+
+		if (!reclaim) {
+			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
+			return -EBUSY;
+		}
+
+		if (!sgx_epc_cgroup_reclaim_pages(1, epc_cg->cg))
+			/* All pages were too young to reclaim, try again */
+			schedule();
+	}
+
+	return 0;
+}
+
 /**
  * sgx_epc_cgroup_try_charge() - hierarchically try to charge a single EPC page
+ * @reclaim:		whether or not synchronous reclaim is allowed
  *
  * Returns EPC cgroup or NULL on success, -errno on failure.
  */
-struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
+struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(bool reclaim)
 {
 	struct sgx_epc_cgroup *epc_cg;
 	int ret;
@@ -29,12 +237,12 @@ struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
 		return NULL;
 
 	epc_cg = sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
-	ret = misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
+	ret = __sgx_epc_cgroup_try_charge(epc_cg, reclaim);
 
-	if (!ret) {
+	if (ret) {
 		/* No epc_cg returned, release ref from get_current_misc_cg() */
 		put_misc_cg(epc_cg->cg);
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(ret);
 	}
 
 	/* Ref released in sgx_epc_cgroup_uncharge() */
@@ -64,6 +272,7 @@ static void sgx_epc_cgroup_free(struct misc_cg *cg)
 	if (!epc_cg)
 		return;
 
+	cancel_work_sync(&epc_cg->reclaim_work);
 	kfree(epc_cg);
 }
 
@@ -82,6 +291,8 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
 	if (!epc_cg)
 		return -ENOMEM;
 
+	sgx_lru_init(&epc_cg->lru);
+	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
 	cg->res[MISC_CG_RES_SGX_EPC].misc_ops = &sgx_epc_cgroup_ops;
 	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
 	epc_cg->cg = cg;
@@ -95,6 +306,11 @@ static int __init sgx_epc_cgroup_init(void)
 	if (!boot_cpu_has(X86_FEATURE_SGX))
 		return 0;
 
+	sgx_epc_cg_wq = alloc_workqueue("sgx_epc_cg_wq",
+					WQ_UNBOUND | WQ_FREEZABLE,
+					WQ_UNBOUND_MAX_ACTIVE);
+	BUG_ON(!sgx_epc_cg_wq);
+
 	cg = misc_cg_root();
 	BUG_ON(!cg);
 
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index c3abfe82be15..ddc1b89f2805 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -16,20 +16,33 @@
 #define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
 struct sgx_epc_cgroup;
 
-static inline struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
+static inline struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(bool reclaim)
 {
 	return NULL;
 }
 
 static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg) { }
+
+static inline void sgx_epc_cgroup_isolate_pages(struct misc_cg *root,
+						unsigned int nr_to_scan,
+						struct list_head *dst) { }
+
+static bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
+{
+	return true;
+}
 #else
 struct sgx_epc_cgroup {
-	struct misc_cg *cg;
+	struct misc_cg			*cg;
+	struct sgx_epc_lru_list		lru;
+	struct work_struct		reclaim_work;
 };
 
-struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void);
+struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(bool reclaim);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
 bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
+void sgx_epc_cgroup_isolate_pages(struct misc_cg *root, unsigned int nr_to_scan,
+				  struct list_head *dst);
 
 #endif
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e8848b493eb7..c496b8f15b54 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -32,6 +32,31 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_list sgx_global_lru;
 
+#ifndef CONFIG_CGROUP_SGX_EPC
+static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
+#else
+static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_page)
+{
+	if (epc_page->epc_cg)
+		return &epc_page->epc_cg->lru;
+
+	/* This should not happen if kernel is configured correctly */
+	WARN_ON_ONCE(1);
+	return &sgx_global_lru;
+}
+#endif
+
+static inline bool sgx_can_reclaim(void)
+{
+	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		return !sgx_epc_cgroup_lru_empty(misc_cg_root());
+
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -342,6 +367,7 @@ unsigned int sgx_do_epc_reclamation(struct list_head *iso)
 	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
+	struct sgx_epc_lru_list *lru;
 	pgoff_t page_index;
 	size_t ret, i;
 
@@ -370,10 +396,11 @@ unsigned int sgx_do_epc_reclamation(struct list_head *iso)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
+		lru = sgx_lru_list(epc_page);
+		spin_lock(&lru->lock);
 		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
-		list_move_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		list_move_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 	}
@@ -397,9 +424,13 @@ unsigned int sgx_do_epc_reclamation(struct list_head *iso)
 
 static void sgx_reclaim_epc_pages_global(void)
 {
+	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
 	LIST_HEAD(iso);
 
-	sgx_isolate_epc_pages(&sgx_global_lru, SGX_NR_TO_SCAN, &iso);
+	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		sgx_epc_cgroup_isolate_pages(misc_cg_root(), nr_to_scan, &iso);
+	else
+		sgx_isolate_epc_pages(&sgx_global_lru, nr_to_scan, &iso);
 
 	sgx_do_epc_reclamation(&iso);
 }
@@ -407,7 +438,7 @@ static void sgx_reclaim_epc_pages_global(void)
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim();
 }
 
 /*
@@ -528,26 +559,26 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 }
 
 /**
- * sgx_mark_page_reclaimable() - Mark a page as reclaimable
+ * sgx_mark_page_reclaimable() - Mark a page as reclaimable and add it to an appropriate LRU
  * @page:	EPC page
  *
- * Mark a page as reclaimable and add it to the active page list. Pages
- * are automatically removed from the active list when freed.
  */
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_list *lru = sgx_lru_list(page);
+
+	spin_lock(&lru->lock);
 	WARN_ON_ONCE(sgx_epc_page_reclaimable(page->flags));
 	page->flags |= SGX_EPC_PAGE_RECLAIMABLE;
-	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
-	spin_unlock(&sgx_global_lru.lock);
+	list_add_tail(&page->list, &lru->reclaimable);
+	spin_unlock(&lru->lock);
 }
 
 /**
  * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
  * @page:	EPC page
  *
- * Clear the reclaimable flag and remove the page from the active page list.
+ * Clear the reclaimable flag if set and remove the page from its LRU.
  *
  * Return:
  *   0 on success,
@@ -555,15 +586,17 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
  */
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_list *lru = sgx_lru_list(page);
+
+	spin_lock(&lru->lock);
 	if (sgx_epc_page_reclaim_in_progress(page->flags)) {
-		spin_unlock(&sgx_global_lru.lock);
+		spin_unlock(&lru->lock);
 		return -EBUSY;
 	}
 
 	list_del(&page->list);
 	sgx_epc_page_reset_state(page);
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	return 0;
 }
@@ -590,7 +623,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 	struct sgx_epc_page *page;
 	struct sgx_epc_cgroup *epc_cg;
 
-	epc_cg = sgx_epc_cgroup_try_charge();
+	epc_cg = sgx_epc_cgroup_try_charge(reclaim);
 	if (IS_ERR(epc_cg))
 		return ERR_CAST(epc_cg);
 
@@ -601,8 +634,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable))
-			return ERR_PTR(-ENOMEM);
+		if (!sgx_can_reclaim()) {
+			page = ERR_PTR(-ENOMEM);
+			break;
+		}
 
 		if (!reclaim) {
 			page = ERR_PTR(-EBUSY);
-- 
2.25.1


