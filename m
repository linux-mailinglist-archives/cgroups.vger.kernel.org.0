Return-Path: <cgroups+bounces-17368-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SdFmIoodQmrw0QkAu9opvQ
	(envelope-from <cgroups+bounces-17368-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 09:23:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF86D6F55
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 09:23:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=KqLs4GIN;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17368-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17368-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2085C302DB7B
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8E3C1F43;
	Mon, 29 Jun 2026 07:16:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33E39769D
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 07:16:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717398; cv=none; b=kZP0aw3kDFIIFMhw9LqAVpqIfxrT+WtdyFcaqt6WYUSMwexsrxngr8/nKE9uV4rnaDKlTAI7N3fd1iFy/U2NNiD5sP0QfVYb5YoOKZnQIF5f/XiYnpxJlDlUVxAajLYit7pWtsCQtFcVIgRJhkSKLwz9x8E0HhYWLr/MPRotD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717398; c=relaxed/simple;
	bh=irI66T1YvoEyiRNdxiF39BA6qTdeYPFLhfyWCNHKzf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOanNlv0BbeLT5SN+tvhG6aPJo1T715EGKePWBG+RUWQbGm51BLE0bbrPX14avS/0C+D1eZexbjc5KrIgrpxeP5rD3Sd0r7bbqYxmuD23VX0t9VOItRxboKEtwPRkpcdqB+dNcBFEZpQytc2WbMWxpcLkhJZLc7udyeI4G+Kt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KqLs4GIN; arc=none smtp.client-ip=95.215.58.172
Message-ID: <a37d6336-8f67-405c-b6fa-796a4348d676@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782717393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYt6huZCPhtTAV11Wes2eBLleTRAaiagsI+kEZZZ7uo=;
	b=KqLs4GINfOWotsKpxzl4TsSwhRaykiaiFiOiWxJmMxU+c/7vD8iiSbWzpDVeygnefz0uuE
	P8N+nMRY27BdUvpb8E0vhuXqcXjuVcqTkVHFAN4aB74nTde3+pz2W0alZchB5WuXE+0T71
	d8Ocf3fViOPiaDyIt3TkGI/HAMWs9gU=
Date: Mon, 29 Jun 2026 15:16:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 04/11] cgroup/cpuset: Put all task attach related
 variables into attach_ctx
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>, Gregory Price <gourry@gourry.net>,
 David Hildenbrand <david@kernel.org>
References: <20260626181923.133658-1-longman@redhat.com>
 <20260626181923.133658-5-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260626181923.133658-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17368-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1CF86D6F55



On 6/27/2026 2:19 AM, Waiman Long wrote:
> Put the task attach related cpuset_attach_old_cs and
> cpuset_attach_nodemask_to static variables into the new attach_ctx
> structure to improve readability and ease maintanence.
> 
> No functional change is expected.
> 
> Suggested-by: Ridong Chen <ridong.chen@linux.dev>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index dec9785d0271..1f31f340e0ec 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -362,6 +362,8 @@ static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
>    */
>   static struct {
>   	int in_progress;
> +	struct cpuset *old_cs;	/* Source cpuset */
> +	nodemask_t nodemask_to;
>   } attach_ctx;
>   
>   static inline void check_insane_mems_config(nodemask_t *nodes)
> @@ -2996,8 +2998,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	return 0;
>   }
>   
> -static struct cpuset *cpuset_attach_old_cs;
> -
>   /*
>    * Check to see if a cpuset can accept a new task
>    * For v1, cpus_allowed and mems_allowed can't be empty.
> @@ -3029,8 +3029,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	int cpu, ret;
>   
>   	/* used later by cpuset_attach() */
> -	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> -	oldcs = cpuset_attach_old_cs;
> +	attach_ctx.old_cs = task_cs(cgroup_taskset_first(tset, &css));
> +	oldcs = attach_ctx.old_cs;
>   	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
> @@ -3133,7 +3133,6 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>    * allocate from cpuset_init().
>    */
>   static cpumask_var_t cpus_attach;
> -static nodemask_t cpuset_attach_nodemask_to;
>   
>   static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   {
> @@ -3150,7 +3149,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	 */
>   	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>   
> -	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
> +	cpuset_change_task_nodemask(task, &attach_ctx.nodemask_to);
>   	cpuset1_update_task_spread_flags(cs, task);
>   }
>   
> @@ -3160,7 +3159,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	struct task_struct *leader;
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *cs;
> -	struct cpuset *oldcs = cpuset_attach_old_cs;
> +	struct cpuset *oldcs = attach_ctx.old_cs;
>   	bool cpus_updated, mems_updated;
>   	bool queue_task_work = false;
>   
> @@ -3172,7 +3171,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	cpus_updated = !cpumask_equal(cs->effective_cpus,
>   				      oldcs->effective_cpus);
>   	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> -	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
>   
>   	/*
>   	 * In the default hierarchy, enabling cpuset in the child cgroups
> @@ -3211,7 +3210,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   			 */
>   			if (is_memory_migrate(cs)) {
>   				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
> -						  &cpuset_attach_nodemask_to);
> +						  &attach_ctx.nodemask_to);
>   				queue_task_work = true;
>   			} else
>   				mmput(mm);
> @@ -3221,7 +3220,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   out:
>   	if (queue_task_work)
>   		schedule_flush_migrate_mm();
> -	cs->old_mems_allowed = cpuset_attach_nodemask_to;
> +	cs->old_mems_allowed = attach_ctx.nodemask_to;
>   
>   	if (cs->nr_migrate_dl_tasks) {
>   		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
> @@ -3685,7 +3684,7 @@ static void cpuset_fork(struct task_struct *task)
>   
>   	/* CLONE_INTO_CGROUP */
>   	mutex_lock(&cpuset_mutex);
> -	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
>   	cpuset_attach_task(cs, task);
>   
>   	dec_attach_in_progress_locked();

LGTM.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards
Ridong


