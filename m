Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519AE7186E
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfGWMo5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 08:44:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbfGWMo5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 08:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N9UdQqnOB55OuWBdAU8EUbiei4UyxqO1Nv88zjqQ7ak=; b=SvzV/umark6ZER0sswvLH8v85M
        GNXtQ40xP8Ohm61V1o833snKpYrEn+CdmqNnTw9S+FSywW95mQNJUhTBnMmJH6TFf+MZi9CmDawdU
        Uz7MfYP2QOsadFsPZJ0N54m7ObC625hd2wIlTq9l3Ps2aDEgQ2ycCBhebxkTvQcF0K66J8yg1MV0N
        cZVeXLpsbt9kqJjKi1smAi0wtrwYSmEnpNdl4P/jZXxU+9Tnp9Mqsz5QBoCvI9qqwUKSy1rfhNUWr
        s90Ek663/+R1xo3Z+KRs/SyPTvmD2jffFsaJD0ZvaozwJXgtQjahXzNyVEdtFpfroAQHFzSJtDRh2
        YWHe+k8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpu9w-0005Pw-Cs; Tue, 23 Jul 2019 12:44:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89F9F201A942B; Tue, 23 Jul 2019 14:44:46 +0200 (CEST)
Date:   Tue, 23 Jul 2019 14:44:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, tj@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190723124446.GE3402@hirez.programming.kicks-ass.net>
References: <20190719063455.27328-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719063455.27328-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 19, 2019 at 08:34:55AM +0200, Juri Lelli wrote:
> On !CONFIG_RT_GROUP_SCHED configurations it is currently not possible to
> move RT tasks between cgroups to which cpu controller has been attached;
> but it is oddly possible to first move tasks around and then make them
> RT (setschedule to FIFO/RR).
> 
> E.g.:
> 
>   # mkdir /sys/fs/cgroup/cpu,cpuacct/group1
>   # chrt -fp 10 $$
>   # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   bash: echo: write error: Invalid argument
>   # chrt -op 0 $$
>   # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   # chrt -fp 10 $$
>   # cat /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   2345
>   2598
>   # chrt -p 2345
>   pid 2345's current scheduling policy: SCHED_FIFO
>   pid 2345's current scheduling priority: 10
> 
> Also, as Michal noted, it is currently not possible to enable cpu
> controller on unified hierarchy with !CONFIG_RT_GROUP_SCHED (if there
> are any kernel RT threads in root cgroup, they can't be migrated to the
> newly created cpu controller's root in cgroup_update_dfl_csses()).
> 
> Existing code comes with a comment saying the "we don't support RT-tasks
> being in separate groups". Such comment is however stale and belongs to
> pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
> !RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
> are not performed at all in these cases.
> 
> Make moving RT tasks between cpu controller groups viable by removing
> special case check for RT (and DEADLINE) tasks.

I have very vague memories of there being a matching test in
sched_setscheduler(), but clearly that's no longer there.

Thanks!

> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
> v1 -> v2: added comment about unified hierachy in changelog (Michal)
>           collected acks/reviews
> ---
>  kernel/sched/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fa43ce3962e7..be041dc7d313 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6934,10 +6934,6 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>  #ifdef CONFIG_RT_GROUP_SCHED
>  		if (!sched_rt_can_attach(css_tg(css), task))
>  			return -EINVAL;
> -#else
> -		/* We don't support RT-tasks being in separate groups */
> -		if (task->sched_class != &fair_sched_class)
> -			return -EINVAL;
>  #endif
>  		/*
>  		 * Serialize against wake_up_new_task() such that if its
> -- 
> 2.17.2
> 
