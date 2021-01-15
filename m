Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4252F7E5E
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhAOOhY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 09:37:24 -0500
Received: from foss.arm.com ([217.140.110.172]:41974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbhAOOhX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 Jan 2021 09:37:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9254ED1;
        Fri, 15 Jan 2021 06:36:37 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B801B3F70D;
        Fri, 15 Jan 2021 06:36:34 -0800 (PST)
Subject: Re: [PATCH 6/6] sched/deadline: Fixes cpu/rd/dl_bw references for
 suspended tasks
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
References: <cover.1610463999.git.bristot@redhat.com>
 <8c1cb0c850e2f3ab1d7a533aa4b33a30f9dbeda5.1610463999.git.bristot@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <97875017-a6bb-98ea-83f9-82e95db58aca@arm.com>
Date:   Fri, 15 Jan 2021 15:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8c1cb0c850e2f3ab1d7a533aa4b33a30f9dbeda5.1610463999.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/01/2021 16:53, Daniel Bristot de Oliveira wrote:

[...]

> ----- %< -----
>   #!/bin/bash
>   # Enter on the cgroup directory
>   cd /sys/fs/cgroup/
> 
>   # Check it if is cgroup v2 and enable cpuset
>   if [ -e cgroup.subtree_control ]; then
>   	# Enable cpuset controller on cgroup v2
>   	echo +cpuset > cgroup.subtree_control
>   fi
> 
>   echo LOG: create an exclusive cpuset and assigned the CPU 0 to it
>   # Create cpuset groups
>   rmdir dl-group &> /dev/null
>   mkdir dl-group
> 
>   # Restrict the task to the CPU 0
>   echo 0 > dl-group/cpuset.mems
>   echo 0 > dl-group/cpuset.cpus
>   echo root >  dl-group/cpuset.cpus.partition
> 
>   echo LOG: dispatching a regular task
>   sleep 100 &
>   CPUSET_PID="$!"
> 
>   # let it settle down
>   sleep 1
> 
>   # Assign the second task to the cgroup

There is only one task 'CPUSET_PID' involved here?

>   echo LOG: moving the second DL task to the cpuset
>   echo "$CPUSET_PID" > dl-group/cgroup.procs 2> /dev/null
> 
>   CPUSET_ALLOWED=`cat /proc/$CPUSET_PID/status | grep Cpus_allowed_list | awk '{print $2}'`
> 
>   chrt -p -d --sched-period 1000000000 --sched-runtime 100000000 0 $CPUSET_PID
>   ACCEPTED=$?
> 
>   if [ $ACCEPTED == 0 ]; then
>   	echo PASS: the task became DL
>   else
>   	echo FAIL: the task was rejected as DL
>   fi

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5961a97541c2..3c2775e6869f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5905,15 +5905,15 @@ static int __sched_setscheduler(struct task_struct *p,
>  #ifdef CONFIG_SMP
>  		if (dl_bandwidth_enabled() && dl_policy(policy) &&
>  				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
> -			cpumask_t *span = rq->rd->span;
> +			struct root_domain *rd = dl_task_rd(p);
>  
>  			/*
>  			 * Don't allow tasks with an affinity mask smaller than
>  			 * the entire root_domain to become SCHED_DEADLINE. We
>  			 * will also fail if there's no bandwidth available.
>  			 */
> -			if (!cpumask_subset(span, p->cpus_ptr) ||
> -			    rq->rd->dl_bw.bw == 0) {
> +			if (!cpumask_subset(rd->span, p->cpus_ptr) ||
> +			    rd->dl_bw.bw == 0) {
>  				retval = -EPERM;
>  				goto unlock;
>  			}
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c221e14d5b86..1f6264cb8867 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2678,8 +2678,8 @@ int sched_dl_overflow(struct task_struct *p, int policy,
>  	u64 period = attr->sched_period ?: attr->sched_deadline;
>  	u64 runtime = attr->sched_runtime;
>  	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
> -	int cpus, err = -1, cpu = task_cpu(p);
> -	struct dl_bw *dl_b = dl_bw_of(cpu);
> +	int cpus, err = -1, cpu = dl_task_cpu(p);
> +	struct dl_bw *dl_b = dl_task_root_bw(p);
>  	unsigned long cap;
>  
>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
> 

Wouldn't it be sufficient to just introduce dl_task_cpu() and use the
correct cpu to get rd->span or struct dl_bw in __sched_setscheduler()
-> sched_dl_overflow()?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5961a97541c2..0573f676696a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5905,7 +5905,8 @@ static int __sched_setscheduler(struct task_struct *p,
 #ifdef CONFIG_SMP
                if (dl_bandwidth_enabled() && dl_policy(policy) &&
                                !(attr->sched_flags & SCHED_FLAG_SUGOV)) {
-                       cpumask_t *span = rq->rd->span;
+                       int cpu = dl_task_cpu(p);
+                       cpumask_t *span = cpu_rq(cpu)->rd->span;
 
                        /*
                         * Don't allow tasks with an affinity mask smaller than
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c221e14d5b86..308ecaaf3d28 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2678,7 +2678,7 @@ int sched_dl_overflow(struct task_struct *p, int policy,
        u64 period = attr->sched_period ?: attr->sched_deadline;
        u64 runtime = attr->sched_runtime;
        u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
-       int cpus, err = -1, cpu = task_cpu(p);
+       int cpus, err = -1, cpu = dl_task_cpu(p);
        struct dl_bw *dl_b = dl_bw_of(cpu);
        unsigned long cap;
