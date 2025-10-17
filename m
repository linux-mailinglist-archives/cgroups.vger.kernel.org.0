Return-Path: <cgroups+bounces-10878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0DDBEB9DA
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55B1A4FE7C5
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D034FF4C;
	Fri, 17 Oct 2025 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKPp1/jx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B933893F
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732022; cv=none; b=JTIhp50SbH8lckGhgjad3Mb6iheHP/rYbZWFO3oSmw1zEP+USRqMKL4oCjwP7OHr1kO3PICHwnctQ+5vs2csZOULOlkYVsbZtuAx8pONXLSLXYKE3FYMx8oDtjlKGGCnZbuDB5FUq2KuV8AURuEfyMqBxcc7S9JwUoSkug+CSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732022; c=relaxed/simple;
	bh=VfxgTYzfPcNal3AIP/26nqYp1tsVb9JGusB/JnZZlbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/oNAqS3pgf5UJob8p4NqH75470TVlcFliSW9mxJ+a8GS636GwLcSHkaJwffiDg2Hr7/qHIKfTDWNbO7g0182L5wpqmtyZi8aS+Z+qPr8pcvR1U6K/1k9k1X6EQ6FuUEVTXayoONHoFHrdWHCMpJSl0Df0KsiFDTlb3y6ZO2ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKPp1/jx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso2981736a12.2
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732011; x=1761336811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjvPBfWPeDDoysxeGmNxm2XVFXiN0LW7diKaU3jXVt0=;
        b=WKPp1/jx/w6ezl0DMYKz+QZrTxDdERpLqp6Ab7/XaE73h4Qr4CJOf+wXnsM1HoECKD
         FJ0hyq5440pgW7WJrEuiRgjK7mEzX3LfkV2NGuW8109Ea8wVihtjHFkQFqRZcFVPlo2V
         lgdhHtax4NXNrA0ghHjeTd7zsgjvYJ8Jo/L7GM/ah6HHZTaBXbGv2VaYwdarGt6a/UEI
         Us5+Ff5gxr8PYgnwqMFXXPIrWHj2FQmGsf8+jFie59lYTiYot7sYv2AWCO0ZpqP8Uu5B
         hunvVBNqATAmgRpZ1VB8xebcOZcxPdPZlhs8Lkr40Atl/X5wDobknQVmNdHmS/rXnIm9
         nzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732011; x=1761336811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjvPBfWPeDDoysxeGmNxm2XVFXiN0LW7diKaU3jXVt0=;
        b=VG92FBsg+8nYbWY1RPK9g8RdF8wagAZzM2yHyNjLdpq+pgjN78vZw8cQ61HEorkdET
         1Slo1tZ/IFCel+17YOpmKBB3y45PRxWiyrk2eiIOA4S9V09C3r5aEBAMJxyd793kSTS2
         Bnpi+I2lu4gLhbgcgEjYGjFYA8WWBNORQGMLGDHhF4YJiZHVdbD5G8khmTKuOyBrbKAO
         x8Fq/o3csQq5JZhz5TcDaZBRcelrP7XyHIGfNvcUmtluJktbmlWqoc/7ER0j6ZEITeSc
         4WoKUDjEhUlqQa5FoRAgHLw3lYUsTjluBccURWopeiAgPS6ur8oaOh+axRCI9anQbjG8
         kb5A==
X-Gm-Message-State: AOJu0YzxH/rds+GdJRMbubOImHD13ud7lbUwk7VCCli/MLYRmpPlyDeB
	KZGfJUL8Fq/81gkRqliqHO81iCgYoou0YiP43OgC7GARS/9bE4c2/ySwxrSrFWq/RZZkCObCe1T
	Grq0bLqf9sgqjj2U+M9aO91D2qBLmGQwV/QTHOrOB6oWfxfM82vboZcZAPfT3Qaizcj0LHnla3w
	vQvMny3bzaTP7VcRCb3qywFK53Wv1aVVxXc+BzIZtI7Tit7vDpR36em3F/2HpRhUCy
X-Google-Smtp-Source: AGHT+IHIFgvKx4iQssAvfWvw05fzS3tjPMxtqzDzpUfFs2q0tZQVlLhulOrO+VXHlGdzU4khsfJPAu1rlwqetjJf8A==
X-Received: from pjbpj3.prod.google.com ([2002:a17:90b:4f43:b0:332:4129:51b2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9997:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-334a84c81famr6743421637.13.1760732010737;
 Fri, 17 Oct 2025 13:13:30 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:18 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <f326fd44695d94438b6061c0c5881c6a17ad84d3.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 37/37] KVM: selftests: Update private memory exits test
 work with per-gmem attributes
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

Skip setting memory to private in the private memory exits test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Expect an emulated MMIO instead of a memory fault exit when attributes are
per-gmem, as deleting the memslot effectively drops the private status,
i.e. the GPA becomes shared and thus supports emulated MMIO.

Skip the "memslot not private" test entirely, as private vs. shared state
for x86 software-protected VMs comes from the memory attributes themselves,
and so when doing in-place conversions there can never be a disconnect
between the expected and actual states.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/private_mem_kvm_exits_test.c      | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index 13e72fcec8dd2..10be67441d457 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	/* Request to access page privately. */
+	if (!kvm_has_gmem_attributes)
+		vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
 	pthread_create(&vm_thread, NULL,
 		       (void *(*)(void *))run_vcpu_get_exit_reason,
@@ -74,10 +75,26 @@ static void test_private_access_memslot_deleted(void)
 	pthread_join(vm_thread, &thread_return);
 	exit_reason = (uint32_t)(uint64_t)thread_return;
 
-	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	/*
+	 * If attributes are tracked per-gmem, deleting the memslot that points
+	 * at the gmem instance effectively makes the memory shared, and so the
+	 * read should trigger emulated MMIO.
+	 *
+	 * If attributes are tracked per-VM, deleting the memslot shouldn't
+	 * affect the private attribute, and so KVM should generate a memory
+	 * fault exit (emulated MMIO on private GPAs is disallowed).
+	 */
+	if (kvm_has_gmem_attributes) {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MMIO);
+		TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->mmio.len, sizeof(uint64_t));
+		TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
+	} else {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	}
 
 	kvm_vm_free(vm);
 }
@@ -88,6 +105,13 @@ static void test_private_access_memslot_not_private(void)
 	struct kvm_vcpu *vcpu;
 	uint32_t exit_reason;
 
+	/*
+	 * Accessing non-private memory as private with a software-protected VM
+	 * isn't possible when doing in-place conversions.
+	 */
+	if (kvm_has_gmem_attributes)
+		return;
+
 	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
 					   guest_repeatedly_read);
 
-- 
2.51.0.858.gf9c4a03a3a-goog


