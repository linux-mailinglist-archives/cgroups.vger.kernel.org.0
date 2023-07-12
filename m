Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8377513ED
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjGLXCT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGLXCM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEAB18E;
        Wed, 12 Jul 2023 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202931; x=1720738931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CVUrYW5MmLWmAT8eePPeED+pne2A9Lo2ZCZNyX7klu8=;
  b=D+qOdD0IncXzotuN+zFLyVfPbGvxjogjnCKlpQ9LcCzJ4BMDKlMIjeIU
   gukbRBYd89/pDGsg6C8WVmChgd41FUgfnadmOXIQ/Ksntsd3nX2zwUDYV
   G5iduHj7BBlgaJK0H605ov8x/3P9WXyy8B6HdnCE6imwpoGc25TgOyO7M
   PAWeUjJscaRdGDQaTX5AoiTNjrrOkwVOQE4HQStUVGMViPg4DJLrmQVOF
   KMyBzMW8dpHkJBnfv9l2GschfwNV/QQpOVQjND+ttZ+UUybOfC7hvhaYA
   vCDqpmNic+81HGRzSeP7+rHP0cTVZFs5FwMRoWK13tSh2Xb8rSsMfsbVt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774026"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338608"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338608"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:08 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: [PATCH v3 08/28] x86/sgx: Introduce RECLAIM_IN_PROGRESS state
Date:   Wed, 12 Jul 2023 16:01:42 -0700
Message-Id: <20230712230202.47929-9-haitao.huang@linux.intel.com>
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

When a page is being reclaimed from the page pool (sgx_global_lru),
there is an intermediate stage where a page may have been identified
as a candidate for reclaiming, but has not yet been reclaimed.
Currently such pages are list_del_init()'d from the global LRU, and
stored in a an array on stack. To prevent another thread from dropping
the same page in the middle of reclaiming, sgx_drop_epc_page() checks
for list_empty(&page->list).

In future patches these pages need be list_move()'d into a temporary
list that is shared with multiple cgroup reclaimers. so list_empty()
should no longer be used for this purpose. Add a RECLAIM_IN_PROGRESS
state to explicitly designate such intermediate state of EPC in the
reclaiming process. Do not drop any page in this state in
sgx_drop_epc_page().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

V3:
- Extend the sgx_epc_page_state enum introduced earlier to replace the
flag based approach.
---
 arch/x86/kernel/cpu/sgx/main.c | 21 ++++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h  | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 02c358f10383..9eea9038758f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -313,13 +313,15 @@ static void sgx_reclaim_pages(void)
 		list_del_init(&epc_page->list);
 		encl_page = epc_page->encl_page;
 
-		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0)
+		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
+			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
 			chunk[cnt++] = epc_page;
-		else
+		} else {
 			/* The owner is freeing the page. No need to add the
 			 * page back to the list of reclaimable pages.
 			 */
 			sgx_epc_page_reset_state(epc_page);
+		}
 	}
 	spin_unlock(&sgx_global_lru.lock);
 
@@ -531,16 +533,13 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
 	spin_lock(&sgx_global_lru.lock);
-	if (sgx_epc_page_reclaimable(page->flags)) {
-		/* The page is being reclaimed. */
-		if (list_empty(&page->list)) {
-			spin_unlock(&sgx_global_lru.lock);
-			return -EBUSY;
-		}
-
-		list_del(&page->list);
-		sgx_epc_page_reset_state(page);
+	if (sgx_epc_page_reclaim_in_progress(page->flags)) {
+		spin_unlock(&sgx_global_lru.lock);
+		return -EBUSY;
 	}
+
+	list_del(&page->list);
+	sgx_epc_page_reset_state(page);
 	spin_unlock(&sgx_global_lru.lock);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 057905eba466..f26ed4c0d12f 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -40,6 +40,8 @@ enum sgx_epc_page_state {
 
 	/* Page is in use and tracked in a reclaimable LRU list
 	 * Becomes NOT_TRACKED after sgx_drop_epc()
+	 * Becomes RECLAIM_IN_PROGRESS in sgx_reclaim_pages() when identified
+	 * for reclaiming
 	 */
 	SGX_EPC_PAGE_RECLAIMABLE = 2,
 
@@ -50,6 +52,14 @@ enum sgx_epc_page_state {
 	 */
 	SGX_EPC_PAGE_UNRECLAIMABLE = 3,
 
+	/* Page is being prepared for reclaimation, tracked in a temporary
+	 * isolated list by the reclaimer.
+	 * Changes in sgx_reclaim_pages() back to RECLAIMABLE if preparation
+	 * fails for any reason.
+	 * Becomes NOT_TRACKED if reclaimed successfully in sgx_reclaim_pages()
+	 * and immediately sgx_free_epc() is called to make it FREE.
+	 */
+	SGX_EPC_PAGE_RECLAIM_IN_PROGRESS = 4,
 };
 
 #define SGX_EPC_PAGE_STATE_MASK GENMASK(2, 0)
@@ -82,6 +92,12 @@ static inline void sgx_epc_page_set_state(struct sgx_epc_page *page, unsigned lo
 	page->flags |= (flags & SGX_EPC_PAGE_STATE_MASK);
 }
 
+static inline bool sgx_epc_page_reclaim_in_progress(unsigned long flags)
+{
+	return SGX_EPC_PAGE_RECLAIM_IN_PROGRESS == (flags &
+						    SGX_EPC_PAGE_STATE_MASK);
+}
+
 static inline bool sgx_epc_page_reclaimable(unsigned long flags)
 {
 	return SGX_EPC_PAGE_RECLAIMABLE == (flags & SGX_EPC_PAGE_STATE_MASK);
-- 
2.25.1

