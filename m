Return-Path: <cgroups+bounces-1267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C98418DA
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E161B1F2527F
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896838394;
	Tue, 30 Jan 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAh1HGoK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFA37705;
	Tue, 30 Jan 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580587; cv=none; b=F0aD4ZBDujwhYucbVohyoIULaBiRkAdds9zaVkOScagIb7LPV5PrAQkoQj70cWT5FwIZuB+TAAKjNDuMHHRRxJi5u4mwIevI4rzzXIagE4Yfl6MeJjI4k+pHl0NAIJ0uT5fa533PgEHFU9JqVDsFMzdA+K27QdmI/iQpVyVVIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580587; c=relaxed/simple;
	bh=yBZnVsYKUJTdPa6SgYXfS7808tsLgToE9zfhOWgI4aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol69ckkxKAFES4BDuzI54CCSvvCfx+jzPcW1MAmXJrxNjXaHL/vi1ihWH/IBImsaEbRlWuk6rxbZZBk7U1vMoVmr5KMvgJMsLLWiqP/6ZfIdlLLzrLufLSoVsp7laa+mqxyI3sHbkLr+wIfOZFyKRYXLrDGB00APwj94zQSuXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAh1HGoK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580586; x=1738116586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yBZnVsYKUJTdPa6SgYXfS7808tsLgToE9zfhOWgI4aw=;
  b=kAh1HGoKUmJy6jet5nN9NVnaZP++IEnxcKH0drppK4vvz1VhZL7gdOty
   845M4r3BNQqk0ywGthCHLCkgEbMs2ElWVelBKHZezYqzNZg/OhW4w9OKt
   ULAGhucA9U82z3WK4Qb2B2ZQsuMSFYoe31aCcDnZcgM8TVRYUbq6V+VKL
   FZG7djGUH2vfyGNx3b7KJnr3/hVxZKOWEUzqsSqAcPsfX2kyBlFqn7HzM
   OSbIUm2uaOiyFRjdm7TA92LpJYAEiL9ZNGbXwQqiRHBnUvbkC9Fo4L5NI
   np9gocehhLRa/iWnLMEC3Y9eCtcwXa0hsU7AG5yObQsj1ap2D6nZO3tgt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16530977"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16530977"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042342"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042342"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2024 18:09:40 -0800
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
	chrisyan@microsoft.com
Subject: [PATCH v8 08/15] x86/sgx: Implement EPC reclamation flows for cgroup
Date: Mon, 29 Jan 2024 18:09:31 -0800
Message-Id: <20240130020938.10025-9-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130020938.10025-1-haitao.huang@linux.intel.com>
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
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
V8:
- Remove alignment for substructure variables. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 174 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   3 +
 2 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index eac8548164de..8858a0850f8a 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -7,9 +7,173 @@
 
 static struct sgx_epc_cgroup epc_cg_root;
 
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
+ * @root:	Root of the tree to start walking
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
@@ -37,6 +201,7 @@ static void sgx_epc_cgroup_free(struct misc_cg *cg)
 	if (!epc_cg)
 		return;
 
+	cancel_work_sync(&epc_cg->reclaim_work);
 	kfree(epc_cg);
 }
 
@@ -49,6 +214,8 @@ const struct misc_res_ops sgx_epc_cgroup_ops = {
 
 static void sgx_epc_misc_init(struct misc_cg *cg, struct sgx_epc_cgroup *epc_cg)
 {
+	sgx_lru_init(&epc_cg->lru);
+	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
 	epc_cg->cg = cg;
 }
@@ -68,6 +235,11 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
 
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


