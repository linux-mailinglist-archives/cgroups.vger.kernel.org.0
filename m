Return-Path: <cgroups+bounces-4392-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2671959273
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A07B285B8B
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFDE14D44F;
	Wed, 21 Aug 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT6m9G6E"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD113E40F;
	Wed, 21 Aug 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205268; cv=none; b=D31UxpxsqNacCUzaxz8qny+vOsvWxb2aDUL3JucxdT6LwiKc8nreangs08siq1JYT1sOs1wgLYH+49WsPY/0OWCZtPcdsQ1/VLHiEqNFqvCKi9JykqWxO5bgssehZvv1hw+1/3BnPok7G1rUoSZ126dhfsSPRj1DchR5GRBaUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205268; c=relaxed/simple;
	bh=yKjbhYX8NYy6WBTLSZE+Pt5k8zeJcYOwlFHtnoC7S1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfwMIByCRZndjUIRPKBYDdVLyyefIPnBUqePSPxiW/NEihIEvy8sLEnwlD9aYnzk1y+ieEX01e4WqYpPetts/QR3hkBmuAsaNUdQGyviJXneScTUQP0fjAJ3gG/DoEOnOGVa/M3F/fEr6WZYuGQIR3WyZausN44n1wifTyRPjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT6m9G6E; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205267; x=1755741267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKjbhYX8NYy6WBTLSZE+Pt5k8zeJcYOwlFHtnoC7S1s=;
  b=jT6m9G6ESa2IR6xlBGqkw/aZ23/GxiXXaffWWrIKvQ9i/FNWg4gmWT94
   TYxx2+ME3p+0zKGPAuXpXf8tX+RmSuQy+TEjUykXNQI7zyNaaY/3eGIdp
   7Z93WP1leV/3xaOFuD6AhKql+SGpsDbXQfaWay8YMtabNLS47HJQ5/3Hc
   Zpct7v9QPw8jLoM3h4UK8vkU9+QHJoLRsdrIZ+3y5HX10ydHcj+fwVPI+
   T6xWt33H5ckfsTXua5AuuuQSojR9p3c1ONeFQieN/8sDKo1jup81xQPhN
   gEYC6wpuBSSnxt1p1JKD53Z68KLyPkKk0kJNlH95ZNYquCX66zCgHf/sc
   g==;
X-CSE-ConnectionGUID: ZaoSWP1oRzG6UaYk7WK1sQ==
X-CSE-MsgGUID: nCvXX0l4Sv6tnzliLWrKsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107913"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107913"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:20 -0700
X-CSE-ConnectionGUID: jlOa/gazSW6ajkTehKRvJw==
X-CSE-MsgGUID: fCAjtw3mSTCQU2lVZ1OjcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078606"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:19 -0700
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
Subject: [PATCH v16 09/16] x86/sgx: Add basic EPC reclamation flow for cgroup
Date: Tue, 20 Aug 2024 18:53:57 -0700
Message-ID: <20240821015404.6038-10-haitao.huang@linux.intel.com>
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

Currently in the EPC page allocation, the kernel simply fails the
allocation when the current EPC cgroup fails to charge due to its usage
reaching limit.  This is not ideal.  When that happens, a better way is
to reclaim EPC page(s) from the current EPC cgroup to reduce its usage
so the new allocation can succeed.

Currently, all EPC pages are tracked in a single global LRU, and the
"global EPC reclamation" supports the following 3 cases:

1) On-demand asynchronous reclamation: For allocation requests that can
   not wait for reclamation but can be retried, an asynchronous
   reclamation is triggered, in which the global reclaimer, ksgxd, keeps
   reclaiming EPC pages until the free page count is above a minimal
   threshold.

2) On-demand synchronous reclamation: For allocations that can wait for
   reclamation, the EPC page allocator, sgx_alloc_epc_page() reclaims
   EPC page(s) immediately until at least one free page is available for
   allocation.

