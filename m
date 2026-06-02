Return-Path: <cgroups+bounces-16570-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b97PLynkHmq7YgAAu9opvQ
	(envelope-from <cgroups+bounces-16570-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 16:09:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0562F299
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 16:09:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=v+qNzgsD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16570-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16570-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005AD3092C89
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2EC2222C5;
	Tue,  2 Jun 2026 13:59:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06602383329
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 13:58:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408740; cv=none; b=mK82uWOGM5ZRfIV3Szh2/v7rBZ991lb4qxKRgeDb9H+svAutMl4ii3693rpG3/sMKzHvuAEqaCXoJN5nfkgkpHJ5eiEExqAXWf3JIAYV1lTvQbEnhkcqO9i8+6VluhiYjuOTRKvzoB9hTNxsFbAq+V5T99Jpulv/Fd/o1t8OhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408740; c=relaxed/simple;
	bh=o6t7U1fLbXqtSJaKUTEOLP6i7aKjLLmFE35FqaIjkak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhVMeztIzn4CC0Pq6y8oTq4Y8kzQ2jzI1h+72hPXSnO5g9Ik5Nc4r9RUAzGJ5TYkaVCEv5Dxesv82uNDlnQFjzP8KaTamR9BsgYIPC4nknS1qZkpjlBeX5ulUeTCNBwAFd0KaLfNBA18CbWv0eQus7b5TeQ4oeYEO/Y+pRu/olE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v+qNzgsD; arc=none smtp.client-ip=95.215.58.181
Message-ID: <fe26f2ab-2ec2-4df6-8de2-0e3e76fa5b55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780408736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulv2UzU1jAEACaZcvOIdYaeWK87Q7SFGqiPNQBntRmg=;
	b=v+qNzgsDSVgPJjDAwjvCHnwg60j7wmO8opdu2d8QGugButXYMdaDfW/YlinNUiR3fNv8+B
	jq+o1rndF98nHWDBLx372XQDpAOIdxWFgV7J1zDw04JCpfJVMx7MXDXx3UJ33r6ZWEtbLv
	msy6ONwiel2btimPOs7pK0I3l6QOxUs=
Date: Tue, 2 Jun 2026 21:58:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v5 4/6] cgroup/cpuset: Make cpuset_attach_old_cs
 track task group leaders
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 ridong.chen@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260602023203.248077-1-longman@redhat.com>
 <20260602023203.248077-5-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260602023203.248077-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-16570-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:ridong.chen@linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39A0562F299



On 2026/6/2 10:32, Waiman Long wrote:
> There are two possible ways that migration of tasks from multiple source
> cpusets to a target cpuset can happen. Either a multithread application
> with threads in different cpusets is wholely moved to a new cpuset
					^
					wholly
> or disabling of v2 cpuset controller will move all the tasks in child
> cpusets to the parent cpuset.
> 
> In the former case, it is the mm setting of the group leader that really
> matters. So cpuset_attach_old_cs should track the oldcs of the thread
> leader. In the latter case, effective_mems of child cpusets must always
> be a subset of the parent. So no real page migration will be necessary
> no matter which child cpuset is selected as cpuset_attach_old_cs.
> 
> IOW, cpuset_attach_old_cs should be updated to match the latest task
> group leader in cpuset_can_attach(), but fall back to that of the first
> task if there is no group leader in the taskset.
> 
> Suggested-by: Ridong Chen <ridong.chen@linux.dev>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

> ---
>  kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5c777b1237a8..60e8149cc907 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2975,6 +2975,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	return 0;
>  }
>  
> +/*
> + * cpuset_can_attach() and cpuset_attach() specific internal data
> + * Protected by cpuset_mutex
> + */
>  static struct cpuset *cpuset_attach_old_cs;
>  
>  /*
> @@ -3065,11 +3069,32 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	if (ret)
>  		goto out_unlock;
>  
> +	/*
> +	 * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() to get
> +	 * the old_mems_allowed value. There are two ways that many-to-one
> +	 * cpuset migration can happen:
> +	 * 1) A multithread application with threads in different cpusets is
> +	 *    wholely migrated to a new cpuset.
> +	 * 2) Disabling v2 cpuset controller will move all the tasks in child
> +	 *    cpusets to the parent cpuset.
> +	 *
> +	 * In the former case, it is the mm setting of the group leader that
> +	 * really matters. So cpuset_attach_old_cs should track the oldcs of the
> +	 * group leader. It falls back to the oldcs of the first task if there
> +	 * is no group leader in the taskset. In the latter case, effective_mems
> +	 * of child cpusets must always be a subset of the parent. So no real
> +	 * page migration will be necessary no matter which child cpuset is
> +	 * selected as cpuset_attach_old_cs.
> +	 */
>  	cgroup_taskset_for_each(task, css, tset) {
>  		ret = task_can_attach(task);
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

-- 
Best regards,
Ridong

