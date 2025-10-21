Return-Path: <cgroups+bounces-10909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B3BF4945
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 06:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43A564E7A58
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A8246BAA;
	Tue, 21 Oct 2025 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFgCUByo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7469242D9B
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019826; cv=none; b=WjZNr4DPEnLDe71A4mna2Umrz6x478KY00YmwA9CfGDJ73CGCIzsTbNECFEIQEGBJfh+0oPjy887ZZTrGou+gsh1F+TmYJcUxtANuRHWUT4hYj5Qqx37txtyyRhjMcxxdyEy0BLQykOoTZIBRJxYQQTFFeJV2r6O//7HpHO/j/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019826; c=relaxed/simple;
	bh=m6Ygrj9CfSu9M6zL1BkSWa/FjgjlVS2hjqfbAo77jSE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ndYf/M//XFwu58a4str5CsiYeTQhKUdqysg9wKFwUguH0chH/UPGzulMAXOE8lR3G+7PRBbF/3XrutahkBcxFeJiGVRroQ6uVUzJHghxAQPJ6ml7DC7NcYCEtWQxnwHu8rQyoqqYkczyICgiqhaM7J3itnuSd6n1/aIsW/aFYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFgCUByo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9OupL1guxMQZzERaZQ5HIFJ+HTh+MX5SgUIo3LTaUY=;
	b=EFgCUByoM4QfmSq0a5kM72QLaW+qAi03T14bhkOSK4dFQbUyfcSeVLyLdeRhTkRe7L3Nx1
	T1Ch37UbLAp2JYx1a0JOUJ1hawISVoyLefHKSiwciYgWYKKCppkZqwHeEPouFcgGYB5w8P
	uBUQwBTq/+vYXhTkrK8upAhEEPP5SVw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-83hGBX7SNpipIEm4_I-hEw-1; Tue, 21 Oct 2025 00:10:22 -0400
X-MC-Unique: 83hGBX7SNpipIEm4_I-hEw-1
X-Mimecast-MFC-AGG-ID: 83hGBX7SNpipIEm4_I-hEw_1761019822
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78e5b6f1296so158804436d6.2
        for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 21:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019822; x=1761624622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9OupL1guxMQZzERaZQ5HIFJ+HTh+MX5SgUIo3LTaUY=;
        b=nZvitpYicbxRmaf3l0R6AhS+aB+6lOgbvuWyX6ci4OcJuW/Xj1WVYvU4MK1SNu/7kl
         aLRMRLWplopImFkSMJknsG6Ij9iWvUQPfZbYFj8FQvh3OQm7fD7QCxMlAuniV4p01Xdi
         9pLaQuUn1AR55mQDaQE9J/izQprAwfmtLD+FTz+DFn6n3z/2rwypges4MKERLYC67soo
         w5/PE+YBQWmSGn3vaTXYXFusfj09h+UoeVOHkB6P3jCEAcrf2lHDATJl4H9LANMgO6Hs
         0rlMNjqe8ezJkG5sdlGuuNTvV1VZnjnCiTUFPHOlK4B/lcS5sqyQKbJ9KpVvOahsXOwL
         qOwg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsMO+cCfO6BQPsYLsZ2rqouNSDw8VF69GQ/s9iDTzFpQteMK6V6zMki7fK6Jk9eth/sjx/aIS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2QsTiQhhfGbRMzLAuuEB5ULHs7YurMmSbq1dTe5F3XDP0ioQ
	UfLUmljyNO+QCqgJUvxQGXOzNtcaej5FrCiKU4EE5KPtvwn6YAxIO4l17AFGmfcdm61D8Xe8/xV
	XdnynmVnEvIAm0bBimM6DsFJrJYEqWN7QLz29Esn42oNEOHfwRpd2HXVdyrE=
