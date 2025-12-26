Return-Path: <cgroups+bounces-12739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A5CDE3BC
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906DE300C6C6
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 02:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5373B2EA147;
	Fri, 26 Dec 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOwfFZ71";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+T4u0/Q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B92E8B80
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715902; cv=none; b=Rs5WAgfn4TQ6fclmJ6DWQUF3mOfMkJYHE7X0YgkPbDTzc6WhY7jHwTyL1ZAOe2ysImR+OcK1JsYDojKcNZ56d5bWV2xmqckFwmWroNVMP4T3prJCsAFsnQMyPPHMAEEl2t9a+STT5r4WONIQwtfR5TyMs+GDMWGZPCvn6/TIqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715902; c=relaxed/simple;
	bh=vBsV97FFWt6taOOfI5IvjUETKhYJ9bzwqpworgVKu8o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DD9WMvCMjIqJz+7MTdgag3chUkE14pOyAvLv3xjwXduV1US0onc9sILQGnFUpmjlMzYLz/oe/DQoVuEHgSohyxp0tU3lCanUgKU2m7o4/VpKLRAU+g/WIPCwg3gjIZOBJtrVCUrL8MJaAUWagzAsdX4ziAs+kfQbAN82q+z0HL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOwfFZ71; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+T4u0/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766715899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qsz5WPFD/uExCJQBnyZrl3TgkdgAhutxKnz59++5sE=;
	b=hOwfFZ710VPjketZu6BcT4FTzJihP8HWqg/bEK12ffUbnuOtlDn7F61S+drIcBvfayJQiO
	uPy0yhHcM91k1GV2F+M763QrXGRwYmf+LWEV70nvqdRGZ8sqHgZDdM9/DyyMUzRO0B+5+j
	Ulw5E/AE8OgX604RaBBQKKgGs5fV6ec=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-8gvGbm2dPKSFi2jixd6fKA-1; Thu, 25 Dec 2025 21:24:58 -0500
X-MC-Unique: 8gvGbm2dPKSFi2jixd6fKA-1
X-Mimecast-MFC-AGG-ID: 8gvGbm2dPKSFi2jixd6fKA_1766715897
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so7128707a12.2
        for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 18:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766715897; x=1767320697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Qsz5WPFD/uExCJQBnyZrl3TgkdgAhutxKnz59++5sE=;
        b=D+T4u0/QjBdxWPDhpxoAygtibZkXthUyHqYlfsOr8ZRLzEMMs9MCv+FeMoHM+koWXG
         ojVEXXGiuWq5LFvgXXlpTu2xdnXBmqaSfXbhvgeqkn+q3BFbIMQKpU9WxeJ3aDilfjc2
         8dix5/fTrgpX87HKuTOrhvexEXbAx9xSQ8kI/x3aLjOjm/zjcMeMJcazOmQ7/5qVQLqY
         09mU0TQkTLVKEEytMSkvhYQueHM2iK7jGI/OK0basFrDm7fWwFQ+nq+pDf1nP+yoLZOG
         OJlz9mYNkBIGrBqdVPHMTNeE6IPLm30zv6LV7Pp3N1W68waxdELK/fuKVbm5LrQoNlPv
         BqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766715897; x=1767320697;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qsz5WPFD/uExCJQBnyZrl3TgkdgAhutxKnz59++5sE=;
        b=j/Mt6Z9X6Yn4RYucfHcrP9uGI29uia5M6UVBNMO1fpUX9B4YXVNwOPIumaktzU9t2o
         MKrDIgmegPq8Anxvxran9573YwsqcYnw7X6kYojXa4FRYatkp8o06k5Slk3wbzeyg8ob
         wOyCyaOOy2rifd6A4ICHyvCP9GohcsGR15IIgOrIonUjWB8EfMB9yqfZClKt6GuhLJUr
         xd7MgRia13s2aMlxx7CpEQSKFg8kKXpjW/cgXtQOvyC7Www2VRKavMP5x+A7OP9mGIc+
         K0JG0gsYVg4QVW7YSO0dYMkiT6f53NhnOC0bwaQSYUUg2EUs1u0RWdqepahVvcApiunb
         YVyg==
