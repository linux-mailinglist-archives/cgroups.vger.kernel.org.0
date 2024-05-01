Return-Path: <cgroups+bounces-2744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3AD8B8BCF
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 16:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB21C2106C
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079E12F389;
	Wed,  1 May 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdkwhwOl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DB12F36F
	for <cgroups@vger.kernel.org>; Wed,  1 May 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573455; cv=none; b=sB2qbloZf3FDTXu3jSgusqyrUlsENwgrE0DC214m1gmRiWKrklo9o3Ru6IEyzH/CZ62DP+iHewTTVgCCbpEt8ycEY0fqsISw6HhHKV5fC1z7lzNwJ8jy7zQEAjJPmG/ptF+uTjSlaSE39w2Pwcg+WV7yGkqbFcyHB999xyDwGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573455; c=relaxed/simple;
	bh=EtIuFrhuvm6I4l5dfH6G+qCG4QX3swTS9kkAUYF9YwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osrO0V6qHRMn9wMXH3dFcU6M2DSo8oPAw1Mm812qec1z+dsWzFqPV64X340uB6VpDzHabZIrqx0IhoU4OGPjCkP8nmYnFTxt9q9yUBoOXQ+mmBz9GMRN0Q2Hwiel3mL0GzMEOo6g7IT5XHSXvquOnxZgSDogYxvxcB47jeqhnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdkwhwOl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714573452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmIyfibeNjI24B+Eh2I0wAAxdKYTRV5qzSzimEd55VM=;
	b=WdkwhwOl/aY2fj7LDxrCQjAO2UTzQjhObu0QbgXM6MH62+dt7mriys8rILKJwNn6WgLYsc
	4cSzbx9wN/zd0Siw4m/W4/B5Cv+M637fiD2zTgspIesZZEJpBuxrTt9Rbc8VLCxxNyVIY7
	jv1/VnQpNTabtGWIxWCQCX70Dw/w42c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-wgRL6ov4OaiRuY38wBLQag-1; Wed, 01 May 2024 10:24:06 -0400
X-MC-Unique: wgRL6ov4OaiRuY38wBLQag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D661830D37;
	Wed,  1 May 2024 14:24:05 +0000 (UTC)
Received: from [10.22.34.18] (unknown [10.22.34.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64FC21121312;
	Wed,  1 May 2024 14:24:04 +0000 (UTC)
Message-ID: <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
Date: Wed, 1 May 2024 10:24:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 yosryahmed@google.com
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <171457225108.4159924.12821205549807669839.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 5/1/24 10:04, Jesper Dangaard Brouer wrote:
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

This is a per-cpu lock. So the only possible contention involves only 2 
CPUs - a local CPU invoking cgroup_rstat_updated(). A flusher CPU doing 
cgroup_rstat_flush_locked() calling into cgroup_rstat_updated_list(). 
With recent commits to reduce the percpu lock hold time, I doubt lock 
contention on the percpu lock will have a great impact on latency. So do 
we really need such an elaborate scheme to monitor this? BTW, the 
additional code will also add to the worst case latency.

Cheers,
Longman

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


