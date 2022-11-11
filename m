Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2A62614E
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiKKSg3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiKKSgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EDC76FA8;
        Fri, 11 Nov 2022 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191758; x=1699727758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrS+kKaSo6YqmfqiKR19e0LuugWCU+rOlWI2gpswICU=;
  b=BJInnXeBTVEjceo2PbkEAXbpQ/E04cHV9zHi83yhei+RNq0ajrfXyLMW
   CNYau8sVqniBHgL3KZ80ifJ6xsJSOs1cI2ldvMJDsq8WQHd+b2noFvZGy
   E4IgVqF6DxGCjFPh/P2/LpwnR1UjU1hKRT+9lP1mV84NcCtQqbENxRhAf
   3/3N+Ek9IoxK50wsGp2SKEVis1XtBL+uznkVjSiIHCyRazYnhlPBk9T3I
   OI5n/XYjdNweR+qSDYh/GD6EgkPfnvDk5B9byN30//LXJ3//VphwOlp7V
   ud1sBgRnHZ8TfeqHWwQBxr4sg862Ycx0jj0GXF6sDVhbwGFIAgMdm+v/G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050322"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050322"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089207"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089207"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:49 -0800
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
Subject: [PATCH 06/26] x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for EPC pages
Date:   Fri, 11 Nov 2022 10:35:11 -0800
Message-Id: <20221111183532.3676646-7-kristen@linux.intel.com>
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

Keep track of whether the EPC page is in the middle of being reclaimed
and do not delete the page off the it's LRU if it has not yet finished
being reclaimed.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 14 +++++++++-----
 arch/x86/kernel/cpu/sgx/sgx.h  |  4 ++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 3b09433ffd85..8c451071fa91 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -305,13 +305,15 @@ static void __sgx_reclaim_pages(void)
 
 		encl_page = epc_page->encl_owner;
 
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
 
@@ -337,6 +339,7 @@ static void __sgx_reclaim_pages(void)
 
 skip:
 		spin_lock(&sgx_global_lru.lock);
+		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
 		sgx_epc_push_reclaimable(&sgx_global_lru, epc_page);
 		spin_unlock(&sgx_global_lru.lock);
 
@@ -360,7 +363,8 @@ static void __sgx_reclaim_pages(void)
 		sgx_reclaimer_write(epc_page, &backing[i]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
-		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+		epc_page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
+				     SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
 
 		sgx_free_epc_page(epc_page);
 	}
@@ -508,7 +512,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 {
 	spin_lock(&sgx_global_lru.lock);
-	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIM_FLAGS);
 	page->flags |= flags;
 	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
 		sgx_epc_push_reclaimable(&sgx_global_lru, page);
@@ -532,7 +536,7 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
 	spin_lock(&sgx_global_lru.lock);
 	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
 		/* The page is being reclaimed. */
-		if (list_empty(&page->list)) {
+		if (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS) {
 			spin_unlock(&sgx_global_lru.lock);
 			return -EBUSY;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 969606615211..04ca644928a8 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -30,6 +30,10 @@
 #define SGX_EPC_PAGE_IS_FREE		BIT(1)
 /* Pages allocated for KVM guest */
 #define SGX_EPC_PAGE_KVM_GUEST		BIT(2)
+/* page flag to indicate reclaim is in progress */
+#define SGX_EPC_PAGE_RECLAIM_IN_PROGRESS BIT(3)
+#define SGX_EPC_PAGE_RECLAIM_FLAGS	(SGX_EPC_PAGE_RECLAIMER_TRACKED | \
+					 SGX_EPC_PAGE_RECLAIM_IN_PROGRESS)
 
 struct sgx_epc_page {
 	unsigned int section;
-- 
2.37.3

