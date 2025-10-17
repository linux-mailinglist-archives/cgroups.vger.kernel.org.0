Return-Path: <cgroups+bounces-10847-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CAFBEB7C0
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123831AE17E8
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0D33B976;
	Fri, 17 Oct 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8w+MwNE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FD33507D
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731962; cv=none; b=niA0F9A1RbDvSWJBb7wIt7rWb6NkZHy2mCLc73CmfPh2hDm75szyp0H1KkVbrUhB814uTsjbiCLimcmEbz0Xs0Ha+9fWrufbchtSliLuOZR8FuSEhkbpORO6fFNdzli2cr4KZcNxpDUm4Fcydgq2985ZPpDS5FsF4/pwkOC0sic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731962; c=relaxed/simple;
	bh=CHBr2oZCJKzML/Pzlp8jMZe2yxSf6WtNhaMqAdnPaXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fcy+QS4zCggkOqb++Hjkak9h+jCIgOBDTUEdfc1oaOILYxYHhCwX24S4ZqyOcbyXia8sEotJoFff04oTdapqVSUJ8LmcSw2EG2EecOIKseOWz3DSdHydvp48W8wBXaBjvLYi+l8oXHzW1ZxruUs9VJENy/eIbeLBgPTIQn3cyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8w+MwNE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so4081778a91.1
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731957; x=1761336757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XlCNqACOdtYs3iSi7DDE5wuxUUy0M1CfmngZZRUKmxM=;
        b=k8w+MwNEsvEkxMOX3YuQ14MdH3B07R0bieqN6V5TqwfqQ5cX4gemkaHZ7yqyflYPr2
         DJxFo5yJpzHQbl0uRpWs+3nhns3ROOq4zCMBVmgYA0/D7E++2PeuOWwdqb+D//uio86V
         w/OB3HtdmLb0ls4MXe6GQbBLhJTI7oB4FetIisTl/WBMvDqKacufOeZM+rjt98ubyYw0
         WQqPngTO5/4LVXPb4UclrPMAXU48J7nnmcYiSvLB38VPoiwsR8x1SAVNVcmvaaURc/eq
         UKDYakFsX7XEtJobnszAWKI2E3xOEZhTyldoUG/CxQHJXh5t7WSwMa4Lw/tj6d47eGmc
         XYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731957; x=1761336757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlCNqACOdtYs3iSi7DDE5wuxUUy0M1CfmngZZRUKmxM=;
        b=W8uzecLRqZsEwUcFyVF0n8UKi2nsfrQK7V93m4oNMCcw1KDEiVfsfVrcB7uFd+x+Hc
         04tkJB7M23GNCM1fW4PsPAOnmaY2NOq28mqv261b1cpM3GLDMkIytfGHraeYyi7eq+V9
         GAupR0rQqPp93qz5NdXuDDgTuMTBJ8Vjw+8Ekz2kab+wcKla05d1OaKQ8xzEoIEs5kh0
         T9AY5jcn8qpr1b6p8VKl1PFMnv/592DCD+fDYNgTZQxEkcrjaBx56brgKSlNZOBw3swX
         ho9QDRECaSbRbRjZ5IwBLvWEZdKJ4XdoYsx6q66H7vuDhmZMo/nuLJ+UIwspURiSxg/7
         fJCw==
X-Gm-Message-State: AOJu0YzLyiH+bP9IG4tRjQ5An3QXO8SO14j/WWdTGfq11ZgaF4vG5TJn
	HVcDXxc/RKct5+7qLBaUvKT31XD/wUL4ebrDqKXq8nmE6KvIiy85MKQxpxgaF3qR/oDUk9djRMp
	WRjBWPgprM3k5I5sK68hBjFDeSFU/fgYJagU04BMyroSOQP/F180tm8kOUa37oKyNtirVnLrQn7
	741h+9I7oeFBXMykYg7DoBfWz/Wqi/aK6fmFkNzWAy9l9WzlVvAcJ6wzzbY8AOKJ1w
X-Google-Smtp-Source: AGHT+IFfRugl5BuOK85KCSPRCTyguqsgSWCpXisujchuXiQdVcSPjeXkXDq3mUoTdLxoDsm9D4/TSAuMpmtTbZ9t0Q==
X-Received: from pjbrv22.prod.google.com ([2002:a17:90b:2c16:b0:329:6ac4:ea2e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e43:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-33bcec297c9mr5833670a91.0.1760731957035;
 Fri, 17 Oct 2025 13:12:37 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:46 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
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

Implement kvm_gmem_get_memory_attributes() for guest_memfd to allow the KVM
core and architecture code to query per-GFN memory attributes.

kvm_gmem_get_memory_attributes() finds the memory slot for a given GFN and
queries the guest_memfd file's to determine if the page is marked as
private.

If vm_memory_attributes is not enabled, there is no shared/private tracking
at the VM level. Install the guest_memfd implementation as long as
guest_memfd is enabled to give guest_memfd a chance to respond on
attributes.

guest_memfd should look up attributes regardless of whether this memslot is
gmem-only since attributes are now tracked by gmem regardless of whether
mmap() is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 29 +++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 512febf47c265..b8418cc5851f1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2543,6 +2543,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 26cec833766c3..f62facc3ab776 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -518,6 +518,35 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+
+	/*
+	 * If this gfn has no associated memslot, there's no chance of the gfn
+	 * being backed by private memory, since guest_memfd must be used for
+	 * private memory, and guest_memfd must be associated with some memslot.
+	 */
+	if (!slot)
+		return 0;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return false;
+
+	/*
+	 * Don't take the filemap invalidation lock, as temporarily acquiring
+	 * that lock wouldn't provide any meaningful protection.  The caller
+	 * _must_ protect consumption of private vs. shared by checking
+	 * mmu_invalidate_retry_gfn() under mmu_lock.
+	 */
+	guard(rcu)();
+
+	return kvm_gmem_get_attributes(file_inode(file),
+				       kvm_gmem_get_index(slot, gfn));
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_get_memory_attributes);
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6c29770dfa7c8..c73ebdb73070e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2660,6 +2660,9 @@ static void kvm_init_memory_attributes(void)
 	if (vm_memory_attributes)
 		static_call_update(__kvm_get_memory_attributes,
 				   kvm_get_vm_memory_attributes);
+	else if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		static_call_update(__kvm_get_memory_attributes,
+				   kvm_gmem_get_memory_attributes);
 	else
 		static_call_update(__kvm_get_memory_attributes,
 				   (void *)__static_call_return0);
-- 
2.51.0.858.gf9c4a03a3a-goog


