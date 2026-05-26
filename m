Return-Path: <cgroups+bounces-16313-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGjK42NFWrUWQcAu9opvQ
	(envelope-from <cgroups+bounces-16313-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:09:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEF5D5532
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70388300EE97
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED23DDDBB;
	Tue, 26 May 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CRDQOFeh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9342350D7D
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797384; cv=none; b=d1L0sxiSYZQ0Bj3Sp3k6pYJE/+FFYXkxpnrN9yOyclGUPfwFPhgnf0p8E8nP/zpG10AglVnEbbjLEHnpdpTpzv3DZZNTrRw1zQEpMk4WRCRTzNkPh5KCIVVbKD2VNrbv6wjLYhNM22R4PkA2Bez//4A0U1HHP1FckPtzm9oAxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797384; c=relaxed/simple;
	bh=g/nul+3RGXRaIFqCcxDs9xBs0JU9/KuP/csAqYLGNsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dE5Q3CfjY/dLEYQeeJrnWcE2Io9Q99W6XZysporLoeYndJWCp5r9xvwdKz64ifg5P3nEWPdCMzP67mqVrEfNbD5WeupnWOTJT1w0xeL3Y9bK//U8MWvIcDfp6nVj2OEgcM065Th/L/tFnT6dBvykkjZ/oo0tVRjM+7JjaKGFDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CRDQOFeh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779797369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dEWDeMD4s4WPFdThtSlW+BGPpMqUmqyKI4KaSfbUkI=;
	b=CRDQOFehvmrdkKuXIZrzm3MwjJNZ51xCue05DJsfBuT/06JEFsL8SzhhOe+e053Yyjzf6P
	4HN4mltHH6qudTZEMbQr7l4VN6Q/eSMk4hwTnHjKM7oCFqLtYUa9jqnz6c6G0Wb6BNfPQI
	Gvxis9tXFkd5XulaDSXb7ygaik1bYPM=
From: Usama Arif <usama.arif@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] mm: switch deferred split shrinker to list_lru
Date: Tue, 26 May 2026 05:09:22 -0700
Message-ID: <20260526120923.2331056-1-usama.arif@linux.dev>
In-Reply-To: <20260521150330.1955924-9-hannes@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16313-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,kernel.org,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 56DEF5D5532
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 11:02:14 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> The deferred split queue handles cgroups in a suboptimal fashion. The
> queue is per-NUMA node or per-cgroup, not the intersection. That means
> on a cgrouped system, a node-restricted allocation entering reclaim
> can end up splitting large pages on other nodes:
> 
>         alloc/unmap
>           deferred_split_folio()
>             list_add_tail(memcg->split_queue)
>             set_shrinker_bit(memcg, node, deferred_shrinker_id)
> 
>         for_each_zone_zonelist_nodemask(restricted_nodes)
>           mem_cgroup_iter()
>             shrink_slab(node, memcg)
>               shrink_slab_memcg(node, memcg)
>                 if test_shrinker_bit(memcg, node, deferred_shrinker_id)
>                   deferred_split_scan()
>                     walks memcg->split_queue
> 
> The shrinker bit adds an imperfect guard rail. As soon as the cgroup
> has a single large page on the node of interest, all large pages owned
> by that memcg, including those on other nodes, will be split.
> 
> list_lru properly sets up per-node, per-cgroup lists. As a bonus, it
> streamlines a lot of the list operations and reclaim walks. It's used
> widely by other major shrinkers already. Convert the deferred split
> queue as well.
> 
> The list_lru per-memcg heads are instantiated on demand when the first
> object of interest is allocated for a cgroup, by calling
> folio_memcg_alloc_deferred(). Add calls to where splittable pages are
> created: anon faults, swapin faults, khugepaged collapse.
> 
> These calls create all possible node heads for the cgroup at once, so
> the migration code (between nodes) doesn't need any special care.
> 
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/huge_mm.h    |   7 +-
>  include/linux/memcontrol.h |   4 -
>  include/linux/mmzone.h     |  12 --
>  mm/huge_memory.c           | 355 ++++++++++++-------------------------
>  mm/internal.h              |   2 +-
>  mm/khugepaged.c            |   3 +
>  mm/memcontrol.c            |  12 +-
>  mm/memory.c                |   8 +
>  mm/mm_init.c               |  15 --
>  9 files changed, 133 insertions(+), 285 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 127f9e1e7604..dc939873f5df 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -398,10 +398,10 @@ static inline int split_huge_page(struct page *page)
>  {
>  	return split_huge_page_to_list_to_order(page, NULL, 0);
>  }
> +
> +int folio_memcg_alloc_deferred(struct folio *folio);
> +
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> -#ifdef CONFIG_MEMCG
> -void reparent_deferred_split_queue(struct mem_cgroup *memcg);
> -#endif
>  
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze);
> @@ -634,7 +634,6 @@ static inline int folio_split(struct folio *folio, unsigned int new_order,
>  }
>  
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> -static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
>  
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index dc3fa687759b..4a7d8c4f55b4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -277,10 +277,6 @@ struct mem_cgroup {
>  	struct memcg_cgwb_frn cgwb_frn[MEMCG_CGWB_FRN_CNT];
>  #endif
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct deferred_split deferred_split_queue;
> -#endif
> -
>  #ifdef CONFIG_LRU_GEN_WALKS_MMU
>  	/* per-memcg mm_struct list */
>  	struct lru_gen_mm_list mm_list;
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 1331a7b93f33..8e449f524f26 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1431,14 +1431,6 @@ struct zonelist {
>   */
>  extern struct page *mem_map;
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -struct deferred_split {
> -	spinlock_t split_queue_lock;
> -	struct list_head split_queue;
> -	unsigned long split_queue_len;
> -};
> -#endif
> -
>  #ifdef CONFIG_MEMORY_FAILURE
>  /*
>   * Per NUMA node memory failure handling statistics.
> @@ -1564,10 +1556,6 @@ typedef struct pglist_data {
>  	unsigned long first_deferred_pfn;
>  #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct deferred_split deferred_split_queue;
> -#endif
> -
>  #ifdef CONFIG_NUMA_BALANCING
>  	/* start time in ms of current promote rate limit period */
>  	unsigned int nbp_rl_start;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c565b2a651e0..67be09a58d5a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -14,6 +14,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
> +#include <linux/list_lru.h>
>  #include <linux/shrinker.h>
>  #include <linux/mm_inline.h>
>  #include <linux/swapops.h>
> @@ -67,6 +68,8 @@ unsigned long transparent_hugepage_flags __read_mostly =
>  	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
>  	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
>  
> +static struct lock_class_key deferred_split_key;
> +static struct list_lru deferred_split_lru;
>  static struct shrinker *deferred_split_shrinker;
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  					  struct shrink_control *sc);
> @@ -943,6 +946,13 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
>  }
>  #endif /* CONFIG_SYSFS */
>  
> +int folio_memcg_alloc_deferred(struct folio *folio)
> +{
> +	if (mem_cgroup_disabled())
> +		return 0;
> +	return folio_memcg_list_lru_alloc(folio, &deferred_split_lru, GFP_KERNEL);
> +}
> +
>  static int __init thp_shrinker_init(void)
>  {
>  	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
> @@ -952,6 +962,13 @@ static int __init thp_shrinker_init(void)
>  	if (!deferred_split_shrinker)
>  		return -ENOMEM;
>  
> +	if (list_lru_init_memcg_key(&deferred_split_lru,
> +				    deferred_split_shrinker,
> +				    &deferred_split_key)) {
> +		shrinker_free(deferred_split_shrinker);
> +		return -ENOMEM;
> +	}
> +
>  	deferred_split_shrinker->count_objects = deferred_split_count;
>  	deferred_split_shrinker->scan_objects = deferred_split_scan;
>  	shrinker_register(deferred_split_shrinker);
> @@ -973,6 +990,7 @@ static int __init thp_shrinker_init(void)
>  	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
>  	if (!huge_zero_folio_shrinker) {
>  		shrinker_free(deferred_split_shrinker);
> +		list_lru_destroy(&deferred_split_lru);
>  		return -ENOMEM;
>  	}
>  
> @@ -987,6 +1005,7 @@ static void __init thp_shrinker_exit(void)
>  {
>  	shrinker_free(huge_zero_folio_shrinker);
>  	shrinker_free(deferred_split_shrinker);
> +	list_lru_destroy(&deferred_split_lru);
>  }
>  
>  static int __init hugepage_init(void)
> @@ -1166,119 +1185,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  	return pmd;
>  }
>  
> -static struct deferred_split *split_queue_node(int nid)
> -{
> -	struct pglist_data *pgdata = NODE_DATA(nid);
> -
> -	return &pgdata->deferred_split_queue;
> -}
> -
> -#ifdef CONFIG_MEMCG
> -static inline
> -struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
> -					   struct deferred_split *queue)
> -{
> -	if (mem_cgroup_disabled())
> -		return NULL;
> -	if (split_queue_node(folio_nid(folio)) == queue)
> -		return NULL;
> -	return container_of(queue, struct mem_cgroup, deferred_split_queue);
> -}
> -
> -static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memcg)
> -{
> -	return memcg ? &memcg->deferred_split_queue : split_queue_node(nid);
> -}
> -#else
> -static inline
> -struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
> -					   struct deferred_split *queue)
> -{
> -	return NULL;
> -}
> -
> -static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memcg)
> -{
> -	return split_queue_node(nid);
> -}
> -#endif
> -
> -static struct deferred_split *split_queue_lock(int nid, struct mem_cgroup *memcg)
> -{
> -	struct deferred_split *queue;
> -
> -retry:
> -	queue = memcg_split_queue(nid, memcg);
> -	spin_lock(&queue->split_queue_lock);
> -	/*
> -	 * There is a period between setting memcg to dying and reparenting
> -	 * deferred split queue, and during this period the THPs in the deferred
> -	 * split queue will be hidden from the shrinker side.
> -	 */
> -	if (unlikely(memcg_is_dying(memcg))) {
> -		spin_unlock(&queue->split_queue_lock);
> -		memcg = parent_mem_cgroup(memcg);
> -		goto retry;
> -	}
> -
> -	return queue;
> -}
> -
> -static struct deferred_split *
> -split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags)
> -{
> -	struct deferred_split *queue;
> -
> -retry:
> -	queue = memcg_split_queue(nid, memcg);
> -	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> -	if (unlikely(memcg_is_dying(memcg))) {
> -		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
> -		memcg = parent_mem_cgroup(memcg);
> -		goto retry;
> -	}
> -
> -	return queue;
> -}
> -
> -static struct deferred_split *folio_split_queue_lock(struct folio *folio)
> -{
> -	struct deferred_split *queue;
> -
> -	rcu_read_lock();
> -	queue = split_queue_lock(folio_nid(folio), folio_memcg(folio));
> -	/*
> -	 * The memcg destruction path is acquiring the split queue lock for
> -	 * reparenting. Once you have it locked, it's safe to drop the rcu lock.
> -	 */
> -	rcu_read_unlock();
> -
> -	return queue;
> -}
> -
> -static struct deferred_split *
> -folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
> -{
> -	struct deferred_split *queue;
> -
> -	rcu_read_lock();
> -	queue = split_queue_lock_irqsave(folio_nid(folio), folio_memcg(folio), flags);
> -	rcu_read_unlock();
> -
> -	return queue;
> -}
> -
> -static inline void split_queue_unlock(struct deferred_split *queue)
> -{
> -	spin_unlock(&queue->split_queue_lock);
> -}
> -
> -static inline void split_queue_unlock_irqrestore(struct deferred_split *queue,
> -						 unsigned long flags)
> -{
> -	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
> -}
> -
>  static inline bool is_transparent_hugepage(const struct folio *folio)
>  {
>  	if (!folio_test_large(folio))
> @@ -1379,6 +1285,14 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>  		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>  		return NULL;
>  	}
> +
> +	if (folio_memcg_alloc_deferred(folio)) {
> +		folio_put(folio);
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		return NULL;
> +	}
> +
>  	folio_throttle_swaprate(folio, gfp);
>  
>         /*
> @@ -3888,34 +3802,40 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
>  	struct folio *end_folio = folio_next(folio);
>  	struct folio *new_folio, *next;
>  	int old_order = folio_order(folio);
> +	struct list_lru_one *lru;
> +	bool dequeue_deferred;
>  	int ret = 0;
> -	struct deferred_split *ds_queue;
>  
>  	VM_WARN_ON_ONCE(!mapping && end);
> -	/* Prevent deferred_split_scan() touching ->_refcount */
> -	ds_queue = folio_split_queue_lock(folio);
> +	/*
> +	 * If this folio can be on the deferred split queue, lock out
> +	 * the shrinker before freezing the ref. If the shrinker sees
> +	 * a 0-ref folio, it assumes it beat folio_put() to the list
> +	 * lock and must clean up the LRU state - the same dequeue we
> +	 * will do below as part of the split.
> +	 */
> +	dequeue_deferred = folio_test_anon(folio) && old_order > 1;
> +	if (dequeue_deferred) {
> +		rcu_read_lock();
> +		lru = list_lru_lock(&deferred_split_lru,
> +				    folio_nid(folio), folio_memcg(folio));
> +	}
>  	if (folio_ref_freeze(folio, folio_cache_ref_count(folio) + 1)) {
>  		struct swap_cluster_info *ci = NULL;
>  		struct lruvec *lruvec;
>  
> -		if (old_order > 1) {
> -			if (!list_empty(&folio->_deferred_list)) {
> -				ds_queue->split_queue_len--;
> -				/*
> -				 * Reinitialize page_deferred_list after removing the
> -				 * page from the split_queue, otherwise a subsequent
> -				 * split will see list corruption when checking the
> -				 * page_deferred_list.
> -				 */
> -				list_del_init(&folio->_deferred_list);
> -			}
> +		if (dequeue_deferred) {
> +			__list_lru_del(&deferred_split_lru, lru,
> +				       &folio->_deferred_list, folio_nid(folio));
>  			if (folio_test_partially_mapped(folio)) {
>  				folio_clear_partially_mapped(folio);
>  				mod_mthp_stat(old_order,
>  					MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>  			}
> +			list_lru_unlock(lru);
> +			rcu_read_unlock();
>  		}
> -		split_queue_unlock(ds_queue);
> +
>  		if (mapping) {
>  			int nr = folio_nr_pages(folio);
>  
> @@ -4015,7 +3935,10 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
>  		if (ci)
>  			swap_cluster_unlock(ci);
>  	} else {
> -		split_queue_unlock(ds_queue);
> +		if (dequeue_deferred) {
> +			list_lru_unlock(lru);
> +			rcu_read_unlock();
> +		}
>  		return -EAGAIN;
>  	}
>  
> @@ -4381,33 +4304,35 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
>   * queueing THP splits, and that list is (racily observed to be) non-empty.
>   *
>   * It is unsafe to call folio_unqueue_deferred_split() until folio refcount is
> - * zero: because even when split_queue_lock is held, a non-empty _deferred_list
> - * might be in use on deferred_split_scan()'s unlocked on-stack list.
> + * zero: because even when the list_lru lock is held, a non-empty
> + * _deferred_list might be in use on deferred_split_scan()'s unlocked
> + * on-stack list.
>   *
> - * If memory cgroups are enabled, split_queue_lock is in the mem_cgroup: it is
> - * therefore important to unqueue deferred split before changing folio memcg.
> + * The list_lru sublist is determined by folio's memcg: it is therefore
> + * important to unqueue deferred split before changing folio memcg.
>   */
>  bool __folio_unqueue_deferred_split(struct folio *folio)
>  {
> -	struct deferred_split *ds_queue;
> +	struct list_lru_one *lru;
> +	int nid = folio_nid(folio);
>  	unsigned long flags;
>  	bool unqueued = false;
>  
>  	WARN_ON_ONCE(folio_ref_count(folio));
>  	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
>  
> -	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
> -	if (!list_empty(&folio->_deferred_list)) {
> -		ds_queue->split_queue_len--;
> +	rcu_read_lock();
> +	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, folio_memcg(folio), &flags);
> +	if (__list_lru_del(&deferred_split_lru, lru, &folio->_deferred_list, nid)) {
>  		if (folio_test_partially_mapped(folio)) {
>  			folio_clear_partially_mapped(folio);
>  			mod_mthp_stat(folio_order(folio),
>  				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>  		}
> -		list_del_init(&folio->_deferred_list);
>  		unqueued = true;
>  	}
> -	split_queue_unlock_irqrestore(ds_queue, flags);
> +	list_lru_unlock_irqrestore(lru, &flags);
> +	rcu_read_unlock();
>  
>  	return unqueued;	/* useful for debug warnings */
>  }
> @@ -4415,7 +4340,9 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
>  /* partially_mapped=false won't clear PG_partially_mapped folio flag */
>  void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  {
> -	struct deferred_split *ds_queue;
> +	struct list_lru_one *lru;
> +	int nid;
> +	struct mem_cgroup *memcg;
>  	unsigned long flags;
>  
>  	/*
> @@ -4438,7 +4365,11 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  	if (folio_test_swapcache(folio))
>  		return;
>  
> -	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
> +	nid = folio_nid(folio);
> +
> +	rcu_read_lock();
> +	memcg = folio_memcg(folio);
> +	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, memcg, &flags);
>  	if (partially_mapped) {
>  		if (!folio_test_partially_mapped(folio)) {
>  			folio_set_partially_mapped(folio);
> @@ -4446,36 +4377,20 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>  			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>  			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, 1);
> -
>  		}
>  	} else {
>  		/* partially mapped folios cannot become non-partially mapped */
>  		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
>  	}
> -	if (list_empty(&folio->_deferred_list)) {
> -		struct mem_cgroup *memcg;
> -
> -		memcg = folio_split_queue_memcg(folio, ds_queue);
> -		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
> -		ds_queue->split_queue_len++;
> -		if (memcg)
> -			set_shrinker_bit(memcg, folio_nid(folio),
> -					 shrinker_id(deferred_split_shrinker));
> -	}
> -	split_queue_unlock_irqrestore(ds_queue, flags);
> +	__list_lru_add(&deferred_split_lru, lru, &folio->_deferred_list, nid, memcg);
> +	list_lru_unlock_irqrestore(lru, &flags);
> +	rcu_read_unlock();

Can the shrinker bit end up on the wrong memcg here?

deferred_split_folio() takes the lock via list_lru_lock_irqsave() with
the original folio_memcg() of the folio. If that memcg is dying and
already reparented, lock_list_lru_of_memcg() walks up parent_mem_cgroup()
until it finds a live sublist and locks it (lru), but the memcg local
variable still points at the dying child.

__list_lru_add() then calls set_shrinker_bit(memcg, ...) with the
original (dying / reparented) memcg, not the parent that actually owns
the locked sublist where the folio was queued.

>  }
>  
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> -	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> -	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
> -
> -#ifdef CONFIG_MEMCG
> -	if (sc->memcg)
> -		ds_queue = &sc->memcg->deferred_split_queue;
> -#endif
> -	return READ_ONCE(ds_queue->split_queue_len);
> +	return list_lru_shrink_count(&deferred_split_lru, sc);
>  }
>  
>  static bool thp_underused(struct folio *folio)
> @@ -4505,45 +4420,45 @@ static bool thp_underused(struct folio *folio)
>  	return false;
>  }
>  
> +static enum lru_status deferred_split_isolate(struct list_head *item,
> +					      struct list_lru_one *lru,
> +					      void *cb_arg)
> +{
> +	struct folio *folio = container_of(item, struct folio, _deferred_list);
> +	struct list_head *freeable = cb_arg;
> +
> +	if (folio_try_get(folio)) {
> +		list_lru_isolate_move(lru, item, freeable);
> +		return LRU_REMOVED;
> +	}
> +
> +	/* We lost race with folio_put() */
> +	list_lru_isolate(lru, item);
> +	if (folio_test_partially_mapped(folio)) {
> +		folio_clear_partially_mapped(folio);
> +		mod_mthp_stat(folio_order(folio),
> +			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> +	}
> +	return LRU_REMOVED;
> +}
> +
>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> -	struct deferred_split *ds_queue;
> -	unsigned long flags;
> +	LIST_HEAD(dispose);
>  	struct folio *folio, *next;
> -	int split = 0, i;
> -	struct folio_batch fbatch;
> +	int split = 0;
> +	unsigned long isolated;
>  
> -	folio_batch_init(&fbatch);
> +	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
> +					    deferred_split_isolate, &dispose);
>  
> -retry:
> -	ds_queue = split_queue_lock_irqsave(sc->nid, sc->memcg, &flags);
> -	/* Take pin on all head pages to avoid freeing them under us */
> -	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
> -							_deferred_list) {
> -		if (folio_try_get(folio)) {
> -			folio_batch_add(&fbatch, folio);
> -		} else if (folio_test_partially_mapped(folio)) {
> -			/* We lost race with folio_put() */
> -			folio_clear_partially_mapped(folio);
> -			mod_mthp_stat(folio_order(folio),
> -				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> -		}
> -		list_del_init(&folio->_deferred_list);
> -		ds_queue->split_queue_len--;
> -		if (!--sc->nr_to_scan)
> -			break;
> -		if (!folio_batch_space(&fbatch))
> -			break;
> -	}
> -	split_queue_unlock_irqrestore(ds_queue, flags);
> -
> -	for (i = 0; i < folio_batch_count(&fbatch); i++) {
> +	list_for_each_entry_safe(folio, next, &dispose, _deferred_list) {
>  		bool did_split = false;
>  		bool underused = false;
> -		struct deferred_split *fqueue;
>  
> -		folio = fbatch.folios[i];
> +		list_del_init(&folio->_deferred_list);
> +
>  		if (!folio_test_partially_mapped(folio)) {
>  			/*
>  			 * See try_to_map_unused_to_zeropage(): we cannot
> @@ -4572,63 +4487,23 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		 * underused, then consider it used and don't add it back to
>  		 * split_queue.
>  		 */
> -		if (did_split || !folio_test_partially_mapped(folio))
> -			continue;
> +		if (!did_split && folio_test_partially_mapped(folio)) {
>  requeue:
> -		/*
> -		 * Add back partially mapped folios, or underused folios that
> -		 * we could not lock this round.
> -		 */
> -		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
> -		if (list_empty(&folio->_deferred_list)) {
> -			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
> -			fqueue->split_queue_len++;
> +			rcu_read_lock();
> +			list_lru_add_irq(&deferred_split_lru,
> +					 &folio->_deferred_list,
> +					 folio_nid(folio),
> +					 folio_memcg(folio));
> +			rcu_read_unlock();
>  		}
> -		split_queue_unlock_irqrestore(fqueue, flags);
> -	}
> -	folios_put(&fbatch);
> -
> -	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue)) {
> -		cond_resched();
> -		goto retry;
> +		folio_put(folio);
>  	}
>  
> -	/*
> -	 * Stop shrinker if we didn't split any page, but the queue is empty.
> -	 * This can happen if pages were freed under us.
> -	 */
> -	if (!split && list_empty(&ds_queue->split_queue))
> +	if (!split && !isolated)
>  		return SHRINK_STOP;
>  	return split;
>  }
>  
> -#ifdef CONFIG_MEMCG
> -void reparent_deferred_split_queue(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> -	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
> -	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
> -	int nid;
> -
> -	spin_lock_irq(&ds_queue->split_queue_lock);
> -	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
> -
> -	if (!ds_queue->split_queue_len)
> -		goto unlock;
> -
> -	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
> -	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
> -	ds_queue->split_queue_len = 0;
> -
> -	for_each_node(nid)
> -		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
> -
> -unlock:
> -	spin_unlock(&parent_ds_queue->split_queue_lock);
> -	spin_unlock_irq(&ds_queue->split_queue_lock);
> -}
> -#endif
> -
>  #ifdef CONFIG_DEBUG_FS
>  static void split_huge_pages_all(void)
>  {
> diff --git a/mm/internal.h b/mm/internal.h
> index 09931b1e535f..e5bf549ad78e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -861,7 +861,7 @@ static inline bool folio_unqueue_deferred_split(struct folio *folio)
>  	/*
>  	 * At this point, there is no one trying to add the folio to
>  	 * deferred_list. If folio is not in deferred_list, it's safe
> -	 * to check without acquiring the split_queue_lock.
> +	 * to check without acquiring the list_lru lock.
>  	 */
>  	if (data_race(list_empty(&folio->_deferred_list)))
>  		return false;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1a25af3d6d0f..644de0410c12 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1301,6 +1301,9 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>  
> +	if (folio_memcg_alloc_deferred(folio))
> +		goto out_nolock;
> +

Over here, you will end up reporting success on allocation failure.

Maybe set result to SCAN_ALLOC_HUGE_PAGE_FAIL?


>  	mmap_read_lock(mm);
>  	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
>  					 &vma, cc, order);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index aa7361b0d2da..fe896824078b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4065,11 +4065,6 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>  		memcg->cgwb_frn[i].done =
>  			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
> -#endif
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
> -	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
> -	memcg->deferred_split_queue.split_queue_len = 0;
>  #endif
>  	lru_gen_init_memcg(memcg);
>  	return memcg;
> @@ -4221,11 +4216,10 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	zswap_memcg_offline_cleanup(memcg);
>  
>  	memcg_offline_kmem(memcg);
> -	reparent_deferred_split_queue(memcg);
>  	/*
> -	 * The reparenting of objcg must be after the reparenting of the
> -	 * list_lru and deferred_split_queue above, which ensures that they will
> -	 * not mistakenly get the parent list_lru and deferred_split_queue.
> +	 * The reparenting of objcg must be after the reparenting of
> +	 * the list_lru in memcg_offline_kmem(), which ensures that
> +	 * they will not mistakenly get the parent list_lru.
>  	 */
>  	memcg_reparent_objcgs(memcg);
>  	reparent_shrinker_deferred(memcg);
> diff --git a/mm/memory.c b/mm/memory.c
> index 552fe26a042a..b97e3145982a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4759,6 +4759,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  			folio_put(folio);
>  			goto next;
>  		}
> +		if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> +			folio_put(folio);
> +			goto fallback;
> +		}
>  		return folio;
>  next:
>  		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> @@ -5279,6 +5283,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  			folio_put(folio);
>  			goto next;
>  		}
> +		if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> +			folio_put(folio);
> +			goto fallback;
> +		}
>  		folio_throttle_swaprate(folio, gfp);
>  		/*
>  		 * When a folio is not zeroed during allocation
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index db5568cf36e1..c0a7f1cf6fef 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1373,19 +1373,6 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
>  }
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static void pgdat_init_split_queue(struct pglist_data *pgdat)
> -{
> -	struct deferred_split *ds_queue = &pgdat->deferred_split_queue;
> -
> -	spin_lock_init(&ds_queue->split_queue_lock);
> -	INIT_LIST_HEAD(&ds_queue->split_queue);
> -	ds_queue->split_queue_len = 0;
> -}
> -#else
> -static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
> -#endif
> -
>  #ifdef CONFIG_COMPACTION
>  static void pgdat_init_kcompactd(struct pglist_data *pgdat)
>  {
> @@ -1401,8 +1388,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  
>  	pgdat_resize_init(pgdat);
>  	pgdat_kswapd_lock_init(pgdat);
> -
> -	pgdat_init_split_queue(pgdat);
>  	pgdat_init_kcompactd(pgdat);
>  
>  	init_waitqueue_head(&pgdat->kswapd_wait);
> -- 
> 2.54.0
> 
> 

