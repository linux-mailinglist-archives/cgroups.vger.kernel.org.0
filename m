Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC1640D7C
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiLBSim (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiLBSiB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:38:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B93ED698;
        Fri,  2 Dec 2022 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006249; x=1701542249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1TtIGbRSI3H2yjUyeBNwanZjUKzTjkmoWFW60lz7GHQ=;
  b=k0f6EeYG4JNQd/AV+nA6MwS50bfHEyB+z+Qzi5rdZSbVz2LjN+ErXC8P
   yTLlXzR4tYPENCYmgo0DuX0gsPUrn3IpHWtIE0L6BZqEVfex85zxiIqmN
   CP4GqTU4a4DIEEJt/pRVbMtwzu3iFWKJmuQ0EqNiGgKuSNyD3UIVxW3C1
   4Rjx4xKVLavqXtQWIJKaPBOHDceC281JQpzKtPaQqnO0wh6Fy9S/PeA4Q
   IAk+VNYaBPIEcJ0R2H9DzD7b4ax9QltuVShH/IOY6H1OU0fQ16gHLL6Jw
   qT/vh5sR4550Np+Fpw6Vn/cp43D+/q70k7sB8tuXS3FvhXiwK0RCPgfyH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724646"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717557"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717557"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:28 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 13/18] x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
Date:   Fri,  2 Dec 2022 10:36:49 -0800
Message-Id: <20221202183655.3767674-14-kristen@linux.intel.com>
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

Move the isolation loop into a standalone helper, sgx_isolate_pages(),
in preparation for existence of multiple LRUs.  Expose the helper to
other SGX code so that it can be called from the EPC cgroup code, e.g.
to isolate pages from a single cgroup LRU.  Exposing the isolation loop
allows the cgroup iteration logic to be wholly encapsulated within the
cgroup code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 68 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c947b4ae06f3..a59550fa150b 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -280,7 +280,46 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 }
 
 /**
- * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
+ * sgx_isolate_epc_pages() - Isolate pages from an LRU for reclaim
+ * @lru:	LRU from which to reclaim
+ * @nr_to_scan:	Number of pages to scan for reclaim
+ * @dst:	Destination list to hold the isolated pages
+ */
+void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, int *nr_to_scan,
+			   struct list_head *dst)
+{
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+
+	spin_lock(&lru->lock);
+	for (; *nr_to_scan > 0; --(*nr_to_scan)) {
+		if (list_empty(&lru->reclaimable))
+			break;
+
+		epc_page = sgx_epc_peek_reclaimable(lru);
+		if (!epc_page)
+			break;
+
+		encl_page = epc_page->encl_owner;
+
+		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_PAGE_ENCLAVE)))
+			continue;
+
+		if (kref_get_unless_zero(&encl_page->encl->refcount)) {
+			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
+			list_move_tail(&epc_page->list, dst);
+		} else {
+			/* The owner is freeing the page, remove it from the
+			 * LRU list
+			 */
+			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+			list_del_init(&epc_page->list);
+		}
+	}
+	spin_unlock(&lru->lock);
+}
+
+/**
  * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
  * @nr_to_scan:		 Number of EPC pages to scan for reclaim
  * @ignore_age:		 Reclaim a page even if it is young
@@ -305,37 +344,14 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 	struct sgx_epc_lru_lists *lru;
 	pgoff_t page_index;
 	LIST_HEAD(iso);
+	int i = 0;
 	int ret;
-	int i;
-
-	spin_lock(&sgx_global_lru.lock);
-	for (i = 0; i < nr_to_scan; i++) {
-		epc_page = sgx_epc_peek_reclaimable(&sgx_global_lru);
-		if (!epc_page)
-			break;
-
-		encl_page = epc_page->encl_owner;
 
-		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_PAGE_ENCLAVE)))
-			continue;
-
-		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
-			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
-			list_move_tail(&epc_page->list, &iso);
-		} else {
-			/* The owner is freeing the page, remove it from the
-			 * LRU list
-			 */
-			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
-			list_del_init(&epc_page->list);
-		}
-	}
-	spin_unlock(&sgx_global_lru.lock);
+	sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
 
 	if (list_empty(&iso))
 		return 0;
 
-	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
 		encl_page = epc_page->encl_owner;
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index ce859331ddf5..4499a5d5547d 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -207,6 +207,8 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
 int sgx_drop_epc_page(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age);
+void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, int *nr_to_scan,
+			   struct list_head *dst);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.38.1