3) Preemptive reclamation: For some allocation requests, e.g.,
   allocation for reloading a reclaimed page to change its permissions
   or page type, the kernel invokes sgx_reclaim_direct() to preemptively
   reclaim EPC page(s) as a best effort to minimize on-demand
   reclamation for subsequent allocations.

Similarly, a "per-cgroup reclamation" is needed to support the above 3
cases as well:

1) For on-demand asynchronous reclamation, a per-cgroup reclamation
   needs to be invoked to maintain a minimal difference between the
   usage and the limit for each cgroup, analogous to the minimal free
   page threshold  maintained by the global reclaimer.

2) For on-demand synchronous reclamation, sgx_cgroup_try_charge() needs
   to invoke the per-cgroup reclamation until the cgroup usage become
   at least one page lower than its limit.

3) For preemptive reclamation, sgx_reclaim_direct() needs to invoke the
   per-cgroup reclamation to minimize per-cgroup on-demand reclamation
   for subsequent allocations.

To support the per-cgroup reclamation, introduce a "per-cgroup LRU" to
track all EPC pages belong to the owner cgroup to utilize the existing
sgx_reclaim_pages().

Currently, the global reclamation treats all EPC pages equally as it
scans all EPC pages in FIFO order in the global LRU.  The "per-cgroup
reclamation" needs to somehow achieve the same fairness of all EPC pages
that are tracked in the multiple LRUs of the given cgroup and all the
descendants to reflect the nature of the cgroup.

The idea is to achieve such fairness by scanning "all EPC cgroups" of
the subtree (the given cgroup and all the descendants) equally in turns,
and in the scan to each cgroup, apply the existing sgx_reclaim_pages()
to its LRU. This basic flow is encapsulated in a new function,
sgx_cgroup_reclaim_pages().

Export sgx_reclaim_pages() for use in sgx_cgroup_reclaim_pages(). And
modify sgx_reclaim_pages() to return the number of pages scanned so
sgx_cgroup_reclaim_pages() can track scanning progress and determine
whether enough scanning is done or to continue the scanning for next
descendant.

Whenever reclaiming in a subtree of a given root is needed, start the
scanning from the next descendant where scanning was stopped at last
time.  To keep track of the next descendant cgroup to scan, add a new
field, next_cg, in the sgx_cgroup struct.  Create an iterator function,
sgx_cgroup_next_get(), atomically returns a valid reference of the
descendant for next round of scanning and advances @next_cg to next
valid descendant in a preorder walk. This iterator function is used in
sgx_cgroup_reclaim_pages() to iterate descendants for scanning.
Separately also advances @next_cg to next valid descendant when the
cgroup referenced by @next_cg is to be freed.

Add support for on-demand synchronous reclamation in
sgx_cgroup_try_charge(), applying sgx_cgroup_reclaim_pages() iteratively
until cgroup usage is lower than its limit.

Later patches will reuse sgx_cgroup_reclaim_pages() to add support for
asynchronous and preemptive reclamation.

Note all reclaimable EPC pages are still tracked in the global LRU thus
no per-cgroup reclamation is actually active at the moment: -ENOMEM is
returned by __sgx_cgroup_try_charge() when LRUs are empty. Per-cgroup
tracking and reclamation will be turned on in the end after all
necessary infrastructure is in place.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V16:
- Revise commit log to define reclamation requirement and the design more clearly. (Kai)
- Revise sgx_cgroup_reclaim_pages() to scan cgroups in subtree more
  fairly, track next_cg in each sgx_cgroup and add helpers that is used
  to iterate descendant in sgx_cgroup_reclaim_pages().(Kai)

V14:
- Allow sgx_cgroup_reclaim_pages() to continue from previous tree-walk.
It takes in a 'start' node and returns the 'next' node for the caller to
use as the new 'start'. This is to ensure pages in lower level cgroups
can be reclaimed if all pages in upper level nodes are "too young".
(Kai)
- Move renaming sgx_should_reclaim() to sgx_should_reclaim_global() from
a later patch to this one. (Kai)

