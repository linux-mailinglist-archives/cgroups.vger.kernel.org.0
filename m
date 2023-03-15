Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C76BB67B
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCOOtk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 10:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjCOOte (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 10:49:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800BEB42
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 07:49:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so2159225wms.0
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1678891770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDMF/9Jk1Ma//xyCPXZ0qcrhqF6+x2N5EgrMZjwbDtI=;
        b=blOAgwk5isbC6BMGXRH31cyaygGh3ZX2UwPp/2h+oSnCkdRkVPsEEzk5uiDt3b9R0B
         OFJsxYV1t22+fE0rbMSmmVOJIEw/K4VbbRnBfQitsZg/mue8xZp3ocHdDEXQ0/Qafz4t
         xqWr+x5sX6Q9UmhHwswAYPcSxwWZmPo3wQQ+tsz9LngznP1yfmHY9BrpDoqzd3Du+2xf
         /crzOqW8FQTYcX3kJXzXzw4Vlhly6AwVuXnIQfWtAl93XF2ADLFEObBqMqkuyk8mo/yR
         TYSwEJTXceaHn43z4ScbCODJSFdYfo+erf0M47AbYbCztISEMbHSZNambWkixXzpDwmh
         OMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDMF/9Jk1Ma//xyCPXZ0qcrhqF6+x2N5EgrMZjwbDtI=;
        b=6pUNYHivdzFJ6SXW8IbyEdEeATOMGSY1fuXG7xyiC4bwoZ82PhwhxBBxAbOGlY4O4I
         J8MuPQaOJ03Yy4Vae66rOtiaeJemJPu3QoQIDJTuhZU1SBttUf+j2Xig+MCAPlR7L+X2
         S0NAT14ws2tbDiBXsvF+tErkeN225ymYgnEOWavq7ALlXWU8+gYcmtPq4dzEnPz555Ci
         G1SiRmxb013ljQ2uADZQsIgomL8PfWqL40/0iWSMKXKRJn4Dl3gwxsSRdzrbGzunDpLN
         hNN49I7fpt5kgRURVt606nZl46nN4G5soDDBo2IjPRmBOmIJr716FuC7/1hZJHkWs9yj
         6PAw==
X-Gm-Message-State: AO0yUKVZ3jKkNGzfoFMlDPJl0rytSbmxlAAZm2L//L0AHyFL9Kno22Rb
        +6Z0d5yF0Lc4mLnboZktOYHj0Q==
X-Google-Smtp-Source: AK7set8yh7EPUWvcwlsc+RuEBHXyD/aW6OMeVcr/+X2341eatiOAFb5k+Cx2kZXcOkEz1FF36JdFLQ==
X-Received: by 2002:a05:600c:35ce:b0:3eb:2b88:9adc with SMTP id r14-20020a05600c35ce00b003eb2b889adcmr18836483wmq.25.1678891770300;
        Wed, 15 Mar 2023 07:49:30 -0700 (PDT)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b003dc4480df80sm2007514wmj.34.2023.03.15.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:49:29 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:49:27 +0000
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
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Message-ID: <20230315144927.624cbwc3yep3fwor@airbuntu>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315121812.206079-3-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315121812.206079-3-juri.lelli@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/15/23 12:18, Juri Lelli wrote:
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
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  include/linux/cpuset.h |  4 ++++
>  kernel/cgroup/cgroup.c |  4 ++++
>  kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
>  kernel/sched/core.c    | 10 ++++++++++
>  4 files changed, 43 insertions(+)
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
> index c099cf3fa02d..357925e1e4af 100644
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
> index 8d82d66d432b..57bc60112618 100644
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

nit:

I *think* task_cs() assumes rcu_read_lock() is held, right?

Would it make sense to WARN_ON(!rcu_read_lock_held()) to at least
annotate the deps?

Or maybe task_cs() should do that..

> +
> +	cs->nr_deadline_tasks++;
> +}
> +
> +void dec_dl_tasks_cs(struct task_struct *p)
> +{
> +	struct cpuset *cs = task_cs(p);

nit: ditto

> +
> +	cs->nr_deadline_tasks--;
> +}
> +
>  /* bits in struct cpuset flags field */
>  typedef enum {
>  	CS_ONLINE,
> @@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5902cbb5e751..d586a8440348 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7683,6 +7683,16 @@ static int __sched_setscheduler(struct task_struct *p,
>  		goto unlock;
>  	}
>  
> +	/*
> +	 * In case a task is setscheduled to SCHED_DEADLINE, or if a task is
> +	 * moved to a different sched policy, we need to keep track of that on
> +	 * its cpuset (for correct bandwidth tracking).
> +	 */
> +	if (dl_policy(policy) && !dl_task(p))
> +		inc_dl_tasks_cs(p);
> +	else if (dl_task(p) && !dl_policy(policy))
> +		dec_dl_tasks_cs(p);
> +

Would it be better to use switched_to_dl()/switched_from_dl() instead to
inc/dec_dl_tasks_cs()?


Thanks!

--
Qais Yousef

>  	p->sched_reset_on_fork = reset_on_fork;
>  	oldprio = p->prio;
>  
> -- 
> 2.39.2
> 
