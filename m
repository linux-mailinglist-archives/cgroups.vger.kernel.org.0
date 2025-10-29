Return-Path: <cgroups+bounces-11398-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E19C1BE0B
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 154DD5C5C46
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8F330D51;
	Wed, 29 Oct 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdCm4kM2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058D239573
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751892; cv=none; b=cjjTGA4EtLMLoCWbdEAowoLeq0OObPqNcBqq+nxPVkJ9Vo9G05IduJRo02EUgNDtTqvAI4dwZR9gsjHbnDePQ7LQ3M+AFV3PB3OlbwwrV8VOctHPqLh0Z42Ef1vcC+4bO3ItY9iAkJk5bPkduXUUgwgi40envdOCOrjrkrd6blA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751892; c=relaxed/simple;
	bh=4kJkPpViT84UOyWJPK2MzMaXfq/uCGJY++sop0qrvwA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cOZwrk/c0+FsL04WBWxw/1j/5zyxpPIsEI5utS5L5F/NB94CFgMGywaiR0kgADsfQ/l084iWHmN1qSPm7eNnnY2oIlpRvBydCWCsULrbDNxeDYHrTF7n/bIjATRt11VESzrPetlMyXiRXos86n6Cd62aZNVxvNjhcIGIQ/2YuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdCm4kM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761751890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ay3GVREC02A0XZ2TjQyfHhRYCkbbQhZBnuTohtO/ndA=;
	b=FdCm4kM2ot2zx7vXPnFnQsGMHK4+1jd1X48caT2kg0G3wmorYrI3RJhPJVbQaxNSpoyfb1
	yFLfQ4GylZ09WTlYHcIM9ZZyApyuABiMdKmNz28Y8VfaiFATnngkztsC0eSGNJDsgnuRE8
	D45GkDpu4VWq+i6YH1yimn0lKMmFBOc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-7_-TAqs8NDCjViwsR53tGg-1; Wed, 29 Oct 2025 11:31:27 -0400
X-MC-Unique: 7_-TAqs8NDCjViwsR53tGg-1
X-Mimecast-MFC-AGG-ID: 7_-TAqs8NDCjViwsR53tGg_1761751886
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c1cc5a75dso2352956d6.0
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 08:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751886; x=1762356686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ay3GVREC02A0XZ2TjQyfHhRYCkbbQhZBnuTohtO/ndA=;
        b=nyBxXv9riY50ouw23TabdUP6ev0Qg+U6sPXLjZtXdM5D0K6m18XsQ5+O9z1g8PaaCR
         tHf+7vSBxx44IMbzdQn58hIS86hhMGbv2Gc5Lz9cjc6Kc7bxM+W8T5zW6TY7CW0iaE4X
         AQBCqvARjJLNXR5SzNjPpp6eeGsWSgKQPPFIFyn+Bkj1ncH6K5N2MAGGrpVW2vl7VplR
         mbsBbYXM7D6UreBGtRJSfXmX63du8mlhZDVMtatiFLV7Ud6GRQKrr197Wfoj5URk6TCm
         PYhk8mLSHopXYbXpKDW5FX3XKMA5/qHqhR18Vtxnj4MRHVGzmH1CcdUqABU4y2qvGxqh
         ivmw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQo7+CsU3jB5V0fzJzL+/8y7HURM1TU+be90xdGDMMdPww8xSfx6HqzVY2bdwGE1mNh1mLggj@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJd76Ce/nTOdQUW0BxQKQ4unSJOlaDSOJIa4NHjqeuotzBfZ9
	DU6t2GXh/mp56Lb6NLWdsYBeUYjMOq3O3NFgLOvkNv2wF8gzvSBs7u/FcdVCLO1SPLg8RZfOalU
	xF+Wq+sCc9F7NpIvOJDmkX2+QW/px2QE3LjGL/tY1W3XNOv6BV6+XvMMWR4Q=
