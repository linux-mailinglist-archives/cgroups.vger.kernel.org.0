Return-Path: <cgroups+bounces-16070-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAw0JU8hDGqiWwUAu9opvQ
	(envelope-from <cgroups+bounces-16070-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:37:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3357A3F5
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1C313174B79
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880573E3C71;
	Tue, 19 May 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dL1U5Qqi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF363E16A6
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179212; cv=none; b=M+Q+Z/jL0JtSUHyS7E6fESpNIrCNuV+GkTHTJrPbmZfJkxTZu98qEGP/VwV+10gkXrZ8EdABGf4aKoOiXMhcmv/pZUQpKeCEgzKO17OUUwI8mH3L7+BOAgWGdZJXcDV6guKPrD6fEtZJYPgvnEOBugyutrcuXIpAQ+wXfr/sH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179212; c=relaxed/simple;
	bh=EHWpa/M2bF+JXd0IKbGL0oyVH6G+QAWocwl4l3An8XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iA+kObUZSooUPir9GzvctYQGYK9d0HF3J4/G/g6s8JH84Ugx8drIPKbjGR52Kad4Lx/EVXdtNojaip0qsPDQ37BaUdNCtKTVM2Dle7Ib2byT+4hS/WcJWhNU8ODxKSzLDT8kQuRVQqB11GeDTXdXdrAi0tirG4Uq4XvEUfap/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dL1U5Qqi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a22ca5f-567e-43d7-a43b-2de8d889d3f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779179197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtR3QU/2OpAhzxSWJHzWX3Ltv7qM1PFEcI78q0e2sag=;
	b=dL1U5QqiNrPPzqBUing2VArwRsdfdKVliESGIyEKqU7oRdQEHWJ9Zyeiuup8ARNc7F3am3
	7r3+JW1Ga0+yx4AR/6Q/ybeCnGH1XlYFMmls7nMOn+AAO2cESKkL2Eez1xoe36C9DBE8aW
	crJZc4k+CLMLDgb9quQ6hX24gFwAhbU=
Date: Tue, 19 May 2026 16:26:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH cgroup/for-next v2 2/5] cgroup/cpuset: Expand the scope of
 cpuset_can_attach_check()
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20260516042448.698216-1-longman@redhat.com>
 <20260516042448.698216-3-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260516042448.698216-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16070-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:email]
X-Rspamd-Queue-Id: EDC3357A3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/16 12:24, Waiman Long wrote:
> Expand the scope of cpuset_can_attach_check() by including the setting
> of setsched flag inside cpuset_can_attach_check() with the new @oldcs
> and @psetsched argument. As cpuset_can_attach_check() is also called
> from cpuset_can_fork(), set the new arguments to NULL from that caller.
> 
> While at it, expose the source and destination cpuset cpu/memory check
> results in the new attach_cpus_updated and attach_mems_updated static
> flags so that these flags can be used directly from cpuset_attach()
> without the need to do the same computations again.
> 
> No functional change is expected.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

This patch looks good to me.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

