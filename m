Return-Path: <cgroups+bounces-17415-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XU8ALLiARGrFvwoAu9opvQ
	(envelope-from <cgroups+bounces-17415-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 04:51:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393876E94FF
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 04:51:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FYXnqFPd;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17415-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17415-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90D13050A79
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D24364EB0;
	Wed,  1 Jul 2026 02:51:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3403364EA6
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 02:51:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874272; cv=none; b=r5V5MdXOLoqdqRxvBI6ZFYn1BlZV70eS3HQ0zpbX80jVVMiXZ3jEjKcJHwJ8ejn6BCB5dqlOK9Ybc5hQNuTD8FLUOiuV+jTBeqFk/2n0NBA3FJqM+1x8EOVUvTvrW8bp03wbgDhfE+QtODmz2iiOwa3t+JTm88vZZwkJOaZHLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874272; c=relaxed/simple;
	bh=Yj4yy7HnMDHifc7qBASUWkoakRN+gLfRB0WoSvnffok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3NdMmzNVShsIjlxMsGmzxyD/p9Atg7g9mGffEogCvyGxfb7eIH9IlzrcHN/0STqDVv6J/mjozKloYSfsnmtKViKKPpz2nLH8FjPaPhBstDXcwheczIXjD15uFNB0Sg2jHeHGnYfMvu+8qbJdWVi15eMux7X9KG6JGg/QCuFpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FYXnqFPd; arc=none smtp.client-ip=91.218.175.185
Message-ID: <e4608f5d-d569-4796-b0f6-55956a6b341c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782874267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DXvVAQ0vnxV/YBSowAfW39oy1q3vP5kHeGRxhz5icw=;
	b=FYXnqFPd/nuI6TKMTj/OYq2Lc9KAmPGVdQmT2Noe2ilrNiobhF8XdWQr0tWpKxTmoigodH
	LayoFG52M5YO46Y3P2fHcbKsSB4FH/rTVvCJBCgaIY5LKdGMhC5UmFzRwVxK4eyeoLD8IL
	6Ui+EcNrgxyVu2C/cxcd0f/DQcDvKz0=
Date: Wed, 1 Jul 2026 10:51:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v9 10/11] cgroup/cpuset: Support multiple destination
 cpusets for cpuset_*attach()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-11-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260630033344.352702-11-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17415-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 393876E94FF



