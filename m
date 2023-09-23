Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAD7ABD71
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjIWDHj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIWDH0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D661CCC;
        Fri, 22 Sep 2023 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438430; x=1726974430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTmH9wj5vjHB4TTXAmAQRTLQut19Pfnv2uStepKZ6Y0=;
  b=FHhYCvCxI9EotHe6gbI/cvc/9ZfP6PnWHVuLqgeu63dWTopPsphvFp+i
   OVEX3bz39JKsajKL9lRfm5yAz05rS3QqIeNuivpQ9w+knGR7jlPTcLa37
   5Qt8EHYeS03vLqRGEqg22w7LehT3niYlrU2g9IT3gxvDloyXL+aKDw7Ew
   Ux3XGc685U1W2xhLZMHh3ya7BcVQEmCtOXKfNNbu5Qmz5o/zdjWiHdpcT
   b2YLbFpVjv41bkhwSEQWJNvoVQPu5SKm1X6GHQvTee9/v58oQa2Cx59/W
   NZjBY57lSY9abhVRvNnY8+Pzh/5nG0LMsBjX01KrDymYijWGGpz5ELH2L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466842"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048579"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048579"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:13 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 15/18] x86/sgx: Prepare for multiple LRUs
Date:   Fri, 22 Sep 2023 20:06:54 -0700
Message-Id: <20230923030657.16148-16-haitao.huang@linux.intel.com>
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

Add wrappers where a direct references to the global LRU list in the
reclaimer functions.  To support  multiple LRU lists (one per EPC
cgroup) later, only make changes inside these wrappers.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V5:
- Revise commit message to make the purpose more clear.

V4:
- Re-organized this patch to include all changes related to
encapsulation of the global LRU
- Moved this patch to precede the EPC cgroup patch
---
 arch/x86/kernel/cpu/sgx/main.c | 41 +++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b34ad3574c81..d37ef0dd865f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -35,6 +35,16 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  */
 static struct sgx_epc_lru_lists sgx_global_lru;
 
+static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
+
+static inline bool sgx_can_reclaim(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -340,6 +350,7 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
 	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
+	struct sgx_epc_lru_lists *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
 	size_t ret, i;
@@ -372,10 +383,11 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
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
@@ -400,7 +412,7 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim();
 }
 
 /*
@@ -530,14 +542,16 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
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
@@ -552,15 +566,16 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
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
@@ -593,7 +608,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable))
+		if (!sgx_can_reclaim())
 			return ERR_PTR(-ENOMEM);
 
 		if (!reclaim) {
-- 
2.25.1

