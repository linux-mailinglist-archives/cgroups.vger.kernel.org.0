Return-Path: <cgroups+bounces-10873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E69BEB96E
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B986B4FBEB8
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142E33892E;
	Fri, 17 Oct 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUytqRWx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1A345CC4
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732011; cv=none; b=tNNvTp8RgO3BRCpEjaUiGmsq03R9HYEPQwHd1Its09Li4fKonGmpyl8ZwWF0zr3HMIwPl0QSwzEt6LqD7HtllbvSXM02XV4cwTg9+EVysgHMO0H5rOOrwbpGDg94HRtnklEdjWfifjKtDUsPxMMgM8pOe6MK+BycWsCm55w/eVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732011; c=relaxed/simple;
	bh=30zQD4pjDiSn/+U/aldACY0mrFS2JuKzSnFZG7FjNQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MK79rt/0ceEwF0UmZRTKjj0F4MubVggCA4rtQPFpfoB6R53CYjqKn0r2bCxK8z+6w49XcIKObaNSViBIHmvOFjUp/sxCuJaiO0M0bJfvw1NioiMU5BMKC7CDCkOdnk6C836fDq+GZ7tTPITGiikgBfMyeaayWj1yJd3mD2CizSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUytqRWx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1882625a91.3
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732003; x=1761336803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=XUytqRWxtoTgwAU4dT3J+xyQRO7ro4/x0eBKq2VTvRWPNbVRc6hnH+vNAsj/X66z1H
         CT5ssaZ6uMILc2SGfH3486ZjnTggDcoPjliYmvwRw8SOsZGBPuJLGJ/L/4/ojA1vA0An
         y8SCVv0U/QFnpGwWcWUmBSzcFPKFOMI283iC4/ovUMBI/QqI7iT1ZLk4X3OLxvixx4oE
         4ksd72jNPT9IWCRVHijpIEwVU9WYEyMizQfG8RZ0Oh4rmC86JoiFL0L3JZ6pBExtqsRa
         u8AaLZLgMiGHpt/GfBe/1tDEjZQj3tIIFTHkjzXI0hk0gYFFGoOiun1LOaFGJYiN7CTe
         PRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732003; x=1761336803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=OCeGrT3gvn/CIhgzh9dlaEc5jY8xc6wSE8o4xnrj3/NCqCJSQWCcAZApoajv3H90NT
         55li7zpCE2T2QZOil5nsRTFraCyGBCtUIQFI0MMKMVP0jZl1mT7NkqS5l2ixfW38p6rO
         5joNaD5jcOYfqnP4mAJYRfOLRfNDGQ/Xw/iZLHV7qUATGFoySM3oknjj4Aj/mwq/xdEq
         9yPOaOpZhhwB2HxncD8jYpNKgdY/LWvi+u0dZ0MJKKAbpr9rWvWyS+/HcKZij4YtDsLd
         KnLcIw8Xkwokvd5ofWJaqSpV7dXAIgzFMX0ATy+KW6H1DagyAe95now+IkzWB+fJOc+4
         Yc+g==
X-Gm-Message-State: AOJu0YyZ10ZWbXFxRiIWRzWSaHrUV6WU+16x2OujSJFLbxEnhFp2wImR
	2+Y424ZaBKt4XusQGoJPY3OOLjh0h8MGoBcRThqFB5lRH4GzKYGVudsAsNKJRNxPmZ9oM4uC5tH
	ut20AO/E647DT+30sB6FKmeok4iIicxh6Vr9MGVyi8Lij6h9rdyqObeuV3JrTMO/Ovh4nBDNd44
	ynqx6jzsJZaoza2j/XS/SjPOWfY/GPcxzPVOajpuHBzmiatPG1oQGQpMCnEMMg5SVs
X-Google-Smtp-Source: AGHT+IHcO4NwxOJfZLNEBbx6WNz/S52BTLMchZETWWpFSftU3iw+fmFyD6t6Of9AgSIAzGHhdhWoKd+61TBtvxNmOQ==
X-Received: from pjbfs17.prod.google.com ([2002:a17:90a:f291:b0:32e:bcc3:ea8e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33bcf853679mr6444234a91.6.1760732001959;
 Fri, 17 Oct 2025 13:13:21 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:13 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <a3126618d7cb353faad7b231e70c2b732498f449.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 32/37] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
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

Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.

With an invalid fd (usually used for anonymous mappings), there are no
constraints on mmap() flags.

Add this check to make sure that when a guest_memfd is used as region->fd,
the flag provided to mmap() will include MAP_SHARED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rephrase assertion message.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cb73566fdf153..8603bd5c705ed 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1057,6 +1057,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
+	TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
+		    "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
+
 	mmap_offset = flags & KVM_MEM_GUEST_MEMFD ? gmem_offset : 0;
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					vm_mem_backing_src_alias(src_type)->flag,
-- 
2.51.0.858.gf9c4a03a3a-goog


