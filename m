Return-Path: <cgroups+bounces-12098-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A6AC71150
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 21:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8F89B290A8
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE932B9A8;
	Wed, 19 Nov 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQda+Jo2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rxGYqA4o"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B031A810
	for <cgroups@vger.kernel.org>; Wed, 19 Nov 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585486; cv=none; b=tCc6Oosnj0YItZK3ptherUdVXy3287tn3CmgDK1tvVaEg05IzPoOaXQdk1vhi5YPPOCAIgz1ckN9DnG10HV5c+f/rVUTjmNz0MojFFwPIkXda9uWt83AjwzQppxN8alXXtzrCUgB4JCRziyUgcgwQddDubOjYh2vHoxYY49YauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585486; c=relaxed/simple;
	bh=utsO0XcHcd7Z4bt9AaePdGTOqhdltD2lkFDj3cxODfQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ayDmpVbb8GgLBfHKODdLY+s0uDR9540c2+v5Gqm1m+VipnKmeANrLMfsd1pRo8MFM/NOgMkIQ9CFM4miYhoCeBNyqEKQKVHPfnOrhlUsIsl7SABS4u3wUML/yWb/Zt0pM5tDAT8B1ToW7HKD1rr06hxWezwlmofAe9F9mCfErvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQda+Jo2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rxGYqA4o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763585482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFZNyQ/LCaXr6RZiLQW4BnfqNO+92dAQgo541I5j4KI=;
	b=jQda+Jo2RF6y6ReKUpZxa+7X+RL5xDsLbwMb8dFN1aph+JoZrKKXrvLGi0KAbkZHLvs72/
	5oFjNauhNQlcUZ/8T+neZ65lwpN+KrwA21z69FHQX4r2qRIoBqQ6TSG4R6Pi2DPrH9N3YX
	3Waw4xj1110ugL3NsM3okAYSiC0rHu4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-71PNQ4-jOnarjko66h_7Ug-1; Wed, 19 Nov 2025 15:51:21 -0500
X-MC-Unique: 71PNQ4-jOnarjko66h_7Ug-1
X-Mimecast-MFC-AGG-ID: 71PNQ4-jOnarjko66h_7Ug_1763585480
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8804b9afe30so6543066d6.0
        for <cgroups@vger.kernel.org>; Wed, 19 Nov 2025 12:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763585480; x=1764190280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AFZNyQ/LCaXr6RZiLQW4BnfqNO+92dAQgo541I5j4KI=;
        b=rxGYqA4ovdUYLmqpWoy4l/le0kiaResK+EpSfBeXcAC9woTfgEpa0YbZHc6k59dgZI
         up3V3RYv1CwmWN4VGtVxz79vXUNa5KjJ9mSJTjg8mYi3POLdjVcX/LSZL39SncfvBEPT
         bcyIBbAdQfkkmJ886qqpiypX4y+SwfZF3XLg9L+qJz32fyTDkgEM87k33EZT57S5BFEw
         Ml271mp+oaD+J63HQGrO4EyJNp4jtzszEC3AWB7jMq6KZOrI4GEbStDdySWBknjcZnIb
         a5hq8RlrfoPneIga+kRNvOd3PTNwziRVSB+902zdTJU0Jenw6Cp87/vJI85wvfysgx/w
         u0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763585480; x=1764190280;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFZNyQ/LCaXr6RZiLQW4BnfqNO+92dAQgo541I5j4KI=;
        b=Z424LNdZb6ryY7NEfvXFzNfc/9iIyK3/YeR69VuZPNDVSgQrpcbRVcufv+12nHB9qy
         Z6uS4mqone591BgkxFIb4jHvubUZadx9lY5DSvLYaDhk/zX8dNK28hcn5I6FTnW4vzmY
         Nzz6PFT8sY9SPP74ToATckiAWd297or0WW3TqFO7PyTcbl2FJoHKz1jSj9spkEJWw5EO
         s86WZH416zgVeBmfsMJfsa0Nv06Ol5SviPeAuc61QAfVPy9xvT80sJN11Pot6TCTnPU9
         0jfyEv7wOWImG0xniWx1kphB08iRUBhFqhfisxVgJvAS09hB9SBZ5a7AEkpJFbCUFolE
         P6xA==
X-Forwarded-Encrypted: i=1; AJvYcCXUkuIBqLWF0+hAouaKUqSrS5oD1pG/b6Ns11JUBvjFK4Rfo6g6XsJ4SMcXhagCgtefwplzCjMN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3zDIxo6mgMI3lXOO8jadl7nyEFg88v9CI06h27mPinE3jqmDR
	CQN8O/DgEbj1Z0Z2Ea3+pJGA45sXudFfoe98MGGveaJr5Ukjhot3sKxRBWgDaNmt+cHjRcVo3QK
	d3KtULNqKVuKK4+FwSdSLUBJas0NhPoMbK4KR6aOZc9/oBeo3wxd6ZazmBu4=
