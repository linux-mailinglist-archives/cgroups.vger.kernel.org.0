Return-Path: <cgroups+bounces-17167-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZN4TL+rfOWriyQcAu9opvQ
	(envelope-from <cgroups+bounces-17167-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:22:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE46B3271
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:22:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xHuwGa3D;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17167-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17167-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A53301A3BE
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E903535F60E;
	Tue, 23 Jun 2026 01:22:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD03355F22
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 01:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177766; cv=none; b=eOdVDvnhPBchUzChm4j5B+7GSzh2HiXBJaCYvvytLrmtDx7AwA1tw74c9dshkXawt8+U0DsZ8qu08KT4CarYd1oYgdjXhYJ1zEzeD0F/gvS0gGG15ViNLbHNKMXOLT4BfxqVdD6N2N6G5ajHesXJp7TZkd6wld2+9Oh7X65Sl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177766; c=relaxed/simple;
	bh=v+OmKz/qwNb3cD++nL8Ju6+NRPVxqGL6FindB9q758Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx7+JpJMQeZY8ylL9H6CErj5dE2RF3JbmTKYEWlsi1LHIArpnYgRwngacE1Z8uAGwbD92BGYEPYcNSgeBFR23p3DhFkaIHamxO+FhjvJvHmJ2c8ISeiAfiGCyhQJzdXAoTSwqAMcI5myI6WuMLX1PZ/mAFqPDLqPJyHM+EuDlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xHuwGa3D; arc=none smtp.client-ip=95.215.58.181
Message-ID: <5a14e276-e59e-458d-9c24-622321bef8d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782177763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP1jrhz6V+SNpvaMxGkoV85OuYzi4/pwez8gDGp5Ys8=;
	b=xHuwGa3DN5gWsnfU4l0oGCJBdIzNbawDfroYFbMOH494WtqAhZfo2y++a0yLOdC3LaKdVd
	3cskoQ38Tg4ug6I/ZYEma+xobF2Htt1E9RA0KuwB2Mds6CXHBF0kcKC6DIkt7bqT5CEO4y
	EjotpM65Xc33MmKXaZU/yqHUJ0FPta8=
Date: Tue, 23 Jun 2026 09:22:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] cgroup/cpuset: Rebind/migrate mm only for threadgroup
 leader in cpuset_update_tasks_nodemask()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260622224509.1927419-1-longman@redhat.com>
 <20260622224509.1927419-2-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260622224509.1927419-2-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-17167-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19CE46B3271



On 6/23/2026 6:45 AM, Waiman Long wrote:
> As reported by sashiko [1], cpuset_update_tasks_nodemask() will do
> mpol_rebind_mm() and possibly cpuset_migrate_mm() for all threads of
> a multithreaded process. Since commit 3df9ca0a2b8b ("cpuset: migrate
> memory only for threadgroup leaders"), cpuset_attach() had been updated
> to rebind and migrate memory only for threadgroup leaders to mark the
> group leader as the owner of the mm_struct.
> 
> To be consistent and avoid unnecessary performance overhead for heavily
> multithreaded processes, follow the cpuset_attach() example and perform
> memory rebind and migration only for threadgroup leaders.
> 
> Also add a paragraph in cgroup-v2.rst under cpuset.mems that the
> threadgroup leader is the memory owner of that threadgroup. Therefore
> the non-leading threads shouldn't be in other cgroups whose "cpuset.mems"
> doesn't fully overleap that of the group leader.
> 
> [1] https://sashiko.dev/#/patchset/20260621032816.1806773-1-longman%40redhat.com
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 7 +++++++
>   kernel/cgroup/cpuset.c                  | 4 ++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 993446ab66d0..341037c7ec9d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2527,6 +2527,13 @@ Cpuset Interface Files
>   	a need to change "cpuset.mems" with active tasks, it shouldn't
>   	be done frequently.
>   
> +	For a multithreaded process, the threadgroup leader is
> +	considered the owner of the group's memory. Memory policy
> +	rebinding and migration will only happen with respect to the
> +	threadgroup leader. To avoid unexpected result, non-leading
> +	threads shouldn't be put into another cgroup whose "cpuset.mems"
> +	doesn't full overleap that of the threadgroup leader.
> +
>     cpuset.mems.effective
>   	A read-only multiple values file which exists on all
>   	cpuset-enabled cgroups.
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bc0207fd6e57..27bc7a466468 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2659,6 +2659,10 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>   
>   		cpuset_change_task_nodemask(task, &newmems);
>   
> +		/* Rebind and migrate mm only for task group leader */
> +		if (task != task->group_leader)
> +			continue;
> +

Nit.

if (!thread_group_leader(task))
     continue;

>   		mm = get_task_mm(task);
>   		if (!mm)
>   			continue;

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards
Ridong


