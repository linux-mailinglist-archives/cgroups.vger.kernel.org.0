Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA67ABD6A
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjIWDHW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjIWDHJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432E180;
        Fri, 22 Sep 2023 20:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438423; x=1726974423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W4lWkvNcyZmnYgi3wRQrFdf4W2G8XS4+lTbHa80YL7g=;
  b=coxVdvqjtsJqYXoR1GpmC8dy9qPiHAu7cej4KsqB173KXZv7qI8fcjC2
   UB7Nmv/0aPkgItMbJS7ypKk1ursE9Ly3frXtekXDnvL79A/b70eqT7kzR
   8BVTcpu6gRGJAMHMWlcuYsMcAa4GsCjGhNrNBZNo75/jVJTQb9acIxrqw
   phlwbof/bVvXjELvc9i1XuKwAvtAkLS8pVVaVbv/X0o/Gs19xJ+O9vQBg
   +c8q3rn8gSg8ZsUqZZ5rokite65sizX/A1XMh94z+WwT/Ls0flY1emS2o
   pfpZGHtt5Ea+ouZSLEXRL8VgbgtTGgbQIvDFLFFEJDFdg4gOXITeKVd0t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466762"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466762"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048541"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048541"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:06 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Date:   Fri, 22 Sep 2023 20:06:45 -0700
Message-Id: <20230923030657.16148-7-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230923030657.16148-1-haitao.huang@linux.intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 97a53e34a8b4..f5afc8d65e22 100644
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
@@ -272,7 +276,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return ERR_CAST(epc_page);
 
 	encl->secs_child_cnt++;
-	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
 
 	return entry;
 }
@@ -398,7 +402,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->type = SGX_PAGE_TYPE_REG;
 	encl->secs_child_cnt++;
 
-	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
 
 	phys_addr = sgx_get_epc_phys_addr(epc_page);
 	/*
@@ -1256,6 +1260,8 @@ struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
 		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
+	sgx_record_epc_page(epc_page,
+			    SGX_EPC_PAGE_UNRECLAIMABLE);
 
 	return epc_page;
 }
@@ -1315,7 +1321,7 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page)
 {
 	int ret;
 
-	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_STATE_MASK);
 
 	ret = __eremove(sgx_get_epc_virt_addr(page));
 	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index a75eb44022a3..9a32bf5a1070 100644
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
 
@@ -322,7 +325,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
-	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -976,7 +979,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 
 			mutex_lock(&encl->lock);
 
-			sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
+			sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMABLE);
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

