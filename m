Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A39640D69
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiLBSh3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiLBShP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576EBEDD4D;
        Fri,  2 Dec 2022 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006233; x=1701542233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FAwE3GKmpLc7cwMFuZTK8aRPKxUsCUSpv5pSdwsqWPQ=;
  b=Ms2hcNGdTwatlgqSU7ec4xBy21vbehj3JCOMEbeBxrJ/nahdq5E7zSrW
   tY9+QTkKj5SKmmuVsdwd64VbavZkbAzPRWm/dahmRJss/MDtYvPM+kcrN
   /RC38sLT0b8FFGoTwyDq60QjGaUsdbT5bwV2HZ0ijyHNTN9VdVqfT5Z5w
   6mtrT8UNwS03Q43pDBjbEbyz9jasN5xD3eCpx8BNWyyTlaOSasrA7JFhI
   o0UWtea9hf31vc4bccwrGRTa/L/co1hqPx7KGBYRT+K52iplFMwSQZKzH
   lDdJ+a3dvYeTLgvcM4FKPz615baGrWqkZR4AkaF6JVaO0yFRXaU4vhtAO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724529"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724529"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717399"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717399"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:11 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 04/18] x86/sgx: Use sgx_epc_lru_lists for existing active page list
Date:   Fri,  2 Dec 2022 10:36:40 -0800
Message-Id: <20221202183655.3767674-5-kristen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202183655.3767674-1-kristen@linux.intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
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

Replace the existing sgx_active_page_list and its spinlock with
a global sgx_epc_lru_lists struct.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 39 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ffce6fc70a1f..447cf4b8580c 100644
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
+static struct sgx_epc_lru_lists sgx_global_lru;
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
@@ -298,14 +297,12 @@ static void __sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		if (list_empty(&sgx_active_page_list))
+		epc_page = sgx_epc_pop_reclaimable(&sgx_global_lru);
+		if (!epc_page)
 			break;
 
-		epc_page = list_first_entry(&sgx_active_page_list,
-					    struct sgx_epc_page, list);
-		list_del_init(&epc_page->list);
 		encl_page = epc_page->encl_owner;
 
 		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0)
@@ -316,7 +313,7 @@ static void __sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_reclaimer_lock);
+	spin_unlock(&sgx_global_lru.lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -339,9 +336,9 @@ static void __sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_reclaimer_lock);
-		list_add_tail(&epc_page->list, &sgx_active_page_list);
-		spin_unlock(&sgx_reclaimer_lock);
+		spin_lock(&sgx_global_lru.lock);
+		sgx_epc_push_reclaimable(&sgx_global_lru, epc_page);
+		spin_unlock(&sgx_global_lru.lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -378,7 +375,7 @@ static void sgx_reclaim_pages(void)
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_active_page_list);
+	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
 /*
@@ -433,6 +430,8 @@ static bool __init sgx_page_reclaimer_init(void)
 
 	ksgxd_tsk = tsk;
 
+	sgx_lru_init(&sgx_global_lru);
+
 	return true;
 }
 
@@ -508,10 +507,10 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
  */
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_reclaimer_lock);
+	spin_lock(&sgx_global_lru.lock);
 	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
-	list_add_tail(&page->list, &sgx_active_page_list);
-	spin_unlock(&sgx_reclaimer_lock);
+	sgx_epc_push_reclaimable(&sgx_global_lru, page);
+	spin_unlock(&sgx_global_lru.lock);
 }
 
 /**
@@ -526,18 +525,18 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
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
@@ -574,7 +573,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_active_page_list))
+		if (list_empty(&sgx_global_lru.reclaimable))
 			return ERR_PTR(-ENOMEM);
 
 		if (!reclaim) {
-- 
2.38.1

