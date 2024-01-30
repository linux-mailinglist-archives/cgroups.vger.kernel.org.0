Return-Path: <cgroups+bounces-1269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7CB8418E0
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8B21C23DCF
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B0381D9;
	Tue, 30 Jan 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPQpumpv"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A88381B6;
	Tue, 30 Jan 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580588; cv=none; b=VEZ4oxSo2KxWxMQdFsbkPo+i/B6lehn5KZa1uMjfCS+0yyQUbxaINuDxS7tXHEHPGNkn5nSrmDRWkzoW1EU2GB08dUpHGDnAfiDImiDmx1kdKR9aM4wi/o1ln806XgxCy3C1RRt5BVHPJwjISwtfRpQ5k5S1KBhv9B+kkV7OwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580588; c=relaxed/simple;
	bh=JfM/ZcJB3Qb0I3vm5nhyOVFVq3TPAFx7TTYvObPoqg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpWcf9VZjDSby6RX0b3GPHEyYSWa/J+LmvrriIL10MxpwGBU3CuYi7fSn2akRuRN4ttDNNsoxFtVJAXm8aNFHy5anL4W0GwHRT24qL5ILkL8m0STDOJxU2xb3KDaZ7QFWI8fjxtJUeTHGjXsBn9MLmSv/AysF9CgcDZtNK/74Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPQpumpv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580587; x=1738116587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfM/ZcJB3Qb0I3vm5nhyOVFVq3TPAFx7TTYvObPoqg4=;
  b=aPQpumpvbZb2KkRIDDiz4cDar3QaBUctAFdS/7AOiLeED9nMLpax6bxn
   VBW/fWAZsu7/CufoVrKldbylmWhbxXm8EjbGAGUR1OH14k41gvr2RYo22
   xFt+9SFX5bh797B30NghkcrrH2/Irle3TscYXVRRtqz9tZZuq+0narB+j
   SBfrlirf9DxD6Nwhl9EUw5qHW+73l3txcCOpEvLuXg3E+4aJW+RZhqMqi
   OMGRlsIWJVRmV2znkPdd5zotUWnEgbFRJehFpGouVv72rOBmuB4hh/Pyg
   CRDgl3acxoJ02+aavP/0g6+b/uPwRBaTUfSVD/HO9GZxL/To9ZfbnBW9X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16530986"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16530986"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042345"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042345"
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
Subject: [PATCH v8 09/15] x86/sgx: Charge mem_cgroup for per-cgroup reclamation
Date: Mon, 29 Jan 2024 18:09:32 -0800
Message-Id: <20240130020938.10025-10-haitao.huang@linux.intel.com>
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
V8:
- Limit text paragraphs to 80 characters wide. (Jarkko)
---
 arch/x86/kernel/cpu/sgx/encl.c       | 43 ++++++++++++++--------------
 arch/x86/kernel/cpu/sgx/encl.h       |  3 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c |  7 +++--
 arch/x86/kernel/cpu/sgx/main.c       | 27 ++++++++---------
 arch/x86/kernel/cpu/sgx/sgx.h        |  3 +-
 5 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..348e8b58abeb 100644
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
index 8858a0850f8a..cbcb7b0de3fe 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -85,9 +85,10 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
 /**
  * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs to reclaim pages
  * @root:	Root of the tree to start walking
+ * @indirect:   In ksgxd or EPC cgroup work queue context.
  * Return:	Number of pages reclaimed.
  */
-unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
+static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
 {
 	/*
 	 * Attempting to reclaim only a few pages will often fail and is
@@ -111,7 +112,7 @@ unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
 		rcu_read_unlock();
 
 		epc_cg = sgx_epc_cgroup_from_misc_cg(css_misc(pos));
-		cnt += sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan);
+		cnt += sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan, indirect);
 
 		rcu_read_lock();
 		css_put(pos);
@@ -168,7 +169,7 @@ static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
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


