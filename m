Return-Path: <cgroups+bounces-13091-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AECD14AA8
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEB630A2E4C
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA63806AA;
	Mon, 12 Jan 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bmm5xuEu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmDIDF5D"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59836E48F
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241050; cv=none; b=NYXuqV9OtFdLODjGrJr9FaY/l7JFjOnXT5gKMYJBn/l+yBcddPZ4q7RCe5TygIBMrB0uAH9F0nwwGbnzjE/pSc2s232jGG9mT5kHnTRC4O4POboE3xISr09RBuu9BwOhy7YfoJjQLtM7onFGtc6f/MmiRC2zCX1tim/YW4tEsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241050; c=relaxed/simple;
	bh=Iavh03TY5rGjXb0qFvEJfW6qnYQtMHWYb1cCMI4+Vo4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kLuolK/68eGju2kkKGDADXcLhigIAr31IFU3tkmBzrXMgWmRgATFv0npgRhYN0AMIVa/mDb+kUhZsG30EGAg8bJrbj31P3mEaWkaI+PfAuDmdNTwuv865hcek+pwudklRc/VCfPAD2uCl0qS/edYnfXoj4t/Eb+tnzj5jDnW++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bmm5xuEu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmDIDF5D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768241048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGMJ5LbPFmGC8KsyFzZBiUpjaLMx+kfqn+JlgSdWn4Q=;
	b=Bmm5xuEuavZq6ulGSuTXum4O1WLyQa0mjLadZsGuZE5SE37M8cvFX2d+WYZWUed4fz97Xz
	MC9hYebQmY4iuFmKOn7EIhgnLD3G0eKlWdJrvybGh39VzPjPIVhwrk35b2rsOQioSwDVx8
	aTXTp024YCpjEZselQmG+FJL3RjmFAg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-rvYQ4DrRMqqzevFFAlb_yw-1; Mon, 12 Jan 2026 13:04:07 -0500
X-MC-Unique: rvYQ4DrRMqqzevFFAlb_yw-1
X-Mimecast-MFC-AGG-ID: rvYQ4DrRMqqzevFFAlb_yw_1768241046
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9411b2335f4so14709036241.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768241046; x=1768845846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGMJ5LbPFmGC8KsyFzZBiUpjaLMx+kfqn+JlgSdWn4Q=;
        b=CmDIDF5DNbKQxgXvobDBj84Ie8WCmq4f6LWvulKbYLhtBmn1Sb19aEwSuh1Er1ka7C
         SaT+h2aCiDlHj/3mtFs8LfTR3117Ms99v+ib1NtWZyZswM39v/bin4G7mouS/BF6hOe/
         1n+x4LIh1MSRSC5D0WHucMPKIWqvftdsXXtF57JKE7zFIm0hALSns3ZkwNTmmVThJ1sl
         uVN373R22CBMnQW2+PwowPc9mxqYVgkYscCp004RBbFtY3i/gqAeu64XHgGoAhAM42i+
         AYpBRv6Ek/Qyuu1fFbYJJAK26HIC5AcKjT1iS4N0a0JWr+vjhDrDhm3PyJiYKceO+6FL
         DnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241046; x=1768845846;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGMJ5LbPFmGC8KsyFzZBiUpjaLMx+kfqn+JlgSdWn4Q=;
        b=tdWfz2afu69IChzJrhO88QPq8/lJ+HYS/97x40RamsL0Dm49+MYckZQvfnQM1Q+S9W
         D4SeP8wibAXjXWk23E4ks6gtBy8D/lcMk3aIYedpU/Ro5esaqQO+3fzOWpDrRW3rgXXt
         85YIV7ErJ83s76Y9usP5RZLyAhDQ2V0q43CEj9bM70Z0QcFbnysnBzp5zZA7WikjRzw7
         humT36LHjRVWZxVat+nzt4oSkwGCFe1mWrVAD/cOGfkihMIX4kPiPJytFrl+5IqRjq0b
         WQPIPFVlL1plfU8nxU1woJGI2K60f+UUUOvx6+Wwx7LIIvzRl1W3dl72WB7di1Zjw8ef
         h9aw==
