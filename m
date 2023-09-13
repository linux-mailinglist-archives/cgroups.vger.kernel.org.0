Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7179DEEE
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjIMEJA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjIMEIy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40AE172C;
        Tue, 12 Sep 2023 21:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578130; x=1726114130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ks5Zz96UvQ4VHvJPX+CZrJICFZGB/asV0cSRYUmBsT4=;
  b=nU+LjNaEcauyPhXt6Vh5QSFucskDnaJ5/TtS+eit0R75AvqrT0IXSIHY
   b9PDYprUNBAOYmKGXvYgELA4jx3tZv4KOsxsxn5GfL5pZhd6c//uJ8hSM
   sUvh+KliK8vZeb6J1EEnmGCJMNMJPgZI7GQjgA3JBE3h5SInQxKvH17Ur
   5rhggfJFu3Pz3CZ93AA3t1mRSi+k4gVHasLnqMkTXUpPsv8aRhw4cg+O3
   cTnv42w7SUKgyNLZvY53j8AysJ1KethBMCtiD9dEPrag3HAaTzdwOovUd
   fFq9LwYBLkemldlW/sqJ5UCp13cSVrgOsehAXnUG9mUyArlmfGVBLKDbN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990355"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990355"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155919"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155919"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:42 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 06/18] x86/sgx: Introduce EPC page states
Date:   Tue, 12 Sep 2023 21:06:23 -0700
Message-Id: <20230913040635.28815-7-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use the lower 3 bits in the flags field of sgx_epc_page struct to
track EPC states in its life cycle and define an enum for possible
states. More state(s) will be added later.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V4:
- No changes other than required for patch reordering.

V3:
- This is new in V3 to replace the bit mask based approach (requested by Jarkko)
---
 arch/x86/kernel/cpu/sgx/encl.c  | 14 +++++++---
 arch/x86/kernel/cpu/sgx/ioctl.c |  7 +++--
 arch/x86/kernel/cpu/sgx/main.c  | 19 +++++++------
 arch/x86/kernel/cpu/sgx/sgx.h   | 49 ++++++++++++++++++++++++++++++---
 4 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f84ee2eeb058..d11d4111aa98 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -244,8 +244,12 @@ static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
 {
 	struct sgx_epc_page *epc_page = encl->secs.epc_page;
 
-	if (!epc_page)
+	if (!epc_page) {
 		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+		if (!IS_ERR(epc_page))
+			sgx_record_epc_page(epc_page,
+					    SGX_EPC_PAGE_UNRECLAIMABLE);
+	}
 
 	return epc_page;
 }
@@ -273,7 +277,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 
 	encl->secs_child_cnt++;
 	sgx_record_epc_page(epc_page,
-			    SGX_EPC_PAGE_RECLAIMER_TRACKED);
+			    SGX_EPC_PAGE_RECLAIMABLE);
 
 	return entry;
 }
@@ -400,7 +404,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl->secs_child_cnt++;
 
 	sgx_record_epc_page(epc_page,
-			    SGX_EPC_PAGE_RECLAIMER_TRACKED);
+			    SGX_EPC_PAGE_RECLAIMABLE);
 
 	phys_addr = sgx_get_epc_phys_addr(epc_page);
 	/*
@@ -1258,6 +1262,8 @@ struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
 		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
+	sgx_record_epc_page(epc_page,
+			    SGX_EPC_PAGE_UNRECLAIMABLE);
 
 	return epc_page;
 }
@@ -1317,7 +1323,7 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page)
 {
 	int ret;
 
-	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_STATE_MASK);
 
 	ret = __eremove(sgx_get_epc_virt_addr(page));
 	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 0d79dec408af..c28f074d5d71 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -113,6 +113,9 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->attributes = secs->attributes;
 	encl->attributes_mask = SGX_ATTR_UNPRIV_MASK;
 
+	sgx_record_epc_page(encl->secs.epc_page,
+			    SGX_EPC_PAGE_UNRECLAIMABLE);
+
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
 
@@ -323,7 +326,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	}
 
 	sgx_record_epc_page(epc_page,
-			    SGX_EPC_PAGE_RECLAIMER_TRACKED);
+			    SGX_EPC_PAGE_RECLAIMABLE);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -978,7 +981,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 			mutex_lock(&encl->lock);
 
 			sgx_record_epc_page(entry->epc_page,
-					    SGX_EPC_PAGE_RECLAIMER_TRACKED);
+					    SGX_EPC_PAGE_RECLAIMABLE);
 		}
 
 		/* Change EPC type */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index dec1d57cbff6..b26860399402 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -318,7 +318,7 @@ static void sgx_reclaim_pages(void)
 			/* The owner is freeing the page. No need to add the
 			 * page back to the list of reclaimable pages.
 			 */
-			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+			sgx_epc_page_reset_state(epc_page);
 	}
 	spin_unlock(&sgx_global_lru.lock);
 
@@ -344,6 +344,7 @@ static void sgx_reclaim_pages(void)
 
 skip:
 		spin_lock(&sgx_global_lru.lock);
+		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
 		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
 		spin_unlock(&sgx_global_lru.lock);
 
