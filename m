Return-Path: <cgroups+bounces-10876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F5BEB9BC
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E0C741EE8
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891734CFA7;
	Fri, 17 Oct 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iq0ukZcy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D7336EE3
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732018; cv=none; b=hcI1o/kvQqRm5Uz4uEnQBNtZWZLpgTSM6ChHfO1uo8/X5rMn024prrfqB0WNNAhCO5v0F9GpCA1j3IQi43KUOG6/PF8dLitj6f26qZ45U1PW0OqINYUlmcPLCHfi5S8laCROvPkQ7guF/s6g7rVSmNQuSsMjwZUx14IS7XDqBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732018; c=relaxed/simple;
	bh=Xrypi1FL6NpzrXCvVBtI0R5qDUZK7LGg5k2qTqmrUOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lmAFjwm74oGhBp4p88S59BNjTL0rE0z75Z65FajTEkrIpkfeA10qDqbIfPiQkmia7bZFZCarl74JsfVSYESzkn6bZExFZzIsch/jHiz1TD+ZM4/Tk7oLIYlZP431iiwszewbGvsXV0IvH8ZC4GkOKB27AETvHWod8850jWK82HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iq0ukZcy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-332560b7171so3127553a91.0
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732001; x=1761336801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owIsAlZmoRN7Gb0bvmtQ9UfqOaXeNKXLEvRKI4EdMhY=;
        b=Iq0ukZcy9DKvuEs+GFUosCO6bt5kuDKxdGmrwGEz6WTQSB3QBEcV9C5for7f8oyWfC
         SZfBt6uhPqtVLePIpcStVZg8AYF0KkdrIKQlk33WpcZ7pwoD1M56/odnNqF2d88uCiTM
         N8+tX0kyWK+GU0D17Dd8/etptp0ubLDyI9kDJlr+/B+LiWC3HQ/7r1SLShpqkXHoHNmx
         oIV1mKNuFLAK8cobfs0JBcwRVhP0knBCRpkAkdWkhjtqT8zvRDIAgD0GlGR/9FsGZGDa
         zDB2YZ8ie9O487ALYje+5ktCQOXzevxznNob+ujDukN5Rx+jek8JZBHmrCVOX9qP3pp3
         zx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732001; x=1761336801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owIsAlZmoRN7Gb0bvmtQ9UfqOaXeNKXLEvRKI4EdMhY=;
        b=joRh195X0Ij4SEUEqnH5a4KdQCD1bxRhhQiVEamjTYpoGpVvaH4FezS3XFDNqf7S5t
         V9rLltHK4i5e9s0uKXDW0WPO4DrznwloFDW5t6sJi21RTRwFcAT8a4P2hVfwVoPvhB3r
         F1TkxiJ7qKHHSsvy3xuPb+daXdnwZuE8cJuN4QN4PV52Wm9t9ar7vcXB2wifIpgV7RdO
         04lgPI5p8bXToocZk+06unJb6iCEM/3nl8sVDNSCi6Sq98Ctstoo6T61i3QAWWu4ooqX
         vIN1uyaDNBAn7ga1PkyIZztHNXATbTMmSWqerwSFuKxxu7BFsDexOLC0WAFTw9Ug9gnp
         RRRA==
X-Gm-Message-State: AOJu0YzAccxB0BiulE0AGqQ80+5rhUKtkguSvFjovM4mLMk1hTCbmzeB
	OioZnB4PoKDiqlUK+e3vqKTjhmiT9RmlalJdFAPhFbuy6NqICAypkKeTJdae/n/TS/s07qUKCli
	q0CaY3CmlCZ+ZqyQcCqVBRyU1kczBQMnSGHjRrzs9CkXza3y+pwKi1h/N5Jq11RJNoRaYUNv6Xl
	dg5V1Ow0X1+DMKFIQjOTHJN4DdI4JrM+wZM5zZZrBx/bCBL/8mmAqBjStPeZXcxlfb
