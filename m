Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795F640D74
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiLBSiG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiLBSht (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26FEBC9E;
        Fri,  2 Dec 2022 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006244; x=1701542244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r4FfaMTO7MJPJ0OHQyW69TD4X8I66ysGOSc1/fqmusM=;
  b=f9t+qXj6fIxfKIXvNV2C2mxUBRCHfJhXKY+oyEQB/gLa37IA7oOFyXHA
   L+chKoy0S52DrdDRUArO9tVRfK3EpJgCZnbq/YzJk6TaBOqNYuqtChca9
   Yyko7JIC5Ehpwz7eIZlnyeZ783EDb9tUUHVa7+olyQsXG6UktC3EdlLp4
   l+c+1lZtqjSP3egM9fjibOWL3hBAcOT/ND0Lcwlzg0jPVFDj9y65zRoJu
   IBmJyqFsIdZfxXwJK4ayP26BfDPiOOzUVPAN1wsvA6Elq1Swal9MMrace
   943JvaJKnYo0hFHBUPo1v6o6TGbxGsi2Ni8mYK6m9n21CV75EELz0BfJ/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724609"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724609"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717500"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717500"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:22 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 10/18] x86/sgx: Add option to ignore age of page during EPC reclaim
Date:   Fri,  2 Dec 2022 10:36:46 -0800
Message-Id: <20221202183655.3767674-11-kristen@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add a flag to sgx_reclaim_pages() to instruct it to ignore the age of
page, i.e. reclaim the page even if it's young.  The EPC cgroup will use
the flag to enforce its limits by draining the reclaimable lists before
resorting to other measures, e.g. forcefully reclaimable "unreclaimable"
pages by killing enclaves.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 46 +++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index a4a65eadfb79..db96483e2e74 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -31,6 +31,10 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  * with sgx_global_lru.lock acquired.
  */
 static struct sgx_epc_lru_lists sgx_global_lru;
+static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
@@ -278,6 +282,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 /**
  * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
+ * @ignore_age:		 Reclaim a page even if it is young
  *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
@@ -291,11 +296,12 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static int __sgx_reclaim_pages(int nr_to_scan)
+static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 {
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
+	struct sgx_epc_lru_lists *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
 	int ret;
@@ -332,7 +338,8 @@ static int __sgx_reclaim_pages(int nr_to_scan)
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_owner;
 
-		if (i == SGX_MAX_NR_TO_RECLAIM || !sgx_reclaimer_age(epc_page))
+		if (i == SGX_MAX_NR_TO_RECLAIM ||
+		    (!ignore_age && !sgx_reclaimer_age(epc_page)))
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
@@ -350,10 +357,11 @@ static int __sgx_reclaim_pages(int nr_to_scan)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
+		lru = sgx_lru_lists(epc_page);
+		spin_lock(&lru->lock);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-		sgx_epc_move_reclaimable(&sgx_global_lru, epc_page);
-		spin_unlock(&sgx_global_lru.lock);
+		sgx_epc_move_reclaimable(lru, epc_page);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 	}
@@ -377,11 +385,11 @@ static int __sgx_reclaim_pages(int nr_to_scan)
 	return i;
 }
 
-static int sgx_reclaim_pages(int nr_to_scan)
+static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 {
 	int ret;
 
-	ret = __sgx_reclaim_pages(nr_to_scan);
+	ret = __sgx_reclaim_pages(nr_to_scan, ignore_age);
 	cond_resched();
 	return ret;
 }
@@ -402,7 +410,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		__sgx_reclaim_pages(SGX_NR_TO_SCAN);
+		__sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 }
 
 static int ksgxd(void *p)
@@ -428,7 +436,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages(SGX_NR_TO_SCAN);
+			sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 	}
 
 	return 0;
@@ -522,15 +530,17 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
  */
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_lists *lru = sgx_lru_lists(page);
+
+	spin_lock(&lru->lock);
 	WARN_ON(page->flags & (SGX_EPC_PAGE_RECLAIMER_TRACKED |
 			       SGX_EPC_PAGE_RECLAIM_IN_PROGRESS));
 	page->flags |= flags;
 	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
-		sgx_epc_push_reclaimable(&sgx_global_lru, page);
+		sgx_epc_push_reclaimable(lru, page);
 	else
-		sgx_epc_push_unreclaimable(&sgx_global_lru, page);
-	spin_unlock(&sgx_global_lru.lock);
+		sgx_epc_push_unreclaimable(lru, page);
+	spin_unlock(&lru->lock);
 }
 
 /**
@@ -545,14 +555,16 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
  */
 int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_lists *lru = sgx_lru_lists(page);
+
+	spin_lock(&lru->lock);
 	if ((page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) &&
 	    (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS)) {
-		spin_unlock(&sgx_global_lru.lock);
+		spin_unlock(&lru->lock);
 		return -EBUSY;
 	}
 	list_del(&page->list);
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
 			 SGX_EPC_PAGE_RECLAIM_IN_PROGRESS |
@@ -607,7 +619,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages(SGX_NR_TO_SCAN);
+		sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-- 
2.38.1

