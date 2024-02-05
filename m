Return-Path: <cgroups+bounces-1360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F1684A866
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC41F26418
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816F149013;
	Mon,  5 Feb 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd5sGg3a"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87571468FE;
	Mon,  5 Feb 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167209; cv=none; b=TjLfPUKrRrvW9HlxAxxWHMz5a6KRoLRwWdPOWt4mLxicO0voaRCLNKgyzlsqSethI5sB9RxaveHL57hwYfvNFjL4MfFEDRjCJWkd/AyBw5W5cuXs9/tsJmO9T+wE8N6J7DUk94ooAzw6YBrldZ6BsKzUoVID1vKlkg8X5uZo8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167209; c=relaxed/simple;
	bh=Yhrp7k9I76o0grZ16pUBmgOI5IKl40orUcI3ubcyl24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Emn5f4m89mUQRPYnF/tdAQtVDVnPLDO1gDaTGEMzKJKqmbBr9HcLo+XVT2oMAWLAjPT3EGM/VGyptrQSI14auGhFYHaUSTtnUUWP5pLJ0VBMWsnGZL5GuVCDFH7XaB1x5TZYwfNthsaQqbYRl87NG0hkh8QDoP8eyEeEnRodo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd5sGg3a; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167208; x=1738703208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yhrp7k9I76o0grZ16pUBmgOI5IKl40orUcI3ubcyl24=;
  b=Pd5sGg3a7US8GWLHBOz31QGN9c3BYhHV7A98yEbPrTaDalKCGzREd6PO
   SRMNMNhcp7aLNGk2v/8uUe03dpPGdzAGdtkaxSGplmQFjpsTDuEWYFSko
   lqy1lkuzx4bo+i0/9913ha+9AUAuh9ffLSA5IVz0o2MM0pLeIXOUf8sd0
   ym5lXjs/D61vYbEvqgcn5C4f5iGuScGE8kSLgaxEFWJ3Ht+U5VA8bYsX7
   3Vj3WkK4ewHC9QromU+8Lx/yzwVlCNhnpNB8NsLQ2v+nS9ubTCrhy2jKD
   23O8jOlRNusP0C082B66d93nEoglMSDJjTRszXNrVQ/7FUkLTRW3M+N16
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960434"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960434"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245637"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:42 -0800
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
Subject: [PATCH v9 09/15] x86/sgx: Charge mem_cgroup for per-cgroup reclamation
Date: Mon,  5 Feb 2024 13:06:32 -0800
Message-Id: <20240205210638.157741-10-haitao.huang@linux.intel.com>
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

Enclave Page Cache(EPC) memory can be swapped out to regular system
memory, and the consumed memory should be charged to a proper
mem_cgroup. Currently the selection of mem_cgroup to charge is done in
sgx_encl_get_mem_cgroup(). But it only considers two contexts in which
the swapping can be done: normal tasks and the ksgxd kthread.
With the new EPC cgroup implementation, the swapping can also happen in
EPC cgroup work-queue threads. In those cases, it improperly selects the
root mem_cgroup to charge for the RAM usage.

Change sgx_encl_get_mem_cgroup() to handle non-task contexts only and
return the mem_cgroup of an mm_struct associated with the enclave. The
return is used to charge for EPC backing pages in all kthread cases.

Pass a flag into the top level reclamation function,
sgx_reclaim_pages(), to explicitly indicate whether it is called from a
background kthread. Internally, if the flag is true, switch the active
mem_cgroup to the one returned from sgx_encl_get_mem_cgroup(), prior to
any backing page allocation, in order to ensure that shmem page
allocations are charged to the enclave's cgroup.

Removed current_is_ksgxd() as it is no longer needed.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
V9:
- Reduce number of if statements. (Tim)

