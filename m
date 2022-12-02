Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA611640D61
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLBShJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiLBShH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC423EDD4D;
        Fri,  2 Dec 2022 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006226; x=1701542226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qv8PoJW739IycS7cP6BKN7byFcsUeUj+E5iETGUdTaY=;
  b=fjwrwjP9y+xUEsMd6ZeGhn8XC348NLasrXvwxkfJICVBO3ZSoij9vVmd
   6n287W0Zzn8E3fNXrvfyuK9LQn5YK/Qs11plq4giEMXVX8lTMYiFuwfEs
   QEpOUFuhTtLoQvWK6EQSi6TctCfuSeG0vO1EmjwEJ8QsD7FEviR89DLlT
   sIuJDFUD/uH85zJcrDOXw8cvjUFZOfqxGXtl7TpDw8vU07t6dbq5tKTs0
   wXuvF00RoE3LxhWuD1HrUFBI3Yys/YJIUztwpoEiqJzp58mPhX8LVReCW
   EcFU/FwdhO5Xmlp4DIidrt4HPrm3/R3nttsrRQZIYLD/oAQqq9k4gb+w+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724475"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724475"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717343"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717343"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:03 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 01/18] x86/sgx: Call cond_resched() at the end of sgx_reclaim_pages()
Date:   Fri,  2 Dec 2022 10:36:37 -0800
Message-Id: <20221202183655.3767674-2-kristen@linux.intel.com>
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

In order to avoid repetition of cond_resched() in ksgxd() and
sgx_alloc_epc_page(), move the invocation of post-reclaim cond_resched()
inside sgx_reclaim_pages(). Except in the case of sgx_reclaim_direct(),
sgx_reclaim_pages() is always called in a loop and is always followed
by a call to cond_resched().  This will hold true for the EPC cgroup
as well, which adds even more calls to sgx_reclaim_pages() and thus
cond_resched(). Calls to sgx_reclaim_direct() may be performance
sensitive. Allow sgx_reclaim_direct() to avoid the cond_resched()
call by moving the original sgx_reclaim_pages() call to
__sgx_reclaim_pages() and then have sgx_reclaim_pages() become a
wrapper around that call with a cond_resched().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 160c8dbee0ab..ffce6fc70a1f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -287,7 +287,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static void sgx_reclaim_pages(void)
+static void __sgx_reclaim_pages(void)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -369,6 +369,12 @@ static void sgx_reclaim_pages(void)
 	}
 }
 
+static void sgx_reclaim_pages(void)
+{
+	__sgx_reclaim_pages();
+	cond_resched();
+}
+
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
@@ -378,12 +384,14 @@ static bool sgx_should_reclaim(unsigned long watermark)
 /*
  * sgx_reclaim_direct() should be called (without enclave's mutex held)
  * in locations where SGX memory resources might be low and might be
- * needed in order to make forward progress.
+ * needed in order to make forward progress. This call to
+ * __sgx_reclaim_pages() avoids the cond_resched() in sgx_reclaim_pages()
+ * to improve performance.
  */
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+		__sgx_reclaim_pages();
 }
 
 static int ksgxd(void *p)
@@ -410,8 +418,6 @@ static int ksgxd(void *p)
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
 			sgx_reclaim_pages();
-
-		cond_resched();
 	}
 
 	return 0;
@@ -582,7 +588,6 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		}
 
 		sgx_reclaim_pages();
-		cond_resched();
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-- 
2.38.1

