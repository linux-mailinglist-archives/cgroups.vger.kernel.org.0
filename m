Return-Path: <cgroups+bounces-17411-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /yIxK1NwRGpfuwoAu9opvQ
	(envelope-from <cgroups+bounces-17411-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 03:41:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 073686E914F
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 03:41:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=XX7VMDvS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17411-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17411-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C5EC30247E5
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 01:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D503546F1;
	Wed,  1 Jul 2026 01:41:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3634D385
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 01:41:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870094; cv=none; b=S2iVKvdjR9j8HZ/1uEYyXrAAsEZQNZCDJ7eUpgGjiG8hzZYX9jqzbI0erP/NDckVszgqIuXt2xdtnIzjcGK4EazS689IiswLuDDRttQDMnQpi/q5d1rQgV+KAlhhy9IFo48c7l89q19Hcinkd2gZaWz1WpG4W6zL5pVwDU4qrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870094; c=relaxed/simple;
	bh=fISSsi9q4ppHTxE9gVxjH6ipPm9PXHZfo6xwDLK8fjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO8oC6koLE4LdDbpMIetFIba40exaaBvbY6U/jfCnPWcjHIggb/6iCJbGtaduUEppYtqaN5ENutrcmlEcoAEhrDYlhHgS6int4cK8F8AUHRpqkEAYcvQQUrFhQiMCkjnKHCUaT0tNWxqgPFhY0ux0mtUEIe7H2Ugri15w1Pj+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XX7VMDvS; arc=none smtp.client-ip=91.218.175.189
Message-ID: <e28a38fa-5998-4e73-886c-2cbbd26ae98f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782870089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdZreJfJHlBP0nrfmNEqS6amNcZzmZOjYNZtIjg7/YQ=;
	b=XX7VMDvSMCX3922YR0mgMXuFneJyJcIUcAtg0e68VK2dRBtEE5FmWM8qNLbwi5ck3o97sA
	NQzzGZi2/HjyVDdT8p+E9vsF56bDWu5oKA90fvqDHIfMFlS/kQgkIfG2qlZUqGGC2DFfLU
	mqedHyGqzhT4ycHmlBfSwkVbImHvL8s=
Date: Wed, 1 Jul 2026 09:41:22 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v9 03/11] cgroup/cpuset: Prevent race between task
 attach and cpuset state change
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-4-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260630033344.352702-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17411-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 073686E914F



