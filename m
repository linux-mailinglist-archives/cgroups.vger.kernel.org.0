Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1DB626151
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiKKSgb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKKSgC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95241814D1;
        Fri, 11 Nov 2022 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191761; x=1699727761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3P7Q3xIri7oBiVTNsBMGR4O8OWA5OQYl9qvR3LdFVU=;
  b=XkUwzZ3aHIemRjo/noiKurMhPxOTF54mZDv4Cq1yMUGABab6eXeoUeeW
   e0QW9HCj8qQIdygxumVqKLqfoSsD5sbZDZuA1OvUcZlOv28HynRETJuKa
   UAZjLwQMa2VaZyYBIgw3N+rMtiyIDgPw4N8RsFaTo+KC3EDeQRhZ/Ur3S
   omM39GLEu/QErO96sWoScPvvQzzTxUVy8OlSEMkyTROVFZehPGES8HNg/
   PoUxJTxTU//YUKWXiPF97MlKM6Hd+BUobHPEfqfiI1m1X1CDkz/3LqfFE
   HKBlM8AzJqbjuTMimnlZ8n6HTRr734pVSAVC89q/V6jzQr4j/bG8ACdFt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050357"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050357"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089262"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089262"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:00 -0800
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
Subject: [PATCH 11/26] x86/sgx: Add option to ignore age of page during EPC reclaim
Date:   Fri, 11 Nov 2022 10:35:16 -0800
Message-Id: <20221111183532.3676646-12-kristen@linux.intel.com>
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

Add a flag to sgx_reclaim_pages() to instruct it to ignore the age of
page, i.e. reclaim the page even if it's young.  The EPC cgroup will use
the flag to enforce its limits by draining the reclaimable lists before
resorting to other measures, e.g. forcefully reclaimable "unreclaimable"
pages by killing enclaves.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index dfd76c605ef2..b72b5868dd01 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -278,6 +278,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 /**
  * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
+ * @ignore_age:		 Reclaim a page even if it is young
  *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
@@ -291,7 +292,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static int __sgx_reclaim_pages(int nr_to_scan)
+static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 {
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_epc_page *epc_page, *tmp;
@@ -332,7 +333,8 @@ static int __sgx_reclaim_pages(int nr_to_scan)
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_owner;
 
-		if (i == SGX_MAX_NR_TO_RECLAIM || !sgx_reclaimer_age(epc_page))
+		if (i == SGX_MAX_NR_TO_RECLAIM ||
+		    (!ignore_age && !sgx_reclaimer_age(epc_page)))
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
@@ -374,11 +376,11 @@ static int __sgx_reclaim_pages(int nr_to_scan)
 	return i;
 }
 
-static int sgx_reclaim_pages(int nr_to_scan)
+static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 {
 	int ret;
 
-	ret = __sgx_reclaim_pages(nr_to_scan);
+	ret = __sgx_reclaim_pages(nr_to_scan, ignore_age);
 	cond_resched();
 	return ret;
 }
@@ -399,7 +401,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		__sgx_reclaim_pages(SGX_NR_TO_SCAN);
+		__sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 }
 
 static int ksgxd(void *p)
@@ -425,7 +427,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages(SGX_NR_TO_SCAN);
+			sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 	}
 
 	return 0;
@@ -600,7 +602,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages(SGX_NR_TO_SCAN);
+		sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-- 
2.37.3

