Return-Path: <cgroups+bounces-14436-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGzMALWFoGk6kgQAu9opvQ
	(envelope-from <cgroups+bounces-14436-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 18:41:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0781ACAA1
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B2334465D9
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587440F8E6;
	Thu, 26 Feb 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="poAd9zN3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33225395DBB
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125391; cv=none; b=GW5B85tJgBagMzgP3e5bA5E+zTabYgNUFRLijrO5QfJlAcEvk/FV8KLYqiQzNExzPkwKO5VpatxKcwitHgK71qXCC0IaFyeunTCWXVl26jZrxVA3bbOABhGsj+Q8731DSmizW7pW7dFpxzPXRMoZ++9xMWpLE0HkJc1ss5zbb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125391; c=relaxed/simple;
	bh=9wVolcoGS545wRc7j2Rt8si7VRw/U/N2Kfv8ElkDVjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krbDrcVroy6XL21WSuSQuocs38B7T4pFCcgWbinNW62TfZaSaISnQHG+kyONGrMVrWqgE/Yyem+7BT3qkEagw2ip1lJ3ED/UtHr8YOsA9y05kI4srWpmgnfLP5l9rmdwhdcpJPxbU1o1KA8WvRudgVkJK+GJ7jXN9jPm3S03uCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=poAd9zN3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Feb 2026 09:02:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772125387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmqwR2VfW9/BK6pSRwRf4VC4vuaKHxCtIx0Jze1RC2g=;
	b=poAd9zN3ZW2O8aPHHsQ5vQ+4Ej/d3mGYgOXpxfrGT5y6HP6geAK0fhG+e8SL8FJZ3DUit9
	ITN3g3TPnlkQmKxepNYwUa4AfJxGQgRjK/9ZBTFJftBO05MgqBZxKg291eypBRs5bnG7xl
	30ZVg+WcpoqKTmS8uxU2OoWyVerD/7o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <aaB7yYSpAaC5uInq@linux.dev>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
 <aZ-R87JfacQ2gGq1@linux.dev>
 <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14436-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E0781ACAA1
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:16:50AM -0800, Yosry Ahmed wrote:
> > > Did you measure the impact of making state_local atomic on the flush
> > > path? It's a slow path but we've seen pain from it being too slow
> > > before, because it extends the critical section of the rstat flush
> > > lock.
> >
> > Qi, please measure the impact on flushing and if no impact then no need to do
> > anything as I don't want anymore churn in this series.
> >
> > >
> > > Can we keep this non-atomic and use mod_memcg_lruvec_state() here? It
> > > will update the stat on the local counter and it will be added to
> > > state_local in the flush path when needed. We can even force another
> > > flush in reparent_state_local () after reparenting is completed, if we
> > > want to avoid leaving a potentially large stat update pending, as it
> > > can be missed by mem_cgroup_flush_stats_ratelimited().
> > >
> > > Same for reparent_memcg_state_local(), we can probably use mod_memcg_state()?
> >
> > Yosry, do you mind sending the patch you are thinking about over this series?
> 
> Honestly, I'd rather squash it into this patch if possible. It avoids
> churn in the history (switch to atomics and back), and is arguably
> simpler than checking for regressions in the flush path.

Yup, let's squash it into the original patch. Please add your sign-off tag.

> 
> What I have in mind is the diff below (build tested only). Qi, would
> you be able to test this? It applies directly on this patch in mm-new:

Qi, please squash this diff into the patch and test. You might need to change
the subsequent patches. Once you are done with testing, you can post the diffs
for those in reply to those patches and we will ask Andrew to squash into
orinigal ones.

The diff looks good to me though.
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d82dbfcc28057..404565e80cbf3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -234,11 +234,18 @@ static inline void reparent_state_local(struct
> mem_cgroup *memcg, struct mem_cgr
>         if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>                 return;
> 
> +       /*
> +        * Reparent stats exposed non-hierarchically. Flush @memcg's
> stats first to
> +        * read its stats accurately , and conservatively flush @parent's stats
> +        * after reparenting to avoid hiding a potentially large stat update
> +        * (e.g. from callers of mem_cgroup_flush_stats_ratelimited()).
> +        */
>         __mem_cgroup_flush_stats(memcg, true);
> 
> -       /* The following counts are all non-hierarchical and need to
> be reparented. */
>         reparent_memcg1_state_local(memcg, parent);
>         reparent_memcg1_lruvec_state_local(memcg, parent);
> +
> +       __mem_cgroup_flush_stats(parent, true);
>  }
>  #else
>  static inline void reparent_state_local(struct mem_cgroup *memcg,
> struct mem_cgroup *parent)
> @@ -442,7 +449,7 @@ struct lruvec_stats {
>         long state[NR_MEMCG_NODE_STAT_ITEMS];
> 
>         /* Non-hierarchical (CPU aggregated) state */
> -       atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
> +       long state_local[NR_MEMCG_NODE_STAT_ITEMS];
> 
>         /* Pending child counts during tree propagation */
>         long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> @@ -485,7 +492,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>                 return 0;
> 
>         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -       x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
> +       x = READ_ONCE(pn->lruvec_stats->state_local[i]);
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x = 0;
> @@ -493,6 +500,10 @@ unsigned long lruvec_page_state_local(struct
> lruvec *lruvec,
>         return x;
>  }
> 
> +static void mod_memcg_lruvec_state(struct lruvec *lruvec,
> +                                  enum node_stat_item idx,
> +                                  int val);
> +
>  #ifdef CONFIG_MEMCG_V1
>  void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>                                        struct mem_cgroup *parent, int idx)
> @@ -506,12 +517,10 @@ void reparent_memcg_lruvec_state_local(struct
> mem_cgroup *memcg,
>         for_each_node(nid) {
>                 struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg,
> NODE_DATA(nid));
>                 struct lruvec *parent_lruvec =
> mem_cgroup_lruvec(parent, NODE_DATA(nid));
> -               struct mem_cgroup_per_node *parent_pn;
>                 unsigned long value =
> lruvec_page_state_local(child_lruvec, idx);
> 
> -               parent_pn = container_of(parent_lruvec, struct
> mem_cgroup_per_node, lruvec);
> -
> -               atomic_long_add(value,
> &(parent_pn->lruvec_stats->state_local[i]));
> +               mod_memcg_lruvec_state(child_lruvec, idx, -value);
> +               mod_memcg_lruvec_state(parent_lruvec, idx, value);
>         }
>  }
>  #endif
> @@ -598,7 +607,7 @@ struct memcg_vmstats {
>         unsigned long           events[NR_MEMCG_EVENTS];
> 
>         /* Non-hierarchical (CPU aggregated) page state & events */
> -       atomic_long_t           state_local[MEMCG_VMSTAT_SIZE];
> +       long                    state_local[MEMCG_VMSTAT_SIZE];
>         unsigned long           events_local[NR_MEMCG_EVENTS];
> 
>         /* Pending child counts during tree propagation */
> @@ -835,7 +844,7 @@ unsigned long memcg_page_state_local(struct
> mem_cgroup *memcg, int idx)
>         if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n",
> __func__, idx))
>                 return 0;
> 
> -       x = atomic_long_read(&(memcg->vmstats->state_local[i]));
> +       x = READ_ONCE(memcg->vmstats->state_local[i]);
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x = 0;
> @@ -852,7 +861,8 @@ void reparent_memcg_state_local(struct mem_cgroup *memcg,
>         if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n",
> __func__, idx))
>                 return;
> 
> -       atomic_long_add(value, &(parent->vmstats->state_local[i]));
> +       mod_memcg_state(memcg, idx, -value);
> +       mod_memcg_state(parent, idx, value);
>  }
>  #endif
> 
> @@ -4174,8 +4184,6 @@ struct aggregate_control {
>         long *aggregate;
>         /* pointer to the non-hierarchichal (CPU aggregated) counters */
>         long *local;
> -       /* pointer to the atomic non-hierarchichal (CPU aggregated) counters */
> -       atomic_long_t *alocal;
>         /* pointer to the pending child counters during tree propagation */
>         long *pending;
>         /* pointer to the parent's pending counters, could be NULL */
> @@ -4213,12 +4221,8 @@ static void mem_cgroup_stat_aggregate(struct
> aggregate_control *ac)
>                 }
> 
>                 /* Aggregate counts on this level and propagate upwards */
> -               if (delta_cpu) {
> -                       if (ac->local)
> -                               ac->local[i] += delta_cpu;
> -                       else if (ac->alocal)
> -                               atomic_long_add(delta_cpu, &(ac->alocal[i]));
> -               }
> +               if (delta_cpu)
> +                       ac->local[i] += delta_cpu;
> 
>                 if (delta) {
>                         ac->aggregate[i] += delta;
> @@ -4289,8 +4293,7 @@ static void mem_cgroup_css_rstat_flush(struct
> cgroup_subsys_state *css, int cpu)
> 
>         ac = (struct aggregate_control) {
>                 .aggregate = memcg->vmstats->state,
> -               .local = NULL,
> -               .alocal = memcg->vmstats->state_local,
> +               .local = memcg->vmstats->state_local,
>                 .pending = memcg->vmstats->state_pending,
>                 .ppending = parent ? parent->vmstats->state_pending : NULL,
>                 .cstat = statc->state,
> @@ -4323,8 +4326,7 @@ static void mem_cgroup_css_rstat_flush(struct
> cgroup_subsys_state *css, int cpu)
> 
>                 ac = (struct aggregate_control) {
>                         .aggregate = lstats->state,
> -                       .local = NULL,
> -                       .alocal = lstats->state_local,
> +                       .local = lstats->state_local,
>                         .pending = lstats->state_pending,
>                         .ppending = plstats ? plstats->state_pending : NULL,
>                         .cstat = lstatc->state,

