Return-Path: <cgroups+bounces-15498-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M8VFXR762npNAAAu9opvQ
	(envelope-from <cgroups+bounces-15498-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 16:17:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1066460151
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A88E3013A9A
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803A3DBD5B;
	Fri, 24 Apr 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt6wv7fi"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF538AC87
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040172; cv=none; b=FdH5uZQyJe7+cRbeXyLV+99PDv1arP4bwHswL6vubwUU8sqsU23NCnVI4Pqq4itGMComSJyvIJFRWv6WI6ZNcB2717OR8NSyD0FYLR63Z4+dpvm5whrGg1MLv5Ls4/LMFUmLSgtEDKU4gHS7RvMqpps6TIw3Zf4pcYt3qW/I9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040172; c=relaxed/simple;
	bh=pr/YeeW6sDBGQzKAh7tdbqLe+lVtRuNpcFXZB1ufqcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUtTDbB8ubSTQ1wS+/wT881wAd1lXg3D6TsLBMk9zWIsHk+ozV30fNFL7DqF7NCH3Qm88gEKDGU4iRZ7nIfB25fSzn4/JJD9oC90dxjfTPhshbtem68uCzQx3py1sTpPFlEtDAgfkeobnuxbrhFcLCVrjrzLgTxHjtbHsaxFcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wt6wv7fi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777040170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnNrABuljqyVBjGi5Ai0o3fCSODLF1F5Mmda4IDLCzY=;
	b=Wt6wv7fimfypkPHhZ4l4kdpVv5Y4Q1TRAFnHLSFvC9Cdz09/tZBIbLK3sZVuQhPk9ZVXU9
	TgruHekZ/7JrCpBdZ4s3yqUJM//sfqJ5V8524Em+J8M6ccxoDwz/uXrqNQMu6yjqjkgODw
	reZSz4okhzygAr9CSujes+1AHfGb3nc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-KCI3R-oGNuKNCyf52CfdTw-1; Fri,
 24 Apr 2026 10:16:05 -0400
X-MC-Unique: KCI3R-oGNuKNCyf52CfdTw-1
X-Mimecast-MFC-AGG-ID: KCI3R-oGNuKNCyf52CfdTw_1777040163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACD171956050;
	Fri, 24 Apr 2026 14:16:02 +0000 (UTC)
Received: from [10.22.88.143] (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DD941800351;
	Fri, 24 Apr 2026 14:15:58 +0000 (UTC)
Message-ID: <6840e385-ef47-4f83-bf4c-8f80843f8c1d@redhat.com>
Date: Fri, 24 Apr 2026 10:15:58 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: make DL attach bandwidth reservation
 root-domain aware
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, tj@kernel.org,
 juri.lelli@redhat.com, chenridong@huaweicloud.com, mkoutny@suse.com
Cc: hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: B1066460151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-15498-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]

On 4/21/26 4:34 AM, Guopeng Zhang wrote:
> cpuset_can_attach() currently sums the bandwidth of all migrating
> SCHED_DEADLINE tasks and reserves destination bandwidth whenever the
> old and new cpuset effective CPU masks do not overlap.
>
> That condition is stronger than what the scheduler uses when migrating
> a deadline task. set_cpus_allowed_dl() only subtracts bandwidth from
> the source side when moving the task requires a DL bandwidth move
> between root domains.
>
> As a result, moving a deadline task between disjoint member cpusets that
> still belong to the same root domain can reserve destination bandwidth
> even though no matching source-side subtraction happens. Successful
> back-and-forth migrations between such cpusets can monotonically
> increase dl_bw->total_bw.
>
> Fix this by extracting the source root-domain test already used by
> set_cpus_allowed_dl() into a shared helper and make cpuset DL bandwidth
> preallocation use that same condition. Count all migrating deadline
> tasks for cpuset task accounting, but only accumulate sum_migrate_dl_bw
> for tasks that actually need a DL bandwidth move. Reserve and rollback
> bandwidth only for that subset.
>
> This keeps successful attach accounting aligned with
> set_cpus_allowed_dl() and avoids double-accounting within a single
> root domain.
>
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   include/linux/sched/deadline.h  |  9 +++++++++
>   kernel/cgroup/cpuset-internal.h |  1 +
>   kernel/cgroup/cpuset.c          | 34 ++++++++++++++++-----------------
>   kernel/sched/deadline.c         | 14 +++++++++++---
>   4 files changed, 38 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 1198138cb839..273538200a44 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -33,6 +33,15 @@ struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
>   extern void dl_clear_root_domain(struct root_domain *rd);
>   extern void dl_clear_root_domain_cpu(int cpu);
> +/*
> + * Return whether moving DL task @p to @new_mask requires moving DL
> + * bandwidth accounting between root domains. This helper is specific to
> + * DL bandwidth move accounting semantics and is shared by
> + * cpuset_can_attach() and set_cpus_allowed_dl() so both paths use the
> + * same source root-domain test.
> + */
> +extern bool dl_task_needs_bw_move(struct task_struct *p,
> +				  const struct cpumask *new_mask);
>   
>   extern u64 dl_cookie;
>   extern bool dl_bw_visited(int cpu, u64 cookie);
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index bb4e692bea30..f7aaf01f7cd5 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -167,6 +167,7 @@ struct cpuset {
>   	 */
>   	int nr_deadline_tasks;
>   	int nr_migrate_dl_tasks;
> +	/* DL bandwidth that needs destination reservation for this attach. */
>   	u64 sum_migrate_dl_bw;
>   	/*
>   	 * CPU used for temporary DL bandwidth allocation during attach;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e3a081a07c6d..761098b45f23 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2993,7 +2993,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	struct cpuset *cs, *oldcs;
>   	struct task_struct *task;
>   	bool setsched_check;
> -	int ret;
> +	int cpu, ret;
>   
>   	/* used later by cpuset_attach() */
>   	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> @@ -3039,31 +3039,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   
>   		if (dl_task(task)) {
>   			cs->nr_migrate_dl_tasks++;
> -			cs->sum_migrate_dl_bw += task->dl.dl_bw;
> +
> +			if (dl_task_needs_bw_move(task, cs->effective_cpus))
> +				cs->sum_migrate_dl_bw += task->dl.dl_bw;
>   		}
>   	}
>   
> -	if (!cs->nr_migrate_dl_tasks)
> +	if (!cs->sum_migrate_dl_bw)
>   		goto out_success;
You should make sure that cs->nr_migrate_dl_tasks is cleared too. 
Alternatively, you can move the dl task increment under the 
dl_task_needs_bw_move() check. It doesn't seem to do any harm if 
nr_migrate_dl_tasks is non-zero, but dl_bw is 0, but it still doesn't 
look right.
>   
> -	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
> -		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> +	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
>   
> -		if (unlikely(cpu >= nr_cpu_ids)) {
> -			reset_migrate_dl_data(cs);
> -			ret = -EINVAL;
> -			goto out_unlock;
> -		}
> -
> -		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -		if (ret) {
> -			reset_migrate_dl_data(cs);
> -			goto out_unlock;
> -		}
> +	if (unlikely(cpu >= nr_cpu_ids)) {
> +		reset_migrate_dl_data(cs);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
>   
> -		cs->dl_bw_cpu = cpu;
> +	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +	if (ret) {
> +		reset_migrate_dl_data(cs);
> +		goto out_unlock;
>   	}
>   
> +	cs->dl_bw_cpu = cpu;
> +
>   out_success:
>   	/*
>   	 * Mark attach is in progress.  This makes validate_change() fail
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index edca7849b165..5ddfa0d30bf6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3107,20 +3107,18 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
>   static void set_cpus_allowed_dl(struct task_struct *p,
>   				struct affinity_context *ctx)
>   {
> -	struct root_domain *src_rd;
>   	struct rq *rq;
>   
>   	WARN_ON_ONCE(!dl_task(p));
>   
>   	rq = task_rq(p);
> -	src_rd = rq->rd;
>   	/*
>   	 * Migrating a SCHED_DEADLINE task between exclusive
>   	 * cpusets (different root_domains) entails a bandwidth
>   	 * update. We already made space for us in the destination
>   	 * domain (see cpuset_can_attach()).
>   	 */
> -	if (!cpumask_intersects(src_rd->span, ctx->new_mask)) {
> +	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
>   		struct dl_bw *src_dl_b;
>   
>   		src_dl_b = dl_bw_of(cpu_of(rq));
> @@ -3137,6 +3135,16 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>   	set_cpus_allowed_common(p, ctx);
>   }
>   
> +bool dl_task_needs_bw_move(struct task_struct *p,
> +			   const struct cpumask *new_mask)
> +{
> +	if (!dl_task(p))
> +		return false;
> +
> +	guard(rcu)();

What do you need a RCU guard here?

Cheers,
Longman

> +	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
> +}
> +
>   /* Assumes rq->lock is held */
>   static void rq_online_dl(struct rq *rq)
>   {


