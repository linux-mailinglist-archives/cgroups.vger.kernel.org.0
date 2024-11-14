Return-Path: <cgroups+bounces-5560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAD9C901A
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9AB450C4
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FECA17E44A;
	Thu, 14 Nov 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFPefi7S"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D517BED0
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599905; cv=none; b=WQXb3lpuNC8hc9/LG6Xws8yM+qomu/qy/cbDdFG03i1+wxNumHM4xtkSoE2hjCPwQ/5AhSrK0grw8XPyfIOXvCFKRqWdpMkdozGD/L3O6CQe3vI++t7UYLaGMuw7wpy25oRggsEQYwRKEGa8s+XHQjqKnMCrFCK581Ml1m2wPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599905; c=relaxed/simple;
	bh=R0XqAamMNscxNuoXObRJ02lOLz1+HI+3Z3noGMG9kCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJfzH0BA9Soc6h1RR/jw3ugX2IqMit8O4s5w00538+EYiWMrDglTg3lJGTP93ncE0BGq7eo4bT4WRHH7zgg9VFhBhuN1gDkfLTjTn37O6SUSiY67GDQkiZW8F639QqX0FaMmeFWJU2Gzwktd3biuYVj9/mNJYZEEiya3E6x2/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFPefi7S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYMJBAU5BVBfRXr/IcaNUVmGDH7kSQCx5gS3ZVjn1Ps=;
	b=VFPefi7STCycm5ErfmZxH+2Ddfc9l+DYYjwKX0Bi+fZvpg9WhWoC8hYTgBoxYA8/J4JU/p
	Y1Uv++u6wWmiqxMzNO0k9WKzXD9z2nc7g0NdCZy7GVxn/dWiFwrvAtX4tG3P0r6gH+0uWI
	z5VSXzeCT64GHEA44DKQP6iZ9D1UasU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-i4Bpvf1OMYWft19gJEtD3w-1; Thu,
 14 Nov 2024 10:58:17 -0500
X-MC-Unique: i4Bpvf1OMYWft19gJEtD3w-1
X-Mimecast-MFC-AGG-ID: i4Bpvf1OMYWft19gJEtD3w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98D751955BF4;
	Thu, 14 Nov 2024 15:58:14 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92A711955F43;
	Thu, 14 Nov 2024 15:58:09 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:58:06 -0500
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
Subject: Re: [PATCH v2 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <20241114155806.GD471026@pauld.westford.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <20241114142810.794657-3-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114142810.794657-3-juri.lelli@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Nov 14, 2024 at 02:28:10PM +0000 Juri Lelli wrote:
> For hotplug operations, DEADLINE needs to check that there is still enough
> bandwidth left after removing the CPU that is going offline. We however
> fail to do so currently.
> 
> Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> that overflow conditions (not enough bandwidth left) are properly
> checked. Also account for dl_server bandwidth, i.e. discount such
> bandwidth in the calculation since NORMAL tasks will be anyway moved
> away from the CPU as a result of the hotplug operation.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>

Nice, thanks!

Reviewed-by: Phil Auld <pauld@redhat.com>


> ---
> v1->v2: special case when total_bw = 0 (discounting dl_servers)
> ---
>  kernel/sched/core.c     |  2 +-
>  kernel/sched/deadline.c | 48 +++++++++++++++++++++++++++++++++--------
>  kernel/sched/sched.h    |  2 +-
>  3 files changed, 41 insertions(+), 11 deletions(-)
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
> index a9cdbf058871..267ea8bacaf6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3470,29 +3470,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
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
> @@ -3501,6 +3503,34 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
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
> +		/*
> +		 * Not much to check if no DEADLINE bandwidth is present.
> +		 * dl_servers we can discount, as tasks will be moved out the
> +		 * offlined CPUs anyway.
> +		 */
> +		if (dl_b->total_bw - fair_server_bw > 0) {
> +			/*
> +			 * Leaving at least one CPU for DEADLINE tasks seems a
> +			 * wise thing to do.
> +			 */
> +			if (dl_bw_cpus(cpu))
> +				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
> +			else
> +				overflow = 1;
> +		}
> +
> +		break;
>  	}
>  
>  	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
> @@ -3509,9 +3539,9 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
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

-- 


