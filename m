Return-Path: <cgroups+bounces-17244-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ofcZHC7uO2oyfggAu9opvQ
	(envelope-from <cgroups+bounces-17244-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:48:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA16BF49E
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:48:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="L+y8/CCL";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17244-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17244-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 010E5300BD52
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC73CB2DF;
	Wed, 24 Jun 2026 14:44:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFE3C943F;
	Wed, 24 Jun 2026 14:44:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312250; cv=none; b=SXHkaSru8l/YKj9Bi8L9GQb3rMwm22yee0OP2fEV6/f4V5wbJ/pkimM7d7Ge5hQE58ZTCoUCkvK+3H3jpSaaHLYwzSbwOmCMcvUj41FUFQkpi/N4gmdjOLOQ7nh7P8gAtaGSBOICAms6Czd69F6eC1Lr9GRIGMhDJqRDTbNx8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312250; c=relaxed/simple;
	bh=Pni8XeMFaLuHzsr0aaBwd+vqSlUI2eVp/LH/jNmXYVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU4eC/iHdPn/Ienz5czXXwHVPfVYNMWGFnQqcbkV9vaX04GeXcs04M0Y7ZY7clvDyKo/LE5VU9dpPHuptmZ48i7lYuR9R15UnvRzeBDX0/MW66sh7Fti+HvLFTAkPeU/hpxcfU05+39Rgd0dRUbO0nLWpd4bHEWH5tpOWuieVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+y8/CCL; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782312246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PGmacesfs5D7l88/LYc0Jj+8T2MBmH/nLSbNfGqkXo=;
	b=L+y8/CCLptX4rVDt3mUoH2+z/RlxAGGHesMozRiYtc51iD7ksQVhnoE3wpcIBGe689UFWh
	4yunwbmU7mx07/KO2uHSgFjCW1VeVNqq/ChP07BM7crn76c9ZQ5ONb5EPN1phEoWDwFzGd
	a+zjUTd4M/8w0y69tl8+2i93Wt+JjeQ=
From: Usama Arif <usama.arif@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock
Date: Wed, 24 Jun 2026 07:43:47 -0700
Message-ID: <20260624144348.4117578-1-usama.arif@linux.dev>
In-Reply-To: <20260623180124.868655-5-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17244-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:usama.arif@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64FA16BF49E

On Tue, 23 Jun 2026 11:01:22 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Now with all of the memcg_stock handling logic replicated in
> page_counter_stock, switch memcg to use the page_counter_stock for the
> memory (and for cgroup v1 users, memsw) page_counters.
> 
> There are a few details that have changed:
> 
> First, the old special-casing for the !allow_spinning check to avoid
> refilling and flushing of the old stock is removed. This special casing
> was important previously, because refilling the stock could do a lot of
> extra work by evicting one of 7 random victim memcgs in the percpu
> memcg_stock slots. In the new per-counter design, refilling stock just
> adds pages to the counter's own local cache without affecting other memcgs,
> so the original reason for the special case no longer applies.
> 
> Also, we can now fail during page_counter_alloc_stock(), if there is
> not enough memory to allocate a percpu page_counter_stock. This failure
> is rare and nonfatal; the system can continue to operate, with the page
> counter working without stock and falling back to walking the hierarchy.
> 
> drain_all_stock and memcg_hotplug_cpu_dead also now use the page_counter
> stock drain variant, which uses remote atomic_xchg to retrieve stock
> across CPUs, instead of scheduling asynchronous work.
> 
> Finally, as a side-effect of separating the per-memcg stock to per-
> page_counter, the memsw and memory page_counters have independent stock.
> This means that the reported memsw may transiently be lower than memory
> usage if the stock for memory and memsw page_counters go out of sync.
> 
> Note that obj_stock is untouched by this change.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  mm/memcontrol.c | 87 +++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 306658fd55512..846800917af49 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2269,39 +2269,36 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>  		queue_work_on(cpu, memcg_wq, work);
>  }
>  
> +static void memcg_drain_stock(struct mem_cgroup *memcg, int cpu)
> +{
> +	page_counter_drain_stock(&memcg->memory, cpu);
> +	if (do_memsw_account())
> +		page_counter_drain_stock(&memcg->memsw, cpu);
> +}
> +
>  /*
>   * Drains all per-CPU charge caches for given root_memcg resp. subtree
>   * of the hierarchy under it.
>   */
>  void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> +	struct mem_cgroup *memcg;
>  	int cpu, curcpu;
>  
>  	/* If someone's already draining, avoid adding running more workers. */
>  	if (!mutex_trylock(&percpu_charge_mutex))
>  		return;
> -	/*
> -	 * Notify other cpus that system-wide "drain" is running
> -	 * We do not care about races with the cpu hotplug because cpu down
> -	 * as well as workers from this path always operate on the local
> -	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
> -	 */
> +
> +	for_each_mem_cgroup_tree(memcg, root_memcg) {
> +		for_each_online_cpu(cpu)
> +			memcg_drain_stock(memcg, cpu);
> +	}
> +
>  	migrate_disable();
>  	curcpu = smp_processor_id();
>  	for_each_online_cpu(cpu) {
> -		struct memcg_stock_pcp *memcg_st = &per_cpu(memcg_stock, cpu);
>  		struct obj_stock_pcp *obj_st = &per_cpu(obj_stock, cpu);
>  
> -		if (!test_bit(FLUSHING_CACHED_CHARGE, &memcg_st->flags) &&
> -		    is_memcg_drain_needed(memcg_st, root_memcg) &&
> -		    !test_and_set_bit(FLUSHING_CACHED_CHARGE,
> -				      &memcg_st->flags)) {
> -			if (cpu == curcpu)
> -				drain_local_memcg_stock(&memcg_st->work);
> -			else
> -				schedule_drain_work(cpu, &memcg_st->work);
> -		}
> -
>  		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
>  		    obj_stock_flush_required(obj_st, root_memcg) &&
>  		    !test_and_set_bit(FLUSHING_CACHED_CHARGE,
> @@ -2318,9 +2315,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  
>  static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  {
> +	struct mem_cgroup *memcg;
> +
>  	/* no need for the local lock */
>  	drain_obj_stock(&per_cpu(obj_stock, cpu));
> -	drain_stock_fully(&per_cpu(memcg_stock, cpu));
> +
> +	for_each_mem_cgroup(memcg)
> +		memcg_drain_stock(memcg, cpu);
>  
>  	return 0;
>  }
> @@ -2595,7 +2596,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  			    unsigned int nr_pages)
>  {
> -	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
>  	int nr_retries = MAX_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
>  	struct page_counter *counter;
> @@ -2606,36 +2606,30 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool raised_max_event = false;
>  	unsigned long pflags;
>  	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> +	unsigned long nr_charged = 0;
>  
>  retry:
> -	if (consume_stock(memcg, nr_pages))
> -		return 0;
> -
> -	if (!allow_spinning)
> -		/* Avoid the refill and flush of the older stock */
> -		batch = nr_pages;
> -
>  	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  	if (do_memsw_account() &&
> -	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
> +	    !page_counter_try_charge_stock(&memcg->memsw, nr_pages,
> +					   &counter, NULL)) {
>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
>  		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>  		goto reclaim;
>  	}
>  
> -	if (page_counter_try_charge(&memcg->memory, batch, &counter))
> -		goto done_restock;
> +	if (page_counter_try_charge_stock(&memcg->memory, nr_pages,
> +					  &counter, &nr_charged)) {
> +		if (!nr_charged)
> +			return 0;
> +		goto handle_high;
> +	}
>  
>  	if (do_memsw_account())
> -		page_counter_uncharge(&memcg->memsw, batch);
> +		page_counter_uncharge(&memcg->memsw, nr_pages);

This needs a transactional rollback. page_counter_try_charge_stock() can
succeed by consuming memsw stock and charging 0 new pages, but the
memory-failure path unconditionally uncharges nr_pages from memsw.
That turns a failed allocation into a real memsw usage decrement.


>  	mem_over_limit = mem_cgroup_from_counter(counter, memory);
>  
>  reclaim:
> -	if (batch > nr_pages) {
> -		batch = nr_pages;
> -		goto retry;
> -	}
> -
>  	/*
>  	 * Prevent unbounded recursion when reclaim operations need to
>  	 * allocate memory. This might exceed the limits temporarily,
> @@ -2731,10 +2725,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	return 0;
>  
> -done_restock:
> -	if (batch > nr_pages)
> -		refill_stock(memcg, batch - nr_pages);
> -
> +handle_high:
>  	/*
>  	 * If the hierarchy is above the normal consumption range, schedule
>  	 * reclaim on returning to userland.  We can perform reclaim here
> @@ -2771,7 +2762,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  			 * and distribute reclaim work and delay penalties
>  			 * based on how much each task is actually allocating.
>  			 */
> -			current->memcg_nr_pages_over_high += batch;
> +			current->memcg_nr_pages_over_high += nr_charged;
>  			set_notify_resume(current);
>  			break;
>  		}
> @@ -3076,7 +3067,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  	account_kmem_nmi_safe(memcg, -nr_pages);
>  	memcg1_account_kmem(memcg, -nr_pages);
>  	if (!mem_cgroup_is_root(memcg))
> -		refill_stock(memcg, nr_pages);
> +		memcg_uncharge(memcg, nr_pages);
>  
>  	css_put(&memcg->css);
>  }
> @@ -4080,6 +4071,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>  
>  static void mem_cgroup_free(struct mem_cgroup *memcg)
>  {
> +	page_counter_free_stock(&memcg->memory);
> +	page_counter_free_stock(&memcg->memsw);
>  	lru_gen_exit_memcg(memcg);
>  	memcg_wb_domain_exit(memcg);
>  	__mem_cgroup_free(memcg);
> @@ -4247,6 +4240,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	refcount_set(&memcg->id.ref, 1);
>  	css_get(css);
>  
> +	/* failure is nonfatal, charges fall back to direct hierarchy */
> +	page_counter_alloc_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
> +	if (do_memsw_account())
> +		page_counter_alloc_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
> +
>  	/*
>  	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
>  	 *
> @@ -5502,7 +5500,7 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
>  
>  	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
>  
> -	refill_stock(memcg, nr_pages);
> +	page_counter_uncharge(&memcg->memory, nr_pages);
>  }
>  
>  void mem_cgroup_flush_workqueue(void)
> @@ -5555,12 +5553,9 @@ int __init mem_cgroup_init(void)
>  	memcg_wq = alloc_workqueue("memcg", WQ_PERCPU, 0);
>  	WARN_ON(!memcg_wq);
>  
> -	for_each_possible_cpu(cpu) {
> -		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
> -			  drain_local_memcg_stock);
> +	for_each_possible_cpu(cpu)
>  		INIT_WORK(&per_cpu_ptr(&obj_stock, cpu)->work,
>  			  drain_local_obj_stock);
> -	}
>  
>  	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
>  	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
> -- 
> 2.53.0-Meta
> 
> 