V11:
- Use commit message suggested by Kai
- Remove "usage" comments for functions. (Kai)

V10:
- Simplify the signature by removing a pointer to nr_to_scan (Kai)
- Return pages attempted instead of reclaimed as it is really what the
cgroup caller needs to track progress. This further simplifies the design.
- Merge patch for exposing sgx_reclaim_pages() with basic synchronous
reclamation. (Kai)
- Shorten names for EPC cgroup functions. (Jarkko)
- Fix/add comments to justify the design (Kai)
- Separate out a helper for for addressing single iteration of the loop
in sgx_cgroup_try_charge(). (Jarkko)

V9:
- Add comments for static variables. (Jarkko)

V8:
- Use width of 80 characters in text paragraphs. (Jarkko)
- Remove alignment for substructure variables. (Jarkko)

V7:
- Reworked from patch 9 of V6, "x86/sgx: Restructure top-level EPC reclaim
function". Do not split the top level function (Kai)
- Dropped patches 7 and 8 of V6.
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 208 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  18 ++-
 arch/x86/kernel/cpu/sgx/main.c       |  19 ++-
 arch/x86/kernel/cpu/sgx/sgx.h        |   1 +
 4 files changed, 238 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 0e422fef02bb..ce28efd20a15 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -7,17 +7,203 @@
 /* The root SGX EPC cgroup */
 static struct sgx_cgroup sgx_cg_root;
 
