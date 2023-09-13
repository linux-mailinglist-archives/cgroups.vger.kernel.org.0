Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE55079DEF8
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjIMEJL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbjIMEJC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:09:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEAF1736;
        Tue, 12 Sep 2023 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578138; x=1726114138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qtSM03QbJLI7zt9hAzmFYzEy+EU72cnHWti1yqOHIcQ=;
  b=UGw7Qlqklhh+x0ywTYO8u42BLmOrzpQSOYZD3TMfy4RYD8VN4n3Umyua
   6JmFWuu+fXgoK7gz5oBTxb4OOGiIeKmLJNQvMPdumbz8zBTkG8bjF3N0i
   xNeSOfzp2yyMEJ8C1zqSawOKL6eYBDIhARLG55YmyD6QJN0oOoFEKPI4g
   TX831V9HDXGsFAOWAPlRvOXb8/isDhZsjMHReRLBG/3DL+xFsa2xeeg0L
   j5M7JgqXqjVXlMiDTGu2beCiMq+myNlhuX+sSsQN3sfPXhwCs45Bgvakm
   jnKC06iZ0lblaE55O2KDYZLyWddAoPeWluUK2JgiWql8Cxasfqp2ef5e+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990479"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155978"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155978"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:50 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
Date:   Tue, 12 Sep 2023 21:06:30 -0700
Message-Id: <20230913040635.28815-14-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Adjust and expose the top-level reclaim function as
sgx_reclaim_epc_pages() for use by the upcoming EPC cgroup, which will
initiate reclaim to enforce the max limit.

Make these adjustments to the function signature.

1) To take a parameter that specifies the number of pages to scan for
reclaiming. Define a max value of 32, but scan 16 in the case for the
global reclaimer (ksgxd). The EPC cgroup will use it to specify a
desired number of pages to be reclaimed up to the max value of 32.

2) To take a flag to force reclaiming a page regardless of its age.  The
EPC cgroup will use the flag to enforce its limits by draining the
reclaimable lists before resorting to other measures, e.g. forcefully
kill enclaves.

3) Return the number of reclaimed pages. The EPC cgroup will use the
result to track reclaiming progress and escalate to a more forceful
reclaiming mode, e.g., calling this function with the flag to ignore age
of pages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- Combined the 3 patches that made the individual changes to the
function signature.
- Removed 'high' limit in commit message.
---
 arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c8900d62cfff..e1dde431a400 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -17,6 +17,10 @@
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
+/**
+ * Maximum number of pages to scan for reclaiming.
+ */
+#define SGX_NR_TO_SCAN_MAX	32
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
@@ -279,7 +283,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
+/**
+ * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
+ * @nr_to_scan:		 Number of EPC pages to scan for reclaim
+ * @ignore_age:		 Reclaim a page even if it is young
+ *
  * Take a fixed number of pages from the head of the active page pool and
  * reclaim them to the enclave's private shmem files. Skip the pages, which have
  * been accessed since the last scan. Move those pages to the tail of active
@@ -292,15 +300,15 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
  */
-static void sgx_reclaim_pages(void)
+size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
 {
-	struct sgx_backing backing[SGX_NR_TO_SCAN];
+	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
 	struct sgx_epc_page *epc_page, *tmp;
 	struct sgx_encl_page *encl_page;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
-	int ret;
-	int i;
+	size_t ret;
+	size_t i;
 
 	spin_lock(&sgx_global_lru.lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
@@ -326,13 +334,14 @@ static void sgx_reclaim_pages(void)
 	spin_unlock(&sgx_global_lru.lock);
 
 	if (list_empty(&iso))
-		return;
+		return 0;
 
 	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_page;
 
-		if (!sgx_reclaimer_age(epc_page))
+		if (i == SGX_NR_TO_SCAN_MAX ||
+		    (!ignore_age && !sgx_reclaimer_age(epc_page)))
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
@@ -371,6 +380,7 @@ static void sgx_reclaim_pages(void)
 
 		sgx_free_epc_page(epc_page);
 	}
+	return i;
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
@@ -387,7 +397,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
 }
 
 static int ksgxd(void *p)
@@ -410,7 +420,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
 
 		cond_resched();
 	}
@@ -582,7 +592,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages();
+		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 3818be5a8bd3..aa4ec2c0ce96 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -177,6 +177,7 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
 int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
+size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1

