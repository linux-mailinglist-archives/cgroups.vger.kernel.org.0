Return-Path: <cgroups+bounces-17412-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 714FGzB4RGpovQoAu9opvQ
	(envelope-from <cgroups+bounces-17412-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 04:15:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF76E936A
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 04:15:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IsWrkHPE;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17412-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17412-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CFD2303B9FC
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4C3630AD;
	Wed,  1 Jul 2026 02:15:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FF3630BF
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 02:15:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872107; cv=none; b=SljKkk4gQz/T3H6NYZGmjljRTYY87i36VOj5uTXB4HyKUeh9ySgIEBQEova9X0Lu4v4NXiZQ5FV4exW3UzXtdsN6oYUJtGtKJv449Bqb4jBEXDleCdQzicgp90dmvDkGWRUR5LvELshtcttihSneibhanvsjRzg5r90JT+Ci90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872107; c=relaxed/simple;
	bh=k+p9RmRy1A4Z81AQb7jwx/P+CY94fuGejI8VtyS6C74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSqOdaAxTfn19sn4jk1Esncyd68g7v2QlLLQNDFtjn7V6qnonLRGECyoMp6QXvI5wea8TQRRSUIsUiGjQMIaMUQRxLriDdglH4kBZ/i9ME/b/iTRm/xP0KRK18vf8ehRnrKGdM2AGm12Q84+unruixZR4fMDXDZ5r6DTlM2HC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IsWrkHPE; arc=none smtp.client-ip=91.218.175.178
Message-ID: <33151a98-3d3d-4a11-9919-2bf38aa83f76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782872091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0fpQae9+H0z3yf8NaJ71qIOg3xUmfB2m91dIE9eL0I=;
	b=IsWrkHPE3OWPCi94xEiMBhtH+KYCbnFqdyGb51HIc4wtPIuHRJoTXCqR3ptZ0O7G4Ebkxj
	Hk0Ou50Fx+1qqEyNo8T1a+nqcqBLWArrUY9K+9DZ10AXPbOUQwpWQB3iZaoqO7SxBkBXfl
	VHlDD3+BSSvZ/Uj0o0nh+rq1OC2rFY4=
Date: Wed, 1 Jul 2026 10:14:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v9 08/11] cgroup/cpuset: Move
 mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-9-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260630033344.352702-9-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17412-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01BF76E936A



