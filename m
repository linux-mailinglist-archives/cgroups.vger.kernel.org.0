Return-Path: <cgroups+bounces-6752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EEA4A44B
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 21:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDE188DCDC
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758523F388;
	Fri, 28 Feb 2025 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVRF/+JO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAE23F36A
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774829; cv=none; b=CDAgyL2BUBw6/wxYp2fybYrwH4qTF2rFD6J/qi5vPZxXze66aUBz1vb5l/YBgKdJ2efHWfeo4pifFzOaxgL4ImHqxlFYVqufYd6nghGw7aZvRtTunH3Fpj48eyjUieAG7bn+8OoMSQ0qi+euhSWNY7Rl0lXW1R8qzt7xRVTVeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774829; c=relaxed/simple;
	bh=HfjrxunaWhT5wBuIwKGkELzBngawkit8WB6ORzniqQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHnTFYACN6BPDAwsJKdJE85/ZXHVzo8GoWzu2QqThWM53f6F6ic8Whbq/Sfb0jaL5YIAI8DgQ8Ko8OiqAWxY1z+oaov80uRNEwhgC0KrVCCC8VUaFCCJSSG7LJ9RLm5aoJ2CBke5dJy3VKRMyncwvgBOkD0l5yiVy17JZ3DOcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVRF/+JO; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 20:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740774825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqMg0hL+XFhc4KPH2HmRXMMpzVqSXfOvXWygEKuCZPs=;
	b=vVRF/+JONwu4qvOU4RlxS92UudoXv+J6mW+zKd9lVc+BxJOVlJv11JFNY5NZ9nxJCajIqA
	3/cAfgxpsJXTTJFIowEglyiVMTL4p9I2MajupG504g+/knlI4zT7zYfRlGoS5Xb2oQDcaM
	YxdC9O6A6YA6Ct0ScE1ROK140bRN/mg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/4 v2] cgroup: separate rstat list pointers from base
 stats
Message-ID: <Z8IdpGIwwdlk-oSk@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-5-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:55:43PM -0800, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> A majority of the cgroup_rstat_cpu struct size is made up of the base
> stat entities. Since only the "self" subsystem state makes use of these,
> move them into a struct of their own. This allows for a new compact
> cgroup_rstat_cpu struct that the formal subsystems can make use of.
> Where applicable, decide on whether to allocate the compact or full
> struct including the base stats.

Mentioning the memory savings in this patch's log would be helpful.

> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/linux/cgroup-defs.h | 37 ++++++++++++++----------
>  kernel/cgroup/rstat.c       | 57 +++++++++++++++++++++++++------------
>  2 files changed, 61 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 1598e1389615..b0a07c63fd46 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -170,7 +170,10 @@ struct cgroup_subsys_state {
>  	struct percpu_ref refcnt;
>  
>  	/* per-cpu recursive resource statistics */
> -	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +	union {
> +		struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +		struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
> +	};
>  
>  	/*
>  	 * siblings list anchored at the parent's ->children
> @@ -356,6 +359,24 @@ struct cgroup_base_stat {
>   * resource statistics on top of it - bsync, bstat and last_bstat.
>   */
>  struct cgroup_rstat_cpu {
> +	/*
> +	 * Child cgroups with stat updates on this cpu since the last read
> +	 * are linked on the parent's ->updated_children through
> +	 * ->updated_next.
> +	 *
> +	 * In addition to being more compact, singly-linked list pointing
> +	 * to the cgroup makes it unnecessary for each per-cpu struct to
> +	 * point back to the associated cgroup.
> +	 *
> +	 * Protected by per-cpu cgroup_rstat_cpu_lock.

I just noticed, the patch that split the lock should have updated this
comment.

> +	 */
> +	struct cgroup_subsys_state *updated_children;	/* terminated by self */
> +	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */
> +};
> +
> +struct cgroup_rstat_base_cpu {
> +	struct cgroup_rstat_cpu self;

Why 'self'? Why not 'rstat_cpu' like it's named in struct
cgroup_subsys_state?

> +
>  	/*
>  	 * ->bsync protects ->bstat.  These are the only fields which get
>  	 * updated in the hot path.
> @@ -382,20 +403,6 @@ struct cgroup_rstat_cpu {
>  	 * deltas to propagate to the per-cpu subtree_bstat.
>  	 */
>  	struct cgroup_base_stat last_subtree_bstat;
> -
> -	/*
> -	 * Child cgroups with stat updates on this cpu since the last read
> -	 * are linked on the parent's ->updated_children through
> -	 * ->updated_next.
> -	 *
> -	 * In addition to being more compact, singly-linked list pointing
> -	 * to the cgroup makes it unnecessary for each per-cpu struct to
> -	 * point back to the associated cgroup.
> -	 *
> -	 * Protected by per-cpu cgroup_rstat_cpu_lock.
> -	 */
> -	struct cgroup_subsys_state *updated_children;	/* terminated by self */
> -	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */
>  };
>  
>  struct cgroup_freezer_state {
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index b3eaefc1fd07..c08ebe2f9568 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -24,6 +24,12 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
>  	return per_cpu_ptr(css->rstat_cpu, cpu);
>  }
>  
> +static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
> +		struct cgroup_subsys_state *css, int cpu)
> +{
> +	return per_cpu_ptr(css->rstat_base_cpu, cpu);
> +}
> +
>  static inline bool is_base_css(struct cgroup_subsys_state *css)
>  {
>  	return css->ss == NULL;
> @@ -438,17 +444,31 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
>  
>  	/* the root cgrp's self css has rstat_cpu preallocated */
>  	if (!css->rstat_cpu) {
> -		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
> -		if (!css->rstat_cpu)
> -			return -ENOMEM;
> -	}
> +		if (is_base_css(css)) {
> +			css->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
> +			if (!css->rstat_base_cpu)
> +				return -ENOMEM;
>  
> -	/* ->updated_children list is self terminated */
> -	for_each_possible_cpu(cpu) {
> -		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(css, cpu);
> +			for_each_possible_cpu(cpu) {
> +				struct cgroup_rstat_base_cpu *rstatc;

We should use different variable names for cgroup_rstat_base_cpu and
cgroup_rstat_cpu throughout. Maybe 'brstatc' or 'rstatbc' for the
latter?

> +
> +				rstatc = cgroup_rstat_base_cpu(css, cpu);
> +				rstatc->self.updated_children = css;
> +				u64_stats_init(&rstatc->bsync);
> +			}
> +		} else {
> +			css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
> +			if (!css->rstat_cpu)
> +				return -ENOMEM;
> +
> +			for_each_possible_cpu(cpu) {
> +				struct cgroup_rstat_cpu *rstatc;
> +
> +				rstatc = cgroup_rstat_cpu(css, cpu);
> +				rstatc->updated_children = css;
> +			}
> +		}
>  
> -		rstatc->updated_children = css;
> -		u64_stats_init(&rstatc->bsync);

I think there's too much replication here. We can probably do something
like this (untested):

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de057c992f824..1750a69887a2e 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -443,34 +443,30 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
 	int cpu;
 
 	/* the root cgrp's self css has rstat_cpu preallocated */
-	if (!css->rstat_cpu) {
-		if (is_base_css(css)) {
-			css->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
-			if (!css->rstat_base_cpu)
-				return -ENOMEM;
-
-			for_each_possible_cpu(cpu) {
-				struct cgroup_rstat_base_cpu *rstatc;
+	if (css->rstat_cpu)
+		return 0;
 
-				rstatc = cgroup_rstat_base_cpu(css, cpu);
-				rstatc->self.updated_children = css;
-				u64_stats_init(&rstatc->bsync);
-			}
-		} else {
-			css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-			if (!css->rstat_cpu)
-				return -ENOMEM;
+	if (is_base_css(css)) {
+		css->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+		if (!css->rstat_base_cpu)
+			return -ENOMEM;
+	} else {
+		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		if (!css->rstat_cpu)
+			return -ENOMEM;
+	}
 
-			for_each_possible_cpu(cpu) {
-				struct cgroup_rstat_cpu *rstatc;
+	for_each_possible_cpu(cpu) {
+		struct cgroup_rstat_base_cpu *brstatc = NULL;
+		struct cgroup_rstat_cpu *rstatc;
 
-				rstatc = cgroup_rstat_cpu(css, cpu);
-				rstatc->updated_children = css;
-			}
+		if (is_base_css(css)) {
+			brstatc = cgroup_rstat_base_cpu(css, cpu);
+			u64_stats_init(&brstatc->bsync);
+			rstatc = brstatc->self;
 		}
-
+		rstatc->updated_children = css;
 	}
-
 	return 0;
 }
 
>  	}
>  
>  	return 0;
> @@ -522,9 +542,10 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
>  
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
>  {
> -	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(&cgrp->self, cpu);
> +	struct cgroup_rstat_base_cpu *rstatc = cgroup_rstat_base_cpu(
> +			&cgrp->self, cpu);
>  	struct cgroup *parent = cgroup_parent(cgrp);
> -	struct cgroup_rstat_cpu *prstatc;
> +	struct cgroup_rstat_base_cpu *prstatc;

Same here, we should use different names than rstatc and prstatc. Same
applies for the rest of the diff.

>  	struct cgroup_base_stat delta;
>  	unsigned seq;
>  
> @@ -552,25 +573,25 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
>  		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
>  
>  		delta = rstatc->subtree_bstat;
> -		prstatc = cgroup_rstat_cpu(&parent->self, cpu);
> +		prstatc = cgroup_rstat_base_cpu(&parent->self, cpu);
>  		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
>  		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
>  		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
>  	}
>  }
>  
> -static struct cgroup_rstat_cpu *
> +static struct cgroup_rstat_base_cpu *
>  cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
>  {
> -	struct cgroup_rstat_cpu *rstatc;
> +	struct cgroup_rstat_base_cpu *rstatc;
>  
> -	rstatc = get_cpu_ptr(cgrp->self.rstat_cpu);
> +	rstatc = get_cpu_ptr(cgrp->self.rstat_base_cpu);
>  	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
>  	return rstatc;
>  }
>  
>  static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
> -						 struct cgroup_rstat_cpu *rstatc,
> +						 struct cgroup_rstat_base_cpu *rstatc,
>  						 unsigned long flags)
>  {
>  	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
> @@ -580,7 +601,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
>  
>  void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
>  {
> -	struct cgroup_rstat_cpu *rstatc;
> +	struct cgroup_rstat_base_cpu *rstatc;
>  	unsigned long flags;
>  
>  	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
> @@ -591,7 +612,7 @@ void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
>  void __cgroup_account_cputime_field(struct cgroup *cgrp,
>  				    enum cpu_usage_stat index, u64 delta_exec)
>  {
> -	struct cgroup_rstat_cpu *rstatc;
> +	struct cgroup_rstat_base_cpu *rstatc;
>  	unsigned long flags;
>  
>  	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
> -- 
> 2.43.5
> 
> 

