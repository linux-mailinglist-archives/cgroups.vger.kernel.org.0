Return-Path: <cgroups+bounces-12514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270ACCCC40
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 323EA3009851
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7C369212;
	Thu, 18 Dec 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7CPOtlR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nlmA6hMR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C136829F
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075456; cv=none; b=YIQKAT0qimv2EPJbQ7moUS0B5nP3Dx7kIkz9GdZ1XKAhl4rvTY3bccjUEwMSLbBWGX20Sawftv0+fSvHiymZeuFBjpeKvfCXFHHAudZBQzzkMluAWiceRjH2kyJdWr6m7qlmRWe3yVjgk39iijv2voB7eUbXRqiLmQABGttCd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075456; c=relaxed/simple;
	bh=bsWEt0LXpmjn4jeK52XXZlBBrRjEbkQrxQneXstrT/o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=awDu+Cu482C6B+B1Ny+yudxNLNx+L+mTmYrV3ma2WctfVi0G+Hm+biwslOqtx6sLqN2v1khbe9SilAtZIonRxc0frtxdU5nuZFX7F6R4RbbnZiYeDUxJK31IwQaQhlde4iVueunbPXnMXrR1gZKoFf3q3I5nRGuDGAlEjrV31u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7CPOtlR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nlmA6hMR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766075453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfNKfopIbFRfgkV4tFKYI59dNU2zT1JUyIB1Hp/hoMs=;
	b=O7CPOtlRZxoasmJekFpr7vTyhX3fyQnGTsZtWGxK7LIDIoLAB9IYqRDLXovOWHcCvA/Mza
	2Vzxv6GoAtcLMLqiaDBWfvTxIT1Tt+isfpScq7oEEifPtuwZ/aJaclxK7H+luEVU1zA9Dc
	9AWkbXc7akYivoXHzzZSSRessglaMjA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187--Q5o31zgOUqHcgNGRrARSA-1; Thu, 18 Dec 2025 11:30:51 -0500
X-MC-Unique: -Q5o31zgOUqHcgNGRrARSA-1
X-Mimecast-MFC-AGG-ID: -Q5o31zgOUqHcgNGRrARSA_1766075451
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc88eca7eso1358833a91.2
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766075451; x=1766680251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfNKfopIbFRfgkV4tFKYI59dNU2zT1JUyIB1Hp/hoMs=;
        b=nlmA6hMRIIx0Q/Om3MU5zB8j2T+J9tuqzkuEZl/zr0kyuxXYwnc7yzDYLVAH3no7YD
         RlQFJyXJ0r3F9bhqzK6rbyUwC1FUE/8OiSMS3+DT+hZPtWkQjHnP/d5WukiFjXilFn2t
         gYiDLA0FP2R8B3EsmgqtozGCh1pJDAkJCeeAfDmja22bIRcRKSoRDe7gtoHAjUA+uV9v
         4qFw/zlbC59TNzgLKWpP4+xaam9T+biNO44nK7dwVRDPsdYX0FZl1DBhevn9e9TeuaEu
         6bnG96D+ymSAaoM94lU3sKjcyW3sVodg2u6SCD9rEKhoAxU4swoAKW+44yb4y9Q+wtgW
         b3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075451; x=1766680251;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfNKfopIbFRfgkV4tFKYI59dNU2zT1JUyIB1Hp/hoMs=;
        b=XYdpLcQG9M1BpPyD0qfhFinstByHE6l8Ae7r7vhvEUGavjCsU9FHK4QXttpRhRPAvT
         W08C0PB0kRUEyTNKGwTh8areppCWmbCV0piQ4Cl3H+kmZSEuQPPGvma0Xu0xRh5OKIID
         nr2UP+ZfRf2SjAOc0VCw4PjCxMBO3MzGZY5sP+MqXP9rt6+B5ymrGKtcoOYY3xlhToIw
         CzPnB3ZBgYrpwZXLuibMoeq+qPtWxjFB6aS3gkrSDhPsnmoWfSUErcfBJZVWK0OttLJp
         lhXLti78a6pEMBna99wWfXuL5iO9VlLp8x8X7RKWFloU2s2nRa5cZ0TExWcleWhrcC3e
         VzEQ==
X-Gm-Message-State: AOJu0YwHS8iztZy6R6EkzG3MqGr1PB53bxVccOVZg3h6wsnkaAZZKS3D
	BO6PYfW5saF9DV7QEhmycHIpr1xbc/9SfUj85ze3SMN2oMvlFTc9I03aPeV3VVQWfYBGxiJMCqr
	V89uXUGRsbxuX6ogctT+fY+qJwccVqSSsbKMLjKa81oIy0TpZZQyYr+n70gc=