X-Forwarded-Encrypted: i=1; AJvYcCVqorK1LTc7wNM99IgCB8DuAS6NdDnQ88CuQ4lCp32vl+0VsIyRRVWNbLNuAnQG+7MfdySAhdEr@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCsgKx1oyJ7dfEx4aIkrM/finxk/ucboW8giYCwckgRJvFRyZ
	P6/u1sMnIggQNGtAFhv8r/e5+9OGVXI0a/ejLaleUqNL7kuVMjiPqhxMykG7qaau+JQUkwBWNN7
	QfuUpWBGkNW+j0xM3Q0CycIuFJgUOMO/47nKDwuHp3Ac9abHMiOaCY5oqty4=
X-Gm-Gg: AY/fxX6zDcR/d7OVRIencNrv27DwFy5bBv9W/6Bnu+gmjenafcOkfm0aJ9U1O/9aBRI
	Ak+yyNJWCXxDGdlPFMOIyN5VFGazjB9rMMGFlsUC0EOod7uxg9qls8YzrFCfb7kN6mqNqr/lsjb
	n+tPJ5InEq7pFb4ww4lVfTHXZ5A/DAxBajVEYpqJrFuLMueAp/ng/uWS2Z/cOS5rbqtD2gQYEpD
	L59dqRy/fYrRDGLKdEmsWa3zGthtJn7v/4KwaV7Radk4npbUD78cbnuInM3qThq67dcYxX59ZdD
	uNg9zlh1YSndh02AnkSzpcAC45QClxQ5/y6ltLCL8LAwvexbQxDjQ7xoKuZFN+8u6WTz3Ffzqu9
	tvbRaUyUh4X06KrxiFQqGLvPdHQG4l46gUKKonpZbJvr7ZITVZP9/kMGE
X-Received: by 2002:a05:7301:7d16:b0:2ae:526a:961d with SMTP id 5a478bee46e88-2b05ec8642fmr15215231eec.40.1766715896412;
        Thu, 25 Dec 2025 18:24:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXdA8ClkjU6K261gUhCEsY/UDJEEfrrLSdJplFZD7gmyleR6jxqLs3c/WeMtHejh420lmUqA==
X-Received: by 2002:a05:7301:7d16:b0:2ae:526a:961d with SMTP id 5a478bee46e88-2b05ec8642fmr15215216eec.40.1766715895871;
        Thu, 25 Dec 2025 18:24:55 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffad66fsm49761798eec.4.2025.12.25.18.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 18:24:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <17aadc7e-7dd6-4335-a748-e66f0239df85@redhat.com>
Date: Thu, 25 Dec 2025 21:24:41 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
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
 <20251224134520.33231-15-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
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
>   include/linux/sched/isolation.h |  7 +++
>   kernel/cgroup/cpuset.c          |  3 ++
>   kernel/sched/isolation.c        | 76 ++++++++++++++++++++++++++++++---
>   kernel/sched/sched.h            |  1 +
>   4 files changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 109a2149e21a..6842a1ba4d13 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -9,6 +9,11 @@
>   enum hk_type {
>   	/* Revert of boot-time isolcpus= argument */
>   	HK_TYPE_DOMAIN_BOOT,
> +	/*
> +	 * Same as HK_TYPE_DOMAIN_BOOT but also includes the
> +	 * revert of cpuset isolated partitions. As such it
> +	 * is always a subset of HK_TYPE_DOMAIN_BOOT.
> +	 */
>   	HK_TYPE_DOMAIN,
>   	/* Revert of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> @@ -35,6 +40,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>   extern bool housekeeping_enabled(enum hk_type type);
>   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern int housekeeping_update(struct cpumask *isol_mask, enum hk_type type);
>   extern void __init housekeeping_init(void);
>   
>   #else
> @@ -62,6 +68,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   	return true;
>   }
>   
> +static inline int housekeeping_update(struct cpumask *isol_mask, enum hk_type type) { return 0; }
>   static inline void housekeeping_init(void) { }
>   #endif /* CONFIG_CPU_ISOLATION */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5e2e3514c22e..e13e32491ebf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1490,6 +1490,9 @@ static void update_isolation_cpumasks(void)
>   	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
>   	WARN_ON_ONCE(ret < 0);
>   
> +	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> +	WARN_ON_ONCE(ret < 0);
> +
>   	isolated_cpus_updating = false;
>   }
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 83be49ec2b06..a124f1119f2e 100644
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

To be more correct, we should use IS_ENABLED(CONFIG_PROVE_LOCKING) as 
this is the real kconfig that enables most of the lockdep checking. 
PROVE_LOCKING selects LOCKDEP but not vice versa. So for some weird 
configs that set LOCKDEP but not PROVE_LOCKING, it can cause compilation 
problem.

Other than that, the rest looks good to me.

Cheers,
Longman


