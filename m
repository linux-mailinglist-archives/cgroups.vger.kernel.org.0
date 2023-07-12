Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290FC7513EF
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjGLXCT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGLXCM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A7519B;
        Wed, 12 Jul 2023 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202931; x=1720738931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PydI83cKvrPzhjzQxB3kjgQ0AGgyY2Uz5x1crKJURs=;
  b=aGnDsO7Ww1LzqK+qGDDu1Pi4PQKDTp6O/SIju7f1B9CuFj5yuhsKqMc+
   paHbdKxn+IG6YsQLPp7Xay36/ee8n8cE8gkXVdzwpDqtAsxJHv5JGULiu
   rPnLKuEaOM2DGLqEPM0U6ErhK3CmPLRlt0ljhHHGhEzEfBEgzEZsVUJC/
   AGFtU3oHI/OHxU/B91VcjPBZMeYeJ/vkUCxbM3FrDm1GduS0tspJJESOm
   bAwhOV/+/EMIJQiylDBWgAWaygrkJ66P3NXk0F94WEAX06isRSqAZ9ymu
   1VZauMTkqcQRI3WEnf07NWA2rh2G1hew+C17xRWTkowhuRZvbzpNniS3w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774062"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774062"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338611"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338611"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:09 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com
Subject: [PATCH v3 09/28] x86/sgx: Use a list to track to-be-reclaimed pages
Date:   Wed, 12 Jul 2023 16:01:43 -0700
Message-Id: <20230712230202.47929-10-haitao.huang@linux.intel.com>
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

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Change sgx_reclaim_pages() to use a list rather than an array for
storing the epc_pages which will be reclaimed. This change is needed
to transition to the LRU implementation for EPC cgroup support, which
uses lists to store reclaimable and unreclaimable pages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang<haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

V3:
- Removed list wrappers
---
 arch/x86/kernel/cpu/sgx/main.c | 40 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9eea9038758f..f3a3ed894616 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -294,12 +294,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  */
 static void sgx_reclaim_pages(void)
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
 
@@ -315,18 +314,22 @@ static void sgx_reclaim_pages(void)
 
 		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
 			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
-			chunk[cnt++] = epc_page;
+			list_move_tail(&epc_page->list, &iso);
 		} else {
-			/* The owner is freeing the page. No need to add the
-			 * page back to the list of reclaimable pages.
+			/* The owner is freeing the page, remove it from the
+			 * LRU list
 			 */
 			sgx_epc_page_reset_state(epc_page);
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
 		encl_page = epc_page->encl_page;
 
 		if (!sgx_reclaimer_age(epc_page))
@@ -341,6 +344,7 @@ static void sgx_reclaim_pages(void)
 			goto skip;
 		}
 
+		i++;
 		encl_page->desc |= SGX_ENCL_PAGE_BEING_RECLAIMED;
 		mutex_unlock(&encl_page->encl->lock);
 		continue;
@@ -348,27 +352,19 @@ static void sgx_reclaim_pages(void)
 skip:
 		spin_lock(&sgx_global_lru.lock);
 		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
-		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
+		list_move_tail(&epc_page->list, &sgx_global_lru.reclaimable);
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
+	list_for_each_entry(epc_page, &iso, list)
+		sgx_reclaimer_block(epc_page);
 
+	i = 0;
+	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_page;
-		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_reclaimer_write(epc_page, &backing[i++]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		sgx_epc_page_reset_state(epc_page);
-- 
2.25.1

