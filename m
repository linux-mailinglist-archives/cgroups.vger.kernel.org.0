Return-Path: <cgroups+bounces-2954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ED48C8EAD
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 01:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8131C20DDB
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F851411EA;
	Fri, 17 May 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Osl+qZUM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByZ+1fkM"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B01E532;
	Fri, 17 May 2024 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989361; cv=none; b=poXTlwNKvqfy/mb0u8QDzniXkDyhXfseBL+cnWKjSaDcSiK4nw/Yebq0XNSmukf/3wSE0DbbqOcaq9ExHg/selA80gtfWgoEmQm1EusEuhnuAD1YwEZHPrEEpksojMQhmJmd1+d6H6BeGpeNi49cIKdefqEEzHnNy1XRzJjpjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989361; c=relaxed/simple;
	bh=bWqKsu+ymZ8REvUC9OM+fUZomFNhNWZJ3tDFvdCEG+c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fS8X/IDblfJTflmioJ8tKVy7GiMQysD9FPb6P2G95cB/4vQ3XRLwLhaagNEqDIpKXVPQYkDaMQhYLXStkmdesKoAv3/6pY1i+3BehYAt2IfdqDBAAVq4Obk6qU0YsWsceDcExHW+kdS6EwpNqijs40WU1maGPONWKqRBsYeSvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Osl+qZUM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByZ+1fkM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715989356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDgmYK2oZcxFjAI/hc4HO+N3Bdybn2809x1KJTzImM=;
	b=Osl+qZUMz9sl3kI0J+1qLjO8rPfcK/GN5pvCF+mn6QlYvNPaDAufs98ZrfaDgz5qeykVQH
	meg/3FEcBuf59BS4QbNv8Ruxroubdgdm6H2jxKqC4tsp5x7E3DMzmbCIpCP+kRIaBHgRKp
	Ak3wKGH501SKsgzUpNw/XmYPBXaqs3lKJku4KcpH93PsrNo5yvm30nCqc2mPb+Fx9z1ylu
	NDVt4FuYtOe0zdaL9+ieln9CfpCMPdWKvHG655wlKKans7i4dBg/PqQ2oJqlX/WpXP4O9K
	PuB64q46SWjLSLHstC/eBBf7O2e0/8XX3JDhWItv6yHrdvGGMbVFvDmmpZ2sZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715989356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDgmYK2oZcxFjAI/hc4HO+N3Bdybn2809x1KJTzImM=;
	b=ByZ+1fkMZkqY/gTWFGcVt/3TtwLCo4byONUFH0MqZQNwzv9q1L8cpP63E2fXQlOE1Qt5/J
	0hSg633mkRqZQFDA==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 pauld@redhat.com, juri.lelli@redhat.com, prarit@redhat.com,
 vschneid@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Costa
 Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v1 3/7] sched/isolation: Adjust affinity of hrtimers
 according to change of housekeeping cpumask
In-Reply-To: <20240516190437.3545310-4-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-4-costa.shul@redhat.com>
Date: Sat, 18 May 2024 01:42:35 +0200
Message-ID: <87zfsohuok.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 16 2024 at 22:04, Costa Shulyupin wrote:
> Adjust affinity of watchdog_cpumask, hrtimers according to
> change of housekeeping.cpumasks[HK_TYPE_TIMER].
>
> Function migrate_hrtimer_list_except() is prototyped from
> migrate_hrtimer_list() and is more generic.
>
> Potentially it can be used instead of migrate_hrtimer_list.
>
> Function hrtimers_resettle_from_cpu() is blindly prototyped
> from hrtimers_cpu_dying(). local_irq_disable() is used because
> cpuhp_thread_fun() uses it before cpuhp_invoke_callback().

I'm again impressed by the depth of analysis.

Q: What the heck has cpuhp_thread_fun() to do with hrtimers_cpu_dying()?

A: Absolutely nothing.

