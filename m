Return-Path: <cgroups+bounces-15782-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D1uAbM1AmocpAEAu9opvQ
	(envelope-from <cgroups+bounces-15782-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:01:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CF515610
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC643010C22
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0953033CB;
	Mon, 11 May 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8K1Um0d"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113431D74B
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529642; cv=none; b=meJgEgFdH75jQfJ8kGZ5rjXPtrL8YMonunHm1sEuXysI+A//aIclljy0IuN3S/IQVHtEyIq5oRmevfOGsE7rXwbyGTSYk2/asMuxGi6bMhshmlfwARpSkxa5wdZeMhYAAbfbTTyHPfRk2PcppXOXW84/mieNc6Ou82CO4TDic7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529642; c=relaxed/simple;
	bh=1KRAqQAWTAhWVrs204gKu/wV0zuf6t0FkpqjQuZTGq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lao2rKgcQ2pjLMdMa27XvXp4wkXLPfFMofYtD8NBPXJSnEIvtn1ANDcx4AA3NNHZtjoIgwih2tFB2uHzdvcdGMlAXMK6SVzCWtL2Y36z6B/I8RiFYZitMs1bJHdvigieJMmpm9g94i5SDKGssfFXooU9vteUucv9oAK1zwY1bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8K1Um0d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778529640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nW6nfkcXo0UZUmY08qZpxOObv3dTS8UzyfTVH8HRueI=;
	b=b8K1Um0dJz91FeTWZ5QaAjuPZIR2ZeHwymdLGBCKnnV1dpRawXdAtWF1IClGnXprNg3cx4
	8RqtSMIQysgkKt0Rplohbe8+lqXRHyaKPsso4YeCeIEfntyLStrFkyjvnfwk3gMGJdGdFn
	9NKaFoH4UFrsop39NHkibYd5diSfokY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-Zo71Wcg5O5aVL0-tkh0m-g-1; Mon,
 11 May 2026 16:00:35 -0400
X-MC-Unique: Zo71Wcg5O5aVL0-tkh0m-g-1
X-Mimecast-MFC-AGG-ID: Zo71Wcg5O5aVL0-tkh0m-g_1778529632
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E64701956062;
	Mon, 11 May 2026 20:00:30 +0000 (UTC)
Received: from [10.2.17.16] (unknown [10.2.17.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14E031800465;
	Mon, 11 May 2026 20:00:24 +0000 (UTC)
Message-ID: <a9bd9e15-d11e-4dcd-ab06-be2e83525ce3@redhat.com>
Date: Mon, 11 May 2026 16:00:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cgroup/cpuset: reserve DL bandwidth only for
 root-domain moves
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
 <20260509102031.97608-3-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260509102031.97608-3-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 5C1CF515610
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
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-15782-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/9/26 6:20 AM, Guopeng Zhang wrote:
> cpuset_can_attach() currently adds the bandwidth of all migrating
> SCHED_DEADLINE tasks to sum_migrate_dl_bw. If the source and destination
> cpuset effective CPU masks do not overlap, the whole sum is then
> reserved in the destination root domain.
>
> set_cpus_allowed_dl(), however, subtracts bandwidth from the source
> root domain only when the affinity change really moves the task between
> root domains. A DL task can move between cpusets that are still in the
> same root domain, so including that task in sum_migrate_dl_bw can reserve
> destination bandwidth without a matching source-side subtraction.
>
> Share the root-domain move test with set_cpus_allowed_dl(). Keep
> nr_migrate_dl_tasks counting all migrating deadline tasks for cpuset DL
> task accounting, but add to sum_migrate_dl_bw only for tasks that need a
> root-domain bandwidth move. Keep using the destination cpuset effective
> CPU mask and leave the broader can_attach()/attach() transaction model
> unchanged.
>
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   include/linux/sched/deadline.h  |  9 +++++++++
>   kernel/cgroup/cpuset-internal.h |  1 +
>   kernel/cgroup/cpuset.c          | 33 ++++++++++++++++++---------------
>   kernel/sched/deadline.c         | 13 ++++++++++---
>   4 files changed, 38 insertions(+), 18 deletions(-)
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
> index b9c839538900..23abfbbb4686 100644
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
> @@ -3038,28 +3038,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		}
>   
>   		if (dl_task(task)) {
> +			/*
> +			 * Count all migrating DL tasks for cpuset task accounting.
> +			 * Only tasks that need a root-domain bandwidth move
> +			 * contribute to sum_migrate_dl_bw.
> +			 */
>   			cs->nr_migrate_dl_tasks++;
> -			cs->sum_migrate_dl_bw += task->dl.dl_bw;
> +			if (dl_task_needs_bw_move(task, cs->effective_cpus))
> +				cs->sum_migrate_dl_bw += task->dl.dl_bw;
>   		}
>   	}
>   
> -	if (!cs->nr_migrate_dl_tasks)
> +	if (!cs->sum_migrate_dl_bw)
>   		goto out_success;
>   
> -	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
> -		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -
> -		if (unlikely(cpu >= nr_cpu_ids)) {
> -			ret = -EINVAL;
> -			goto out_unlock;
> -		}
> +	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> +	if (unlikely(cpu >= nr_cpu_ids)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
>   
> -		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -		if (ret)
> -			goto out_unlock;
> +	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +	if (ret)
> +		goto out_unlock;
>   
> -		cs->dl_bw_cpu = cpu;
> -	}
> +	cs->dl_bw_cpu = cpu;
>   
>   out_success:
>   	/*
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index edca7849b165..7db4c87df83b 100644
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
> @@ -3137,6 +3135,15 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>   	set_cpus_allowed_common(p, ctx);
>   }
>   
> +bool dl_task_needs_bw_move(struct task_struct *p,
> +			   const struct cpumask *new_mask)
> +{
> +	if (!dl_task(p))
> +		return false;
> +
> +	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
> +}
> +
>   /* Assumes rq->lock is held */
>   static void rq_online_dl(struct rq *rq)
>   {

LGTM

Reviewed-by: Waiman Long <longman@redhat.com>


