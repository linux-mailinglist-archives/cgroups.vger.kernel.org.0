Return-Path: <cgroups+bounces-2724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0388B80C6
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A1F1C23146
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF719DF5F;
	Tue, 30 Apr 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQGlaccv"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1D19DF45;
	Tue, 30 Apr 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506671; cv=none; b=edRVdfF1OhhZshw32SL1PiKpc/PaxG/QzEXu86f7J3n6aT37LdbHQWI4zoWCOgJvlQDbsxqtAMLLCdzHh9yww1QparYG6oWtlZkxbi/fvxD88togN61IgwO+10U2Zz1SCjwmCTY1C2tWsAn2c52tBnpu8muv8yzcQHWQ3YP+o9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506671; c=relaxed/simple;
	bh=GPZvGvi6PM3uewi5xKf/fHnXTlqZU38tXJf5pvUdLGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+BuCv1VrUuQBE2nwJQRd4ifnAD3ylLmJfixtd6FfIlq9wL5bV2zo9VG8J9q91I2SFZO5tDtxJ1wpAIx2P16GX5CMTeb2q3I+Sz8yBWrKYD1wC5LOyVFh1jjkagl7JpTCSMtFPTXAZfFvgqscmLbN4iMQvgPGcenHlOPv9pUj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQGlaccv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714506670; x=1746042670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPZvGvi6PM3uewi5xKf/fHnXTlqZU38tXJf5pvUdLGY=;
  b=HQGlaccvqisCvw+U79xf5XEHFwVcQIyRgGOqJeWTOn0GYg6dxv4uxA1F
   ZxLPXlq2Q3N7xxFxU/kUARH+1qy/54+l9Kwhd0gZlpUPNuIPrHEg05e9x
   vXi8z18hy7/TxLBVYVmrUnK8Q2HSnlWvn1l09cs+jJ3tpuJPnaFFvG7m/
   SB8TgWfl6OfX4VJl+YSdjrUujVap5qkyGD2IKCwVpBn25QKlAb1aenTTx
   3nKUvj2ZXEc1S9S0VddkDWod4CdnbP/1NcY2RicbCAgHFOaxVfM21eSUS
   1e0BkoS99izdnvF5P8wf+7tMqC2DKVsCelu5dELKK08Yn3tVaTkXA03j3
   Q==;
X-CSE-ConnectionGUID: c2F3+0HcTzWfulIqrI8SWg==
X-CSE-MsgGUID: IQ9p5ODPQHKkWRT4xbINvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10355568"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10355568"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:51:09 -0700
X-CSE-ConnectionGUID: xhfAvDGNRUGG+vdA0LI1CQ==
X-CSE-MsgGUID: oklgzl/9RIyKNWwJdY9GyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31280297"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2024 12:51:09 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v13 01/14] x86/sgx: Replace boolean parameters with enums
Date: Tue, 30 Apr 2024 12:50:55 -0700
Message-Id: <20240430195108.5676-2-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430195108.5676-1-haitao.huang@linux.intel.com>
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace boolean parameters for 'reclaim' in the function
sgx_alloc_epc_page() and its callers with an enum.

Also opportunistically remove non-static declaration of
__sgx_alloc_epc_page() and a typo

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
 arch/x86/kernel/cpu/sgx/encl.h  |  4 ++--
 arch/x86/kernel/cpu/sgx/ioctl.c | 10 +++++-----
 arch/x86/kernel/cpu/sgx/main.c  | 14 +++++++-------
 arch/x86/kernel/cpu/sgx/sgx.h   | 13 +++++++++++--
 arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..f474179b6f77 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -217,7 +217,7 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(encl_page, false);
+	epc_page = sgx_alloc_epc_page(encl_page, SGX_NO_RECLAIM);
 	if (IS_ERR(epc_page))
 		return epc_page;
 
@@ -359,14 +359,14 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 		goto err_out_unlock;
 	}
 
-	epc_page = sgx_alloc_epc_page(encl_page, false);
+	epc_page = sgx_alloc_epc_page(encl_page, SGX_NO_RECLAIM);
 	if (IS_ERR(epc_page)) {
 		if (PTR_ERR(epc_page) == -EBUSY)
 			vmret =  VM_FAULT_NOPAGE;
 		goto err_out_unlock;
 	}
 
