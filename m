Return-Path: <cgroups+bounces-12770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882ECDF255
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 00:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AABEF3000B75
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2923290D81;
	Fri, 26 Dec 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy6GinHx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX8/lhjU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD773285CA9
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793584; cv=none; b=SJ+AEuhnukyf4TwpNOXNJWUl2AurDfMiybQY3snupTvMXS7QCVViDUqQrCEMMfRw3sI9jFjGttGAee94DaPZdyE1/0VvpghAYYn2iCzc7u9h/9tQNgBN6eaZ36Jmy2ChIptTmjNwTc1zwz3tcxK499tcxYwRudrtgHAkIWIPm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793584; c=relaxed/simple;
	bh=0WgtEyyghiej13OjppeGfPv7cq7v3kU/ZW6GrWWjF1I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m469wvA7T9BQ4uEiaOQddLd5cpMcQcye6yA4oYAcWAatFyuUTtyRZR0qDlekqnTWiXjiH3QzVBiaULHq8RWiE4GggMjG+jltYoKLo2Fb1FzGp9QnxeXLeh7nEd/OmQWkXP8p/h7alB/Oh8UNcG2Qxwb1Mf1vFaB6Mb1a6uH085s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iy6GinHx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hX8/lhjU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766793581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=865A7519wiN2/j/d36TzZexT5dCdrH361yDIN6aF4EQ=;
	b=Iy6GinHx2MJh6OO5k7SeTj7ZaOOtC2+QV+AvwjOx93VNx079uRE3YwXMl/KLdbITaMb0G2
	D2kyBRsvN8O7EZWf8CCa9lax5osGiYfRXdWsIAEohBen2+Aols4SWFg516Jeo13UvD59oj
	OWThu6/mWm1DGmUJn9T1rasFoTHuqcs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-gi6Pq2icOmekW_vegM9nOw-1; Fri, 26 Dec 2025 18:59:40 -0500
X-MC-Unique: gi6Pq2icOmekW_vegM9nOw-1
X-Mimecast-MFC-AGG-ID: gi6Pq2icOmekW_vegM9nOw_1766793580
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d26abbd8so219192841cf.1
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 15:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766793580; x=1767398380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=865A7519wiN2/j/d36TzZexT5dCdrH361yDIN6aF4EQ=;
        b=hX8/lhjU69EsMzJ45goSg9ZefRLPOdWtjnXVTnr6qD9njIgew8fbvDeFi97WODJtF0
         ZakysNxmxlrjAvuQ4MKMKhwndrpeL+LjgmB45/MMqnhoNACBeIWVr8JrqSgxlELxBF4Y
         UZGh+lC76YD68d4ayoUBdOFySRWeGVv8757imn579Qki4ZPumKhtxkUCjASdmKf5SiZ1
         mZd05s87jG8HOkqiRlo6G4mS+vkfvTm/ZSczPTYFi3CVjJoZm5yM9c2tqwfHMwpJvPpq
         cTVT88b52JMEu2N9s999y13SN6NDrrxG3Lz1dB/2jDjk+4MjZ3rd0DM/puoTtOrJv67F
         PpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766793580; x=1767398380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=865A7519wiN2/j/d36TzZexT5dCdrH361yDIN6aF4EQ=;
        b=YchcXnupefyiU+U6yC9/ojUunIXNZiS2HkZBVLbgCrtA6HGmoPZ/k9/M9Kv9y2MVj9
         xweKeCF5Wvm5lTJPMgbPOpC1oKrqD/KzfryBg4hl2/WOFyeKA4+B6iA55wCR0eCjWfuE
         CLybgsLVxO8BNl839xevG7ReVtwwj3sai7OSbO0/DCfuOSFtmsGKVI32X7yr5Un8q7WI
         /6/j1Ja1o5pE2GlsNXfWsA6jREpawzDSCvfNZVT8pRH0w8eg1ejVUsLOkVn+H77uV6iQ
         JskYjvsEdVGL/9dVPIm9KK1zY585rRnMBVnIXwUqovW0scLzENuLjOjyp8X0qyboKlHX
         FTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW65r4lXy9cTxHR3oDLLBSMnwDL3yFD1Duz6Sgv1WauFsljFILIMwMlGLnUmkf2WgH74szojUim@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiJ5LQsprSKVEFROC+LmrqSPn2EzT7qYEQwe+y7FbxlHDUb+A
	aZhjSfzXaH24d1+CCD1eAMtqBOz+pwzgZdaQl5tTQw/jEvfclbF8O+ek9qs94IFpFsaD/saUz0X
	pRQMUwElXsr8mP9LqAXvCFuWrhAI0SKkum9K2/Wgy8IwEhRjcQAjwaZU/ikM=
