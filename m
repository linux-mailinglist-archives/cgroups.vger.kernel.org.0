Return-Path: <cgroups+bounces-3201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040C90AE4E
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D484287016
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0F198A19;
	Mon, 17 Jun 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNLPd8g+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E2198A0F;
	Mon, 17 Jun 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628827; cv=none; b=BMan3+opVFM/cl2X7AfQapc/K5Iw3K/nRF0PbcpPH2jBd7MSn+mkCand9DSiqSLzBHKSZU5XX75cHiUSoAz0BQb6jwQZvAgQAM98k14/PIcuPNY7iqkPCvH6U7/8KbFDBG6KPdPh+QhGFMF8xZSZ9KdbBcVb+riUjmbFuPpaXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628827; c=relaxed/simple;
	bh=Dt3pmPoaXjSX1vk6mCUzhICuDxWp7p56GB1n7ZilMMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFl6EDjZW+xyPhmxExm/tjf9ozY0PBbn4q3flt8XmTUMKsQFDcYZBeAK4m9I6Jy1IXbcbFQ3xD0RA6Fj8JLbYVn9Lm6Nvfi/diAv3RmVUGGZ0hKbFeh3E/66evuE+7jpSvoiYnHffDQZSUwICyM+CH4kCx3mllwtVM1D9ThGN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNLPd8g+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628825; x=1750164825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dt3pmPoaXjSX1vk6mCUzhICuDxWp7p56GB1n7ZilMMo=;
  b=CNLPd8g+H6DQB7aZPiMZmMtJBsrCEbzZeYe2V9y52MD3K5wuyB+RjMZd
   gD9bU+EbjJhpdQ3Mos70kvNvMN4+Eru8Xt/R0sg2QLsBW7mshJbz3r9TC
   hRdvBJn2zH+r/7UVVFBwDPDsStR/vR9kphUriGg5NhyqRRdYVFCbFmxSX
   tiKM9w369X/Eo6/3BsGAVz9yRL7cmi3el/in4Jdk0wg3aJx/hPOsBhZ5W
   /N/HrrkUJ4SUtCxQl81GF4714WGgJm8Ao/GvJRR/YM04+7ufxQnQrPvcU
   xN6/pUhG8PlEqWJzvBRdRIFEWXwhwnv3av+b65f2CXDDEXHgykuJ87gNI
   A==;
X-CSE-ConnectionGUID: 6YfUlHOxSGmBAb4Up9e4QA==
X-CSE-MsgGUID: MWGjjexiR9acD++2vp1yWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570904"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:42 -0700
X-CSE-ConnectionGUID: XDKYRJQESwK7Z00w1iEicw==
X-CSE-MsgGUID: JgnlgCZ6RwadldzzijyIBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387535"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:41 -0700
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
Subject: [PATCH v15 08/14] x86/sgx: Add basic EPC reclamation flow for cgroup
Date: Mon, 17 Jun 2024 05:53:15 -0700
Message-ID: <20240617125321.36658-9-haitao.huang@linux.intel.com>
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

Currently in the EPC page allocation, the kernel simply fails the
allocation when the current EPC cgroup fails to charge due to its usage
reaching limit.  This is not ideal. When that happens, a better way is
to reclaim EPC page(s) from the current EPC cgroup (and/or its
descendants) to reduce its usage so the new allocation can succeed.

Add the basic building blocks to support per-cgroup reclamation.

Currently the kernel only has one place to reclaim EPC pages: the global
EPC LRU list.  To support the "per-cgroup" EPC reclaim, maintain an LRU
list for each EPC cgroup, and introduce a "cgroup" variant function to
reclaim EPC pages from a given EPC cgroup and its descendants.

Currently the kernel does the global EPC reclaim in sgx_reclaim_page().
It always tries to reclaim EPC pages in batch of SGX_NR_TO_SCAN (16)
pages.  Specifically, it always "scans", or "isolates" SGX_NR_TO_SCAN
pages from the global LRU, and then tries to reclaim these pages at once
for better performance.

Implement the "cgroup" variant EPC reclaim in a similar way, but keep
the implementation simple: 1) change sgx_reclaim_pages() to take an LRU
as input, and return the pages that are "scanned" and attempted for
reclamation (but not necessarily reclaimed successfully); 2) loop the
given EPC cgroup and its descendants and do the new sgx_reclaim_pages()
until SGX_NR_TO_SCAN pages are "scanned".