X-Gm-Gg: AY/fxX4opniEDNOQOyZU02M/q67H8Srf6ah6vM8Dr2aRaULYZIGU5NrYgXNv0KiQYqv
	JpWIZYcOe5syZK5cHq4H4aFN9RFdOCblaAc8gg/oChIAiQzlUdaO/jGB/v3d7cHY5QSUMUnErJ2
	bObZpgnv32Pi2LKYpk2CwGrL9sEDLsBEn5wow2LksEgOPBnEWiACGCRmR9CQvQBjhKZ+b8TBFRF
	gsUA8WZ3GgbXeTKd652lEciRIBvj/fydagAyF24r1PlqgVQ4+FhC6Ltb06W/hRduoPILRnIac1e
	Td7N2PRWl8KsiNoNWhiBH5lDuHyFpXgBLXJqapx0qpAaYf9HGeA52hyyKKc6X1a7XjAg8PUHb+R
	omZ4hfFnVOHXpvoBTIkydRsKjQm96XsUjW4hMkg0+zBgK3uIa24OojfV9
X-Received: by 2002:a17:90b:498f:b0:34c:ab9b:76d6 with SMTP id 98e67ed59e1d1-34cab9b80bfmr10304272a91.25.1766075450827;
        Thu, 18 Dec 2025 08:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqd9R+6MDA55+urUTRA55x2WaEcXM3XWArRx5ZwuJaUBDvpV6fB9wCDNhQ4+UtX3IFusm9UA==
X-Received: by 2002:a17:90b:498f:b0:34c:ab9b:76d6 with SMTP id 98e67ed59e1d1-34cab9b80bfmr10304246a91.25.1766075450399;
        Thu, 18 Dec 2025 08:30:50 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7d3sm2966492a91.4.2025.12.18.08.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 08:30:49 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <51351ec6-f56f-42b1-91f2-f4493b1c70e8@redhat.com>
Date: Thu, 18 Dec 2025 11:30:45 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 0/6] cpuset: further separate v1 and v2
 implementations
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251218093141.2687291-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251218093141.2687291-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 4:31 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Most of the v1-specific code has already been moved to cpuset-v1.c, but
> some parts remain in cpuset.c, such as the handling of CS_SPREAD_PAGE,
> CS_SPREAD_SLAB, and CGRP_CPUSET_CLONE_CHILDREN. These can also be moved
> to cpuset-v1.c.
>
> Additionally, several cpuset members are specific to v1, including
> fmeter, relax_domain_level, and the uf_node node. These should only be
> visible when v1 support is enabled (CONFIG_CPUSETS_V1).
>
> This series relocates the remaining v1-specific code to cpuset-v1.c and
> guards v1-only members with CONFIG_CPUSETS_V1.
>
> The most significant change is the separation of generate_sched_domains()
> into v1 and v2 versions. For v1, the original function is preserved
> with v2-specific code removed, keeping it largely unchanged since v1 is
> deprecated and receives minimal future updates. For v2, all v1-specific
> code has been removed, resulting in a much simpler and more maintainable
> implementation.
>
> ---
>
> v2:
> patch1: remame assert_cpuset_lock_held to lockdep_assert_cpuset_lock_held.
> patch5: remove some unnecessary v1 code.
> patch6: add comment before the goto generate_doms label in the v2 version.
>
> Chen Ridong (6):
>    cpuset: add lockdep_assert_cpuset_lock_held helper
>    cpuset: add cpuset1_online_css helper for v1-specific operations
>    cpuset: add cpuset1_init helper for v1 initialization
>    cpuset: move update_domain_attr_tree to cpuset_v1.c
>    cpuset: separate generate_sched_domains for v1 and v2
>    cpuset: remove v1-specific code from generate_sched_domains
>
>   include/linux/cpuset.h          |   2 +
>   kernel/cgroup/cpuset-internal.h |  42 +++++-
>   kernel/cgroup/cpuset-v1.c       | 241 +++++++++++++++++++++++++++++-
>   kernel/cgroup/cpuset.c          | 253 +++++---------------------------
>   4 files changed, 312 insertions(+), 226 deletions(-)
>
For the whole series,

Reviewed-by: Waiman Long <longman@redhat.com>


