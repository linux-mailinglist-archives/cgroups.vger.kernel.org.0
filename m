Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7156751400
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjGLXCt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjGLXCP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ECB19B;
        Wed, 12 Jul 2023 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202934; x=1720738934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHo09Hp6a2Hqq4tdVzNvgVvRLKdzq3gAOdGs+9yItKc=;
  b=BCrZqv8D//PEsmlAShnTqAtwqxvE19Xty4N06cpFFsolhdYKbZuVh7Em
   BPEYZXwoNeaHXAUTXu4FBgtmh5ct/4E5gEvamsADKTN7v59KQMis47oz9
   2cwzvkDP1ZPx342kB21f/dQ97475cXUqZSG+y3wp73mdUVvjo9L3vuhQ8
   ChNtFJyunhWw85pfargacO5Mzf7ydZFe9zcDh48RMtOx9hxIOitc+N4tX
   teber+BU8mNPXXvRFrmIpyMcMIqeqydRLhwr3MWguDzgzWxoTb0S08f7d
   oOqkJX2LsLvz6Uz5eKlvJuwWQfMyt5WSyQZWcaimc2n3/Ye7PvRcS6Rkl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774114"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338625"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338625"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:11 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: [PATCH v3 12/28] x86/sgx: Add option to ignore age of page during EPC reclaim
Date:   Wed, 12 Jul 2023 16:01:46 -0700
Message-Id: <20230712230202.47929-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 44 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4fc931156972..ea0698db8698 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -34,6 +34,11 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_lists sgx_global_lru;
 
+static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -286,6 +291,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 /**
  * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
+ * @ignore_age:		 Reclaim a page even if it is young
  *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
@@ -299,11 +305,12 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static size_t sgx_reclaim_pages(size_t nr_to_scan)
+static size_t sgx_reclaim_pages(size_t nr_to_scan, bool ignore_age)
 {
 	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
+	struct sgx_epc_lru_lists *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
 	size_t ret;
@@ -339,7 +346,8 @@ static size_t sgx_reclaim_pages(size_t nr_to_scan)
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_page;
 
-		if (i == SGX_NR_TO_SCAN_MAX || !sgx_reclaimer_age(epc_page))
+		if (i == SGX_NR_TO_SCAN_MAX ||
+		    (!ignore_age && !sgx_reclaimer_age(epc_page)))
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
@@ -357,10 +365,11 @@ static size_t sgx_reclaim_pages(size_t nr_to_scan)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
+		lru = sgx_lru_lists(epc_page);
+		spin_lock(&lru->lock);
 		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
-		list_move_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		list_move_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 	}
@@ -395,7 +404,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages(SGX_NR_TO_SCAN);
+		sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 }
 
 static int ksgxd(void *p)
@@ -418,7 +427,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages(SGX_NR_TO_SCAN);
+			sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 
 		cond_resched();
 	}
@@ -514,14 +523,16 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
  */
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_lists *lru = sgx_lru_lists(page);
+
+	spin_lock(&lru->lock);
 	WARN_ON_ONCE(sgx_epc_page_reclaimable(page->flags));
 	page->flags |= flags;
 	if (sgx_epc_page_reclaimable(flags))
-		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+		list_add_tail(&page->list, &lru->reclaimable);
 	else
-		list_add_tail(&page->list, &sgx_global_lru.unreclaimable);
-	spin_unlock(&sgx_global_lru.lock);
+		list_add_tail(&page->list, &lru->unreclaimable);
+	spin_unlock(&lru->lock);
 }
 
 /**
@@ -536,15 +547,16 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
  */
 int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru_lists *lru = sgx_lru_lists(page);
+
+	spin_lock(&lru->lock);
 	if (sgx_epc_page_reclaim_in_progress(page->flags)) {
-		spin_unlock(&sgx_global_lru.lock);
+		spin_unlock(&lru->lock);
 		return -EBUSY;
 	}
-
 	list_del(&page->list);
 	sgx_epc_page_reset_state(page);
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	return 0;
 }
@@ -590,7 +602,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages(SGX_NR_TO_SCAN);
+		sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 		cond_resched();
 	}
 
-- 
2.25.1