This implementation, encapsulated in sgx_cgroup_reclaim_pages(), always
tries to reclaim SGX_NR_TO_SCAN pages from the LRU of the given EPC
cgroup, and only moves to its descendants when there's no enough
reclaimable EPC pages to "scan" in its LRU.  It should be enough for
most cases. In other cases, the caller may invoke this function in a
loop to ensure enough pages reclaimed for its usage. To ensure all
descendant groups scanned in a round-robin fashion in those cases,
sgx_cgroup_reclaim_pages() takes in a starting cgroup and returns the
next cgroup that the caller can pass in as the new starting cgroup for a
subsequent call.

Note, this simple implementation doesn't _exactly_ mimic the current
global EPC reclaim (which always tries to do the actual reclaim in batch
of SGX_NR_TO_SCAN pages): when LRUs have less than SGX_NR_TO_SCAN
reclaimable pages, the actual reclaim of EPC pages will be split into
smaller batches _across_ multiple LRUs with each being smaller than
SGX_NR_TO_SCAN pages.

A more precise way to mimic the current global EPC reclaim would be to
have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
_across_ the given EPC cgroup _AND_ its descendants, and then do the
actual reclaim in one batch.  But this is unnecessarily complicated at
this stage.

Alternatively, the current sgx_reclaim_pages() could be changed to
return the actual "reclaimed" pages, but not "scanned" pages. However,
the reclamation is a lengthy process, forcing a successful reclamation
of predetermined number of pages may block the caller for too long. And
that may not be acceptable in some synchronous contexts, e.g., in
serving an ioctl().

With this building block in place, add synchronous reclamation support
in sgx_cgroup_try_charge(): trigger a call to
sgx_cgroup_reclaim_pages() if the cgroup reaches its limit and the
caller allows synchronous reclaim as indicated by s newly added
parameter.

A later patch will add support for asynchronous reclamation reusing
sgx_cgroup_reclaim_pages().

Note all reclaimable EPC pages are still tracked in the global LRU thus
no per-cgroup reclamation is actually active at the moment. Per-cgroup
tracking and reclamation will be turned on in the end after all
necessary infrastructure is in place.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 149 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   5 +-
 arch/x86/kernel/cpu/sgx/main.c       |  55 ++++++----
 arch/x86/kernel/cpu/sgx/sgx.h        |   1 +
 4 files changed, 183 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 73e4c0304b77..507926f37abf 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -8,16 +8,158 @@
 static struct sgx_cgroup sgx_cg_root;
 
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
+			break;
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
+/**
+ * sgx_cgroup_reclaim_pages() - reclaim EPC from a cgroup tree
+ * @root:	The root of cgroup tree to reclaim from.
+ * @start:	The descendant cgroup from which to start the tree walking.
+ *
+ * This function performs a pre-order walk in the cgroup tree under the given
+ * root, starting from the node %start, or from the root if %start is NULL. The
+ * function will attempt to reclaim pages at each node until a fixed number of
+ * pages (%SGX_NR_TO_SCAN) are attempted for reclamation. No guarantee of
+ * success on the actual reclamation process. In extreme cases, if all pages in
+ * front of the LRUs are recently accessed, i.e., considered "too young" to
+ * reclaim, no page will actually be reclaimed after walking the whole tree.
+ *
+ * In some cases, a caller may want to ensure enough reclamation until its
+ * specific need is met. In those cases, the caller should invoke this function
+ * in a loop, and at each iteration passes in the same root and the next node
+ * returned from the previous call as the new %start.
+ *
+ * Return: The next misc cgroup in the subtree to continue the scanning and
+ * attempt for more reclamation from this subtree if needed.  Caller must
+ * release the reference if the returned is not used as %start for a subsequent
+ * call.
+ */
+static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct misc_cg *start)
+{
+	struct cgroup_subsys_state *css_root, *pos;
+	struct cgroup_subsys_state *next = NULL;
+	struct sgx_cgroup *sgx_cg;
+	unsigned int cnt = 0;
+
+	 /* Caller must ensure css_root and start ref's acquired */
+	css_root = &root->css;
+	if (start)
+		pos = &start->css;
+	else
+		pos = css_root;
+
+	while (cnt < SGX_NR_TO_SCAN) {
+		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
+		cnt += sgx_reclaim_pages(&sgx_cg->lru);
+
+		rcu_read_lock();
+
+		next = css_next_descendant_pre(pos, css_root);
+
+		if (pos != css_root)
+			css_put(pos);
+
+		if (!next || !css_tryget(next)) {
+			/* We are done if next is NULL or not safe to continue
+			 * the walk if next is dead. Return NULL and the caller
+			 * determines whether to restart from root.
+			 */
+			rcu_read_unlock();
+			return NULL;
+		}
+
+		rcu_read_unlock();
+		pos = next;
+	}
+
+	return css_misc(next);
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
+	struct misc_cg *cg_next = NULL;
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
+		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next);
+		cond_resched();
+	}
+
+out:
+	if (cg_next != sgx_cg->cg)
+		put_misc_cg(cg_next);
+	return ret;
 }
 
 /**
@@ -42,6 +184,7 @@ static void sgx_cgroup_free(struct misc_cg *cg)
 
 static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
 {
+	sgx_lru_init(&sgx_cg->lru);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
 	sgx_cg->cg = cg;
 }
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 5750eebc2f3f..98af9bde6087 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -20,7 +20,7 @@ static inline struct sgx_cgroup *sgx_get_current_cg(void)
 
 static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg) { }
 
-static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
 	return 0;
 }
@@ -33,6 +33,7 @@ static inline void sgx_cgroup_init(void) { }
 
 struct sgx_cgroup {
 	struct misc_cg *cg;
+	struct sgx_epc_lru_list lru;
 };
 
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
@@ -63,7 +64,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 	put_misc_cg(sgx_cg->cg);
 }
 
-int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg);
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 int __init sgx_cgroup_init(void);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 1eadf4c39678..d272488c53bf 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -286,11 +286,14 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
- * Take a fixed number of pages from the head of the active page pool and
- * reclaim them to the enclave's private shmem files. Skip the pages, which have
- * been accessed since the last scan. Move those pages to the tail of active
- * page pool so that the pages get scanned in LRU like fashion.
+/**
+ * sgx_reclaim_pages() - Attempt to reclaim a fixed number of pages from an LRU
+ * @lru:	The LRU from which pages are reclaimed.
+ *
+ * Take a fixed number of pages from the head of a given LRU and reclaim them to
+ * the enclave's private shmem files. Skip the pages, which have been accessed
+ * since the last scan. Move those pages to the tail of the list so that the
+ * pages get scanned in LRU like fashion.
  *
  * Batch process a chunk of pages (at the moment 16) in order to degrade amount
  * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
@@ -298,8 +301,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * + EWB) but not sufficiently. Reclaiming one page at a time would also be
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
+ *
+ * Return:	Number of pages attempted for reclamation.
  */
