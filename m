Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CF7ABD66
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjIWDHZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjIWDHM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DAE1A8;
        Fri, 22 Sep 2023 20:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438425; x=1726974425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CPVq7hMKhTxLnKfdXR7Q7yMpcir8DY5XsL5VtYGW0ew=;
  b=UGcAPNMKOqBSrrtcEHqIYv7pf84DCxGXAqwrmd0+u9QtO/Aw004XgPWr
   Ue7jVJvi1e1eSbT3G7YBJQp4BN5Oo9RR6JJi+i9lPrI9JyHT+YoKNWB4g
   3C3mPZ6MCG+8n2RYMFKmYZdBgpaX8ZyrEx+h1hHwPLDlwwBJ1OHitT2MC
   kxCjQSBIF1ImeZqh+IHyqCdc5cm6bOEYicIUEJp7A12grMLWY7YqfVvt4
   cZhoJrwykFjoGWBrKLi0SfW0rkxImBWeBptIgnmD4E40Lm2qn40TNAWQ8
   MKBLRtdOgylAzZMErwENispd5wHnBXczNPZeeKZxekJQpo/FWB5CSpoiZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466787"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466787"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048555"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048555"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:08 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating new VA pages
Date:   Fri, 22 Sep 2023 20:06:48 -0700
Message-Id: <20230923030657.16148-10-haitao.huang@linux.intel.com>
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

In a later patch, when a cgroup has exceeded the max capacity for EPC
pages, it may need to identify and OOM kill a less active enclave to
make room for other enclaves within the same group. Such a victim
enclave would have no active pages other than the unreclaimable Version
Array (VA) and SECS pages.  Therefore, the cgroup needs examine its
unreclaimable page list, and finding an enclave given a SECS page or a
VA page. This will require a backpointer from a page to an enclave,
which is not available for VA pages.

Because struct sgx_epc_page instances of VA pages are not owned by an
sgx_encl_page instance, mark their owner as sgx_encl: pass the struct
sgx_encl of the enclave allocating the VA page to sgx_alloc_epc_page(),
which will store this value in the owner field of the struct
sgx_epc_page.  In a later patch, VA pages will be placed in an
unreclaimable queue that can be examined by the cgroup to select the OOM
killed enclave.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V5:
- Fixed some comments in code (Jarkko)

V4:
- Changes needed for patch reordering
- Revised commit messages (Jarkko)
---
 arch/x86/kernel/cpu/sgx/encl.c  |  5 +++--
 arch/x86/kernel/cpu/sgx/encl.h  |  2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
 arch/x86/kernel/cpu/sgx/main.c  | 20 ++++++++++----------
 arch/x86/kernel/cpu/sgx/sgx.h   |  7 ++++++-
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f5afc8d65e22..ec3402d41b63 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -1236,6 +1236,7 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @encl:    The new owner of the page.
  * @reclaim: Reclaim EPC pages directly if none available. Enclave
  *           mutex should not be held if this is set.
  *
@@ -1245,12 +1246,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, reclaim);
+	epc_page = sgx_alloc_epc_page(encl, reclaim);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..831d63f80f5a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,7 +116,7 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 9a32bf5a1070..164256ea18d0 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page(reclaim);
+		va_page->epc_page = sgx_alloc_va_page(encl, reclaim);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index fba06dc5abfe..ed813288af44 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -107,7 +107,7 @@ static unsigned long __sgx_sanitize_pages(struct list_head *dirty_page_list)
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
 {
-	struct sgx_encl_page *page = epc_page->owner;
+	struct sgx_encl_page *page = epc_page->encl_page;
 	struct sgx_encl *encl = page->encl;
 	struct sgx_encl_mm *encl_mm;
 	bool ret = true;
@@ -139,7 +139,7 @@ static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
 
 static void sgx_reclaimer_block(struct sgx_epc_page *epc_page)
 {
-	struct sgx_encl_page *page = epc_page->owner;
+	struct sgx_encl_page *page = epc_page->encl_page;
 	unsigned long addr = page->desc & PAGE_MASK;
 	struct sgx_encl *encl = page->encl;
 	int ret;
@@ -196,7 +196,7 @@ void sgx_ipi_cb(void *info)
 static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 struct sgx_backing *backing)
 {
-	struct sgx_encl_page *encl_page = epc_page->owner;
+	struct sgx_encl_page *encl_page = epc_page->encl_page;
 	struct sgx_encl *encl = encl_page->encl;
 	struct sgx_va_page *va_page;
 	unsigned int va_offset;
@@ -249,7 +249,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 				struct sgx_backing *backing)
 {
-	struct sgx_encl_page *encl_page = epc_page->owner;
+	struct sgx_encl_page *encl_page = epc_page->encl_page;
 	struct sgx_encl *encl = encl_page->encl;
 	struct sgx_backing secs_backing;
 	int ret;
@@ -309,7 +309,7 @@ static void sgx_reclaim_pages(void)
 			break;
 
 		list_del_init(&epc_page->list);
-		encl_page = epc_page->owner;
+		encl_page = epc_page->encl_page;
 
 		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
 			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
@@ -329,7 +329,7 @@ static void sgx_reclaim_pages(void)
 
 	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
-		encl_page = epc_page->owner;
+		encl_page = epc_page->encl_page;
 
 		if (!sgx_reclaimer_age(epc_page))
 			goto skip;
@@ -362,7 +362,7 @@ static void sgx_reclaim_pages(void)
 
 	i = 0;
 	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
-		encl_page = epc_page->owner;
+		encl_page = epc_page->encl_page;
 		sgx_reclaimer_write(epc_page, &backing[i++]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
@@ -562,7 +562,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 	for ( ; ; ) {
 		page = __sgx_alloc_epc_page();
 		if (!IS_ERR(page)) {
-			page->owner = owner;
+			page->encl_page = owner;
 			break;
 		}
 
@@ -607,7 +607,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	spin_lock(&node->lock);
 
-	page->owner = NULL;
+	page->encl_page = NULL;
 	if (page->poison)
 		list_add(&page->list, &node->sgx_poison_page_list);
 	else
@@ -642,7 +642,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
-		section->pages[i].owner = NULL;
+		section->pages[i].encl_page = NULL;
 		section->pages[i].poison = 0;
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 764cec23f4e5..5110dd433b80 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -68,7 +68,12 @@ struct sgx_epc_page {
 	unsigned int section;
 	u16 flags;
 	u16 poison;
-	struct sgx_encl_page *owner;
+
+	/* Possible owner types */
+	union {
+		struct sgx_encl_page *encl_page;
+		struct sgx_encl *encl;
+	};
 	struct list_head list;
 };
 
-- 
2.25.1

