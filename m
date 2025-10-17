Return-Path: <cgroups+bounces-10846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C634BEB7A5
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD406E7E5A
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34933B942;
	Fri, 17 Oct 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTuLDn25"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81E337B81
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731960; cv=none; b=EMNhNkIZWogrfRoHOaaWkTAmOnc4SM/LoFvjk0ZimraWvhC/ux2UYK+8UnIWHhfMbGcbYaHgUOuQlz40hOJhTV58NJ6vPWm59Pn34fdCyx9JCNee+1iozY7PHVkAfENXWLXsoaW61/PRpwqiMfGhw5TII9GRJGcOpQpGDrSXIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731960; c=relaxed/simple;
	bh=q96g+L3bnTbr87g7/gpIu5+QcTCQTeNSaqmljYO1hLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AqCehs6uAv/o3JAz2bvr5DtAf0DbxJZa9XHS3Rb/oaLAwJY212/KTdfqWp0ilycPudif+JLvBMWPIm+z5YSSlDA5keZ+nt99Tk9RwdgWurtDTjSUQrwyJoVNRQGVPMaVtvYE9Bgvi5AyqipNkMeGWCNWjfUIkXtFkqBYkx3zNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTuLDn25; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb779733so1622263a91.3
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731956; x=1761336756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X801w8PuUrJmaegQKcScTVv31uPM2rOwC4B+emIFE+k=;
        b=jTuLDn25zmbHE/oa/RXaVOvYClqE8FRih48qhrHXEFeDe4FJm8NI7Vv3N0EL6zfkBe
         noQw6BrQWn7nSv+kKcN+vGC8oaCEm+j3O7izASmQF78l1sudasTdmhY4fVrKl/eGb22V
         nRQrOhuBOggArxU0SF1t7lEuY3e3Z4rMHecyyZIkkCCqTNzTjVlAegKCApE7A475GIZW
         8ML9rc5t8V+GHDxIFdOaBJ2S15UVRnCA7mIaFkMgoBNL2moZHAc9RcYRyMIevzTu8+To
         3//zCi0EWVFaa8V1jgvwoswwGvX65xFiIN670jfGdWO/F/3QjOul+MNBzX2je1DZb3xA
         Hprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731956; x=1761336756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X801w8PuUrJmaegQKcScTVv31uPM2rOwC4B+emIFE+k=;
        b=mjbgAye6g8ROKRxOSyNZ+t74we3g4Jj4xRzskrfy/jQeLtQTh499DEjYdTFGQKlKjr
         OV+/yvzuKlC7Er7sS75OKhnLMqbf3CB7zObcRWVEaIjqiZZwJknvhp1H/S73DfxlOJjg
         MzO1hmdRBmUlgTgZbrPkqiAOtxPPsV7Fnf/7khSv0B+NUaUmyvhnbFiBTfYSJ2ukxQcS
         AHcMLcWjR8mHJP/6WTThpPCU+pennKezTSLNkLcGyFY58qo4KjUczflVkkZuklwavIPS
         dzMpMomX4Km8ZWtlbjil3o6iBbfkK6HDC0+R1lRiUjteHLHO/2As9cLQFMsvZOGrhi7W
         uHag==
X-Gm-Message-State: AOJu0YxxQhKWa1dgv7lI2XTNTA5zip9pcos1UYAehG5T1A7l9nYv8USq
	CFq53gJGJP21PYhyawaycjheMg3dESETwJ3VaVU4IwrIZ3gOeJSb1YFdaBuQIHVPDSHU6Y73jIx
	8D3+PZJHNCwDlarHl1ABDAygR71+HMVfDIKJQRe8MjbVWjxqyB6sd0Lok43P4RtL2anrBdNIkiL
	LNaeZpUtn0MPwknfYZmWHjxe48K1dvLDE4KFfjsl9qzZak20fLUCrIhKjO0t6uLLk/
