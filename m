Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35E16F5D6C
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjECSDS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjECSDR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 14:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F5226A0
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683136949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCYSyO5l+BDD42iHkGOCdzOGv+hBfShQp7EjGzaqPjk=;
        b=IAmnunuKjkaaSY31wxq2i6GZ5Nw4Uw3D0q9t/bciqeza6GH2OEkYk8rQTaxMNJBB5e+6e2
        gvVRjlA1l7+Ax8MsLlgVPCI7LnfCwNRF8fceiL091a9WGA/6HpV0V1BH0ndiKlPMwMC0g+
        w9YcE7YhnRekoLwhMmG/MuMScehRWCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-txHJLkxzPOa6QVC5lBFU_A-1; Wed, 03 May 2023 14:02:09 -0400
X-MC-Unique: txHJLkxzPOa6QVC5lBFU_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4B46886463;
        Wed,  3 May 2023 18:02:07 +0000 (UTC)
Received: from [10.22.17.228] (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F71492C13;
        Wed,  3 May 2023 18:02:06 +0000 (UTC)
Message-ID: <fe1a48fe-b937-3313-cae7-fcc197dd8d65@redhat.com>
Date:   Wed, 3 May 2023 14:02:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 6/6] cgroup/cpuset: Free DL BW in case can_attach()
 fails
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-7-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230503072228.115707-7-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 5/3/23 03:22, Juri Lelli wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> cpuset_can_attach() can fail. Postpone DL BW allocation until all tasks
> have been checked. DL BW is not allocated per-task but as a sum over
> all DL tasks migrating.
>
> If multiple controllers are attached to the cgroup next to the cpuset
> controller a non-cpuset can_attach() can fail. In this case free DL BW
> in cpuset_cancel_attach().
>
> Finally, update cpuset DL task count (nr_deadline_tasks) only in
> cpuset_attach().
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched.h  |  2 +-
>   kernel/cgroup/cpuset.c | 53 ++++++++++++++++++++++++++++++++++++++----
>   kernel/sched/core.c    | 17 ++------------
>   3 files changed, 51 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0bee06542450..2553918f0b61 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1852,7 +1852,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
>   }
>   
>   extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> -extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
> +extern int task_can_attach(struct task_struct *p);
>   extern int dl_bw_alloc(int cpu, u64 dl_bw);
>   extern void dl_bw_free(int cpu, u64 dl_bw);
>   #ifdef CONFIG_SMP
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6587df42cb61..d1073603c96c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -198,6 +198,8 @@ struct cpuset {
>   	 * know when to rebuild associated root domain bandwidth information.
>   	 */
>   	int nr_deadline_tasks;
> +	int nr_migrate_dl_tasks;
> +	u64 sum_migrate_dl_bw;
>   
>   	/* Invalid partition error code, not lock protected */
>   	enum prs_errcode prs_err;
> @@ -2494,16 +2496,23 @@ static int cpuset_can_attach_check(struct cpuset *cs)
>   	return 0;
>   }
>   
> +static void reset_migrate_dl_data(struct cpuset *cs)
> +{
> +	cs->nr_migrate_dl_tasks = 0;
> +	cs->sum_migrate_dl_bw = 0;
> +}
> +
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>   {
>   	struct cgroup_subsys_state *css;
> -	struct cpuset *cs;
> +	struct cpuset *cs, *oldcs;
>   	struct task_struct *task;
>   	int ret;
>   
>   	/* used later by cpuset_attach() */
>   	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> +	oldcs = cpuset_attach_old_cs;
>   	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
> @@ -2514,7 +2523,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		goto out_unlock;
>   
>   	cgroup_taskset_for_each(task, css, tset) {
> -		ret = task_can_attach(task, cs->effective_cpus);
> +		ret = task_can_attach(task);
>   		if (ret)
>   			goto out_unlock;
>   		ret = security_task_setscheduler(task);
> @@ -2522,11 +2531,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   			goto out_unlock;
>   
>   		if (dl_task(task)) {
> -			cs->nr_deadline_tasks++;
> -			cpuset_attach_old_cs->nr_deadline_tasks--;
> +			cs->nr_migrate_dl_tasks++;
> +			cs->sum_migrate_dl_bw += task->dl.dl_bw;
>   		}
>   	}
>   
> +	if (!cs->nr_migrate_dl_tasks)
> +		goto out_success;
> +
> +	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
> +		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> +
> +		if (unlikely(cpu >= nr_cpu_ids)) {
> +			reset_migrate_dl_data(cs);
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +		if (ret) {
> +			reset_migrate_dl_data(cs);
> +			goto out_unlock;
> +		}
> +	}
> +
> +out_success:
>   	/*
>   	 * Mark attach is in progress.  This makes validate_change() fail
>   	 * changes which zero cpus/mems_allowed.
> @@ -2549,6 +2578,14 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   	cs->attach_in_progress--;
>   	if (!cs->attach_in_progress)
>   		wake_up(&cpuset_attach_wq);
> +
> +	if (cs->nr_migrate_dl_tasks) {
> +		int cpu = cpumask_any(cs->effective_cpus);
> +
> +		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
> +		reset_migrate_dl_data(cs);
> +	}
> +
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> @@ -2649,6 +2686,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   out:
>   	cs->old_mems_allowed = cpuset_attach_nodemask_to;
>   
> +	if (cs->nr_migrate_dl_tasks) {
> +		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
> +		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
> +		reset_migrate_dl_data(cs);
> +	}
> +
>   	cs->attach_in_progress--;
>   	if (!cs->attach_in_progress)
>   		wake_up(&cpuset_attach_wq);
> @@ -3328,7 +3371,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
>   	if (ret)
>   		goto out_unlock;
>   
> -	ret = task_can_attach(task, cs->effective_cpus);
> +	ret = task_can_attach(task);
>   	if (ret)
>   		goto out_unlock;
>   
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index df659892d7d5..ed0d7381b2ec 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9294,8 +9294,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>   	return ret;
>   }
>   
> -int task_can_attach(struct task_struct *p,
> -		    const struct cpumask *cs_effective_cpus)
> +int task_can_attach(struct task_struct *p)
>   {
>   	int ret = 0;
>   
> @@ -9308,21 +9307,9 @@ int task_can_attach(struct task_struct *p,
>   	 * success of set_cpus_allowed_ptr() on all attached tasks
>   	 * before cpus_mask may be changed.
>   	 */
> -	if (p->flags & PF_NO_SETAFFINITY) {
> +	if (p->flags & PF_NO_SETAFFINITY)
>   		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
> -					      cs_effective_cpus)) {
> -		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
>   
> -		if (unlikely(cpu >= nr_cpu_ids))
> -			return -EINVAL;
> -		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
> -	}
> -
> -out:
>   	return ret;
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>

