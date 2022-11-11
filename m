Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D2A62614B
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKKSg2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiKKSgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571187C8D6;
        Fri, 11 Nov 2022 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191759; x=1699727759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIa/7h6XPbf5DpSxTVt6veE3s6+KUgB6b/1ZxHux3uI=;
  b=aaVhyy4smRD5mAabgZ3ld1/76uN6/RYyrnkt41wrAWLNLnnPHpHvROnb
   8hGBJGNEEZUWjA/7xvwdVP7T5BS690Ee47VAQnx5UZW3UIdy5DJBQE0+H
   1ydiNp9II13fXLkIk9UDHh3lvsr23J+FSMZBaNKZdSwXSA1joizIWtqdC
   +bAGuyLpnyNMVVGs3h4hcXkF/twa9Q5NBvBun+YcKUMREVMGCihSJhrqD
   F7UPK6coHJze3R1s8CED7ALYO58zMvBidrTmvcm02VYQpLoAPNq8MkQBB
   JTtRDtKzQg1UeTHfgxnQZVxN075YdiFrX/3tMbF8AckDQEKvHOOry0t85
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050336"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050336"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089221"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089221"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:52 -0800
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
Subject: [PATCH 07/26] x86/sgx: Use a list to track to-be-reclaimed pages during reclaim
Date:   Fri, 11 Nov 2022 10:35:12 -0800
Message-Id: <20221111183532.3676646-8-kristen@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Change sgx_reclaim_pages() to use a list rather than an array for
storing the epc_pages which will be reclaimed. This change is needed
to transition to the LRU implementation for EPC cgroup support.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 44 ++++++++++++++++------------------
 arch/x86/kernel/cpu/sgx/sgx.h  | 28 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8c451071fa91..c76a53b63fa2 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -288,18 +288,17 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  */
 static void __sgx_reclaim_pages(void)
 {
-	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
+	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
-	struct sgx_epc_page *epc_page;
 	pgoff_t page_index;
-	int cnt = 0;
+	LIST_HEAD(iso);
 	int ret;
 	int i;
 
 	spin_lock(&sgx_global_lru.lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = sgx_epc_pop_reclaimable(&sgx_global_lru);
+		epc_page = sgx_epc_peek_reclaimable(&sgx_global_lru);
 		if (!epc_page)
 			break;
 
@@ -307,18 +306,22 @@ static void __sgx_reclaim_pages(void)
 
 		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
 			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-			chunk[cnt++] = epc_page;
+			list_move_tail(&epc_page->list, &iso);
 		} else {
-			/* The owner is freeing the page. No need to add the
-			 * page back to the list of reclaimable pages.
+			/* The owner is freeing the page, remove it from the
+			 * LRU list
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+			list_del_init(&epc_page->list);
 		}
 	}
 	spin_unlock(&sgx_global_lru.lock);
 
-	for (i = 0; i < cnt; i++) {
-		epc_page = chunk[i];
+	if (list_empty(&iso))
+		return;
+
+	i = 0;
+	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_owner;
 
 		if (!sgx_reclaimer_age(epc_page))
@@ -333,6 +336,7 @@ static void __sgx_reclaim_pages(void)
 			goto skip;
 		}
 
+		i++;
 		encl_page->desc |= SGX_ENCL_PAGE_BEING_RECLAIMED;
 		mutex_unlock(&encl_page->encl->lock);
 		continue;
@@ -340,27 +344,19 @@ static void __sgx_reclaim_pages(void)
 skip:
 		spin_lock(&sgx_global_lru.lock);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-		sgx_epc_push_reclaimable(&sgx_global_lru, epc_page);
+		sgx_epc_move_reclaimable(&sgx_global_lru, epc_page);
 		spin_unlock(&sgx_global_lru.lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
-
-		chunk[i] = NULL;
-	}
-
-	for (i = 0; i < cnt; i++) {
-		epc_page = chunk[i];
-		if (epc_page)
-			sgx_reclaimer_block(epc_page);
 	}
 
-	for (i = 0; i < cnt; i++) {
-		epc_page = chunk[i];
-		if (!epc_page)
-			continue;
-
+	list_for_each_entry(epc_page, &iso, list)
+		sgx_reclaimer_block(epc_page);
+ 
+	i = 0;
+	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_owner;
-		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_reclaimer_write(epc_page, &backing[i++]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		epc_page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 04ca644928a8..29c0981d6310 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -116,6 +116,14 @@ static inline void __sgx_epc_page_list_push(struct list_head *list, struct sgx_e
 	list_add_tail(&page->list, list);
 }
 
+/*
+ * Must be called with queue lock acquired
+ */
+static inline void __sgx_epc_page_list_move(struct list_head *list, struct sgx_epc_page *page)
+{
+	list_move_tail(&page->list, list);
+}
+
 /*
  * Must be called with queue lock acquired
  */
@@ -131,14 +139,34 @@ static inline struct sgx_epc_page * __sgx_epc_page_list_pop(struct list_head *li
 	return epc_page;
 }
 
+/*
+ * Must be called with queue lock acquired
+ */
+static inline struct sgx_epc_page * __sgx_epc_page_list_peek(struct list_head *list)
+{
+	struct sgx_epc_page *epc_page;
+
+	if (list_empty(list))
+		return NULL;
+
+	epc_page = list_first_entry(list, struct sgx_epc_page, list);
+	return epc_page;
+}
+
 #define sgx_epc_pop_reclaimable(lru) \
 	__sgx_epc_page_list_pop(&(lru)->reclaimable)
 #define sgx_epc_push_reclaimable(lru, page) \
 	__sgx_epc_page_list_push(&(lru)->reclaimable, page)
+#define sgx_epc_peek_reclaimable(lru) \
+	__sgx_epc_page_list_peek(&(lru)->reclaimable)
+#define sgx_epc_move_reclaimable(lru, page) \
+	__sgx_epc_page_list_move(&(lru)->reclaimable, page)
 #define sgx_epc_pop_unreclaimable(lru) \
 	__sgx_epc_page_list_pop(&(lru)->unreclaimable)
 #define sgx_epc_push_unreclaimable(lru, page) \
 	__sgx_epc_page_list_push(&(lru)->unreclaimable, page)
+#define sgx_epc_peek_unreclaimable(lru) \
+	__sgx_epc_page_list_peek(&(lru)->unreclaimable)
 
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
-- 
2.37.3

