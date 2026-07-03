Return-Path: <cgroups+bounces-17456-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /SyoE5McR2pfTQAAu9opvQ
	(envelope-from <cgroups+bounces-17456-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 04:21:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 940046FDE50
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 04:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=hYl4J+2B;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17456-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17456-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62A2302B779
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792A25B092;
	Fri,  3 Jul 2026 02:20:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B107257ACF;
	Fri,  3 Jul 2026 02:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045255; cv=none; b=PrTdCnFGwc1h+ilRQhhGRmaxjptEWvMNpB/ZcX4MvQ+QGTd5WH+ZpuxebTu7AklKH5Aa+OAYAeBG6CtdFtn7FG2x//8yJ3UD04KjBE/K7kuBQL28o2y3ZIRrm3RW8F2vXTURKaaZvPmqWab4jj1yFRocf7635OTg/DdHpajkbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045255; c=relaxed/simple;
	bh=X/+5YPKq2c06N/pTlCkM8KbSyr3K7Z0H8hb/uDOd51U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUYsvIMveyTOXHeA+enp0G79PL8ofnjsi26SbmUN38dQAQzIH1767SFJk5tP3yhtXdQ9vth05g7CDSy0ig8sC2sWBD+kFQpY4yybDfct3du0IB2IZUreNsLEYTeuMi8lmzxmY+YWuUDkCv7uWCt36ZCVtm6aX8RXlHEAQXYj8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hYl4J+2B; arc=none smtp.client-ip=91.218.175.178
Message-ID: <5cb90d4c-4e4b-4d61-9f7e-2136cc1c9842@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783045241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArtngSc+9snDpFQxzEeu6qh3H7ukfyzLLi0sger0XGM=;
	b=hYl4J+2B6OYNB9IN1BN0KGPzjtg0EayGLn27WnIu7951a2wbP4DQQfcmfZahXqbTS+JlAr
	rIXe6VbTzZacSmXuc/TPFd5n+FwlXq0HstSaD2l23InsTvF76eYoS+0BOZ+t0pXewQn/r+
	mdrz7q4D/3G2U3Bp1aXV+c6OypzM4kM=
Date: Fri, 3 Jul 2026 10:20:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v10 09/11] cgroup/cpuset: Support multiple source
 cpusets for cpuset_*attach()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260702214757.579012-1-longman@redhat.com>
 <20260702214757.579012-10-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260702214757.579012-10-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-17456-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 940046FDE50



