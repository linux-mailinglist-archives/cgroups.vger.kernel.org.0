Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C579DEF5
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbjIMEJH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbjIMEI6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:08:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ADC173F;
        Tue, 12 Sep 2023 21:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578133; x=1726114133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vepZbnyqDblpA7sGXTqcBcK8nK4OglstUykMn9D3KzU=;
  b=V6Z/A85geapDrS8Vv8upjlkTxTdF0di2X5kjpeRtZQ3n5cg8uzZDmabX
   MmN00F3Oa8bNs+/AbG7+dEyy7JPGoRgRAolgiWmxzn+N0SCjE8Dy8do2d
   1cy5tTLO8fNAsBWSqc9t/6rEmbVloAM5XtEYJ+CEq3mhmwNQ/wf9aHZvD
   wdp8TJMfolzbOLwGzz4rVPmB/Lafm3btqlGXrx/5ZiIC/kuzdsJ7GZ05J
   ZEgGHf8nULPMK30S58ucZJ0nppio8flaMUfK2efxJPSdOQ30JCvZWJvQz
   FqB6E1QIvztttIAnCBh+3ijmDMxYlKWWNOYeKAjcGqDDjl2yShxHhdqC/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990425"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990425"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155959"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155959"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:47 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 11/18] x86/sgx: store unreclaimable pages in LRU lists
Date:   Tue, 12 Sep 2023 21:06:28 -0700
Message-Id: <20230913040635.28815-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

When an OOM event occurs, all pages associated with an enclave will need
to be freed, including pages that are not currently tracked by the
cgroup LRU lists.

Add a new "unreclaimable" list to the sgx_epc_lru_lists struct and
update the "sgx_record/drop_epc_pages()" functions for adding/removing
VA and SECS pages to/from this "unreclaimable" list.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
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
index 91f83a5e543d..bf0ac3677ca8 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -748,6 +748,7 @@ void sgx_encl_release(struct kref *ref)
 	xa_destroy(&encl->page_array);
 
 	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 	}
@@ -756,6 +757,7 @@ void sgx_encl_release(struct kref *ref)
 		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
 					   list);
 		list_del(&va_page->list);
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
 	}
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 95ec20a6992f..8c23bb524674 100644
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
index e06b4aadb6a1..e210af77f0cf 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -150,17 +150,23 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
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

