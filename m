Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A834751402
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjGLXCw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjGLXCR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D18173C;
        Wed, 12 Jul 2023 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202935; x=1720738935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yu336iBUDP7BjU+WkSBkWx6y2b0+7f0dw5mWwSyUGZU=;
  b=fRB9Wp3XdyM5OIOr5bi86Tvju8oXarRpsAV5j+yKTbq14+WyLZnRTv70
   B6yC+Jfxr1WjPRNFTEqCXYVww+v9f08QzfenplUjPtXzpllN7sWvFq0+7
   oZ73llITrHzkm9nszSRcqWvwIW2TL4Pll6yP8xT6YDUjigESjaqsfRo50
   8Uix6MWVXRy33tx+i7hKRrwNIcb9a5DgfxZuPyat4lmirzDhaolVlYB7/
   mwGxl7HHyJaOG2aN4Bxxjc/f0zg7d3wG1raDcjDTa74btdLznTkK5ueDN
   xNr/I7GxuhR6Il+dqndtJ6fMvo40oQB9oawt9dKxfSEGDqJZFhnJh3B/6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774147"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774147"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338643"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338643"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:13 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: [PATCH v3 16/28] x86/sgx: Add EPC OOM path to forcefully reclaim EPC
Date:   Wed, 12 Jul 2023 16:01:50 -0700
Message-Id: <20230712230202.47929-17-haitao.huang@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Introduce the OOM path for killing an enclave with the reclaimer is no
longer able to reclaim enough EPC pages. Find a victim enclave, which
will be an enclave with EPC pages remaining that are not accessible to
the reclaimer ("unreclaimable"). Once a victim is identified, mark the
enclave as OOM and zap the enclaves entire page range, and drain all mm
references in encl->mm_list. Block allocating any EPC pages in #PF
handler, or reloading any pages in all paths, or creating any new mappings.

The OOM killing path may race with the reclaimers: in some cases, the
victim enclave is in the process of reclaiming the last EPC pages when
OOM happens, that is, all pages other than SECS and VA pages are in
RECLAIMING_IN_PROGRESS state. The reclaiming process requires access to
the enclave backing, VA pages as well as SECS. So the OOM killer does
not directly release those enclave resources, instead, it lets all
reclaiming in progress to finish, and relies (as currently done) on
kref_put on encl->refcount to trigger sgx_encl_release() to do the
final cleanup.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

V3:
- Rebased to use the new VMA_ITERATOR to zap VMAs.
- Fixed the racing cases by blocking new page allocation/mapping and
reloading when enclave is marked for OOM. And do not release any enclave
resources other than draining mm_list entries, and let pages in
RECLAIMING_IN_PROGRESS to be reaped by reclaimers.
- Due to above changes, also removed the no-longer needed encl->lock in
the OOM path which was causing deadlocks reported by the lock prover.
---
 arch/x86/kernel/cpu/sgx/driver.c |  27 +-----
 arch/x86/kernel/cpu/sgx/encl.c   |  48 ++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h   |   2 +
 arch/x86/kernel/cpu/sgx/ioctl.c  |   9 ++
 arch/x86/kernel/cpu/sgx/main.c   | 140 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h    |   1 +
 6 files changed, 200 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 262f5fb18d74..ff42d649c7b6 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -44,7 +44,6 @@ static int sgx_open(struct inode *inode, struct file *file)
 static int sgx_release(struct inode *inode, struct file *file)
 {
 	struct sgx_encl *encl = file->private_data;
-	struct sgx_encl_mm *encl_mm;
 
 	/*
 	 * Drain the remaining mm_list entries. At this point the list contains
@@ -52,31 +51,7 @@ static int sgx_release(struct inode *inode, struct file *file)
 	 * not exited yet. The processes, which have exited, are gone from the
 	 * list by sgx_mmu_notifier_release().
 	 */
-	for ( ; ; )  {
-		spin_lock(&encl->mm_lock);
-
-		if (list_empty(&encl->mm_list)) {
-			encl_mm = NULL;
-		} else {
-			encl_mm = list_first_entry(&encl->mm_list,
-						   struct sgx_encl_mm, list);
-			list_del_rcu(&encl_mm->list);
-		}
-
-		spin_unlock(&encl->mm_lock);
-
-		/* The enclave is no longer mapped by any mm. */
-		if (!encl_mm)
-			break;
-
-		synchronize_srcu(&encl->srcu);
-		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
-		kfree(encl_mm);
-
-		/* 'encl_mm' is gone, put encl_mm->encl reference: */
-		kref_put(&encl->refcount, sgx_encl_release);
-	}
-
+	sgx_encl_mm_drain(encl);
 	kref_put(&encl->refcount, sgx_encl_release);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index e7319209fc4a..c321c848baa9 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -430,6 +430,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	if (unlikely(!encl))
 		return VM_FAULT_SIGBUS;
 
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * The page_array keeps track of all enclave pages, whether they
 	 * are swapped out or not. If there is no entry for this page and
@@ -628,7 +631,8 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
 	if (!encl)
 		return -EFAULT;
 
-	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags))
+	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags) ||
+	    test_bit(SGX_ENCL_OOM, &encl->flags))
 		return -EFAULT;
 
 	for (i = 0; i < len; i += cnt) {
@@ -753,6 +757,45 @@ void sgx_encl_release(struct kref *ref)
 	kfree(encl);
 }
 
