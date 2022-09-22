Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7465E693E
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiIVRLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiIVRLT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:11:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9CFF3C0;
        Thu, 22 Sep 2022 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866677; x=1695402677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SP1h/AVDS1rYjbGfp3sx5WI8G6QhYX2mnj2uQhxeucs=;
  b=Av1poSON40f8mP1dvl/8MU30CTHglbebMGhwX8KiOBji0rVtMleYjtaR
   gQ8ezGe+37aqkam+quptBqrBou04MXWfdPZ6kA6Es/9FHphpWSh7AHI0i
   bGwHK4RrySoq0qtcCOgB5HpQnplpDQOKa1Ve7pySDNdr5wgoZ+SHKS27b
   BRZ9ob9yQtInzquR5ZE9u2Ek1u2N4DTPMct5f/WGLJnAtYCbzH/mMRkMv
   X8KfHwm/rfv73RNy+meRwKRDaD9yagFJB1h27By+mZOJ/CNVQV2EUOFu2
   2Sr+anBkSN5OTPiTdNT4xBw6HyZnIdXYJJIRJBMqiG1V9hWzqjZnpl2Vu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326689848"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326689848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762269906"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:14 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 04/20] x86/sgx: Add 'struct sgx_epc_lru' to encapsulate lru list(s)
Date:   Thu, 22 Sep 2022 10:10:41 -0700
Message-Id: <20220922171057.1236139-5-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Wrap the existing reclaimable list and its spinlock in a struct to
minimize the code changes needed to handle multiple LRUs as well as
reclaimable and non-reclaimable lists, both of which will be introduced
and used by SGX EPC cgroups.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 37 +++++++++++++++++-----------------
 arch/x86/kernel/cpu/sgx/sgx.h  | 11 ++++++++++
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4cdeb915dc86..af68dc1c677b 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -26,10 +26,9 @@ static DEFINE_XARRAY(sgx_epc_address_space);
 
 /*
  * These variables are part of the state of the reclaimer, and must be accessed
- * with sgx_reclaimer_lock acquired.
+ * with sgx_global_lru.lock acquired.
  */
-static LIST_HEAD(sgx_active_page_list);
-static DEFINE_SPINLOCK(sgx_reclaimer_lock);
+static struct sgx_epc_lru sgx_global_lru;
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
@@ -298,12 +297,12 @@ static void sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		if (list_empty(&sgx_active_page_list))
+		if (list_empty(&sgx_global_lru.reclaimable))
 			break;
 
-		epc_page = list_first_entry(&sgx_active_page_list,
+		epc_page = list_first_entry(&sgx_global_lru.reclaimable,
 					    struct sgx_epc_page, list);
 		list_del_init(&epc_page->list);
 		encl_page = epc_page->owner;
@@ -316,7 +315,7 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_reclaimer_lock);
+	spin_unlock(&sgx_global_lru.lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -339,9 +338,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_reclaimer_lock);
-		list_add_tail(&epc_page->list, &sgx_active_page_list);
-		spin_unlock(&sgx_reclaimer_lock);
+		spin_lock(&sgx_global_lru.lock);
+		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
+		spin_unlock(&sgx_global_lru.lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -374,7 +373,7 @@ static void sgx_reclaim_pages(void)
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_active_page_list);
+	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
 /*
@@ -427,6 +426,8 @@ static bool __init sgx_page_reclaimer_init(void)
 
 	ksgxd_tsk = tsk;
 
+	sgx_lru_init(&sgx_global_lru);
+
 	return true;
 }
 
@@ -502,10 +503,10 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
  */
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
-	list_add_tail(&page->list, &sgx_active_page_list);
-	spin_unlock(&sgx_reclaimer_lock);
+	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+	spin_unlock(&sgx_global_lru.lock);
 }
 
 /**
@@ -520,18 +521,18 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
  */
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
 		/* The page is being reclaimed. */
 		if (list_empty(&page->list)) {
-			spin_unlock(&sgx_reclaimer_lock);
+			spin_unlock(&sgx_global_lru.lock);
 			return -EBUSY;
 		}
 
 		list_del(&page->list);
 		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_reclaimer_lock);
+	spin_unlock(&sgx_global_lru.lock);
 
 	return 0;
 }
@@ -564,7 +565,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_active_page_list))
+		if (list_empty(&sgx_global_lru.reclaimable))
 			return ERR_PTR(-ENOMEM);
 
 		if (!reclaim) {
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 5a7e858a8f98..7b208ee8eb45 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -83,6 +83,17 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+struct sgx_epc_lru {
+	spinlock_t lock;
+	struct list_head reclaimable;
+};
+
+static inline void sgx_lru_init(struct sgx_epc_lru *lru)
+{
+	spin_lock_init(&lru->lock);
+	INIT_LIST_HEAD(&lru->reclaimable);
+}
+
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
-- 
2.37.3

