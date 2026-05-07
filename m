Return-Path: <cgroups+bounces-15665-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZRSoOSK3/GkqTAAAu9opvQ
	(envelope-from <cgroups+bounces-15665-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 18:00:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D014EBB98
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D120430753BF
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A144CAD9;
	Thu,  7 May 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWhueQBb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031A3F0AB9
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169188; cv=none; b=qYjvPE+DzRlLcXWe8Bn+eikE+SCtBOFHIXKWMNcut5Bg6RYIDmj4p+9DEn1/2XO3SIXmwmAkFQT7NashEmU0NWbIW90HrIjU9nmUHPu0+5IfVjkQ0bwhkGDORrFGPQ4N983EpFHTgpAYMuR05iN6JCiaoqLkxlBIrFCL1yPF8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169188; c=relaxed/simple;
	bh=5Cg3bylYbwZ7wPM/TPOqpFEgOdsJEMvm8YA8uWNMom0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tN6AEpbQWGVTyqgfKU0LdZw3GHK2D/UZHyxNpIfaqGghWhvrcbAUpFfab0C5+PIJOZjVd7fN2msMmgSqWejl1Lv7l1fBQElYXkHbCkbRNTDXXRh6RpL5EmmSOXVrpsEwIQmq4ewGpRATRqhspQnhVZ8lHiyCBWSCyInTwV0WKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWhueQBb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778169184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTQRu3iifG+kUtcXVt+UQ1Aeko3vBlnOxCllwAXA5UA=;
	b=MWhueQBbnM29xt3klvQnTNQ6QYNOnsYNVVyZgiwveS0mznQzC1Im0qi9bUoZP9Z1CRYxTb
	vdGD4fiobjziQ0s/akG91jQY74gfNwrLtrJrBJ/fcbEnJurG/+bfQmPjknuYmgD+GbkAXv
	+ZtIWvpST6MY2QhmJWd1dOEbX4u5wWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-U_qFem0vPc-Q3j6z47tZcQ-1; Thu,
 07 May 2026 11:53:02 -0400
X-MC-Unique: U_qFem0vPc-Q3j6z47tZcQ-1
X-Mimecast-MFC-AGG-ID: U_qFem0vPc-Q3j6z47tZcQ_1778169180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9531D18005B5;
	Thu,  7 May 2026 15:52:59 +0000 (UTC)
Received: from [10.2.16.64] (unknown [10.2.16.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5CB180034E;
	Thu,  7 May 2026 15:52:51 +0000 (UTC)
Message-ID: <4e718145-5af6-40c3-83da-a004904e29d1@redhat.com>
Date: Thu, 7 May 2026 11:52:50 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: align DL bandwidth reservation with
 attach target mask
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
 <20260507103310.35849-3-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260507103310.35849-3-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 14D014EBB98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-15665-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 6:33 AM, Guopeng Zhang wrote:
> cpuset_can_attach() preallocates destination SCHED_DEADLINE bandwidth
> before the attach commit point, while set_cpus_allowed_dl() later
> subtracts bandwidth from the source root domain when the task affinity is
> actually updated.
>
> Those two decisions must be made with the same CPU mask.
> cpuset_can_attach() used the destination cpuset effective mask directly,
> but cpuset_attach_task() first builds a per-task target mask which is
> constrained by task_cpu_possible_mask() and, if needed, by walking up the
> cpuset hierarchy. On asymmetric systems, the actual target mask can
> therefore be a strict subset of cs->effective_cpus.

The task_cpu_possible_mask() is there for a special class of arm64 CPUs 
where only some of the cores are able to run legacy 32-bit applications 
on 64-bit arm CPUs. We can argue how likely that a DL task can be a 
legacy 32 bit application that is inherently slower than the same 
application compiled into native 64-bit code. Perhaps we can just 
disallow such a legacy 32-bit application from moving to a DL scheduling 
class in the first place.

I am not in favor of the idea of making the cpuset code more complex to 
support such a corner case which may never be utilized. Could you strip 
out the task_possible_cpu_mask() part from this patch? We can revisit 
this with another patch if such a special use case can be useful to 
support in the future.

Cheers,
Longman

>
> If the source root domain intersects cs->effective_cpus only on CPUs
> outside the task's possible mask, can_attach() can skip the destination
> reservation even though set_cpus_allowed_dl() later sees a real
> root-domain move and subtracts from the source domain.
>
> Extract the root-domain bandwidth-move test used by
> set_cpus_allowed_dl() into dl_task_needs_bw_move(), and make
> cpuset_can_attach() compute the same per-task target mask that
> cpuset_attach_task() applies.
>
> Keep nr_migrate_dl_tasks counting all migrating deadline tasks for
> cpuset DL task accounting. Restrict sum_migrate_dl_bw to the subset of
> tasks that need destination root-domain bandwidth reservation, because a
> deadline task can move between cpusets without moving bandwidth between
> root domains.
>
> This keeps the existing per-attach aggregate reservation model; it only
> changes the per-task mask used to decide which tasks contribute to that
> aggregate. The broader can_attach()/attach() transaction window is left
> unchanged.
>
> Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   include/linux/sched/deadline.h  |  9 +++
>   kernel/cgroup/cpuset-internal.h |  1 +
>   kernel/cgroup/cpuset.c          | 97 ++++++++++++++++++++++-----------
>   kernel/sched/deadline.c         | 13 ++++-
>   4 files changed, 86 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 1198138cb839..ddfd5216f3fc 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -33,6 +33,15 @@ struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
>   extern void dl_clear_root_domain(struct root_domain *rd);
>   extern void dl_clear_root_domain_cpu(int cpu);
> +/*
> + * Return whether moving DL task @p to @new_mask requires moving DL
> + * bandwidth accounting between root domains. This helper is specific to
> + * DL bandwidth move accounting semantics and is shared by
> + * cpuset_can_attach() and set_cpus_allowed_dl() so both paths use the
> + * same source root-domain test.
> + */
> +bool dl_task_needs_bw_move(struct task_struct *p,
> +			   const struct cpumask *new_mask);
>   
>   extern u64 dl_cookie;
>   extern bool dl_bw_visited(int cpu, u64 cookie);
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index bb4e692bea30..f7aaf01f7cd5 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -167,6 +167,7 @@ struct cpuset {
>   	 */
>   	int nr_deadline_tasks;
>   	int nr_migrate_dl_tasks;
> +	/* DL bandwidth that needs destination reservation for this attach. */
>   	u64 sum_migrate_dl_bw;
>   	/*
>   	 * CPU used for temporary DL bandwidth allocation during attach;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ae41736399a1..78c1a4071cc3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -485,6 +485,30 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>   	rcu_read_unlock();
>   }
>   
> +/* Compute the effective CPU mask cpuset_attach_task() will apply to @tsk. */
> +static void cpuset_attach_task_cpus(struct cpuset *cs, struct task_struct *tsk,
> +				    struct cpumask *pmask)
> +{
> +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
> +	lockdep_assert_cpuset_lock_held();
> +
> +	if (cs == &top_cpuset) {
> +		cpumask_andnot(pmask, possible_mask, subpartitions_cpus);
> +		return;
> +	}
> +
> +	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_active_mask)))
> +		cpumask_copy(pmask, cpu_active_mask);
> +
> +	rcu_read_lock();
> +	while (!cpumask_intersects(cs->effective_cpus, pmask))
> +		cs = parent_cs(cs);
> +
> +	cpumask_and(pmask, pmask, cs->effective_cpus);
> +	rcu_read_unlock();
> +}
> +
>   /*
>    * Return in *pmask the portion of a cpusets's mems_allowed that
>    * are online, with memory.  If none are online with memory, walk
> @@ -2986,6 +3010,14 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>   	cs->dl_bw_cpu = -1;
>   }
>   
> +/*
> + * Protected by cpuset_mutex. cpus_attach is used by the can_attach/attach
> + * paths but we can't allocate it dynamically there. Define it global and
> + * allocate from cpuset_init().
> + */
> +static cpumask_var_t cpus_attach;
> +static nodemask_t cpuset_attach_nodemask_to;
> +
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>   {
> @@ -2993,7 +3025,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	struct cpuset *cs, *oldcs;
>   	struct task_struct *task;
>   	bool setsched_check;
> -	int ret;
> +	int cpu = nr_cpu_ids, ret;
>   
>   	/* used later by cpuset_attach() */
>   	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> @@ -3038,32 +3070,47 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		}
>   
>   		if (dl_task(task)) {
> +			/*
> +			 * Count all migrating DL tasks for cpuset task accounting.
> +			 * Only tasks that need a root-domain bandwidth move
> +			 * contribute to sum_migrate_dl_bw.
> +			 */
>   			cs->nr_migrate_dl_tasks++;
> -			cs->sum_migrate_dl_bw += task->dl.dl_bw;
> +			cpuset_attach_task_cpus(cs, task, cpus_attach);
> +
> +			if (dl_task_needs_bw_move(task, cpus_attach)) {
> +				/*
> +				 * Keep the existing aggregate reservation model.
> +				 * Tasks in one attach enter the same destination
> +				 * cpuset, so the first CPU found for a task needing
> +				 * DL bandwidth reservation identifies the destination
> +				 * root domain.
> +				 */
> +				if (cpu >= nr_cpu_ids)
> +					cpu = cpumask_any_and(cpu_active_mask,
> +							      cpus_attach);
> +				cs->sum_migrate_dl_bw += task->dl.dl_bw;
> +			}
>   		}
>   	}
>   
> -	if (!cs->nr_migrate_dl_tasks)
> +	if (!cs->sum_migrate_dl_bw)
>   		goto out_success;
>   
> -	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
> -		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -
> -		if (unlikely(cpu >= nr_cpu_ids)) {
> -			reset_migrate_dl_data(cs);
> -			ret = -EINVAL;
> -			goto out_unlock;
> -		}
> -
> -		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -		if (ret) {
> -			reset_migrate_dl_data(cs);
> -			goto out_unlock;
> -		}
> +	if (unlikely(cpu >= nr_cpu_ids)) {
> +		reset_migrate_dl_data(cs);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
>   
> -		cs->dl_bw_cpu = cpu;
> +	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +	if (ret) {
> +		reset_migrate_dl_data(cs);
> +		goto out_unlock;
>   	}
>   
> +	cs->dl_bw_cpu = cpu;
> +
>   out_success:
>   	/*
>   	 * Mark attach is in progress.  This makes validate_change() fail
> @@ -3099,23 +3146,11 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> -/*
> - * Protected by cpuset_mutex. cpus_attach is used only by cpuset_attach_task()
> - * but we can't allocate it dynamically there.  Define it global and
> - * allocate from cpuset_init().
> - */
> -static cpumask_var_t cpus_attach;
> -static nodemask_t cpuset_attach_nodemask_to;
> -
>   static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   {
>   	lockdep_assert_cpuset_lock_held();
>   
> -	if (cs != &top_cpuset)
> -		guarantee_active_cpus(task, cpus_attach);
> -	else
> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
> -			       subpartitions_cpus);
> +	cpuset_attach_task_cpus(cs, task, cpus_attach);
>   	/*
>   	 * can_attach beforehand should guarantee that this doesn't
>   	 * fail.  TODO: have a better way to handle failure here
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index edca7849b165..7db4c87df83b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3107,20 +3107,18 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
>   static void set_cpus_allowed_dl(struct task_struct *p,
>   				struct affinity_context *ctx)
>   {
> -	struct root_domain *src_rd;
>   	struct rq *rq;
>   
>   	WARN_ON_ONCE(!dl_task(p));
>   
>   	rq = task_rq(p);
> -	src_rd = rq->rd;
>   	/*
>   	 * Migrating a SCHED_DEADLINE task between exclusive
>   	 * cpusets (different root_domains) entails a bandwidth
>   	 * update. We already made space for us in the destination
>   	 * domain (see cpuset_can_attach()).
>   	 */
> -	if (!cpumask_intersects(src_rd->span, ctx->new_mask)) {
> +	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
>   		struct dl_bw *src_dl_b;
>   
>   		src_dl_b = dl_bw_of(cpu_of(rq));
> @@ -3137,6 +3135,15 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>   	set_cpus_allowed_common(p, ctx);
>   }
>   
> +bool dl_task_needs_bw_move(struct task_struct *p,
> +			   const struct cpumask *new_mask)
> +{
> +	if (!dl_task(p))
> +		return false;
> +
> +	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
> +}
> +
>   /* Assumes rq->lock is held */
>   static void rq_online_dl(struct rq *rq)
>   {


