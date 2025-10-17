Return-Path: <cgroups+bounces-10845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0ABEB7A2
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE361AE20E2
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E135335082;
	Fri, 17 Oct 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McP2cB7F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AD337100
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731959; cv=none; b=bicrTzqC2AYuuWtc0r/uugg3l0NCFWCICJaH4+4Fes8uNuhwJseFreaA/Ctr7NG3Ywnm8O+ghohM8G7ikLIVZb8EREvMqjbLJwihiRxzJ0j/bCbT810MVqfnSLn5bv3pyRnbvgN5o8i5Ja3DylUcMFAzvh7ESfKJje7qWbUmc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731959; c=relaxed/simple;
	bh=Tt0+Pkd1zdjlSryJQZy+YeVqss0WVcZyPgwOd/oHmb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G/jJSH+aUQWTA6lSHuR4dLfcSvfEFwgjTWCkV9EllR679fl14WvOLID7bj5ZmfEtezufXTJZ13XK+PezRuAahioDFiB51Q8QinyO0Hpg58qA2rzFbqQu47zORQHi0dvMPp7rpFxM8WKND9mp3ktj+oSHm8lZEmvzwDQlkT16Jcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McP2cB7F; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32edda89a37so2138250a91.1
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731954; x=1761336754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEij1CupCDGyNPjfKEYxhnSr/WYW50lo3K/U1CWabEc=;
        b=McP2cB7FUaUH2DOzSlvE1xbVkMjVQyszi6PnlIc7UehMTITmX8XurYLFB2c3IrWrkQ
         M86K9D3kjUDRzEBgmTMZrt3Je9eYgYRu9FKAFmd1p6/IBoX+JsM1mpZXWMARILKOyAOl
         XO9odIQ9Ovs5v3nwfqgPo66sgxkT28SJwLV/+wSlbY64qtz8pEwTMwMtHnwBMBtnDu+w
         o5QQjxL3YJM5c60zIVp0JrepH+dHrRu9Apvhu9lJBdbCzBG0Oy81qloRSOIXO5Jl8lW1
         MvvgmjU2lX2OYk7KYFVbJsO8bMoV8gJwCpv/ziH7Nzomw6+oRcHlSu8sBhX75EhuBfT8
         ky8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731954; x=1761336754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEij1CupCDGyNPjfKEYxhnSr/WYW50lo3K/U1CWabEc=;
        b=tSpA3i5CztGtqPRF4q2kiqn3UTxQP1p6+t7HZQXut0nEadvUfNYByZH+BXrY3DPide
         tqYOpYOzivh0WIeCBIQJgnCyEAtd6jW+NTomYJu/CpMiqWqwrQnWe/lwKsebeT06DiNa
         ofv0wvzNyT0quQAMRhriJfcy9usV5nPVQAv9+oushnE8i7aY+83/1ajPfpjzna3vhi9V
         ZTSRIydXq9OL0Uwq5OPfaOQp/Zejwuzslk63kyVExqIE1HqAdNLaM2mMHzTMr5yKOZzF
         pa1jGnHy1C7b+XUGMExnz4dBMs1feons4jMPP8HEUlWmL8d0G1VGED//gk5Z6PL7NkOS
         /e+Q==
X-Gm-Message-State: AOJu0YxhuQ5I8GwiSbp1+C4dya4J6MlSXZ58hG3tg731mbHdKQUq/Nn2
	smpzjUA2NFrZ0XUMzAKzJlGTzkY58Uqs5XehGnF6WBYTu3CQYoRc7FniObgVXA6gQhhSXUoULdV
	sYMDBN5RaXgzXizzNNJHPZ78vQP/pNO2thDsHm9TwT//744r2cgeNkPM0uXdRxlVbTb8Ce/qvma
	Kb/fsyAKy8/nixi7U0YUfoheN40RtbG+qz0Ig9BvzF4RAqGlogJtR4web2QpSjSA5C
X-Google-Smtp-Source: AGHT+IGB3FEZBVXofYnV/2OlFnNwgrJDt0eUkK+vRXpIJeJOVHDG0MgXbSCylMyEgGvaFtRNgbmZV92cuc0fSiwxCA==
X-Received: from pjvp17.prod.google.com ([2002:a17:90a:df91:b0:329:7261:93b6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5623:b0:33b:d371:1131 with SMTP id 98e67ed59e1d1-33bd3711391mr5701672a91.34.1760731953647;
 Fri, 17 Oct 2025 13:12:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:44 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <405686bacd68ce6c76aa5e6ef40f0a5324983c5b.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 03/37] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
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

Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
on kvm_arch_has_private_mem being #defined in anticipation of decoupling
kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
guest_memfd support for memory attributes will be unconditional to avoid
yet more macros (all architectures that support guest_memfd are expect to
user per-gmem attributes at some point), at which point enumerating support
KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
supported _somewhere_ would result in KVM over-reporting support on arm64.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fddb373fcbaaf..21bf30e8d3cc1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -721,7 +721,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f73047ea4333e..591795a3fa124 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2428,8 +2428,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+#ifdef kvm_arch_has_private_mem
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
 
 	return 0;
 }
-- 
2.51.0.858.gf9c4a03a3a-goog