V8:
- Limit text paragraphs to 80 characters wide. (Jarkko)
---
 arch/x86/kernel/cpu/sgx/encl.c       | 38 +++++++++++++---------------
 arch/x86/kernel/cpu/sgx/encl.h       |  3 +--
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  7 ++---
 arch/x86/kernel/cpu/sgx/main.c       | 27 +++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h        |  3 ++-
 5 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..4e5948362060 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -993,9 +993,7 @@ static int __sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_inde
 }
 
 /*
- * When called from ksgxd, returns the mem_cgroup of a struct mm stored
- * in the enclave's mm_list. When not called from ksgxd, just returns
- * the mem_cgroup of the current task.
+ * Returns the mem_cgroup of a struct mm stored in the enclave's mm_list.
  */
 static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
 {
@@ -1003,14 +1001,6 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
 	struct sgx_encl_mm *encl_mm;
 	int idx;
 
-	/*
-	 * If called from normal task context, return the mem_cgroup
-	 * of the current task's mm. The remainder of the handling is for
-	 * ksgxd.
-	 */
-	if (!current_is_ksgxd())
-		return get_mem_cgroup_from_mm(current->mm);
-
 	/*
 	 * Search the enclave's mm_list to find an mm associated with
 	 * this enclave to charge the allocation to.
@@ -1047,27 +1037,33 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
+ * @indirect:	in ksgxd or EPC cgroup work queue context
+ *
+ * Create a backing page for loading data back into an EPC page with ELDU. This
+ * function takes a reference on a new backing page which must be dropped with a
+ * corresponding call to sgx_encl_put_backing().
  *
- * When called from ksgxd, sets the active memcg from one of the
- * mms in the enclave's mm_list prior to any backing page allocation,
- * in order to ensure that shmem page allocations are charged to the
- * enclave.  Create a backing page for loading data back into an EPC page with
- * ELDU.  This function takes a reference on a new backing page which
- * must be dropped with a corresponding call to sgx_encl_put_backing().
+ * When @indirect is true, sets the active memcg from one of the mms in the
+ * enclave's mm_list prior to any backing page allocation, in order to ensure
+ * that shmem page allocations are charged to the enclave.
  *
  * Return:
  *   0 on success,
  *   -errno otherwise.
  */
 int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
-			   struct sgx_backing *backing)
+			   struct sgx_backing *backing, bool indirect)
 {
-	struct mem_cgroup *encl_memcg = sgx_encl_get_mem_cgroup(encl);
-	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
+	struct mem_cgroup *encl_memcg;
+	struct mem_cgroup *memcg;
 	int ret;
 
-	ret = __sgx_encl_get_backing(encl, page_index, backing);
+	if (!indirect)
+		return  __sgx_encl_get_backing(encl, page_index, backing);
 
+	encl_memcg = sgx_encl_get_mem_cgroup(encl);
+	memcg = set_active_memcg(encl_memcg);
+	ret = __sgx_encl_get_backing(encl, page_index, backing);
 	set_active_memcg(memcg);
 	mem_cgroup_put(encl_memcg);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..549cd2e8d98b 100644
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
+			   struct sgx_backing *backing, bool indirect);
 void sgx_encl_put_backing(struct sgx_backing *backing);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 16b6d9f909eb..d399fda2b55e 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -93,9 +93,10 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
 /**
  * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs to reclaim pages
  * @root:	Root of the tree to start walking from.
+ * @indirect:   In ksgxd or EPC cgroup work queue context.
  * Return:	Number of pages reclaimed.
  */
-unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
+static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
 {
 	/*
 	 * Attempting to reclaim only a few pages will often fail and is
@@ -119,7 +120,7 @@ unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
 		rcu_read_unlock();
 
 		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
-		cnt += sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan);
+		cnt += sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan, indirect);
 
 		rcu_read_lock();
 		css_put(pos);
@@ -176,7 +177,7 @@ static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
 			break;
 
 		/* Keep reclaiming until above condition is met. */
-		sgx_epc_cgroup_reclaim_pages(epc_cg->cg);
+		sgx_epc_cgroup_reclaim_pages(epc_cg->cg, true);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4f5824c4751d..51904f191b97 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -254,7 +254,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 }
 
 static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
-				struct sgx_backing *backing)
+				struct sgx_backing *backing, bool indirect)
 {
 	struct sgx_encl_page *encl_page = epc_page->owner;
 	struct sgx_encl *encl = encl_page->encl;
@@ -270,7 +270,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
 		ret = sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
-					   &secs_backing);
+					   &secs_backing, indirect);
 		if (ret)
 			goto out;
 
@@ -304,9 +304,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * @lru:	The LRU from which pages are reclaimed.
  * @nr_to_scan: Pointer to the target number of pages to scan, must be less than
  *		SGX_NR_TO_SCAN.
+ * @indirect:	In ksgxd or EPC cgroup work queue contexts.
  * Return:	Number of pages reclaimed.
  */
-unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to_scan)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to_scan,
+			       bool indirect)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -348,7 +350,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
 
 		mutex_lock(&encl_page->encl->lock);
-		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
+		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i], indirect);
 		if (ret) {
 			mutex_unlock(&encl_page->encl->lock);
 			goto skip;
@@ -381,7 +383,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to
 			continue;
 
 		encl_page = epc_page->owner;
-		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_reclaimer_write(epc_page, &backing[i], indirect);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
@@ -399,11 +401,11 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
-static void sgx_reclaim_pages_global(void)
+static void sgx_reclaim_pages_global(bool indirect)
 {
 	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
 
-	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan);
+	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan, indirect);
 }
 
 /*
@@ -414,7 +416,7 @@ static void sgx_reclaim_pages_global(void)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages_global();
+		sgx_reclaim_pages_global(false);
 }
 
 static int ksgxd(void *p)
@@ -437,7 +439,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages_global();
+			sgx_reclaim_pages_global(true);
 
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
@@ -623,7 +620,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		 * Need to do a global reclamation if cgroup was not full but free
 		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
 		 */
-		sgx_reclaim_pages_global();
+		sgx_reclaim_pages_global(false);
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 2593c013d091..cfe906054d85 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -110,7 +110,8 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
-unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to_scan);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to_scan,
+			       bool indirect);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1


