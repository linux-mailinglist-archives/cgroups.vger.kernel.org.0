Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E2640D66
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiLBShN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiLBShL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEEEDD56;
        Fri,  2 Dec 2022 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006231; x=1701542231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+7CHYhh5wuKLW8x7IX2pGjuO6Ml3uaP1xZZqkdxdwU=;
  b=i2/LeCXIwJoB1Fl4myXlwolIrjDhHegFAxrqOKZeo+3wrDT0lHRGAW7w
   vjBwUwFIoMnArnKD3mgNwS6jE1R+RV3AhlkT6SYS87KM+HtoMP9e27mxY
   V2TTduKeXgdhkTIQzsweBed/hc9Wt7fWIn12rFX4KZtTEzqhCS+KkdIjf
   12xbC8khSNC6V3RY64tZy6CZgTRkvDe1uXQi3L28g9xaRSULB2ivVjVK/
   icZgyRlph1c0Waiz4yuRgaIHymvxupyGvqT7vdXLttWZhBoF7p1/I0Mqd
   bKj4UL9VENCmPI/5JZXRojAbnph5YQL2zbimwoErVdU0ELNTHI8D8VgQK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724510"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724510"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717386"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717386"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:08 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 03/18] x86/sgx: Add 'struct sgx_epc_lru_lists' to encapsulate lru list(s)
Date:   Fri,  2 Dec 2022 10:36:39 -0800
Message-Id: <20221202183655.3767674-4-kristen@linux.intel.com>
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

Introduce a data structure to wrap the existing reclaimable list
and its spinlock in a struct to minimize the code changes needed
to handle multiple LRUs as well as reclaimable and non-reclaimable
lists, both of which will be introduced and used by SGX EPC cgroups.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/sgx.h | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 39cb15a8abcb..5e6d88438fae 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -90,6 +90,71 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+/*
+ * This data structure wraps a list of reclaimable EPC pages, and a list of
+ * non-reclaimable EPC pages and is used to implement a LRU policy during
+ * reclamation.
+ */
+struct sgx_epc_lru_lists {
+	spinlock_t lock;
+	struct list_head reclaimable;
+	struct list_head unreclaimable;
+};
+
+static inline void sgx_lru_init(struct sgx_epc_lru_lists *lrus)
+{
+	spin_lock_init(&lrus->lock);
+	INIT_LIST_HEAD(&lrus->reclaimable);
+	INIT_LIST_HEAD(&lrus->unreclaimable);
+}
+
+/*
+ * Must be called with queue lock acquired
+ */
+static inline void __sgx_epc_page_list_push(struct list_head *list, struct sgx_epc_page *page)
+{
+	list_add_tail(&page->list, list);
+}
+
+/*
+ * Must be called with queue lock acquired
+ */
+static inline struct sgx_epc_page * __sgx_epc_page_list_pop(struct list_head *list)
+{
+	struct sgx_epc_page *epc_page;
+
+	if (list_empty(list))
+		return NULL;
+
+	epc_page = list_first_entry(list, struct sgx_epc_page, list);
+	list_del_init(&epc_page->list);
+	return epc_page;
+}
+
+static inline struct sgx_epc_page *
+sgx_epc_pop_reclaimable(struct sgx_epc_lru_lists *lrus)
+{
+	return __sgx_epc_page_list_pop(&(lrus)->reclaimable);
+}
+
+static inline void sgx_epc_push_reclaimable(struct sgx_epc_lru_lists *lrus,
+					    struct sgx_epc_page *page)
+{
+	__sgx_epc_page_list_push(&(lrus)->reclaimable, page);
+}
+
+static inline struct sgx_epc_page *
+sgx_epc_pop_unreclaimable(struct sgx_epc_lru_lists *lrus)
+{
+	return __sgx_epc_page_list_pop(&(lrus)->unreclaimable);
+}
+
+static inline void sgx_epc_push_unreclaimable(struct sgx_epc_lru_lists *lrus,
+					      struct sgx_epc_page *page)
+{
+	__sgx_epc_page_list_push(&(lrus)->unreclaimable, page);
+}
+
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
-- 
2.38.1

