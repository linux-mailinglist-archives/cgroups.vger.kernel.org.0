Return-Path: <cgroups+bounces-16410-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INdJMrv3GGqvpQgAu9opvQ
	(envelope-from <cgroups+bounces-16410-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:19:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30545FC509
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95673037F13
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14EE282F24;
	Fri, 29 May 2026 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J8TIOOKh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F771267B07
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021172; cv=none; b=NsbaO/rOAxmjah1P9j8qfFEkuM7qagPtOC8iCtYhLDrmElzk5AvoUkDNqdIaDzBjqMWIPiWprKYh2NsXaH0MriKymqmXfrU6f4YrmQTdNupKRR9yc5GfspphN0Gj35ze84e8obAHiPTMvKWP8EWKgLDyDWoco24QoMxb/oBM8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021172; c=relaxed/simple;
	bh=mDM9DSs/FWie+AmBTK0WBZBwM5L33g0aQtehlZMNGL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJlCzkUfb+3NYcuUsnpFOMngZWQbqDcPaYDt8xChQRo85JyOUO0Vdz1JvE5xjRvbcCwVYYZVyX1FDQQNwAHxPHz+vqa3zBj8QJLwj5pOWA/JHO/ewCoBuHSYQcwtW5TFGBAhIfvF95Hy/r2DgfrUtnkHunhDOOLO6m4CfGqdTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J8TIOOKh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3f84c49-96cd-4da3-838e-11c72990bc06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780021168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTEYA+9JAkvteNFvAUGj4LNQw8LAznaBqzFkJbujJ0g=;
	b=J8TIOOKhrI1JdisGxDSPCb2VYEd9vG2NYkcFK0jBakOQg2DwqlzvhP5QMY/hnsyCTWLLrm
	6OtXcsy7Zw0Y5QlXbAfRTHnkKDYzhxI3yet3oecsX0o83bGxVhYhmR91PFbn7brcNexfIl
	jqyF6AnGpNJXGXWyS1VAwqlQI90yD5w=
Date: Fri, 29 May 2026 10:19:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v3 3/5] cgroup/cpuset: Made cpuset_attach_old_cs
 track task group leaders
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Ridong Chen <ridong.chen@linux.dev>
References: <20260527153800.1557449-1-longman@redhat.com>
 <20260527153800.1557449-4-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guopeng Zhang <guopeng.zhang@linux.dev>
In-Reply-To: <20260527153800.1557449-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16410-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D30545FC509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/5/27 23:37, Waiman Long 写道:
> There are two possible ways that migration of tasks from multiple source
> cpusets to a target cpuset can happen. Either a multithread application
> with threads in different cpusets is wholely moved to a new cpuset
> or disabling of v2 cpuset controller will move all the tasks in child
> cpusets to the parent cpuset.
> 
> In the former case, t is the mm setting of the group leader that really
> matters. So cpuset_attach_old_cs should track the oldcs of the thread
> leader. In the latter case, effective_mems of child cpusets must always
> be a subset of the parent. So no real page migration will be necessary
> no matter which child cpuset is selected as cpuset_attach_old_cs.
> 
> IOW, cpuset_attach_old_cs should be updated to match the latest task
> group leader in cpuset_can_attach().
> 
> Suggested-by: Ridong Chen <ridong.chen@linux.dev>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4457c4f11fce..b233a71f9b7c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2967,6 +2967,20 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  /*
>   * cpuset_can_attach() and cpuset_attach() specific internal data
>   * Protected by cpuset_mutex
> + *
> + * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() tp get the
> + * old_mems_allowed value. There are two ways that many-to-one cpuset migration
> + * can happen:
Hi Waiman,

I applied this series locally and ran some of my test cases. I didn't
observe any issue so far.

While doing a static/checkpatch pass, I noticed a few minor issues in
patches 3, 4 and 5. They are all non-functional nits.

For this patch, I only noticed a couple of small wording/typo nits in
the new comment:

s/tp get/to get/

Best,
Guopeng
> + * 1) A multithread application with threads in different cpusets is wholely
> + *    moved to a new cpuset.
> + * 2) Disabling v2 cpuset controller will move all the tasks in child cpusets
> + *    to the parent cpuset.
> + *
> + * In the former case, it is the mm setting of the group leader that really
> + * matters. So cpuset_attach_old_cs should track the oldcs of the thread
> + * leader. In the latter case, effective_mems of child cpusets must always
> + * be a subset of the parent. So no real page migration will be necessary no
> + * matter which child cpuset is selected as cpuset_attach_old_cs.
>   */
>  static struct cpuset *cpuset_attach_old_cs;
>  static bool attach_cpus_updated;
> @@ -3069,6 +3083,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  		if (ret)
>  			goto out_unlock;
>  
> +		/* Update cpuset_attach_old_cs to the latest group leader */
> +		if (task == task->group_leader)
> +			cpuset_attach_old_cs = task_cs(task);
> +
>  		if (setsched_check) {
>  			ret = security_task_setscheduler(task);
>  			if (ret)


