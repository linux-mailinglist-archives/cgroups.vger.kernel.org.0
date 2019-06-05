Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B4E354EA
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 03:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFEBPh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jun 2019 21:15:37 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36109 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfFEBPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jun 2019 21:15:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TTSDNmF_1559697333;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTSDNmF_1559697333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jun 2019 09:15:34 +0800
Subject: Re: [RFC PATCH 2/3] psi: cgroup v1 support
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>
References: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
 <20190604015745.78972-3-joseph.qi@linux.alibaba.com>
 <20190604115519.GA18545@cmpxchg.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <7c9e6755-5996-5d96-c0d7-fd3d00d59a8a@linux.alibaba.com>
Date:   Wed, 5 Jun 2019 09:15:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604115519.GA18545@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes,

Thanks for the quick comments.

On 19/6/4 19:55, Johannes Weiner wrote:
> On Tue, Jun 04, 2019 at 09:57:44AM +0800, Joseph Qi wrote:
>> Implements pressure stall tracking for cgroup v1.
>>
>> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>> ---
>>  kernel/sched/psi.c | 65 +++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 56 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 7acc632c3b82..909083c828d5 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -719,13 +719,30 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
>>  	return state_mask;
>>  }
>>  
>> -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>> +static struct cgroup *psi_task_cgroup(struct task_struct *task, enum psi_res res)
>> +{
>> +	switch (res) {
>> +	case NR_PSI_RESOURCES:
>> +		return task_dfl_cgroup(task);
>> +	case PSI_IO:
>> +		return task_cgroup(task, io_cgrp_subsys.id);
>> +	case PSI_MEM:
>> +		return task_cgroup(task, memory_cgrp_subsys.id);
>> +	case PSI_CPU:
>> +		return task_cgroup(task, cpu_cgrp_subsys.id);
>> +	default:  /* won't reach here */
>> +		return NULL;
>> +	}
>> +}
>> +
>> +static struct psi_group *iterate_groups(struct task_struct *task, void **iter,
>> +					enum psi_res res)
>>  {
>>  #ifdef CONFIG_CGROUPS
>>  	struct cgroup *cgroup = NULL;
>>  
>>  	if (!*iter)
>> -		cgroup = task->cgroups->dfl_cgrp;
>> +		cgroup = psi_task_cgroup(task, res);
>>  	else if (*iter == &psi_system)
>>  		return NULL;
>>  	else
>> @@ -776,15 +793,45 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>>  		     wq_worker_last_func(task) == psi_avgs_work))
>>  		wake_clock = false;
>>  
>> -	while ((group = iterate_groups(task, &iter))) {
>> -		u32 state_mask = psi_group_change(group, cpu, clear, set);
>> +	if (cgroup_subsys_on_dfl(cpu_cgrp_subsys) ||
>> +	    cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
>> +	    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
>> +		while ((group = iterate_groups(task, &iter, NR_PSI_RESOURCES))) {
>> +			u32 state_mask = psi_group_change(group, cpu, clear, set);
>>  
>> -		if (state_mask & group->poll_states)
>> -			psi_schedule_poll_work(group, 1);
>> +			if (state_mask & group->poll_states)
>> +				psi_schedule_poll_work(group, 1);
>>  
>> -		if (wake_clock && !delayed_work_pending(&group->avgs_work))
>> -			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
>> +			if (wake_clock && !delayed_work_pending(&group->avgs_work))
>> +				schedule_delayed_work(&group->avgs_work, PSI_FREQ);
>> +		}
>> +	} else {
>> +		enum psi_task_count i;
>> +		enum psi_res res;
>> +		int psi_flags = clear | set;
>> +
>> +		for (i = NR_IOWAIT; i < NR_PSI_TASK_COUNTS; i++) {
>> +			if ((i == NR_IOWAIT) && (psi_flags & TSK_IOWAIT))
>> +				res = PSI_IO;
>> +			else if ((i == NR_MEMSTALL) && (psi_flags & TSK_MEMSTALL))
>> +				res = PSI_MEM;
>> +			else if ((i == NR_RUNNING) && (psi_flags & TSK_RUNNING))
>> +				res = PSI_CPU;
>> +			else
>> +				continue;
>> +
>> +			while ((group = iterate_groups(task, &iter, res))) {
>> +				u32 state_mask = psi_group_change(group, cpu, clear, set);
> 
> This doesn't work. Each resource state is composed of all possible
> task states:
> 
> static bool test_state(unsigned int *tasks, enum psi_states state)
> {
> 	switch (state) {
> 	case PSI_IO_SOME:
> 		return tasks[NR_IOWAIT];
> 	case PSI_IO_FULL:
> 		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
> 	case PSI_MEM_SOME:
> 		return tasks[NR_MEMSTALL];
> 	case PSI_MEM_FULL:
> 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
> 	case PSI_CPU_SOME:
> 		return tasks[NR_RUNNING] > 1;
> 	case PSI_NONIDLE:
> 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
> 			tasks[NR_RUNNING];
> 	default:
> 		return false;
> 	}
> }
> 
> So the IO controller needs to know of NR_RUNNING to tell some vs full,
> the memory controller needs to know of NR_IOWAIT to tell nonidle etc.
> 
> You need to run the full psi task tracking and aggregation machinery
> separately for each of the different cgroups a task can be in in v1.
> 
Yes, since different controllers have their own hierarchy.

> Needless to say, that is expensive. For cpu, memory and io, it's
> triple the scheduling overhead with three ancestor walks and three
> times the cache footprint; three times more aggregation workers every
> two seconds... We could never turn this on per default.
> 
IC, but even on cgroup v2, would it still be expensive if we have many
cgroups?

> Have you considered just co-mounting cgroup2, if for nothing else, to
> get the pressure numbers?
> 
Do you mean mounting cgroup1 and cgroup2 at the same time? 
IIUC, this may not work since many cgroup code have xxx_on_dfl check.

Thanks,
Joseph
