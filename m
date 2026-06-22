Return-Path: <cgroups+bounces-17115-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iSpHEDKjOGr+ewcAu9opvQ
	(envelope-from <cgroups+bounces-17115-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 04:51:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A30466AC37A
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 04:51:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="hKLi/NL7";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17115-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17115-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FE013017FB2
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE83358B9;
	Mon, 22 Jun 2026 02:48:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0545474F
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 02:48:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096527; cv=none; b=d1rJKiYzizC7IkDLQJpmQrhsDRYrkqp/a4mGHjf7ogrp/YNdBoQujvxyGfOiAaiM/rnTMHf16kKWizkdGZAbqbOYenEj5i6BZGYfkW6BeG9WA8x2TrS308vi+ce2KIPu4Cpe55SzOv0yHBMAwMsB/2htHA1Q07B/0GM/JgtApJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096527; c=relaxed/simple;
	bh=sBBgWHgY4sZTLA3OffZotlgP5uyifoCoEvsURKr/+u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWht6JJpouWkRW36MAZZTa0PvbtwBBr87G+SGo8LpicLMfkil9/lElhZEJ1Gyx5jSdtyj1SJaw6lSguCDZs5hF8QKik4EO9rxVGbmOBoDzHUNX+aUiBH54suau37hEbLv9G+orx8OJcc0ruPcnBFWjnJlKC+HxPmGaOZOxwLu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hKLi/NL7; arc=none smtp.client-ip=91.218.175.189
Message-ID: <e8fb50d3-0831-4caf-b4e4-2af94ac86263@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782096512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JH9HFGHp4wzXnsWFJYE2FW32AhiIJ7QrLRXx/qg8cr8=;
	b=hKLi/NL7QjLjB884fGHD2ssyh5i95mRyLilltyhtAA86wFzgegTV1pkI1vdcyK0GmV7n8A
	CMopimN1Mlv9+ZjnRww6+8PZKK/awhECY//MjxuXKOmQ/LJJsgUhHPsjZWD/BFan/D/t/D
	gM1xXkRUCwn1yw8FLFP1AeEais5KC7I=
Date: Mon, 22 Jun 2026 10:48:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 7/9] cgroup/cpuset: Move
 mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Li Zefan <lizefan@huawei.com>,
 Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>,
 Gregory Price <gourry@gourry.net>, David Hildenbrand <david@kernel.org>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-8-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260621032816.1806773-8-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-17115-lists,cgroups=lfdr.de];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A30466AC37A



On 6/21/2026 11:28 AM, Waiman Long wrote:
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
> cpuset_migrate_mm() calls inside cpuset_attach_task(). As a result,
> the following static variables will have to be updated in cpuset_fork().
>   - cpuset_attach_old_cs
>   - attach_cpus_updated
>   - attach_mems_updated
>   - queue_task_work
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 105 ++++++++++++++++++++++++-----------------
>   1 file changed, 62 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0375dae26d0b..511afb077e2d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2981,8 +2981,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   /*
>    * cpuset_can_attach() and cpuset_attach() specific internal data
>    * Protected by cpuset_mutex
> + *
> + * The attach_cpus_updated/attach_mems_updated flags are set in either
> + * cpuset_attach() or cpuset_fork() and used in cpuset_attach_task().
>    */
>   static struct cpuset *cpuset_attach_old_cs;
> +static bool attach_cpus_updated;
> +static bool attach_mems_updated;
>   
>   /*
>    * Check to see if a cpuset can accept a new task
> @@ -3157,9 +3162,12 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>    */
>   static cpumask_var_t cpus_attach;
>   static nodemask_t cpuset_attach_nodemask_to;
> +static bool queue_task_work;
>   

There are more and more of these standalone state variables now, and 
it's getting harder to maintain. Could we group them into a struct and 
manage them together rather than keep adding globals?

Just like:

```
struct cpuset_attach_ctx {
	struct cpuset     *old_cs;
	struct llist_head src_cs, dst_cs;
	bool              cpus_updated, mems_updated, queue_work;
	nodemask_t        nodemask_to;
};
```

>   static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   {
> +	struct mm_struct *mm;
> +
>   	lockdep_assert_cpuset_lock_held();
>   
>   	if (cs != &top_cpuset)
> @@ -3173,28 +3181,60 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	 */
>   	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>   
> +	if (cpuset_v2() && !attach_mems_updated)
> +		return;
> +
>   	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
>   	cpuset1_update_task_spread_flags(cs, task);
> +
> +	if ((task != task->group_leader) ||
> +	    (!is_memory_migrate(cs) && !attach_mems_updated))
> +		return;
> +
> +	/*
> +	 * Change mm for threadgroup leader. This is expensive and may
> +	 * sleep and should be moved outside migration path proper.
> +	 */
> +	mm = get_task_mm(task);
> +	if (mm) {
> +		struct cpuset *oldcs = cpuset_attach_old_cs;
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
> +					  &cpuset_attach_nodemask_to);
> +			queue_task_work = true;
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
>   	struct cpuset *oldcs = cpuset_attach_old_cs;
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
> +	queue_task_work = false;
> +
> +	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> +	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
>   	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>   
>   	/*
> @@ -3203,44 +3243,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	 * and mems. In that case, we can optimize out by skipping the task
>   	 * iteration and update.
>   	 */
> -	if (cpuset_v2() && !cpus_updated && !mems_updated)
> +	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated)
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
> -						  &cpuset_attach_nodemask_to);
> -				queue_task_work = true;
> -			} else
> -				mmput(mm);
> -		}
> -	}
> -
>   out:
>   	if (queue_task_work)
>   		schedule_flush_migrate_mm();
> @@ -3689,15 +3697,14 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
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
> @@ -3709,7 +3716,19 @@ static void cpuset_fork(struct task_struct *task)
>   	/* CLONE_INTO_CGROUP */
>   	mutex_lock(&cpuset_mutex);
>   	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +	cs->old_mems_allowed = cpuset_attach_nodemask_to;
> +
> +	/*
> +	 * Assume CPUs and memory nodes are updated
> +	 * A CLONE_INTO_CGROUP operation should have taken the cgroup mutex
> +	 * and so there shouldn't be a competing cpuset_attach() operation.
> +	 */
> +	attach_cpus_updated = attach_mems_updated = true;
> +	queue_task_work = false;
> +	cpuset_attach_old_cs = oldcs;
>   	cpuset_attach_task(cs, task);
> +	if (queue_task_work)
> +		schedule_flush_migrate_mm();
>   
>   	dec_attach_in_progress_locked(cs);
>   	mutex_unlock(&cpuset_mutex);

-- 
Best regards
Ridong


