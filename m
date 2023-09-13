Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1894779DEFA
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbjIMEJO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjIMEJH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:09:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3F198E;
        Tue, 12 Sep 2023 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578139; x=1726114139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9K4lkxszdYXWqW66P8rfWQzfOVoQfKmanJIZjiiAlD8=;
  b=n3slb7FV1nVwrPmIB7SwFkiVOXFK299FzlOpJiV74NHNGS9x1/CuNfUw
   J06KrtBPtz5zvVHwI2snaotmVetVh8EJAwQ5NpskGKUhpzKK0Ehzkshbw
   NKx7uPfzn0u6lz6OLWEihoutjcTXEjlRm/ONrVkvweSFXoUcpo10iIozP
   CtXn7rTPfkKbWVa9FAQfMcHQ0tbfiosEgYKP13nPReix9aJ88Z+G1JZJW
   JcI2MaPcwRz5gPBDOY7wvvriOw3/WiU4dy/h6jheJbxVY4ZhjGZrjhd3w
   cEsiUtNKtodW8a3hqbzObh9Lkvic2UxpBOrUQ7pOZDao+MiGBPTKiGQKc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990488"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990488"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155992"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155992"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:51 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 14/18] x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
Date:   Tue, 12 Sep 2023 21:06:31 -0700
Message-Id: <20230913040635.28815-15-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the isolation loop into a helper, sgx_isolate_pages(), in
preparation for existence of multiple LRUs. Expose the helper to other
SGX code so that it can be called from the EPC cgroup code, e.g., to
isolate pages from a single cgroup LRU. Exposing the isolation loop
allows the cgroup iteration logic to be wholly encapsulated within the
cgroup code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- No changes other than reordering the patches
---
 arch/x86/kernel/cpu/sgx/main.c | 57 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 ++
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e1dde431a400..ce316bd5e5bb 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -283,6 +283,40 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
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
@@ -310,28 +344,7 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
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
index aa4ec2c0ce96..7e21192b87a8 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -178,6 +178,8 @@ int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
 size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age);
+void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, size_t nr_to_scan,
+			   struct list_head *dst);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1

