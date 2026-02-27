Return-Path: <cgroups+bounces-14456-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g2TVM5gLoWm0pwQAu9opvQ
	(envelope-from <cgroups+bounces-14456-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 04:12:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFF1B231E
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 04:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B812302A535
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 03:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579623112B4;
	Fri, 27 Feb 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qp0pBMMa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B856309DAF
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161941; cv=none; b=aEQsOs1hdesaAfRRv/QqK9ig8I9QGOaDsXnw7YjboKFzeRpk/TGZrSqwiy9acbOfSM+7/IEqReLenHy7gHjnxWEUydG6ZOyWH2gmp0U5Y5kMrTdS65lfgRO0sG6uCbvm2nzEzh/cgUxbzM4J0FnqlTEdI/annPXOBzeyfrTDpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161941; c=relaxed/simple;
	bh=YTZ41qUcX+MsVbVFDi4U62gzjG9ZurM7ZdoKLYYSJQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qfq8elKu/cGaY1g2xorUQet6OkxrcA47BelBG5TtzwBvNJVljMODHryIax6pazjQS98HXF9q79xsOOBx6Mh5IxjkOGX3rMZw6n/iZoZyRDrLF4v1FYZmi1OqUZmhzUvgrJFLW21TSWLKrGKAQX2VF8Z9fEZ3fvYW8JiIYpAxu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qp0pBMMa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97e296ed-ef73-44b7-ab68-3d79749caa47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772161936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9eSofGPc3u44KFMUEmfCKwDammC+wOoAF3xzjznUw8=;
	b=qp0pBMMafWvK4Sxmn6zcim7tiwH0QeBbCp9/CCu+LJR5xWQBGthnSeE9jXEotNJfYPTl2W
	uZtCSCB0UO8mUKkhnD6EczVBh0C2svfSj1nm2Tw5rKtFwyaojmGaqDVPRg7xT0n33lQydx
	kI/BzpUWIfUfu/zYRrRCDDDt0n+taNQ=
Date: Fri, 27 Feb 2026 11:11:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Yosry Ahmed <yosry@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
 <aZ-R87JfacQ2gGq1@linux.dev>
 <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-14456-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28BFF1B231E
X-Rspamd-Action: no action

Hi Yosry,

On 2/26/26 11:16 PM, Yosry Ahmed wrote:
>>> Did you measure the impact of making state_local atomic on the flush
>>> path? It's a slow path but we've seen pain from it being too slow
>>> before, because it extends the critical section of the rstat flush
>>> lock.
>>
>> Qi, please measure the impact on flushing and if no impact then no need to do
>> anything as I don't want anymore churn in this series.
>>
>>>
>>> Can we keep this non-atomic and use mod_memcg_lruvec_state() here? It
>>> will update the stat on the local counter and it will be added to
>>> state_local in the flush path when needed. We can even force another
>>> flush in reparent_state_local () after reparenting is completed, if we
>>> want to avoid leaving a potentially large stat update pending, as it
>>> can be missed by mem_cgroup_flush_stats_ratelimited().
>>>
>>> Same for reparent_memcg_state_local(), we can probably use mod_memcg_state()?
>>
>> Yosry, do you mind sending the patch you are thinking about over this series?
> 
> Honestly, I'd rather squash it into this patch if possible. It avoids
> churn in the history (switch to atomics and back), and is arguably
> simpler than checking for regressions in the flush path.
> 
> What I have in mind is the diff below (build tested only). Qi, would
> you be able to test this? It applies directly on this patch in mm-new:

Thank you so much for doing this! I'm willing to squash and test.

And I found some issues with the diff:

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d82dbfcc28057..404565e80cbf3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -234,11 +234,18 @@ static inline void reparent_state_local(struct
> mem_cgroup *memcg, struct mem_cgr
>          if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>                  return;
> 
> +       /*
> +        * Reparent stats exposed non-hierarchically. Flush @memcg's
> stats first to
> +        * read its stats accurately , and conservatively flush @parent's stats
> +        * after reparenting to avoid hiding a potentially large stat update
> +        * (e.g. from callers of mem_cgroup_flush_stats_ratelimited()).
> +        */
>          __mem_cgroup_flush_stats(memcg, true);
> 
> -       /* The following counts are all non-hierarchical and need to
> be reparented. */
>          reparent_memcg1_state_local(memcg, parent);
>          reparent_memcg1_lruvec_state_local(memcg, parent);
> +
> +       __mem_cgroup_flush_stats(parent, true);
>   }
>   #else
>   static inline void reparent_state_local(struct mem_cgroup *memcg,
> struct mem_cgroup *parent)
> @@ -442,7 +449,7 @@ struct lruvec_stats {
>          long state[NR_MEMCG_NODE_STAT_ITEMS];
> 
>          /* Non-hierarchical (CPU aggregated) state */
> -       atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
> +       long state_local[NR_MEMCG_NODE_STAT_ITEMS];
> 
>          /* Pending child counts during tree propagation */
>          long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> @@ -485,7 +492,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>                  return 0;
> 
>          pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -       x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
> +       x = READ_ONCE(pn->lruvec_stats->state_local[i]);
>   #ifdef CONFIG_SMP
>          if (x < 0)
>                  x = 0;
> @@ -493,6 +500,10 @@ unsigned long lruvec_page_state_local(struct
> lruvec *lruvec,
>          return x;
>   }
> 
> +static void mod_memcg_lruvec_state(struct lruvec *lruvec,
> +                                  enum node_stat_item idx,
> +                                  int val);
> +
>   #ifdef CONFIG_MEMCG_V1
>   void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>                                         struct mem_cgroup *parent, int idx)
> @@ -506,12 +517,10 @@ void reparent_memcg_lruvec_state_local(struct
> mem_cgroup *memcg,
>          for_each_node(nid) {
>                  struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg,
> NODE_DATA(nid));
>                  struct lruvec *parent_lruvec =
> mem_cgroup_lruvec(parent, NODE_DATA(nid));
> -               struct mem_cgroup_per_node *parent_pn;
>                  unsigned long value =
> lruvec_page_state_local(child_lruvec, idx);
> 
> -               parent_pn = container_of(parent_lruvec, struct
> mem_cgroup_per_node, lruvec);
> -
> -               atomic_long_add(value,
> &(parent_pn->lruvec_stats->state_local[i]));
> +               mod_memcg_lruvec_state(child_lruvec, idx, -value);

We can't use mod_memcg_lruvec_state() here, because child memcg has
already been set CSS_DYING. So in mod_memcg_lruvec_state(), we will
get parent memcg.

It seems we need to reimplement a function or add a parameter to
mod_memcg_lruvec_state() to solve the problem. What do you think?

> +               mod_memcg_lruvec_state(parent_lruvec, idx, value);
>          }
>   }
>   #endif
> @@ -598,7 +607,7 @@ struct memcg_vmstats {
>          unsigned long           events[NR_MEMCG_EVENTS];
> 
>          /* Non-hierarchical (CPU aggregated) page state & events */
> -       atomic_long_t           state_local[MEMCG_VMSTAT_SIZE];
> +       long                    state_local[MEMCG_VMSTAT_SIZE];
>          unsigned long           events_local[NR_MEMCG_EVENTS];
> 
>          /* Pending child counts during tree propagation */
> @@ -835,7 +844,7 @@ unsigned long memcg_page_state_local(struct
> mem_cgroup *memcg, int idx)
>          if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n",
> __func__, idx))
>                  return 0;
> 
> -       x = atomic_long_read(&(memcg->vmstats->state_local[i]));
> +       x = READ_ONCE(memcg->vmstats->state_local[i]);
>   #ifdef CONFIG_SMP
>          if (x < 0)
>                  x = 0;
> @@ -852,7 +861,8 @@ void reparent_memcg_state_local(struct mem_cgroup *memcg,
>          if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n",
> __func__, idx))
>                  return;
> 
> -       atomic_long_add(value, &(parent->vmstats->state_local[i]));
> +       mod_memcg_state(memcg, idx, -value);

