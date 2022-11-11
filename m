Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F73626159
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiKKSgr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiKKSgM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C7B7F54C;
        Fri, 11 Nov 2022 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191770; x=1699727770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhkDQba3waDzI7XsFxcqpI9nmgBLwwaPF8PxtWxCjOU=;
  b=dS/PkOSYAChvUMugt26i9e3ZRkUUHAqiJFY9RqD5xFiOdEycTsJQmIrp
   hMtwNLoeoO6Xm04sHYqPektTvYmiRwXMppiUbcIm4jco64SBwVJ/Mpquc
   s2FLPdAl4utlcmjQ8z5r+tMFU9iC1xtv6E1+njI5SfdkvCJFH9+LKuEtl
   SIKpkpvDLKnPybbdgu29CZlK986xT7qIfTOzoO1jxYf62bOKeUwcFYNce
   Ot3OqaL+rRXkv6X66DvLl3jMzNx9eJAI1tuHIbEX8hZ7ifxWuQppsvTZT
   kXJBN854DbA9Z9Qjc+OsMtEu+JS1Rnd7UUpDklo2xEUVu7SYD3xujKuW2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050377"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050377"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089325"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089325"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:09 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 16/26] x86/sgx: Add EPC OOM path to forcefully reclaim EPC
Date:   Fri, 11 Nov 2022 10:35:21 -0800
Message-Id: <20221111183532.3676646-17-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221111183532.3676646-1-kristen@linux.intel.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
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

Introduce the OOM path for killing an enclave with the reclaimer
is no longer able to reclaim enough EPC pages. Find a victim enclave,
which will be an enclave with EPC pages remaining that are not
accessible to the reclaimer ("unreclaimable"). Once a victim is
identified, mark the enclave as OOM and zap the enclaves entire
page range. Release all the enclaves resources except for the
struct sgx_encl memory itself.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/encl.c |  74 +++++++++++++++---
 arch/x86/kernel/cpu/sgx/encl.h |   2 +
 arch/x86/kernel/cpu/sgx/main.c | 135 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |   1 +
 4 files changed, 201 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 653c9ee5bf57..c1d772a11462 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -622,7 +622,8 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
 	if (!encl)
 		return -EFAULT;
 