+/*
+ * Return the next descendant in a preorder walk, given a root, @root and a
+ * cgroup, @cg, to start the walk from. Return @root if no descendant left for
+ * this walk, Otherwise, return next descendant and has its refcnt incremented.
+ */
+static struct sgx_cgroup *sgx_cgroup_next_descendant_pre(struct sgx_cgroup *root,
+							 struct sgx_cgroup *cg)
+{
+	struct cgroup_subsys_state *next;
+
+	rcu_read_lock();
+	for (;;) {
+		next = css_next_descendant_pre(&cg->cg->css, &root->cg->css);
+		if (!next) {
+			next = &root->cg->css;
+			break;
+		}
+
+		if (css_tryget(next))
+			break;
+	}
+	rcu_read_unlock();
+
+	return sgx_cgroup_from_misc_cg(css_misc(next));
+}
+
+/*
+ * For a given root, @root, if a given cgroup, @cg, is the next cgroup to
+ * reclaim pages from, i.e., referenced by @root->next_cg, then advance
+ * @root->next_cg to the next valid cgroup in a preorder walk or the root if no
+ * more descendants left to walk.
+ *
+ * Called from sgx_cgroup_free() when @cg is to be freed so it can no longer be
+ * used as 'next_cg'.
+ */
+static inline void sgx_cgroup_next_skip(struct sgx_cgroup *root, struct sgx_cgroup *cg)
+{
+	struct sgx_cgroup *p;
+
+	spin_lock(&root->next_cg_lock);
+	p = root->next_cg;
+	spin_unlock(&root->next_cg_lock);
+
+	/* Already moved by other threads, no need to update */
+	if (cg != p)
+		return;
+
+	p = sgx_cgroup_next_descendant_pre(root, cg);
+
+	spin_lock(&root->next_cg_lock);
+	if (root->next_cg == cg)
+		root->next_cg = p;
+	spin_unlock(&root->next_cg_lock);
+
+	/* Decrement refcnt so cgroup pointed to by p can be released */
+	if (p != cg && p != root)
+		sgx_put_cg(p);
+}
+
+/*
+ * Return the cgroup currently referenced by @root->next_cg and advance
+ * @root->next_cg to the next descendant or @root.  The returned cgroup has its
+ * refcnt incremented if it is not @root and caller must release the refcnt.
+ */
+static inline struct sgx_cgroup *sgx_cgroup_next_get(struct sgx_cgroup *root)
+{
+	struct sgx_cgroup *p;
+
+	/*
+	 * Acquire a reference for the to-be-returned cgroup and advance
+	 * next_cg with the lock so the same cg not returned to two threads.
+	 */
+	spin_lock(&root->next_cg_lock);
+
+	p = root->next_cg;
+
+	/* Advance the to-be-returned to next descendant if current one is dying */
+	if (p != root && !css_tryget(&p->cg->css))
+		p = sgx_cgroup_next_descendant_pre(root, p);
+
+	/* Advance next_cg */
+	root->next_cg = sgx_cgroup_next_descendant_pre(root, p);
+
+	/* Decrement ref here so it can be released by cgroup subsystem */
+	if (root->next_cg != root)
+		sgx_put_cg(root->next_cg);
+
+	spin_unlock(&root->next_cg_lock);
+
+	/* p is root or refcnt incremented */
+	return p;
+}
+
 /**
- * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
+ * sgx_cgroup_lru_empty() - check if a cgroup tree has no pages on its LRUs
+ * @root:	Root of the tree to check
  *
+ * Return: %true if all cgroups under the specified root have empty LRU lists.
+ */
+static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+{
+	struct cgroup_subsys_state *css_root;
+	struct cgroup_subsys_state *pos;
+	struct sgx_cgroup *sgx_cg;
+	bool ret = true;
+
+	/*
+	 * Caller must ensure css_root ref acquired
+	 */
+	css_root = &root->css;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, css_root) {
+		if (!css_tryget(pos))
+			continue;
+
+		rcu_read_unlock();
+
+		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
+
+		spin_lock(&sgx_cg->lru.lock);
+		ret = list_empty(&sgx_cg->lru.reclaimable);
+		spin_unlock(&sgx_cg->lru.lock);
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
+/*
+ * Scan at least @nr_to_scan pages and attempt to reclaim them from the subtree of @root.
+ */
+static inline void sgx_cgroup_reclaim_pages(struct sgx_cgroup *root,
+					    unsigned int nr_to_scan)
+{
+	struct sgx_cgroup *next_cg = NULL;
+	unsigned int cnt = 0;
+
+	while (!sgx_cgroup_lru_empty(root->cg) && cnt < nr_to_scan) {
+		next_cg = sgx_cgroup_next_get(root);
+		cnt += sgx_reclaim_pages(&next_cg->lru);
+		if (next_cg != root)
+			sgx_put_cg(next_cg);
+	}
+}
+
+static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
+{
+	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
+		return 0;
+
+	/* No reclaimable pages left in the cgroup */
+	if (sgx_cgroup_lru_empty(epc_cg->cg))
+		return -ENOMEM;
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	return -EBUSY;
+}
+
+/**
+ * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
  * @sgx_cg:	The EPC cgroup to be charged for the page.
+ * @reclaim:	Whether or not synchronous EPC reclaim is allowed.
  * Return:
  * * %0 - If successfully charged.
  * * -errno - for failures.
  */
-int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
-	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
+	int ret;
+
+	for (;;) {
+		ret = __sgx_cgroup_try_charge(sgx_cg);
+
+		if (ret != -EBUSY)
+			goto out;
+
+		if (reclaim == SGX_NO_RECLAIM) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		sgx_cgroup_reclaim_pages(sgx_cg, 1);
+
+		cond_resched();
+	}
+
+out:
+	return ret;
 }
 
 /**
@@ -32,18 +218,34 @@ void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg)
 static void sgx_cgroup_free(struct misc_cg *cg)
 {
 	struct sgx_cgroup *sgx_cg;
+	struct misc_cg *p;
 
 	sgx_cg = sgx_cgroup_from_misc_cg(cg);
 	if (!sgx_cg)
 		return;
 
+	/*
+	 * Notify ancestors to not reclaim from this dying cgroup.
+	 * Not start from this cgroup itself because at this point no reference
+	 * of this cgroup being hold, i.e., all pages in this cgroup are freed
+	 * and LRU is empty, so no reclamation possible.
+	 */
+	p = misc_cg_parent(cg);
+	while (p) {
+		sgx_cgroup_next_skip(sgx_cgroup_from_misc_cg(p), sgx_cg);
+		p = misc_cg_parent(p);
+	}
+
 	kfree(sgx_cg);
 }
 
 static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
 {
+	sgx_lru_init(&sgx_cg->lru);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
 	sgx_cg->cg = cg;
+	sgx_cg->next_cg = sgx_cg;
+	spin_lock_init(&sgx_cg->next_cg_lock);
 }
 
 static int sgx_cgroup_alloc(struct misc_cg *cg)
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index e74b1ea0b642..da7f5315bff8 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -20,7 +20,7 @@ static inline struct sgx_cgroup *sgx_get_current_cg(void)
 
 static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg) { }
 
