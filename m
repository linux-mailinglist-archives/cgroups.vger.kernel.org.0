Return-Path: <cgroups+bounces-1695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA785A794
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC64282DF7
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720938FA5;
	Mon, 19 Feb 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8CTs7m0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E688381CE;
	Mon, 19 Feb 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357201; cv=none; b=n+WO3NZ5qz/uy4bDvNpHvmIrUcDLdt/3HdWbTvQSMwaAmiszuZguN3i6Dzk6cJdSV/wTNuC+zF/+fukIiA4siWjR4Wo5Lb7FVlcXDFCQVY4BQ46JrNCSBs/2SrcKWopz2czQ3lxPvSgW6wt48Wm3H++mzs6ADyTC4p2mObtXN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357201; c=relaxed/simple;
	bh=ckLM5TQFKK8lW70PK56ytZgY9likU8hHI4t/ifS0ybI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qss89qn5dAECzOH7aMGvtIijkkXxkNzUTu6Mji9lWxGJMOLTGyLfbFqpkKNSRv6J0BrJIZ3uVBELbaDVvBbv6gmHU/7eZJ+9jkZPo7+h8LNKgxy6THM3KOlY/DjYKZgLLn/nipJDGD7Rps9rgwL4XOxhPCRH5PMWlgDPFofsjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8CTs7m0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708357199; x=1739893199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ckLM5TQFKK8lW70PK56ytZgY9likU8hHI4t/ifS0ybI=;
  b=i8CTs7m081aaLkzsQvNT0euj91bzW/PklQeBlU0gtLNoUXSTJgcNznxB
   d5KIPQfgGfPFB5ecxyZIOFeQfEEWNzbUZ9sYF9bisgxpJNyUvgKCouSrZ
   q5cuw0Vd8ZBMCQGPPw6gWVUTeR1lezx7jca/EwUOVrCZlnrwp4rB4y8xW
   Z1A1dHkzYaNs4XzsE+Zr4Sbysj8I1VFtOdyQLvJkOfEQ4/Anj3AZ3wSGf
   3Yv9iMYA8Y/zqwGMoV3xZReDUc9Oj82kbdH1n5JLBqRF84xfzH95WiAN/
   bVNpxytt+4THajKOCsbmeCjKnlDN48Th1jE46FaCpkncBSrhWgPuQp7AT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13149608"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13149608"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="912894511"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912894511"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2024 07:39:57 -0800
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org
Cc: anakrish@microsoft.com,
	bp@alien8.de,
	cgroups@vger.kernel.org,
	chrisyan@microsoft.com,
	dave.hansen@linux.intel.com,
	haitao.huang@linux.intel.com,
	hpa@zytor.com,
	kristen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	mikko.ylinen@linux.intel.com,
	mingo@redhat.com,
	mkoutny@suse.com,
	seanjc@google.com,
	sohil.mehta@intel.com,
	tglx@linutronix.de,
	tim.c.chen@linux.intel.com,
	tj@kernel.org,
	x86@kernel.org,
	yangjie@microsoft.com,
	zhanb@microsoft.com,
	zhiquan1.li@intel.com
Subject: [RFC PATCH] x86/sgx: Remove 'reclaim' boolean parameters
Date: Mon, 19 Feb 2024 07:39:56 -0800
Message-Id: <20240219153957.9957-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
References: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove all boolean parameters for 'reclaim' from the function
sgx_alloc_epc_page() and its callers by making two versions of each
function.

Also opportunistically remove non-static declaration of
__sgx_alloc_epc_page() and a typo

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 56 +++++++++++++++++++++------
 arch/x86/kernel/cpu/sgx/encl.h  |  6 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 23 ++++++++---
 arch/x86/kernel/cpu/sgx/main.c  | 68 ++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h   |  4 +-
 arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
 6 files changed, 115 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..07f369ae855c 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -217,7 +217,7 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(encl_page, false);
+	epc_page = sgx_alloc_epc_page(encl_page);
 	if (IS_ERR(epc_page))
 		return epc_page;
 
@@ -359,14 +359,14 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 		goto err_out_unlock;
 	}
 
-	epc_page = sgx_alloc_epc_page(encl_page, false);
+	epc_page = sgx_alloc_epc_page(encl_page);
 	if (IS_ERR(epc_page)) {
 		if (PTR_ERR(epc_page) == -EBUSY)
 			vmret =  VM_FAULT_NOPAGE;
 		goto err_out_unlock;
 	}
 