X-Google-Smtp-Source: AGHT+IExXQGpSFTWVGWgZhk6TSzKZM0/emFdEFIF3GaH8xwLFcQEGwkRkAqkYJMl+3AP4jC8HlOrtN4AmbdSUVQ1pw==
X-Received: from pjto24.prod.google.com ([2002:a17:90a:c718:b0:33b:51fe:1a81])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7d0:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-33bc9b8dd13mr6982314a91.5.1760731998604;
 Fri, 17 Oct 2025 13:13:18 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:11 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <9079cbdc091930f98948983b7e2f8b38b5a863be.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 30/37] KVM: selftests: Provide function to look up
 guest_memfd details from gpa
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

Introduce a new helper, kvm_gpa_to_guest_memfd(), to find the
guest_memfd-related details of a memory region that contains a given guest
physical address (GPA).

The function returns the file descriptor for the memfd, the offset into
the file that corresponds to the GPA, and the number of bytes remaining
in the region from that GPA.

kvm_gpa_to_guest_memfd() was factored out from vm_guest_mem_fallocate();
refactor vm_guest_mem_fallocate() to use the new helper.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 34 ++++++++++++-------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index dd26a41106fae..e9c2696770cf0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -404,6 +404,9 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, off_t *fd_offset,
+			   uint64_t *nr_bytes);
+
 #define TEST_REQUIRE_SET_MEMORY_ATTRIBUTES2()				\
 	__TEST_REQUIRE(kvm_has_cap(KVM_CAP_MEMORY_ATTRIBUTES2),		\
 		       "KVM selftests now require KVM_SET_MEMORY_ATTRIBUTES2")
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c9c59f3ecd14f..cb73566fdf153 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1244,27 +1244,19 @@ void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t size,
 			    bool punch_hole)
 {
 	const int mode = FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_FL_PUNCH_HOLE : 0);
-	struct userspace_mem_region *region;
 	uint64_t end = base + size;
 	uint64_t gpa, len;
 	off_t fd_offset;
-	int ret;
+	int fd, ret;
 
 	for (gpa = base; gpa < end; gpa += len) {
-		uint64_t offset;
+		fd = kvm_gpa_to_guest_memfd(vm, gpa, &fd_offset, &len);
+		len = min(end - gpa, len);
 
-		region = userspace_mem_region_find(vm, gpa, gpa);
-		TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
-			    "Private memory region not found for GPA 0x%lx", gpa);
-
-		offset = gpa - region->region.guest_phys_addr;
-		fd_offset = region->region.guest_memfd_offset + offset;
-		len = min_t(uint64_t, end - gpa, region->region.memory_size - offset);
-
-		ret = fallocate(region->region.guest_memfd, mode, fd_offset, len);
+		ret = fallocate(fd, mode, fd_offset, len);
 		TEST_ASSERT(!ret, "fallocate() failed to %s at %lx (len = %lu), fd = %d, mode = %x, offset = %lx",
 			    punch_hole ? "punch hole" : "allocate", gpa, len,
-			    region->region.guest_memfd, mode, fd_offset);
+			    fd, mode, fd_offset);
 	}
 }
 
@@ -1673,6 +1665,22 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
 	return (void *) ((uintptr_t) region->host_alias + offset);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, off_t *fd_offset,
+			   uint64_t *nr_bytes)
+{
+	struct userspace_mem_region *region;
+	vm_paddr_t gpa_offset;
+
+	region = userspace_mem_region_find(vm, gpa, gpa);
+	TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
+		    "guest_memfd memory region not found for GPA 0x%lx", gpa);
+
+	gpa_offset = gpa - region->region.guest_phys_addr;
+	*fd_offset = region->region.guest_memfd_offset + gpa_offset;
+	*nr_bytes = region->region.memory_size - gpa_offset;
+	return region->fd;
+}
+
 /* Create an interrupt controller chip for the specified VM. */
 void vm_create_irqchip(struct kvm_vm *vm)
 {
-- 
2.51.0.858.gf9c4a03a3a-goog


