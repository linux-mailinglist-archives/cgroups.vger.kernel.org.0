Return-Path: <cgroups+bounces-10864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4875BEB8E1
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138AE1AE08A9
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9469346786;
	Fri, 17 Oct 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJLF0JRO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE884334C33
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731994; cv=none; b=Z1GSqB/NtUhGhTjDDY7ZBDbS4pXMzl1yzb3WtnKSAm+x0n9EXOIZvUJEUaWxMAm44brRmcqVjcnGuhZnFKAfdeUFirEzezn9Rgph/AQExBzbeXiKH2FpUCcy/nWieoAWEG9dqxfw8Rz8kKAzn5C8WVUpATQx0Q9wK+0HdEJXTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731994; c=relaxed/simple;
	bh=GAzkYSUv+N3H/xAb/xfS36q3dfdBV69oqQqnMSyz1sM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qy9u74ZwFuFAG7HRTTZgGyQ06LJ70LpRQqJqJ1sIDORwilN2+07Mc4GsuM6iw98FMDH9mzPY5rApwHbRJRouDyK2oXeWvFqKiT3tqWv2lbzs5ijhciQonybZqd17DFKuDpdVxvzQDe7RVi564C//Qc02H8VWQ6O9buwGSlVJhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJLF0JRO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-286a252bfbfso59094655ad.3
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731986; x=1761336786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDnbSa/T9rbLxdB+UQ48e1HAUASVlE84N9T/ACVvI5o=;
        b=hJLF0JRO1onb5pTS6Ue4G5uZZ/vAFXKB2sYLi28L6w6UdpIUtcPH5es28OIJZnn2ay
         V7mowwCRunCtZPoD9B/21ku2f9AtrMZvvcc50H1PBj2gA0hWHHdJeCcZuuWoysnPeVCm
         TRCiCiz4dPIpOXjjC6jJGFiSjeUArq/CuG6QOtWfBSRdNjtxBS12qDsdmtHaJLI6ll4k
         WmIaUA3xaqk/CBIADGucN00tzOAVR69StYsfa+FSLJ85wBp9+qrDPuPUEy5JgSaXh64U
         DvUJEGW7k02Q3A+TmQwmKgAN0Q3BK/IIo37cZKErB9cWXtWrkMsAImNpliGH52UKUvLa
         pRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731986; x=1761336786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDnbSa/T9rbLxdB+UQ48e1HAUASVlE84N9T/ACVvI5o=;
        b=xDmdkw64Jd8nN2/Zlf/RhVjzzix7pu8HzDMQunM7luK0416Inbha0zZ7M8utpcnNCD
         L1f5jfVW73zkzeQTyAPakqGoU529HEeHEpmbcl3VU41j7KvFgIpg0VM+WVyyJQMTELHn
         4vcRhBJJRIHlN7qi3rL8ikpWNyYbKWysTQrM93xEj31msFSt/E0h1oUF5Ng9VHVE8oRC
         mTi0iR25zGCX0gQPqPhPpk53COIptxG7Fn0yQAHz6J1bUQrNFUl0C/j2WJR4CN2/X8gj
         f1VZ3X+6qpZ6tC6S1ebO+Er9ntlJYWFd1hZp+GAGMULihlNAQmvcr73G6D/9Fhx/yRqQ
         SrTg==
X-Gm-Message-State: AOJu0Yxf70IzuQhCNUpS8CjZi0B92q0MQ7Nncj0qYXqbxQff4DrZMiPo
	Xb3yq7BS8wI4+F+u1czgnDTucm/f1hhkAIfkLl8nJTxg7NdO0OA6yWET4GI06eXQF60C9xO5d6W
	4vSnVolO9HsoxUXJYX06uAy6NBPLYqpDrhI6uhOxfUHs9Zn3++6VHyy5r7EehygladpZJFEObWL
	oOjYIXYjozzYgEArFNJvRl5R6mI0cvkxiNGwObwQpAQmH6VqI6X+x6QsZ/XQqtx2KI
X-Google-Smtp-Source: AGHT+IGK/mdDuG3ZSGIyaVntdExFllUnbaBOt/fbdQU/VGroSYt3OxnCk4b4pKyuwZyAug/4lKin+lC/nqf3X5a2jw==
X-Received: from plrt13.prod.google.com ([2002:a17:902:b20d:b0:267:fa7d:b637])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:15c7:b0:288:e2ec:edfd with SMTP id d9443c01a7336-290c9c93ce2mr47503675ad.10.1760731985255;
 Fri, 17 Oct 2025 13:13:05 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:03 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <ab6491c3eac047b8c0fd4cbfcb021e6327124203.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 22/37] KVM: selftests: guest_memfd: Test conversion
 before allocation
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

Add two test cases to the guest_memfd conversions selftest to cover
the scenario where a conversion is requested before any memory has been
allocated in the guest_memfd region.

The KVM_MEMORY_CONVERT_GUEST ioctl can be called on a memory region at any
time. If the guest has not yet faulted in any pages for that region, the
kernel must record the conversion request and apply the requested state
when the pages are eventually allocated.

The new tests cover both conversion directions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 54e7deec992d4..3b222009227c3 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -263,6 +263,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 	}
 }
 
+/*
+ * Test that even if there are no folios yet, conversion requests are recorded
+ * in guest_memfd.
+ */
+GMEM_CONVERSION_TEST_INIT_SHARED(before_allocation_shared)
+{
+	test_convert_to_private(t, 0, 0, 'A');
+}
+
+GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
+{
+	test_convert_to_shared(t, 0, 0, 'A', 'B');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


