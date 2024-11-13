Return-Path: <cgroups+bounces-5532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9989C72CB
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B941AB240E1
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB8E1FF7BD;
	Wed, 13 Nov 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZvmBps3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FF18870D
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505770; cv=none; b=mr9mwb0gZlIi9k3WsHmWAwBKiTjycobtnrPGqafsaf09jm6wb8QsIdJ2xV4IyIP6C2v9Yg1jblhHE25JZxu09mwAfqpeVz4r/h7+h/qW/8WRd8QUi4bGfgapg1QIdeTv1nXaoNfmRaAF0f4FA6QnD2o9Jh/Me+iIuyBCpaeNA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505770; c=relaxed/simple;
	bh=a2sOY6nfgk1jbL+D4vvHcSCzKxDDWpNMwu4cmLkTQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWqhgU+0LdMN7OdHetJoGQPag+2BNvlBmgmK9k9zZ//URxnc/4IcJE079sMS0X4YUSczjIjSWp462lNcmR5DG4qVDvbticsWBQKEIPuUZ7lEwR0qLnq4HkYOaD91tmrb1kTzEOrJk+763qFtCuo9678Ujap7GSYRbMJB83akW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZvmBps3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731505766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k/LcZrM/9Y5qmvuVpcBz0SdXxixMRmOMiDkjPQpzcK0=;
	b=RZvmBps39VFbr10jJDUE9Qk3roEq80eNwil9ZEZF2OjM/JtDts/wP4kY4pTbbnfxTk6tyh
	uXX5GKUuUrpoj7cAujzphwO1NXvbd5nL1bKfvWfe3DigI5DEMq8sq2MHoL+nnXtWnJa8Ae
	k/q3vqQX8+K9BJCDNOVBwgxn3hte+vI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-KysHKV5GMFqyhKgkJleg6g-1; Wed,
 13 Nov 2024 08:49:20 -0500
X-MC-Unique: KysHKV5GMFqyhKgkJleg6g-1
X-Mimecast-MFC-AGG-ID: KysHKV5GMFqyhKgkJleg6g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A76F1955E87;
	Wed, 13 Nov 2024 13:49:16 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.158])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BFB019560A3;
	Wed, 13 Nov 2024 13:49:11 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:49:08 -0500
From: Phil Auld <pauld@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <20241113134908.GB402105@pauld.westford.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113125724.450249-3-juri.lelli@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


Hi Juri,

On Wed, Nov 13, 2024 at 12:57:23PM +0000 Juri Lelli wrote:
> For hotplug operations, DEADLINE needs to check that there is still enough
> bandwidth left after removing the CPU that is going offline. We however
> fail to do so currently.
> 
> Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> that overflow conditions (not enough bandwidth left) are properly
> checked. Also account for dl_server bandwidth, i.e. discount such
> bandwidht in the calculation since NORMAL tasks will be anyway moved

"bandwidth"  :)


> away from the CPU as a result of the hotplug operation.
>

LGTM.

Reviewed-by: Phil Auld <pauld@redhat.com>


> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/core.c     |  2 +-
>  kernel/sched/deadline.c | 33 ++++++++++++++++++++++++---------
>  kernel/sched/sched.h    |  2 +-
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..d1049e784510 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8057,7 +8057,7 @@ static void cpuset_cpu_active(void)
>  static int cpuset_cpu_inactive(unsigned int cpu)
>  {
>  	if (!cpuhp_tasks_frozen) {
> -		int ret = dl_bw_check_overflow(cpu);
> +		int ret = dl_bw_deactivate(cpu);
>  
>  		if (ret)
>  			return ret;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e53208a50279..609685c5df05 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3467,29 +3467,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
>  }
>  
>  enum dl_bw_request {
> -	dl_bw_req_check_overflow = 0,
> +	dl_bw_req_deactivate = 0,
>  	dl_bw_req_alloc,
>  	dl_bw_req_free
>  };
>  
>  static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  {
> -	unsigned long flags;
> +	unsigned long flags, cap;
>  	struct dl_bw *dl_b;
>  	bool overflow = 0;
> +	u64 fair_server_bw = 0;
>  
>  	rcu_read_lock_sched();
>  	dl_b = dl_bw_of(cpu);
>  	raw_spin_lock_irqsave(&dl_b->lock, flags);
>  
> -	if (req == dl_bw_req_free) {
> +	cap = dl_bw_capacity(cpu);
> +	switch (req) {
> +	case dl_bw_req_free:
>  		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
> -	} else {
> -		unsigned long cap = dl_bw_capacity(cpu);
> -
> +		break;
> +	case dl_bw_req_alloc:
>  		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
>  
> -		if (req == dl_bw_req_alloc && !overflow) {
> +		if (!overflow) {
>  			/*
>  			 * We reserve space in the destination
>  			 * root_domain, as we can't fail after this point.
> @@ -3498,6 +3500,19 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  			 */
>  			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
>  		}
> +		break;
> +	case dl_bw_req_deactivate:
> +		/*
> +		 * cpu is going offline and NORMAL tasks will be moved away
> +		 * from it. We can thus discount dl_server bandwidth
> +		 * contribution as it won't need to be servicing tasks after
> +		 * the cpu is off.
> +		 */
> +		if (cpu_rq(cpu)->fair_server.dl_server)
> +			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
> +
> +		overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
> +		break;
>  	}
>  
>  	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
> @@ -3506,9 +3521,9 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  	return overflow ? -EBUSY : 0;
>  }
>  
> -int dl_bw_check_overflow(int cpu)
> +int dl_bw_deactivate(int cpu)
>  {
> -	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
> +	return dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
>  }
>  
>  int dl_bw_alloc(int cpu, u64 dl_bw)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b1c3588a8f00..1fee840f1bab 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -362,7 +362,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
>  extern bool __checkparam_dl(const struct sched_attr *attr);
>  extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
>  extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> -extern int  dl_bw_check_overflow(int cpu);
> +extern int  dl_bw_deactivate(int cpu);
>  extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
>  /*
>   * SCHED_DEADLINE supports servers (nested scheduling) with the following
> -- 
> 2.47.0
> 
> 

-- 