X-Gm-Gg: AY/fxX7PAWxCqkDqFbLvI3ka7LjDE03Ts8n/ZYmvFD99mfo2q6oSy7+9FCb23grksyJ
	uPOFEq7awh6I7rxe+YVv0gOyZvTQcWHISd38ooFeK5wDs7QRTk15LnA53J5coG+7VN5IHX2+DGR
	OtBSB8cfLYCbzJd8g7pEgJlEUTfPHwmqowEdrEDJxZyvBzZUqrx8ZFbkkHx8kQCFkhqQNnjGEXO
	gwE7NCxd7wZFcAjTncQweQMQmVwwzWmMk9uVAob+YnX7yJyz0L3GKLKJF0/dsIB1uYLKac6FXzt
	mtKRfVWAM7SyE0dwTHrd8lGgLuXrKFdLe77XH0kr1grEaaPv+RnP9F4YCojzJmFSYxHvHakafR5
	2vNx3suuVVbJ0SaWCTeqP9480VcG+IqVl29gnWn4jBas0FBstEjja6suL
X-Received: by 2002:a05:622a:198b:b0:4ee:1bc7:9d7b with SMTP id d75a77b69052e-4f4abd8cc1fmr323812771cf.39.1766793580123;
        Fri, 26 Dec 2025 15:59:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERH4Oby4w37LQow9PPp6jIctRZ9vYsC7ux3H2yEqxLfgye1sWzIlcBk2jF/qfYV4D0shjHTw==
X-Received: by 2002:a05:622a:198b:b0:4ee:1bc7:9d7b with SMTP id d75a77b69052e-4f4abd8cc1fmr323812481cf.39.1766793579691;
        Fri, 26 Dec 2025 15:59:39 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac55fde7sm165334981cf.12.2025.12.26.15.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 15:59:38 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a8968902-7fc3-4dec-9a53-e9685a5705b9@redhat.com>
Date: Fri, 26 Dec 2025 18:59:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] kthread: Honour kthreads preferred affinity after
 cpuset changes
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
 <20251224134520.33231-31-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-31-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> When cpuset isolated partitions get updated, unbound kthreads get