> ---
>   kernel/cgroup/cpuset.c | 70 +++++++++++++++++++++++++-----------------
>   1 file changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7cae47829013..0d01b66f464d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2964,19 +2964,56 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	return 0;
>   }
>   
> +/*
> + * cpuset_can_attach() and cpuset_attach() specific internal data
> + * Protected by cpuset_mutex
> + */
>   static struct cpuset *cpuset_attach_old_cs;
> +static bool attach_cpus_updated;
> +static bool attach_mems_updated;
>   
>   /*
>    * Check to see if a cpuset can accept a new task
>    * For v1, cpus_allowed and mems_allowed can't be empty.
>    * For v2, effective_cpus can't be empty.
>    * Note that in v1, effective_cpus = cpus_allowed.
> + *
> + * Also set the boolean flag passed in by @psetsched depending on if
> + * security_task_setscheduler() call is needed and @oldcs is not NULL.
>    */
> -static int cpuset_can_attach_check(struct cpuset *cs)
> +static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
> +				   bool *psetsched)
>   {
>   	if (cpumask_empty(cs->effective_cpus) ||
>   	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
>   		return -ENOSPC;
> +
> +	if (!oldcs)
> +		return 0;
> +
> +	/*
> +	 * Update attach specific data
> +	 */
> +	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> +	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +
> +	/*
> +	 * Skip rights over task setsched check in v2 when nothing changes,
> +	 * migration permission derives from hierarchy ownership in
> +	 * cgroup_procs_write_permission()).
> +	 */
> +	*psetsched = !cpuset_v2() || attach_cpus_updated || attach_mems_updated;
> +
> +	/*
> +	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
> +	 * brings the last online CPU offline as users are not allowed to empty
> +	 * cpuset.cpus when there are active tasks inside. When that happens,
> +	 * we should allow tasks to migrate out without security check to make
> +	 * sure they will be able to run after migration.
> +	 */
> +	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
> +		*psetsched = false;
> +
>   	return 0;
>   }
>   

This function is messy due to the presence of both 'is_in_v2_mode' and 
'cpuset_v2'. I would like to suggest moving the v1 logic to cpuset-v1.c 
in a separate patch.

> @@ -3023,29 +3060,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	mutex_lock(&cpuset_mutex);
>   
>   	/* Check to see if task is allowed in the cpuset */
> -	ret = cpuset_can_attach_check(cs);
> +	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>   	if (ret)
>   		goto out_unlock;
>   
> -	/*
> -	 * Skip rights over task setsched check in v2 when nothing changes,
> -	 * migration permission derives from hierarchy ownership in
> -	 * cgroup_procs_write_permission()).
> -	 */
> -	setsched_check = !cpuset_v2() ||
> -		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
> -		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
> -
> -	/*
> -	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
> -	 * brings the last online CPU offline as users are not allowed to empty
> -	 * cpuset.cpus when there are active tasks inside. When that happens,
> -	 * we should allow tasks to migrate out without security check to make
> -	 * sure they will be able to run after migration.
> -	 */
> -	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
> -		setsched_check = false;
> -
>   	cgroup_taskset_for_each(task, css, tset) {
>   		ret = task_can_attach(task);
>   		if (ret)
> @@ -3140,7 +3158,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *cs;
>   	struct cpuset *oldcs = cpuset_attach_old_cs;
> -	bool cpus_updated, mems_updated;
>   	bool queue_task_work = false;
>   
>   	cgroup_taskset_first(tset, &css);
> @@ -3148,9 +3165,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   
>   	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
>   	mutex_lock(&cpuset_mutex);
> -	cpus_updated = !cpumask_equal(cs->effective_cpus,
> -				      oldcs->effective_cpus);
> -	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
>   
>   	/*
>   	 * In the default hierarchy, enabling cpuset in the child cgroups
> @@ -3158,7 +3172,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	 * in effective cpus and mems. In that case, we can optimize out
>   	 * by skipping the task iteration and update.
>   	 */
> -	if (cpuset_v2() && !cpus_updated && !mems_updated) {
> +	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated) {
>   		cpuset_attach_nodemask_to = cs->effective_mems;
>   		goto out;
>   	}
> @@ -3175,7 +3189,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	 * not set.
>   	 */
>   	cpuset_attach_nodemask_to = cs->effective_mems;
> -	if (!is_memory_migrate(cs) && !mems_updated)
> +	if (!is_memory_migrate(cs) && !attach_mems_updated)
>   		goto out;
>   
>   	cgroup_taskset_for_each_leader(leader, css, tset) {
> @@ -3590,7 +3604,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
>   	mutex_lock(&cpuset_mutex);
>   
>   	/* Check to see if task is allowed in the cpuset */
> -	ret = cpuset_can_attach_check(cs);
> +	ret = cpuset_can_attach_check(cs, NULL, NULL);
>   	if (ret)
>   		goto out_unlock;
>   

-- 
Best regards,
Ridong