On 6/30/2026 11:33 AM, Waiman Long wrote:
> The only case where the cgroup_taskset structure requires task migration
> to multiple cpusets is when enabling a cpuset controller in cgroup v2
> where the newly created child cpusets inherits the same effective CPUs
> and memory nodes from the parent. In that case, task migration can happen
> directly with no update to tasks' CPU and memory nodes assignment and no
> further work needed from the cpuset side except updating nr_deadline_tasks
> when DL tasks are involved and setting old_mems_allowed in the child
> cpusets.
> 
> Do that by tracking all the destination cpusets with a new dst_cs_head
> singly linked list. The reset_migrate_dl_data() function is integrated
> into clear_attach_data() so that it can be used for both source and
> destination cpusets.
> 
> It is assumed that a given cpuset cannot be both a source and a
> destination cpuset. If such condition happens or when there are multiple
> destination cpusets with CPU or memory nodes changes, the current code
> will not handle it correctly. So it will print a warning and fail the
> attach operation in these unexpected cases as we will have to enhance the
> code to support this if such use cases are valid and not coding errors.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-internal.h |   1 +
>   kernel/cgroup/cpuset.c          | 115 ++++++++++++++++++++------------
>   2 files changed, 72 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index e7d010661fd3..d1161b0a3d85 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -149,6 +149,7 @@ struct cpuset {
>   	 * For linking impacted cpusets during an attach operation.
>   	 */
>   	struct llist_node attach_node;
> +	bool attach_source;
>   
>   	/* partition root state */
>   	int partition_root_state;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b201f4ba18b6..1591d6dca66a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -366,10 +366,12 @@ static struct {
>   	bool cpus_updated;
>   	bool mems_updated;
>   	bool task_work_queued;
> +	bool many_dest_cs;	/* Have many destination cpusets */
>   	struct cpuset *old_cs;	/* Source cpuset */
>   	nodemask_t nodemask_to;
>   } attach_ctx;
>   static LLIST_HEAD(src_cs_head);
> +static LLIST_HEAD(dst_cs_head);
>   

This looks a lot like the 'struct list_head mg_src_preload_node' and
'struct list_head mg_dst_preload_node' in struct css_set. Is there a
better way to reuse those instead of adding a separate tracking list here?

TJ, Michal, do you have any opinions on this?

>   /*
>    * Wait if task attach is in progress until it is done and then acquire
> @@ -3044,8 +3046,23 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
>   	if (!oldcs)
>   		return 0;
>   
> -	if (!llist_on_list(&oldcs->attach_node))
> +	/*
> +	 * The same cpuset cannot be both a source and a destination.
> +	 * The current code does not support that, print a warning and
> +	 * fail the attach if so.
> +	 */
> +	if (WARN_ON_ONCE((!oldcs->attach_source &&
> +			  llist_on_list(&oldcs->attach_node)) ||
> +			  cs->attach_source))
> +		return -EINVAL;
> +
> +	if (!llist_on_list(&oldcs->attach_node)) {
>   		llist_add(&oldcs->attach_node, &src_cs_head);
> +		oldcs->attach_source = true;
> +	}
> +
> +	if (!llist_on_list(&cs->attach_node))
> +		llist_add(&cs->attach_node, &dst_cs_head);
>   
>   	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
>   	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> @@ -3075,35 +3092,31 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
>   	return 0;
>   }
>   
> -static int cpuset_reserve_dl_bw(struct cpuset *cs)
> +static int cpuset_reserve_dl_bw(void)
>   {
> +	struct cpuset *cs;
>   	int cpu, ret;
>   
> -	if (!cs->sum_migrate_dl_bw)
> -		return 0;
> +	llist_for_each_entry(cs, dst_cs_head.first, attach_node) {
> +		if (!cs->sum_migrate_dl_bw)
> +			continue;
>   
> -	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -	if (unlikely(cpu >= nr_cpu_ids))
> -		return -EINVAL;
> +		cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> +		if (unlikely(cpu >= nr_cpu_ids))
> +			return -EINVAL;
>   
> -	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -	if (ret)
> -		return ret;
> +		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +		if (ret)
> +			return ret;
>   
> -	cs->dl_bw_cpu = cpu;
> +		cs->dl_bw_cpu = cpu;
> +	}
>   	return 0;
>   }
>   
> -static void reset_migrate_dl_data(struct cpuset *cs)
> -{
> -	cs->nr_migrate_dl_tasks = 0;
> -	cs->sum_migrate_dl_bw = 0;
> -	cs->dl_bw_cpu = -1;
> -}
> -
>   /*
>    * Clear and optionally apply (@cancel is false) the attach related data in the
> - * source cpusets.
> + * source or destination cpuset.
>    */
>   static void clear_attach_data(struct llist_head *head, bool cancel)
>   {
> @@ -3115,8 +3128,13 @@ static void clear_attach_data(struct llist_head *head, bool cancel)
>   		if (cs->nr_migrate_dl_tasks) {
>   			if (!cancel)
>   				atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
> +			else if (cs->dl_bw_cpu >= 0) /* && cacnel */
> +				dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
>   			cs->nr_migrate_dl_tasks = 0;
> +			cs->sum_migrate_dl_bw = 0;
> +			cs->dl_bw_cpu = -1;
>   		}
> +		cs->attach_source = false;
>   	}
>   }
>   
> @@ -3137,6 +3155,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	mutex_lock(&cpuset_mutex);
>   	attach_ctx.cpus_updated = false;
>   	attach_ctx.mems_updated = false;
> +	attach_ctx.many_dest_cs = false;
>   
>   	/* Check to see if task is allowed in the cpuset */
>   	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
> @@ -3161,9 +3180,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	 * selected as attach_ctx.old_cs.
>   	 */
>   	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *new_cs = css_cs(css);
>   		struct cpuset *new_oldcs = task_cs(task);
>   
> -		if (new_oldcs != oldcs) {
> +		if ((new_oldcs != oldcs) || (new_cs != cs)) {
> +			if (new_cs != cs)
> +				attach_ctx.many_dest_cs = true;
> +			cs = new_cs;
>   			oldcs = new_oldcs;
>   			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>   			if (ret)
> @@ -3197,12 +3220,28 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		}
>   	}
>   
> -	ret = cpuset_reserve_dl_bw(cs);
> +	/*
> +	 * The only case where there are multiple destination cpusets for
> +	 * task migration is when enabling a v2 cpuset controllers where
> +	 * tasks will be migrated to multiple child cpusets from a parent
> +	 * cpuset with the same effective CPUs and memory nodes. IOW,
> +	 * both attach_cpus_updated and attach_mems_updated should be false.
> +	 * If not, it is a condition that the current code cannot handled.
> +	 * Print a warning and abort the attach operation as further code
> +	 * change will be needed.
> +	 */
> +	if (WARN_ON_ONCE(attach_ctx.many_dest_cs && (!cpuset_v2() ||
> +			 attach_ctx.cpus_updated || attach_ctx.mems_updated))) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = cpuset_reserve_dl_bw();
>   
>   out_unlock:
>   	if (ret) {
> -		reset_migrate_dl_data(cs);
>   		clear_attach_data(&src_cs_head, true);
> +		clear_attach_data(&dst_cs_head, true);
>   	} else {
>   		attach_ctx.in_progress++;
>   	}
> @@ -3213,22 +3252,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
>   	dec_attach_in_progress_locked();
>   	clear_attach_data(&src_cs_head, true);
> -
> -	if (cs->dl_bw_cpu >= 0)
> -		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
> -
> -	if (cs->nr_migrate_dl_tasks)
> -		reset_migrate_dl_data(cs);
> -
> +	clear_attach_data(&dst_cs_head, true);
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> @@ -3312,25 +3339,25 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	 * In the default hierarchy, enabling cpuset in the child cgroups
>   	 * will trigger a cpuset_attach() call with no change in effective cpus
>   	 * and mems. In that case, we can optimize out by skipping the task
> -	 * iteration and update.
> +	 * iteration and updatebut the destination cpuset list is iterated to
> +	 * set old_mems_allowed.
>   	 */
> -	if (cpuset_v2() && !attach_ctx.cpus_updated && !attach_ctx.mems_updated)
> +	if (cpuset_v2() && !attach_ctx.cpus_updated && !attach_ctx.mems_updated) {
> +		llist_for_each_entry(cs, dst_cs_head.first, attach_node)
> +			cs->old_mems_allowed = attach_ctx.nodemask_to;
>   		goto out;
> +	}
>   
> +	/* Task iteration shouldn't happen with attach_ctx.many_dest_cs set */
>   	cgroup_taskset_for_each(task, css, tset)
>   		cpuset_attach_task(cs, task);
>   
> -out:
>   	if (attach_ctx.task_work_queued)
>   		schedule_flush_migrate_mm();
>   	cs->old_mems_allowed = attach_ctx.nodemask_to;
> -
> -	if (cs->nr_migrate_dl_tasks) {
> -		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
> -		reset_migrate_dl_data(cs);
> -	}
> -
> +out:
>   	clear_attach_data(&src_cs_head, false);
> +	clear_attach_data(&dst_cs_head, false);
>   	dec_attach_in_progress_locked();
>   
>   	mutex_unlock(&cpuset_mutex);

-- 
Best regards
Ridong


