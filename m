Return-Path: <cgroups+bounces-5531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59D9C7139
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534F21F21409
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC388200BBE;
	Wed, 13 Nov 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9qUd4aD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6C200B88
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505428; cv=none; b=DygFDUkqMRtzAm69D5/ogsBGiw0S5vOrgOzpbAwoNtVViEC93yeHKr/5eIu/QdFSTCsHeFSBfRikBt1Yc1NE/UkoJPpusACWjaRgLoXuY1R96iEhw86oXFYAXMhOlisLue3/58GUrjN1ZPW/ZPAal/rwLnCCc0xBBFZ6fLz3y2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505428; c=relaxed/simple;
	bh=+zMnvloxaCSpMvgyYqLs2QHpUg7QBnvW/fUxPVrsfkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvlS+grv0BuLgvDTDGSR6CM4c4oWyKEkWbbX4D8lfp8gorV2GGCED0R810K+f3RLHGa93kAjvM8n4n+KcPq+74PsD5VFw0ecbyApRXkLekznUNVW/XMdBcpuyRhl9xbivoEXfMSX8nc9dUgDxB+WmHsNSut0UiUQ6YUQDYdyC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9qUd4aD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731505425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmOevJufZu4mgzJjDlfEl6PeJBrFET9QpgN5rfl3zyI=;
	b=b9qUd4aDNeJsHB41SZ9JGVWgaRggwOFYkyC+zouyTNAnyA+Taucg7Frct1pmo7FkQSEeHQ
	7bPOyBRwnn+cdRhoxyInLiTIuz3X13bGpQJyl2KBvOxCw+trxaSzaaVkZzf8zUkkmvwB2O
	j3K5X9EO3eZgqfJ8hdrh9NiIhDhnYp8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-h_azobdlPSW14nOoMzrrTg-1; Wed,
 13 Nov 2024 08:43:39 -0500
X-MC-Unique: h_azobdlPSW14nOoMzrrTg-1
X-Mimecast-MFC-AGG-ID: h_azobdlPSW14nOoMzrrTg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C7841955F3A;
	Wed, 13 Nov 2024 13:43:36 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F6FC19560A3;
	Wed, 13 Nov 2024 13:43:31 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:43:28 -0500
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
Subject: Re: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
Message-ID: <20241113134328.GA402105@pauld.westford.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-2-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113125724.450249-2-juri.lelli@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Juri,

On Wed, Nov 13, 2024 at 12:57:22PM +0000 Juri Lelli wrote:
> When root domain non-destructive changes (e.g., only modifying one of
> the existing root domains while the rest is not touched) happen we still
> need to clear DEADLINE bandwidth accounting so that it's then properly
> restore taking into account DEADLINE tasks associated to each cpuset

"restored, taking ..."  ?

> (associated to each root domain). After the introduction of dl_servers,
> we fail to restore such servers contribution after non-destructive
> changes (as they are only considered on destructive changes when
> runqueues are attached to the new domains).
> 
> Fix this by making sure we iterate over the dl_server attached to
> domains that have not been destroyed and add them bandwidth contribution
> back correctly.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>


Looks good to me. 


Reviewed-by: Phil Auld <pauld@redhat.com>


> ---
>  include/linux/sched/deadline.h |  2 +-
>  kernel/cgroup/cpuset.c         |  2 +-
>  kernel/sched/deadline.c        | 18 +++++++++++++-----
>  kernel/sched/topology.c        | 10 ++++++----
>  4 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 3a912ab42bb5..82c966a55856 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -33,7 +33,7 @@ static inline bool dl_time_before(u64 a, u64 b)
>  
>  struct root_domain;
>  extern void dl_add_task_root_domain(struct task_struct *p);
> -extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain(struct root_domain *rd, bool restore);
>  
>  #endif /* CONFIG_SMP */
>  
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 142303abb055..4d3603a99db3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,7 +954,7 @@ static void dl_rebuild_rd_accounting(void)
>  	 * Clear default root domain DL accounting, it will be computed again
>  	 * if a task belongs to it.
>  	 */
> -	dl_clear_root_domain(&def_root_domain);
> +	dl_clear_root_domain(&def_root_domain, false);
>  
>  	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>  
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ce93d0bf452..e53208a50279 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2968,13 +2968,21 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	task_rq_unlock(rq, p, &rf);
>  }
>  
> -void dl_clear_root_domain(struct root_domain *rd)
> +void dl_clear_root_domain(struct root_domain *rd, bool restore)
>  {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> +	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
>  	rd->dl_bw.total_bw = 0;
> -	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> +
> +	if (restore) {
> +		int i;
> +
> +		for_each_cpu(i, rd->span) {
> +			struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
> +
> +			if (dl_server(dl_se))
> +				rd->dl_bw.total_bw += dl_se->dl_bw;
> +		}
> +	}
>  }
>  
>  #endif /* CONFIG_SMP */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..e9e7a7c43dd6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2721,12 +2721,14 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
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
> -				dl_clear_root_domain(rd);
> +				dl_clear_root_domain(rd, true);
>  				goto match1;
>  			}
>  		}
> -- 
> 2.47.0
> 
> 

-- 


