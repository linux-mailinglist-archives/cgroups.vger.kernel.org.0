Return-Path: <cgroups+bounces-5536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD159C7810
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A055286565
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17614A4C3;
	Wed, 13 Nov 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii1arUh1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41126158205
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513659; cv=none; b=R/G+r1nh6xoVB7Qs4ytQo2XjMLn2Yv3+iWxDWxerzy092xetoyAmXs0fZYCPpJcdYF48Ljwqa+yQjLJ1PNSYFZvLnoNkYfueoYDJpO2a5l9jw7WdZz7Pr/+kQ/+Vy6zCOFNlv7o3mwlK5Y3I7PP8GYX/ynu9TrXxSGi8svgGKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513659; c=relaxed/simple;
	bh=+Slv5CC/4TAzKjLZg0OGlTnIZZ5EzRic/m8KO2N0W5I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rxq0MlqhVPdJFhptZXBzOrFlxygZXG1K91yZX7ZC8ONMLEDoztDNaHhseUVxrVmGSnQ0XoRjH31uLqXp3Pfcj5rzguXEFwEWaO51CUDd0sYYB6QmR7/XrFRNeZE+sCV/qsehFYY+rsfmbW/h8OlEQDaD4hh9lzwVEfw5eAiQDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ii1arUh1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731513656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWQPA9RVyE5frZ47nu2bneN1jwH5ernfdKrCSBJzB7o=;
	b=Ii1arUh1VVG5bqte3cMoglQk+Oh9GIFhln4hIz90ttNa7vTxituu4yZQTtuYC83zt7GCDT
	Y1BmTYflIrAF2L5EVzpW37CQb6E2Gnq/7gveKai1qfEV1cI2YC1LoRAFBE6ql2j4KwrDim
	FJfmtYvGKj3yZlehI2A2+KOUUiREKkY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-HCWbDuS4MHKS5_YN7LyIug-1; Wed, 13 Nov 2024 11:00:55 -0500
X-MC-Unique: HCWbDuS4MHKS5_YN7LyIug-1
X-Mimecast-MFC-AGG-ID: HCWbDuS4MHKS5_YN7LyIug
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5eb7a63c9f3so5664826eaf.0
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 08:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513651; x=1732118451;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWQPA9RVyE5frZ47nu2bneN1jwH5ernfdKrCSBJzB7o=;
        b=j/G9zWKWsvCHnXIrkSNNmW/xSujO/gKx6OClDV/yQiwMvoC31mkCoHwd9RvpuZqvbf
         0IAH0lJ0nDgjFHnO8fwQwa4eGlTT7RDpSoqy8G499uwwo7t/Qgl2gA+Ufitoozp/F1C6
         0u+DDfzoPpJ6AXBh/GJiHzyoP7Ouabq0n61tOXEarTw90mMOKyqHNJ2oppi1vmj3Dxc1
         b67ntD8uMQnl45KiiBT/sum3qtXbSSYjrX8fpSS2VJJAqdTGYCr3N3R+lkQXq6LiOlIr
         yGfoIcIS/mr7WZ8dYdPdF6mDjm30JQdhSG8wGMWUPJEwp81fbxL9xDbYzXALdHW+2jME
         s6TA==
X-Forwarded-Encrypted: i=1; AJvYcCXrLTBz+87cnTbSF1Rk3zDz5Cf1TAdXh53qS8Y2sdr5lOAIX/a82kYVHG2F/LnkLZRv5Bfd1vPG@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTDy2cVF9cvW6alLRV8sL3w2t3HMvSOuLCE1GxqaWW1H2uOmh
	rjuMFSmn1TvfG0Mp5DZtEfyGWkqS6N69E9XFwxIdu4RneaFueHqx8XeuUp7A0jaHLX2/BGu75hi
	w0jRcGk/Jnh1S9Gg77F0AHQBfmmIMLxu0zG7AyQhduAf26f6VJJOGd1wauoRUhlY=
X-Received: by 2002:a05:6820:2910:b0:5eb:c6ba:7830 with SMTP id 006d021491bc7-5ee57cc40d3mr15040770eaf.4.1731513651152;
        Wed, 13 Nov 2024 08:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxWWUuPKP0t2ZZvJuTp9gzfR0PFWGV7zxdTg/WhdiX/MmEftHmL8gY4oQmepjvJnQv3ILkxA==
X-Received: by 2002:a05:6e02:160b:b0:3a3:4164:eec9 with SMTP id e9e14a558f8ab-3a6f1a15cb8mr236895055ab.14.1731513639554;
        Wed, 13 Nov 2024 08:00:39 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f9cd1sm2841953173.140.2024.11.13.08.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:00:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4a388ba7-8533-4c86-9135-883451f65065@redhat.com>
Date: Wed, 13 Nov 2024 11:00:35 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
To: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-2-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20241113125724.450249-2-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 7:57 AM, Juri Lelli wrote:
> When root domain non-destructive changes (e.g., only modifying one of
> the existing root domains while the rest is not touched) happen we still
> need to clear DEADLINE bandwidth accounting so that it's then properly
> restore taking into account DEADLINE tasks associated to each cpuset
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
> ---
>   include/linux/sched/deadline.h |  2 +-
>   kernel/cgroup/cpuset.c         |  2 +-
>   kernel/sched/deadline.c        | 18 +++++++++++++-----
>   kernel/sched/topology.c        | 10 ++++++----
>   4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 3a912ab42bb5..82c966a55856 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -33,7 +33,7 @@ static inline bool dl_time_before(u64 a, u64 b)
>   
>   struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
> -extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain(struct root_domain *rd, bool restore);
>   
>   #endif /* CONFIG_SMP */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 142303abb055..4d3603a99db3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,7 +954,7 @@ static void dl_rebuild_rd_accounting(void)
>   	 * Clear default root domain DL accounting, it will be computed again
>   	 * if a task belongs to it.
>   	 */
> -	dl_clear_root_domain(&def_root_domain);
> +	dl_clear_root_domain(&def_root_domain, false);
>   
>   	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>   
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ce93d0bf452..e53208a50279 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2968,13 +2968,21 @@ void dl_add_task_root_domain(struct task_struct *p)
>   	task_rq_unlock(rq, p, &rf);
>   }
>   
> -void dl_clear_root_domain(struct root_domain *rd)
> +void dl_clear_root_domain(struct root_domain *rd, bool restore)
>   {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> +	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
>   	rd->dl_bw.total_bw = 0;
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
>   }
>   
>   #endif /* CONFIG_SMP */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..e9e7a7c43dd6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2721,12 +2721,14 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   
>   				/*
>   				 * This domain won't be destroyed and as such
> -				 * its dl_bw->total_bw needs to be cleared.  It
> -				 * will be recomputed in function
> -				 * update_tasks_root_domain().
> +				 * its dl_bw->total_bw needs to be cleared.
> +				 * Tasks contribution will be then recomputed
> +				 * in function dl_update_tasks_root_domain(),
> +				 * dl_servers contribution in function
> +				 * dl_restore_server_root_domain().
>   				 */
>   				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
> -				dl_clear_root_domain(rd);
> +				dl_clear_root_domain(rd, true);
>   				goto match1;
>   			}
>   		}

With my limited understanding of the deadline code, this change looks 
reasonable to me. dl_rebuild_rd_accounting() is a part of the cpuset 
code that is seldom touched. So I don't think this particular hunk will 
cause any merge conflict. So it can be carried in the tip tree.

Acked-by: Waiman Long <longman@redhat.com>