-	va_page = sgx_encl_grow(encl, false);
+	va_page = sgx_encl_grow(encl);
 	if (IS_ERR(va_page)) {
 		if (PTR_ERR(va_page) == -EBUSY)
 			vmret = VM_FAULT_NOPAGE;
@@ -1230,23 +1230,23 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 	} while (unlikely(encl->mm_list_version != mm_list_version));
 }
 
-/**
- * sgx_alloc_va_page() - Allocate a Version Array (VA) page
- * @reclaim: Reclaim EPC pages directly if none available. Enclave
- *           mutex should not be held if this is set.
- *
- * Allocate a free EPC page and convert it to a Version Array (VA) page.
+typedef struct sgx_epc_page *(*sgx_alloc_epc_page_fn_t)(void *owner);
+
+/*
+ * Allocate a Version Array (VA) page
+ * @alloc_fn: the EPC page allocation function.
  *
  * Return:
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
+static struct sgx_epc_page *__sgx_alloc_va_page(sgx_alloc_epc_page_fn_t alloc_fn)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, reclaim);
+	epc_page = alloc_fn(NULL);
+
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
@@ -1260,6 +1260,40 @@ struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
 	return epc_page;
 }
 
+/**
+ * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ *
+ * Allocate a free EPC page and convert it to a VA page.
+ *
+ * Do not reclaim EPC pages if none available.
+ *
+ * Return:
+ *   a VA page,
+ *   -errno otherwise
+ */
+struct sgx_epc_page *sgx_alloc_va_page(void)
+{
+    return __sgx_alloc_va_page(sgx_alloc_epc_page);
+}
+
+/**
+ * sgx_alloc_va_page_reclaim() - Allocate a Version Array (VA) page
+ *
+ * Allocate a free EPC page and convert it to a VA page.
+ *
+ * Reclaim EPC pages directly if none available. Enclave mutex should not be
+ * held.
+ *
+ * Return:
+ *   a VA page,
+ *   -errno otherwise
+ */
+
+struct sgx_epc_page *sgx_alloc_va_page_reclaim(void)
+{
+    return __sgx_alloc_va_page(sgx_alloc_epc_page_reclaim);
+}
+
 /**
  * sgx_alloc_va_slot - allocate a VA slot
  * @va_page:	a &struct sgx_va_page instance
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..3248ff72e573 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,14 +116,16 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
+struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page_reclaim(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+struct sgx_va_page *sgx_encl_grow_reclaim(struct sgx_encl *encl);
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..70f904f753aa 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,8 @@
 #include "encl.h"
 #include "encls.h"
 
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
+typedef struct sgx_epc_page *(*sgx_alloc_va_page_fn_t)(void);
+static struct sgx_va_page *__sgx_encl_grow(struct sgx_encl *encl, sgx_alloc_va_page_fn_t alloc_fn)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -30,7 +31,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page(reclaim);
+		va_page->epc_page = alloc_fn();
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
@@ -43,6 +44,16 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 	return va_page;
 }
 
+struct sgx_va_page *sgx_encl_grow_reclaim(struct sgx_encl *encl)
+{
+    return __sgx_encl_grow(encl, sgx_alloc_va_page_reclaim);
+}
+
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+{
+    return __sgx_encl_grow(encl, sgx_alloc_va_page);
+}
+
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 {
 	encl->page_cnt--;
@@ -64,7 +75,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
-	va_page = sgx_encl_grow(encl, true);
+	va_page = sgx_encl_grow_reclaim(encl);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
 	else if (va_page)
@@ -83,7 +94,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 
 	encl->backing = backing;
 
-	secs_epc = sgx_alloc_epc_page(&encl->secs, true);
+	secs_epc = sgx_alloc_epc_page_reclaim(&encl->secs);
 	if (IS_ERR(secs_epc)) {
 		ret = PTR_ERR(secs_epc);
 		goto err_out_backing;
@@ -269,13 +280,13 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	if (IS_ERR(encl_page))
 		return PTR_ERR(encl_page);
 
-	epc_page = sgx_alloc_epc_page(encl_page, true);
+	epc_page = sgx_alloc_epc_page_reclaim(encl_page);
 	if (IS_ERR(epc_page)) {
 		kfree(encl_page);
 		return PTR_ERR(epc_page);
 	}
 
-	va_page = sgx_encl_grow(encl, true);
+	va_page = sgx_encl_grow_reclaim(encl);
 	if (IS_ERR(va_page)) {
 		ret = PTR_ERR(va_page);
 		goto err_out_free;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 166692f2d501..ed9b711049c2 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -463,14 +463,16 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 /**
  * __sgx_alloc_epc_page() - Allocate an EPC page
  *
- * Iterate through NUMA nodes and reserve ia free EPC page to the caller. Start
+ * Iterate through NUMA nodes and reserve a free EPC page to the caller. Start
  * from the NUMA node, where the caller is executing.
  *
+ * When a page is no longer needed it must be released with sgx_free_epc_page().
+ *
  * Return:
  * - an EPC page:	A borrowed EPC pages were available.
- * - NULL:		Out of EPC pages.
+ * - -errno:		Out of EPC pages.
  */
