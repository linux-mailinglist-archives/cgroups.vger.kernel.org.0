Return-Path: <cgroups+bounces-13766-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFbIGj+hhmniPQQAu9opvQ
	(envelope-from <cgroups+bounces-13766-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 03:19:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3D1049B7
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 03:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3023026593
	for <lists+cgroups@lfdr.de>; Sat,  7 Feb 2026 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692F222582;
	Sat,  7 Feb 2026 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a/HRwe30"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEF1482E8
	for <cgroups@vger.kernel.org>; Sat,  7 Feb 2026 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770430779; cv=none; b=bq2z1Q0yN+V3FjgKsdGEQcEgbdgn9XkJ/Hq3YyOJm2rNlXxFgfqZrvojbZulOVeZhph1xM/Gb6WxXHiVvskXbqAXfCpdQ8xqeza2y82dqGtbS3NCIzRJeICvmlom8e/V/v0YDlIGceMlDI24J6FNzxTzwyMwjURNUVq7LHtr6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770430779; c=relaxed/simple;
	bh=Es9SdBnwqTwda1sAspgYKDORFikJC1Y9/Bol4LcmTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d132YppIgZ+h9u/D5Z5SLTMwBnAkTEihWKy/gKyv4tEfr/v64STSP0DFJD7eu9Qoh3Xola6SaGENjchRBovW9LBX5z5/e8f6CX2FWhHbrP+vHwpAhF9q7l5mAT6JZ1/IbfEurdKD6behFgQGVJaPk5O0gTUNJ4YCaz0czdo5IzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a/HRwe30; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Feb 2026 18:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770430776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1X3kDy5N2SH4ikE+zkDTVptsymdGlqEoS9znjBd3Wuk=;
	b=a/HRwe30e3ObQOHtkrZGHkrqvQ/YIXUwVMbqMvF5lOBJYtCFnPKptafhg4PcfBvfv+ZWez
	w/bt4b9iA/4NfLzU/ef0uL/wcNW7+e2jh+admstkJlUAzIga5s8Ai2xXAqQrQE3daFWcEE
	N4yPSAJjxaIzKJ2oxGKe8mEGVEqcPNw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 29/31] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <aYabQii_-9EVdgub@linux.dev>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
 <3ca234c643ecb484f17aa88187e0bce8949bdb6b.1770279888.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca234c643ecb484f17aa88187e0bce8949bdb6b.1770279888.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13766-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: B7F3D1049B7
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 05:01:48PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> To resolve the dying memcg issue, we need to reparent LRU folios of child
> memcg to its parent memcg. This could cause problems for non-hierarchical
> stats.
> 
> As Yosry Ahmed pointed out:
> 
> ```
> In short, if memory is charged to a dying cgroup at the time of
> reparenting, when the memory gets uncharged the stats updates will occur
> at the parent. This will update both hierarchical and non-hierarchical
> stats of the parent, which would corrupt the parent's non-hierarchical
> stats (because those counters were never incremented when the memory was
> charged).
> ```
> 
> Now we have the following two types of non-hierarchical stats, and they
> are only used in CONFIG_MEMCG_V1:
> 
> a. memcg->vmstats->state_local[i]
> b. pn->lruvec_stats->state_local[i]
> 
> To ensure that these non-hierarchical stats work properly, we need to
> reparent these non-hierarchical stats after reparenting LRU folios. To
> this end, this commit makes the following preparations:
> 
> 1. implement reparent_state_local() to reparent non-hierarchical stats
> 2. make css_killed_work_fn() to be called in rcu work, and implement
>    get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
>    between mod_memcg_state()/mod_memcg_lruvec_state()
>    and reparent_state_local()
> 3. change these non-hierarchical stats to atomic_long_t type to avoid race
>    between mem_cgroup_stat_aggregate() and reparent_state_local()
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Overall looks good just a couple of comments.

> ---
>  include/linux/memcontrol.h |   4 ++
>  kernel/cgroup/cgroup.c     |   8 +--
>  mm/memcontrol-v1.c         |  16 ++++++
>  mm/memcontrol-v1.h         |   3 +
>  mm/memcontrol.c            | 113 ++++++++++++++++++++++++++++++++++---
>  5 files changed, 132 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3970c102fe741..a4f6ab7eb98d6 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -957,12 +957,16 @@ static inline void mod_memcg_page_state(struct page *page,
>  
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
> +void reparent_memcg_state_local(struct mem_cgroup *memcg,
> +				struct mem_cgroup *parent, int idx);

Put the above in mm/memcontrol-v1.h file.

>  unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  bool memcg_stat_item_valid(int idx);
>  bool memcg_vm_event_item_valid(enum vm_event_item idx);
>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  				      enum node_stat_item idx);
> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> +				       struct mem_cgroup *parent, int idx);

