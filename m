Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59E7ABD67
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjIWDHW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIWDHK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E551A5;
        Fri, 22 Sep 2023 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438424; x=1726974424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gXh1rHtrkHSzkPHJy21La79GKdM/hChwBw4+Gb9Byg=;
  b=az+qzZHSkN9xnfdSF71mjpM2TUPQN0TGexiyvj4zL+WcE6kRFBwSOY1x
   bDU+ZLFwz0NEEQ0y0tbdeZglo5kInAk8tYe3j8PFw47LS0P8Q8JseTUk6
   2WZHQybn2y7ISBSgkyDPbnlRgv08CT865sWRTvH59hGOtunMyY2dEzs6X
   /8Ky8jzwrirtx4lquAJLsM2F12ekoI5hleeHLrfkqylgosCoU1fvbprrB
   wLertwiScRz7zQu/SVId8G8eVBD/myYC16jwg6pgKt+xgQ23IKt1hwVhA
   ea8pFbeOkQiCZznr9jNEd4ipGx5FBmPMtVdmr6EfNXJ0vG8IPSSarC1x0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466770"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048548"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048548"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:07 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 07/18] x86/sgx: Introduce RECLAIM_IN_PROGRESS state
Date:   Fri, 22 Sep 2023 20:06:46 -0700
Message-Id: <20230923030657.16148-8-haitao.huang@linux.intel.com>
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

Add RECLAIM_IN_PROGRESS state to not rely on list_empty(&epc_page->list)
to determine if an EPC page is selected as a reclaiming candidate.

When a page is being reclaimed from the page pool (sgx_global_lru),
there is an intermediate stage where a page may have been identified as
a candidate for reclaiming, but has not yet been reclaimed.  Currently
such pages are list_del_init()'d from the global LRU list, and stored in
a an array on stack. To prevent another thread from dropping the same
page in the middle of reclaiming, sgx_drop_epc_page() checks for
list_empty(&epc_page->list).

A later patch will replace the array on stack with a temporary list to
store the candidate pages, so list_empty() should no longer be used for
this purpose.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- Fixed some typos.
- Revised commit message.

V3:
- Extend the sgx_epc_page_state enum introduced earlier to replace the
flag based approach.
---
 arch/x86/kernel/cpu/sgx/main.c | 21 ++++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h  | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b26860399402..c1ae19a154d0 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -312,13 +312,15 @@ static void sgx_reclaim_pages(void)
 		list_del_init(&epc_page->list);
 		encl_page = epc_page->owner;
 
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
 
@@ -528,16 +530,13 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
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
index 2faeb40b345f..764cec23f4e5 100644
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
 
+	/* Page is being prepared for reclamation, tracked in a temporary
+	 * isolated list by the reclaimer.
+	 * Changes in sgx_reclaim_pages() back to RECLAIMABLE if preparation
+	 * fails for any reason.
+	 * Becomes NOT_TRACKED if reclaimed successfully in sgx_reclaim_pages()
+	 * and immediately sgx_free_epc() is called to make it FREE.
+	 */
+	SGX_EPC_PAGE_RECLAIM_IN_PROGRESS = 4,
 };
 
 #define SGX_EPC_PAGE_STATE_MASK GENMASK(2, 0)
@@ -73,6 +83,12 @@ static inline void sgx_epc_page_set_state(struct sgx_epc_page *page, unsigned lo
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