-	va_page = sgx_encl_grow(encl, false);
+	va_page = sgx_encl_grow(encl, SGX_NO_RECLAIM);
 	if (IS_ERR(va_page)) {
 		if (PTR_ERR(va_page) == -EBUSY)
 			vmret = VM_FAULT_NOPAGE;
@@ -1232,8 +1232,8 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
- * @reclaim: Reclaim EPC pages directly if none available. Enclave
- *           mutex should not be held if this is set.
+ * @reclaim: Whether reclaim EPC pages directly if none available. Enclave
+ *           mutex should not be held for SGX_DO_RECLAIM.
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
  *
@@ -1241,7 +1241,7 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
+struct sgx_epc_page *sgx_alloc_va_page(enum sgx_reclaim reclaim)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..fe15ade02ca1 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,14 +116,14 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
+struct sgx_epc_page *sgx_alloc_va_page(enum sgx_reclaim reclaim);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, enum sgx_reclaim reclaim);
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..793a0ba2cb16 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, enum sgx_reclaim reclaim)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -64,7 +64,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
-	va_page = sgx_encl_grow(encl, true);
+	va_page = sgx_encl_grow(encl, SGX_DO_RECLAIM);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
 	else if (va_page)
@@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 
 	encl->backing = backing;
 
-	secs_epc = sgx_alloc_epc_page(&encl->secs, true);
+	secs_epc = sgx_alloc_epc_page(&encl->secs, SGX_DO_RECLAIM);
 	if (IS_ERR(secs_epc)) {
 		ret = PTR_ERR(secs_epc);
 		goto err_out_backing;
@@ -269,13 +269,13 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	if (IS_ERR(encl_page))
 		return PTR_ERR(encl_page);
 
-	epc_page = sgx_alloc_epc_page(encl_page, true);
+	epc_page = sgx_alloc_epc_page(encl_page, SGX_DO_RECLAIM);
 	if (IS_ERR(epc_page)) {
 		kfree(encl_page);
 		return PTR_ERR(epc_page);
 	}
 
-	va_page = sgx_encl_grow(encl, true);
+	va_page = sgx_encl_grow(encl, SGX_DO_RECLAIM);
 	if (IS_ERR(va_page)) {
 		ret = PTR_ERR(va_page);
 		goto err_out_free;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 166692f2d501..d219f14365d4 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -463,14 +463,14 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 /**
  * __sgx_alloc_epc_page() - Allocate an EPC page
  *
- * Iterate through NUMA nodes and reserve ia free EPC page to the caller. Start
+ * Iterate through NUMA nodes and reserve a free EPC page to the caller. Start
  * from the NUMA node, where the caller is executing.
  *
  * Return:
  * - an EPC page:	A borrowed EPC pages were available.
  * - NULL:		Out of EPC pages.
  */
-struct sgx_epc_page *__sgx_alloc_epc_page(void)
+static struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
 	struct sgx_epc_page *page;
 	int nid_of_current = numa_node_id();
@@ -542,12 +542,12 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 /**
  * sgx_alloc_epc_page() - Allocate an EPC page
  * @owner:	the owner of the EPC page
- * @reclaim:	reclaim pages if necessary
+ * @reclaim:	whether reclaim pages if necessary
  *
  * Iterate through EPC sections and borrow a free EPC page to the caller. When a
  * page is no longer needed it must be released with sgx_free_epc_page(). If
- * @reclaim is set to true, directly reclaim pages when we are out of pages. No
- * mm's can be locked when @reclaim is set to true.
+ * @reclaim is set to SGX_DO_RECLAIM, directly reclaim pages when we are out of
+ * pages. No mm's can be locked for SGX_DO_RECLAIM.
  *
  * Finally, wake up ksgxd when the number of pages goes below the watermark
  * before returning back to the caller.
@@ -556,7 +556,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  *   an EPC page,
  *   -errno on error
  */
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 {
 	struct sgx_epc_page *page;
 
@@ -570,7 +570,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		if (list_empty(&sgx_active_page_list))
 			return ERR_PTR(-ENOMEM);
 
-		if (!reclaim) {
+		if (reclaim == SGX_NO_RECLAIM) {
 			page = ERR_PTR(-EBUSY);
 			break;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index d2dad21259a8..ca34cd4f58ac 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -29,6 +29,16 @@
 /* Pages on free list */
 #define SGX_EPC_PAGE_IS_FREE		BIT(1)
 
+/**
+ * enum sgx_reclaim - Whether EPC reclamation is allowed within a function.
+ * %SGX_NO_RECLAIM:		Do not reclaim EPC pages.
+ * %SGX_DO_RECLAIM:		Reclaim EPC pages as needed.
+ */
+enum sgx_reclaim {
+	SGX_NO_RECLAIM,
+	SGX_DO_RECLAIM
+};
+
 struct sgx_epc_page {
 	unsigned int section;
 	u16 flags;
@@ -83,13 +93,12 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
-struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim);
 
 void sgx_ipi_cb(void *info);
 
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7aaa3652e31d..e7fdc3a9abae 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -46,7 +46,7 @@ static int __sgx_vepc_fault(struct sgx_vepc *vepc,
 	if (epc_page)
 		return 0;
 
-	epc_page = sgx_alloc_epc_page(vepc, false);
+	epc_page = sgx_alloc_epc_page(vepc, SGX_NO_RECLAIM);
 	if (IS_ERR(epc_page))
 		return PTR_ERR(epc_page);
 
-- 
2.25.1


