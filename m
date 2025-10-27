Return-Path: <cgroups+bounces-11189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28542C0DB29
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E2A3BFC05
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE549230D0F;
	Mon, 27 Oct 2025 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTS802Je"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE822F77B
	for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569341; cv=none; b=EraogQOxNknF/UdoWLcq9ytGvPc/C/uayjaxJxHIMZHeHuzuukc8PSXnaE4caFJxQmikKSfD2hYHF4VqoCmioeX0H6CCYdVOqkCGLv9edfqEU2RuBElo64PrtmqV4vKlaaiNCdxABL6jstKjXf2nX4+ar6b1Wxw267y/iKOiE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569341; c=relaxed/simple;
	bh=xIqDNcTwMPF2Nfh7H2HrsYu57Z68rRXirPja4i/3Ah0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u28H0nIMEDnG+PPSyvb4bnUUPffFyThB4hozSGKK1dtJ02LFTF6c1ut4Vv8UumoDj1cp/57CvyDSIpbKq4lnYsf77pTrTS1bi8r7BZRyAjAnfZzLCl76gSRT9owoG9XHSvq1giAjrThi5Qeyyg6wUz2CjD/2Q1QedJ7x66IYlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTS802Je; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso2929073a12.3
        for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761569338; x=1762174138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpsH9gx/luUFZveFm6voMll1yjdVEPjIbyyyxybZ4HQ=;
        b=YTS802JetUCMSbN8b0ql2ACutOsA+EQE7/jK1PeV7DwkUyOmKCiPVNA1QulO179JGF
         nY5Ab48vWwtZ2dz/7nMVpeVj+LzBc+BxEZJillea3xf/mLFJDMFuTIa5pAUMGdKM8cBh
         9A/HLo7dCsUus1TE7HhhVykk9/8hEm45rWsUIKNGvdPem2zLfQ8yks4JmrQ/Ek0vT2q6
         67Pid7oNNI7hUUI7eb9wyItNX6w13LL+otk4aWjEtjaM+an+cBKYAWes7Es+GMAE3+jS
         DgiPdNRbo+6BgBz2QZgmbpXqn0KaBmqOBClU0h7v/rUkBAumXx+MmlLItZRucPkWv12a
         Y7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569338; x=1762174138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpsH9gx/luUFZveFm6voMll1yjdVEPjIbyyyxybZ4HQ=;
        b=a9UOvha6pqAS0VcS3jrBYgBr5vhuYoLfKGwc/Fd9SuplQ4GSt0xmHv5Rz2+frnzPLt
         FjYgSKY9di93FjROVvrrtNwvz/I4vjV78ogLJySxfZSml+/WMpOzEVa6NfLdcRHt65Sv
         ACLdtLHpsHWXML4G5qsV1T8DBCyoQ+lIqs8hzomPuXMF5zwKu3f9oUaBQ4C2a7xVslvo
         3FX+75ikOeWgYrRoCHBgtvnZMMQlOvZsr92Ywbc3yQ40CCQzSjLIn73nQnDwUU7cDFiu
         U55yUXn13gHIKabbs16XDQJ+BQk8nc0AnLlYX1Dl7vJ5YtLcQtogUx6orMFUSCMp2cKA
         4vdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJp6qNmxlGkI21T5hTiYc1BIEkAbqceKBNGdJLg4K18uLkDyP+S108lK+q1mtAGGhYTAQbCtll@vger.kernel.org
X-Gm-Message-State: AOJu0Yzznb02u3B+cMWv+pGGTUngO9NFoQmobiCDkPOvgkEU6Nf+B2V+
	pEjGxtnQzjLvpIIoJbTvTv9ek56g5HL/ySxbqoR0fEi7J18/IuCrTyTWXzAgc2erHzNkbXcmGwC
	76HImeoHh4lI90vWt/vr6K1S+jQ==
X-Google-Smtp-Source: AGHT+IE8aJKICvS5xOA+BTAY6bjRh41q0VtmGZijtJh7qHPsEmdIFH7jOAvP+FEHmW/GVGRbcG4XOU1+vDg6R+rrXQ==
X-Received: from plbmg14.prod.google.com ([2002:a17:903:348e:b0:268:e12a:2266])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id d9443c01a7336-290c9cd4b48mr418021645ad.25.1761569338212;
 Mon, 27 Oct 2025 05:48:58 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:48:56 -0700
In-Reply-To: <aPu7IosMI61NjZY5@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com>
 <diqzv7k5emza.fsf@google.com> <aPpEPZ4YfrRHIkal@google.com>
 <diqzqzuse58c.fsf@google.com> <aPuXCV0Aof0zihW9@google.com>
 <diqzo6pwdzfy.fsf@google.com> <aPu7IosMI61NjZY5@google.com>
Message-ID: <diqzecqojyrr.fsf@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, 
	shakeel.butt@linux.dev, shuah@kernel.org, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Oct 24, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> > @@ -486,6 +488,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>> >         }
>> >         guest_rng = new_guest_random_state(guest_random_seed);
>> >         sync_global_to_guest(vm, guest_rng);
>> > +       sync_global_to_guest(vm, kvm_has_gmem_attributes);
>> 
>> I ported this [1] except for syncing this value to the guest, because I
>> think the guest shouldn't need to know this information,
>
> KVM selftests are about practically and testing, what information should or
> shouldn't be available to a test from e.g. a safety perspective is completely
> irrelevant.  In fact, one of the biggest advantages of selftests over KUT is
> that the guest side can know _exactly_ what's going on in the host.
>
> See the usage in 1850e3da4b03 ("KVM: selftests: Update private_mem_conversions_test
> to mmap() guest_memfd") from:
>
>   https://github.com/sean-jc/linux.git x86/gmem_inplace
>
>> the host should decide what to do. I think, if the guests really need to know
>> this, the test itself can do the syncing.
>
> Why force tests to do extra work, and potentially introduce subtle bugs due to
> state being stale?

Adding it back. Thanks!

This variable should be sync-able for TDX selftests as well since the
value should be synced before the TD image is loaded.

