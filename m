Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53154640D7A
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiLBSig (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiLBShy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDCED687;
        Fri,  2 Dec 2022 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006247; x=1701542247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7MsvLTiIZvWWxFFWya637LlOY9eT/xkcvSR43Ixrm0=;
  b=l98QrOd6Zc3kV9pp1e/Y5UDr88q5aOK6i7f0g22DPKMNnUnZO+Sl7Wxt
   6fn40zakseUtk0fAs5xblVWio3zuE/Uvq5k7HJr/KXfuFDFicahmpC9aw
   ijJeAxjf3T8ZuwfhTnu9T4kplj5kgEFBgyehEmU0AuHzl9AwL1GzomRIt
   xm1r2+Duohts2bkQaOnWEVBIqpMCme6NxZTJd+MfHXUIL8+gNSG5eB4S1
   oLIEy5ChH6S0vkt+Y1m57js+gljza/QtMVOvHKw27ZRuNg5+VVI0Eb8Ns
   FYpqxspTEBU75SMIeCd1YAku84toeAGpzNCyh6LZuM9BRckcZQFefrXFv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724635"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724635"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717549"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717549"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:26 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 12/18] x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
Date:   Fri,  2 Dec 2022 10:36:48 -0800
Message-Id: <20221202183655.3767674-13-kristen@linux.intel.com>
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

Expose the top-level reclaim function as sgx_reclaim_epc_pages() for use
by the upcoming EPC cgroup, which will initiate reclaim to enforce
changes to high/max limits.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 7 ++++---
 arch/x86/kernel/cpu/sgx/sgx.h  | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 96399e2016a8..c947b4ae06f3 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -281,6 +281,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 /**
  * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
+ * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
  * @ignore_age:		 Reclaim a page even if it is young
  *
@@ -385,7 +386,7 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 	return i;
 }
 
-static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
+int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age)
 {
 	int ret;
 
@@ -441,7 +442,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
+			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
 	}
 
 	return 0;
@@ -624,7 +625,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
+		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index ec8d567cd975..ce859331ddf5 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -206,6 +206,7 @@ void sgx_reclaim_direct(void);
 void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
 int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.38.1

