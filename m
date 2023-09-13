Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1379DEEC
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjIMEJA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjIMEIy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCD5172B;
        Tue, 12 Sep 2023 21:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578130; x=1726114130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSHLe4sR+ZCA5OhAeQwvoCaKi8Vwwi+c6tqBlpXop9k=;
  b=LOT/HdI6VtyADBdmKimrHfAc5truBS9AQDdmt9FoMW3p7d4PEN4TMo3T
   cnbe/nLyUz0rrPMv3ipoJ/C23ATZ3jt4VUqmQcn5ZZwJ5xedviVYTxMHd
   oACjioobIEhFOazlyjVaRNKcatYiF8crSo7nmbgUT8XrLXTmD0B+YiDne
   0Ix9UjDTPiGJ9Tc5/NG3jpryISAo8kgZoaa4zV6MLM0XJV0uZsWiGDMs0
   BLguMKjGQGT5DSBFTmAPcUz4zt/AqWAPcajlMOb8ywKYWKueUfaRyQxjk
   4Aff8i2bdwyD5K8y5zv7edH+XOSBVzRg5O/ooS2mjsjCdSUfxOiQYbptt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990346"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990346"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155911"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155911"
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
Subject: [PATCH v4 05/18] x86/sgx: Store reclaimable EPC pages in sgx_epc_lru_lists
Date:   Tue, 12 Sep 2023 21:06:22 -0700
Message-Id: <20230913040635.28815-6-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

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
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- Code update needed for patch reordering
- Revised commit message.
---
 arch/x86/kernel/cpu/sgx/encl.c  |  8 +++++---
 arch/x86/kernel/cpu/sgx/ioctl.c | 10 ++++++----
 arch/x86/kernel/cpu/sgx/main.c  | 22 ++++++++++++----------
 arch/x86/kernel/cpu/sgx/sgx.h   |  4 ++--
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..f84ee2eeb058 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -272,7 +272,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return ERR_CAST(epc_page);
 
 	encl->secs_child_cnt++;
-	sgx_mark_page_reclaimable(entry->epc_page);
+	sgx_record_epc_page(epc_page,
+			    SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	return entry;
 }
@@ -398,7 +399,8 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->type = SGX_PAGE_TYPE_REG;
 	encl->secs_child_cnt++;
 
-	sgx_mark_page_reclaimable(encl_page->epc_page);
+	sgx_record_epc_page(epc_page,
+			    SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	phys_addr = sgx_get_epc_phys_addr(epc_page);
 	/*
@@ -714,7 +716,7 @@ void sgx_encl_release(struct kref *ref)
 			 * The page and its radix tree entry cannot be freed
 			 * if the page is being held by the reclaimer.
 			 */
-			if (sgx_unmark_page_reclaimable(entry->epc_page))
+			if (sgx_drop_epc_page(entry->epc_page))
 				continue;
 
 			sgx_encl_free_epc_page(entry->epc_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d390df21440..0d79dec408af 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -322,7 +322,8 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
-	sgx_mark_page_reclaimable(encl_page->epc_page);
+	sgx_record_epc_page(epc_page,
+			    SGX_EPC_PAGE_RECLAIMER_TRACKED);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -961,7 +962,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 			 * Prevent page from being reclaimed while mutex
 			 * is released.
 			 */
-			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+			if (sgx_drop_epc_page(entry->epc_page)) {
 				ret = -EAGAIN;
 				goto out_entry_changed;
 			}
@@ -976,7 +977,8 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 
 			mutex_lock(&encl->lock);
 
-			sgx_mark_page_reclaimable(entry->epc_page);
+			sgx_record_epc_page(entry->epc_page,
+					    SGX_EPC_PAGE_RECLAIMER_TRACKED);
 		}
 
 		/* Change EPC type */
@@ -1133,7 +1135,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
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

