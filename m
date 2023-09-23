Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF67ABD64
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjIWDH1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjIWDHV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154551B1;
        Fri, 22 Sep 2023 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438427; x=1726974427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C63qJ730rbliOEJWIvRszebH9fI5wJTL885JlaOiRVw=;
  b=Dpj3LOxn5sbyqXNxDgx8ly+nkJEviBSKrGMtBUpvgyuRW1on8C9y1F6H
   BJ9Gn3ddYnvhqnOo2OcmQkAbH1AM4JMO1jR1V+xKOqfH4fUmQuXxI5IyS
   QxXNM7JHutMbfPL1r++5BR1xtCWtgjqLeRRv4RRrUdxdlnF1+GZKDfwU2
   RZ52hluiazsvjy3RmwJfoV7mkKNxs7e8LSSI+RznArLUjkmf3bn5bS6Fg
   I4aEjLL5lCgy3VaGAWF8+o4/NsJaL3FbpMHRL7yDPO2G3qEfni/QtB1Ib
   V3nmaUyX7uk+Az8O0bU9EpsZvFg/5EPLWRhpbg3a9mfjEwVM0d8K3N67n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466805"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048565"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048565"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:10 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
Date:   Fri, 22 Sep 2023 20:06:50 -0700
Message-Id: <20230923030657.16148-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230923030657.16148-1-haitao.huang@linux.intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

When an OOM event occurs, all pages associated with an enclave will need
to be freed, including pages that are not currently tracked by the
cgroup LRU lists.

Add a new "unreclaimable" list to the sgx_epc_lru_lists struct and
update the "sgx_record/drop_epc_pages()" functions for adding/removing
VA and SECS pages to/from this "unreclaimable" list.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- Updates for patch reordering.
- Revised commit messages.
- Revised comments for the list.

V3:
- Removed tracking virtual EPC pages in unreclaimable list as host
kernel does not reclaim them. The EPC cgroups implemented later only
blocks allocating for a guest if the limit is reached by returning
-ENOMEM from sgx_alloc_epc_page() called by virt_epc, and does nothing
else. Therefore, no need to track those in LRU lists.
---
 arch/x86/kernel/cpu/sgx/encl.c  | 2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c | 1 +
 arch/x86/kernel/cpu/sgx/main.c  | 3 +++
 arch/x86/kernel/cpu/sgx/sgx.h   | 8 +++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index da1657813fce..a8617e6a4b4e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -746,6 +746,7 @@ void sgx_encl_release(struct kref *ref)
 	xa_destroy(&encl->page_array);
 
 	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 	}
@@ -754,6 +755,7 @@ void sgx_encl_release(struct kref *ref)
 		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
 					   list);
 		list_del(&va_page->list);
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
 	}
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index cd338e93acc1..50ddd8988452 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -48,6 +48,7 @@ void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 	encl->page_cnt--;
 
 	if (va_page) {
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		list_del(&va_page->list);
 		kfree(va_page);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ed813288af44..f3a3ed894616 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -268,6 +268,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 			goto out;
 
 		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 
@@ -510,6 +511,8 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 	page->flags |= flags;
 	if (sgx_epc_page_reclaimable(flags))
 		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+	else
+		list_add_tail(&page->list, &sgx_global_lru.unreclaimable);
 	spin_unlock(&sgx_global_lru.lock);
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 51aba1cd1937..337747bef7c2 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -152,17 +152,23 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 }
 
 /*
- * Tracks EPC pages reclaimable by the reclaimer (ksgxd).
+ * Contains EPC pages tracked by the reclaimer (ksgxd).
  */
 struct sgx_epc_lru_lists {
 	spinlock_t lock;
 	struct list_head reclaimable;
+	/*
+	 * Tracks SECS, VA pages,etc., pages only freeable after all its
+	 * dependent reclaimables are freed.
+	 */
+	struct list_head unreclaimable;
 };
 
 static inline void sgx_lru_init(struct sgx_epc_lru_lists *lrus)
 {
 	spin_lock_init(&lrus->lock);
 	INIT_LIST_HEAD(&lrus->reclaimable);
+	INIT_LIST_HEAD(&lrus->unreclaimable);
 }
 
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
-- 
2.25.1

