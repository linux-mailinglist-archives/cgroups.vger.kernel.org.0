Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01586640D73
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiLBSiE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiLBSht (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2848EBCA1;
        Fri,  2 Dec 2022 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006242; x=1701542242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sBuJld5YfAr7cCiwad4f37JGGvCzkKs+++hBvxzdEeQ=;
  b=BUBH2Kb9edTv0TDLFqvCIPZfU/2JcMinQ6u2aag+SXBL+F2a1iJpszrE
   5ymdgwcwl/zebtSfZuPhncwccRWZxeL2at616gxQy97BjWfuOhJ2oH+tz
   gRVh35LaroYVPxKW9kzaNsThhYLkEE0Qg283PoAulCveIZxQEInzUFEoY
   wnswhoqyByx8+6Zotq2PxVQE/67XTCkTPi81D7Md1uua4uaPyG+qxZkPU
   59hgpy1ttwlRZnMAVZdzONxffaUXaPFCENXowcdv23E0PYP7pQPjlS3I1
   voeKhtbHpYDuoSstFNvyy8FSPx8AICAXbllt59Jjq2KWGnVKKSNZe9QMp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724594"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724594"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717489"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717489"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:21 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 09/18] x86/sgx: Return the number of EPC pages that were successfully reclaimed
Date:   Fri,  2 Dec 2022 10:36:45 -0800
Message-Id: <20221202183655.3767674-10-kristen@linux.intel.com>
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

Return the number of reclaimed pages from sgx_reclaim_pages(), the EPC
cgroup will use the result to track the success rate of its reclaim
calls, e.g. to escalate to a more forceful reclaiming mode if necessary.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index f201ca85212f..a4a65eadfb79 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -291,7 +291,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static void __sgx_reclaim_pages(int nr_to_scan)
+static int __sgx_reclaim_pages(int nr_to_scan)
 {
 	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
 	struct sgx_epc_page *epc_page, *tmp;
@@ -326,7 +326,7 @@ static void __sgx_reclaim_pages(int nr_to_scan)
 	spin_unlock(&sgx_global_lru.lock);
 
 	if (list_empty(&iso))
-		return;
+		return 0;
 
 	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
@@ -374,12 +374,16 @@ static void __sgx_reclaim_pages(int nr_to_scan)
 
 		sgx_free_epc_page(epc_page);
 	}
+	return i;
 }
 
-static void sgx_reclaim_pages(int nr_to_scan)
+static int sgx_reclaim_pages(int nr_to_scan)
 {
-	__sgx_reclaim_pages(nr_to_scan);
+	int ret;
+
+	ret = __sgx_reclaim_pages(nr_to_scan);
 	cond_resched();
+	return ret;
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
-- 
2.38.1