@@ -367,7 +368,7 @@ static void sgx_reclaim_pages(void)
 		sgx_reclaimer_write(epc_page, &backing[i]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
-		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+		sgx_epc_page_reset_state(epc_page);
 
 		sgx_free_epc_page(epc_page);
 	}
@@ -507,9 +508,9 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
 	spin_lock(&sgx_global_lru.lock);
-	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	WARN_ON_ONCE(sgx_epc_page_reclaimable(page->flags));
 	page->flags |= flags;
-	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
+	if (sgx_epc_page_reclaimable(flags))
 		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
 	spin_unlock(&sgx_global_lru.lock);
 }
@@ -527,7 +528,7 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
 	spin_lock(&sgx_global_lru.lock);
-	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
+	if (sgx_epc_page_reclaimable(page->flags)) {
 		/* The page is being reclaimed. */
 		if (list_empty(&page->list)) {
 			spin_unlock(&sgx_global_lru.lock);
@@ -535,7 +536,7 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
 		}
 
 		list_del(&page->list);
-		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+		sgx_epc_page_reset_state(page);
 	}
 	spin_unlock(&sgx_global_lru.lock);
 
@@ -607,6 +608,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
 	struct sgx_numa_node *node = section->node;
 
+	WARN_ON_ONCE(page->flags & (SGX_EPC_PAGE_STATE_MASK));
+
 	spin_lock(&node->lock);
 
 	page->owner = NULL;
@@ -614,7 +617,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 		list_add(&page->list, &node->sgx_poison_page_list);
 	else
 		list_add_tail(&page->list, &node->free_page_list);
-	page->flags = SGX_EPC_PAGE_IS_FREE;
+	page->flags = SGX_EPC_PAGE_FREE;
 
 	spin_unlock(&node->lock);
 	atomic_long_inc(&sgx_nr_free_pages);
@@ -715,7 +718,7 @@ int arch_memory_failure(unsigned long pfn, int flags)
 	 * If the page is on a free list, move it to the per-node
 	 * poison page list.
 	 */
-	if (page->flags & SGX_EPC_PAGE_IS_FREE) {
+	if (page->flags == SGX_EPC_PAGE_FREE) {
 		list_move(&page->list, &node->sgx_poison_page_list);
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 113d930fd087..2faeb40b345f 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -23,11 +23,36 @@
 #define SGX_NR_LOW_PAGES		32
 #define SGX_NR_HIGH_PAGES		64
 
-/* Pages, which are being tracked by the page reclaimer. */
-#define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
+enum sgx_epc_page_state {
+	/* Not tracked by the reclaimer:
+	 * Pages allocated for virtual EPC which are never tracked by the host
+	 * reclaimer; pages just allocated from free list but not yet put in
+	 * use; pages just reclaimed, but not yet returned to the free list.
+	 * Becomes FREE after sgx_free_epc()
+	 * Becomes RECLAIMABLE or UNRECLAIMABLE after sgx_record_epc()
+	 */
+	SGX_EPC_PAGE_NOT_TRACKED = 0,
+
+	/* Page is in the free list, ready for allocation
+	 * Becomes NOT_TRACKED after sgx_alloc_epc_page()
+	 */
+	SGX_EPC_PAGE_FREE = 1,
+
+	/* Page is in use and tracked in a reclaimable LRU list
+	 * Becomes NOT_TRACKED after sgx_drop_epc()
+	 */
+	SGX_EPC_PAGE_RECLAIMABLE = 2,
+
+	/* Page is in use but tracked in an unreclaimable LRU list. These are
+	 * only reclaimable when the whole enclave is OOM killed or the enclave
+	 * is released, e.g., VA, SECS pages
+	 * Becomes NOT_TRACKED after sgx_drop_epc()
+	 */
+	SGX_EPC_PAGE_UNRECLAIMABLE = 3,
 
-/* Pages on free list */
-#define SGX_EPC_PAGE_IS_FREE		BIT(1)
+};
+
+#define SGX_EPC_PAGE_STATE_MASK GENMASK(2, 0)
 
 struct sgx_epc_page {
 	unsigned int section;
@@ -37,6 +62,22 @@ struct sgx_epc_page {
 	struct list_head list;
 };
 
+static inline void sgx_epc_page_reset_state(struct sgx_epc_page *page)
+{
+	page->flags &= ~SGX_EPC_PAGE_STATE_MASK;
+}
+
+static inline void sgx_epc_page_set_state(struct sgx_epc_page *page, unsigned long flags)
+{
+	page->flags &= ~SGX_EPC_PAGE_STATE_MASK;
+	page->flags |= (flags & SGX_EPC_PAGE_STATE_MASK);
+}
+
+static inline bool sgx_epc_page_reclaimable(unsigned long flags)
+{
+	return SGX_EPC_PAGE_RECLAIMABLE == (flags & SGX_EPC_PAGE_STATE_MASK);
+}
+
 /*
  * Contains the tracking data for NUMA nodes having EPC pages. Most importantly,
  * the free page list local to the node is stored here.
-- 
2.25.1

