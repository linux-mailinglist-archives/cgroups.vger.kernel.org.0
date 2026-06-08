Return-Path: <cgroups+bounces-16743-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJRkD5gRJ2qZrAIAu9opvQ
	(envelope-from <cgroups+bounces-16743-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 21:01:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90526659F3D
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 21:01:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZyFcenUm;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16743-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16743-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0CBB307370B
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412A3D9048;
	Mon,  8 Jun 2026 18:50:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BD3E00B8
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 18:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944601; cv=none; b=CrVY1qCzAT2YCu44e/1Ce07p2EU4eQyte4t0gq1AZkKn27stt5yHSIBcqwHxRGqOPABp7JjEMryGFrvRLu8rUAo0B1/zP+NxhnzQbxern7fIzvU8CacDK6C+OlGz0StLStX87tOwtQgk9ZSQQq0j6iK95XBZvJ7zokHuwSONX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944601; c=relaxed/simple;
	bh=66TAWgWrpW/xqdKZGOh7jvDXqykRUDDWtX1ecZJBLvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMq5rkCj7WCazYuQXfuuniuyPe/JwqclPKkRgnLJc16DYB1b6suTcERMqQUnOvnJgvicMYrPt+dq6Ut3MdIxoW/eYXAlkoAgB09FxaQgKuJHDb+7FhAnLhz4TRvCkWy0V/35ilJ9XgAeSd8/X32JyQKG9luwTAJXF4JXuapfxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyFcenUm; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780944595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y72g0dxxwa8Q1Z7zZ3mssBLxL35CpgIscapI/HIhd8I=;
	b=ZyFcenUmgqFDkJIBioij/X3EgSiqDEmIWfogvr7oPL0hKjpkEj1xorid/ky7lvQXqPWF1J
	zWcRhPRDoNdrWdPHQtPIxlK0rNx4vQdI8JYSi4X+0e1B4lbZ0XyGXBk+O2wgwy6tkgCT5x
	heDQsFPngm4e7kv/rkI3tPNlWM1T3cE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-m6UGjM7LMPu30Fb9BH0mzw-1; Mon,
 08 Jun 2026 14:49:52 -0400
X-MC-Unique: m6UGjM7LMPu30Fb9BH0mzw-1
X-Mimecast-MFC-AGG-ID: m6UGjM7LMPu30Fb9BH0mzw_1780944591
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E64E419560BA;
	Mon,  8 Jun 2026 18:49:50 +0000 (UTC)
Received: from [10.22.81.1] (unknown [10.22.81.1])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE1B61954B3E;
	Mon,  8 Jun 2026 18:49:49 +0000 (UTC)
Message-ID: <e7bbd0b7-6c44-4875-aaed-160791adc9b2@redhat.com>
Date: Mon, 8 Jun 2026 14:49:49 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Support multiple source/destination
 cpusets using pids pattern
To: Ridong Chen <ridong.chen@linux.dev>
Cc: cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
References: <110456d5-7164-4032-ae4f-81a97ed96504@redhat.com>
 <20260607031259.79541-1-ridong.chen@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260607031259.79541-1-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16743-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90526659F3D


On 6/6/26 11:12 PM, Ridong Chen wrote:
> When the cpuset controller is enabled/disabled in a parent cgroup, tasks
> from multiple child cpusets need to be migrated. The current code only
> handles a single source/destination pair.
>
> Support multiple source/destination cpusets by adopting the per-task
> processing pattern similar to the pids controller:
>
> 1) Perform per-task DL bandwidth reservation (dl_bw_alloc) directly in
>     cpuset_can_attach() instead of batching into sum_migrate_dl_bw. This
>     eliminates the sum_migrate_dl_bw and dl_bw_cpu fields from the cpuset
>     struct.
>
> 2) Track attach_in_progress per-task per-destination cpuset to properly
>     guard all involved cpusets from having their cpus/mems zeroed.
>
> 3) Use a shared cpuset_undo_attach() helper for both rollback-on-error
>     in cpuset_can_attach() and for cpuset_cancel_attach().
>
> 4) Detect many-source migrations and force cpus_updated/mems_updated
>     to true so all tasks get properly updated during attach.
>
> 5) Defer nr_deadline_tasks updates to cpuset_attach() (after migration
>     is committed) to avoid a race with dl_rebuild_rd_accounting() that
>     could see inconsistent values between can_attach and attach.
>
> Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
> ---
>   kernel/cgroup/cpuset-internal.h |   7 --
>   kernel/cgroup/cpuset.c          | 167 ++++++++++++++++----------------
>   2 files changed, 84 insertions(+), 90 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index f7aaf01f7cd5..8f32cb97eb94 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -167,13 +167,6 @@ struct cpuset {
>   	 */
>   	int nr_deadline_tasks;
>   	int nr_migrate_dl_tasks;
> -	/* DL bandwidth that needs destination reservation for this attach. */
> -	u64 sum_migrate_dl_bw;
> -	/*
> -	 * CPU used for temporary DL bandwidth allocation during attach;
> -	 * -1 if no DL bandwidth was allocated in the current attach.
> -	 */
> -	int dl_bw_cpu;
>   
>   	/* Invalid partition error code, not lock protected */
>   	enum prs_errcode prs_err;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e52a5a40d607..a6d96a39cdb1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -288,7 +288,6 @@ struct cpuset top_cpuset = {
>   	.flags = BIT(CS_CPU_EXCLUSIVE) |
>   		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
> -	.dl_bw_cpu = -1,
>   };
>   
>   /**
> @@ -580,8 +579,6 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>   	if (!trial)
>   		return NULL;
>   
> -	trial->dl_bw_cpu = -1;
> -
>   	/* Setup cpumask pointer array */
>   	cpumask_var_t *pmask[4] = {
>   		&trial->cpus_allowed,
> @@ -3026,31 +3023,36 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
>   	return 0;
>   }
>   
> -static int cpuset_reserve_dl_bw(struct cpuset *cs)
> +/*
> + * Undo DL bandwidth reservations and attach_in_progress increments done
> + * in cpuset_can_attach(). Used for both rollback on error and cancel_attach.
> + * If @stop_at is non-NULL, undo only for tasks before @stop_at in the tset.
> + */
> +static void cpuset_undo_attach(struct cgroup_taskset *tset,
> +			       struct task_struct *stop_at)
>   {
> -	int cpu, ret;
> -
> -	if (!cs->sum_migrate_dl_bw)
> -		return 0;
> +	struct cgroup_subsys_state *css;
> +	struct task_struct *task;
>   
> -	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -	if (unlikely(cpu >= nr_cpu_ids))
> -		return -EINVAL;
> +	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *cs = css_cs(css);
>   
> -	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -	if (ret)
> -		return ret;
> +		if (task == stop_at)
> +			break;
>   
> -	cs->dl_bw_cpu = cpu;
> -	return 0;
> +		if (dl_task(task)) {
> +			cs->nr_migrate_dl_tasks--;
> +			if (dl_task_needs_bw_move(task, cs->effective_cpus)) {
> +				int cpu = cpumask_any_and(cpu_active_mask,
> +							 cs->effective_cpus);
> +				dl_bw_free(cpu, task->dl.dl_bw);
> +			}
> +		}
> +		dec_attach_in_progress_locked(cs);
> +	}
>   }
>   
> -static void reset_migrate_dl_data(struct cpuset *cs)
> -{
> -	cs->nr_migrate_dl_tasks = 0;
> -	cs->sum_migrate_dl_bw = 0;
> -	cs->dl_bw_cpu = -1;
> -}
> +static bool attach_many_sources;
>   
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>   static int cpuset_can_attach(struct cgroup_taskset *tset)
> @@ -3067,90 +3069,73 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
> +	attach_many_sources = false;
>   
>   	/* Check to see if task is allowed in the cpuset */
>   	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>   	if (ret)
>   		goto out_unlock;
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
>   	cgroup_taskset_for_each(task, css, tset) {
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
>   		ret = task_can_attach(task);
>   		if (ret)
> -			goto out_unlock;
> +			goto out_rollback;
>   
> -		/* Update cpuset_attach_old_cs to the latest group leader */
>   		if (task == task->group_leader)
>   			cpuset_attach_old_cs = task_cs(task);
>   
>   		if (setsched_check) {
>   			ret = security_task_setscheduler(task);
>   			if (ret)
> -				goto out_unlock;
> +				goto out_rollback;
>   		}
>   
>   		if (dl_task(task)) {
> -			/*
> -			 * Count all migrating DL tasks for cpuset task accounting.
> -			 * Only tasks that need a root-domain bandwidth move
> -			 * contribute to sum_migrate_dl_bw.
> -			 */
>   			cs->nr_migrate_dl_tasks++;
> -			if (dl_task_needs_bw_move(task, cs->effective_cpus))
> -				cs->sum_migrate_dl_bw += task->dl.dl_bw;
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
>   		}
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
>   		cs->attach_in_progress++;
>   	}
>   
> +	goto out_unlock;
> +
> +out_rollback:
> +	cpuset_undo_attach(tset, task);
> +
> +out_unlock:
>   	mutex_unlock(&cpuset_mutex);
>   	return ret;
>   }
>   
>   static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   {
> -	struct cgroup_subsys_state *css;
> -	struct cpuset *cs;
> -
> -	cgroup_taskset_first(tset, &css);
> -	cs = css_cs(css);
> -
>   	mutex_lock(&cpuset_mutex);
> -	dec_attach_in_progress_locked(cs);
> -
> -	if (cs->dl_bw_cpu >= 0)
> -		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
> -
> -	if (cs->nr_migrate_dl_tasks)
> -		reset_migrate_dl_data(cs);
> -
> +	cpuset_undo_attach(tset, NULL);
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> @@ -3232,8 +3217,15 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	mutex_lock(&cpuset_mutex);
>   	queue_task_work = false;
>   
> -	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> -	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +	if (attach_many_sources) {
> +		attach_cpus_updated = true;
> +		attach_mems_updated = true;
> +	} else {
> +		attach_cpus_updated = !cpumask_equal(cs->effective_cpus,
> +						    oldcs->effective_cpus);
> +		attach_mems_updated = !nodes_equal(cs->effective_mems,
> +						   oldcs->effective_mems);
> +	}
>   
>   	/*
>   	 * In the default hierarchy, enabling cpuset in the child cgroups
> @@ -3250,20 +3242,29 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	}
>   
>   	cgroup_taskset_for_each(task, css, tset)
> -		cpuset_attach_task(cs, task);
> +		cpuset_attach_task(css_cs(css), task);
>   
>   out:
>   	if (queue_task_work)
>   		schedule_flush_migrate_mm();
>   	cs->old_mems_allowed = cpuset_attach_nodemask_to;
>   
> -	if (cs->nr_migrate_dl_tasks) {
> -		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
> -		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
> -		reset_migrate_dl_data(cs);
> -	}
> +	/*
> +	 * Update nr_deadline_tasks now that migration is committed.
> +	 * nr_migrate_dl_tasks was accumulated per-dst in can_attach but
> +	 * nr_deadline_tasks is deferred to here to avoid a race with
> +	 * dl_rebuild_rd_accounting() between can_attach and attach.
> +	 */
> +	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *dst_cs = css_cs(css);
>   
> -	dec_attach_in_progress_locked(cs);
> +		if (dst_cs->nr_migrate_dl_tasks) {
> +			dst_cs->nr_deadline_tasks += dst_cs->nr_migrate_dl_tasks;
> +			oldcs->nr_deadline_tasks -= dst_cs->nr_migrate_dl_tasks;
> +			dst_cs->nr_migrate_dl_tasks = 0;
> +		}
> +		dec_attach_in_progress_locked(dst_cs);
> +	}

You are assuming that there is only one source cpuset. That may not be 
true. I suppose that we may not track the set of destination cpusets and 
they will be hit during task iteration. We will still need to track all 
the source cpusets.

Cheers,
Longman

>   
>   	mutex_unlock(&cpuset_mutex);
>   }