X-Google-Smtp-Source: AGHT+IGU4C5ckx0x3MXQbWEOI5N6qnZ05m/AWSE4UXdG4wN2ZO+xuAl9xRpx3d+vYpPUkqqKlpsZCTwULeIPVKxVzA==
X-Received: from pjbnk18.prod.google.com ([2002:a17:90b:1952:b0:33b:51fe:1a7c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8b:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-33bcf8e4a07mr5508977a91.23.1760731955330;
 Fri, 17 Oct 2025 13:12:35 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:45 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <2737fd9776aaa1ff7537244e128083ace0cf2cc8.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 04/37] KVM: Stub in ability to disable per-VM memory
 attribute tracking
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

Introduce the basic infrastructure to allow per-VM memory attribute
tracking to be disabled. This will be built-upon in a later patch, where a
module param can disable per-VM memory attribute tracking.

Split the Kconfig option into a base KVM_MEMORY_ATTRIBUTES and the
existing KVM_VM_MEMORY_ATTRIBUTES. The base option provides the core
plumbing, while the latter enables the full per-VM tracking via an xarray
and the associated ioctls.

kvm_get_memory_attributes() now performs a static call that either looks up
kvm->mem_attr_array with CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled, or
just returns 0 otherwise. The static call can be patched depending on
whether per-VM tracking is enabled by the CONFIG.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 include/linux/kvm_host.h        | 23 ++++++++++-------
 virt/kvm/Kconfig                |  6 ++++-
 virt/kvm/kvm_main.c             | 44 ++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index efb0b2e1808d5..197b28ae0e28c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2301,7 +2301,7 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 		       int tdp_max_root_level, int tdp_huge_page_level);
 
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 21bf30e8d3cc1..512febf47c265 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2514,19 +2514,15 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
 }
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
+DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
+
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return static_call(__kvm_get_memory_attributes)(kvm, gfn);
 }
 
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long mask, unsigned long attrs);
-bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
-					struct kvm_gfn_range *range);
-bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
-					 struct kvm_gfn_range *range);
-
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
@@ -2536,6 +2532,15 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
+#endif
+
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long mask, unsigned long attrs);
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range);
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range);
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 9dd7873114b59..395996977fe5a 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -108,10 +108,14 @@ config KVM_MMU_LOCKLESS_AGING
        depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
-config KVM_VM_MEMORY_ATTRIBUTES
+config KVM_MEMORY_ATTRIBUTES
        depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
+config KVM_VM_MEMORY_ATTRIBUTES
+       select KVM_MEMORY_ATTRIBUTES
+       bool
+
 config KVM_GUEST_MEMFD
        depends on KVM_GENERIC_MMU_NOTIFIER
        select XARRAY_MULTI
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 591795a3fa124..6c29770dfa7c8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -101,6 +101,17 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+static bool vm_memory_attributes = true;
+#else
+#define vm_memory_attributes false
+#endif
+DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_TRAMP(__kvm_get_memory_attributes));
+#endif
+
 /*
  * Ordering of locks:
  *
@@ -2425,7 +2436,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
 #ifdef kvm_arch_has_private_mem
@@ -2436,6 +2447,12 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 	return 0;
 }
 
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+}
+
 /*
  * Returns true if _all_ gfns in the range [@start, @end) have attributes
  * such that the bits in @mask match @attrs.
@@ -2632,7 +2649,24 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 
 	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
 }
+#else  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	BUILD_BUG_ON(1);
+}
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+static void kvm_init_memory_attributes(void)
+{
+	if (vm_memory_attributes)
+		static_call_update(__kvm_get_memory_attributes,
+				   kvm_get_vm_memory_attributes);
+	else
+		static_call_update(__kvm_get_memory_attributes,
+				   (void *)__static_call_return0);
+}
+#else  /* CONFIG_KVM_MEMORY_ATTRIBUTES */
+static void kvm_init_memory_attributes(void) { }
+#endif /* CONFIG_KVM_MEMORY_ATTRIBUTES */
 
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
@@ -4925,6 +4959,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		return 1;
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	case KVM_CAP_MEMORY_ATTRIBUTES:
+		if (!vm_memory_attributes)
+			return 0;
+
 		return kvm_supported_mem_attributes(kvm);
 #endif
 #ifdef CONFIG_KVM_GUEST_MEMFD
@@ -5331,6 +5368,10 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_SET_MEMORY_ATTRIBUTES: {
 		struct kvm_memory_attributes attrs;
 
+		r = -ENOTTY;
+		if (!vm_memory_attributes)
+			goto out;
+
 		r = -EFAULT;
 		if (copy_from_user(&attrs, argp, sizeof(attrs)))
 			goto out;
@@ -6513,6 +6554,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
+	kvm_init_memory_attributes();
 	kvm_init_debug();
 
 	r = kvm_vfio_ops_init();
-- 
2.51.0.858.gf9c4a03a3a-goog


