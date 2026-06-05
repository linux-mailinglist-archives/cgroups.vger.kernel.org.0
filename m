Return-Path: <cgroups+bounces-16655-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fMtBFJKEImpvZgEAu9opvQ
	(envelope-from <cgroups+bounces-16655-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 10:10:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF0646491
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 10:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=YZRMh1m8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16655-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16655-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70F49303D0D0
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 07:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E947B423;
	Fri,  5 Jun 2026 07:48:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187A3D3301
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 07:48:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645716; cv=none; b=i8iMFcrBXtaIWCG5e/l9EZDiTompxZJUblupZprEubzQUdtEqMaX9TRyj2zcKJ+2vBLFjCc6DHRDxBLgdgOowyqrtVzQH5ZjMVFH+/3ApfOZWEYfh82o3ohX9JCE+5BbrZcB3G+p7/X2HSBIDfIZRJwTinkNm0kAetvtUNoGMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645716; c=relaxed/simple;
	bh=nFbVuVv3cS6ICjhl8VpgTh7nQIkXWEVkOFRgSxZzHGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDl8M6GfSd9GBXPguJCBgqu6LRGTLEV/CsRvqQs4YNVN1sMa30cukOAfL4ritY9aUpdtZL192DH1GWO5tN0B3xe0Vz7RojXakSSQQHTxqOoNqOBNooySXEP/pzxtEPMt21HS3A848E/7JzGXH+Id7KHxkVHCVPzAixWY2YzLLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZRMh1m8; arc=none smtp.client-ip=91.218.175.180
Message-ID: <fb65a2f6-8ab0-43d0-b9e7-d223ec1a671d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780645713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ8P4i53/U3XmK7X/ThPr167XtqJzNlgqX1d7/74z88=;
	b=YZRMh1m8UPxGq9tCb9P5SKsepmpvzxiG2JkyNF2/gWgpEfwJ2T9SweTJBh4sHZCDx4/sGW
	jU/S8fmaQoww2xhgK2p0d6JZO7J+rGk9MnQqBRCbymkgHX8xSzZQpcJmLu2+bYlnGm1vvT
	bCGpAIviA8AOMBBmcq49IDMtjoV27cI=
Date: Fri, 5 Jun 2026 15:48:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v6 1/6] cgroup/cpuset: Fix node inconsistencies
 between cpuset_update_tasks_nodemask() and cpuset_attach()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260604150229.414135-1-longman@redhat.com>
 <20260604150229.414135-2-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260604150229.414135-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16655-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48EF0646491



On 6/4/2026 11:02 PM, Waiman Long wrote:
> Whenever memory node mask is changed, there are 4 places where the node
> mask has to be updated or used.
>  1) task's node mask via cpuset_change_task_nodemask()
>  2) memory policy binding via mpol_rebind_mm()
>  3) if memory migration is enabled, migrate from old_mems_allowed to
>     the new node mask via cpuset_migrate_mm().
>  4) setting old_mems_allowed
> 
> These memory actions are done in cpuset_update_tasks_nodemask() and
> cpuset_attach(). However there are inconsistencies in what node masks
> are being used in these 2 functions.
> 
> In cpuset_update_tasks_nodemask(),
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): mems_allowed
>  - cpuset_migrate_mm(): guarantee_online_mems()
>  - old_mems_allowed: guarantee_online_mems()
> 
> In cpuset_attach(),
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): effective_mems
>  - cpuset_migrate_mm(): effective_mems
>  - old_mems_allowed: effective_mems
> 
> These inconsistencies dates back to quite a long time ago and it is
> hard to say what should be the correct values.
> 
> The guarantee_online_mems() function returns a node mask from current or
> an ancestor cpuset that is a subset of node_states[N_MEMORY]. Nodes in
> node_states[N_MEMORY] are all online, i.e. in node_states[N_ONLINE].
> However, node in node_states[N_ONLINE] may not have memory. So
> node_states[N_MEMORY] should be a subset of node_states[N_ONLINE].
> 
> The guarantee_online_mems() function should only be useful for v1 where
> mems_allowed is the same as effective_mems. With v2, the memory nodes
> in effective_mems should always be a subset of node_states[N_MEMORY].
> The only time that may not be true is when a memory hot-unplug operation
> is in progress and a memory node is removed from node_states[N_MEMORY]
> but not yet reflected in effective_mems as cpuset_handle_hotplug()
> has not yet been called from cpuset_track_online_nodes(). When
> cpuset_handle_hotplug() is called later, the memory node setting
> of the relevant cpusets and tasks will be updated. So replacing the
> guarantee_online_mems() call by just using cs->effective_mems should
> be fine.
> 

