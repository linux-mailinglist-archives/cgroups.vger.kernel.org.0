Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA9640D72
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiLBSiE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiLBSht (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33311EBC9B;
        Fri,  2 Dec 2022 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006242; x=1701542242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ld5LaZJWmZionb9cQjqD/LPN3rIVzYDCwEBv2smvVZU=;
  b=NeMxXnBKBt0bgtyR8H23rYZqgMWwLLroanb5gW/YhNHk5NkFy4VULzl0
   sr3RIZzA5rics1vhYkWrKlRfXzwE6m2565VTkJUS9QN2kTtl7BjPgD20k
   ssAWDbIXegm9gbq/f6IujvWrDntk2b/nUHlq2mz+r6OXvtXsG3FCz6d6C
   5F769lk38dBffWoleQX0iybRdakrnlGzM2h5SX827naZf+M1jzLOV79LV
   kAX7zgtjZCnCLfjp1i32Cj5nNYmLv+u1jL7dDyfhHBWS6W0049RAJ+uTr
   inY0tMO8GNrpABm0qXYCZmrSTZo6yvTGLrHzfek0JHmFvisC3jbu/dnDL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724581"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724581"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717479"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717479"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:19 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 08/18] x86/sgx: Allow reclaiming up to 32 pages, but scan 16 by default
Date:   Fri,  2 Dec 2022 10:36:44 -0800
Message-Id: <20221202183655.3767674-9-kristen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202183655.3767674-1-kristen@linux.intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
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

Modify sgx_reclaim_pages() to take a parameter that specifies the
number of pages to scan for reclaiming. Specify a max value of
32, but scan 16 in the usual case. This allows the number of pages
sgx_reclaim_pages() scans to be specified by the caller, and adjusted
in future patches.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 83aaf5cea7b9..f201ca85212f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -18,6 +18,8 @@
 #include "encl.h"
 #include "encls.h"
 
+#define SGX_MAX_NR_TO_RECLAIM	32
+
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
 static struct task_struct *ksgxd_tsk;
@@ -273,7 +275,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
+/**
+ * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
+ * @nr_to_scan:		 Number of EPC pages to scan for reclaim
+ *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
  * been accessed since the last scan. Move those pages to the tail of active
@@ -286,9 +291,9 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static void __sgx_reclaim_pages(void)
+static void __sgx_reclaim_pages(int nr_to_scan)
 {
-	struct sgx_backing backing[SGX_NR_TO_SCAN];
+	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
 	pgoff_t page_index;
@@ -297,7 +302,7 @@ static void __sgx_reclaim_pages(void)
 	int i;
 
 	spin_lock(&sgx_global_lru.lock);
-	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
+	for (i = 0; i < nr_to_scan; i++) {
 		epc_page = sgx_epc_peek_reclaimable(&sgx_global_lru);
 		if (!epc_page)
 			break;
@@ -327,7 +332,7 @@ static void __sgx_reclaim_pages(void)
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_owner;
 
-		if (!sgx_reclaimer_age(epc_page))
+		if (i == SGX_MAX_NR_TO_RECLAIM || !sgx_reclaimer_age(epc_page))
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
@@ -371,9 +376,9 @@ static void __sgx_reclaim_pages(void)
 	}
 }
 
-static void sgx_reclaim_pages(void)
+static void sgx_reclaim_pages(int nr_to_scan)
 {
-	__sgx_reclaim_pages();
+	__sgx_reclaim_pages(nr_to_scan);
 	cond_resched();
 }
 
@@ -393,7 +398,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		__sgx_reclaim_pages();
+		__sgx_reclaim_pages(SGX_NR_TO_SCAN);
 }
 
 static int ksgxd(void *p)
@@ -419,7 +424,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+			sgx_reclaim_pages(SGX_NR_TO_SCAN);
 	}
 
 	return 0;
@@ -598,7 +603,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages();
+		sgx_reclaim_pages(SGX_NR_TO_SCAN);
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-- 
2.38.1

