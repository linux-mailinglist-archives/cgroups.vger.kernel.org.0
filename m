Return-Path: <cgroups+bounces-3059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62E8D6C77
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C2D1C2504C
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60F136E17;
	Fri, 31 May 2024 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mY5OyYzY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526F135A46;
	Fri, 31 May 2024 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194402; cv=none; b=EHKN8cskKtXrkuLgaZyheJx0nN+2eF/riNhyHzNxpeAkOCxvxCLhcz/+LxxIvJjC+Pwy9VbmWo5LiwPHNwUyUv2C80tsB0FlqOl/L+TQvn0Fsfc6lwpdDZAXCnmPWYZB9BVtBR24E7nwZEULroaI4u93OIm6i88EWlH706noT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194402; c=relaxed/simple;
	bh=tF955xMuW1EHkFoi7eshEs2wQd/fgKYYCmBcjOvyEP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3RM+eOuhDOTg3KRj6/UxszfaDLNTrZtPvNPCv0b8QORwNtZXDS8rFUxtwtBkYZwDaWXfwwl20Ptb0hKDvoUc598pnFYKWflt4aNrH4FkzDzrURzCaE0Nj8IJiNqx5vnQZUR/maAL/PogrkNXaKEkxietr94lephgxl1MtuAD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mY5OyYzY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194401; x=1748730401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tF955xMuW1EHkFoi7eshEs2wQd/fgKYYCmBcjOvyEP8=;
  b=mY5OyYzYoPl1khLHMTmC6smVy3OfPqKw8zn5ItU2bPyyS/pXKZNmPTy6
   V9ceZrJ4+lQRv/Lk3MU9vH/Sjzvwgzu5Qk0PbuNx+KXqtmHAjlhuu5gJp
   FDwRFrOPbzu1YWXNIw6fczH2s+625KKmgqe6V5FD5olDoDQG+XIL4gEmE
   /dp5MZUp7mT6QxrhpwDM8FX7jC6hVKGLXwSVS25QVH1Q48jyHp48uNWGH
   O0AEtXco8or6ok9C3YUNvrK4+xXrUHYTjbdkICOkHkdmsIkGNXF9vxmtM
   odo4vYkSaX39PB0fOMrq2ovf3g9m068SPNKT9rEueEHkTx/nB3gY1RJ9i
   g==;
X-CSE-ConnectionGUID: myeoXfnBReGuwtiaJzbLkQ==
X-CSE-MsgGUID: 2R0XUDgrRWiYEEgd7Rty5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13949826"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13949826"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:26:38 -0700
X-CSE-ConnectionGUID: F9RyWtJ4S/aTM5nmIcb5DQ==
X-CSE-MsgGUID: WHiXQh4LTN+20eqmKYk13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40736945"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 15:26:37 -0700
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
Subject: [PATCH v14 11/14] x86/sgx: Charge mem_cgroup for per-cgroup reclamation
Date: Fri, 31 May 2024 15:26:27 -0700
Message-Id: <20240531222630.4634-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531222630.4634-1-haitao.huang@linux.intel.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enclave Page Cache(EPC) memory can be swapped out to regular system
memory, and the consumed memory should be charged to a proper
mem_cgroup. Currently the selection of mem_cgroup to charge is done in
sgx_encl_get_mem_cgroup(). But it considers all contexts other than the
ksgxd thread are user processes. With the new EPC cgroup implementation,
the swapping can also happen in EPC cgroup work-queue threads. In those
cases, it improperly selects the root mem_cgroup to charge for the RAM
usage.

Remove current_is_ksgxd() and change sgx_encl_get_mem_cgroup() to take
an additional argument to explicitly specify the mm struct to charge for
allocations. Callers from background kthreads not associated with a
charging mm struct would set it to NULL, while callers in user process
contexts set it to current->mm.

Internally, it handles the case when the charging mm given is NULL, by
searching for an mm struct from enclave's mm_list.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V10:
- Pass mm struct instead of a boolean 'indirect'. (Dave, Jarkko)