> indifferently affine to all non isolated CPUs, regardless of their
> individual affinity preferences.
>
> For example kswapd is a per-node kthread that prefers to be affine to
> the node it refers to. Whenever an isolated partition is created,
> updated or deleted, kswapd's node affinity is going to be broken if any
> CPU in the related node is not isolated because kswapd will be affine
> globally.
>
> Fix this with letting the consolidated kthread managed affinity code do
> the affinity update on behalf of cpuset.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/kthread.h  |  1 +
>   kernel/cgroup/cpuset.c   |  5 ++---
>   kernel/kthread.c         | 41 ++++++++++++++++++++++++++++++----------
>   kernel/sched/isolation.c |  3 +++
>   4 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 8d27403888ce..c92c1149ee6e 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -100,6 +100,7 @@ void kthread_unpark(struct task_struct *k);
>   void kthread_parkme(void);
>   void kthread_exit(long result) __noreturn;
>   void kthread_complete_and_exit(struct completion *, long) __noreturn;
> +int kthreads_update_housekeeping(void);
>   
>   int kthreadd(void *unused);
>   extern struct task_struct *kthreadd_task;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1cc83a3c25f6..c8cfaf5cd4a1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1208,11 +1208,10 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>   
>   		if (top_cs) {
>   			/*
> +			 * PF_KTHREAD tasks are handled by housekeeping.
>   			 * PF_NO_SETAFFINITY tasks are ignored.
> -			 * All per cpu kthreads should have PF_NO_SETAFFINITY
> -			 * flag set, see kthread_set_per_cpu().
>   			 */
> -			if (task->flags & PF_NO_SETAFFINITY)
> +			if (task->flags & (PF_KTHREAD | PF_NO_SETAFFINITY))
>   				continue;
>   			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
>   		} else {
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 968fa5868d21..03008154249c 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -891,14 +891,7 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
>   }
>   EXPORT_SYMBOL_GPL(kthread_affine_preferred);
>   
> -/*
> - * Re-affine kthreads according to their preferences
> - * and the newly online CPU. The CPU down part is handled
> - * by select_fallback_rq() which default re-affines to
> - * housekeepers from other nodes in case the preferred
> - * affinity doesn't apply anymore.
> - */
> -static int kthreads_online_cpu(unsigned int cpu)
> +static int kthreads_update_affinity(bool force)
>   {
>   	cpumask_var_t affinity;
>   	struct kthread *k;
> @@ -924,7 +917,8 @@ static int kthreads_online_cpu(unsigned int cpu)
>   		/*
>   		 * Unbound kthreads without preferred affinity are already affine
>   		 * to housekeeping, whether those CPUs are online or not. So no need
> -		 * to handle newly online CPUs for them.
> +		 * to handle newly online CPUs for them. However housekeeping changes
> +		 * have to be applied.
>   		 *
>   		 * But kthreads with a preferred affinity or node are different:
>   		 * if none of their preferred CPUs are online and part of
> @@ -932,7 +926,7 @@ static int kthreads_online_cpu(unsigned int cpu)
>   		 * But as soon as one of their preferred CPU becomes online, they must
>   		 * be affine to them.
>   		 */
> -		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +		if (force || k->preferred_affinity || k->node != NUMA_NO_NODE) {
>   			kthread_fetch_affinity(k, affinity);
>   			set_cpus_allowed_ptr(k->task, affinity);
>   		}
> @@ -943,6 +937,33 @@ static int kthreads_online_cpu(unsigned int cpu)
>   	return ret;
>   }
>   
> +/**
> + * kthreads_update_housekeeping - Update kthreads affinity on cpuset change
> + *
> + * When cpuset changes a partition type to/from "isolated" or updates related
> + * cpumasks, propagate the housekeeping cpumask change to preferred kthreads
> + * affinity.
> + *
> + * Returns 0 if successful, -ENOMEM if temporary mask couldn't
> + * be allocated or -EINVAL in case of internal error.
> + */
> +int kthreads_update_housekeeping(void)
> +{
> +	return kthreads_update_affinity(true);
> +}
> +
> +/*
> + * Re-affine kthreads according to their preferences
> + * and the newly online CPU. The CPU down part is handled
> + * by select_fallback_rq() which default re-affines to
> + * housekeepers from other nodes in case the preferred
> + * affinity doesn't apply anymore.
> + */
> +static int kthreads_online_cpu(unsigned int cpu)
> +{
> +	return kthreads_update_affinity(false);
> +}
> +
>   static int kthreads_init(void)
>   {
>   	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 84a257d05918..c499474866b8 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -157,6 +157,9 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
>   	err = tmigr_isolated_exclude_cpumask(isol_mask);
>   	WARN_ON_ONCE(err < 0);
>   
> +	err = kthreads_update_housekeeping();
> +	WARN_ON_ONCE(err < 0);
> +
>   	kfree(old);
>   
>   	return err;
Reviewed-by: Waiman Long <longman@redhat.com>