X-Gm-Gg: ASbGncuVBCD29OineWXx0rBtIlgA5b12NeVUNX+xLozjlN15ndigGaoLHTMwhL8TvWD
	SuTMk262iouOTxF9Nqj3ws+rp0Mwxm/GFTEC2N+jUTw/sHFYj2qrZaOaDfWR/KVRyPmNRDseHbT
	hxsgGPhUe6tx1QeKTqrCg9+2iz1vzkkiTNQabXqhUih1L+5T6GnvYnbfXrDT43nezdOonsDjaZ0
	YHInRmdxla8YWZMgI79ouhBwVXUH+XULSyAKzCmyP7Uu77wXmUIv64tvmayK+mmYutM174yRG2d
	SSHnXvgTvrfk6jQAO6H6ov6JEezKEFxdV6e5RimcjCW0x3vp4outw9gJzimeBMGBN1aWI7xBuUN
	eOx/il35/zYv6A3jdRx+/CnP329ZQg7+g0agvg10iTPzgFw==
X-Received: by 2002:a05:6214:808f:b0:87c:223c:c5c8 with SMTP id 6a1803df08f44-87c223cc6b8mr152673846d6.20.1761019821866;
        Mon, 20 Oct 2025 21:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdm2hwRLRcjdAJaN67gocvEQv/ytDjJvvxgQlCm7/W761K2ldQ2/8L5ftdru4g+9p/5t/b/A==
X-Received: by 2002:a05:6214:808f:b0:87c:223c:c5c8 with SMTP id 6a1803df08f44-87c223cc6b8mr152673626d6.20.1761019821460;
        Mon, 20 Oct 2025 21:10:21 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028af525sm62600596d6.51.2025.10.20.21.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 21:10:20 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>
Date: Tue, 21 Oct 2025 00:10:16 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-14-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
> CPUs passed through isolcpus= boot option. Users interested in also
> knowing the runtime defined isolated CPUs through cpuset must use
> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>
> There are many drawbacks to that approach:
>
> 1) Most interested subsystems want to know about all isolated CPUs, not
>    just those defined on boot time.
>
> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>    concurrent cpuset changes.
>
> 3) Further cpuset modifications are not propagated to subsystems
>
> Solve 1) and 2) and centralize all isolated CPUs within the
> HK_TYPE_DOMAIN housekeeping cpumask.
>
> Subsystems can rely on RCU to synchronize against concurrent changes.
>
> The propagation mentioned in 3) will be handled in further patches.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h |  2 +
>   kernel/cgroup/cpuset.c          |  2 +
>   kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
>   kernel/sched/sched.h            |  1 +
>   4 files changed, 74 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index da22b038942a..94d5c835121b 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -32,6 +32,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>   extern bool housekeeping_enabled(enum hk_type type);
>   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
>   extern void __init housekeeping_init(void);
>   
>   #else
> @@ -59,6 +60,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   	return true;
>   }
>   
> +static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
>   static inline void housekeeping_init(void) { }
>   #endif /* CONFIG_CPU_ISOLATION */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aa1ac7bcf2ea..b04a4242f2fa 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1403,6 +1403,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
>   
>   	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>   	WARN_ON_ONCE(ret < 0);
> +	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> +	WARN_ON_ONCE(ret < 0);
>   }
>   
>   /**
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index b46c20b5437f..95d69c2102f6 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>   
>   bool housekeeping_enabled(enum hk_type type)
>   {
> -	return !!(housekeeping.flags & BIT(type));
> +	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> +static bool housekeeping_dereference_check(enum hk_type type)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
> +		/* Cpuset isn't even writable yet? */
> +		if (system_state <= SYSTEM_SCHEDULING)
> +			return true;
> +
> +		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> +			return true;
> +
> +		/* Cpuset lock held, partitions not writable */
> +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> +			return true;

I have some doubt about this condition as the cpuset_mutex may be held 
in the process of making changes to an isolated partition that will 
impact HK_TYPE_DOMAIN cpumask.

Cheers,
Longman


