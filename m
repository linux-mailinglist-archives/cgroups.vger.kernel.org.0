Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32379DEF1
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbjIMEJC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbjIMEI5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:08:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FB173A;
        Tue, 12 Sep 2023 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578132; x=1726114132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PsYQ63FO9gKjJV2WD5fndgBtRRQxs63BhKeT1YL4QI=;
  b=Y+aA71W8qFfmCh7THPvt56RUyK9R+QNcGbbLMp2LO4Z0VnazN6mcjxcJ
   A+rvrymFhg0cZZCom8gVEw6yfsZpty04jou8+blf2KuL9lsvdcbUt7a1z
   bcDJTciO7Oux8OZVUExY7tPqf5gPiFmX7Z+mwlUaorN1Ypz52nj7ZEHam
   Hfn/H0ROV9G4rh9MsoqG1u1PjKs3kvjqjegG3vcvH2r7Lb/8ASrUHCs9K
   TMuc6CIf6HiBoElOID5qSNCx7U838IFoD4GdXVCMTSlmcmIGNmnd3TS5U
   uDFvou0WJCnuhjSQRC23Sme3Z+LjZ+vEFv0h1myPDgd13zUBeaVeyJm9f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990379"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990379"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155933"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155933"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:44 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 08/18] x86/sgx: Use a list to track to-be-reclaimed pages
Date:   Tue, 12 Sep 2023 21:06:25 -0700
Message-Id: <20230913040635.28815-9-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Change sgx_reclaim_pages() to use a list rather than an array for
storing the epc_pages which will be reclaimed. This change is needed
to transition to the LRU implementation for EPC cgroup support.

When the EPC cgroup is implemented, the reclaiming process will do a
pre-order tree walk for the subtree starting from the limit-violating
cgroup.  When each node is visited, candidate pages are selected from
its "reclaimable" LRU list and moved into this temporary list. Passing a
list from node to node for temporary storage in this walk is more
straightforward than using an array.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang<haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- Changes needed for patch reordering
- Revised commit message

V3:
- Removed list wrappers
---
 arch/x86/kernel/cpu/sgx/main.c | 40 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c1ae19a154d0..fba06dc5abfe 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -293,12 +293,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
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
 
@@ -314,18 +313,22 @@ static void sgx_reclaim_pages(void)
 
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
 		encl_page = epc_page->owner;
 
 		if (!sgx_reclaimer_age(epc_page))
@@ -340,6 +343,7 @@ static void sgx_reclaim_pages(void)
 			goto skip;
 		}
 
+		i++;
 		encl_page->desc |= SGX_ENCL_PAGE_BEING_RECLAIMED;
 		mutex_unlock(&encl_page->encl->lock);
 		continue;
@@ -347,27 +351,19 @@ static void sgx_reclaim_pages(void)
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
 		encl_page = epc_page->owner;
-		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_reclaimer_write(epc_page, &backing[i++]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		sgx_epc_page_reset_state(epc_page);
-- 
2.25.1

