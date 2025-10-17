Return-Path: <cgroups+bounces-10843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD61EBEB775
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F716E7C54
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9223370E5;
	Fri, 17 Oct 2025 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFYTTm7f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1C332907
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731954; cv=none; b=dyhi8vUa3Nf8hNjnUF1dzISCg63KjP9j3SEsG7Hdmi8hYq1qFPHXR9P4j75Bwgy61iSmOyu1ivteWGrCnwfKl0mvOR1+mUBoHZ9dD0zrEILTrcTPs+vV0SqDzBURplgfbL2NN65ihF8+rb3+309dOdTrma1kUIU5h5fzOhvjGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731954; c=relaxed/simple;
	bh=tH33FMwwajM7pnR5j/vOU4w7VfKG/h8B1dO52nFfMS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KU2KYmXkSyMMhpZVdjK9Ebai3QMUj3ch4jTtkDlSN4IKyK48B+Eogfv/gBfusjavUbJDVTAR+2woocN3JDUrFENDieiEgW6BYtIcRMQnTTqXdntq/oS6E2lb1TQCVJr6Mhts8U3yRoTu53An5KMaB1SFI7qbglnLjZd65x6Imog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFYTTm7f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so4081640a91.1
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731951; x=1761336751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=23h18nOdPjrep9qeiUX9eD9XykFWLhPvQkHoEMjMhTg=;
        b=CFYTTm7fmUtMbj9aoU0NW0JffzX+1siv31ArNBdfE41kQr6mR28I9VkdMtGgSTpK4K
         C9yy0eNoOBEEn9g5R+NFiDeY5rm6nmhre62gBUIIa8W7X1uzQz+M9DexjdW+D2OKtIuJ
         Ydi88AL0r2Zrzth/sDRhDCf5AM3suw4YQoV2EdP7fYVgrPLqAaKIoMFu6jBr71QdLoJ1
         4CjlXsfJCj31G8pOQWzNU1CqoXZEQFTZe5b8qIlYJIALEeQKxovnDZSLeeWWW4JTL2w1
         wGFQaR6HZoDeoFdQh5xl4EOzLdVJqszW6aqCTNgrFigl5mFgiPl3b7RDJo9Lxcecz3AC
         rd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731951; x=1761336751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23h18nOdPjrep9qeiUX9eD9XykFWLhPvQkHoEMjMhTg=;
        b=OKUT7Re8C1xJJjfxcDFYKLoDAT/NddIiDbYONqoGSJUmN4+FtIesnMp08jRIjGgOJB
         nOlKhhwoVe0pZPmO23MwBDHOAi+48E2ZixM1vEN/Dty0EualDm+f3KPBe8pMKAwcpnrq
         ESwSe7QtFLG/W5jsQjPPygabd7yvjjtdxc85eF2N9wXNqDdS6dFJuAsglQ8gY7XVjJKz
         0sMjHDSbb6ldSqycdzllWztPWDLy+v9cklWJg8RM5XQsHxFWzTEAubwVjUPIGWYq0BVD
         sJDv+MRPNc5qgIP/ESw7VZCauO0cOxbs9/VwsWc7vkxGfbYOwd+fKob6KfFcx8dkKvAL
         UJbg==
X-Gm-Message-State: AOJu0YwR5gFPhxlS9vjKszCMKfnyvJqwkY5MlDMmtVU1L09FllMIODEy
	abnvkXUvYWnw4ZBw+zsh1OyxHqbcbpo4gTZDgECnbSQTtNajV1A8aoxO7Rdz5EElAiuqkV30q8+
	cqJXALntpIv0QfKMOlFYjytqvGDmeM3A/iUdy6fOPyhbdwa0AIs9nivca6Vw1EMKUHSgvPzJRhF
	O21S4wyX5Sd1grDbjCQRhUtpfMJ4PxJPEVw797DO+gGOEUcKflUlaJWQoZY8A5ugZa
X-Google-Smtp-Source: AGHT+IGzIMHx5sxfwAd/ggf5vwDMz3obOs3omuhPz2fGRAWX79j+Sw8ihvoUsiE28s/7yqNKxtqfmUfdmtv/upqGpA==
X-Received: from pjto24.prod.google.com ([2002:a17:90a:c718:b0:33b:51fe:1a81])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35cc:b0:32e:43ae:e7e9 with SMTP id 98e67ed59e1d1-33bcf8ec899mr6732034a91.17.1760731950177;
 Fri, 17 Oct 2025 13:12:30 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:42 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Start plumbing in guest_memfd support for in-place private<=>shared
