Return-Path: <cgroups+bounces-5369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587C9B8F30
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 11:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE13B1F22C63
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3A168488;
	Fri,  1 Nov 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/cpWu87"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAF1607B7;
	Fri,  1 Nov 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456933; cv=none; b=HLy/mUeDjdat9yn5BguUq2zTNIZL33GWQd+d+zM+7xUN1OF2n5RoaDVb8GqieZXytxV8V+IsiYGWIvFOyNnN4jD/SlhlnfMCMc1M4Qcb3ibhXSShlhumZhLMWtccNCcYDGQlkSr+XEPf5MHFvfJ/5O/7723Zrvj7BO4Df3daLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456933; c=relaxed/simple;
	bh=qqzwqXPG5kSBUoiW7UPB9jyiWWdRAOWWw0hnaBf3hKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxzm1D9HL/SQSd/Q6bghM+Bbin0soMSJZZ768HiHmCosSEv+ym1VSOUCP57zw3Pd0b5AZWQLUFbMBZhVtx+95AizqBHjj7Z+tPcsUxfSveDNMd0O8zqIJadzmvQyLR/Y/eqdFNFyeWD4qnEQjh1R43BeiwnGtaLI0Ft0M65KnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O/cpWu87; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eTuJEiCktuDlH3Z9V/7T4YRPqsrQfabfFwzhECL/W1g=; b=O/cpWu87U/LFdlec807JLoB9ue
	ypsHWDDC6fzBADcZ/AKucxYP/B5OuIMLIVcDInkm1KfrEEKwE/rJL+5985NS3JhFxTagETibZwMfz
	Egb6RCOc4O6hXRJQeCTu9UyKZkOHWWIS/O/86zDC5DC+t/CzmfrBR/u2NedfDB22iT1UL/q300bLz
	bhaUAsjm4+26qeYGt/kCZerRADbf7rkU4DkIqj+bvsZpQLU1xUg+g4lce1Tj/VYAruRli8k2KPHGD
	FMHuhaRm9WM7GzDaSKap78Jhlm+d33zcD6sCMQlteCkSr/PEDd4SnT8iGaVyE65WYqNdiA4L1rOHu
	FP0I1rWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6otW-0000000AfFc-2G7l;
	Fri, 01 Nov 2024 10:28:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F60A300599; Fri,  1 Nov 2024 11:28:42 +0100 (CET)
Date: Fri, 1 Nov 2024 11:28:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] sched: Fix cgroup irq accounting for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <20241101102842.GW14555@noisy.programming.kicks-ass.net>
References: <20241101031750.1471-1-laoar.shao@gmail.com>
 <20241101031750.1471-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101031750.1471-5-laoar.shao@gmail.com>

On Fri, Nov 01, 2024 at 11:17:50AM +0800, Yafang Shao wrote:
> After enabling CONFIG_IRQ_TIME_ACCOUNTING to monitor IRQ pressure in our
> container environment, we observed several noticeable behavioral changes.
> 
> One of our IRQ-heavy services, such as Redis, reported a significant
> reduction in CPU usage after upgrading to the new kernel with
> CONFIG_IRQ_TIME_ACCOUNTING enabled. However, despite adding more threads
> to handle an increased workload, the CPU usage could not be raised. In
> other words, even though the container’s CPU usage appeared low, it was
> unable to process more workloads to utilize additional CPU resources, which
> caused issues.

> We can verify the CPU usage of the test cgroup using cpuacct.stat. The
> output shows:
> 
>   system: 53
>   user: 2
> 
> The CPU usage of the cgroup is relatively low at around 55%, but this usage
> doesn't increase, even with more netperf tasks. The reason is that CPU0 is
> at 100% utilization, as confirmed by mpstat:
> 
>   02:56:22 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>   02:56:23 PM    0    0.99    0.00   55.45    0.00    0.99   42.57    0.00    0.00    0.00    0.00
> 
>   02:56:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>   02:56:24 PM    0    2.00    0.00   55.00    0.00    0.00   43.00    0.00    0.00    0.00    0.00
> 
> It is clear that the %soft is not accounted into the cgroup of the
> interrupted task. This behavior is unexpected. We should account for IRQ
> time to the cgroup to reflect the pressure the group is under.
> 
> After a thorough analysis, I discovered that this change in behavior is due
> to commit 305e6835e055 ("sched: Do not account irq time to current task"),
> which altered whether IRQ time should be charged to the interrupted task.
> While I agree that a task should not be penalized by random interrupts, the
> task itself cannot progress while interrupted. Therefore, the interrupted
> time should be reported to the user.
> 
> The system metric in cpuacct.stat is crucial in indicating whether a
> container is under heavy system pressure, including IRQ/softirq activity.
> Hence, IRQ/softirq time should be accounted for in the cpuacct system
> usage, which also applies to cgroup2’s rstat.
> 
> This patch reintroduces IRQ/softirq accounting to cgroups.

How !? what does it actually do?

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/core.c  | 33 +++++++++++++++++++++++++++++++--
>  kernel/sched/psi.c   | 14 +++-----------
>  kernel/sched/stats.h |  7 ++++---
>  3 files changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 06a06f0897c3..5ed2c5c8c911 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5579,6 +5579,35 @@ __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
>  static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
>  #endif /* CONFIG_SCHED_DEBUG */
>  
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +static void account_irqtime(struct rq *rq, struct task_struct *curr,
> +			    struct task_struct *prev)
> +{
> +	int cpu = smp_processor_id();
> +	s64 delta;
> +	u64 irq;
> +
> +	if (!static_branch_likely(&sched_clock_irqtime))
> +		return;
> +
> +	irq = irq_time_read(cpu);
> +	delta = (s64)(irq - rq->psi_irq_time);

At this point the variable is no longer exclusive to PSI and should
probably be renamed.

> +	if (delta < 0)
> +		return;
> +
> +	rq->psi_irq_time = irq;
> +	psi_account_irqtime(rq, curr, prev, delta);
> +	cgroup_account_cputime(curr, delta);
> +	/* We account both softirq and irq into softirq */
> +	cgroup_account_cputime_field(curr, CPUTIME_SOFTIRQ, delta);

This seems wrong.. we have CPUTIME_IRQ.

> +}

In fact, much of this seems like it's going about things sideways.

Why can't you just add the cgroup_account_*() garbage to
irqtime_account_irq()? That is were it's still split out into softirq
and irq.

But the much bigger question is -- how can you be sure that this
interrupt is in fact for the cgroup you're attributing it to? Could be
for an entirely different cgroup.



