Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC95E694F
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIVRNK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiIVRNH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:13:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3DDF8595;
        Thu, 22 Sep 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866786; x=1695402786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=op2/5yqxd7J9ovTWhDUl48f07ozoWvtTyl9KC7Oy26o=;
  b=niBZMfobb9IJr4uj6nd1v5YrrGcPHm0dy5USD244PtxSe8gBA+e06JQD
   3kRtYCla4Lb1nUXO8UuRzwmXRy/oIBr4KGrVFlLr3kbe8u9u9iVzst+ly
   eDr8Gz9bXtM6d67HuCJiensDQwqNtyUXJpCFAzlKJE/B8SAfeg9iuNmpT
   FZz0doqGBDQZbmMWRBFgg+Ea7wuItW9zFmDxlxHfuIO5SQdvSf9C9qNfO
   kaBEv6wrxFA+vZaUttw5Zh6eD6hiOPqPcdeJFdhiCTMxei7ILnbgWZkho
   oHoLVubcHnS5a7ZW4x3fOuO8Xew7HI1x5mdFM3o5WVik4Vwx884DspHOk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283421379"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283421379"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762270184"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:42 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 15/20] x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
Date:   Thu, 22 Sep 2022 10:10:52 -0700
Message-Id: <20220922171057.1236139-16-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the isolation loop into a standalone helper, sgx_isolate_pages(),
in preparation for existence of multiple LRUs.  Expose the helper to
other SGX code so that it can be called from the EPC cgroup code, e.g.
to isolate pages from a single cgroup LRU.  Exposing the isolation loop
allows the cgroup iteration logic to be wholly encapsulated within the
cgroup code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 72 ++++++++++++++++++++--------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 1791881aa1b1..151ad720a4ec 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -280,10 +280,47 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 }
 
 /**
- * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
+ * sgx_isolate_epc_pages - Isolate pages from an LRU for reclaim
+ * @lru		LRU from which to reclaim
+ * @nr_to_scan	Number of pages to scan for reclaim
+ * @dst		Destination list to hold the isolated pages
+ */
+void sgx_isolate_epc_pages(struct sgx_epc_lru *lru, int *nr_to_scan,
+			   struct list_head *dst)
+{
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+
+	spin_lock(&lru->lock);
+	for (; *nr_to_scan > 0; --(*nr_to_scan)) {
+		if (list_empty(&lru->reclaimable))
+			break;
+
+		epc_page = list_first_entry(&lru->reclaimable,
+					    struct sgx_epc_page, list);
+
+		encl_page = epc_page->owner;
+		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_PAGE_ENCLAVE)))
+			continue;
+
+		if (kref_get_unless_zero(&encl_page->encl->refcount)) {
+			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
+			list_move_tail(&epc_page->list, dst);
+		} else {
+			/* The owner is freeing the page, remove it from the
+			 * LRU list
+			 */
+			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+			list_del_init(&epc_page->list);
+		}
+	}
+	spin_unlock(&lru->lock);
+}
+
+/**
  * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
- * @nr_to_scan:		 Number of EPC pages to scan for reclaim
- * @ignore_age:		 Reclaim a page even if it is young
+ * @nr_to_scan:		Number of EPC pages to scan for reclaim
+ * @ignore_age:		Reclaim a page even if it is young
  *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
@@ -302,42 +339,19 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age)
 {
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
-	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page, *tmp;
+	struct sgx_encl_page *encl_page;
 	struct sgx_epc_lru *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
+	int i = 0;
 	int ret;
-	int i;
-
-	spin_lock(&sgx_global_lru.lock);
-	for (i = 0; i < nr_to_scan; i++) {
-		if (list_empty(&sgx_global_lru.reclaimable))
-			break;
-
-		epc_page = list_first_entry(&sgx_global_lru.reclaimable,
-					    struct sgx_epc_page, list);
-		encl_page = epc_page->owner;
-		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_PAGE_ENCLAVE)))
-			continue;
 
-		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
-			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-			list_move_tail(&epc_page->list, &iso);
-		} else {
-			/* The owner is freeing the page, remove it from the
-			 * LRU list
-			 */
-			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
-			list_del_init(&epc_page->list);
-		}
-	}
-	spin_unlock(&sgx_global_lru.lock);
+	sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
 
 	if (list_empty(&iso))
 		goto out;
 
-	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->owner;
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index a2042303a666..0598d534371b 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -114,6 +114,8 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
 int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age);
+void sgx_isolate_epc_pages(struct sgx_epc_lru *lru, int *nr_to_scan,
+			   struct list_head *dst);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.37.3