> Core test snippets without infrastructure:
>
> 1. Create hrtimer on specific cpu with:
>
>         set_cpus_allowed_ptr(current, cpumask_of(test_cpu));
>         hrtimer_init(&test_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         test_hrtimer.function = test_hrtimer_cb;
>         hrtimer_start(&test_hrtimer, -1,  HRTIMER_MODE_REL);
>
> 2. Call housekeeping_update()
>
> 3. Assure that there is only tick_nohz_handler on specified cpu
> in /proc/timer_list manually or with script:
>
> grep -E 'cpu| #[0-9]' /proc/timer_list | \
> 	awk "/cpu:/{y=0};/cpu: $test_cpu\$/{y=1};y"
>
> Another alternative solution to migrate hrtimers:
> 1. Use cpuhp to set sched_timer offline
> 2. Resettle all hrtimers likewise migrate_hrtimer_list
> 3. Use cpuhp to set sched_timer online

Another pile of incomprehensible word salad which pretends to be a
change log.

> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -126,10 +126,12 @@ static void resettle_all_timers(cpumask_var_t enable_mask, cpumask_var_t disable
>  
>  	for_each_cpu(cpu, enable_mask)	{
>  		timers_prepare_cpu(cpu);
> +		hrtimers_prepare_cpu(cpu);

And yet another lockless re-initialization of an active in use data
structure ...

> +/*
> + * migrate_hrtimer_list_except - migrates hrtimers from one base to another,
> + * except specified one.
> + */
> +static void migrate_hrtimer_list_except(struct hrtimer_clock_base *old_base,
> +				struct hrtimer_clock_base *new_base, struct hrtimer *except)
> +{
> +	struct hrtimer *timer;
> +	struct timerqueue_node *node;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +	node = timerqueue_getnext(&old_base->active);
> +	while (node) {
> +		timer = container_of(node, struct hrtimer, node);
> +		node = timerqueue_iterate_next(node);
> +		if (timer == except)
> +			continue;

What's the rationale that there is only a single timer to except from
the migration?

> +		BUG_ON(hrtimer_callback_running(timer));

Q: What prevents that a hrtimer callback is running on the CPU which was
   not isolated before?

A: Nothing. Ergo this is prone to kill a perfectly correct system just
   because of blindly copying something.

   At least your attempt of a changelog is clear about that...

> +		debug_deactivate(timer);
> +
> +		/*
> +		 * Mark it as ENQUEUED not INACTIVE otherwise the
> +		 * timer could be seen as !active and just vanish away
> +		 * under us on another CPU
> +		 */
> +		__remove_hrtimer(timer, old_base, HRTIMER_STATE_ENQUEUED, 0);
> +		timer->base = new_base;
> +		/*
> +		 * Enqueue the timers on the new cpu. This does not
> +		 * reprogram the event device in case the timer
> +		 * expires before the earliest on this CPU, but we run
> +		 * hrtimer_interrupt after we migrated everything to
> +		 * sort out already expired timers and reprogram the
> +		 * event device.
> +		 */
> +		enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS);
> +	}
> +}
> +
> +/**
> + * hrtimers_resettle_from_cpu - resettles hrtimers from
> + * specified cpu to housekeeping cpus.
> + */
> +void hrtimers_resettle_from_cpu(unsigned int isol_cpu)
> +{
> +	int ncpu, i;
> +	struct tick_sched *ts = tick_get_tick_sched(isol_cpu);
> +	struct hrtimer_cpu_base *old_base, *new_base;
> +
> +	local_irq_disable();
> +	ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
> +
> +	old_base = &per_cpu(hrtimer_bases, isol_cpu);
> +	new_base = &per_cpu(hrtimer_bases, ncpu);
> +
> +	/*
> +	 * The caller is globally serialized and nobody else
> +	 * takes two locks at once, deadlock is not possible.
> +	 */
> +	raw_spin_lock(&old_base->lock);
> +	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
> +	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
> +		migrate_hrtimer_list_except(&old_base->clock_base[i],
> +				     &new_base->clock_base[i],
> +				     &ts->sched_timer);
> +	}
> +
> +	/*
> +	 * The migration might have changed the first expiring softirq
> +	 * timer on this CPU. Update it.
> +	 */
> +	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
> +
> +	raw_spin_unlock(&new_base->lock);
> +	raw_spin_unlock(&old_base->lock);
> +	local_irq_enable();
> +
> +	/* Tell the other CPU to retrigger the next event */
> +	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
> +}

We clearly need another copy of hrtimers_cpu_dying() and
migrate_hrtimer_list() to add a local_irq_dis/enable() pair and a
completely ill defined exclusion mechanism which assumes that the tick
hrtimer is the only one which has to be excluded from migration.

Even if the exlusion mechanism would be correct there is ZERO
justification for this copy and pasta orgy even if you marked this
series RFC. RFC != POC hackery.

Thanks,

        tglx

