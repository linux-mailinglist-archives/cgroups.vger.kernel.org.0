Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C74598785
	for <lists+cgroups@lfdr.de>; Thu, 18 Aug 2022 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiHRPbp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Aug 2022 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiHRPbo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Aug 2022 11:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE39C8D9
        for <cgroups@vger.kernel.org>; Thu, 18 Aug 2022 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660836702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTTQvzeO8NbT9iEosZSAoBf5nEuQJaIJbAqJp7WZFCk=;
        b=NpsWZm1Kmfu4yey6P3UXOxN19DlKzdvFKtVal361vZulW30i3P6nTbgj1xHHARzsljid2t
        gdLiCblqRrUIVk+SYAvNtBdQdSADpXpWAcohB+9MGtgoMdcirtvgDTElSRTMLRM35FW7id
        CXznb7195JFVJAa+X5QOHjD+nFHEHbs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-wUlIOUvQN0C_769kI5zOOw-1; Thu, 18 Aug 2022 11:31:39 -0400
X-MC-Unique: wUlIOUvQN0C_769kI5zOOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B5B12932485;
        Thu, 18 Aug 2022 15:31:38 +0000 (UTC)
Received: from [10.22.32.4] (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA922166B26;
        Thu, 18 Aug 2022 15:31:24 +0000 (UTC)
Message-ID: <81f06470-ad5b-2b92-86d6-dc2ca5d21d53@redhat.com>
Date:   Thu, 18 Aug 2022 08:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/3] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-2-longman@redhat.com>
 <Yvyp02LLIQQPs5d6@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yvyp02LLIQQPs5d6@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/17/22 04:41, Peter Zijlstra wrote:
> On Tue, Aug 16, 2022 at 03:27:32PM -0400, Waiman Long wrote:
>> @@ -2981,25 +2969,21 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>>   		goto err_unlock;
>>   	}
>>   
>> -	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
>> +
>> +	if (p->user_cpus_ptr)
>> +		not_empty = cpumask_and(new_mask, p->user_cpus_ptr, subset_mask);
>> +	else
>> +		not_empty = cpumask_and(new_mask, cpu_online_mask, subset_mask);
>> +
>> +	if (!not_empty) {
>>   		err = -EINVAL;
>>   		goto err_unlock;
>>   	}
>>   
>> -	/*
>> -	 * We're about to butcher the task affinity, so keep track of what
>> -	 * the user asked for in case we're able to restore it later on.
>> -	 */
>> -	if (user_mask) {
>> -		cpumask_copy(user_mask, p->cpus_ptr);
>> -		p->user_cpus_ptr = user_mask;
>> -	}
>> -
>>   	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
>>   
>>   err_unlock:
>>   	task_rq_unlock(rq, p, &rf);
>> -	kfree(user_mask);
>>   	return err;
>>   }
>>   
>> @@ -3049,34 +3033,27 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
>>   }
>>   
>>   static int
>> -__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
>> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask);
>>   
>>   /*
>>    * Restore the affinity of a task @p which was previously restricted by a
>> - * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
>> - * @p->user_cpus_ptr.
>> + * call to force_compatible_cpus_allowed_ptr().
>>    *
>>    * It is the caller's responsibility to serialise this with any calls to
>>    * force_compatible_cpus_allowed_ptr(@p).
>>    */
>>   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>>   {
>> -	struct cpumask *user_mask = p->user_cpus_ptr;
>> -	unsigned long flags;
>> +	const struct cpumask *user_mask = p->user_cpus_ptr;
>> +
>> +	if (!user_mask)
>> +		user_mask = cpu_online_mask;
>>   
>>   	/*
>> -	 * Try to restore the old affinity mask. If this fails, then
>> -	 * we free the mask explicitly to avoid it being inherited across
>> -	 * a subsequent fork().
>> +	 * Try to restore the old affinity mask with __sched_setaffinity().
>> +	 * Cpuset masking will be done there too.
>>   	 */
>> -	if (!user_mask || !__sched_setaffinity(p, user_mask))
>> -		return;
>> -
>> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
>> -	user_mask = clear_user_cpus_ptr(p);
>> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>> -
>> -	kfree(user_mask);
>> +	__sched_setaffinity(p, user_mask, false);
>>   }
>>   
>>   void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>
> Would it not be simpler to write it something like so?
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 03053eebb22e..cdae4d50a588 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2955,7 +2955,6 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>   	struct rq_flags rf;
>   	struct rq *rq;
>   	int err;
> -	bool not_empty;
>   
>   	rq = task_rq_lock(p, &rf);
>   
> @@ -2969,13 +2968,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>   		goto err_unlock;
>   	}
>   
> -
> -	if (p->user_cpus_ptr)
> -		not_empty = cpumask_and(new_mask, p->user_cpus_ptr, subset_mask);
> -	else
> -		not_empty = cpumask_and(new_mask, cpu_online_mask, subset_mask);
> -
> -	if (!not_empty) {
> +	if (!cpumask_and(new_mask, task_user_cpus(p), subset_mask)) {
>   		err = -EINVAL;
>   		goto err_unlock;
>   	}
> @@ -3044,16 +3037,11 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save
>    */
>   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>   {
> -	const struct cpumask *user_mask = p->user_cpus_ptr;
> -
> -	if (!user_mask)
> -		user_mask = cpu_online_mask;
> -
>   	/*
>   	 * Try to restore the old affinity mask with __sched_setaffinity().
>   	 * Cpuset masking will be done there too.
>   	 */
> -	__sched_setaffinity(p, user_mask, false);
> +	__sched_setaffinity(p, task_user_cpus(p), false);
>   }
>   
>   void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 15eefcd65faa..426e9b64b587 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1881,6 +1881,13 @@ static inline void dirty_sched_domain_sysctl(int cpu)
>   #endif
>   
>   extern int sched_update_scaling(void);
> +
> +static inline const struct cpumask *task_user_cpus(struct task_struct *p)
> +{
> +	if (!p->user_cpus_ptr)
> +		return cpus_possible_mask; /* &init_task.cpus_mask */
> +	return p->user_cpus_ptr;
> +}
>   #endif /* CONFIG_SMP */
>   
>   #include "stats.h"
>
Thanks for the good suggestions, will make the changes.

Cheers,
Longman

