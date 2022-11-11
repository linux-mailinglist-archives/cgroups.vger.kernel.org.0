Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B144626149
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiKKSg1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiKKSgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF966CA0E;
        Fri, 11 Nov 2022 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191755; x=1699727755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xhlVwQG/KBxFjRGNP4mKqJ7NtCZV2S4HhsKxjA0yAU=;
  b=gvcGaXs+KbymuxRzE5frapAs59Q4LgQ5WrnsZhx20d5f63X8nAgORxmW
   5WLJhqZKD25BDMcjhi1YrU0rtEbgUmaNsFLfeSmTXg/XRxXclhhMkM4xk
   YAeF1rGol1Z4/4+9Qlq+f1lNSxQ+wwgjajWjN+VUKuXuQSjZ88x+1r6Vy
   6CrQOaKTdU+U7Y0/6YdHwEJs6Hu5uZnN4Yq/8KbVRujIib7CgoYbcE45K
   /5CnjqSL1ekKbDyZ3EjxBWzhXdzK4eAb7Ym72tWBQ7Mcx9/SIIuDKbv53
   Q9jIeaya88zax13Ipwg11VwEoxrmaXtW57XMMexzpaal+wucPmXLwe7Fc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050311"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089203"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089203"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:47 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 05/26] x86/sgx: Track epc pages on reclaimable or unreclaimable lists
Date:   Fri, 11 Nov 2022 10:35:10 -0800
Message-Id: <20221111183532.3676646-6-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221111183532.3676646-1-kristen@linux.intel.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace functions sgx_mark_page_reclaimable() and
sgx_unmark_page_reclaimable() with sgx_record_epc_page() and
sgx_drop_epc_page(). sgx_record_epc_page() wil add the epc_page
to the correct "reclaimable" or "unreclaimable" list in the
sgx_epc_lru struct. sgx_drop_epc_page() will delete the page
from the sgx_epc_lru list. Tracking pages that are not tracked by
the reclaimer in the LRU's "unreclaimable" list allows an OOM event
to cause all the pages in use by an enclave to be freed, regardless
of whether they were reclaimable pages or not.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 10 +++++++---
 arch/x86/kernel/cpu/sgx/ioctl.c | 11 +++++++----
 arch/x86/kernel/cpu/sgx/main.c  | 26 +++++++++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h   |  4 ++--
 arch/x86/kernel/cpu/sgx/virt.c  | 28 ++++++++++++++++++++--------
 5 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 4eaf9d21e71b..4683da9ef4f1 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -252,6 +252,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		epc_page = sgx_encl_eldu(&encl->secs, NULL);
 		if (IS_ERR(epc_page))
 			return ERR_CAST(epc_page);
+		sgx_record_epc_page(epc_page, 0);
 	}
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
@@ -259,7 +260,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return ERR_CAST(epc_page);
 
 	encl->secs_child_cnt++;
-	sgx_mark_page_reclaimable(entry->epc_page);
+	sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	return entry;
 }
@@ -375,7 +376,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->type = SGX_PAGE_TYPE_REG;
 	encl->secs_child_cnt++;
 
-	sgx_mark_page_reclaimable(encl_page->epc_page);
+	sgx_record_epc_page(encl_page->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	phys_addr = sgx_get_epc_phys_addr(epc_page);
 	/*
@@ -687,7 +688,7 @@ void sgx_encl_release(struct kref *ref)
 			 * The page and its radix tree entry cannot be freed
 			 * if the page is being held by the reclaimer.
 			 */
-			if (sgx_unmark_page_reclaimable(entry->epc_page))
+			if (sgx_drop_epc_page(entry->epc_page))
 				continue;
 
 			sgx_encl_free_epc_page(entry->epc_page);
@@ -703,6 +704,7 @@ void sgx_encl_release(struct kref *ref)
 	xa_destroy(&encl->page_array);
 
 	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 	}
@@ -711,6 +713,7 @@ void sgx_encl_release(struct kref *ref)
 		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
 					   list);
 		list_del(&va_page->list);
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
 	}
@@ -1218,6 +1221,7 @@ struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
 		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
