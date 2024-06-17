Return-Path: <cgroups+bounces-3203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5BE90AE55
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D446B20D8E
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D61991D0;
	Mon, 17 Jun 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGGLkH+w"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359E198E98;
	Mon, 17 Jun 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628828; cv=none; b=qb9Yrhj2KVxFDWSAQcWBCLVSy+AysozbQuCujUqdj1nTSvm2Ae/QV1u4iaaeJhAM203efyYgh56zzRYqldMye2DehhwP5oRdQK7nrUxwK5+irwJ0qUob/Tp1pTBAsCikTONY+X0tbTRlauhA0Lioxgw1tmFzmAAyFJC704FtT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628828; c=relaxed/simple;
	bh=KtUbaJGCe66CR7VGRok9JORxLkx8Q2xuO3UyluJAlDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp/tu+SHbPHlR7pEs+xT/z7ENDyFMTljHilsNOo5ICxmANkgNybsXQrXpNjw7Beg4PMre3d9HRRTIztYrq0I4ZiWdDjhanJccfdT520w9Goqu21TNJuwAS2s/GYRP0NbsgglZpN4ZwFrenVjU6yQ54OBWgpQiq97Wl47SApuxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGGLkH+w; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628827; x=1750164827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KtUbaJGCe66CR7VGRok9JORxLkx8Q2xuO3UyluJAlDY=;
  b=DGGLkH+wnmFKgLBw9PUZMU6n9cbg/51bTQdhtVSpLDH/dHlsyW+P/Wlp
   yEp2irGymR8MeQalUOUql6uGPHDD2i8cFAcphgAa2N+bl4sGKupTaxI1M
   pBWznOJOKhRwGtQM6YQ8ok8gBTIy9xzmfSGph/la5YgyZu341FYNn3CBK
   h1NhF5BYYTQWOfoIUz7im558/LeVatZKD9YW92pPJO0xhT29lhUecaYKs
   BPHu9P/NsWveqYoFo0g5/55/mqmJ6Zx3ynIZhWLq/Z0iy4HdunwxH13Ab
   cScGbABaUpt2xZlGrG/HjM+KsxhP2w/S2wUUM6ZVmP/SWWw7zQJSB5tLP
   g==;
X-CSE-ConnectionGUID: DJGqV/fIQMiPQIAk6OL5zQ==
X-CSE-MsgGUID: WwfDblMGTROmADf6DbdJdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570940"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:44 -0700
X-CSE-ConnectionGUID: JgWGF71ZTHKqEllzPW8X3w==
X-CSE-MsgGUID: WFGd0r43R+W6LEAzd90lAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387562"
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
Subject: [PATCH v15 11/14] x86/sgx: Charge mem_cgroup for per-cgroup reclamation
Date: Mon, 17 Jun 2024 05:53:18 -0700
Message-ID: <20240617125321.36658-12-haitao.huang@linux.intel.com>
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

From: Haitao Huang <haitao.huang@linux.intel.com>

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
index fdadfb7c05fe..ec7f267d3e7a 100644
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
index 2c0a36be7cdd..e91fa5f5348d 100644
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
index 4dc04f4d046c..4dc067519504 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -136,7 +136,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim);
-unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, struct mm_struct *charge_mm);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.43.0