X-Gm-Gg: ASbGncueTl1oXRrFCtiksGDEEmQ6IZlcjU79rPtGX30/lyHcY9JKdp7BRVHeUi3XuDP
	3UwKJtpEx8CmmDzXBKLrltuPQfOgu7NQibhYTqCGl9j+fw8OVuSVfwEFRVu1kFPGDocW0gFGl7X
	EeMRWn8diPd1NDS9npgI7iVLavZa+/gJOvyhk7ySnl6hHNj+g504dfKx0sIoykONKrjJ7tOgLWi
	pzwGi53zE0sIFeYIU3L8rKxiE5//JYC3pujvUkInqQNCkt1lqVqJELwHKIG2ZIzOl0MXbpVEXf8
	8xE1ATHLYBojX9R1Pe+GuQ1eWkbN7yeIgnWVUueWg1Eth7s9wmidR00k9spLXkblARS348GIY1m
	DgxzRZKojrQ1JDRfSDiS8o238f5jIluek0wZMsHmVjOCPJQ==
X-Received: by 2002:a05:6214:d67:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-88009c2847cmr40476186d6.59.1761751886324;
        Wed, 29 Oct 2025 08:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFys7HZ0z2qOJPlFPdrALA3NTmGw21B0aVlfZnCHalAutSq/VNf86cOTWelivjXx+NLDX1KNg==
X-Received: by 2002:a05:6214:d67:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-88009c2847cmr40475516d6.59.1761751885717;
        Wed, 29 Oct 2025 08:31:25 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4962376sm100081026d6.41.2025.10.29.08.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:31:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>
