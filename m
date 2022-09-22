Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF575E694C
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiIVRNJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiIVRNH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:13:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EE2EF2D;
        Thu, 22 Sep 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866786; x=1695402786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAqBkTUmYYX0pPDN5Vz9uab6QodYLXhHPk1Zsj7TxBE=;
  b=Rph/LjkQFeQlhV2N9AiBG6/YOR618v073CZiFSpwl4DbfSV5QETh98AJ
   x7lNyG0dtr8G985Fbmb0utazLPmgy0vwsUfShXhe/6Ek2JpbKh9kjXe66
   zXsZQ6oguTSXlUd+OzOc7eFHYf72ZqcvJzUiR9H1c89wPkFJ5cQP/Mwtn
   UQbfA19YZBNYi8Imei/hKA5M7YBWAMq0SdcCSTNa8J8nX14TTOqLjGkdk
   QtIhAnpNo39P9UXuScZXaKkko1Zq3XK5b5jV0ZUIDE84dsxfGHtrFU3Xp
   kcOopBzT8MIhmLPn6wF9ZqSrQG/fELliZ4WX6s3Oe53Hxt6i5dQMwMHhz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283421376"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283421376"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762270151"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:34 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 12/20] x86/sgx: Add helper to retrieve SGX EPC LRU given an EPC page
Date:   Thu, 22 Sep 2022 10:10:49 -0700
Message-Id: <20220922171057.1236139-13-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 98531f6fb448..9f2cb264a347 100644
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
 
@@ -299,6 +303,7 @@ static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page, *tmp;
+	struct sgx_epc_lru *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
 	int ret;
@@ -354,10 +359,11 @@ static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
+		lru = sgx_lru(epc_page);
+		spin_lock(&lru->lock);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-		list_move_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		list_move_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 	}
@@ -514,14 +520,16 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
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
-		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+		list_add_tail(&page->list, &lru->reclaimable);
 	else
-		list_add_tail(&page->list, &sgx_global_lru.unreclaimable);
-	spin_unlock(&sgx_global_lru.lock);
+		list_add_tail(&page->list, &lru->unreclaimable);
+	spin_unlock(&lru->lock);
 }
 
 /**
@@ -536,14 +544,16 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
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

