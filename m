Return-Path: <cgroups+bounces-1359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D072284A865
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03141C27D99
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BD1487FA;
	Mon,  5 Feb 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU1Srz3E"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1E145331;
	Mon,  5 Feb 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167209; cv=none; b=IQsCtQRJxCiPqFyuIN0TFtx8S8daG2Dfavg3Cq2Mbz9ppZ1qnrsOxH6FUXahq/4ndVMiKREmLG9b8ZL0mQR49BNadqEuCBcQdfuiGyegdMQcoKDycrhMG08yWjEoPiVB1HFwPJissLWC/WfdMhdOgNJ3XnlPMatTe3bX2T423+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167209; c=relaxed/simple;
	bh=eUN2BjJJ5PxF/WozfC0mPnA7u1ZdTF/IwnovnwBHmEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KveSYXHhvGbwTrLNLJpVO2K3x4JSkqlBSD14+sbq+kgfjjwS4PWr/Fy4Eh5qhIu/+LShjwtBWL9iIR64YPcx5C7BvuPVenSTbn+AUXQJAmkYQglwPofK+O8RiLKf5EgniDvu+2EBeOodIRDLPkBjDDywZnxg+dzkR4jtjiNkksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU1Srz3E; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167207; x=1738703207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eUN2BjJJ5PxF/WozfC0mPnA7u1ZdTF/IwnovnwBHmEg=;
  b=BU1Srz3Eo3BLc/dR6SpnzRN0CKH4dbuyMgq/Ijbsko8cZJJ5eN7AatDn
   THhYm5vUx5EDOfsz85ZML0lnTDSLxEp9Sh6F86UKu8VPoW6xkl05xM/OR
   EcTJRZVUZvYH2B8q/FVgHZiLImKeuizZA1+Luee2SuZN4dwV3g92Q2BDU
   G0HvEKFyD1Zuo/1a96dCuhH8hI+r7JCtz5Rlw/MXg8npOZQ3CfdCNNDcQ
   cYWvvT7zOVQCczYKyErCQFRZuz/iwO/SrfDrqDzLidukrgCo5u8jKs3o2
   nQPeoM25/lNtA7ox58F53i/VBCDcEmbI4R4n/+obahU+l0m2gUQmQpVdG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960432"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960432"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245634"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:41 -0800
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
Subject: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for cgroup
Date: Mon,  5 Feb 2024 13:06:31 -0800
Message-Id: <20240205210638.157741-9-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210638.157741-1-haitao.huang@linux.intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Implement the reclamation flow for cgroup, encapsulated in the top-level
function sgx_epc_cgroup_reclaim_pages(). It does a pre-order walk on its
subtree, and make calls to sgx_reclaim_pages() at each node passing in
the LRU of that node. It keeps track of total reclaimed pages, and pages
left to attempt.  It stops the walk if desired number of pages are
attempted.

In some contexts, e.g. page fault handling, only asynchronous
reclamation is allowed. Create a work-queue, corresponding work item and
function definitions to support the asynchronous reclamation. Both
synchronous and asynchronous flows invoke the same top level reclaim
function, and will be triggered later by sgx_epc_cgroup_try_charge()
when usage of the cgroup is at or near its limit.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V9:
- Add comments for static variables. (Jarkko)

V8:
- Remove alignment for substructure variables. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 181 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   3 +
 2 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index f4a37ace67d7..16b6d9f909eb 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -8,9 +8,180 @@
 /* The root EPC cgroup */
 static struct sgx_epc_cgroup epc_cg_root;
 
+/*
+ * The work queue that reclaims EPC pages in the background for cgroups.
+ *
+ * A cgroup schedules a work item into this queue to reclaim pages within the
+ * same cgroup when its usage limit is reached and synchronous reclamation is not
+ * an option, e.g., in a fault handler.
+ */
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
+ * sgx_epc_cgroup_reclaim_work_func() to determine if EPC usage of a cgroup is
+ * over its limit or its ancestors' hence reclamation is needed.
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
 /**
- * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC page
+ * sgx_epc_cgroup_lru_empty() - check if a cgroup tree has no pages on its LRUs
+ * @root:	Root of the tree to check
  *
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
+ * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs to reclaim pages
+ * @root:	Root of the tree to start walking from.
+ * Return:	Number of pages reclaimed.
+ */
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
+{
+	/*
+	 * Attempting to reclaim only a few pages will often fail and is
+	 * inefficient, while reclaiming a huge number of pages can result in
+	 * soft lockups due to holding various locks for an extended duration.
+	 */
+	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
+	struct cgroup_subsys_state *css_root;
+	struct cgroup_subsys_state *pos;
+	struct sgx_epc_cgroup *epc_cg;
+	unsigned int cnt;
+
+	 /* Caller ensure css_root ref acquired */
+	css_root = &root->css;
+
+	cnt = 0;
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, css_root) {
+		if (!css_tryget(pos))
+			break;
+		rcu_read_unlock();
+
+		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
+		cnt += sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan);
+
+		rcu_read_lock();
+		css_put(pos);
+		if (!nr_to_scan)
+			break;
+	}
+
+	rcu_read_unlock();
+	return cnt;
+}
+
+/*
+ * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the cgroup
+ * when the cgroup is at/near its maximum capacity
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
+		if (max > SGX_NR_TO_SCAN * 2)
+			max -= (SGX_NR_TO_SCAN / 2);
+
+		cur = sgx_epc_cgroup_page_counter_read(epc_cg);
+
+		if (cur <= max || sgx_epc_cgroup_lru_empty(epc_cg->cg))
+			break;
+
+		/* Keep reclaiming until above condition is met. */
+		sgx_epc_cgroup_reclaim_pages(epc_cg->cg);
+	}
+}
+
+/**
+ * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC page
  * @epc_cg:	The EPC cgroup to be charged for the page.
  * Return:
  * * %0 - If successfully charged.
@@ -38,6 +209,7 @@ static void sgx_epc_cgroup_free(struct misc_cg *cg)
 	if (!epc_cg)
 		return;
 
+	cancel_work_sync(&epc_cg->reclaim_work);
 	kfree(epc_cg);
 }
 
@@ -50,6 +222,8 @@ const struct misc_res_ops sgx_epc_cgroup_ops = {
 
 static void sgx_epc_misc_init(struct misc_cg *cg, struct sgx_epc_cgroup *epc_cg)
 {
+	sgx_lru_init(&epc_cg->lru);
+	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
 	epc_cg->cg = cg;
 }
@@ -69,6 +243,11 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
 
 void sgx_epc_cgroup_init(void)
 {
+	sgx_epc_cg_wq = alloc_workqueue("sgx_epc_cg_wq",
+					WQ_UNBOUND | WQ_FREEZABLE,
+					WQ_UNBOUND_MAX_ACTIVE);
+	BUG_ON(!sgx_epc_cg_wq);
+
 	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_epc_cgroup_ops);
 	sgx_epc_misc_init(misc_cg_root(), &epc_cg_root);
 }
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 6b664b4c321f..e3c6a08f0ee8 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -34,6 +34,8 @@ static inline void sgx_epc_cgroup_init(void) { }
 #else
 struct sgx_epc_cgroup {
 	struct misc_cg *cg;
+	struct sgx_epc_lru_list lru;
+	struct work_struct reclaim_work;
 };
 
 static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct misc_cg *cg)
@@ -66,6 +68,7 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
 
 int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
+bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
 void sgx_epc_cgroup_init(void);
 
 #endif
-- 
2.25.1


