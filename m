Return-Path: <cgroups+bounces-8677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B36AF836A
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 00:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4456814D
	for <lists+cgroups@lfdr.de>; Thu,  3 Jul 2025 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E82BE7B3;
	Thu,  3 Jul 2025 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaLlLqgR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F9239E87;
	Thu,  3 Jul 2025 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581757; cv=none; b=KU1NAUuGOhqC3vcWpEoYGUm9ECqYaDznPBYRL53mUpUGYXg4cEkBa23ec6+alIwElCPjn/q3geMJGY4nPAvnoX/iBo6RC41hz2VjnTxGyWpADDdtSQk9Fii2X4YFH2R8YHBnlY3J8IaXboC/ATn856t3uXOg5jLFCBnlp7nRRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581757; c=relaxed/simple;
	bh=XJVEb1yF5sFUaYCLLq3nTetyfMZ6c3HU7Msa9fSlfrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4e62A67GI4GcWofw/pYnrsXMgkMV2xPWX1LfyKVurOpQ1ikHg0XSa8seMkQkTV3AzIrPbzntvJ+q2NIxbvBkG6UgBckfZiSlIRHJCwWu6wlhy6Op8OxJP6Lhk5x5Ai+iAjXiPJw9UP9UoOuDGiZ8AbuKaxO7XkfbNBxjKL/Btk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaLlLqgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77D5C4CEED;
	Thu,  3 Jul 2025 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751581757;
	bh=XJVEb1yF5sFUaYCLLq3nTetyfMZ6c3HU7Msa9fSlfrc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WaLlLqgR++apx0cyR91VqHO24UiPOOt2Ihj/uEFSLXCopmm3u0F8NP0H3Ibs4lmUO
	 IcoVF+JeO8g8yBPMPZa6DcGTbMqbimCp1JaCU7MWBQNHAKwGHr/pngjMJSGdBpV+wi
	 rgRYO5Em/QqUXvPWkP72lCVOl1pOsEoU/NEkAM9gtK8q6KqMop92GBXMFzbpgkPstB
	 E2g5D1Nm1GitciHcaeDzSDFqsPvHwc0CAMiQ4IkE/Y0g8uKCO9kysvF+85gM1iRfuJ
	 Uj2YUerShddPClB7rFdtiuhx4x3RUI73mAcumHgNenK4KpA0Yv035sy383g8BBEbnH
	 76bhvlQadCzUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90E27CE0C97; Thu,  3 Jul 2025 15:29:16 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:29:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
Message-ID: <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703200012.3734798-2-shakeel.butt@linux.dev>

On Thu, Jul 03, 2025 at 01:00:12PM -0700, Shakeel Butt wrote:
> Currently the rstat updater and the flusher can race and cause a
> scenario where the stats updater skips adding the css to the lockless
> list but the flusher might not see those updates done by the skipped
> updater. This is benign race and the subsequent flusher will flush those
> stats and at the moment there aren't any rstat users which are not fine
> with this kind of race. However some future user might want more
> stricter guarantee, so let's add appropriate comments and data_race()
> tags to ease the job of future users.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  kernel/cgroup/rstat.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index c8a48cf83878..b98c03b1af25 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -60,6 +60,12 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
>   * Atomically inserts the css in the ss's llist for the given cpu. This is
>   * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
>   * will be processed at the flush time to create the update tree.
> + *
> + * NOTE: if the user needs the guarantee that the updater either add itself in
> + * the lockless list or the concurrent flusher flushes its updated stats, a
> + * memory barrier is needed before the call to css_rstat_updated() i.e. a
> + * barrier after updating the per-cpu stats and before calling
> + * css_rstat_updated().
>   */
>  __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>  {
> @@ -86,8 +92,13 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>  		return;
>  
>  	rstatc = css_rstat_cpu(css, cpu);
> -	/* If already on list return. */
> -	if (llist_on_list(&rstatc->lnode))
> +	/*
> +	 * If already on list return. This check is racy and smp_mb() is needed
> +	 * to pair it with the smp_mb() in css_process_update_tree() if the
> +	 * guarantee that the updated stats are visible to concurrent flusher is
> +	 * needed.
> +	 */
> +	if (data_race(llist_on_list(&rstatc->lnode)))

OK, I will bite...

Why is this needed given the READ_ONCE() that the earlier patch added to
llist_on_list()?

>  		return;
>  
>  	/*
> @@ -145,9 +156,24 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
>  	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
>  	struct llist_node *lnode;
>  
> -	while ((lnode = llist_del_first_init(lhead))) {
> +	while ((lnode = data_race(llist_del_first_init(lhead)))) {

And for this one, why not make init_llist_node(), which is invoked from
llist_del_first_init(), do a WRITE_ONCE()?

							Thanx, Paul

>  		struct css_rstat_cpu *rstatc;
>  
> +		/*
> +		 * smp_mb() is needed here (more specifically in between
> +		 * init_llist_node() and per-cpu stats flushing) if the
> +		 * guarantee is required by a rstat user where etiher the
> +		 * updater should add itself on the lockless list or the
> +		 * flusher flush the stats updated by the updater who have
> +		 * observed that they are already on the list. The
> +		 * corresponding barrier pair for this one should be before
> +		 * css_rstat_updated() by the user.
> +		 *
> +		 * For now, there aren't any such user, so not adding the
> +		 * barrier here but if such a use-case arise, please add
> +		 * smp_mb() here.
> +		 */
> +
>  		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
>  		__css_process_update_tree(rstatc->owner, cpu);
>  	}
> -- 
> 2.47.1
> 