X-Forwarded-Encrypted: i=1; AJvYcCUZmFcqB36klUtxxVfqWBsin4ijm3rj1cofzqL7ZccYmC0/qGMHVwwEip/9qURkiomTCRNVsgTx@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXNuI1MKaK0Y4p1ORw49nRa2q+GA7GJ+Er0GJeT82mBlbJ3BW
	xGfBC9fpi9V8rCfOE1PAU5AU/bGRMNNHL+u/2nRoDhDBivXN7XH8fODSX8JPkxohtjjXfXgiglA
	g0jKYmBEJWEC15C1sWpP8ubi5N75MbnNfuzW0z9tdQwvinI7XKzPh7jn1eac=
X-Gm-Gg: AY/fxX4qg4Wee19ivt8LFVCfSBjPBBu2REcAZlDObXN9tYwgOSqQPv8rj0+jvsmVVyp
	RAuDSN6UGEqi2czFgLirfnt8b7WJNyxqmBUopjOvRNUtayposce41e7T0YmftjWUC50d+tfQnW/
	s0joga9tQQPiZIixCGgJyv6GHnUrSl26xUxoaM5EqRNeZZzlsAWN8Har/AOxrENjPJwRui5uOpT
	I+VRnxYTFb30oqKK7JRSuZ38NsOoep7WBvS4pGynFRiR3y1r6aNL4k7Ucv5zMPQeO8yJkK7ulbk
	F+gCK4+Qkvi6hRrBnG/Q0l5PPpPkR5puWJXs/+gWbKCvn8PosV+Ce37ig+rDHf3tcaBkXTB4Nos
	ewbW8sV2hKvrwJ8Crdj3fEvJZ3i162VPv5EksiOuXfuxT6lLpr6VkGvm+
X-Received: by 2002:a05:6122:4897:b0:563:7886:5e7a with SMTP id 71dfb90a1353d-563788663a0mr2842004e0c.9.1768241044898;
        Mon, 12 Jan 2026 10:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM6+Ba4s/MEV+9Zbgj4Jf91uX/qo/VCXWtL6yFKP9LvZ7kJD7E9gBdpreY2pV75Zsq8xOxKw==
X-Received: by 2002:a05:6122:4897:b0:563:7886:5e7a with SMTP id 71dfb90a1353d-563788663a0mr2841898e0c.9.1768241043068;
        Mon, 12 Jan 2026 10:04:03 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563667cf148sm10043559e0c.2.2026.01.12.10.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:04:02 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c1cac1a6-22fe-479f-bfc5-89a5d3aabda5@redhat.com>
Date: Mon, 12 Jan 2026 13:03:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-6-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260101221359.22298-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>   include/linux/sched/isolation.h | 4 ++++
>   kernel/sched/isolation.c        | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..c7cf6934489c 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,8 +7,12 @@
>   #include <linux/tick.h>
>   
>   enum hk_type {
> +	/* Inverse of boot-time isolcpus= argument */
> +	HK_TYPE_DOMAIN_BOOT,
>   	HK_TYPE_DOMAIN,
> +	/* Inverse of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> +	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
>   	HK_TYPE_KERNEL_NOISE,
>   	HK_TYPE_MAX,
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 3ad0d6df6a0a..11a623fa6320 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -11,6 +11,7 @@
>   #include "sched.h"
>   
>   enum hk_flags {
> +	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
>   	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>   	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
>   	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> @@ -239,7 +240,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>   
>   		if (!strncmp(str, "domain,", 7)) {
>   			str += 7;
> -			flags |= HK_FLAG_DOMAIN;
> +			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>   			continue;
>   		}
>   
> @@ -269,7 +270,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>   
>   	/* Default behaviour for isolcpus without flags */
>   	if (!flags)
> -		flags |= HK_FLAG_DOMAIN;
> +		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>   
>   	return housekeeping_setup(str, flags);
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


