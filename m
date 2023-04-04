Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA06D6D93
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjDDUGN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 16:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjDDUGK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 16:06:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E64C06
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 13:06:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so34034445wra.9
        for <cgroups@vger.kernel.org>; Tue, 04 Apr 2023 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680638763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzcIcdfK6v6WZlW481z/oaOzg6K9dkiqV3VlSKeaQxk=;
        b=dOr7Zq8PSNVIa43CVrIIl7DPYIkM2Hj1+TqDDbU/S3cBOJEMJy2M31X53CLptqz3Q9
         LgsoDnQOo5KapDOVeMmqkWxn2fCGJ3H7SG0yWveDmyJ/0W4wv3jdzWtjAVbBt6H91xed
         7dydChFL/a0cs3yf/oZTxHg1pQhrP9wtXoCkmtxIQ3qEhpwt+Eu0UdePh0QxIFae36Xa
         MHIvFEVshrFIFEez+s+4X7ed0mANRSoQ6FU1NFvXaIIQoDSFvBVmh3JH0LXpzHDLLR7R
         WBBX3GkbIvmHN9DX1qq9ETPnn9EzHgMqYPu4CSpcnA/O3siN+XkECtOs9xt5ckNHtLuu
         sjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzcIcdfK6v6WZlW481z/oaOzg6K9dkiqV3VlSKeaQxk=;
        b=qyAGKUlyDd0ymtt/iTfz+sCXu1n3mrzZOM+dk9lI1uUKUQ+MFnygT1T9eARcH1z1zz
         PLI6EdIFqck7I0S71EtpfLmtjptISZCttRWoBg9GZ9BKeEPA9i+ycVA9/RePvoDWIegG
         klugG2BELpn0pbhmFpVuTWXOZiTJgegf2uMVYBqNMGpiNOPo7UTsexTYH4xSW4nb+gYE
         V2ThOH3mpR4z9wT3kgq9SQNycmbLvED4K1McNzQtThTm7ojXMkBjObyxy6iZH8aG5uJ8
         /FcHCcnESQaEp/y3wbMTwQvt/ufhp4DYVOU73dLMGatmRK01L7f8lC8GnefciwHahbuo
         fNRA==
X-Gm-Message-State: AAQBX9fo59nk8ZndPcbWsK2S4QRP4HfoJ5+G+Z+jQz9PXYpjBQF3JZE/
        T4Dk8Fh2T1onWkc+owRnghGFAQ==
X-Google-Smtp-Source: AKy350a28fGlLed1Z6zmOYi/tYfpj56FvFwy3/xVLIm1F3h1Iwas1jONOsQKZYKnjhTCpG2+9ayZWw==
X-Received: by 2002:a05:6000:1292:b0:2cf:efad:9c1f with SMTP id f18-20020a056000129200b002cfefad9c1fmr2270129wrx.46.1680638763359;
        Tue, 04 Apr 2023 13:06:03 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe8cc000000b002c7b229b1basm13054297wrn.15.2023.04.04.13.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:06:02 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:06:01 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH 3/6] sched/cpuset: Keep track of SCHED_DEADLINE task in
 cpusets
Message-ID: <20230404200601.vjsju6iayisy7gjt@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-4-juri.lelli@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
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

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

>  include/linux/cpuset.h  |  4 ++++
>  kernel/cgroup/cgroup.c  |  4 ++++
>  kernel/cgroup/cpuset.c  | 25 +++++++++++++++++++++++++
>  kernel/sched/deadline.c | 14 ++++++++++++++
>  4 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 355f796c5f07..0348dba5680e 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -71,6 +71,8 @@ extern void cpuset_init_smp(void);
>  extern void cpuset_force_rebuild(void);
>  extern void cpuset_update_active_cpus(void);
>  extern void cpuset_wait_for_hotplug(void);
> +extern void inc_dl_tasks_cs(struct task_struct *task);
> +extern void dec_dl_tasks_cs(struct task_struct *task);
>  extern void cpuset_lock(void);
>  extern void cpuset_unlock(void);
>  extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
> @@ -196,6 +198,8 @@ static inline void cpuset_update_active_cpus(void)
>  
>  static inline void cpuset_wait_for_hotplug(void) { }
>  
> +static inline void inc_dl_tasks_cs(struct task_struct *task) { }
> +static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>  static inline void cpuset_lock(void) { }
>  static inline void cpuset_unlock(void) { }
>  
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 935e8121b21e..ff27b2d2bf0b 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -57,6 +57,7 @@
>  #include <linux/file.h>
>  #include <linux/fs_parser.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/sched/deadline.h>
>  #include <linux/psi.h>
>  #include <net/sock.h>
>  
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
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fbc10b494292..eb0854ef9757 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -193,6 +193,12 @@ struct cpuset {
>  	int use_parent_ecpus;
>  	int child_ecpus_count;
>  
> +	/*
> +	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
> +	 * know when to rebuild associated root domain bandwidth information.
> +	 */
> +	int nr_deadline_tasks;
> +
>  	/* Invalid partition error code, not lock protected */
>  	enum prs_errcode prs_err;
>  
> @@ -245,6 +251,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>  	return css_cs(cs->css.parent);
>  }
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
>  /* bits in struct cpuset flags field */
>  typedef enum {
>  	CS_ONLINE,
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
>  
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
> -- 
> 2.39.2
> 
