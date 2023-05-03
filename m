Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2E6F5D61
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 19:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjECR5K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjECR5J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 13:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088C3C01
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683136575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQpEwS4JBjiBUmzDrp0hg9pwaawUbOZgQLeijVoHEYM=;
        b=JS3Jx/cp/pUCfR5irtpd1jY15FTzZaTxwc1DrZ/O1Vm5IdGNEI+4YcsKUlSmcLvDDTYSy0
        hZiVVR/oZIuPEKISXmvr3i0+wzogdRuOBrMxZUep/6EalIVzUOuOETheM+TjHdQfJnSyGd
        JwTnWXD2DIBzbV6fmHnHsAmMFDrNWno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-NHidxL8xOX2KWq5WVmBCBw-1; Wed, 03 May 2023 13:56:12 -0400
X-MC-Unique: NHidxL8xOX2KWq5WVmBCBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA53185A79C;
        Wed,  3 May 2023 17:56:11 +0000 (UTC)
Received: from [10.22.17.228] (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA7B34020961;
        Wed,  3 May 2023 17:56:09 +0000 (UTC)
Message-ID: <09fc4561-5ea9-8b5f-a784-37f578f152af@redhat.com>
Date:   Wed, 3 May 2023 13:56:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/6] sched/cpuset: Keep track of SCHED_DEADLINE task in
 cpusets
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
 <20230503072228.115707-4-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230503072228.115707-4-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/3/23 03:22, Juri Lelli wrote:
> Qais reported that iterating over all tasks when rebuilding root domains
> for finding out which ones are DEADLINE and need their bandwidth
> correctly restored on such root domains can be a costly operation (10+
> ms delays on suspend-resume).
>
> To fix the problem keep track of the number of DEADLINE tasks belonging
> to each cpuset and then use this information (followup patch) to only
> perform the above iteration if DEADLINE tasks are actually present in
> the cpuset for which a corresponding root domain is being rebuilt.
>
> Reported-by: Qais Yousef <qyousef@layalina.io>
> Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/cpuset.h  |  4 ++++
>   kernel/cgroup/cgroup.c  |  4 ++++
>   kernel/cgroup/cpuset.c  | 25 +++++++++++++++++++++++++
>   kernel/sched/deadline.c | 14 ++++++++++++++
>   4 files changed, 47 insertions(+)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index f90e6325d707..d629094fac6e 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -71,6 +71,8 @@ extern void cpuset_init_smp(void);
>   extern void cpuset_force_rebuild(void);
>   extern void cpuset_update_active_cpus(void);
>   extern void cpuset_wait_for_hotplug(void);
> +extern void inc_dl_tasks_cs(struct task_struct *task);
> +extern void dec_dl_tasks_cs(struct task_struct *task);
>   extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
> @@ -189,6 +191,8 @@ static inline void cpuset_update_active_cpus(void)
>   
>   static inline void cpuset_wait_for_hotplug(void) { }
>   
> +static inline void inc_dl_tasks_cs(struct task_struct *task) { }
> +static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>   static inline void cpuset_lock(void) { }
>   static inline void cpuset_unlock(void) { }
>   
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..9d809191a54f 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -57,6 +57,7 @@
>   #include <linux/file.h>
>   #include <linux/fs_parser.h>
>   #include <linux/sched/cputime.h>
> +#include <linux/sched/deadline.h>
>   #include <linux/psi.h>
>   #include <net/sock.h>
>   
> @@ -6683,6 +6684,9 @@ void cgroup_exit(struct task_struct *tsk)
>   	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>   	cset->nr_tasks--;
>   
> +	if (dl_task(tsk))
> +		dec_dl_tasks_cs(tsk);
> +
>   	WARN_ON_ONCE(cgroup_task_frozen(tsk));
>   	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
>   		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ee66be215fb9..b9f4d5602517 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -193,6 +193,12 @@ struct cpuset {
>   	int use_parent_ecpus;
>   	int child_ecpus_count;
>   
> +	/*
> +	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
> +	 * know when to rebuild associated root domain bandwidth information.
> +	 */
> +	int nr_deadline_tasks;
> +
>   	/* Invalid partition error code, not lock protected */
>   	enum prs_errcode prs_err;
>   
> @@ -245,6 +251,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>   	return css_cs(cs->css.parent);
>   }
>   
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
>   /* bits in struct cpuset flags field */
>   typedef enum {
>   	CS_ONLINE,
> @@ -2497,6 +2517,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		ret = security_task_setscheduler(task);
>   		if (ret)
>   			goto out_unlock;
> +
> +		if (dl_task(task)) {
> +			cs->nr_deadline_tasks++;
> +			cpuset_attach_old_cs->nr_deadline_tasks--;
> +		}
>   	}
>   
>   	/*
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5a9a4b81c972..e11de074a6fd 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -16,6 +16,8 @@
>    *                    Fabio Checconi <fchecconi@gmail.com>
>    */
>   
> +#include <linux/cpuset.h>
> +
>   /*
>    * Default limits for DL period; on the top end we guard against small util
>    * tasks still getting ridiculously long effective runtimes, on the bottom end we
> @@ -2596,6 +2598,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>   	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>   		task_non_contending(p);
>   
> +	/*
> +	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
> +	 * keep track of that on its cpuset (for correct bandwidth tracking).
> +	 */
> +	dec_dl_tasks_cs(p);
> +
>   	if (!task_on_rq_queued(p)) {
>   		/*
>   		 * Inactive timer is armed. However, p is leaving DEADLINE and
> @@ -2636,6 +2644,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>   	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
>   		put_task_struct(p);
>   
> +	/*
> +	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
> +	 * track of that on its cpuset (for correct bandwidth tracking).
> +	 */
> +	inc_dl_tasks_cs(p);
> +
>   	/* If p is not queued we will update its parameters at next wakeup. */
>   	if (!task_on_rq_queued(p)) {
>   		add_rq_bw(&p->dl, &rq->dl);
Reviewed-by: Waiman Long <longman@redhat.com>