+/**
+ * sgx_encl_mm_drain - drain all mm_list entries
+ * @encl:	address of the sgx_encl to drain
+ *
+ * Used during oom kill to empty the mm_list entries after they have been
+ * zapped. Or used by sgx_release to drain the remaining mm_list entries when
+ * the enclave fd is closing. After this call, sgx_encl_release will be called
+ * with kref_put.
+ */
+void sgx_encl_mm_drain(struct sgx_encl *encl)
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
+}
+
 /*
  * 'mm' is exiting and no longer needs mmu notifications.
  */
@@ -822,6 +865,9 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	struct sgx_encl_mm *encl_mm;
 	int ret;
 
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		return -ENOMEM;
+
 	/*
 	 * Even though a single enclave may be mapped into an mm more than once,
 	 * each 'mm' only appears once on encl->mm_list. This is guaranteed by
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 831d63f80f5a..47792fb00cee 100644
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
+void sgx_encl_mm_drain(struct sgx_encl *encl);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 4f95096c9786..2c159168f346 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -420,6 +420,9 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	    test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
 		return -EINVAL;
 
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		return -ENOMEM;
+
 	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
 		return -EFAULT;
 
@@ -605,6 +608,9 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	    test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
 		return -EINVAL;
 
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		return -ENOMEM;
+
 	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
 		return -EFAULT;
 
@@ -681,6 +687,9 @@ static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
 	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
 		return -EINVAL;
 
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 883470062514..9ea487469e4c 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -662,6 +662,146 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	atomic_long_inc(&sgx_nr_free_pages);
 }
 
+static bool sgx_oom_get_ref(struct sgx_epc_page *epc_page)
+{
+	struct sgx_encl *encl;
+
+	if (epc_page->flags & SGX_EPC_OWNER_ENCL_PAGE)
+		encl = epc_page->encl_page->encl;
+	else if (epc_page->flags & SGX_EPC_OWNER_ENCL)
+		encl = epc_page->encl;
+	else
+		return false;
+
+	return kref_get_unless_zero(&encl->refcount);
+}
+
+static struct sgx_epc_page *sgx_oom_get_victim(struct sgx_epc_lru_lists *lru)
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
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	/**
+	 * Use end because start can be zero and not mapped into
+	 * enclave even if encl->base = 0.
+	 */
+	for_each_vma_range(vmi, vma, end) {
+		if (vma->vm_ops == ops && vma->vm_private_data == owner &&
+		    vma->vm_start < end) {
+			zap_vma_pages(vma);
+		}
+	}
+}
+
+static bool sgx_oom_encl(struct sgx_encl *encl)
+{
+	unsigned long mm_list_version;
+	struct sgx_encl_mm *encl_mm;
+	bool ret = false;
+	int idx;
+
+	if (!test_bit(SGX_ENCL_CREATED, &encl->flags))
+		goto out_put;
+
+	/* Done OOM on this enclave previously, do not redo it.
+	 * This may happen when the SECS page is still UNCLRAIMABLE because
+	 * another page is in RECLAIM_IN_PROGRESS. Still return true so OOM
+	 * killer can wait until the reclaimer done with the hold-up page and
+	 * SECS before it move on to find another victim.
+	 */
+	if (test_bit(SGX_ENCL_OOM, &encl->flags))
+		goto out;
+
+	set_bit(SGX_ENCL_OOM, &encl->flags);
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
+	sgx_encl_mm_drain(encl);
+out:
+	ret = true;
+
+out_put:
+	/*
+	 * This puts the refcount we took when we identified this enclave as
+	 * an OOM victim.
+	 */
+	kref_put(&encl->refcount, sgx_encl_release);
+	return ret;
+}
+
+static inline bool sgx_oom_encl_page(struct sgx_encl_page *encl_page)
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
+bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
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
+	if (victim->flags & SGX_EPC_OWNER_ENCL_PAGE)
+		return sgx_oom_encl_page(victim->encl_page);
+
+	if (victim->flags & SGX_EPC_OWNER_ENCL)
+		return sgx_oom_encl(victim->encl);
+
+	/*Will never happen unless we add more owner types in future */
+	WARN_ON_ONCE(1);
+	return false;
+}
+
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 					 unsigned long index,
 					 struct sgx_epc_section *section)
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 25db815f5add..c6b3c90db0fa 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -178,6 +178,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age);
 void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, size_t nr_to_scan,
 			   struct list_head *dst);
+bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1

