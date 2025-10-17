Return-Path: <cgroups+bounces-10862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284FABEB8BA
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826D41A65AA1
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F2345CA0;
	Fri, 17 Oct 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPhOQzm4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4934214E
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731990; cv=none; b=pVwTtDWXnMyEyEZHDcNs8C9olmtFKFkjhouOSoMx50xhvLWz9j1VvWLSwc/jrR8ZeUdJsLjEdZV5LykuGK7tgPbr/DjtrUSlIWcpTt53Z8gejUrwluQY9FL1ktwTsVzkv8hZ+G6yUt1567xtFTjgV8gWKJHk4lGRFG16oF8lWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731990; c=relaxed/simple;
	bh=IK+aPp0bAYiYdOuiPGlO4li+6cUHoZfj0NlSGTQDvR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q3xwm1dVtcTlgvX0Xmq7wxuk9fGPqe0tteHKf8G+A6bma4ZKToQZ/LIKN3rjJqDXqiAgqu+JR+Wni26fIQm2/pvzaYXaFNJyr89TumV8wiUpjpjedMVAZ5n3QW56RYeFeyJH/nCkKihoEO8eVdWAZ/ryNRLPueHOQgtZAEEZXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPhOQzm4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so2523663a91.3
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731982; x=1761336782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzloQp0TPf2fLdiTJlGZLQkrpHjgZ46Ds9buDtJoDXY=;
        b=IPhOQzm4027rSbiWiK1qE/kKbFpAJCSkrvlIErA3pf3vT8m6DEL1SiEN/pd2Gq1T8l
         bHdzcJ3Ffnc2/EZrcw/caMLZTvx6LMQs75fiABJ7ORna9RlsTMLBhLhfFgPtN7fnt6x6
         3YTC4CAJhRJJxuZf9ExqlHTCnmzgpymVS7KvRjiyS5i93606jhGBg8utJwjeJhalnyNi
         xs+lHJHJ7EAkW4EFg14sb9NdENa3kCX7tQEVYU8cFOuzZ5efWlZTdrPLpdBfR5KFBbtv
         G97wlssoqjbvVRZEbUgtPQAfybWX1KVKNr7z/m1TJS2vI+uFfhaDNIKUijQhH6Eu+tTv
         qL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731982; x=1761336782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzloQp0TPf2fLdiTJlGZLQkrpHjgZ46Ds9buDtJoDXY=;
        b=SX7WXoeuT4hhCa+HIATG7wZXHfWKDcICT3mnvqj13ZK1Xak2KIELm9UH2840A29yLq
         dBtO3DyrTncy3qHppADmAQPsVVK9yAUW2Dh95lAwANgseNEns2S/ZJ3RN6jEtipPfO+t
         0+wV7P4auFO1P1CstZhGml1jYMAxVdgT5njA34RB18Z0l5uI7O17xxluPpHiAD74oKMI
         HsctDwBKbYlXtyPaL2yhTyGcfyXNXPlcfqQvDYEkux6mXue3zrfYMYGAF3ik+JOUEhat
         RH3X/F6JdSkm6haJS0xzL9f7+DGkPW9CRPkBd3H7nJyOyMp8q5RWCKzMhK2ZAJe+sm3k
         rlxA==
X-Gm-Message-State: AOJu0YwRpQUjjuof+8UvmD1QHFemuYiYBsolaXmag0s4XPx20yrQIS3A
	FwvqYg93vxbVtkQv8imCQfDzM2kO9teLf0P7JMxKseRf0+B2u+gy7aZwpLP6Dz9WdEPaKEAuNWG
	2W59ZJHVSGg81ozkOd3nG3qblYxjJ1Q7aK86Wch+HF3eMFiZDxylmb0lGtXN/P1Rw4XrqIXORzv
	uqn/RkJblEnEKkWp+hsujK4Guon/nB/G0im/ZcYqZ46xRddTsE+xNpBL4DJw0pZa83
X-Google-Smtp-Source: AGHT+IEpN0MnN6PvJLRUm946buFQLbmtK0gdHmBaP5LEf3oHWoiaohC28e+OPVfB4xkdPalSl2AiLN8+JWhQOYKhmw==
X-Received: from pjot19.prod.google.com ([2002:a17:90a:9513:b0:323:25d2:22db])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ec8b:b0:330:3fb8:3885 with SMTP id 98e67ed59e1d1-33bcf8e6354mr5452028a91.18.1760731981888;
 Fri, 17 Oct 2025 13:13:01 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:01 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <c47ed2eddab3146889273373295c576bac296805.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 20/37] KVM: selftests: guest_memfd: Test conversion
 flow when INIT_SHARED
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

Add a test case to verify that conversions between private and shared
memory work correctly when the memory is initially created as shared.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index e0370e92e1b24..d57e66ee11310 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -95,6 +95,12 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
 #define GMEM_CONVERSION_TEST_INIT_PRIVATE(test)					\
 	__GMEM_CONVERSION_TEST_INIT_PRIVATE(test, 1)
 
+#define __GMEM_CONVERSION_TEST_INIT_SHARED(test, __nr_pages)			\
+	GMEM_CONVERSION_TEST(test, __nr_pages, GUEST_MEMFD_FLAG_INIT_SHARED)
+
+#define GMEM_CONVERSION_TEST_INIT_SHARED(test)					\
+	__GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
+
 struct guest_check_data {
 	void *mem;
 	char expected_val;
@@ -194,6 +200,12 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(init_private)
 	test_convert_to_private(t, 0, 'C', 'E');
 }
 
+GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
+{
+	test_shared(t, 0, 0, 'A', 'B');
+	test_convert_to_private(t, 0, 'B', 'C');
+	test_convert_to_shared(t, 0, 'C', 'D', 'E');
+}
 
 int main(int argc, char *argv[])
 {
-- 
2.51.0.858.gf9c4a03a3a-goog