X-Gm-Gg: ASbGncubvWXaw6rmgDemAPJDA8iUBtYYuXHzXViyzE4HXqwU2+cwBPSfm124NZCpT5S
	iV/+FO+X0qdUwezVREX8rWaFRyG9WtQjr7IsU+FJ4AHUbnkVyMaHHyjzrR3Y4HfQcZzSH9mKzTS
	VqYHdxkHTm2hLz/4RCvVx2DjdwiG+qnyJEhm+S8MCKiIa4zatxFb6CXBWS0NTDau+JTxce2aTuh
	vi18/3v35yL3ElUR6hWy48Dh6FITmNcemF6YEHuJWT8sqBMlzeMUrmjiOSXBZoQ9N6gbL3G9/Ad
	FOQP+JYXJTFlt8kqoV9WEWdGTEpHmqPZzuW5ReeoBkXZLCK8US/Bz8qL62zo5lkf1QkxiyWT0Aj
	4qoZ7VhH23ahqYeia6Ohzd0Z3GAIyESa3hRp2lqR4ybueUwzNt7VJfkv+
X-Received: by 2002:a05:6214:2422:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-8846e17f98emr11147226d6.59.1763585480626;
        Wed, 19 Nov 2025 12:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvXNGPWiTmV3Z3w2kP8vow9MpastD+FUkYyGIygQlkmlY0/CEWX7LxZHA9dKtx0oRjDVaa3A==
X-Received: by 2002:a05:6214:2422:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-8846e17f98emr11146946d6.59.1763585480316;
        Wed, 19 Nov 2025 12:51:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e4682c7sm3276206d6.16.2025.11.19.12.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 12:51:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b0d222e0-3380-4014-8d9a-57e8be8b082c@redhat.com>
Date: Wed, 19 Nov 2025 15:51:18 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/2] cgroup/cpuset: Introduce
 cpuset_cpus_allowed_locked()
To: Pingfan Liu <piliu@redhat.com>, cgroups@vger.kernel.org
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20251119095525.12019-1-piliu@redhat.com>
 <20251119095525.12019-2-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251119095525.12019-2-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/25 4:55 AM, Pingfan Liu wrote:
> cpuset_cpus_allowed() uses a reader lock that is sleepable under RT,
> which means it cannot be called inside raw_spin_lock_t context.
>
> Introduce a new cpuset_cpus_allowed_locked() helper that performs the
> same function as cpuset_cpus_allowed() except that the caller must have
> acquired the cpuset_mutex so that no further locking will be needed.
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: linux-kernel@vger.kernel.org
> To: cgroups@vger.kernel.org
> ---
>   include/linux/cpuset.h |  9 +++++++-
>   kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++-------------
>   2 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..a98d3330385c2 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
>   extern void dec_dl_tasks_cs(struct task_struct *task);
>   extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
> +extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>   extern bool cpuset_cpu_is_isolated(int cpu);
> @@ -195,10 +196,16 @@ static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>   static inline void cpuset_lock(void) { }
>   static inline void cpuset_unlock(void) { }
>   
> +static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
> +					struct cpumask *mask)
> +{
> +	cpumask_copy(mask, task_cpu_possible_mask(p));
> +}
> +
>   static inline void cpuset_cpus_allowed(struct task_struct *p,
>   				       struct cpumask *mask)
>   {
> -	cpumask_copy(mask, task_cpu_possible_mask(p));
> +	cpuset_cpus_allowed_locked(p, mask);
>   }
>   
>   static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a3..7a179a1a2e30a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4116,24 +4116,13 @@ void __init cpuset_init_smp(void)
>   	BUG_ON(!cpuset_migrate_mm_wq);
>   }
>   
> -/**
> - * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
> - * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
> - * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
> - *
> - * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
> - * attached to the specified @tsk.  Guaranteed to return some non-empty
> - * subset of cpu_active_mask, even if this means going outside the
> - * tasks cpuset, except when the task is in the top cpuset.
> - **/
> -
> -void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> +/*
> + * Return cpus_allowed mask from a task's cpuset.
> + */
> +static void __cpuset_cpus_allowed_locked(struct task_struct *tsk, struct cpumask *pmask)
>   {
> -	unsigned long flags;
>   	struct cpuset *cs;
>   
> -	spin_lock_irqsave(&callback_lock, flags);
> -
>   	cs = task_cs(tsk);
>   	if (cs != &top_cpuset)
>   		guarantee_active_cpus(tsk, pmask);
> @@ -4153,7 +4142,39 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   		if (!cpumask_intersects(pmask, cpu_active_mask))
>   			cpumask_copy(pmask, possible_mask);
>   	}
> +}
>   
> +/**
> + * cpuset_cpus_allowed_locked - return cpus_allowed mask from a task's cpuset.
> + * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
> + * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
> + *
> + * Similir to cpuset_cpus_allowed() except that the caller must have acquired
> + * cpuset_mutex.
> + */
> +void cpuset_cpus_allowed_locked(struct task_struct *tsk, struct cpumask *pmask)
> +{
> +	lockdep_assert_held(&cpuset_mutex);
> +	__cpuset_cpus_allowed_locked(tsk, pmask);
> +}
> +
> +/**
> + * cpuset_cpus_allowed - return cpus_allowed mask from a task's cpuset.
> + * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
> + * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
> + *
> + * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
> + * attached to the specified @tsk.  Guaranteed to return some non-empty
> + * subset of cpu_active_mask, even if this means going outside the
> + * tasks cpuset, except when the task is in the top cpuset.
> + **/
> +
> +void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&callback_lock, flags);
> +	__cpuset_cpus_allowed_locked(tsk, pmask);
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>