-struct sgx_epc_page *__sgx_alloc_epc_page(void)
+static struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
 	struct sgx_epc_page *page;
 	int nid_of_current = numa_node_id();
@@ -493,7 +495,24 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 			return page;
 	}
 
-	return ERR_PTR(-ENOMEM);
+	if (list_empty(&sgx_active_page_list))
+		return ERR_PTR(-ENOMEM);
+
+	return ERR_PTR(-EBUSY);
+}
+
+/*
+ * Post-processing after allocating an EPC page.
+ *
+ * Set its owner, wake up ksgxd when the number of pages goes below the watermark.
+ */
+static void sgx_alloc_epc_page_post(struct sgx_epc_page *page, void* owner)
+{
+	if (!IS_ERR(page))
+		page->owner = owner;
+
+	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+		wake_up(&ksgxd_waitq);
 }
 
 /**
@@ -542,38 +561,44 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 /**
  * sgx_alloc_epc_page() - Allocate an EPC page
  * @owner:	the owner of the EPC page
- * @reclaim:	reclaim pages if necessary
  *
- * Iterate through EPC sections and borrow a free EPC page to the caller. When a
- * page is no longer needed it must be released with sgx_free_epc_page(). If
- * @reclaim is set to true, directly reclaim pages when we are out of pages. No
- * mm's can be locked when @reclaim is set to true.
+ * When a page is no longer needed it must be released with sgx_free_epc_page().
  *
- * Finally, wake up ksgxd when the number of pages goes below the watermark
- * before returning back to the caller.
+ * Return:
+ *   an EPC page,
+ *   -errno on error
+ */
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner)
+{
+	struct sgx_epc_page *page;
+
+	page = __sgx_alloc_epc_page();
+
+	sgx_alloc_epc_page_post(page, owner);
+
+	return page;
+}
+/**
+ * sgx_alloc_epc_page_reclaim() - Allocate an EPC page, reclaim pages if necessary
+ * @owner:	the owner of the EPC page
+ *
+ * Reclaim pages when we are out of pages. No mm's can be locked.
  *
  * Return:
  *   an EPC page,
  *   -errno on error
  */
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
+struct sgx_epc_page *sgx_alloc_epc_page_reclaim(void *owner)
 {
 	struct sgx_epc_page *page;
 
 	for ( ; ; ) {
 		page = __sgx_alloc_epc_page();
 		if (!IS_ERR(page)) {
-			page->owner = owner;
 			break;
 		}
-
-		if (list_empty(&sgx_active_page_list))
-			return ERR_PTR(-ENOMEM);
-
-		if (!reclaim) {
-			page = ERR_PTR(-EBUSY);
+		if (PTR_ERR(page) != -EBUSY)
 			break;
-		}
 
 		if (signal_pending(current)) {
 			page = ERR_PTR(-ERESTARTSYS);
@@ -584,8 +609,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		cond_resched();
 	}
 
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		wake_up(&ksgxd_waitq);
+	sgx_alloc_epc_page_post(page, owner);
 
 	return page;
 }
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index d2dad21259a8..d6246a79f0b6 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -83,13 +83,13 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
-struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner);
+struct sgx_epc_page *sgx_alloc_epc_page_reclaim(void *owner);
 
 void sgx_ipi_cb(void *info);
 
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7aaa3652e31d..6a81d8af84ab 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -46,7 +46,7 @@ static int __sgx_vepc_fault(struct sgx_vepc *vepc,
 	if (epc_page)
 		return 0;
 
-	epc_page = sgx_alloc_epc_page(vepc, false);
+	epc_page = sgx_alloc_epc_page(vepc);
 	if (IS_ERR(epc_page))
 		return PTR_ERR(epc_page);
 
-- 
2.25.1


