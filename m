Return-Path: <cgroups+bounces-12726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FFFCDE22A
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEE0A30014EC
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD192BD035;
	Thu, 25 Dec 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3SB6ibX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBq+4AV6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651D74BE1
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701872; cv=none; b=rsKgLdModl7hIhW/t6lHGdF1ufJ8V9cg13LvQ5FMf+EyxOKqxGyOsDCeR8frMoWcELrcLutWEqxJlwZxaLhKZcg7JfFKIAYzyvin/6zwu2nax5gdv/ywBNuo/6e5DHU7cfKH/92OtiPOXbDnkS5uGznXFE6SOrdstoeNfhc209U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701872; c=relaxed/simple;
	bh=pWxufWESdVpjSVMoJonasFKWulN2V2omt68lqo3uzG8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=seeuf0lWCRnlY2uDAOoREcZzvWlaJ32zTpkntld0Mo2tReVtTJVIKzCsQMQ45buTqsz4QRswvnw9FLH567/uz0YkQbD3xHdzqkUVdtEYI5/sXPUH8nqsR8RRP9oZdx5l7YORScdPfwQKqzSJN39DZepRgFIhB/yk8Wj4ooQe3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3SB6ibX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBq+4AV6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766701869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab+MnheIVRKoBcmzrgSbvk3S4ufWNXWYr9CVeGGgh3o=;
	b=E3SB6ibXHefP/sYpOnOQ9NEEhL5aHbkO7ZEMJ4ULCi3lIHoMbCtHetgy8I1CwFsaWQXWbs
	Hs69ZWOLNGPY2/gIcOT6be3bm1qxCNiJQm7uarCrp1rtIVOJB+ENElLrF5+5q8LqkgYKMI
	A9HAM5G7ZR/rVQe/9+c0uMTQT3pkGE4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-r68gSK5CO7udNfWdPpKZ4Q-1; Thu, 25 Dec 2025 17:31:08 -0500
X-MC-Unique: r68gSK5CO7udNfWdPpKZ4Q-1
X-Mimecast-MFC-AGG-ID: r68gSK5CO7udNfWdPpKZ4Q_1766701868
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed7591799eso167929531cf.0
        for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766701868; x=1767306668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ab+MnheIVRKoBcmzrgSbvk3S4ufWNXWYr9CVeGGgh3o=;
        b=HBq+4AV66DNfZOvb0tfvWKOYgl0rajg9KIchs5xk+rSIeXZvzmx0sBkqkIN8dgqRP0
         nOj8o6GMap/8h7EEYWrvRp9vzn0a6EoNrpL9BV/rmsDhrVpVlRo9ZNRCdz2m5d4lobfM
         3Zv0XAzfJae01+2Y5jEpoSC+4IMsiBdmIFMzxnMiMjJQmahrj4H1Mq+yFvCl893bLvcW
         V3WWdMVzaHhRfhPSGns0krIJweh/wd/+RaXc3tTe580D5PiIa30hzWEdHtzTDqrsBKnx
         F2wk97RQWTCzaiQ2QGrCH+unYL3S7ngkgL00XgL8oK781OyI2JLcI7/J7KmYTsNFf1+Q
         izyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766701868; x=1767306668;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab+MnheIVRKoBcmzrgSbvk3S4ufWNXWYr9CVeGGgh3o=;
        b=REZNFoKGDjv1YK9BNzcSdDGh9NkkEiJeCLDbuIucocqqBNaLD46Jq2kOiVS99WonfM
         ls/CZDcGS6/AGTSpjfXgOIu41UMvz02e+O3j2kY4WE+nrpsFJH7z5o5QojpjM7s6DegL
         /MvEAVkOvY9H+EXQw9bhFFJatOXPkXhpn85a3r05JqCXrozRI6pcIFXXOhlCzD9sjDob
         nkf8a/7B/JDFNT7zfTanazblYYs+6ZRTWxhaVknb1sVEsdv28cjOw89zSpdlcU107XEG
         xucECDnk9jTUdpdEGQ+fe95ip8up2Pl64deqoc6giM/IqE0ZLcjjClqgdwx5eArQ8nm3
         nlqg==