On 7/3/2026 5:47 AM, Waiman Long wrote:
> There are 2 possible scenarios where the cgroup_taskset structure
> passed into the cgroup can_attach() and attach() methods can contain
> task migration data with multiple source cpusets.
> 
>   - A multithread application with threads in different cpusets is
>     fully migrated into a new cpuset.
>   - Disabling v2 cpuset controller will move all the tasks in child
>     cpusets to the parent cpuset.
> 
> The current cpuset_can_attach() and cpuset_attach() functions still
> expect task migration is from one source cpuset to one destination
> cpuset.
> 
> Fix that by tracking the set of source (old) cpusets in singly linked
> lists. The list will be iterated when necessary to properly update
> internal data.
> 
> To ensure proper DL tasks accounting, the nr_migrate_dl_tasks in both
> the source and destination cpusets are decremented/incremented with
> their values added to nr_deadline_tasks when the migration is successful.
> 
> The setting of the global attach_ctx.cpus_updated and
> attach_ctx.mems_updated flags are also moved from cpuset_attach()
> to cpuset_can_attach() as the correct source cpuset can no longer be
> determined in cpuset_attach() and cpuset states will not be changed
> between cpuset_attach() and cpuset_can_attach() with an earlier patch.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  5 +++
>   kernel/cgroup/cpuset.c          | 73 ++++++++++++++++++++++++++-------
>   2 files changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index df662c7fd1a4..e7d010661fd3 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -145,6 +145,11 @@ struct cpuset {
>   	 */
>   	nodemask_t old_mems_allowed;
>   
> +	/*
> +	 * For linking impacted cpusets during an attach operation.
> +	 */
> +	struct llist_node attach_node;
> +
>   	/* partition root state */
>   	int partition_root_state;
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 9a9de47d52f4..4bbfae041b63 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -37,6 +37,7 @@
>   #include <linux/wait.h>
>   #include <linux/workqueue.h>
>   #include <linux/task_work.h>
> +#include <linux/llist.h>
>   
>   DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>   DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
> @@ -368,6 +369,7 @@ static struct {
>   	struct cpuset *old_cs;	/* Source cpuset */
>   	nodemask_t nodemask_to;
>   } attach_ctx;
> +static LLIST_HEAD(src_cs_head);
>   
>   /*
>    * Wait if task attach is in progress until it is done and then acquire
> @@ -615,6 +617,7 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>   		return NULL;
>   
>   	trial->dl_bw_cpu = -1;
> +	init_llist_node(&trial->attach_node);
>   
>   	/* Setup cpumask pointer array */
>   	cpumask_var_t *pmask[4] = {
> @@ -3032,6 +3035,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
>   				   bool *psetsched)
>   {
> +	bool cpus_updated, mems_updated;
> +
>   	if (cpumask_empty(cs->effective_cpus) ||
>   	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
>   		return -ENOSPC;
> @@ -3039,14 +3044,23 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
>   	if (!oldcs)
>   		return 0;
>   
> +	if (!llist_on_list(&oldcs->attach_node))
> +		llist_add(&oldcs->attach_node, &src_cs_head);
> +
> +	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> +	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +
> +	if (cpus_updated)
> +		attach_ctx.cpus_updated = true;
> +	if (mems_updated)
> +		attach_ctx.mems_updated = true;
> +
>   	/*
> -	 * Skip rights over task setsched check in v2 when nothing changes,
> -	 * migration permission derives from hierarchy ownership in
> -	 * cgroup_procs_write_permission()).
> +	 * Skip rights over task setsched check in v2 when nothing changes for
> +	 * the current oldcs/cs pair, migration permission derives from
> +	 * hierarchy ownership in cgroup_procs_write_permission()).
>   	 */
> -	*psetsched = !cpuset_v2() ||
> -		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
> -		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +	*psetsched = !cpuset_v2() || cpus_updated || mems_updated;
>   
>   	/*
>   	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
> @@ -3087,6 +3101,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>   	cs->dl_bw_cpu = -1;
>   }
>   
> +/*
> + * Clear and optionally apply (@cancel is false) the attach related data in the
> + * source cpusets.
> + */
> +static void clear_attach_data(struct llist_head *head, bool cancel)
> +{
> +	struct cpuset *cs, *next;
> +	struct llist_node *lnode = __llist_del_all(head);
> +
> +	llist_for_each_entry_safe(cs, next, lnode, attach_node) {
> +		init_llist_node(&cs->attach_node);
> +		if (cs->nr_migrate_dl_tasks) {
> +			if (!cancel)
> +				atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
> +			cs->nr_migrate_dl_tasks = 0;
> +		}
> +	}
> +}
> +
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>   {
> @@ -3102,6 +3135,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
> +	attach_ctx.cpus_updated = false;
> +	attach_ctx.mems_updated = false;
>   
>   	/* Check to see if task is allowed in the cpuset */
>   	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
> @@ -3126,6 +3161,15 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	 * selected as attach_ctx.old_cs.
>   	 */
>   	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *new_oldcs = task_cs(task);
> +
> +		if (new_oldcs != oldcs) {
> +			oldcs = new_oldcs;
> +			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
> +			if (ret)
> +				goto out_unlock;
> +		}
> +
>   		ret = task_can_attach(task);
>   		if (ret)
>   			goto out_unlock;
> @@ -3147,6 +3191,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   			 * contribute to sum_migrate_dl_bw.
>   			 */
>   			cs->nr_migrate_dl_tasks++;
> +			oldcs->nr_migrate_dl_tasks--;
>   			if (dl_task_needs_bw_move(task, cs->effective_cpus))
>   				cs->sum_migrate_dl_bw += task->dl.dl_bw;
>   		}
> @@ -3155,10 +3200,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	ret = cpuset_reserve_dl_bw(cs);
>   
>   out_unlock:
> -	if (ret)
> -		reset_migrate_dl_data(cs);
> -	else
> +	if (ret) {
> +		reset_migrate_dl_data(cs); /* Destination cpuset only */
> +		clear_attach_data(&src_cs_head, true);
> +	} else {
>   		attach_ctx.in_progress++;
> +	}
>   
>   	mutex_unlock(&cpuset_mutex);
>   	return ret;
> @@ -3174,6 +3221,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   
>   	mutex_lock(&cpuset_mutex);
>   	dec_attach_in_progress_locked();
> +	clear_attach_data(&src_cs_head, true);
>   
>   	if (cs->dl_bw_cpu >= 0)
>   		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
> @@ -3250,7 +3298,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	struct task_struct *task;
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *cs;
> -	struct cpuset *oldcs = attach_ctx.old_cs;
>   
>   	cgroup_taskset_first(tset, &css);
>   	cs = css_cs(css);
> @@ -3258,9 +3305,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
>   	mutex_lock(&cpuset_mutex);
>   	attach_ctx.task_work_queued = false;
> -
> -	attach_ctx.cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> -	attach_ctx.mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
>   	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
>   
>   	/*
> @@ -3282,10 +3326,10 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   
>   	if (cs->nr_migrate_dl_tasks) {
>   		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
> -		atomic_sub(cs->nr_migrate_dl_tasks, &oldcs->nr_deadline_tasks);
>   		reset_migrate_dl_data(cs);
>   	}
>   
> +	clear_attach_data(&src_cs_head, false);
>   	dec_attach_in_progress_locked();
>   
>   	mutex_unlock(&cpuset_mutex);
> @@ -3792,6 +3836,7 @@ int __init cpuset_init(void)
>   	cpumask_setall(top_cpuset.effective_xcpus);
>   	cpumask_setall(top_cpuset.exclusive_cpus);
>   	nodes_setall(top_cpuset.effective_mems);
> +	init_llist_node(&top_cpuset.attach_node);
>   
>   	cpuset1_init(&top_cpuset);
>   

LGTM.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
-- 
Best regards
Ridong


