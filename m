Return-Path: <cgroups+bounces-5559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EE9C8EF3
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25602289FA0
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6F15B0EF;
	Thu, 14 Nov 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQyzLAUG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549318FDBB
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599782; cv=none; b=SLOar3e+c3dPYHCFDzZF3nMcTb2SfSwM47dMyvr093xqJgS/Fr6iziYXcrcDltx1oVfVJxTf8LQ4jXMt1LW2zmULWzJq7HGHIA1f/QkySltyuqeSR3BE/C9pKCcAz9jUv9kTjxexHxmPlcSvc5RnnBQYtzQSv5lxZcDoZiu7xzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599782; c=relaxed/simple;
	bh=OEjKFEcpQsz13XZdaX5cjpBVs6KT2WkZQePyblu+T0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5pCrXZ8E7+pE8A6RscvKlEbCoMth5fOwjldgeYCtTGO7NesLtDETOjPFF21Sg3HsJIWfBpMkBwvhzz2A0EGpeo8722xz4GckoCx7nQURj4QOTQ6VvQlZGWVk1sMQKn6MBc4CB2KYy1GjIhmJzSNprTiL/2i6RsIRPYEZRTAWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQyzLAUG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua4wH/vsk3I0t11x5uOU5gdCtR20Wk4Y/+2Djkj+c9E=;
	b=QQyzLAUGwh2S7gmdGakX2M0ddp3cr0EN2dS4qHJ/NfNldxBzXNSx+Bpfb6T0QeQ8g5W38P
	CYhdutkMqqMWFgEune1RCBG02LY9l2JmhGAnmqKZMKRJBCtgixKf6+5oort5vDQV3AGYLn
	2BVPvmX0CLfanyOh/9o1xynQ/iHABsM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-U6QBzEdcM7-uHr7FbB5-NQ-1; Thu,
 14 Nov 2024 10:56:13 -0500
X-MC-Unique: U6QBzEdcM7-uHr7FbB5-NQ-1
X-Mimecast-MFC-AGG-ID: U6QBzEdcM7-uHr7FbB5-NQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A9421955F42;
	Thu, 14 Nov 2024 15:56:10 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC064195DF81;
	Thu, 14 Nov 2024 15:56:05 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:56:03 -0500
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
Subject: Re: [PATCH v2 1/2] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
Message-ID: <20241114155603.GC471026@pauld.westford.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <20241114142810.794657-2-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114142810.794657-2-juri.lelli@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Nov 14, 2024 at 02:28:09PM +0000 Juri Lelli wrote:
> When root domain non-destructive changes (e.g., only modifying one of
> the existing root domains while the rest is not touched) happen we still
> need to clear DEADLINE bandwidth accounting so that it's then properly
> restored, taking into account DEADLINE tasks associated to each cpuset
> (associated to each root domain). After the introduction of dl_servers,
> we fail to restore such servers contribution after non-destructive
> changes (as they are only considered on destructive changes when
> runqueues are attached to the new domains).
> 
> Fix this by making sure we iterate over the dl_servers attached to
> domains that have not been destroyed and add their bandwidth
> contribution back correctly.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>


Reviewed-by: Phil Auld <pauld@redhat.com>


> ---
> v1->v2: always restore, considering a root domain span (and check for
>         active cpus)
> ---
>  kernel/sched/deadline.c | 17 ++++++++++++++---
>  kernel/sched/topology.c |  8 +++++---
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ce93d0bf452..a9cdbf058871 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2970,11 +2970,22 @@ void dl_add_task_root_domain(struct task_struct *p)
>  
>  void dl_clear_root_domain(struct root_domain *rd)
>  {
> -	unsigned long flags;
> +	int i;
>  
> -	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> +	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
>  	rd->dl_bw.total_bw = 0;
> -	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> +
> +	/*
> +	 * dl_server bandwidth is only restored when CPUs are attached to root
> +	 * domains (after domains are created or CPUs moved back to the
> +	 * default root doamin).
> +	 */
> +	for_each_cpu(i, rd->span) {
> +		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
> +
> +		if (dl_server(dl_se) && cpu_active(i))
> +			rd->dl_bw.total_bw += dl_se->dl_bw;
> +	}
>  }
>  
>  #endif /* CONFIG_SMP */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..9c405f0e7b26 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2721,9 +2721,11 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>  
>  				/*
>  				 * This domain won't be destroyed and as such
> -				 * its dl_bw->total_bw needs to be cleared.  It
> -				 * will be recomputed in function
> -				 * update_tasks_root_domain().
> +				 * its dl_bw->total_bw needs to be cleared.
> +				 * Tasks contribution will be then recomputed
> +				 * in function dl_update_tasks_root_domain(),
> +				 * dl_servers contribution in function
> +				 * dl_restore_server_root_domain().
>  				 */
>  				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
>  				dl_clear_root_domain(rd);
> -- 
> 2.47.0
> 

-- 


