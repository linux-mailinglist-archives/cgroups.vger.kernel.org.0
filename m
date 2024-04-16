Return-Path: <cgroups+bounces-2503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C38A618F
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E39A1F22EBF
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198E3FE55;
	Tue, 16 Apr 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBkEpTXf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B73A29C;
	Tue, 16 Apr 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237621; cv=none; b=DBAaxEKksx+7JJynKBOojWo99CPz2l669W98dnk/lDkBFL8wT4HNXPLzYakZQ1aBMywN1l+YQ3B7a6M9N8PRh4JCG7NIWZ1BxzXS+HpxohaGx97g1oSWKjRyXviypXoPwajzZd9ASgD6jJ6bzMlOw3wR+uVnSoHARcucgvCNaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237621; c=relaxed/simple;
	bh=vAH5+ikPrTq/z0eDlMC0ikctJKVXbrf59M2oz6H4Ms4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4jHsS15PZRXqmxg+5x2K9PF15SW/ALDZZQ6g2rVliKriVG0e5Cqt/ylZbGpA79nw2m9/dk0OenPteFkJL3M+Xi5J5E+s/ZPhFZywTMvWzj7+ovYdvFYsAczucLJapJonJ/eQEh7fpkgoNKYgKjhxB3mR+Yvd6ZyZJwSlec3q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBkEpTXf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237619; x=1744773619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vAH5+ikPrTq/z0eDlMC0ikctJKVXbrf59M2oz6H4Ms4=;
  b=mBkEpTXfIiYo75nbuT2hkUqkYHnMpOxhPjk5PXO0PUlFLHaNQzX2aeFJ
   D+kTK+QaRbX1jUqzbpBBg7i0b8l210bTncpEHQ3ULUTBJ1JlAHd+9obB1
   av2sn6/2AZSERPBZVrFhBEk0HiUkxd1/C/2zqg1qxwOGZE1t33uBLMGil
   XP07huMbFRg3ONSjrqwrB+heE7fMrKO9S2ACLnxy0OnnZm3tgtGAzVlG1
   S74+EtYloqGFzYXEf1xOPKw0fvNR3AAyjjM7boE0s0/fZYVdxOnKGYwYX
   CB76jT91k0AyPstZPNVncStXdX8s2Cl5XJJc+xulpdqbMUReB3beX6JLi
   w==;
X-CSE-ConnectionGUID: VOM4ZPwtT7e/EYJBiUEifw==
X-CSE-MsgGUID: guI0KZ6zTHeMnF47OyWnhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34043405"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="34043405"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:20:19 -0700
X-CSE-ConnectionGUID: MiQOE9d4SteG6JIr5l5RCA==
X-CSE-MsgGUID: apPOW6tnRWKP4AJnjvkJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22193654"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 20:20:18 -0700
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
Subject: [PATCH v12 10/14] x86/sgx: Charge mem_cgroup for per-cgroup reclamation
Date: Mon, 15 Apr 2024 20:20:07 -0700
Message-Id: <20240416032011.58578-11-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416032011.58578-1-haitao.huang@linux.intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
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
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 10 ++++++----
 arch/x86/kernel/cpu/sgx/main.c       | 29 +++++++++++++---------------
 arch/x86/kernel/cpu/sgx/sgx.h        |  2 +-
 5 files changed, 36 insertions(+), 37 deletions(-)

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
index 8151371a198b..2efc33476b0b 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -107,6 +107,7 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
 /**
  * sgx_cgroup_reclaim_pages() - reclaim EPC from a cgroup tree
  * @root:	The root of cgroup tree to reclaim from.
+ * @charge_mm:	The mm to charge for backing store allocation.
  *
  * This function performs a pre-order walk in the cgroup tree under the given
  * root, attempting to reclaim pages at each node until a fixed number of pages
@@ -115,7 +116,7 @@ static bool sgx_cgroup_lru_empty(struct misc_cg *root)
  * the LRUs are recently accessed, i.e., considered "too young" to reclaim, no
  * page will actually be reclaimed after walking the whole tree.
  */
-static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
+static void sgx_cgroup_reclaim_pages(struct misc_cg *root, struct mm_struct *charge_mm)
 {
 	struct cgroup_subsys_state *css_root;
 	struct cgroup_subsys_state *pos;
@@ -132,7 +133,7 @@ static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
 		rcu_read_unlock();
 
 		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
-		cnt += sgx_reclaim_pages(&sgx_cg->lru);
+		cnt += sgx_reclaim_pages(&sgx_cg->lru, charge_mm);
 
 		rcu_read_lock();
 		css_put(pos);
@@ -194,7 +195,8 @@ static void sgx_cgroup_reclaim_work_func(struct work_struct *work)
 	 * blocked until a worker makes its way through the global work queue.
 	 */
 	while (sgx_cgroup_should_reclaim(sgx_cg)) {
-		sgx_cgroup_reclaim_pages(sgx_cg->cg);
+		 /* Indirect reclaim, no mm to charge, so NULL: */
+		sgx_cgroup_reclaim_pages(sgx_cg->cg, NULL);
 		cond_resched();
 	}
 }
@@ -241,7 +243,7 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 			return -EBUSY;
 		}
 
-		sgx_cgroup_reclaim_pages(sgx_cg->cg);
+		sgx_cgroup_reclaim_pages(sgx_cg->cg, current->mm);
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b79c1d6cdc23..7f5428571c6a 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -253,8 +253,8 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 	}
 }
 
-static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
-				struct sgx_backing *backing)
+static void sgx_reclaimer_write(struct sgx_epc_page *epc_page, struct sgx_backing *backing,
+				struct mm_struct *charge_mm)
 {
 	struct sgx_encl_page *encl_page = epc_page->owner;
 	struct sgx_encl *encl = encl_page->encl;
@@ -270,7 +270,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
 		ret = sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
-					   &secs_backing);
+					   &secs_backing, charge_mm);
 		if (ret)
 			goto out;
 
@@ -289,6 +289,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 /**
  * sgx_reclaim_pages() - Attempt to reclaim a fixed number of pages from an LRU
  * @lru:	The LRU from which pages are reclaimed.
+ * @charge_mm:	The mm to charge for backing store allocation.
  *
  * Take a fixed number of pages from the head of a given LRU and reclaim them to
  * the enclave's private shmem files. Skip the pages, which have been accessed
@@ -304,7 +305,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  *
  * Return:	Number of pages attempted for reclamation.
  */
-unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, struct mm_struct *charge_mm)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -344,7 +345,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
 
 		mutex_lock(&encl_page->encl->lock);
-		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
+		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i], charge_mm);
 		if (ret) {
 			mutex_unlock(&encl_page->encl->lock);
 			goto skip;
@@ -376,7 +377,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 			continue;
 
 		encl_page = epc_page->owner;
-		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_reclaimer_write(epc_page, &backing[i], charge_mm);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
@@ -393,9 +394,9 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
-static void sgx_reclaim_pages_global(void)
+static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
 {
-	sgx_reclaim_pages(&sgx_global_lru);
+	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
 }
 
 /*
@@ -406,7 +407,7 @@ static void sgx_reclaim_pages_global(void)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages_global();
+		sgx_reclaim_pages_global(current->mm);
 }
 
 static int ksgxd(void *p)
@@ -429,7 +430,8 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages_global();
+			/* Indirect reclaim, no mm to charge, so NULL: */
+			sgx_reclaim_pages_global(NULL);
 
 		cond_resched();
 	}
@@ -452,11 +454,6 @@ static bool __init sgx_page_reclaimer_init(void)
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
@@ -611,7 +608,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
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


