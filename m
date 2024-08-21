Return-Path: <cgroups+bounces-4384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A9959263
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2512A1C2209D
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C474BED;
	Wed, 21 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpY1ml17"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17456440;
	Wed, 21 Aug 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205262; cv=none; b=rEFnJadVqfOtDFZGoSIX8g63h5pgQA5i7UmyacdQTXioWqv3jC6RYW98BhB2ESepyZe7NTHhUW1/N5Omq1A8G5W4vuq6HuY2g39bQqWFintCPqKwWvpqEpHZLlxxRxsLfKrSLCFnibm5ydM1b89Ozo6mCwjaPVM34zKSkZ7eib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205262; c=relaxed/simple;
	bh=aBp+AO4BxlLvxNYOsjganDc4V0zfIfXD4mqngD4w4vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI1ZuObKlWt2vHg7hCAHjHAMMul2c27ERGaOx/OQs0V6YJ4zoftKQFIPiKsSrlU0wfiWrMtmF7IB3AISKkYSD5PYGFvr0UJoXMobHho4WwDSMQkXPSEOGOiM1PHFutBopPdQ+NzkaCsrwhlcIxPVbI6r8a5jj6BnUJZJhexeiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpY1ml17; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205260; x=1755741260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBp+AO4BxlLvxNYOsjganDc4V0zfIfXD4mqngD4w4vw=;
  b=TpY1ml17AOkOV5ST2IBfnorXFlPr0qn/tg6zgDjLTtitWTocdbuPPbTU
   pgV+vujWRd0PA36KHTzPYyx7OUioNYxosGdPC2VgXoy4oF/SROD2RMBlT
   YD6lCTKao5f5Rkf4krT9vKd2vHNz1+vja3LsVfDYxb2nXBoVIq8/8AX4U
   EJ486Qn6X5EjQFOjshIKxVanP4lDphfrxaFNdZ0gO0cbxiHSGe9npiHQo
   AHTU7Yd03NtlP3f2exILBfq4w51ItpfI34KbKADvdIabqNotzAbv7R9f2
   UWYfF69iYp95CiOWzTyB0zO+JrZoNJwQRJvmYmn/FLi+5/E46Ez12KUJl
   Q==;
X-CSE-ConnectionGUID: edJkvbLwT4KHXRDAUlCxCQ==
X-CSE-MsgGUID: bWT11sEWT3WvEiId2hCGbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107830"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107830"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:16 -0700
X-CSE-ConnectionGUID: McdZgyEJTcaFqup/v69sng==
X-CSE-MsgGUID: UGridlf7QACJ/OblBvXbTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078578"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:14 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
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
Subject: [PATCH v16 01/16] x86/sgx: Replace boolean parameters with enums
Date: Tue, 20 Aug 2024 18:53:49 -0700
Message-ID: <20240821015404.6038-2-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821015404.6038-1-haitao.huang@linux.intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
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
index 27892e57c4ef..e64073fb4256 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -464,14 +464,14 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
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
@@ -543,12 +543,12 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
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
@@ -557,7 +557,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  *   an EPC page,
  *   -errno on error
  */
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 {
 	struct sgx_epc_page *page;
 
@@ -571,7 +571,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
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
2.43.0