Put the above in mm/memcontrol-v1.h file.

>  
>  void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 94788bd1fdf0e..dbf94a77018e6 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6043,8 +6043,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
>   */
>  static void css_killed_work_fn(struct work_struct *work)
>  {
> -	struct cgroup_subsys_state *css =
> -		container_of(work, struct cgroup_subsys_state, destroy_work);
> +	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
> +				struct cgroup_subsys_state, destroy_rwork);
>  
>  	cgroup_lock();
>  
> @@ -6065,8 +6065,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
>  		container_of(ref, struct cgroup_subsys_state, refcnt);
>  
>  	if (atomic_dec_and_test(&css->online_cnt)) {
> -		INIT_WORK(&css->destroy_work, css_killed_work_fn);
> -		queue_work(cgroup_offline_wq, &css->destroy_work);
> +		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
> +		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
>  	}
>  }
>  
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index c6078cd7f7e53..a427bb205763b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1887,6 +1887,22 @@ static const unsigned int memcg1_events[] = {
>  	PGMAJFAULT,
>  };
>  
> +void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
> +		reparent_memcg_state_local(memcg, parent, memcg1_stats[i]);
> +}
> +
> +void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_LRU_LISTS; i++)
> +		reparent_memcg_lruvec_state_local(memcg, parent, i);
> +}
> +
>  void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  {
>  	unsigned long memory, memsw;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index eb3c3c1056574..45528195d3578 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -41,6 +41,7 @@ static inline bool do_memsw_account(void)
>  
>  unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
> +void mod_memcg_page_state_local(struct mem_cgroup *memcg, int idx, unsigned long val);
>  unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
>  bool memcg1_alloc_events(struct mem_cgroup *memcg);
>  void memcg1_free_events(struct mem_cgroup *memcg);
> @@ -73,6 +74,8 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
>  			   unsigned long nr_memory, int nid);
>  
>  void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
> +void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> +void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
>  
>  void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
>  static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c9b5dfd822d0a..e7d4e4ff411b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -225,6 +225,26 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
>  	return objcg;
>  }
>  
> +#ifdef CONFIG_MEMCG_V1
> +static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
> +
> +static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> +{
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return;
> +
> +	__mem_cgroup_flush_stats(memcg, true);
> +
> +	/* The following counts are all non-hierarchical and need to be reparented. */
> +	reparent_memcg1_state_local(memcg, parent);
> +	reparent_memcg1_lruvec_state_local(memcg, parent);
> +}
> +#else
> +static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> +{
> +}
> +#endif
> +
>  static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>  {
>  	spin_lock_irq(&objcg_lock);
> @@ -407,7 +427,7 @@ struct lruvec_stats {
>  	long state[NR_MEMCG_NODE_STAT_ITEMS];
>  
>  	/* Non-hierarchical (CPU aggregated) state */
> -	long state_local[NR_MEMCG_NODE_STAT_ITEMS];
> +	atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
>  
>  	/* Pending child counts during tree propagation */
>  	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> @@ -450,7 +470,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  		return 0;
>  
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
> +	x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -458,6 +478,27 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return x;
>  }
>  

Please put the following function under CONFIG_MEMCG_V1. Just move it in
the same block as reparent_state_local().

> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> +				       struct mem_cgroup *parent, int idx)
> +{
> +	int i = memcg_stats_index(idx);
> +	int nid;
> +
> +	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
> +		return;
> +
> +	for_each_node(nid) {
> +		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> +		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
> +		struct mem_cgroup_per_node *parent_pn;
> +		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
> +
> +		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
> +
> +		atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
> +	}
> +}
> +

[...]

>  
> +#ifdef CONFIG_MEMCG_V1
> +/*
> + * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race with
> + * reparenting of non-hierarchical state_locals.
> + */
> +static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
> +{
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return memcg;
> +
> +	rcu_read_lock();
> +
> +	while (memcg_is_dying(memcg))
> +		memcg = parent_mem_cgroup(memcg);
> +
> +	return memcg;
> +}
> +
> +static inline void get_non_dying_memcg_end(void)
> +{
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return;
> +
> +	rcu_read_unlock();
> +}
> +#else
> +static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
> +{
> +	return memcg;
> +}
> +
> +static inline void get_non_dying_memcg_end(void)
> +{
> +}
> +#endif

Add the usage of these start and end functions in mod_memcg_state() and
mod_memcg_lruvec_state() in this patch.


