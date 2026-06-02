Return-Path: <cgroups+bounces-16567-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0OR2DfPeHmoGXAAAu9opvQ
	(envelope-from <cgroups+bounces-16567-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 15:47:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C636D62EA23
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 15:47:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=eAowQ8oM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16567-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16567-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0852130F43BF
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791D3E716D;
	Tue,  2 Jun 2026 13:37:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EC3E5EF6
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 13:37:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407449; cv=none; b=d+MD/v0o9sbvgghlO+XSl9V75cFzqwvCwJtkvtf878xwH1U9QgRnz0VScDPLZmTfDZgQ+uQ6jIeD4jU/3rx6p2gh9w33kaNGsVabi7poAKqEmkio/04ZyoTN4YG1KqONywgEuGbPkTaL8TTSEoD9b7yDXvHVCh22hQxa6p+FrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407449; c=relaxed/simple;
	bh=opT1djNuF0VQTOD8YZ4vL8EPRbIrVANLjmqGMG7W6R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRHySw4TsOhAbgckf5dX4uB9YDjJ7l5xwAAV/CpxCHuO0fnULSJ18smRcM70G/xIsBdu3gWanMF9j6oLgSUH6DUIA8IzXVPIYbI39xl2lAJ12sZVPp1GMRDvhNbF/+O2yoSN58nhSE0feL3dyoPpUUJp1SlVozKkHamral/v5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eAowQ8oM; arc=none smtp.client-ip=95.215.58.172
Message-ID: <a69816f1-6cce-4123-92ec-1ade963061f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780407444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PY5Ix0GcJYEWXHg8qof86Ez84D7zG6nfT1VsEVNpKkE=;
	b=eAowQ8oMEord+v7B6ndgqldDNO+pwh08G9I98czU6yG1X4SMNWMZovIf/A9t9qdfMoyj+a
	3EggxNwPsw2m76HOtRP4GUG8A4Gn1HrOJ1TpDG7MZwiv5vVhUqHSVWWx/l2wj8rMuybiGT
	XqxUO4yMIhSKy7QQiYAio2824+bVirM=
Date: Tue, 2 Jun 2026 21:37:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v5 1/6] cgroup/cpuset: Fix node inconsistencies
 between cpuset_update_tasks_nodemask() and cpuset_attach()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 ridong.chen@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260602023203.248077-1-longman@redhat.com>
 <20260602023203.248077-2-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260602023203.248077-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-16567-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:ridong.chen@linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C636D62EA23



On 2026/6/2 10:31, Waiman Long wrote:
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

I noticed this pattern in several places:

```
if (cpuset_v2())
	newmems = cs->effective_mems;
else
	guarantee_online_mems(cs, &newmems);
```

Would it be simpler to move the v2 logic into guarantee_online_mems?

```
static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
{
	if (cpuset_v2()) {
		*pmask = cs->effective_mems;
		return;
	}
	while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
		cs = parent_cs(cs);
}
```

> Let use the following setup for both of them and make them consistent.
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): effective_mems
>  - cpuset_migrate_mm(): guarantee_online_mems()
>  - old_mems_allowed: guarantee_online_mems()
> 
> So for v2, it is effectively all effective_mems. For v1, mpol_rebind_mm()
> uses cpus_allowed which may differ from what guarantee_online_mems()
	^
mems_allowed?
> returns.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6bdb68689c24..987456b6d879 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2616,6 +2616,13 @@ static void *cpuset_being_rebound;
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

I agree, but the implementation is not as simple as what I mentioned above.

>   */
>  void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  {
> @@ -2625,7 +2632,10 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
>  
> -	guarantee_online_mems(cs, &newmems);
> +	if (cpuset_v2())
> +		newmems = cs->effective_mems;
> +	else
> +		guarantee_online_mems(cs, &newmems);
>  
>  	/*
>  	 * The mpol_rebind_mm() call takes mmap_lock, which we couldn't
> @@ -2650,7 +2660,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  		migrate = is_memory_migrate(cs);
>  
> -		mpol_rebind_mm(mm, &cs->mems_allowed);
> +		mpol_rebind_mm(mm, &cs->effective_mems);
>  		if (migrate)
>  			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>  		else
> @@ -3148,17 +3158,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
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
>  	cgroup_taskset_for_each(task, css, tset)
>  		cpuset_attach_task(cs, task);
>  
> @@ -3168,7 +3179,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
>  	 * not set.
>  	 */
> -	cpuset_attach_nodemask_to = cs->effective_mems;
>  	if (!is_memory_migrate(cs) && !mems_updated)
>  		goto out;
>  
> @@ -3176,7 +3186,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  		struct mm_struct *mm = get_task_mm(leader);
>  
>  		if (mm) {
> -			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
> +			mpol_rebind_mm(mm, &cs->effective_mems);
>  
>  			/*
>  			 * old_mems_allowed is the same with mems_allowed

-- 
Best regards,
Ridong

