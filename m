Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7D626152
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiKKSgb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiKKSgE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F4787B6;
        Fri, 11 Nov 2022 10:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191763; x=1699727763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqEEntqYbLvI5IiAkoUnLqlFey5cK++4386ISoTRbDQ=;
  b=NyeS7rN3OaA/u3vut/55VUDCWVXYTm9hf7Ix0JkVZJI6BfW5/q65vi5I
   Mcx9yG0cyu4yFKXzdP+TstbbzQE3kpV/ThxJOQcqByhBh5MGp6r0KFXKY
   iYwO7ymRmhTkp0JEMdjYY/nVp68miCJi+ip68wdc5u4InuQk620Z6dJVV
   Wms1+CUebNkp4BM4PIUHTtLERBqeyL5VXCnR4/s2jbsaL+VFq7tkluWdo
   hy+MIDjZp7Dq68zx/qmQthDg+ftxAJEASR0NSSe6P2BaMdnqM0jKAt1mD
   68pDWfzd2gdIBg3cumKo78YhxxyakP6z1jGCUzcZ4q3NjdWzUhOgrkyxo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050361"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050361"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089272"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089272"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:01 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 12/26] x86/sgx: Add helper to retrieve SGX EPC LRU given an EPC page
Date:   Fri, 11 Nov 2022 10:35:17 -0800
Message-Id: <20221111183532.3676646-13-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221111183532.3676646-1-kristen@linux.intel.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
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

Introduce a function that will be used to retrieve an LRU
from an EPC page.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b72b5868dd01..c33966eafab6 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -31,6 +31,10 @@ static DEFINE_XARRAY(sgx_epc_address_space);
  * with sgx_global_lru.lock acquired.
  */
 static struct sgx_epc_lru sgx_global_lru;
+static inline struct sgx_epc_lru *sgx_lru(struct sgx_epc_page *epc_page)
+{
+	return &sgx_global_lru;
+}
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
@@ -297,6 +301,7 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
+	struct sgx_epc_lru *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
 	int ret;
@@ -352,10 +357,11 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
+		lru = sgx_lru(epc_page);
+		spin_lock(&lru->lock);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-		sgx_epc_move_reclaimable(&sgx_global_lru, epc_page);
-		spin_unlock(&sgx_global_lru.lock);
+		sgx_epc_move_reclaimable(lru, epc_page);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 	}
@@ -521,14 +527,16 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
  */
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru *lru = sgx_lru(page);
+
+	spin_lock(&lru->lock);
 	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIM_FLAGS);
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
@@ -543,14 +551,16 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
  */
 int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
-	spin_lock(&sgx_global_lru.lock);
+	struct sgx_epc_lru *lru = sgx_lru(page);
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
 
 	page->flags &= ~SGX_EPC_PAGE_RECLAIM_FLAGS;
 
-- 
2.37.3

