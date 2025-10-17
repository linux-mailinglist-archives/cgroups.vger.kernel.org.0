Return-Path: <cgroups+bounces-10871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04997BEB953
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D90D4FC1C7
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A79A34B43F;
	Fri, 17 Oct 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpt6Z4qo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD633343B
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732007; cv=none; b=ejgNnrpezWC+qYfxHcm71K+hVI2HMe6+2sv8p4D6dCv91i2OcvDlzzlbVB3ovNhvr/TNZzpzdTR+C0cfK7v8i+ysc/2Aq48AkRJt2vnCw//Tgi6PTHHHe2kNi7pZfxOcPcYXDuFakIbSCIO27Jw7K0nyIqAtcN5qxRj0U89Xxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732007; c=relaxed/simple;
	bh=TrihwiuuxJ8YYrvlxOwVsirF8kMMYHFCCthbk+rVim0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/UvxqrFvMvuKtuHvC/5xDlWbjN5LyC9UQa8oXhGYtJip5DNTNOb3vYcyzQj6BQ9bCMqg1hbgPXawSeXJmTBeMw+I2/cJeDN5RKJ1lX/Z4KMPwMP2qYhQVByszwHLK1SjGoJ45tVhYhVfOOREXcKLpYSMwjt7ZBzk1LlgwNPWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpt6Z4qo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-334b0876195so2500179a91.1
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731998; x=1761336798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/lNHI4Q/bFe7E7u1u54KO9h5F/sVs5DEw3rAt9A97U=;
        b=zpt6Z4qobzPwmniKW2M1nf7i3iN5aQwRWiHOhOYY2lLisgMWGk7/3IE/tXK/IQ3wnZ
         R3sMTAefNk49wGX7AnkPi1CBl+IPcaWT64HY+qFrzdm2gRDSw739DJiSkx9cQA7w8OoD
         gOJGtM4DDxo8sehaDmPFHIHnbkMKICqcRRDX8RDke2WaV4N24tZ3kzt0Hqm+ag9usz+Y
         nZb9jJ7pVa6k+Et5KzB512PFNGEYgNGcwOhQFlTWwGk9kjl6RIy3+8eSYVTEcKoASV4U
         ck/0VHf58xF6Md9RVcEIkEtBhUnONV1TiD8K4gqrOXFHfZifFK+gPUr76GP1k1I8nHDu
         hgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731998; x=1761336798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/lNHI4Q/bFe7E7u1u54KO9h5F/sVs5DEw3rAt9A97U=;
        b=DhOY1Uwi7Px3p2CZhsRU/fZhiA1qlSJMb77yIEkxljXKenTdZ6AtvOnwTmeqw9EezF
         7nNBzikfQQeUCkNZVFMB2+Clnatw7kcH0R3uLnmEGBIWxRXuLy9drWigejDk0pWCHlme
         ikKF8CGl5gWRsdMI3QzZU0KeMRTbZEZNTt5MkabeNWM5vykP7lECqgSo9Jnqu/BhEhUq
         GfJa0uLzHpP7LKgkFZloCzUDGKVmunTtrL106VuX9WYkfKN8WTlv66qnK2o+Ni8wFbbh
         6Tze4E5qM+DXYioByOyGxhAnlEKdOyjZUOjCaqbsdhK4YhFCFkZhsWKyMpcVVEEpk/Mu
         2Ubw==
X-Gm-Message-State: AOJu0YzTdqWxQ5Xf3/RCWYMHTM5uJGTAyGxe+BpUlydBDCSgMZriMAbV
	bCpD3XMKGSTRxMeJewDZcJRbIKKHF++yIYCaPWd3qeOn+Dsq5N3hkpNwkghwXYcOBzy5diAT+xQ
	jsP1TUQI1eLkEyKVjU1/6bcyk8XHYp/MU7Q1ad8sMzn2iZ4Gty1HD72DHOKVA1cyoAmjFKUjzcx
	gCzA+tzhsnDvXU84o1/gviGROpGvIhctsdU8p2URtKC4X6y9VOSSzV8ct/Emiszuut
X-Google-Smtp-Source: AGHT+IEJOmwwfA3Kaekqa8uydRah72/LLd/POEax3xDQXkYFm9XmuPnw9MNGeowIWx2EtPAAJiD//RyC47hEWG+7ug==
X-Received: from pjbpa17.prod.google.com ([2002:a17:90b:2651:b0:33b:51fe:1a8c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:498f:b0:33b:da51:f05b with SMTP id 98e67ed59e1d1-33bda51f510mr5711640a91.26.1760731996748;
 Fri, 17 Oct 2025 13:13:16 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:10 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <5656d432df1217c08da0cc2694fd79948bfd686f.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 29/37] KVM: selftests: Add selftests global for guest
 memory attributes capability
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

Add a global variable, kvm_has_gmem_attributes, to make the result of
checking for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES available to all tests.

kvm_has_gmem_attributes is true if KVM tracks memory attributes at the VM
level, as opposed to per-guest_memfd tracking.

This global variable is meant to be used by the host only.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b4872ba8ed124..2871a42928471 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -113,6 +113,8 @@ struct guest_random_state {
 extern uint32_t guest_random_seed;
 extern struct guest_random_state guest_rng;
 
+extern bool kvm_has_gmem_attributes;
+
 struct guest_random_state new_guest_random_state(uint32_t seed);
 uint32_t guest_random_u32(struct guest_random_state *state);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 19c0445c0b296..c9c59f3ecd14f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -24,6 +24,8 @@ uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 static uint32_t last_guest_seed;
 
+bool kvm_has_gmem_attributes;
+
 static size_t vcpu_mmap_sz(void);
 
 int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
@@ -2321,6 +2323,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	guest_random_seed = last_guest_seed = random();
 	pr_info("Random seed: 0x%x\n", guest_random_seed);
 
+	kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
 	kvm_selftest_arch_init();
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


