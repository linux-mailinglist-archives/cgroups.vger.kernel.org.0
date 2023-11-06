Return-Path: <cgroups+bounces-182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152F7E293D
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB98A28156A
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC428E38;
	Mon,  6 Nov 2023 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExDgPGp8"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962F28E36
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 15:59:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F317134;
	Mon,  6 Nov 2023 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699286386; x=1730822386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNLv1SRYuFTxKKGWoPF57npETHhdWVhK7V/evmU3EZ0=;
  b=ExDgPGp89KgJMJ7spuC4pltQ9hAX5n570J9QAe5UtqbpKYr9axvIObTU
   63q9+9MM6moQyzIh3MmK04MxfJGCI7lbFdmwo3oP5PHiuB6d4IMWI0Axs
   Awmq4y+KSOX9M0YEG4/8SVLCRnGukWBPVw6lEHpKjztAg6Tt8JSDvMEMo
   CYgtOiCH2SjW+xVmwjltO3AJFqJ3SmKkMN8flR4TNGi9w9ZCsGQa3gLDw
   WvZQEIo0antl/HlTFUgdT5oZKqBjSF57ClLxRbvd9MKWA8aysSSBjDZ/r
   ICVhlM2hGuz1tGZUWwiE/QD10b1OZ53hLK0X9aktJLD+WVNdPpv02iEW8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="7935095"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="7935095"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 07:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1093820031"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="1093820031"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2023 07:59:43 -0800
From: Haitao Huang <haitao.huang@linux.intel.com>
To: haitao.huang@linux.intel.com
Cc: anakrish@microsoft.com,
	bp@alien8.de,
	cgroups@vger.kernel.org,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	jarkko@kernel.org,
	kristen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	mikko.ylinen@linux.intel.com,
	mingo@redhat.com,
	mkoutny@suse.com,
	sean.j.christopherson@intel.com,
	seanjc@google.com,
	sohil.mehta@intel.com,
	tglx@linutronix.de,
	tj@kernel.org,
	x86@kernel.org,
	yangjie@microsoft.com,
	zhanb@microsoft.com,
	zhiquan1.li@intel.com
Subject: [PATCH] x86/sgx: Charge proper mem_cgroup for usage due to EPC reclamation by cgroups
Date: Mon,  6 Nov 2023 07:58:59 -0800
Message-Id: <20231106155859.7251-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-11-haitao.huang@linux.intel.com>
References: <20231030182013.40086-11-haitao.huang@linux.intel.com>
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
the swapping can be done: normal task and the ksgxd kthread.
With the new EPC cgroup implementation, the swapping can also happen in
EPC cgroup work-queue threads. In those cases, it improperly selects the
root mem_cgroup to charge for the RAM usage.

Change sgx_encl_get_mem_cgroup() to handle non-task contexts only and
return the mem_cgroup of an mm_struct associated with the enclave. The
return is used to charge for EPC backing pages in all kthread cases.

Pass a flag into the top level reclamation function,
sgx_do_epc_reclamation(), to explicitly indicate whether it is called
from a background kthread. Internally, if the flag is true, switch the
active mem_cgroup to the one returned from sgx_encl_get_mem_cgroup(),
prior to any backing page allocation, in order to ensure that shmem page
allocations are charged to the enclave's cgroup.

Removed current_is_ksgxd() as it is no longer needed.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c       | 43 ++++++++++++++--------------
 arch/x86/kernel/cpu/sgx/encl.h       |  3 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  8 +++---
 arch/x86/kernel/cpu/sgx/main.c       | 26 +++++++----------
 arch/x86/kernel/cpu/sgx/sgx.h        |  2 +-
 5 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 17dc108d3ff7..930f5bd4b752 100644
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
@@ -1047,29 +1037,38 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
+ * @indirect:	in ksgxd or EPC cgroup work queue context
+ *
+ * Create a backing page for loading data back into an EPC page with ELDU. This function takes
+ * a reference on a new backing page which must be dropped with a corresponding call to
+ * sgx_encl_put_backing().
  *
- * When called from ksgxd, sets the active memcg from one of the
- * mms in the enclave's mm_list prior to any backing page allocation,
- * in order to ensure that shmem page allocations are charged to the
- * enclave.  Create a backing page for loading data back into an EPC page with
- * ELDU.  This function takes a reference on a new backing page which
- * must be dropped with a corresponding call to sgx_encl_put_backing().
+ * When @indirect is true, sets the active memcg from one of the mms in the enclave's mm_list
+ * prior to any backing page allocation, in order to ensure that shmem page allocations are
+ * charged to the enclave.
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
 
+	if (indirect) {
+		encl_memcg = sgx_encl_get_mem_cgroup(encl);
+		memcg = set_active_memcg(encl_memcg);
+	}
+
 	ret = __sgx_encl_get_backing(encl, page_index, backing);
 