Same as mod_memcg_lruvec_state().

Thanks,
Qi

> +       mod_memcg_state(parent, idx, value);
>   }
>   #endif
> 
> @@ -4174,8 +4184,6 @@ struct aggregate_control {
>          long *aggregate;
>          /* pointer to the non-hierarchichal (CPU aggregated) counters */
>          long *local;
> -       /* pointer to the atomic non-hierarchichal (CPU aggregated) counters */
> -       atomic_long_t *alocal;
>          /* pointer to the pending child counters during tree propagation */
>          long *pending;
>          /* pointer to the parent's pending counters, could be NULL */
> @@ -4213,12 +4221,8 @@ static void mem_cgroup_stat_aggregate(struct
> aggregate_control *ac)
>                  }
> 
>                  /* Aggregate counts on this level and propagate upwards */
> -               if (delta_cpu) {
> -                       if (ac->local)
> -                               ac->local[i] += delta_cpu;
> -                       else if (ac->alocal)
> -                               atomic_long_add(delta_cpu, &(ac->alocal[i]));
> -               }
> +               if (delta_cpu)
> +                       ac->local[i] += delta_cpu;
> 
>                  if (delta) {
>                          ac->aggregate[i] += delta;
> @@ -4289,8 +4293,7 @@ static void mem_cgroup_css_rstat_flush(struct
> cgroup_subsys_state *css, int cpu)
> 
>          ac = (struct aggregate_control) {
>                  .aggregate = memcg->vmstats->state,
> -               .local = NULL,
> -               .alocal = memcg->vmstats->state_local,
> +               .local = memcg->vmstats->state_local,
>                  .pending = memcg->vmstats->state_pending,
>                  .ppending = parent ? parent->vmstats->state_pending : NULL,
>                  .cstat = statc->state,
> @@ -4323,8 +4326,7 @@ static void mem_cgroup_css_rstat_flush(struct
> cgroup_subsys_state *css, int cpu)
> 
>                  ac = (struct aggregate_control) {
>                          .aggregate = lstats->state,
> -                       .local = NULL,
> -                       .alocal = lstats->state_local,
> +                       .local = lstats->state_local,
>                          .pending = lstats->state_pending,
>                          .ppending = plstats ? plstats->state_pending : NULL,
>                          .cstat = lstatc->state,


