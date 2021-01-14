Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795B2F653C
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhANPwe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 10:52:34 -0500
Received: from foss.arm.com ([217.140.110.172]:51986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbhANPwe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Jan 2021 10:52:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B437ED1;
        Thu, 14 Jan 2021 07:51:48 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 521A03F70D;
        Thu, 14 Jan 2021 07:51:45 -0800 (PST)
Subject: Re: [PATCH 4/6] sched/deadline: Block DL tasks on non-exclusive
 cpuset if bandwitdh control is enable
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
 <7b336c37cc3c38def6de181df8ba8c3148c5cc0c.1610463999.git.bristot@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4b37b32b-0e16-ffbc-ca6a-fbee935c0813@arm.com>
Date:   Thu, 14 Jan 2021 16:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b336c37cc3c38def6de181df8ba8c3148c5cc0c.1610463999.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/01/2021 16:53, Daniel Bristot de Oliveira wrote:
> The current SCHED_DEADLINE design supports only global scheduler,
> or variants of it, i.e., clustered and partitioned, via cpuset config.
> To enable the partitioning of a system with clusters of CPUs, the
> documentation advises the usage of exclusive cpusets, creating an
> exclusive root_domain for the cpuset.
> 
> Attempts to change the cpu affinity of a thread to a cpu mask different
> from the root domain results in an error. For instance:

[...]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 788a391657a5..c221e14d5b86 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2878,6 +2878,13 @@ int dl_task_can_attach(struct task_struct *p,
>  	if (cpumask_empty(cs_cpus_allowed))
>  		return 0;
>  
> +	/*
> +	 * Do not allow moving tasks to non-exclusive cpusets
> +	 * if bandwidth control is enabled.
> +	 */
> +	if (dl_bandwidth_enabled() && !exclusive)
> +		return -EBUSY;
> +
>  	/*
>  	 * The task is not moving to another root domain, so it is
>  	 * already accounted.
> 

But doesn't this mean you only have to set this cgroup exclusive/root to
run into the same issue:

with this patch:

cgroupv1:

root@juno:/sys/fs/cgroup/cpuset# chrt -d --sched-period 1000000000
--sched-runtime 100000000 0 sleep 500 &
[1] 1668
root@juno:/sys/fs/cgroup/cpuset# PID1=$!

root@juno:/sys/fs/cgroup/cpuset# chrt -d --sched-period 1000000000
--sched-runtime 100000000 0 sleep 500 &
[2] 1669
root@juno:/sys/fs/cgroup/cpuset# PID2=$!

root@juno:/sys/fs/cgroup/cpuset# mkdir A

root@juno:/sys/fs/cgroup/cpuset# echo 0 > ./A/cpuset.mems
root@juno:/sys/fs/cgroup/cpuset# echo 0 > ./A/cpuset.cpus

root@juno:/sys/fs/cgroup/cpuset# echo $PID2 > ./A/cgroup.procs
-bash: echo: write error: Device or resource busy

root@juno:/sys/fs/cgroup/cpuset# echo 1 > ./A/cpuset.cpu_exclusive

root@juno:/sys/fs/cgroup/cpuset# echo $PID2 > ./A/cgroup.procs

root@juno:/sys/fs/cgroup/cpuset# cat /proc/$PID1/status | grep
Cpus_allowed_list | awk '{print $2}'
0-5
root@juno:/sys/fs/cgroup/cpuset# cat /proc/$PID2/status | grep
Cpus_allowed_list | awk '{print $2}'
0

cgroupv2:

root@juno:/sys/fs/cgroup# echo +cpuset > cgroup.subtree_control

root@juno:/sys/fs/cgroup# chrt -d --sched-period 1000000000
--sched-runtime 100000000 0 sleep 500 &
[1] 1687
root@juno:/sys/fs/cgroup# PID1=$!

root@juno:/sys/fs/cgroup# chrt -d --sched-period 1000000000
--sched-runtime 100000000 0 sleep 500 &
[2] 1688
root@juno:/sys/fs/cgroup# PID2=$!

root@juno:/sys/fs/cgroup# mkdir A

root@juno:/sys/fs/cgroup# echo 0 > ./A/cpuset.mems
root@juno:/sys/fs/cgroup# echo 0 > ./A/cpuset.cpus

root@juno:/sys/fs/cgroup# echo $PID2 > ./A/cgroup.procs
-bash: echo: write error: Device or resource busy

root@juno:/sys/fs/cgroup# echo root > ./A/cpuset.cpus.partition

root@juno:/sys/fs/cgroup# echo $PID2 > ./A/cgroup.procs

root@juno:/sys/fs/cgroup# cat /proc/$PID1/status | grep
Cpus_allowed_list | awk '{print $2}'
0-5
root@juno:/sys/fs/cgroup# cat /proc/$PID2/status | grep
Cpus_allowed_list | awk '{print $2}'
0