-static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
 	return 0;
 }
@@ -38,6 +38,20 @@ static inline void __init sgx_cgroup_register(void) { }
 
 struct sgx_cgroup {
 	struct misc_cg *cg;
+	struct sgx_epc_lru_list lru;
+	/*
+	 * Pointer to the next cgroup to scan when the per-cgroup reclamation
+	 * is triggered next time. It does not hold a reference to prevent it
+	 * from being freed in order to allow the misc cgroup subsystem to
+	 * release and free the cgroup as needed, e.g., when admin wants to
+	 * delete the cgroup. When the cgroup pointed to is being freed,
+	 * sgx_cgroup_next_cg_skip(), will be invoked to update the pointer to
+	 * next accessible cgroup in a preorder walk of the subtree of the same
+	 * root.
+	 */
+	struct sgx_cgroup *next_cg;
+	/* Lock to protect concurrent access to @next_cg */
+	spinlock_t next_cg_lock;
 };
 
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
@@ -68,7 +82,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 	put_misc_cg(sgx_cg->cg);
 }
 
-int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg);
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 int __init sgx_cgroup_init(void);
 void __init sgx_cgroup_register(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 47dfba6f45af..303b06f39e4e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -301,7 +301,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
+/**
+ * sgx_reclaim_pages() - Attempt to reclaim a fixed number of pages from an LRU
+ * @lru:	The LRU from which pages are reclaimed.
+ *
  * Take a fixed number of pages from the head of a given LRU and reclaim them to
  * the enclave's private shmem files. Skip the pages, which have been accessed
  * since the last scan. Move those pages to the tail of the list so that the
@@ -313,8 +316,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * + EWB) but not sufficiently. Reclaiming one page at a time would also be
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
+ *
+ * Return:	Number of pages attempted for reclamation.
  */
-static void sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -393,6 +398,8 @@ static void sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 
 		sgx_free_epc_page(epc_page);
 	}
+
+	return cnt;
 }
 
 static bool sgx_should_reclaim_global(unsigned long watermark)
@@ -591,7 +598,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 	int ret;
 
 	sgx_cg = sgx_get_current_cg();
-	ret = sgx_cgroup_try_charge(sgx_cg);
+	ret = sgx_cgroup_try_charge(sgx_cg, reclaim);
 	if (ret) {
 		sgx_put_cg(sgx_cg);
 		return ERR_PTR(ret);
@@ -619,6 +626,12 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
+		/*
+		 * At this point, the usage within this cgroup is under its
+		 * limit but there is no physical page left for allocation.
+		 * Perform a global reclaim to get some pages released from any
+		 * cgroup with reclaimable pages.
+		 */
 		sgx_reclaim_pages_global();
 		cond_resched();
 	}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0c8d88eb65ff..f456abfe5c52 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -139,6 +139,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.43.0


