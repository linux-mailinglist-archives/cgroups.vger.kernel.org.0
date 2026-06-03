Return-Path: <cgroups+bounces-16599-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n/iaCwcEIGpiuAAAu9opvQ
	(envelope-from <cgroups+bounces-16599-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 12:37:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D163636A74
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 12:37:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Sa7om6Mh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16599-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16599-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3DE3044545
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D337386450;
	Wed,  3 Jun 2026 10:32:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC982E54D1
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 10:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482777; cv=none; b=HWLNiWPzFOJHDI2RzWVMy/FLmDlup+o89IsGt8PEuH1zUldg2EEsPX/5p1p894yUMOflPM9uXiowwqbRHhQwatDUDU2daACOeIiVugzGel7wjCwLw6KGv2hhV+zRlsJVZUGQ975OG9JxGAZ+eeCjNqZVm9LTyqBiHi4u1t24M1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482777; c=relaxed/simple;
	bh=JSKFadDrrNZOrtfYuG+QePncbLZmLKysxjKipF+gJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHgjqOrsnR71TCpVfRwuEwJ0/y8cGNGLAD4bf4qWU0eVoXeo8O0/EthbYAnwURrDAUnlvM2YyOaswNSywwO1hwh2u5J1Plr8cCkxMKsMa91W754vSasXrVsEO1UQ2+rWn7Ctm4RA8/V7/W0b2+4hDqghdzlSJkL0mLxTkJtmcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sa7om6Mh; arc=none smtp.client-ip=91.218.175.180
Message-ID: <29f96009-27ae-45fa-b4ff-c300838ba835@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780482772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5ZQmo+9G7POb+74dnbIt60PG/5dDWYqvDxdfS6//G8=;
	b=Sa7om6Mh3h7EpGVXJfmISOHgXBIc+4GBhF9pg9lSTfYSS/Nn1N2kF1I22R5LVi+diXK4Dz
	vcb97PHPhhC97lErPbUWVDg9XKOdCtgV37TyQ0Px8hDm4PvqbgstDp9RIYssQDsP6KWz3h
	dp/4U297G86TbK5J1Jno2L7OLT/wa8Q=
Date: Wed, 3 Jun 2026 18:32:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup/cpuset: Support multiple source/destination
 cpusets using pids pattern
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
References: <20260602023203.248077-7-longman@redhat.com>
 <20260603102604.177503-1-ridong.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260603102604.177503-1-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16599-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D163636A74

Hi Longman,

I used AI to generate a patch that fixes this issue, following the same
approach as the pids subsystem. I think this may be much simpler. Just a
heads-up — this patch is only for discussion and hasn't been tested.

On 2026/6/3 18:26, Ridong Chen wrote:
> The current cpuset_can_attach() and cpuset_attach() functions assume task
> migration is from one source cpuset to one destination cpuset. This can be
> wrong in several scenarios:
>  - Moving a multi-threaded process with threads in different cpusets
>  - Disabling the cpuset controller (many children to one parent)
>  - Enabling the cpuset controller (one parent to many children)
> 
> Fix this by adopting the pids subsystem's per-task accounting pattern.
> In cpuset_can_attach(), use task_cs(task) to get the correct source cpuset
> for each task (like pids_can_attach uses task_css), adjust nr_deadline_tasks
> and reserve DL bandwidth per-task, and increment attach_in_progress per-task
> on the destination cpuset. In cpuset_attach(), handle destination cpuset
> changes within the task iteration loop.
> 
> A shared helper cpuset_undo_attach() reverses the per-task operations for
> both partial rollback in cpuset_can_attach() and full reversal in
> cpuset_cancel_attach().
> 
> When multiple source cpusets are detected in can_attach(), set
> attach_many_sources so that cpuset_attach() forces cpus_updated and
> mems_updated to true, ensuring all tasks get properly updated regardless
> of which source cpuset cpuset_attach_old_cs points to.
> 
> This eliminates the need for nr_migrate_dl_tasks, sum_migrate_dl_bw, and
> dl_bw_cpu fields in struct cpuset.
> 
> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default hierarchy")
> Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
> ---
>  kernel/cgroup/cpuset-internal.h |   8 --
>  kernel/cgroup/cpuset.c          | 177 ++++++++++++++++----------------
>  2 files changed, 89 insertions(+), 96 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index f7aaf01f7cd5..601e38b3c75b 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -166,14 +166,6 @@ struct cpuset {
>  	 * know when to rebuild associated root domain bandwidth information.
>  	 */
>  	int nr_deadline_tasks;
> -	int nr_migrate_dl_tasks;
> -	/* DL bandwidth that needs destination reservation for this attach. */
> -	u64 sum_migrate_dl_bw;
> -	/*
> -	 * CPU used for temporary DL bandwidth allocation during attach;
> -	 * -1 if no DL bandwidth was allocated in the current attach.
> -	 */
> -	int dl_bw_cpu;
>  
>  	/* Invalid partition error code, not lock protected */
>  	enum prs_errcode prs_err;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e52a5a40d607..be222eb6078c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -288,7 +288,6 @@ struct cpuset top_cpuset = {
>  	.flags = BIT(CS_CPU_EXCLUSIVE) |
>  		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>  	.partition_root_state = PRS_ROOT,
> -	.dl_bw_cpu = -1,
>  };
>  
>  /**
> @@ -580,8 +579,6 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>  	if (!trial)
>  		return NULL;
>  
> -	trial->dl_bw_cpu = -1;
> -
>  	/* Setup cpumask pointer array */
>  	cpumask_var_t *pmask[4] = {
>  		&trial->cpus_allowed,
> @@ -2984,6 +2981,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  static struct cpuset *cpuset_attach_old_cs;
>  static bool attach_cpus_updated;
>  static bool attach_mems_updated;
> +static bool attach_many_sources;
>  
>  /*
>   * Check to see if a cpuset can accept a new task
> @@ -3026,30 +3024,36 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
>  	return 0;
>  }
>  
> -static int cpuset_reserve_dl_bw(struct cpuset *cs)
> +/*
> + * Reverse per-task operations done in cpuset_can_attach().
> + * If @stop_at is non-NULL, only undo tasks before it (partial rollback).
> + * If @stop_at is NULL, undo all tasks (full reversal for cancel_attach).
> + * Must be called with cpuset_mutex held.
> + */
> +static void cpuset_undo_attach(struct cgroup_taskset *tset,
> +			       struct task_struct *stop_at)
>  {
> -	int cpu, ret;
> -
> -	if (!cs->sum_migrate_dl_bw)
> -		return 0;
> -
> -	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -	if (unlikely(cpu >= nr_cpu_ids))
> -		return -EINVAL;
> +	struct cgroup_subsys_state *css;
> +	struct task_struct *task;
>  
> -	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -	if (ret)
> -		return ret;
> +	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *cs = css_cs(css);
> +		struct cpuset *oldcs = task_cs(task);
>  
> -	cs->dl_bw_cpu = cpu;
> -	return 0;
> -}
> +		if (task == stop_at)
> +			break;
>  
> -static void reset_migrate_dl_data(struct cpuset *cs)
> -{
> -	cs->nr_migrate_dl_tasks = 0;
> -	cs->sum_migrate_dl_bw = 0;
> -	cs->dl_bw_cpu = -1;
> +		if (dl_task(task)) {
> +			cs->nr_deadline_tasks--;
> +			oldcs->nr_deadline_tasks++;
> +			if (dl_task_needs_bw_move(task, cs->effective_cpus)) {
> +				int cpu = cpumask_any_and(cpu_active_mask,
> +							 cs->effective_cpus);
> +				dl_bw_free(cpu, task->dl.dl_bw);
> +			}
> +		}
> +		dec_attach_in_progress_locked(cs);
> +	}
>  }
>  
>  /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
> @@ -3061,96 +3065,79 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	bool setsched_check;
>  	int ret;
>  
> -	/* used later by cpuset_attach() */
>  	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>  	oldcs = cpuset_attach_old_cs;
>  	cs = css_cs(css);
>  
>  	mutex_lock(&cpuset_mutex);
> +	attach_many_sources = false;
>  
> -	/* Check to see if task is allowed in the cpuset */
>  	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>  	if (ret)
>  		goto out_unlock;
>  
> -	/*
> -	 * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() to get
> -	 * the old_mems_allowed value. There are two ways that many-to-one
> -	 * cpuset migration can happen:
> -	 * 1) A multithread application with threads in different cpusets is
> -	 *    wholely migrated to a new cpuset.
> -	 * 2) Disabling v2 cpuset controller will move all the tasks in child
> -	 *    cpusets to the parent cpuset.
> -	 *
> -	 * In the former case, it is the mm setting of the group leader that
> -	 * really matters. So cpuset_attach_old_cs should track the oldcs of the
> -	 * group leader. It falls back to the oldcs of the first task if there
> -	 * is no group leader in the taskset. In the latter case, effective_mems
> -	 * of child cpusets must always be a subset of the parent. So no real
> -	 * page migration will be necessary no matter which child cpuset is
> -	 * selected as cpuset_attach_old_cs.
> -	 */
>  	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *newcs = css_cs(css);
> +		struct cpuset *new_oldcs = task_cs(task);
> +
> +		if (newcs != cs || new_oldcs != oldcs) {
> +			if (new_oldcs != oldcs)
> +				attach_many_sources = true;
> +			cs = newcs;
> +			oldcs = new_oldcs;
> +			ret = cpuset_can_attach_check(cs, oldcs,
> +						      &setsched_check);
> +			if (ret)
> +				goto out_rollback;
> +		}
> +
>  		ret = task_can_attach(task);
>  		if (ret)
> -			goto out_unlock;
> +			goto out_rollback;
>  
> -		/* Update cpuset_attach_old_cs to the latest group leader */
>  		if (task == task->group_leader)
>  			cpuset_attach_old_cs = task_cs(task);
>  
>  		if (setsched_check) {
>  			ret = security_task_setscheduler(task);
>  			if (ret)
> -				goto out_unlock;
> +				goto out_rollback;
>  		}
>  
>  		if (dl_task(task)) {
> -			/*
> -			 * Count all migrating DL tasks for cpuset task accounting.
> -			 * Only tasks that need a root-domain bandwidth move
> -			 * contribute to sum_migrate_dl_bw.
> -			 */
> -			cs->nr_migrate_dl_tasks++;
> -			if (dl_task_needs_bw_move(task, cs->effective_cpus))
> -				cs->sum_migrate_dl_bw += task->dl.dl_bw;
> +			cs->nr_deadline_tasks++;
> +			oldcs->nr_deadline_tasks--;
> +
> +			if (dl_task_needs_bw_move(task, cs->effective_cpus)) {
> +				int cpu = cpumask_any_and(cpu_active_mask,
> +							 cs->effective_cpus);
> +				if (unlikely(cpu >= nr_cpu_ids)) {
> +					ret = -EINVAL;
> +					goto out_rollback;
> +				}
> +				ret = dl_bw_alloc(cpu, task->dl.dl_bw);
> +				if (ret)
> +					goto out_rollback;
> +			}
>  		}
> -	}
> -
> -	ret = cpuset_reserve_dl_bw(cs);
>  
> -out_unlock:
> -	if (ret) {
> -		reset_migrate_dl_data(cs);
> -	} else {
> -		/*
> -		 * Mark attach is in progress.  This makes validate_change() fail
> -		 * changes which zero cpus/mems_allowed.
> -		 */
>  		cs->attach_in_progress++;
>  	}
>  
> +	goto out_unlock;
> +
> +out_rollback:
> +	cpuset_undo_attach(tset, task);
> +
> +out_unlock:
>  	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }
>  
>  static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>  {
> -	struct cgroup_subsys_state *css;
> -	struct cpuset *cs;
> -
> -	cgroup_taskset_first(tset, &css);
> -	cs = css_cs(css);
> -
>  	mutex_lock(&cpuset_mutex);
> -	dec_attach_in_progress_locked(cs);
> -
> -	if (cs->dl_bw_cpu >= 0)
> -		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
> -
> -	if (cs->nr_migrate_dl_tasks)
> -		reset_migrate_dl_data(cs);
> -
> +	cpuset_undo_attach(tset, NULL);
>  	mutex_unlock(&cpuset_mutex);
>  }
>  
> @@ -3232,8 +3219,15 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	mutex_lock(&cpuset_mutex);
>  	queue_task_work = false;
>  
> -	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> -	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +	if (attach_many_sources) {
> +		attach_cpus_updated = true;
> +		attach_mems_updated = true;
> +	} else {
> +		attach_cpus_updated = !cpumask_equal(cs->effective_cpus,
> +						     oldcs->effective_cpus);
> +		attach_mems_updated = !nodes_equal(cs->effective_mems,
> +						    oldcs->effective_mems);
> +	}
>  
>  	/*
>  	 * In the default hierarchy, enabling cpuset in the child cgroups
> @@ -3249,21 +3243,28 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>  	}
>  
> -	cgroup_taskset_for_each(task, css, tset)
> +	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *newcs = css_cs(css);
> +
> +		if (newcs != cs) {
> +			cs->old_mems_allowed = cpuset_attach_nodemask_to;
> +			cs = newcs;
> +			if (cpuset_v2())
> +				cpuset_attach_nodemask_to = cs->effective_mems;
> +			else
> +				guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +		}
>  		cpuset_attach_task(cs, task);
> +	}
>  
>  out:
>  	if (queue_task_work)
>  		schedule_flush_migrate_mm();
>  	cs->old_mems_allowed = cpuset_attach_nodemask_to;
>  
> -	if (cs->nr_migrate_dl_tasks) {
> -		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
> -		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
> -		reset_migrate_dl_data(cs);
> -	}
> -
> -	dec_attach_in_progress_locked(cs);
> +	/* Decrement per-task attach_in_progress */
> +	cgroup_taskset_for_each(task, css, tset)
> +		dec_attach_in_progress_locked(css_cs(css));
>  
>  	mutex_unlock(&cpuset_mutex);
>  }

-- 
Best regards,
Ridong