-static void sgx_reclaim_pages(void)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -310,10 +315,9 @@ static void sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_global_lru.lock);
+	spin_lock(&lru->lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
-						    struct sgx_epc_page, list);
+		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);
 		if (!epc_page)
 			break;
 
@@ -328,7 +332,7 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -351,9 +355,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
-		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		spin_lock(&lru->lock);
+		list_add_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -379,14 +383,21 @@ static void sgx_reclaim_pages(void)
 
 		sgx_free_epc_page(epc_page);
 	}
+
+	return cnt;
 }
 
-static bool sgx_should_reclaim(unsigned long watermark)
+static bool sgx_should_reclaim_global(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
 	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
+static void sgx_reclaim_pages_global(void)
+{
+	sgx_reclaim_pages(&sgx_global_lru);
+}
+
 /*
  * sgx_reclaim_direct() should be called (without enclave's mutex held)
  * in locations where SGX memory resources might be low and might be
@@ -394,8 +405,8 @@ static bool sgx_should_reclaim(unsigned long watermark)
  */
 void sgx_reclaim_direct(void)
 {
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
+		sgx_reclaim_pages_global();
 }
 
 static int ksgxd(void *p)
@@ -415,10 +426,10 @@ static int ksgxd(void *p)
 
 		wait_event_freezable(ksgxd_waitq,
 				     kthread_should_stop() ||
-				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
+				     sgx_should_reclaim_global(SGX_NR_HIGH_PAGES));
 
-		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+		if (sgx_should_reclaim_global(SGX_NR_HIGH_PAGES))
+			sgx_reclaim_pages_global();
 
 		cond_resched();
 	}
@@ -572,7 +583,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 	int ret;
 
 	sgx_cg = sgx_get_current_cg();
-	ret = sgx_cgroup_try_charge(sgx_cg);
+	ret = sgx_cgroup_try_charge(sgx_cg, reclaim);
 	if (ret) {
 		sgx_put_cg(sgx_cg);
 		return ERR_PTR(ret);
@@ -600,7 +611,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 		cond_resched();
 	}
 
@@ -613,7 +624,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 		sgx_put_cg(sgx_cg);
 	}
 
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
 		wake_up(&ksgxd_waitq);
 
 	return page;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index e21c5a134a5e..4dc04f4d046c 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -136,6 +136,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.43.0