The message should be updated.

> Let use the following setup for both of them and make them consistent.
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): effective_mems
>  - cpuset_migrate_mm(): guarantee_online_mems()
>  - old_mems_allowed: guarantee_online_mems()
> 
> So for v2, it is effectively all effective_mems. For v1, mpol_rebind_mm()
> uses mems_allowed which may differ from what guarantee_online_mems()
> returns.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6bdb68689c24..8305b5830c3c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -489,7 +489,10 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>   * Return in *pmask the portion of a cpusets's mems_allowed that
>   * are online, with memory.  If none are online with memory, walk
>   * up the cpuset hierarchy until we find one that does have some
> - * online mems.  The top cpuset always has some mems online.
> + * online mems.  The top cpuset always has some mems online. With v2,
> + * effective_mems should always contain online memory nodes except
> + * during the transition period where a memory node hotunplug operation
> + * is in progress.
>   *
>   * One way or another, we guarantee to return some non-empty subset
>   * of node_states[N_MEMORY].
> @@ -498,6 +501,10 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>   */
>  static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>  {
> +	if (cpuset_v2()) {
> +		*pmask = cs->effective_mems;
> +		return;
> +	}
>  	while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
>  		cs = parent_cs(cs);
>  }
> @@ -2616,6 +2623,13 @@ static void *cpuset_being_rebound;
>   * Iterate through each task of @cs updating its mems_allowed to the
>   * effective cpuset's.  As this function is called with cpuset_mutex held,
>   * cpuset membership stays stable.
> + *
> + * - cpuset_change_task_nodemask(): guarantee_online_mems()
> + * - mpol_rebind_mm(): effective_mems
> + * - cpuset_migrate_mm(): guarantee_online_mems()
> + * - old_mems_allowed: guarantee_online_mems()
> + *
> + * For v2, guarantee_online_mems() should just return effective_mems.
>   */
>  void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  {
> @@ -2624,7 +2638,6 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  	struct task_struct *task;
>  
>  	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
> -
>  	guarantee_online_mems(cs, &newmems);
>  
>  	/*
> @@ -2650,7 +2663,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  		migrate = is_memory_migrate(cs);
>  
> -		mpol_rebind_mm(mm, &cs->mems_allowed);
> +		mpol_rebind_mm(mm, &cs->effective_mems);
>  		if (migrate)
>  			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>  		else
> @@ -3148,17 +3161,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  
>  	/*
>  	 * In the default hierarchy, enabling cpuset in the child cgroups
> -	 * will trigger a number of cpuset_attach() calls with no change
> -	 * in effective cpus and mems. In that case, we can optimize out
> -	 * by skipping the task iteration and update.
> +	 * will trigger a cpuset_attach() call with no change in effective cpus
> +	 * and mems. In that case, we can optimize out by skipping the task
> +	 * iteration and update.
>  	 */
> -	if (cpuset_v2() && !cpus_updated && !mems_updated) {
> +	if (cpuset_v2()) {
>  		cpuset_attach_nodemask_to = cs->effective_mems;
> -		goto out;
> +		if (!cpus_updated && !mems_updated)
> +			goto out;
> +	} else {
> +		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>  	}
>  
> -	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> -

Nit.

I prefer:

	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
	if (cpuset_v2() && !cpus_updated && !mems_updated)
		goto out;

>  	cgroup_taskset_for_each(task, css, tset)
>  		cpuset_attach_task(cs, task);
>  
> @@ -3168,7 +3182,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
>  	 * not set.
>  	 */
> -	cpuset_attach_nodemask_to = cs->effective_mems;
>  	if (!is_memory_migrate(cs) && !mems_updated)
>  		goto out;
>  
> @@ -3176,7 +3189,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  		struct mm_struct *mm = get_task_mm(leader);
>  
>  		if (mm) {
> -			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
> +			mpol_rebind_mm(mm, &cs->effective_mems);
>  
>  			/*
>  			 * old_mems_allowed is the same with mems_allowed

Other than that, looks good to me.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards,
Ridong


