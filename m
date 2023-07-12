Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E099C7513EB
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjGLXCS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjGLXCL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8EE11D;
        Wed, 12 Jul 2023 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202930; x=1720738930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LP9W4hlkm5ekzqLCSSJ7Z7Ak8eW+S808RjkB/UQVNtg=;
  b=hLJvN1em6sEGSJtNcSpguutP/9RqhfcVp+SrgSJn83s5If6i3PnIHcjt
   NJ47J4gaLLmTvbYh+NwiV4beYftSCfQdGgi36HgfVxT3sBmywqFKmDcQt
   CHr9OAPfNkRukIh3mx/oh/Cr7smbP/GKN/J32AR5aV54aJpYcCimgfANs
   QRMSn20KBPVRlGVYx4Isf7MtHPjL1Vxulq20kvDR64Tqibj9dgnDkWORj
   K44uyAmkHXs+WWmJ93WojLjm3bK/kzSY5ijm2DUpiYmqtg+WD6RBj4iJi
   AFtQocVfsLTcUarBaQFfkrLjbRN8v6YW90y9S1uGZmoTV+KD7rOJOM3R3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428773946"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428773946"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338601"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338601"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:06 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com
Subject: [PATCH v3 06/28] x86/sgx: store unreclaimable EPC pages in sgx_epc_lru_lists
Date:   Wed, 12 Jul 2023 16:01:40 -0700
Message-Id: <20230712230202.47929-7-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

When an OOM event occurs, all pages associated with an enclave will
need to be freed, including pages that are not currently tracked by
the reclaimer.

A previous patch converted the SGX code to use a pair of generic
"sgx_record/drop_epc_pages()" for storing the EPC pages that are
tracked by the reclaimer. This patch utilizes those functions to
store the remaining untracked pages to a new "unreclaimable" list
stored with the struct sgx_epc_lru_lists struct.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

V3:
- Removed tracking virtual EPC pages in unreclaimable list as host
kernel does not reclaim them. The EPC cgroups implemented later only
blocks allocating for a guest if the limit is reached by returning
-ENOMEM from sgx_alloc_epc_page() called by virt_epc, and does nothing
else. Therefore, no need to track those in LRU lists.
---
 arch/x86/kernel/cpu/sgx/encl.c  | 8 ++++++--
 arch/x86/kernel/cpu/sgx/ioctl.c | 4 +++-
 arch/x86/kernel/cpu/sgx/main.c  | 3 +++
 arch/x86/kernel/cpu/sgx/sgx.h   | 5 +++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f68af9e37daa..edb8d8c1c229 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -252,7 +252,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		epc_page = sgx_encl_eldu(&encl->secs, NULL);
 		if (IS_ERR(epc_page))
 			return ERR_CAST(epc_page);
-		epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
+		sgx_record_epc_page(epc_page, SGX_EPC_OWNER_ENCL_PAGE |
+				    SGX_EPC_PAGE_RECLAIMER_UNTRACKED);
 	}
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
@@ -724,6 +725,7 @@ void sgx_encl_release(struct kref *ref)
 	xa_destroy(&encl->page_array);
 
 	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 	}
@@ -732,6 +734,7 @@ void sgx_encl_release(struct kref *ref)
 		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
 					   list);
 		list_del(&va_page->list);
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
 	}
@@ -1238,7 +1241,8 @@ struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
 		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
-	epc_page->flags |= SGX_EPC_OWNER_ENCL;
+	sgx_record_epc_page(epc_page, SGX_EPC_OWNER_ENCL |
+			    SGX_EPC_PAGE_RECLAIMER_UNTRACKED);
 
 	return epc_page;
 }
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index dd7ab1c80db6..4e6d0c9d043a 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -48,6 +48,7 @@ void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 	encl->page_cnt--;
 
 	if (va_page) {
+		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		list_del(&va_page->list);
 		kfree(va_page);
@@ -113,7 +114,8 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->attributes = secs->attributes;
 	encl->attributes_mask = SGX_ATTR_UNPRIV_MASK;
 
-	encl->secs.epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
+	sgx_record_epc_page(encl->secs.epc_page, SGX_EPC_OWNER_ENCL_PAGE |
+			    SGX_EPC_PAGE_RECLAIMER_UNTRACKED);
 
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 371135665ff7..9252728865fa 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -268,6 +268,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 			goto out;
 
 		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
+		sgx_drop_epc_page(encl->secs.epc_page);
 		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 
@@ -511,6 +512,8 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 	page->flags |= flags;
 	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
 		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
+	else
+		list_add_tail(&page->list, &sgx_global_lru.unreclaimable);
 	spin_unlock(&sgx_global_lru.lock);
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index c60bbd995942..9f780b2c4cfe 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -23,6 +23,9 @@
 #define SGX_NR_LOW_PAGES		32
 #define SGX_NR_HIGH_PAGES		64
 
+/* Pages, which are not tracked by the page reclaimer. */
+#define SGX_EPC_PAGE_RECLAIMER_UNTRACKED 0
+
 /* Pages, which are being tracked by the page reclaimer. */
 #define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
@@ -101,12 +104,14 @@ struct sgx_epc_lru_lists {
 	/* Must acquire this lock to access */
 	spinlock_t lock;
 	struct list_head reclaimable;
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