Date: Wed, 29 Oct 2025 11:31:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
To: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251028034357.11055-2-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/25 11:43 PM, Pingfan Liu wrote:
> *** Bug description ***
> When testing kexec-reboot on a 144 cpus machine with
> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> encounter the following bug:
>
> [   97.114759] psci: CPU142 killed (polled 0 ms)
> [   97.333236] Failed to offline CPU143 - error=-16
> [   97.333246] ------------[ cut here ]------------
> [   97.342682] kernel BUG at kernel/cpu.c:1569!
> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [...]
>
> In essence, the issue originates from the CPU hot-removal process, not
> limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
> program that waits indefinitely on a semaphore, spawning multiple
> instances to ensure some run on CPU 72, and then offlining CPUs 1–143
> one by one. When attempting this, CPU 143 failed to go offline.
>    bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'
>
> `
> *** Issue ***
> Tracking down this issue, I found that dl_bw_deactivate() returned
> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> But that is not the fact, and contributed by the following factors:
> When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
> blocked-state deadline task (in this case, "cppc_fie"), it was not
> migrated to CPU0, and its task_rq() information is stale. So its rq->rd
> points to def_root_domain instead of the one shared with CPU0.  As a
> result, its bandwidth is wrongly accounted into a wrong root domain
> during domain rebuild.
>
> The key point is that root_domain is only tracked through active rq->rd.
> To avoid using a global data structure to track all root_domains in the
> system, there should be a method to locate an active CPU within the
> corresponding root_domain.
>
> *** Solution ***
> To locate the active cpu, the following rules for deadline
> sub-system is useful
>    -1.any cpu belongs to a unique root domain at a given time
>    -2.DL bandwidth checker ensures that the root domain has active cpus.
>
> Now, let's examine the blocked-state task P.
> If P is attached to a cpuset that is a partition root, it is
> straightforward to find an active CPU.
> If P is attached to a cpuset that has changed from 'root' to 'member',
> the active CPUs are grouped into the parent root domain. Naturally, the
> CPUs' capacity and reserved DL bandwidth are taken into account in the
> ancestor root domain. (In practice, it may be unsafe to attach P to an
> arbitrary root domain, since that domain may lack sufficient DL
> bandwidth for P.) Again, it is straightforward to find an active CPU in
> the ancestor root domain.
>
> This patch groups CPUs into isolated and housekeeping sets. For the
> housekeeping group, it walks up the cpuset hierarchy to find active CPUs
> in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> To: cgroups@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
> v3 -> v4:
> rename function with cpuset_ prefix
> improve commit log
>
>   include/linux/cpuset.h  | 18 ++++++++++++++++++
>   kernel/cgroup/cpuset.c  | 26 ++++++++++++++++++++++++++
>   kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
>   3 files changed, 68 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..d4da93e51b37b 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -12,6 +12,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/topology.h>
>   #include <linux/sched/task.h>
> +#include <linux/sched/housekeeping.h>
>   #include <linux/cpumask.h>
>   #include <linux/nodemask.h>
>   #include <linux/mm.h>
> @@ -130,6 +131,7 @@ extern void rebuild_sched_domains(void);
>   
>   extern void cpuset_print_current_mems_allowed(void);
>   extern void cpuset_reset_sched_domains(void);
> +extern void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus);
>   
>   /*
>    * read_mems_allowed_begin is required when making decisions involving
> @@ -276,6 +278,22 @@ static inline void cpuset_reset_sched_domains(void)
>   	partition_sched_domains(1, NULL, NULL);
>   }
>   
> +static inline void cpuset_get_task_effective_cpus(struct task_struct *p,
> +		struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> +			/* isolated cpus belong to a root domain */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +	cpumask_and(cpus, cpu_active_mask, hk_msk);
> +}
> +
>   static inline void cpuset_print_current_mems_allowed(void)
>   {
>   }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675d..6ad88018f1a4e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1102,6 +1102,32 @@ void cpuset_reset_sched_domains(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +/* caller hold RCU read lock */
> +void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +	struct cpuset *cs;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> +			/* isolated cpus belong to a root domain */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +	/* In HK_TYPE_DOMAIN, cpuset can be applied */
> +	cs = task_cs(p);
> +	while (cs != &top_cpuset) {
> +		if (is_sched_load_balance(cs))
> +			break;
> +		cs = parent_cs(cs);
> +	}
> +
> +	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
> +	cpumask_and(cpus, cs->effective_cpus, hk_msk);
> +}
> +

It looks like you are trying to find a set of CPUs that are definitely 
in a active sched domain. The difference between this version and the 
!CONFIG_CPUSETS version in cpuset.h is the going up the cpuset hierarchy 
to find one with load balancing enabled. I would suggest you extract 
just this part out as a cpuset helper function and put the rests into 
deadline.c as a separate helper function without the cpuset prefix. In 
that way, you don't create a new housekeeping.h header file.

>   /**
>    * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
>    * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 72c1f72463c75..a3a43baf4314e 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2884,6 +2884,8 @@ void dl_add_task_root_domain(struct task_struct *p)
>   	struct rq_flags rf;
>   	struct rq *rq;
>   	struct dl_bw *dl_b;
> +	unsigned int cpu;
> +	struct cpumask msk;
>   
>   	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>   	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> @@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
>   		return;
>   	}
>   
> -	rq = __task_rq_lock(p, &rf);
> -
> +	/* prevent race among cpu hotplug, changing of partition_root_state */
> +	lockdep_assert_cpus_held();
> +	/*
> +	 * If @p is in blocked state, task_cpu() may be not active. In that
> +	 * case, rq->rd does not trace a correct root_domain. On the other hand,
> +	 * @p must belong to an root_domain at any given time, which must have
> +	 * active rq, whose rq->rd traces the valid root domain.
> +	 */
> +	cpuset_get_task_effective_cpus(p, &msk);
> +	cpu = cpumask_first_and(cpu_active_mask, &msk);
> +	/*
> +	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
> +	 * check prevents CPU hot removal from deactivating all CPUs in that
> +	 * domain.
> +	 */
> +	BUG_ON(cpu >= nr_cpu_ids);
> +	rq = cpu_rq(cpu);
> +	/*
> +	 * This point is under the protection of cpu_hotplug_lock. Hence
> +	 * rq->rd is stable.
> +	 */

So you trying to find a active sched domain with some dl bw to use for 
checking. I don't know enough about this dl bw checking code to know if 
it is valid or not. I will let Juri comment on that.

Cheers,
Longman