-	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags))
+	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags) ||
+	    test_bit(SGX_ENCL_OOM, &encl->flags))
 		return -EFAULT;
 
 	for (i = 0; i < len; i += cnt) {
@@ -668,16 +669,8 @@ const struct vm_operations_struct sgx_vm_ops = {
 	.access = sgx_vma_access,
 };
 
-/**
- * sgx_encl_release - Destroy an enclave instance
- * @ref:	address of a kref inside &sgx_encl
- *
- * Used together with kref_put(). Frees all the resources associated with the
- * enclave and the instance itself.
- */
-void sgx_encl_release(struct kref *ref)
+static void __sgx_encl_release(struct sgx_encl *encl)
 {
-	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
 	struct sgx_va_page *va_page;
 	struct sgx_encl_page *entry;
 	unsigned long index;
@@ -712,7 +705,7 @@ void sgx_encl_release(struct kref *ref)
 	while (!list_empty(&encl->va_pages)) {
 		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
 					   list);
-		list_del(&va_page->list);
+		list_del_init(&va_page->list);
 		sgx_drop_epc_page(va_page->epc_page);
 		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
@@ -728,10 +721,66 @@ void sgx_encl_release(struct kref *ref)
 	/* Detect EPC page leak's. */
 	WARN_ON_ONCE(encl->secs_child_cnt);
 	WARN_ON_ONCE(encl->secs.epc_page);
+}
+
+/**
+ * sgx_encl_release - Destroy an enclave instance
+ * @ref:	address of a kref inside &sgx_encl
+ *
+ * Used together with kref_put(). Frees all the resources associated with the
+ * enclave and the instance itself.
+ */
+void sgx_encl_release(struct kref *ref)
+{
+	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
+
+	/* if the enclave was OOM killed previously, it just needs to be freed */
+	if (!test_bit(SGX_ENCL_OOM, &encl->flags))
+		__sgx_encl_release(encl);
 
 	kfree(encl);
 }
 
+/**
+ * sgx_encl_destroy - prepare the enclave for release
+ * @encl:	address of the sgx_encl to drain
+ *
+ * Used during oom kill to empty the mm_list entries after they have
+ * been zapped. Release the remaining enclave resources without freeing
+ * struct sgx_encl.
+ */
+void sgx_encl_destroy(struct sgx_encl *encl)
+{
+	struct sgx_encl_mm *encl_mm;
+
+	for ( ; ; )  {
+		spin_lock(&encl->mm_lock);
+
+		if (list_empty(&encl->mm_list)) {
+			encl_mm = NULL;
+		} else {
+			encl_mm = list_first_entry(&encl->mm_list,
+						   struct sgx_encl_mm, list);
+			list_del_rcu(&encl_mm->list);
+		}
+
+		spin_unlock(&encl->mm_lock);
+
+		/* The enclave is no longer mapped by any mm. */
+		if (!encl_mm)
+			break;
+
+		synchronize_srcu(&encl->srcu);
+		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
+		kfree(encl_mm);
+
+		/* 'encl_mm' is gone, put encl_mm->encl reference: */
+		kref_put(&encl->refcount, sgx_encl_release);
+	}
+
+	__sgx_encl_release(encl);
+}
+
 /*
  * 'mm' is exiting and no longer needs mmu notifications.
  */
@@ -801,6 +850,9 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	struct sgx_encl_mm *encl_mm;
 	int ret;
 
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		return -ENOMEM;
+
 	/*
 	 * Even though a single enclave may be mapped into an mm more than once,
 	 * each 'mm' only appears once on encl->mm_list. This is guaranteed by
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 831d63f80f5a..f4935632e53a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -39,6 +39,7 @@ enum sgx_encl_flags {
 	SGX_ENCL_DEBUG		= BIT(1),
 	SGX_ENCL_CREATED	= BIT(2),
 	SGX_ENCL_INITIALIZED	= BIT(3),
+	SGX_ENCL_OOM		= BIT(4),
 };
 
 struct sgx_encl_mm {
@@ -125,5 +126,6 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
 struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
+void sgx_encl_destroy(struct sgx_encl *encl);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index f8f1451b0a11..5a511046ad38 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -670,6 +670,141 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	atomic_long_inc(&sgx_nr_free_pages);
 }
 
+static bool sgx_oom_get_ref(struct sgx_epc_page *epc_page)
+{
+	struct sgx_encl *encl;
+
+	if (epc_page->flags & SGX_EPC_PAGE_ENCLAVE)
+		encl = ((struct sgx_encl_page *)epc_page->encl_owner)->encl;
+	else if (epc_page->flags & SGX_EPC_PAGE_VERSION_ARRAY)
+		encl = epc_page->encl;
+	else
+		return false;
+
+	return kref_get_unless_zero(&encl->refcount);
+}
+
+static struct sgx_epc_page *sgx_oom_get_victim(struct sgx_epc_lru *lru)
+{
+	struct sgx_epc_page *epc_page, *tmp;
+
+	if (list_empty(&lru->unreclaimable))
+		return NULL;
+
+	list_for_each_entry_safe(epc_page, tmp, &lru->unreclaimable, list) {
+		list_del_init(&epc_page->list);
+
+		if (sgx_oom_get_ref(epc_page))
+			return epc_page;
+	}
+	return NULL;
+}
+
+static void sgx_epc_oom_zap(void *owner, struct mm_struct *mm, unsigned long start,
+			    unsigned long end, const struct vm_operations_struct *ops)
+{
+	struct vm_area_struct *vma, *tmp;
+	unsigned long vm_end;
+
+	vma = find_vma(mm, start);
+	if (!vma || vma->vm_ops != ops || vma->vm_private_data != owner ||
+	    vma->vm_start >= end)
+		return;
+
+	for (tmp = vma; tmp->vm_start < end; tmp = tmp->vm_next) {
+		do {
+			vm_end = tmp->vm_end;
+			tmp = tmp->vm_next;
+		} while (tmp && tmp->vm_ops == ops &&
+			 vma->vm_private_data == owner && tmp->vm_start < end);
+
+		zap_page_range(vma, vma->vm_start, vm_end - vma->vm_start);
+
+		if (!tmp)
+			break;
+	}
+}
+
+static void sgx_oom_encl(struct sgx_encl *encl)
+{
+	unsigned long mm_list_version;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	set_bit(SGX_ENCL_OOM, &encl->flags);
+
+	if (!test_bit(SGX_ENCL_CREATED, &encl->flags))
+		goto out;
+
+	do {
+		mm_list_version = encl->mm_list_version;
+
+		/* Pairs with smp_rmb() in sgx_encl_mm_add(). */
+		smp_rmb();
+
+		idx = srcu_read_lock(&encl->srcu);
+
+		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+			if (!mmget_not_zero(encl_mm->mm))
+				continue;
+
+			mmap_read_lock(encl_mm->mm);
+
+			sgx_epc_oom_zap(encl, encl_mm->mm, encl->base,
+					encl->base + encl->size, &sgx_vm_ops);
+
+			mmap_read_unlock(encl_mm->mm);
+
+			mmput_async(encl_mm->mm);
+		}
+
+		srcu_read_unlock(&encl->srcu, idx);
+	} while (WARN_ON_ONCE(encl->mm_list_version != mm_list_version));
+
+	mutex_lock(&encl->lock);
+	sgx_encl_destroy(encl);
+	mutex_unlock(&encl->lock);
+
+out:
+	/*
+	 * This puts the refcount we took when we identified this enclave as
+	 * an OOM victim.
+	 */
+	kref_put(&encl->refcount, sgx_encl_release);
+}
+
+static inline void sgx_oom_encl_page(struct sgx_encl_page *encl_page)
+{
+	return sgx_oom_encl(encl_page->encl);
+}
+
+/**
+ * sgx_epc_oom() - invoke EPC out-of-memory handling on target LRU
+ * @lru:	LRU that is low
+ *
+ * Return:	%true if a victim was found and kicked.
+ */
+bool sgx_epc_oom(struct sgx_epc_lru *lru)
+{
+	struct sgx_epc_page *victim;
+
+	spin_lock(&lru->lock);
+	victim = sgx_oom_get_victim(lru);
+	spin_unlock(&lru->lock);
+
+	if (!victim)
+		return false;
+
+	if (victim->flags & SGX_EPC_PAGE_ENCLAVE)
+		sgx_oom_encl_page(victim->encl_owner);
+	else if (victim->flags & SGX_EPC_PAGE_VERSION_ARRAY)
+		sgx_oom_encl(victim->encl);
+	else
+		WARN_ON_ONCE(1);
+
+	return true;
+}
+
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 					 unsigned long index,
 					 struct sgx_epc_section *section)
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 29c37f20792c..db09a8a0ea6e 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -184,6 +184,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age);
 void sgx_isolate_epc_pages(struct sgx_epc_lru *lru, int *nr_to_scan,
 			   struct list_head *dst);
+bool sgx_epc_oom(struct sgx_epc_lru *lru);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.37.3

