Return-Path: <cgroups+bounces-11448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE175C22D3F
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 01:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A36F3B664C
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331F208961;
	Fri, 31 Oct 2025 00:53:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD01B78F3;
	Fri, 31 Oct 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872026; cv=none; b=OccQTx9LbOK9bcVxlx1jFtvj5IGDFRwq+B7ph6ZQvSN9F/DB2BXAQeErwzScDhBEmwHDZOmmNg/CAHCShxAb9gdRszA7JoFY0cF9yuO2CtcaC04YiC+2vilVUk5fY1gexoteGOZsIlYU0Y2OGgMWGHq+ASaKmJOmVFGxmKDAmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872026; c=relaxed/simple;
	bh=avj7CwmN4vwzU+RqZSmcaRvBwgDhGJ1dXxVYEA27O2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWNXp15WTqZb6WzUQm/z0hRm3n/u8FqDHhLeTT/qCLcIx26Iy9VAwwuj403ZvvuhEotZagu5boTZWQHC41B1SjFU1G/x4JtAGK3k6Q9ahmRyByeiGhEde92Q/3mCW5mi1RzKO/xbCdbFU0ttwFCtqiZZ24A7jYmp90HxLkBTdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyMt63Ff6zYQtgk;
	Fri, 31 Oct 2025 08:53:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0969D1A0D3F;
	Fri, 31 Oct 2025 08:53:42 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgCnOt+RCARpqpGMCA--.36160S2;
	Fri, 31 Oct 2025 08:53:38 +0800 (CST)
Message-ID: <bd8413ea-bdfe-4bc3-a3d0-aed6e4c576e5@huaweicloud.com>
Date: Fri, 31 Oct 2025 08:53:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3] sched/core: Skip user_cpus_ptr masking if no
 online CPU left
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250718164143.31338-1-longman@redhat.com>
 <20251029212724.1005063-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251029212724.1005063-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCnOt+RCARpqpGMCA--.36160S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfGrWrtw1fZF1UAr47urg_yoW5JFWrpF
	WkKFWUCFZ2qF1UCayxu3y2kF1Fqa9xJ3WaqF4Syr1FvFWagF40kry0gFnxXr15KrsakFyU
	tFWagrZ29r1qqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/30 5:27, Waiman Long wrote:
> Chen Ridong reported that cpuset could report a kernel warning for a task
> due to set_cpus_allowed_ptr() returning failure in the corner case that:
> 
> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>    be the same as the cpuset.cpus of its cpuset,
> 2) all the CPUs assigned to that cpuset were taken offline, and
> 3) cpuset v1 is in use and the task had to be migrated to top_cpuset.
>    Task migration is not needed for cpuset v2.
> 
> Due to the fact that CPU affinity of the tasks in the top cpuset are
> not updated when a CPU hotplug online/offline event happens, offline
> CPUs are included in CPU affinity of those tasks. It is possible
> that further masking with user_cpus_ptr set by sched_setaffinity(2)
> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
> to return failure with an empty CPU affinity.
> 
> Fix this failure by skipping user_cpus_ptr masking if there is no online
> CPU left.
> 
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f1ebf67b48e2..66cd21582822 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3146,12 +3146,13 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>  
>  	rq = task_rq_lock(p, &rf);
>  	/*
> -	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
> -	 * flags are set.
> +	 * Masking should be skipped if SCA_USER, any of the SCA_MIGRATE_*
> +	 * flags are set or no online CPU left.
>  	 */
>  	if (p->user_cpus_ptr &&
>  	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
> +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
>  		ctx->new_mask = rq->scratch_mask;
>  
>  	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);

This patch have been tested with our test project.

Reviewed-by: Chen Ridong<chenridong@huawei.com>

-- 
Best regards,
Ridong