X-Forwarded-Encrypted: i=1; AJvYcCUegEFJSwqsnxG+DH7qULFeBVRdZXTnf76GN7BIFJDFq3Pnd19Mi2x0MDAexNV033IehZQIYNZm@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmqdrAI96XS//AsR4SEAQRO3RbnRR3Tak9v+IWHV6mRIy4XoM
	Td8ZxrFWBrNU9orcAdQwieLMuW/aJEjmKyDlo57lB7lbbP8/MlvRDiQP5rheJ80duiuWaww9Sv4
	KmJXZ2UTYUDvf2ToUvFpVhIQ3gwbsQJ51sLg/nMcY2lDr8a1gb30jQumKoUI=
X-Gm-Gg: AY/fxX7vzYW4cQd8t4r5oLUwT8FnWW0p4w7OawKtgsLaT3NI2JVlaSH8QeEFL9fMoIl
	KZyDKfGCgoFFnexGZwNoZoWeY5j/sbbITrKdwxW6neeiSkIFdZdJSJCWD2yk20hUNSGa5PvduJK
	h+kEybyzmmJqdEzKFsZdk22tK4czDXskSE6CeVdoiAnYtQFLXqdlgUQ9qC+MBA5AwlPa6J9Y1SF
	r+OUdV5MQzcpgRaMfXecUVxRSEl898ASBFTi9pChyKMeTsP/xrIROwbn3aMuRIYC9qk2j7t+0zq
	Ia1GdU2zXAvLSrrHkHb+9MLhtidqttgNWds0O+SiLRhGj2LUyPQweM2gG3KXbcJzZ3KZ/IUS1mo
	ZK/um1tWRb1MyH5tMah5tMl9Qy0ixjYrq8rY2pQv7kvLg/8ifptxiMMS/
X-Received: by 2002:a05:622a:341:b0:4ee:24fc:be81 with SMTP id d75a77b69052e-4f4abd400d4mr330935811cf.36.1766701867889;
        Thu, 25 Dec 2025 14:31:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHthnytoNkit4+7wP+txqxK1npOqoQN/ulutuPL/gqwE7YXGTzVApXUK7yM3kp5hfoASbcRLg==
X-Received: by 2002:a05:622a:341:b0:4ee:24fc:be81 with SMTP id d75a77b69052e-4f4abd400d4mr330935421cf.36.1766701867385;
        Thu, 25 Dec 2025 14:31:07 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac65344bsm146923311cf.28.2025.12.25.14.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 14:31:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <006b00ab-c8b4-4a2d-aa38-94a41eadd238@redhat.com>
Date: Thu, 25 Dec 2025 17:31:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] cpuset: Convert boot_hk_cpus to use
 HK_TYPE_DOMAIN_BOOT
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
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-7-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-7-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> boot_hk_cpus is an ad-hoc copy of HK_TYPE_DOMAIN_BOOT. Remove it and use
> the official version.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e6eb09b8db6..3afa72f8d579 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -88,12 +88,6 @@ static cpumask_var_t	isolated_cpus;
>    */
>   static bool isolated_cpus_updating;
>   
> -/*
> - * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
> - */
> -static cpumask_var_t	boot_hk_cpus;
> -static bool		have_boot_isolcpus;
> -
>   /*
>    * A flag to force sched domain rebuild at the end of an operation.
>    * It can be set in
> @@ -1453,15 +1447,16 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>    * @new_cpus: cpu mask
>    * Return: true if there is conflict, false otherwise
>    *
> - * CPUs outside of boot_hk_cpus, if defined, can only be used in an
> + * CPUs outside of HK_TYPE_DOMAIN_BOOT, if defined, can only be used in an
>    * isolated partition.
>    */
>   static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   {
> -	if (!have_boot_isolcpus)
> +	if (!housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
>   		return false;
>   
> -	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
> +	if ((prstate != PRS_ISOLATED) &&
> +	    !cpumask_subset(new_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)))
>   		return true;
>   
>   	return false;
> @@ -3892,12 +3887,9 @@ int __init cpuset_init(void)
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>   
> -	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
> -	if (have_boot_isolcpus) {
> -		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
> -		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
> -		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
> -	}
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
> +		cpumask_andnot(isolated_cpus, cpu_possible_mask,
> +			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>   
>   	return 0;
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


