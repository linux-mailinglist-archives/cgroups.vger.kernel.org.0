Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3854596B7E
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiHQImR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiHQImQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 04:42:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424B7CB64;
        Wed, 17 Aug 2022 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yYgdD4rk7WaTZnaGm+LJxzeI5X81LuPS6wWmTiHsp/k=; b=SMNBHb93eh1hbbMFyUTr7ac5Ri
        rOPXm/wf5T9cyHmqLa9jbFWhVzbp1lHew9sjI6yKlENZnMjxhZkmR6OmzxNO/FN3FAwOpAYs/7CEN
        jpuJzw7W5Pa6zWzqSjQr91FDSMV2W+EWl3dDk7bgnUNTKZqqBB2jYa7COlsf26CrgQNySnztCbpyN
        cWKwwiSEGiQC/JqLu4b/g2xknOFSqJXuSzHEk0IiW+fGLqIDz+E9yfK7YqP48IBnTLOV4jsSfUb29
        ww/qA/jpiKWEm04i3usK/Lrv19e6utZ2OYLHt9e3ui2XBh7Y0FSLj1l2xy3jPDXxayd3Ww6rQPOaB
        R9xrmlmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOEcf-003DbQ-C6; Wed, 17 Aug 2022 08:41:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C30D6980089; Wed, 17 Aug 2022 10:41:55 +0200 (CEST)
Date:   Wed, 17 Aug 2022 10:41:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 1/3] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Message-ID: <Yvyp02LLIQQPs5d6@worktop.programming.kicks-ass.net>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816192734.67115-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 16, 2022 at 03:27:32PM -0400, Waiman Long wrote:
> @@ -2981,25 +2969,21 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>  		goto err_unlock;
>  	}
>  
> -	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
> +
> +	if (p->user_cpus_ptr)
> +		not_empty = cpumask_and(new_mask, p->user_cpus_ptr, subset_mask);
> +	else
> +		not_empty = cpumask_and(new_mask, cpu_online_mask, subset_mask);
> +
> +	if (!not_empty) {
>  		err = -EINVAL;
>  		goto err_unlock;
>  	}
>  
> -	/*
> -	 * We're about to butcher the task affinity, so keep track of what
> -	 * the user asked for in case we're able to restore it later on.
> -	 */
> -	if (user_mask) {
> -		cpumask_copy(user_mask, p->cpus_ptr);
> -		p->user_cpus_ptr = user_mask;
> -	}
> -
>  	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
>  
>  err_unlock:
>  	task_rq_unlock(rq, p, &rf);
> -	kfree(user_mask);
>  	return err;
>  }
>  
> @@ -3049,34 +3033,27 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
>  }
>  
>  static int
> -__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask);
>  
>  /*
>   * Restore the affinity of a task @p which was previously restricted by a
> - * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
> - * @p->user_cpus_ptr.
> + * call to force_compatible_cpus_allowed_ptr().
>   *
>   * It is the caller's responsibility to serialise this with any calls to
>   * force_compatible_cpus_allowed_ptr(@p).
>   */
>  void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>  {
> -	struct cpumask *user_mask = p->user_cpus_ptr;
> -	unsigned long flags;
> +	const struct cpumask *user_mask = p->user_cpus_ptr;
> +
> +	if (!user_mask)
> +		user_mask = cpu_online_mask;
>  
>  	/*
> -	 * Try to restore the old affinity mask. If this fails, then
> -	 * we free the mask explicitly to avoid it being inherited across
> -	 * a subsequent fork().
> +	 * Try to restore the old affinity mask with __sched_setaffinity().
> +	 * Cpuset masking will be done there too.
>  	 */
> -	if (!user_mask || !__sched_setaffinity(p, user_mask))
> -		return;
> -
> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
> -	user_mask = clear_user_cpus_ptr(p);
> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> -
> -	kfree(user_mask);
> +	__sched_setaffinity(p, user_mask, false);
>  }
>  
>  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)


Would it not be simpler to write it something like so?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03053eebb22e..cdae4d50a588 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2955,7 +2955,6 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 	struct rq_flags rf;
 	struct rq *rq;
 	int err;
-	bool not_empty;
 
 	rq = task_rq_lock(p, &rf);
 
@@ -2969,13 +2968,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		goto err_unlock;
 	}
 
-
-	if (p->user_cpus_ptr)
-		not_empty = cpumask_and(new_mask, p->user_cpus_ptr, subset_mask);
-	else
-		not_empty = cpumask_and(new_mask, cpu_online_mask, subset_mask);
-
-	if (!not_empty) {
+	if (!cpumask_and(new_mask, task_user_cpus(p), subset_mask)) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
@@ -3044,16 +3037,11 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save
  */
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
-	const struct cpumask *user_mask = p->user_cpus_ptr;
-
-	if (!user_mask)
-		user_mask = cpu_online_mask;
-
 	/*
 	 * Try to restore the old affinity mask with __sched_setaffinity().
 	 * Cpuset masking will be done there too.
 	 */
-	__sched_setaffinity(p, user_mask, false);
+	__sched_setaffinity(p, task_user_cpus(p), false);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15eefcd65faa..426e9b64b587 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1881,6 +1881,13 @@ static inline void dirty_sched_domain_sysctl(int cpu)
 #endif
 
 extern int sched_update_scaling(void);
+
+static inline const struct cpumask *task_user_cpus(struct task_struct *p)
+{
+	if (!p->user_cpus_ptr)
+		return cpus_possible_mask; /* &init_task.cpus_mask */
+	return p->user_cpus_ptr;
+}
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