conversions by tracking attributes via a maple tree.  KVM currently tracks
private vs. shared attributes on a per-VM basis, which made sense when a
guest_memfd _only_ supported private memory, but tracking per-VM simply
can't work for in-place conversions as the shareability of a given page
needs to be per-gmem_inode, not per-VM.

Use the filemap invalidation lock to protect the maple tree, as taking the
lock for read when faulting in memory (for userspace or the guest) isn't
expected to result in meaningful contention, and using a separate lock
would add significant complexity (avoid deadlock is quite difficult).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 virt/kvm/guest_memfd.c | 119 +++++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b22caa8b530ab..26cec833766c3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
@@ -32,6 +33,7 @@ struct gmem_inode {
 	struct inode vfs_inode;

 	u64 flags;
+	struct maple_tree attributes;
 };

 static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
@@ -54,6 +56,23 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
 	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
 }

+static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
+{
+	void *entry = mtree_load(&GMEM_I(inode)->attributes, index);
+
+	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
+}
+
+static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
+{
+	return kvm_gmem_get_attributes(inode, index) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+}
+
+static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
+{
+	return !kvm_gmem_is_private_mem(inode, index);
+}
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -415,10 +434,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;

-	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
-		return VM_FAULT_SIGBUS;
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	if (kvm_gmem_is_shared_mem(inode, vmf->pgoff))
+		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+	else
+		folio = ERR_PTR(-EACCES);
+	filemap_invalidate_unlock_shared(inode->i_mapping);

-	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		if (PTR_ERR(folio) == -EAGAIN)
 			return VM_FAULT_RETRY;
@@ -572,6 +594,46 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }

+static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
+{
+	struct gmem_inode *gi = GMEM_I(inode);
+	MA_STATE(mas, &gi->attributes, 0, (size >> PAGE_SHIFT) - 1);
+	u64 attrs;
+	int r;
+
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_inaccessible(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	gi->flags = flags;
+
+	mt_set_external_lock(&gi->attributes,
+			     &inode->i_mapping->invalidate_lock);
+
+	/*
+	 * Store default attributes for the entire gmem instance. Ensuring every
+	 * index is represented in the maple tree at all times simplifies the
+	 * conversion and merging logic.
+	 */
+	attrs = gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	/*
+	 * Acquire the invalidation lock purely to make lockdep happy. There
+	 * should be no races at this time since the inode hasn't yet been fully
+	 * created.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+	r = mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	return r;
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	static const char *name = "[kvm-gmem]";
@@ -602,16 +664,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fops;
 	}

-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
-	GMEM_I(inode)->flags = flags;
+	err = kvm_gmem_init_inode(inode, size, flags);
+	if (err)
+		goto err_inode;

 	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
 	if (IS_ERR(file)) {
@@ -798,9 +853,13 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;

+	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
+
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		r = PTR_ERR(folio);
+		goto out;
+	}

 	if (!is_prepared)
 		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
@@ -812,6 +871,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	else
 		folio_put(folio);

+out:
+	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
@@ -925,13 +986,39 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)

 	mpol_shared_policy_init(&gi->policy, NULL);

+	/*
+	 * Memory attributes are protected the filemap invalidation lock, but
+	 * the lock structure isn't available at this time.  Immediately mark
+	 * maple tree as using external locking so that accessing the tree
+	 * before its fully initialized results in NULL pointer dereferences
+	 * and not more subtle bugs.
+	 */
+	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
+
 	gi->flags = 0;
 	return &gi->vfs_inode;
 }

 static void kvm_gmem_destroy_inode(struct inode *inode)
 {
-	mpol_free_shared_policy(&GMEM_I(inode)->policy);
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	mpol_free_shared_policy(&gi->policy);
+
+	/*
+	 * Note!  Checking for an empty tree is functionally necessary to avoid
+	 * explosions if the tree hasn't been initialized, i.e. if the inode is
+	 * being destroyed before guest_memfd can set the external lock.
+	 */
+	if (!mtree_empty(&gi->attributes)) {
+		/*
+		 * Acquire the invalidation lock purely to make lockdep happy,
+		 * the inode is unreachable at this point.
+		 */
+		filemap_invalidate_lock(inode->i_mapping);
+		__mt_destroy(&gi->attributes);
+		filemap_invalidate_unlock(inode->i_mapping);
+	}
 }

 static void kvm_gmem_free_inode(struct inode *inode)
--
2.51.0.858.gf9c4a03a3a-goog