On 6/30/2026 11:33 AM, Waiman Long wrote:
> Commit e44193d39e8d ("cpuset: let hotplug propagation work wait for
> task attaching") was introduced to let hotplug operation to wait
> until the completion of task attach operation. However, it is still
> possible that the states of the source or destination cpuset can
> be changed between the cpuset_can_attach() call and the subsequent
> cpuset_attach()/cpuset_cacnel_attach() call.
> 
> As a result, data gathered during cpuset_can_attach() cannot be reliably
> used in the subsequent cpuset_attach()/cpuset_cacnel_attach()
> call at all. Make the task attach operation more robust
> and allow the sharing of data between cpuset_can_attach() and
> cpuset_attach()/cpuset_cacnel_attach() by making cpuset_write_resmask()
> and cpuset_partition_write() wait for the completion of task attach
> as well.
> 

Nit.

s/cpuset_cacnel_attach/cpuset_cancel_attach/

> Ideally, an ongoing task attach operation should block any cpuset write
> operation that can change its internal state until the operation is
> completed. However, the attach_in_progress flag is currently per cpuset
> and only the destination cpuset will have this flag set. The flag is not
> set in the source cpuset where the tasks will be moved from. Even if we
> extend the scope to include the source cpuset, it will not block cpuset
> operation that changes the state of one of its ancestor cpuset which may
> indirectly impact the state of the source or destination cpuset. It may
> be too costly to set the flag for the whole subtree, it is far easier
> to just make the flag global and block all the cpuset write operation
> whenever a task attach operation is in progress.
> 
> Make that change by creating a new cpuset attach context (attach_ctx)
> structure to hold the global in_progress flag and use it for blocking
> cpuset write operation if a cpuset attach operation is in progress. Also
> add a new wait_attach_done_lock() helper to do the waiting for an
> ongoing attach operation and acquire the cpuset_mutex.
> 
> The comments about validate_change() are no longer valid as it won't
> be called at all if an attach operation is in progress. So the comments
> can be removed.
> 
> The per-cpuset attach_in_progress flag is also currently used in
> partition_is_populated() and cpuset_is_populated() to determine if
> an empty cpuset will have incoming task. This check will no longer be
> needed as this function will not be called when there is a task attach
> in progress. So the flag check is now removed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-internal.h | 11 +---
>   kernel/cgroup/cpuset.c          | 90 +++++++++++++++++++--------------
>   2 files changed, 53 insertions(+), 48 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 140700e5e236..df662c7fd1a4 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -145,12 +145,6 @@ struct cpuset {
>   	 */
>   	nodemask_t old_mems_allowed;
>   
> -	/*
> -	 * Tasks are being attached to this cpuset.  Used to prevent
> -	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
> -	 */
> -	int attach_in_progress;
> -
>   	/* partition root state */
>   	int partition_root_state;
>   
> @@ -269,10 +263,7 @@ static inline int nr_cpusets(void)
>   static inline bool cpuset_is_populated(struct cpuset *cs)
>   {
>   	lockdep_assert_cpuset_lock_held();
> -
> -	/* Cpusets in the process of attaching should be considered as populated */
> -	return cgroup_is_populated(cs->css.cgroup) ||
> -		cs->attach_in_progress;
> +	return cgroup_is_populated(cs->css.cgroup);
>   }
>   
>   /**
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 431bf210aa52..1a78d0590737 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -356,6 +356,33 @@ static struct workqueue_struct *cpuset_migrate_mm_wq;
>   
>   static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
>   
> +/*
> + * Cpuset task attach context
> + * Protected by cpuset_mutex
> + */
> +static struct {
> +	int in_progress;
> +} attach_ctx;
> +
> +/*
> + * Wait if task attach is in progress until it is done and then acquire
> + * cpuset_mutex before returning.
> + */
> +static void wait_attach_done_lock(void)
> +	    __acquires(&cpuset_mutex)
> +{
> +	for (;;) {
> +		mutex_lock(&cpuset_mutex);
> +		if (!attach_ctx.in_progress)
> +			return;
> +
> +		mutex_unlock(&cpuset_mutex);
> +
> +		/* Wait until attach operation is done to prevent racing */
> +		wait_event(cpuset_attach_wq, attach_ctx.in_progress == 0);
> +	}
> +}
> +
>   static inline void check_insane_mems_config(nodemask_t *nodes)
>   {
>   	if (!cpusets_insane_config() &&
> @@ -368,22 +395,22 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
>   }
>   
>   /*
> - * decrease cs->attach_in_progress.
> - * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
> + * decrease attach_ctx.in_progress.
> + * wake_up cpuset_attach_wq if attach_ctx.in_progress==0.
>    */
> -static inline void dec_attach_in_progress_locked(struct cpuset *cs)
> +static inline void dec_attach_in_progress_locked(void)
>   {
>   	lockdep_assert_cpuset_lock_held();
>   
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> +	attach_ctx.in_progress--;
> +	if (!attach_ctx.in_progress)
>   		wake_up(&cpuset_attach_wq);
>   }
>   
> -static inline void dec_attach_in_progress(struct cpuset *cs)
> +static inline void dec_attach_in_progress(void)
>   {
>   	mutex_lock(&cpuset_mutex);
> -	dec_attach_in_progress_locked(cs);
> +	dec_attach_in_progress_locked();
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> @@ -432,8 +459,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
>   	 * nr_populated_domain_children may include populated
>   	 * csets from descendants that are partitions.
>   	 */
> -	if (cgroup_has_tasks(cs->css.cgroup) ||
> -	    cs->attach_in_progress)
> +	if (cgroup_has_tasks(cs->css.cgroup))
>   		return true;
>   
>   	rcu_read_lock();
> @@ -3091,11 +3117,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	cs->dl_bw_cpu = cpu;
>   
>   out_success:
> -	/*
> -	 * Mark attach is in progress.  This makes validate_change() fail
> -	 * changes which zero cpus/mems_allowed.
> -	 */
> -	cs->attach_in_progress++;
> +	attach_ctx.in_progress++;
>   
>   out_unlock:
>   	if (ret)
> @@ -3113,7 +3135,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
> -	dec_attach_in_progress_locked(cs);
> +	dec_attach_in_progress_locked();
>   
>   	if (cs->dl_bw_cpu >= 0)
>   		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
> @@ -3226,7 +3248,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   		reset_migrate_dl_data(cs);
>   	}
>   
> -	dec_attach_in_progress_locked(cs);
> +	dec_attach_in_progress_locked();
>   
>   	mutex_unlock(&cpuset_mutex);
>   }
> @@ -3246,7 +3268,12 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   		return -EACCES;
>   
>   	buf = strstrip(buf);
> -	cpuset_full_lock();
> +
> +	/* cpuset_mutex acquired in wait_attach_done_lock() */
> +	mutex_lock(&cpuset_top_mutex);
> +	cpus_read_lock();
> +	wait_attach_done_lock();
> +

Would it be cleaner to just pass this into cpuset_full_lock() as a flag?

void cpuset_full_lock(bool wait_attach)
{
       mutex_lock(&cpuset_top_mutex);
       cpus_read_lock();
       if (wait_attach)
               wait_attach_done_lock();
       else
               mutex_lock(&cpuset_mutex);
}
Then the two write paths become a single cpuset_full_lock(true). The
downside is the other 6 callers would need cpuset_full_lock(false). Not 
sure it's worth it â what do you think?

>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> @@ -3377,7 +3404,10 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
>   	else
>   		return -EINVAL;
>   
> -	cpuset_full_lock();
> +	mutex_lock(&cpuset_top_mutex);
> +	cpus_read_lock();
> +	wait_attach_done_lock();
> +
>   	if (is_cpuset_online(cs))
>   		retval = update_prstate(cs, val);
>   	cpuset_update_sd_hk_unlock();
> @@ -3616,11 +3646,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
>   	if (ret)
>   		goto out_unlock;
>   
> -	/*
> -	 * Mark attach is in progress.  This makes validate_change() fail
> -	 * changes which zero cpus/mems_allowed.
> -	 */
> -	cs->attach_in_progress++;
> +	attach_ctx.in_progress++;
>   out_unlock:
>   	mutex_unlock(&cpuset_mutex);
>   	return ret;
> @@ -3638,7 +3664,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
>   	if (same_cs)
>   		return;
>   
> -	dec_attach_in_progress(cs);
> +	dec_attach_in_progress();
>   }
>   
>   /*
> @@ -3670,7 +3696,7 @@ static void cpuset_fork(struct task_struct *task)
>   	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>   	cpuset_attach_task(cs, task);
>   
> -	dec_attach_in_progress_locked(cs);
> +	dec_attach_in_progress_locked();
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> @@ -3774,20 +3800,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   	bool remote;
>   	int partcmd = -1;
>   	struct cpuset *parent;
> -retry:
> -	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
> -
> -	mutex_lock(&cpuset_mutex);
> -
> -	/*
> -	 * We have raced with task attaching. We wait until attaching
> -	 * is finished, so we won't attach a task to an empty cpuset.
> -	 */
> -	if (cs->attach_in_progress) {
> -		mutex_unlock(&cpuset_mutex);
> -		goto retry;
> -	}
>   
> +	wait_attach_done_lock();
>   	parent = parent_cs(cs);
>   	compute_effective_cpumask(&new_cpus, cs, parent);
>   	compute_effective_nodemask(&new_mems, cs, parent);

Overall this looks good to me.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards
Ridong