On 6/30/2026 11:33 AM, Waiman Long wrote:
> The cpuset_attach_task() was introduced in commit 42a11bf5c543
> ("cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly")
> to enable the CLONE_INTO_CGROUP flag of clone(2) to behave more like
> moving a task from one cpuset into another one. That commits didn't
> move the mpol_rebind_mm() and cpuset_migrate_mm() calls for group leader
> into cpuset_attach_task().
> 
> When the CLONE_INTO_CGROUP flag is used without CLONE_THREAD, the new
> task is its own group leader. So it is still not equivalent to moving
> task between cpusets in this case. Make CLONE_INTO_CGROUP behaves
> more close to cpuset_attach() by moving the mpol_rebind_mm() and
> cpuset_migrate_mm() calls inside cpuset_attach_task().
> 
> Also move the stack local cpus_updated, mems_updated and queue_task_work
> flags into attach_ctx so that these flags can be accessed inside and
> outside of cpuset_attach_task(). The cpuset_fork() function is updated
> to set up these flags and do memory migration if necessary.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 104 ++++++++++++++++++++++++-----------------
>   1 file changed, 60 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 55cd580373b7..0b9df38e9a63 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -362,6 +362,9 @@ static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
>    */
>   static struct {
>   	int in_progress;
> +	bool cpus_updated;
> +	bool mems_updated;
> +	bool task_work_queued;
>   	struct cpuset *old_cs;	/* Source cpuset */
>   	nodemask_t nodemask_to;
>   } attach_ctx;
> @@ -3190,6 +3193,8 @@ static cpumask_var_t cpus_attach;
>   
>   static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   {
> +	struct mm_struct *mm;
> +
>   	lockdep_assert_cpuset_lock_held();
>   
>   	if (cs != &top_cpuset)
> @@ -3203,28 +3208,60 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	 */
>   	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>   
> +	if (cpuset_v2() && !attach_ctx.mems_updated)
> +		return;
> +
>   	cpuset_change_task_nodemask(task, &attach_ctx.nodemask_to);
>   	cpuset1_update_task_spread_flags(cs, task);
> +
> +	if ((task != task->group_leader) ||
> +	    (!is_memory_migrate(cs) && !attach_ctx.mems_updated))
> +		return;
> +

Nit.

IIUC, the !is_memory_migrate(cs) check may be unnecessary. Previously, 
placing this condition outside could prevent an unnecessary loop, but in 
its current position, it appears redundant.

	if (task != task->group_leader ||
	    !attach_ctx.mems_updated)

> +	/*
> +	 * Change mm for threadgroup leader. This is expensive and may
> +	 * sleep and should be moved outside migration path proper.
> +	 */
> +	mm = get_task_mm(task);
> +	if (mm) {
> +		struct cpuset *oldcs = attach_ctx.old_cs;
> +
> +		mpol_rebind_mm(mm, &cs->effective_mems);
> +
> +		/*
> +		 * old_mems_allowed is the same with mems_allowed
> +		 * here, except if this task is being moved
> +		 * automatically due to hotplug.  In that case
> +		 * @mems_allowed has been updated and is empty, so
> +		 * @old_mems_allowed is the right nodesets that we
> +		 * migrate mm from.
> +		 */
> +		if (is_memory_migrate(cs)) {
> +			cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
> +					  &attach_ctx.nodemask_to);
> +			attach_ctx.task_work_queued = true;
> +		} else {
> +			mmput(mm);
> +		}
> +	}
>   }
>   
>   static void cpuset_attach(struct cgroup_taskset *tset)
>   {
>   	struct task_struct *task;
> -	struct task_struct *leader;
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *cs;
>   	struct cpuset *oldcs = attach_ctx.old_cs;
> -	bool cpus_updated, mems_updated;
> -	bool queue_task_work = false;
>   
>   	cgroup_taskset_first(tset, &css);
>   	cs = css_cs(css);
>   
>   	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
>   	mutex_lock(&cpuset_mutex);
> -	cpus_updated = !cpumask_equal(cs->effective_cpus,
> -				      oldcs->effective_cpus);
> -	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +	attach_ctx.task_work_queued = false;
> +
> +	attach_ctx.cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> +	attach_ctx.mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
>   	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
>   
>   	/*
> @@ -3233,46 +3270,14 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	 * and mems. In that case, we can optimize out by skipping the task
>   	 * iteration and update.
>   	 */
> -	if (cpuset_v2() && !cpus_updated && !mems_updated)
> +	if (cpuset_v2() && !attach_ctx.cpus_updated && !attach_ctx.mems_updated)
>   		goto out;
>   
>   	cgroup_taskset_for_each(task, css, tset)
>   		cpuset_attach_task(cs, task);
>   
> -	/*
> -	 * Change mm for all threadgroup leaders. This is expensive and may
> -	 * sleep and should be moved outside migration path proper. Skip it
> -	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
> -	 * not set.
> -	 */
> -	if (!is_memory_migrate(cs) && !mems_updated)
> -		goto out;
> -
> -	cgroup_taskset_for_each_leader(leader, css, tset) {
> -		struct mm_struct *mm = get_task_mm(leader);
> -
> -		if (mm) {
> -			mpol_rebind_mm(mm, &cs->effective_mems);
> -
> -			/*
> -			 * old_mems_allowed is the same with mems_allowed
> -			 * here, except if this task is being moved
> -			 * automatically due to hotplug.  In that case
> -			 * @mems_allowed has been updated and is empty, so
> -			 * @old_mems_allowed is the right nodesets that we
> -			 * migrate mm from.
> -			 */
> -			if (is_memory_migrate(cs)) {
> -				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
> -						  &attach_ctx.nodemask_to);
> -				queue_task_work = true;
> -			} else
> -				mmput(mm);
> -		}
> -	}
> -
>   out:
> -	if (queue_task_work)
> +	if (attach_ctx.task_work_queued)
>   		schedule_flush_migrate_mm();
>   	cs->old_mems_allowed = attach_ctx.nodemask_to;
>   
> @@ -3708,15 +3713,14 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
>    */
>   static void cpuset_fork(struct task_struct *task)
>   {
> -	struct cpuset *cs;
> -	bool same_cs;
> +	struct cpuset *cs, *oldcs;
>   
>   	rcu_read_lock();
>   	cs = task_cs(task);
> -	same_cs = (cs == task_cs(current));
> +	oldcs = task_cs(current);
>   	rcu_read_unlock();
>   
> -	if (same_cs) {
> +	if (cs == oldcs) {
>   		if (cs == &top_cpuset)
>   			return;
>   
> @@ -3728,7 +3732,19 @@ static void cpuset_fork(struct task_struct *task)
>   	/* CLONE_INTO_CGROUP */
>   	mutex_lock(&cpuset_mutex);
>   	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
> +	cs->old_mems_allowed = attach_ctx.nodemask_to;
> +
> +	/*
> +	 * Assume CPUs and memory nodes are updated
> +	 * A CLONE_INTO_CGROUP operation should have taken the cgroup mutex
> +	 * and so there shouldn't be a competing cpuset_attach() operation.
> +	 */
> +	attach_ctx.cpus_updated = attach_ctx.mems_updated = true;
> +	attach_ctx.task_work_queued = false;
> +	attach_ctx.old_cs = oldcs;
>   	cpuset_attach_task(cs, task);
> +	if (attach_ctx.task_work_queued)
> +		schedule_flush_migrate_mm();
>   
>   	dec_attach_in_progress_locked();
>   	mutex_unlock(&cpuset_mutex);

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards
Ridong


