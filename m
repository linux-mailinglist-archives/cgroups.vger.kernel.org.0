Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B295C5E696A
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIVRQM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIVRPz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:15:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6A8169C;
        Thu, 22 Sep 2022 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866936; x=1695402936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nj39Q9ceqr5A+bt2PwpCeJxtAg2UJZ0zT/MG8hez1vE=;
  b=dHm3Vzz3l5arsdDq+EDfzMzGSzpvwUmJ83p720XVbIHPoJ7XVlS3MSBo
   iB6vjClvWBvamj0q0Jh9AfIdp0q5bLxxWSpZXQAdgDNoPDPenkpd2JJ1j
   uqEMRw7YA1hJkdwH5fJZhSK1IkVHjgtL9/3h6Epha/sH1mFS0USAuRHFN
   hrop34GTvoE4hD3pdG2+j8DF9PpyUEa/2N8cxQYhYxwnyivDS2Ob54MPl
   l44lH9HyVeqYOaq7erLidypc6RQY9JVTA4HxOyQ8r5ESvOU3MPjdnXisQ
   pKt22qyjUW+l1/heF5jhs/wxWfbiwqazc8baKqFkLvuSpU2t4hNP5BkgJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364351930"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364351930"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762270003"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:23 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 06/20] x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for EPC pages
Date:   Thu, 22 Sep 2022 10:10:43 -0700
Message-Id: <20220922171057.1236139-7-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
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

Keep track of whether the EPC page is in the middle of being reclaimed
and do not delete the page off the it's LRU if it has not yet finished
being reclaimed.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 14 +++++++++-----
 arch/x86/kernel/cpu/sgx/sgx.h  |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 543bc5b20508..93aa9e09c26d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -307,13 +307,15 @@ static void sgx_reclaim_pages(void)
 		list_del_init(&epc_page->list);
 		encl_page = epc_page->owner;
 
-		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0)
+		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
+			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
 			chunk[cnt++] = epc_page;
-		else
+		} else {
 			/* The owner is freeing the page. No need to add the
 			 * page back to the list of reclaimable pages.
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+		}
 	}
 	spin_unlock(&sgx_global_lru.lock);
 
@@ -339,6 +341,7 @@ static void sgx_reclaim_pages(void)
 
 skip:
 		spin_lock(&sgx_global_lru.lock);
+		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
 		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
 		spin_unlock(&sgx_global_lru.lock);
 
@@ -362,7 +365,8 @@ static void sgx_reclaim_pages(void)
 		sgx_reclaimer_write(epc_page, &backing[i]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
-		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+		epc_page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
+				     SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
 
 		sgx_free_epc_page(epc_page);
 	}
@@ -504,7 +508,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
 	spin_lock(&sgx_global_lru.lock);
-	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIM_FLAGS);
 	page->flags |= flags;
 	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
 		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
@@ -528,7 +532,7 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
 	spin_lock(&sgx_global_lru.lock);
 	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
 		/* The page is being reclaimed. */
-		if (list_empty(&page->list)) {
+		if (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS) {
 			spin_unlock(&sgx_global_lru.lock);
 			return -EBUSY;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 65625ea8fd6e..284d0cda9e36 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -29,6 +29,11 @@
 /* Pages on free list */
 #define SGX_EPC_PAGE_IS_FREE		BIT(1)
 
+/* page flag to indicate reclaim is in progress */
+#define SGX_EPC_PAGE_RECLAIM_IN_PROGRESS BIT(2)
+#define SGX_EPC_PAGE_RECLAIM_FLAGS	(SGX_EPC_PAGE_RECLAIMER_TRACKED | \
+					 SGX_EPC_PAGE_RECLAIM_IN_PROGRESS)
+
 struct sgx_epc_page {
 	unsigned int section;
 	u16 flags;
-- 
2.37.3

