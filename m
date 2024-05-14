Return-Path: <cgroups+bounces-2875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57098C4BF0
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 07:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B55E1F2282A
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 05:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0734171A5;
	Tue, 14 May 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiWDV2Do"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E618026;
	Tue, 14 May 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715663902; cv=none; b=pnOhN3s8juBx2t/jVyzMwfs7wScfXJK2N9amS+ZF82er22pppFQR1QB/DBnAL8fCNXUPvhMkNf/pPQWME+BgYybNOBkVKux+gkFtN6T0JUIR1csOW0Jxhot4GXDRjv8SL73MKjxXiHqBLSCc5rV+kEZqh6ep6rhI+ER0sHTHSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715663902; c=relaxed/simple;
	bh=QkpHlnc+ig2PXMttd/+olwpgeCOJicOPEYvANyR1shE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7siEQ125ibGLgPEEHBRzFfkFpwztLZgehSQEX6TqFdSQn4yaLUEWAmYz2y9jFJZ5kfe907YJYDjVJcGJ8BTe4Z6zxwkJWr9XLtdOxaarhPIZsmtwSvz71EwstpEWe62OFpL6DW6lM/wz57kJ289XKbhkdbOW+IdaQB4880dvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiWDV2Do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D120CC2BD10;
	Tue, 14 May 2024 05:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715663902;
	bh=QkpHlnc+ig2PXMttd/+olwpgeCOJicOPEYvANyR1shE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WiWDV2Dop6QttjUXw0Qq/AtrTV4FkTFc0TYLmkJ2g2EUaAZ8wfmOFHcO7/LY8lNgC
	 CPN0uj6y1ewAzCm2VDoBQemZ6P0c7GAOIFGFsZ2uEX12/SCQEesLJ/o57JZtWD3EFW
	 C5DIGs7cgYGBetFa6T7skxOVk+8guAKzF4uP5MepZ/MzoDeFQ2hKxdKx4Acuu9ZJxv
	 5L9Ep/w4nflRJ8F0W7QY5G4aD5vuzdwJabgdzm1ty+0NQ0/ysbKEuR+XhB1M97pved
	 pPkkeoVPLt5OO4LpxljrJ5fGJllviockLW0fTLMagDULdSB/P2bVQuRQ6/0Ts1DIx9
	 UIWO3PiOLKkFw==
Message-ID: <0ef04a5c-ced8-4e30-bcde-43c218e35387@kernel.org>
Date: Tue, 14 May 2024 07:18:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <171457225108.4159924.12821205549807669839.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun,

Could we please apply this for-6.10, to avoid splitting tracepoint 
changes over multiple kernel versions?

--Jesper
P.s. Cloudflare is already running with this applied in production.


