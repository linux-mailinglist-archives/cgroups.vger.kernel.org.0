Return-Path: <cgroups+bounces-13296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B096CD39252
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 04:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EF2301460D
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 03:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897E187FE4;
	Sun, 18 Jan 2026 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kiYOQrhC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696471C2324
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768706463; cv=none; b=IavkMqe0oP+cm+Wktg9HP8b4qHuHqZAylYOdFm3A3HKPgZr0dkALPbITMvZ/Gmt1UqasIuZQbqPXMamUxoz5h4iDKA+f+8OG5Nhrs2U2xtQ92FesGro88tX90bCVvDERQHfp36mUBLdA2OBariScchUzq3UH3YfXptRE8JQikak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768706463; c=relaxed/simple;
	bh=sJynAt+BQGAQfp8BlazcTjtdLTcMNAtx0PtCCtWcazk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obqL/HarSPadf+ojXi+D5aZK0k9HgjDPoBvRA6fLGpXD99f70YcChMsPxae3S5nCvUV5yxzvcgact0kZe2+oPBc2BkCQjZ4RJAa1ZdtsYhAEsjlltZYexPs86vZ6PKRzuQWowDQEOmhHiZbezd8u1qyO4587PnCEEJgE6d8gZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kiYOQrhC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 19:20:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768706448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMR9wI2uv1X/4qjLK3XWKSkgW5cDMnuo2Ij3j5rzC6k=;
	b=kiYOQrhCAW8JavoLiYIK4hQ0/S+LS6jUIUaLy0Lj38EivklOZQagpj22rgub2G5zC69To3
	U/1cKZK2smqGG28yG2w2cpViJXjjaRKmBMrC9iHAfyjW12usO8PLkorCKh2fVAw33neDId
	SZ2t15c+gH9g26Y5qkDlJtNBGb+rfjM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 28/30] mm: memcontrol: prepare for reparenting
 state_local
Message-ID: <iu27pt5nqs6myshw57e7dotld33v6lwuyouvquoqc2zmc5loi6@f23auf7hqbdp>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:55PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> To resolve the dying memcg issue, we need to reparent LRU folios of child
> memcg to its parent memcg. The following counts are all non-hierarchical
> and need to be reparented to prevent the counts of parent memcg overflow.
> 
> 1. memcg->vmstats->state_local[i]
> 2. pn->lruvec_stats->state_local[i]
> 
> This commit implements the specific function, which will be used during
> the reparenting process.

Please add more explanation which was discussed in the email chain at
https://lore.kernel.org/all/5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5/

Also move the upward traversal code in mod_memcg_state() and
mod_memcg_lruvec_state() you added in later patch to this patch and make
it under CONFIG_MEMCG_V1.

Something like:

#ifdef CONFIG_MEMCG_V1
	while (memcg_is_dying(memcg))
		memcg = parent_mem_cgroup(memcg);
#endif
		

> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/memcontrol.h |  4 +++
>  mm/memcontrol-v1.c         | 16 +++++++++++
>  mm/memcontrol-v1.h         |  3 ++
>  mm/memcontrol.c            | 56 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 26c3c0e375f58..f84a23f13ffb4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -963,12 +963,16 @@ static inline void mod_memcg_page_state(struct page *page,
>  
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
> +void reparent_memcg_state_local(struct mem_cgroup *memcg,
> +				struct mem_cgroup *parent, int idx);
>  unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  bool memcg_stat_item_valid(int idx);
>  bool memcg_vm_event_item_valid(enum vm_event_item idx);
>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  				      enum node_stat_item idx);
> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> +				       struct mem_cgroup *parent, int idx);
>  
>  void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index f0ef650d2317b..800606135e7ba 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1898,6 +1898,22 @@ static const unsigned int memcg1_events[] = {
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
> +	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
> +		reparent_memcg_lruvec_state_local(memcg, parent, memcg1_stats[i]);
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
> index 70583394f421f..7aa32b97c9f17 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -225,6 +225,28 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
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
> +	synchronize_rcu();

Hmm synchrinuze_rcu() is a heavy hammer here. Also you would need rcu
read lock in mod_memcg_state() & mod_memcg_lruvec_state() for this
synchronize_rcu().

Hmm instead of synchronize_rcu() here, we can use queue_rcu_work() in
css_killed_ref_fn(). It would be as simple as the following:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e717208cfb18..549a8e026194 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6046,8 +6046,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
-	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
+				 struct cgroup_subsys_state, destroy_rwork);
 
 	cgroup_lock();
 
@@ -6068,8 +6068,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	if (atomic_dec_and_test(&css->online_cnt)) {
-		INIT_WORK(&css->destroy_work, css_killed_work_fn);
-		queue_work(cgroup_offline_wq, &css->destroy_work);
+		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
+		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
 	}
 }
 
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

