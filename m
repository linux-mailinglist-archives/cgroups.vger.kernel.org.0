Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490797ABD5E
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIWDHK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIWDHJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA51A8;
        Fri, 22 Sep 2023 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438422; x=1726974422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qotu9yJej/PeYxfuujfhn2qav8F09p8/KaLGJiCS8IU=;
  b=eybwKEgpuv88v8wpZO+dWFKclr0vjP4mv8d8XBtxVT1eKUiCKNMukkOQ
   Jc5ti+ve13nTnx7s4LnrVjTBemgMge/41qoqM8r3zm1DSPkV4ECPN0MLU
   1QNDC7TCHmCCz8grNeWdrjPUzkDCzlisv56jGJjf/eXpQvfAdfOa3BcXo
   FhZyCeSpvnG80INSwkyS56OqmOv2hS0yP2FMBWENsqinzSb1qlHgcANVO
   m8IcUA4MxbKcyAeX6WOTsdC5fhQJdHyEWjl/7RbRufE//a3Mi/XP/8wvX
   jCEdl6KLMeH7L8lXlzN91p+30BgxeUFHx6bOlTGTBJn8LD8NYeg680GRd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466754"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466754"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048536"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048536"
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
Subject: [PATCH v5 05/18] x86/sgx: Store reclaimable EPC pages in sgx_epc_lru_lists
Date:   Fri, 22 Sep 2023 20:06:44 -0700
Message-Id: <20230923030657.16148-6-haitao.huang@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Replace sgx_mark_page_reclaimable() and sgx_unmark_page_reclaimable()
with sgx_record_epc_page() and sgx_drop_epc_page(). The
sgx_record_epc_page() function adds the epc_page to the "reclaimable"
list in the sgx_epc_lru_lists struct, while sgx_drop_epc_page() removes
the page from the LRU list.

For now, this change serves as a straightforward replacement of the two
functions for pages tracked by the reclaimer. When the unreclaimable
list is added to track VA and SECS pages for cgroups, these functions
will be updated to add/remove them from the unreclaimable lists.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V5:
- style fixes (Jarkko)

V4:
- Code update needed for patch reordering
- Revised commit message.
---
 arch/x86/kernel/cpu/sgx/encl.c  |  6 +++---
 arch/x86/kernel/cpu/sgx/ioctl.c |  8 ++++----
 arch/x86/kernel/cpu/sgx/main.c  | 22 ++++++++++++----------
 arch/x86/kernel/cpu/sgx/sgx.h   |  4 ++--
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..97a53e34a8b4 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -272,7 +272,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return ERR_CAST(epc_page);
 
 	encl->secs_child_cnt++;
-	sgx_mark_page_reclaimable(entry->epc_page);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	return entry;
 }
@@ -398,7 +398,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->type = SGX_PAGE_TYPE_REG;
 	encl->secs_child_cnt++;
 
-	sgx_mark_page_reclaimable(encl_page->epc_page);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	phys_addr = sgx_get_epc_phys_addr(epc_page);
 	/*
@@ -714,7 +714,7 @@ void sgx_encl_release(struct kref *ref)
 			 * The page and its radix tree entry cannot be freed
 			 * if the page is being held by the reclaimer.
 			 */
-			if (sgx_unmark_page_reclaimable(entry->epc_page))
+			if (sgx_drop_epc_page(entry->epc_page))
 				continue;
 
 			sgx_encl_free_epc_page(entry->epc_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d390df21440..a75eb44022a3 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -322,7 +322,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
-	sgx_mark_page_reclaimable(encl_page->epc_page);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -961,7 +961,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 			 * Prevent page from being reclaimed while mutex
 			 * is released.
 			 */
-			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+			if (sgx_drop_epc_page(entry->epc_page)) {
 				ret = -EAGAIN;
 				goto out_entry_changed;
 			}
@@ -976,7 +976,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 
 			mutex_lock(&encl->lock);
 
-			sgx_mark_page_reclaimable(entry->epc_page);
+			sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 		}
 
 		/* Change EPC type */
@@ -1133,7 +1133,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 			goto out_unlock;
 		}
 
-		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+		if (sgx_drop_epc_page(entry->epc_page)) {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index afce51d6e94a..dec1d57cbff6 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -268,7 +268,6 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 			goto out;
 
 		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
-
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 
@@ -498,31 +497,34 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 }
 
 /**
- * sgx_mark_page_reclaimable() - Mark a page as reclaimable
+ * sgx_record_epc_page() - Add a page to the appropriate LRU list
  * @page:	EPC page
+ * @flags:	The type of page that is being recorded
  *
- * Mark a page as reclaimable and add it to the active page list. Pages
- * are automatically removed from the active list when freed.
+ * Mark a page with the specified flags and add it to the appropriate
+ * list.
  */
-void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
+void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
 	spin_lock(&sgx_global_lru.lock);
-	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
-	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	page->flags |= flags;
+	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
+		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
 	spin_unlock(&sgx_global_lru.lock);
 }
 
 /**
- * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
+ * sgx_drop_epc_page() - Remove a page from a LRU list
  * @page:	EPC page
  *
- * Clear the reclaimable flag and remove the page from the active page list.
+ * Clear the reclaimable flag if set and remove the page from its LRU.
  *
  * Return:
  *   0 on success,
  *   -EBUSY if the page is in the process of being reclaimed
  */
-int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
+int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
 	spin_lock(&sgx_global_lru.lock);
 	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 018414b2abe8..113d930fd087 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -101,8 +101,8 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_reclaim_direct(void);
-void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
-int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
+void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
+int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
 void sgx_ipi_cb(void *info);
-- 
2.25.1

