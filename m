Return-Path: <cgroups+bounces-17410-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 43oIF0hrRGqDugoAu9opvQ
	(envelope-from <cgroups+bounces-17410-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 03:20:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A28646E907F
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 03:20:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=SP2i7GV3;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17410-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17410-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A3CF305A39F
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC923D7CE;
	Wed,  1 Jul 2026 01:19:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1562FE0F
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 01:19:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868790; cv=none; b=c9Rf6lHncLouXjnzQrPUTiohwfgFR/rgcs9mc/QUiz7/c+S2X4A8oFlgfr1D+H6mTmo6jcFIAP+1gBjQg87XyI2WxMGrx8SFeKQ4n+uhKPjmJsZ0szgPuIx9pUpFoKwr58qb/XaJlSOAsGbJd5uex6qL9ckmmlzQ0t9lR67PZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868790; c=relaxed/simple;
	bh=W1bWpj+RMbOGf+7d4x1OMI6JvzMSGe7yfBpPQdoXE8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6lNo2vUOWUMGvFljb4JJC78HZRF56vPjhSCJcWqsp5Z/+Rino94qFTzUEiK0M06q9xA0AlzSmyRRysQVmSA214oV6Gs9PDreZw/U4bTeu/Gs3MD/3/dGpK89Li/bAHKYUUF5CmiLjhJ5a7X9GWZU4uWoljIZOI+FQDnu9abYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SP2i7GV3; arc=none smtp.client-ip=91.218.175.178
Message-ID: <12864df2-f907-4971-8c8a-dde55723ef84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782868776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc4QRqqQl58r08u5WVjzg9H56/Sf/FkhuFOyq+QQcmk=;
	b=SP2i7GV3nntPnW15PeJcdyxvfIxIhc49hYulxGqR8uALsjlXgPLsTL9tqi27/A95ZyMCH+
	9/WUERGOR4c+bLMOsi4RW8jivtUENR+pQlys8Fc1FLfx47vgzdPQZlUnO+TL67Nab7p9ms
	41GqMutHScsGZxd+YVoRigWN5slkF0o=
Date: Wed, 1 Jul 2026 09:19:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v9 01/11] cgroup/cpuset: Make nr_deadline_tasks an
 atomic_t
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-2-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260630033344.352702-2-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-17410-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A28646E907F



On 6/30/2026 11:33 AM, Waiman Long wrote:
> The nr_deadline_tasks variable in the cpuset structure was introduced by
> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> in cpusets"). It is reported by sashiko [1] that nr_deadline_tasks
> can currently be modified by inc_dl_tasks_cs() under rq->lock and
> by cpuset_attach() under cpuset_mutex. So if both updates happen
> simultaneously, the nr_deadline_tasks variable can be corrupted leading
> to incorrect operations down the road.
> 
> Fix that by changing its type to atomic_t so that nr_deadline_tasks are
> always atomically updated.
> 
> [1] https://sashiko.dev/#/patchset/20260626181923.133658-1-longman%40redhat.comk
> 

Nit.

The link you provided has an extra 'k' at the end. Please remove it.

https://sashiko.dev/#/patchset/20260626181923.133658-1-longman%40redhat.com

> Fixes: 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  2 +-
>   kernel/cgroup/cpuset.c          | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index f7aaf01f7cd5..140700e5e236 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -165,7 +165,7 @@ struct cpuset {
>   	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
>   	 * know when to rebuild associated root domain bandwidth information.
>   	 */
> -	int nr_deadline_tasks;
> +	atomic_t nr_deadline_tasks;
>   	int nr_migrate_dl_tasks;
>   	/* DL bandwidth that needs destination reservation for this attach. */
>   	u64 sum_migrate_dl_bw;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 49d8564d1a48..c22e55d798cf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -222,14 +222,14 @@ void inc_dl_tasks_cs(struct task_struct *p)
>   {
>   	struct cpuset *cs = task_cs(p);
>   
> -	cs->nr_deadline_tasks++;
> +	atomic_inc(&cs->nr_deadline_tasks);
>   }
>   
>   void dec_dl_tasks_cs(struct task_struct *p)
>   {
>   	struct cpuset *cs = task_cs(p);
>   
> -	cs->nr_deadline_tasks--;
> +	atomic_dec(&cs->nr_deadline_tasks);
>   }
>   
>   static inline bool is_partition_valid(const struct cpuset *cs)
> @@ -918,7 +918,7 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>   	struct css_task_iter it;
>   	struct task_struct *task;
>   
> -	if (cs->nr_deadline_tasks == 0)
> +	if (atomic_read(&cs->nr_deadline_tasks) == 0)
>   		return;
>   
>   	css_task_iter_start(&cs->css, 0, &it);
> @@ -3215,8 +3215,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	cs->old_mems_allowed = cpuset_attach_nodemask_to;
>   
>   	if (cs->nr_migrate_dl_tasks) {
> -		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
> -		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
> +		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
> +		atomic_sub(cs->nr_migrate_dl_tasks, &oldcs->nr_deadline_tasks);
>   		reset_migrate_dl_data(cs);
>   	}
>   

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards
Ridong


