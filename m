Return-Path: <cgroups+bounces-12105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93202C71AAD
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 02:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8C96A29514
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AE23C51D;
	Thu, 20 Nov 2025 01:12:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165CE23B609;
	Thu, 20 Nov 2025 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601140; cv=none; b=jr9N6RmTah4OGoDaSjsR9TLcp10cX9rezjTaRxM4S80IF+v6gA48OvWt55q68idr+8b4I49cZcDAdkxdK7Gtb5zL0PXHJ/YTjkGV7LZKtib6mNUPEISLsvW7f2c0j+dhepH+SNV4LfUxCzwrt6eFWrbmu+QVZaibOKYZm9NozJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601140; c=relaxed/simple;
	bh=zQXc5YiuwqRVA2ZxpOeKGrGC8+XWzEmlPH+B+X4w3HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKsr0orMLMOSwr4GvwB+id1SUGBbApW4Tw+rZhy4IF54CRIoZam/ioTcohrzhMHTqr//sPGflk4jphfWTajmQytMvOfGv3PaZTU0lEJlZvrOCYqxYwQRY8oY/GDUSPDrG1qaPVZf8SQhENBY0Zb945kL9DcXDcu4THNjPEhV+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBgKd4kbVzYQtmj;
	Thu, 20 Nov 2025 09:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AF3FF1A19CE;
	Thu, 20 Nov 2025 09:12:14 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgCHDEbtah5pLN9YBQ--.12866S2;
	Thu, 20 Nov 2025 09:12:14 +0800 (CST)
Message-ID: <4ec92cd0-0d10-4bbb-8fbd-696aa5d84bd5@huaweicloud.com>
Date: Thu, 20 Nov 2025 09:12:13 +0800
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
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20251119095525.12019-1-piliu@redhat.com>
 <20251119095525.12019-2-piliu@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251119095525.12019-2-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHDEbtah5pLN9YBQ--.12866S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryDJFy7tr1kuFy8Jr13Jwb_yoW7XFWxpF
	4qk347CFWUXr1xuw13X3yDuFyF9w1kuF15C3WrXw1rAFy3tF1jyF1kXF98Ary3tr15uF47
	GrZxKr4S9F1DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/19 17:55, Pingfan Liu wrote:
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
>  include/linux/cpuset.h |  9 +++++++-
>  kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++-------------
>  2 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..a98d3330385c2 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
>  extern void dec_dl_tasks_cs(struct task_struct *task);
>  extern void cpuset_lock(void);
>  extern void cpuset_unlock(void);
> +extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>  extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>  extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>  extern bool cpuset_cpu_is_isolated(int cpu);
> @@ -195,10 +196,16 @@ static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>  static inline void cpuset_lock(void) { }
>  static inline void cpuset_unlock(void) { }
>  
> +static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
> +					struct cpumask *mask)
> +{
> +	cpumask_copy(mask, task_cpu_possible_mask(p));
> +}
> +
>  static inline void cpuset_cpus_allowed(struct task_struct *p,
>  				       struct cpumask *mask)
>  {
> -	cpumask_copy(mask, task_cpu_possible_mask(p));
> +	cpuset_cpus_allowed_locked(p, mask);
>  }
>  
>  static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a3..7a179a1a2e30a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4116,24 +4116,13 @@ void __init cpuset_init_smp(void)
>  	BUG_ON(!cpuset_migrate_mm_wq);
>  }
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
>  {
> -	unsigned long flags;
>  	struct cpuset *cs;
>  
> -	spin_lock_irqsave(&callback_lock, flags);
> -
>  	cs = task_cs(tsk);
>  	if (cs != &top_cpuset)
>  		guarantee_active_cpus(tsk, pmask);
> @@ -4153,7 +4142,39 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  		if (!cpumask_intersects(pmask, cpu_active_mask))
>  			cpumask_copy(pmask, possible_mask);
>  	}
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
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }
>  

LGTM

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


