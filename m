Return-Path: <cgroups+bounces-8762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B651B099E6
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 04:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E174A08CE
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E9D1B0F33;
	Fri, 18 Jul 2025 02:43:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB643597A;
	Fri, 18 Jul 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806581; cv=none; b=HT83vbTvq2EwIgjwlUXmW75j8DygjLN/dSUica8d7ihpScTKrl/JnGKa3d+S1S3egYXbTui2ab+4UAdUxAH+BF7PUpWRosOJ1cERuk/SclpKO6WnZQY5n4aVc9ABK8z76UB7mS19jkz1URCNx76wDNad8XgM5Jb7Je6znzYYJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806581; c=relaxed/simple;
	bh=AxKC0cdUyhvufMDloG1kl9akXAe19uKKmNmea2whACU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZODDcbuyTyVg4+jeMKg4GlSaZ6Iy/5DQsvDkrfGqzRrbuOkkDesWnZhr/pNpyK0KWV3ui003VPUjmrsIU7CBaRA+dDZuLHoFNz+s9WeII4jA6qJVdw4BbgIe+niS0XEiHuWcmDm/tkHP71b9LNaqL30Dd0ABXznzHgmlKWmnty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bjvGm4ZfHzKHLxd;
	Fri, 18 Jul 2025 10:42:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 42E151A19EE;
	Fri, 18 Jul 2025 10:42:55 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgAnl7KrtHloCYh_Ag--.5486S2;
	Fri, 18 Jul 2025 10:42:53 +0800 (CST)
Message-ID: <faab5c42-ec95-443c-b748-b3e7e359c934@huaweicloud.com>
Date: Fri, 18 Jul 2025 10:42:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Mask out offline CPUs when user_cpus_ptr is
 used
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250715155810.514141-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250715155810.514141-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnl7KrtHloCYh_Ag--.5486S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4xWw1Uur1fuFyfKFykXwb_yoW5AFyrpF
	WktFWUCrWktF4jyayxZw42kr1Fq3s3JF13tF1SkryFvFWSgF18ur10gFnxXr15WrsakFWU
	trWSgrWF9F1DJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/15 23:58, Waiman Long wrote:
> Chen Ridong reported that cpuset could report a kernel warning for a task
> due to set_cpus_allowed_ptr() returning failure in the corner case that:
> 
> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>    be the same as the cpuset.cpus of its cpuset,
> 2) all the CPUs assigned to that cpuset were taken offline, and
> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
> 
> Due to the fact that CPU affinity of the tasks in the top cpuset are
> not updated when a CPU hotplug online/offline event happens, offline
> CPUs are included in CPU affinity of those tasks. It is possible
> that further masking with user_cpus_ptr set by sched_setaffinity(2)
> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
> to return failure with an empty CPU affinity.
> 
> Fix this failure by masking out offline CPUs when user_cpus_ptr masking
> has to be done and fall back to ignoring user_cpus_ptr if the resulting
> cpumask is empty.
> 
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 81c6df746df1..4cf25dd8827f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3172,10 +3172,15 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>  	/*
>  	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
>  	 * flags are set.
> +	 *
> +	 * Even though the given new_mask must have at least one online CPU,
> +	 * masking with user_cpus_ptr may strip out all online CPUs causing
> +	 * failure. So offline CPUs have to be masked out too.
>  	 */
>  	if (p->user_cpus_ptr &&
>  	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
> +	    cpumask_and(rq->scratch_mask, rq->scratch_mask, cpu_active_mask))
>  		ctx->new_mask = rq->scratch_mask;
>  
>  	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);

Hi, Waiman,
Would the following modification make more sense?

  	if (p->user_cpus_ptr &&
  	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
 -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
 +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
 +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
  		ctx->new_mask = rq->scratch_mask;

This can preserve user intent as much as possible.

Best regards,
Ridong