On 01/05/2024 16.04, Jesper Dangaard Brouer wrote:
> This closely resembles helpers added for the global cgroup_rstat_lock in
> commit fc29e04ae1ad ("cgroup/rstat: add cgroup_rstat_lock helpers and
> tracepoints"). This is for the per CPU lock cgroup_rstat_cpu_lock.
> 
> Based on production workloads, we observe the fast-path "update" function
> cgroup_rstat_updated() is invoked around 3 million times per sec, while the
> "flush" function cgroup_rstat_flush_locked(), walking each possible CPU,
> can see periodic spikes of 700 invocations/sec.
> 
> For this reason, the tracepoints are split into normal and fastpath
> versions for this per-CPU lock. Making it feasible for production to
> continuously monitor the non-fastpath tracepoint to detect lock contention
> issues. The reason for monitoring is that lock disables IRQs which can
> disturb e.g. softirq processing on the local CPUs involved. When the
> global cgroup_rstat_lock stops disabling IRQs (e.g converted to a mutex),
> this per CPU lock becomes the next bottleneck that can introduce latency
> variations.
> 
> A practical bpftrace script for monitoring contention latency:
> 
>   bpftrace -e '
>     tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>       @start[tid]=nsecs; @cnt[probe]=count()}
>     tracepoint:cgroup:cgroup_rstat_cpu_locked {
>       if (args->contended) {
>         @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}
>       @cnt[probe]=count()}
>     interval:s:1 {time("%H:%M:%S "); print(@wait_ns); print(@cnt); clear(@cnt);}'
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   include/trace/events/cgroup.h |   56 +++++++++++++++++++++++++++++----
>   kernel/cgroup/rstat.c         |   70 ++++++++++++++++++++++++++++++++++-------
>   2 files changed, 108 insertions(+), 18 deletions(-)
> 
> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
> index 13f375800135..0b95865a90f3 100644
> --- a/include/trace/events/cgroup.h
> +++ b/include/trace/events/cgroup.h
> @@ -206,15 +206,15 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
>   
>   DECLARE_EVENT_CLASS(cgroup_rstat,
>   
> -	TP_PROTO(struct cgroup *cgrp, int cpu_in_loop, bool contended),
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>   
> -	TP_ARGS(cgrp, cpu_in_loop, contended),
> +	TP_ARGS(cgrp, cpu, contended),
>   
>   	TP_STRUCT__entry(
>   		__field(	int,		root			)
>   		__field(	int,		level			)
>   		__field(	u64,		id			)
> -		__field(	int,		cpu_in_loop		)
> +		__field(	int,		cpu			)
>   		__field(	bool,		contended		)
>   	),
>   
> @@ -222,15 +222,16 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
>   		__entry->root = cgrp->root->hierarchy_id;
>   		__entry->id = cgroup_id(cgrp);
>   		__entry->level = cgrp->level;
> -		__entry->cpu_in_loop = cpu_in_loop;
> +		__entry->cpu = cpu;
>   		__entry->contended = contended;
>   	),
>   
> -	TP_printk("root=%d id=%llu level=%d cpu_in_loop=%d lock contended:%d",
> +	TP_printk("root=%d id=%llu level=%d cpu=%d lock contended:%d",
>   		  __entry->root, __entry->id, __entry->level,
> -		  __entry->cpu_in_loop, __entry->contended)
> +		  __entry->cpu, __entry->contended)
>   );
>   
> +/* Related to global: cgroup_rstat_lock */
>   DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
>   
>   	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> @@ -252,6 +253,49 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
>   	TP_ARGS(cgrp, cpu, contended)
>   );
>   
> +/* Related to per CPU: cgroup_rstat_cpu_lock */
> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended,
> +
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +
> +	TP_ARGS(cgrp, cpu, contended)
> +);
> +
> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended_fastpath,
> +
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +
> +	TP_ARGS(cgrp, cpu, contended)
> +);
> +
> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_locked,
> +
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +
> +	TP_ARGS(cgrp, cpu, contended)
> +);
> +
> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_locked_fastpath,
> +
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +
> +	TP_ARGS(cgrp, cpu, contended)
> +);
> +
> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock,
> +
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +
> +	TP_ARGS(cgrp, cpu, contended)
> +);
> +
> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
> +
> +	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +
> +	TP_ARGS(cgrp, cpu, contended)
> +);
> +
>   #endif /* _TRACE_CGROUP_H */
>   
>   /* This part must be outside protection */
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 52e3b0ed1cee..fb8b49437573 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -19,6 +19,60 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
>   	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
>   }
>   
> +/*
> + * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
> + *
> + * This makes it easier to diagnose locking issues and contention in
> + * production environments. The parameter @fast_path determine the
> + * tracepoints being added, allowing us to diagnose "flush" related
> + * operations without handling high-frequency fast-path "update" events.
> + */
> +static __always_inline
> +unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
> +				     struct cgroup *cgrp, const bool fast_path)
> +{
> +	unsigned long flags;
> +	bool contended;
> +
> +	/*
> +	 * The _irqsave() is needed because cgroup_rstat_lock is
> +	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> +	 * this lock with the _irq() suffix only disables interrupts on
> +	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> +	 * interrupts on both configurations. The _irqsave() ensures
> +	 * that interrupts are always disabled and later restored.
> +	 */
> +	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
> +	if (contended) {
> +		if (fast_path)
> +			trace_cgroup_rstat_cpu_lock_contended_fastpath(cgrp, cpu, contended);
> +		else
> +			trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, contended);
> +
> +		raw_spin_lock_irqsave(cpu_lock, flags);
> +	}
> +
> +	if (fast_path)
> +		trace_cgroup_rstat_cpu_locked_fastpath(cgrp, cpu, contended);
> +	else
> +		trace_cgroup_rstat_cpu_locked(cgrp, cpu, contended);
> +
> +	return flags;
> +}
> +
> +static __always_inline
> +void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
> +			      struct cgroup *cgrp, unsigned long flags,
> +			      const bool fast_path)
> +{
> +	if (fast_path)
> +		trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
> +	else
> +		trace_cgroup_rstat_cpu_unlock(cgrp, cpu, false);
> +
> +	raw_spin_unlock_irqrestore(cpu_lock, flags);
> +}
> +
>   /**
>    * cgroup_rstat_updated - keep track of updated rstat_cpu
>    * @cgrp: target cgroup
> @@ -44,7 +98,7 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>   	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
>   		return;
>   
> -	raw_spin_lock_irqsave(cpu_lock, flags);
> +	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
>   
>   	/* put @cgrp and all ancestors on the corresponding updated lists */
>   	while (true) {
> @@ -72,7 +126,7 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>   		cgrp = parent;
>   	}
>   
> -	raw_spin_unlock_irqrestore(cpu_lock, flags);
> +	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
>   }
>   
>   /**
> @@ -153,15 +207,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
>   	struct cgroup *head = NULL, *parent, *child;
>   	unsigned long flags;
>   
> -	/*
> -	 * The _irqsave() is needed because cgroup_rstat_lock is
> -	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> -	 * this lock with the _irq() suffix only disables interrupts on
> -	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> -	 * interrupts on both configurations. The _irqsave() ensures
> -	 * that interrupts are always disabled and later restored.
> -	 */
> -	raw_spin_lock_irqsave(cpu_lock, flags);
> +	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
>   
>   	/* Return NULL if this subtree is not on-list */
>   	if (!rstatc->updated_next)
> @@ -198,7 +244,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
>   	if (child != root)
>   		head = cgroup_rstat_push_children(head, child, cpu);
>   unlock_ret:
> -	raw_spin_unlock_irqrestore(cpu_lock, flags);
> +	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
>   	return head;
>   }
>   
> 
> 