V9:
- Reduce number of if statements. (Tim)

V8:
- Limit text paragraphs to 80 characters wide. (Jarkko)
---
 arch/x86/kernel/cpu/sgx/encl.c       | 29 ++++++++++++++--------------
 arch/x86/kernel/cpu/sgx/encl.h       |  3 +--
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 11 +++++++----
 arch/x86/kernel/cpu/sgx/main.c       | 29 +++++++++++++---------------
 arch/x86/kernel/cpu/sgx/sgx.h        |  2 +-
 5 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f474179b6f77..7b77dad41daf 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -993,23 +993,23 @@ static int __sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_inde
 }
 
 /*
- * When called from ksgxd, returns the mem_cgroup of a struct mm stored
- * in the enclave's mm_list. When not called from ksgxd, just returns
- * the mem_cgroup of the current task.
+ * Find the mem_cgroup to charge for memory allocated on behalf of an enclave.
+ *
+ * Used in sgx_encl_alloc_backing() for backing store allocation.
+ *
+ * Return the mem_cgroup of the given charge_mm. Otherwise return the mem_cgroup
+ * of a struct mm stored in the enclave's mm_list.
  */
-static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
+static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl,
+						  struct mm_struct *charge_mm)
 {
 	struct mem_cgroup *memcg = NULL;
 	struct sgx_encl_mm *encl_mm;
 	int idx;
 
-	/*
-	 * If called from normal task context, return the mem_cgroup
-	 * of the current task's mm. The remainder of the handling is for
-	 * ksgxd.
-	 */
-	if (!current_is_ksgxd())
-		return get_mem_cgroup_from_mm(current->mm);
+	 /* Use the charge_mm if given. */
+	if (charge_mm)
+		return get_mem_cgroup_from_mm(charge_mm);
 
 	/*
 	 * Search the enclave's mm_list to find an mm associated with
@@ -1047,8 +1047,9 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
+ * @charge_mm:	the mm to charge for the allocation
  *
- * When called from ksgxd, sets the active memcg from one of the
+ * When charge_mm is NULL, sets the active memcg from one of the
  * mms in the enclave's mm_list prior to any backing page allocation,
  * in order to ensure that shmem page allocations are charged to the
  * enclave.  Create a backing page for loading data back into an EPC page with
@@ -1060,9 +1061,9 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
  *   -errno otherwise.
  */
 int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
-			   struct sgx_backing *backing)
+			   struct sgx_backing *backing, struct mm_struct *charge_mm)
 {
-	struct mem_cgroup *encl_memcg = sgx_encl_get_mem_cgroup(encl);
+	struct mem_cgroup *encl_memcg = sgx_encl_get_mem_cgroup(encl, charge_mm);
 	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
 	int ret;
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fe15ade02ca1..5ce9d108290f 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -103,12 +103,11 @@ static inline int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
 int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 		     unsigned long end, unsigned long vm_flags);
 
-bool current_is_ksgxd(void);
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
 const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
 int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
-			   struct sgx_backing *backing);
+			   struct sgx_backing *backing, struct mm_struct *charge_mm);
 void sgx_encl_put_backing(struct sgx_backing *backing);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 9e366068e0cd..7e0e9a4fedf0 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -107,6 +107,7 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
  * sgx_cgroup_reclaim_pages() - reclaim EPC from a cgroup tree
  * @root:	The root of cgroup tree to reclaim from.
  * @start:	The descendant cgroup from which to start the tree walking.
+ * @charge_mm:	The mm to charge for backing store allocation.
  *
  * This function performs a pre-order walk in the cgroup tree under the given
  * root, starting from the node %start, or from the root if %start is NULL. The
@@ -126,7 +127,8 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
  * release the reference if the returned is not used as %start for a subsequent
  * call.
  */
