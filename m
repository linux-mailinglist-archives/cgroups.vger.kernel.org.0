Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2D7BDA33
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjJILn2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJILn1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 07:43:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60A94;
        Mon,  9 Oct 2023 04:43:25 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S3xtW3VqjzrTLF;
        Mon,  9 Oct 2023 19:40:51 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 19:43:22 +0800
Message-ID: <30b0db6f-5f5c-aaa4-7d69-a1b49ee0a501@huawei.com>
Date:   Mon, 9 Oct 2023 19:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/6] sched/cpuset: Keep track of SCHED_DEADLINE task in
 cpusets
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <luca.abeni@santannapisa.it>,
        <claudio@evidence.eu.com>, <tommaso.cucinotta@santannapisa.it>,
        <bristot@redhat.com>, <mathieu.poirier@linaro.org>,
        <cgroups@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-4-juri.lelli@redhat.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <20230329125558.255239-4-juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/3/29 20:55, Juri Lelli wrote:

> To fix the problem keep track of the number of DEADLINE tasks belonging
> to each cpuset and then use this information (followup patch) to only
> perform the above iteration if DEADLINE tasks are actually present in
> the cpuset for which a corresponding root domain is being rebuilt.
>  
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 935e8121b21e..ff27b2d2bf0b 100644

> @@ -6673,6 +6674,9 @@ void cgroup_exit(struct task_struct *tsk)
>  	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>  	cset->nr_tasks--;
>  
> +	if (dl_task(tsk))
> +		dec_dl_tasks_cs(tsk);
> +
>  	WARN_ON_ONCE(cgroup_task_frozen(tsk));
>  	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
>  		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))


The cgroup_exit() function decrements the value of the nr_deadline_tasks by one.


> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fbc10b494292..eb0854ef9757 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -193,6 +193,12 @@ struct cpuset {
> +	/*
> +	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
> +	 * know when to rebuild associated root domain bandwidth information.
> +	 */
> +	int nr_deadline_tasks;
> +

> +void inc_dl_tasks_cs(struct task_struct *p)
> +{
> +	struct cpuset *cs = task_cs(p);
> +
> +	cs->nr_deadline_tasks++;
> +}
> +
> +void dec_dl_tasks_cs(struct task_struct *p)
> +{
> +	struct cpuset *cs = task_cs(p);
> +
> +	cs->nr_deadline_tasks--;
> +}
> +

> @@ -2477,6 +2497,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  		ret = security_task_setscheduler(task);
>  		if (ret)
>  			goto out_unlock;
> +
> +		if (dl_task(task)) {
> +			cs->nr_deadline_tasks++;
> +			cpuset_attach_old_cs->nr_deadline_tasks--;
> +		}
>  	}


The cpuset_can_attach() function increments the value of the nr_deadline_tasks by one.


>  	/*
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4cc7e1ca066d..8f92f0f87383 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -16,6 +16,8 @@
>   *                    Fabio Checconi <fchecconi@gmail.com>
>   */
>  
> +#include <linux/cpuset.h>
> +
>  /*
>   * Default limits for DL period; on the top end we guard against small util
>   * tasks still getting ridiculously long effective runtimes, on the bottom end we
> @@ -2595,6 +2597,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(p);
>  
> +	/*
> +	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
> +	 * keep track of that on its cpuset (for correct bandwidth tracking).
> +	 */
> +	dec_dl_tasks_cs(p);
> +
>  	if (!task_on_rq_queued(p)) {
>  		/*
>  		 * Inactive timer is armed. However, p is leaving DEADLINE and
> @@ -2635,6 +2643,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
>  		put_task_struct(p);
>  
> +	/*
> +	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
> +	 * track of that on its cpuset (for correct bandwidth tracking).
> +	 */
> +	inc_dl_tasks_cs(p);
> +
>  	/* If p is not queued we will update its parameters at next wakeup. */
>  	if (!task_on_rq_queued(p)) {
>  		add_rq_bw(&p->dl, &rq->dl);


And both switched_from_dl() and switched_to_dl() can change the value of
nr_deadline_tasks.

I suspect that changing the values of the nr_deadline_tasks in these
4 paths will cause data race problems.

And this patch([PATCH 6/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present)
has the following judgment:

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f8ebec66da51..05c0a1255218 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1092,6 +1092,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;

+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);

 	while ((task = css_task_iter_next(&it)))
--


The uncertainty of nr_deadline_tasks can lead to logical problems.

May I ask what experts think of the Data Race problem?

I would like to inquire if there is a problem and if so, is it
necessary to use atomic operations to avoid it?

Thank you all.