+	sgx_record_epc_page(epc_page, 0);
 
 	return epc_page;
 }
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 9a1bb3c3211a..aca80a3f38a1 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -48,6 +48,7 @@ void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 	encl->page_cnt--;
 
 	if (va_page) {
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		list_del(&va_page->list);
 		kfree(va_page);
@@ -113,6 +114,8 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->attributes = secs->attributes;
 	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
 
+	sgx_record_epc_page(encl->secs.epc_page, 0);
+
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
 
@@ -322,7 +325,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
-	sgx_mark_page_reclaimable(encl_page->epc_page);
+	sgx_record_epc_page(encl_page->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -958,7 +961,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 			 * Prevent page from being reclaimed while mutex
 			 * is released.
 			 */
-			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+			if (sgx_drop_epc_page(entry->epc_page)) {
 				ret = -EAGAIN;
 				goto out_entry_changed;
 			}
@@ -973,7 +976,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 
 			mutex_lock(&encl->lock);
 
-			sgx_mark_page_reclaimable(entry->epc_page);
+			sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
 		}
 
 		/* Change EPC type */
@@ -1130,7 +1133,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 			goto out_unlock;
 		}
 
-		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+		if (sgx_drop_epc_page(entry->epc_page)) {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index aa938e4d4a73..3b09433ffd85 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -262,7 +262,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 			goto out;
 
 		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
-
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 
@@ -499,31 +499,35 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 }
 
 /**
- * sgx_mark_page_reclaimable() - Mark a page as reclaimable
+ * sgx_record_epc_page() - Add a page to the LRU tracking
  * @page:	EPC page
  *
- * Mark a page as reclaimable and add it to the active page list. Pages
- * are automatically removed from the active list when freed.
+ * Mark a page with the specified flags and add it to the appropriate
+ * (un)reclaimable list.
  */
-void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
+void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
 	spin_lock(&sgx_global_lru.lock);
-	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
-	sgx_epc_push_reclaimable(&sgx_global_lru, page);
+	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	page->flags |= flags;
+	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
+		sgx_epc_push_reclaimable(&sgx_global_lru, page);
+	else
+		sgx_epc_push_unreclaimable(&sgx_global_lru, page);
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
@@ -533,9 +537,9 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 			return -EBUSY;
 		}
 
-		list_del(&page->list);
 		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
+	list_del(&page->list);
 	spin_unlock(&sgx_global_lru.lock);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index aac7d4feb0fa..969606615211 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -140,8 +140,8 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_reclaim_direct(void);
-void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
-int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
+void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
+int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
 void sgx_ipi_cb(void *info);
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 776ae5c1c032..0eabc4db91d0 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -64,6 +64,8 @@ static int __sgx_vepc_fault(struct sgx_vepc *vepc,
 		goto err_delete;
 	}
 
+	sgx_record_epc_page(epc_page, 0);
+
 	return 0;
 
 err_delete:
@@ -148,6 +150,7 @@ static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
 		return ret;
 	}
 
+	sgx_drop_epc_page(epc_page);
 	sgx_free_epc_page(epc_page);
 	return 0;
 }
@@ -220,8 +223,15 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 		 * have been removed, the SECS page must have a child on
 		 * another instance.
 		 */
-		if (sgx_vepc_free_page(epc_page))
+		if (sgx_vepc_free_page(epc_page)) {
+			/*
+			 * Drop the page before adding it to the list of SECS
+			 * pages.  Moving the page off the unreclaimable list
+			 * needs to be done under the LRU's spinlock.
+			 */
+			sgx_drop_epc_page(epc_page);
 			list_add_tail(&epc_page->list, &secs_pages);
+		}
 
 		xa_erase(&vepc->page_array, index);
 	}
@@ -236,15 +246,17 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 	mutex_lock(&zombie_secs_pages_lock);
 	list_for_each_entry_safe(epc_page, tmp, &zombie_secs_pages, list) {
 		/*
-		 * Speculatively remove the page from the list of zombies,
-		 * if the page is successfully EREMOVE'd it will be added to
-		 * the list of free pages.  If EREMOVE fails, throw the page
-		 * on the local list, which will be spliced on at the end.
+		 * If EREMOVE fails, throw the page on the local list, which
+		 * will be spliced on at the end.
+		 *
+		 * Note, this abuses sgx_drop_epc_page() to delete the page off
+		 * the list of zombies, but this is a very rare path (probably
+		 * never hit in production).  It's not worth special casing the
+		 * free path for this super rare case just to avoid taking the
+		 * LRU's spinlock.
 		 */
-		list_del(&epc_page->list);
-
 		if (sgx_vepc_free_page(epc_page))
-			list_add_tail(&epc_page->list, &secs_pages);
+			list_move_tail(&epc_page->list, &secs_pages);
 	}
 
 	if (!list_empty(&secs_pages))
-- 
2.37.3

