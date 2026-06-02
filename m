Return-Path: <cgroups+bounces-16569-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WJ3dHiXjHmoWYgAAu9opvQ
	(envelope-from <cgroups+bounces-16569-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 16:05:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC662F217
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 16:05:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xqyrEPWg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16569-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16569-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AF5A3028598
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585A2E9ED6;
	Tue,  2 Jun 2026 13:51:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038520C00C
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 13:51:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408296; cv=none; b=fNZlff1EqBkHCbYqiAZVNTMCYtjLHvaswOc89Aain4SyUsCbsE6bxoD/5q2q5BAnv2+qKyR3krtiJy7MTVThnvk2V33z9brb5DdmpxJef6jIARcprnzudjkSrtr3jrSyhmWZWZmwpYz/TAFqG4XUMUr0TJ4ksMn879m4I0oFl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408296; c=relaxed/simple;
	bh=swqjaAaFWMtgNZhWTLYv+niunpHcnBizOCtUHc0n41Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCsugLXSaqDBf1zMMvB8GhU0Zj4Z7KTLEAvcxn4BIphnzP9CkkCq27UrQnTMyxM/NbyGpSBe+aM9+sAvwzoy1j0knnBIr0eiN1wBogK3VMIXxImstAs9QlIskANSiS43SZ2/rdXJhj6GdmtnMU1dNJowDJyU5ql0Wwz9U8Zcps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xqyrEPWg; arc=none smtp.client-ip=95.215.58.172
Message-ID: <2d5e7009-1427-489c-abcf-a1c05fee7e13@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780408282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmPAGWikuQjxY9CAQF/UXuu/INAFcTlgOmKpuLw35gY=;
	b=xqyrEPWgNn54t98V2f6xwFE8GD6d8LMqvDACvxk2+pgsuFEcEDf8F74TByWRo7bf78V7M5
	YGTpixEhMkJdYiuwXKwJ1cfs2MllBsnFvJvBvI23wXfe7FAjfBj8oB+01v/TcgrNcJ89PW
	gQ/QZJUPqX6ctHL2J591j1kihe0NTtI=
Date: Tue, 2 Jun 2026 21:51:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v5 3/6] cgroup/cpuset: Expand the scope of
 cpuset_can_attach_check()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260602023203.248077-1-longman@redhat.com>
 <20260602023203.248077-4-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260602023203.248077-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16569-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FBC662F217



On 2026/6/2 10:32, Waiman Long wrote:
> Expand the scope of cpuset_can_attach_check() by including the setting
> of setsched flag inside cpuset_can_attach_check() with the new @oldcs
> and @psetsched argument. As cpuset_can_attach_check() is also called
> from cpuset_can_fork(), set the new arguments to NULL from that caller.
> 

Hi Waiman,

The code change itself looks good to me. However, the commit message
has two paragraphs that don't match this patch:

> While at it, expose the source and destination cpuset cpu/memory check
> results in the new attach_cpus_updated and attach_mems_updated static
> flags so that these flags can be used directly from cpuset_attach()
> without the need to do the same computations again.
> 
> Two new global attach related flags are added (attach_cpus_updated &
> attach_mems_updated) which are set to indicate that CPUs or memory nodes
> are updated. These 2 flags are set in cpuset_can_attach() and are used
> in cpuset_attach() for optimization. Since cpuset_mutex will be released
> between the 2 calls, it is possible that an intervening cpuset action
> may change the CPU or node mask of the relevant cpusets, so check is
> added to set these flags if the effective_cpus or effective_mems of
> those cpusets is changed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Other than that:

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

> ---
>  kernel/cgroup/cpuset.c | 52 ++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5c1f3ee48d5d..5c777b1237a8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2982,12 +2982,39 @@ static struct cpuset *cpuset_attach_old_cs;
>   * For v1, cpus_allowed and mems_allowed can't be empty.
>   * For v2, effective_cpus can't be empty.
>   * Note that in v1, effective_cpus = cpus_allowed.
> + *
> + * Also set the boolean flag passed in by @psetsched depending on if
> + * security_task_setscheduler() call is needed and @oldcs is not NULL.
>   */
> -static int cpuset_can_attach_check(struct cpuset *cs)
> +static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
> +				   bool *psetsched)
>  {
>  	if (cpumask_empty(cs->effective_cpus) ||
>  	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
>  		return -ENOSPC;
> +
> +	if (!oldcs)
> +		return 0;
> +
> +	/*
> +	 * Skip rights over task setsched check in v2 when nothing changes,
> +	 * migration permission derives from hierarchy ownership in
> +	 * cgroup_procs_write_permission()).
> +	 */
> +	*psetsched = !cpuset_v2() ||
> +		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
> +		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
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
>  	return 0;
>  }
>  
> @@ -3034,29 +3061,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	mutex_lock(&cpuset_mutex);
>  
>  	/* Check to see if task is allowed in the cpuset */
> -	ret = cpuset_can_attach_check(cs);
> +	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>  	if (ret)
>  		goto out_unlock;
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
>  	cgroup_taskset_for_each(task, css, tset) {
>  		ret = task_can_attach(task);
>  		if (ret)
> @@ -3601,7 +3609,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
>  	mutex_lock(&cpuset_mutex);
>  
>  	/* Check to see if task is allowed in the cpuset */
> -	ret = cpuset_can_attach_check(cs);
> +	ret = cpuset_can_attach_check(cs, NULL, NULL);
>  	if (ret)
>  		goto out_unlock;
>  

-- 
Best regards,
Ridong