-static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct misc_cg *start)
+static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct misc_cg *start,
+						struct mm_struct *charge_mm)
 {
 	struct cgroup_subsys_state *css_root, *pos;
 	struct cgroup_subsys_state *next = NULL;
@@ -142,7 +144,7 @@ static struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mis
 
 	while (cnt < SGX_NR_TO_SCAN) {
 		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
-		cnt += sgx_reclaim_pages(&sgx_cg->lru);
+		cnt += sgx_reclaim_pages(&sgx_cg->lru, charge_mm);
 
 		rcu_read_lock();
 
@@ -218,7 +220,8 @@ static void sgx_cgroup_reclaim_work_func(struct work_struct *work)
 	 * blocked until a worker makes its way through the global work queue.
 	 */
 	while (sgx_cgroup_should_reclaim(sgx_cg)) {
-		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next);
+		 /* Indirect reclaim, no mm to charge, so NULL: */
+		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next, NULL);
 		cond_resched();
 	}
 
@@ -266,7 +269,7 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 			goto out;
 		}
 
-		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next);
+		cg_next = sgx_cgroup_reclaim_pages(sgx_cg->cg, cg_next, current->mm);
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 0a06b80e26b8..c8ac4eb996aa 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -261,8 +261,8 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 	}
 }
 
-static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
-				struct sgx_backing *backing)
+static void sgx_reclaimer_write(struct sgx_epc_page *epc_page, struct sgx_backing *backing,
+				struct mm_struct *charge_mm)
 {
 	struct sgx_encl_page *encl_page = epc_page->owner;
 	struct sgx_encl *encl = encl_page->encl;
@@ -278,7 +278,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
 		ret = sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
-					   &secs_backing);
+					   &secs_backing, charge_mm);
 		if (ret)
 			goto out;
 
@@ -297,6 +297,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 /**
  * sgx_reclaim_pages() - Attempt to reclaim a fixed number of pages from an LRU
  * @lru:	The LRU from which pages are reclaimed.
+ * @charge_mm:	The mm to charge for backing store allocation.
  *
  * Take a fixed number of pages from the head of a given LRU and reclaim them to
  * the enclave's private shmem files. Skip the pages, which have been accessed
@@ -312,7 +313,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  *
  * Return:	Number of pages attempted for reclamation.
  */
-unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, struct mm_struct *charge_mm)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -352,7 +353,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
 
 		mutex_lock(&encl_page->encl->lock);
-		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
+		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i], charge_mm);
 		if (ret) {
 			mutex_unlock(&encl_page->encl->lock);
 			goto skip;
@@ -384,7 +385,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 			continue;
 
 		encl_page = epc_page->owner;
-		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_reclaimer_write(epc_page, &backing[i], charge_mm);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
@@ -401,9 +402,9 @@ static bool sgx_should_reclaim_global(unsigned long watermark)
 		sgx_can_reclaim_global();
 }
 
-static void sgx_reclaim_pages_global(void)
+static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
-	sgx_reclaim_pages(&sgx_global_lru);
+	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
 /*
@@ -414,7 +415,7 @@ static void sgx_reclaim_pages_global(void)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages_global();
+		sgx_reclaim_pages_global(current->mm);
 }
 
 static int ksgxd(void *p)
@@ -437,7 +438,8 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim_global(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim_global(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages_global();
+			/* Indirect reclaim, no mm to charge, so NULL: */
+			sgx_reclaim_pages_global(NULL);
 
 		cond_resched();
 	}
@@ -460,11 +462,6 @@ static bool __init sgx_page_reclaimer_init(void)
 	return true;
 }
 
-bool current_is_ksgxd(void)
-{
-	return current == ksgxd_tsk;
-}
-
 static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 {
 	struct sgx_numa_node *node = &sgx_numa_nodes[nid];
@@ -619,7 +616,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages_global();
+		sgx_reclaim_pages_global(current->mm);
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 89adac646381..72b022755ff1 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -135,7 +135,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim);
-unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, struct mm_struct *charge_mm);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1


