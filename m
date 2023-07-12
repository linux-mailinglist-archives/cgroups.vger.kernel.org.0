Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD67513FE
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjGLXCu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjGLXCR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39D10E2;
        Wed, 12 Jul 2023 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202935; x=1720738935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tA0QQdRKFxwvJ3GfeRZ7KDjSQ0meiTP93JAaft2AeWw=;
  b=agrHstpKriBNmRDcJB6E1/yRtxsSES7TORHQEMeifhhBn319tUlzQlJZ
   moZHBLqMzGTGT8+aVE3BAqeLTkOWr06uHXAnczVABySpIB7MlD/0qWdjX
   aWTyy7wsB0z2Fu923FaKuEtLiBLs3W4/qHwacdxp0hkIT1m8pauUbrl3p
   oRIENHi6Lts1RzNaytfJaBWUPgJUXXnLg9r4qwCQ+PFT4TjdVekNOWm3a
   ipD+1VIBMaKr//ZSAOLB0mYei7vFp40htNH+kwRG+flqXpyn1quvFg4Fp
   R7+U5+mP+aSWwcZ1HsU2Y8+yaNoKT+MWXbYga3K1BkjaNI377cJ9t0fl+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774138"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338640"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338640"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:13 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: [PATCH v3 15/28] x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
Date:   Wed, 12 Jul 2023 16:01:49 -0700
Message-Id: <20230712230202.47929-16-haitao.huang@linux.intel.com>
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

Move the isolation loop into a helper, sgx_isolate_pages(), in
preparation for existence of multiple LRUs.  Expose the helper to other
SGX code so that it can be called from the EPC cgroup code, e.g.  to
isolate pages from a single cgroup LRU. Exposing the isolation loop
allows the cgroup iteration logic to be wholly encapsulated within the
cgroup code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 60 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 ++
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e9c9e0d97300..883470062514 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -288,6 +288,43 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
+/**
+ * sgx_isolate_epc_pages() - Isolate pages from an LRU for reclaim
+ * @lru:	LRU from which to reclaim
+ * @nr_to_scan:	Number of pages to scan for reclaim
+ * @dst:	Destination list to hold the isolated pages
+ */
+void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, size_t nr_to_scan,
+			   struct list_head *dst)
+{
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+
+	spin_lock(&lru->lock);
+	for (; nr_to_scan > 0; --nr_to_scan) {
+		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);
+		if (!epc_page)
+			break;
+
+		encl_page = epc_page->encl_page;
+
+		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_OWNER_ENCL_PAGE)))
+			continue;
+
+		if (kref_get_unless_zero(&encl_page->encl->refcount)) {
+			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
+			list_move_tail(&epc_page->list, dst);
+		} else {
+			/* The owner is freeing the page, remove it from the
+			 * LRU list
+			 */
+			sgx_epc_page_reset_state(epc_page);
+			list_del_init(&epc_page->list);
+		}
+	}
+	spin_unlock(&lru->lock);
+}
+
 /**
  * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
@@ -316,28 +353,7 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
 	size_t ret;
 	size_t i;
 
-	spin_lock(&sgx_global_lru.lock);
-	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
-						    struct sgx_epc_page, list);
-		if (!epc_page)
-			break;
-
-		list_del_init(&epc_page->list);
-		encl_page = epc_page->encl_page;
-
-		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
-			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
-			list_move_tail(&epc_page->list, &iso);
-		} else {
-			/* The owner is freeing the page, remove it from the
-			 * LRU list
-			 */
-			sgx_epc_page_reset_state(epc_page);
-			list_del_init(&epc_page->list);
-		}
-	}
-	spin_unlock(&sgx_global_lru.lock);
+	sgx_isolate_epc_pages(&sgx_global_lru, nr_to_scan, &iso);
 
 	if (list_empty(&iso))
 		return 0;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 98d3b15341b1..25db815f5add 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -176,6 +176,8 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
 int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age);
+void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, size_t nr_to_scan,
+			   struct list_head *dst);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1