-	set_active_memcg(memcg);
-	mem_cgroup_put(encl_memcg);
+	if (indirect) {
+		set_active_memcg(memcg);
+		mem_cgroup_put(encl_memcg);
+	}
 
 	return ret;
 }
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
index 110d44c0ef7c..9c82bfd531e6 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -131,7 +131,7 @@ void sgx_epc_cgroup_isolate_pages(struct misc_cg *root,
 }
 
 static unsigned int sgx_epc_cgroup_reclaim_pages(unsigned int nr_pages,
-						 struct misc_cg *root)
+						 struct misc_cg *root, bool indirect)
 {
 	LIST_HEAD(iso);
 	/*
@@ -143,7 +143,7 @@ static unsigned int sgx_epc_cgroup_reclaim_pages(unsigned int nr_pages,
 	nr_pages = min(nr_pages, SGX_NR_TO_SCAN_MAX);
 	sgx_epc_cgroup_isolate_pages(root, nr_pages, &iso);
 
-	return sgx_do_epc_reclamation(&iso);
+	return sgx_do_epc_reclamation(&iso, indirect);
 }
 
 /*
@@ -191,7 +191,7 @@ static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
 			break;
 
 		/* Keep reclaiming until above condition is met. */
-		sgx_epc_cgroup_reclaim_pages((unsigned int)(cur - max), epc_cg->cg);
+		sgx_epc_cgroup_reclaim_pages((unsigned int)(cur - max), epc_cg->cg, true);
 	}
 }
 
@@ -214,7 +214,7 @@ static int __sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg,
 			return -EBUSY;
 		}
 
-		if (!sgx_epc_cgroup_reclaim_pages(1, epc_cg->cg))
+		if (!sgx_epc_cgroup_reclaim_pages(1, epc_cg->cg, false))
 			/* All pages were too young to reclaim, try again */
 			schedule();
 	}
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c496b8f15b54..45036d41c797 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -274,7 +274,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 }
 
 static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
-				struct sgx_backing *backing)
+				struct sgx_backing *backing, bool indirect)
 {
 	struct sgx_encl_page *encl_page = epc_page->owner;
 	struct sgx_encl *encl = encl_page->encl;
@@ -290,7 +290,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
 		ret = sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
-					   &secs_backing);
+					   &secs_backing, indirect);
 		if (ret)
 			goto out;
 
@@ -346,6 +346,7 @@ unsigned int  sgx_isolate_epc_pages(struct sgx_epc_lru_list *lru, unsigned int n
 /**
  * sgx_do_epc_reclamation() - Perform reclamation for isolated EPC pages.
  * @iso:		List of isolated pages for reclamation
+ * @indirect:		In ksgxd or EPC cgroup workqueue threads
  *
  * Take a list of EPC pages and reclaim them to the enclave's private shmem files.  Do not
  * reclaim the pages that have been accessed since the last scan, and move each of those pages
@@ -362,7 +363,7 @@ unsigned int  sgx_isolate_epc_pages(struct sgx_epc_lru_list *lru, unsigned int n
  *
  * Return: number of pages successfully reclaimed.
  */
-unsigned int sgx_do_epc_reclamation(struct list_head *iso)
+unsigned int sgx_do_epc_reclamation(struct list_head *iso, bool indirect)
 {
 	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
 	struct sgx_epc_page *epc_page, *tmp;
@@ -384,7 +385,7 @@ unsigned int sgx_do_epc_reclamation(struct list_head *iso)
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
 
 		mutex_lock(&encl_page->encl->lock);
-		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
+		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i], indirect);
 		if (ret) {
 			mutex_unlock(&encl_page->encl->lock);
 			goto skip;
@@ -411,7 +412,7 @@ unsigned int sgx_do_epc_reclamation(struct list_head *iso)
 	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, iso, list) {
 		encl_page = epc_page->owner;
-		sgx_reclaimer_write(epc_page, &backing[i++]);
+		sgx_reclaimer_write(epc_page, &backing[i++], indirect);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		sgx_epc_page_reset_state(epc_page);
@@ -422,7 +423,7 @@ unsigned int sgx_do_epc_reclamation(struct list_head *iso)
 	return i;
 }
 
-static void sgx_reclaim_epc_pages_global(void)
+static void sgx_reclaim_epc_pages_global(bool indirect)
 {
 	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
 	LIST_HEAD(iso);
@@ -432,7 +433,7 @@ static void sgx_reclaim_epc_pages_global(void)
 	else
 		sgx_isolate_epc_pages(&sgx_global_lru, nr_to_scan, &iso);
 
-	sgx_do_epc_reclamation(&iso);
+	sgx_do_epc_reclamation(&iso, indirect);
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
@@ -449,7 +450,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_epc_pages_global();
+		sgx_reclaim_epc_pages_global(false);
 }
 
 static int ksgxd(void *p)
@@ -472,7 +473,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_epc_pages_global();
+			sgx_reclaim_epc_pages_global(true);
 
 		cond_resched();
 	}
@@ -495,11 +496,6 @@ static bool __init sgx_page_reclaimer_init(void)
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
@@ -653,7 +649,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		 * Need to do a global reclamation if cgroup was not full but free
 		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
 		 */
-		sgx_reclaim_epc_pages_global();
+		sgx_reclaim_epc_pages_global(false);
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 6a40f70ed96f..377625e2ba1d 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -167,7 +167,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
-unsigned int sgx_do_epc_reclamation(struct list_head *iso);
+unsigned int sgx_do_epc_reclamation(struct list_head *iso, bool indirect);
 unsigned int sgx_isolate_epc_pages(struct sgx_epc_lru_list *lru, unsigned int nr_to_scan,
 				   struct list_head *dst);
 
-- 
2.25.1


