Return-Path: <cgroups+bounces-6336-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA7A1D639
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4557A307B
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BACD1FF1B5;
	Mon, 27 Jan 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D1JI4BTk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B24430
	for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982302; cv=none; b=l2zgBjMsCeEeZJ/Ism4pJsjMaLF6rVrVIuahX/GrJnjFCJe7JNybd46SIsDs+ydSkI3faMZqdlHytrZcrBwRK6/yuWqPfpNr0dpsFrGJIUVyPxlmTzSes2/akUePmGOaHoaOzeiaENF95qGnokaZ31P9QpWtR16gFEjN5IONL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982302; c=relaxed/simple;
	bh=K7OTzi7vVRH7yxAiND7Vw0w+Kx0ls4KcJ6bwIiYAv+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWIGgfs0ZrUm6aUnV6LdFLPl3LcS8QxnFBDlnh/aqUqKzsB3LM1lMDw9dbUycacdH4zE5lLIp34cIuqJkx2ivPeCxoESq02aglH9NRAOn64BN2zF7GGdG64DMtXphThbFgKLQudCNz1Mgl8tRdgXNTsIT99P1iDeqkYvcjv+BQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D1JI4BTk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43635796b48so27954465e9.0
        for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737982299; x=1738587099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUdOnZ3pVPXHNipHXzmTmcF4SHP8faxq+VQ81N4+Q4w=;
        b=D1JI4BTk7xKckvSW5IQGFJ8Wtt7Gy5rAO4ruPuSNhDRJVRdkg+yQMFrE1FM5xFrg3m
         cHiREgEBegjjQ0VTG4Oi9f/nVIAER2XQ40gUxCs1YL/jFspcqNqirrvKMYqAucT60Sq9
         N/6fwrO4sE3NZ1KfjOpqX8cdt2ZjOMb9eM/8gvpialI/H18yO0ufzKGkXkcwt4nMFi9s
         XWKRLrG/slKlFLaqq4+/l8XrTMgbgRgkOLJRlMKBptf1fz57lnu+g7Sxi42SEI3rcLN+
         iKQJDWs3g+h3VUVx+WlxicqZO3JXUNyqfmW+ePluwy2C+nBTyxkCpG7IK9j0gQ3ztMac
         KWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982299; x=1738587099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUdOnZ3pVPXHNipHXzmTmcF4SHP8faxq+VQ81N4+Q4w=;
        b=CJeZJF+FR7uW+laCarkb/iXP7ebImt1eD45ZBkeVtzX5CbPWOixvreLIAMn8f8FGDT
         hvSSBi8sQdQ3WHOt6wnpb3kmlE3V7YT6dnx19vvKtukFCfnmQtwJvTRVc4Avx3f6xbs0
         WAjbbZ0hBz9rtWd5egDgLQYMAhBIBWLNbScjx9sI+PG5vuJ61Nnw4xIthmLjnzZTXl6Q
         BCB/QofGKRbnLKq5qfTbJeizg65mQ0IdA+KXdX0iRJr4czr8WS7O7ABVR8gGm/rI+dyH
         79Stu+GM4n6dfyxTQf05Q08rkTDB4nz7AOKSY7PL5xw2Bs4Hazl7lDhcqS843k2YZndr
         eszA==
X-Forwarded-Encrypted: i=1; AJvYcCXok0wNtmm2gKEKcou51MLZh98omlvkotwm8CIKoY1hdFwmqXe0pgnlpB98BV2Y2X+aGdOojBWl@vger.kernel.org
X-Gm-Message-State: AOJu0YzelNatXOHE7uGs70/QhU+tMe9IJiePaREKb5d+ow9k9gAx01W+
	2WaTV0sA/vwpRG0eilsRchtbOjdV4byhia5prnxfCwRIsxqVHm8LTPwB+xt04Io=
X-Gm-Gg: ASbGncsjdfA9yFrNXSb4Kr5L+juuYcyUe5k7I+L5mR3bYLeha+EvAN6cXES6vWs1PrE
	956nsXSiU/rpobSAhJLc8gLuzP7qSMaKQTc+yKWkSqM61CvUafQ/ZhxJzlpkK9j5Q6qumWxi9l6
	kJmbjDV9zl8cv11sYvVfJPhMZdrXS9VPpYKWfgvyE4B0IGBKPihwPhXSJTuTiO5JGnYG3KCXanp
	nWTZel7Hg/bqvh3vKXamzRu5emoDb/S87VpFqDCf3ojn8bLFl7zcyBPF8f+3LFPkeBKflnIc9hz
	OcfkcMwXP9fkIUBOBijldxCRGw==
X-Google-Smtp-Source: AGHT+IGz9ZQe0lgKhGXT9MpFYZau7KXgXCWDlVpa+MVDrAbANHbmcWfnpKYyI2WJ4jTfYXI07gq7kg==
X-Received: by 2002:a05:600c:6a8a:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-438bd0611f5mr103951235e9.6.1737982298629;
        Mon, 27 Jan 2025 04:51:38 -0800 (PST)
Received: from localhost (109-81-84-37.rct.o2.cz. [109.81.84.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4900e2sm131201275e9.24.2025.01.27.04.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 04:51:38 -0800 (PST)
Date: Mon, 27 Jan 2025 13:51:37 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
Message-ID: <Z5eBWRRINH5RaeRk@tiehlicka>
References: <20250124054132.45643-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124054132.45643-1-hannes@cmpxchg.org>

On Fri 24-01-25 00:41:32, Johannes Weiner wrote:
> The interweaving of two entirely different swap accounting strategies
> has been one of the more confusing parts of the memcg code. Split out
> the v1 code to clarify the implementation and a handful of callsites,
> and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> 
>    text	  data	   bss	   dec	   hex	filename
>   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
>   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/memcontrol.h |  17 +++--
>  include/linux/swap.h       |   5 --
>  mm/huge_memory.c           |   2 +-
>  mm/memcontrol-v1.c         |  89 ++++++++++++++++++++++++-
>  mm/memcontrol-v1.h         |   6 +-
>  mm/memcontrol.c            | 129 ++++++-------------------------------
>  mm/memory.c                |   2 +-
>  mm/shmem.c                 |   2 +-
>  mm/swap_state.c            |   2 +-
>  mm/vmscan.c                |   2 +-
>  10 files changed, 126 insertions(+), 130 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6e74b8254d9b..57664e2a8fb7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -649,8 +649,6 @@ int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  				  gfp_t gfp, swp_entry_t entry);
>  
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
> -
>  void __mem_cgroup_uncharge(struct folio *folio);
>  
>  /**
> @@ -1165,10 +1163,6 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
>  	return 0;
>  }
>  
> -static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr)
> -{
> -}
> -
>  static inline void mem_cgroup_uncharge(struct folio *folio)
>  {
>  }
> @@ -1848,6 +1842,9 @@ static inline void mem_cgroup_exit_user_fault(void)
>  	current->in_user_fault = 0;
>  }
>  
> +void memcg1_swapout(struct folio *folio, swp_entry_t entry);
> +void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages);
> +
>  #else /* CONFIG_MEMCG_V1 */
>  static inline
>  unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> @@ -1875,6 +1872,14 @@ static inline void mem_cgroup_exit_user_fault(void)
>  {
>  }
>  
> +static inline void memcg1_swapout(struct folio *folio, swp_entry_t entry)
> +{
> +}
> +
> +static inline void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
> +{
> +}
> +
>  #endif /* CONFIG_MEMCG_V1 */
>  
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b13b72645db3..91b30701274e 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -659,7 +659,6 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
>  #endif
>  
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
> -void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
>  int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
>  static inline int mem_cgroup_try_charge_swap(struct folio *folio,
>  		swp_entry_t entry)
> @@ -680,10 +679,6 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct folio *folio);
>  #else
> -static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
> -{
> -}
> -
>  static inline int mem_cgroup_try_charge_swap(struct folio *folio,
>  					     swp_entry_t entry)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3d3ebdc002d5..c40b42a1015a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3740,7 +3740,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  
>  	/*
>  	 * Exclude swapcache: originally to avoid a corrupt deferred split
> -	 * queue. Nowadays that is fully prevented by mem_cgroup_swapout();
> +	 * queue. Nowadays that is fully prevented by memcg1_swapout();
>  	 * but if page reclaim is already handling the same folio, it is
>  	 * unnecessary to handle it again in the shrinker, so excluding
>  	 * swapcache here may still be a useful optimization.
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6d184fae0ad1..1d16a99fb964 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -581,8 +581,59 @@ void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  	local_irq_restore(flags);
>  }
>  
> -void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg)
> +/**
> + * memcg1_swapout - transfer a memsw charge to swap
> + * @folio: folio whose memsw charge to transfer
> + * @entry: swap entry to move the charge to
> + *
> + * Transfer the memsw charge of @folio to @entry.
> + */
> +void memcg1_swapout(struct folio *folio, swp_entry_t entry)
>  {
> +	struct mem_cgroup *memcg, *swap_memcg;
> +	unsigned int nr_entries;
> +
> +	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	if (!do_memsw_account())
> +		return;
> +
> +	memcg = folio_memcg(folio);
> +
> +	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
> +	if (!memcg)
> +		return;
> +
> +	/*
> +	 * In case the memcg owning these pages has been offlined and doesn't
> +	 * have an ID allocated to it anymore, charge the closest online
> +	 * ancestor for the swap instead and transfer the memory+swap charge.
> +	 */
> +	swap_memcg = mem_cgroup_id_get_online(memcg);
> +	nr_entries = folio_nr_pages(folio);
> +	/* Get references for the tail pages, too */
> +	if (nr_entries > 1)
> +		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
> +	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
> +
> +	swap_cgroup_record(folio, entry);
> +
> +	folio_unqueue_deferred_split(folio);
> +	folio->memcg_data = 0;
> +
> +	if (!mem_cgroup_is_root(memcg))
> +		page_counter_uncharge(&memcg->memory, nr_entries);
> +
> +	if (memcg != swap_memcg) {
> +		if (!mem_cgroup_is_root(swap_memcg))
> +			page_counter_charge(&swap_memcg->memsw, nr_entries);
> +		page_counter_uncharge(&memcg->memsw, nr_entries);
> +	}
> +
>  	/*
>  	 * Interrupts should be disabled here because the caller holds the
>  	 * i_pages lock which is taken with interrupts-off. It is
> @@ -594,6 +645,42 @@ void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg)
>  	memcg1_charge_statistics(memcg, -folio_nr_pages(folio));
>  	preempt_enable_nested();
>  	memcg1_check_events(memcg, folio_nid(folio));
> +
> +	css_put(&memcg->css);
> +}
> +
> +/*
> + * memcg1_swapin - uncharge swap slot
> + * @entry: the first swap entry for which the pages are charged
> + * @nr_pages: number of pages which will be uncharged
> + *
> + * Call this function after successfully adding the charged page to swapcache.
> + *
> + * Note: This function assumes the page for which swap slot is being uncharged
> + * is order 0 page.
> + */
> +void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
> +{
> +	/*
> +	 * Cgroup1's unified memory+swap counter has been charged with the
> +	 * new swapcache page, finish the transfer by uncharging the swap
> +	 * slot. The swap slot would also get uncharged when it dies, but
> +	 * it can stick around indefinitely and we'd count the page twice
> +	 * the entire time.
> +	 *
> +	 * Cgroup2 has separate resource counters for memory and swap,
> +	 * so this is a non-issue here. Memory and swap charge lifetimes
> +	 * correspond 1:1 to page and swap slot lifetimes: we charge the
> +	 * page to memory here, and uncharge swap when the slot is freed.
> +	 */
> +	if (do_memsw_account()) {
> +		/*
> +		 * The swap entry might not get freed for a long time,
> +		 * let's not wait for it.  The page already received a
> +		 * memory+swap charge, drop the swap entry duplicate.
> +		 */
> +		mem_cgroup_uncharge_swap(entry, nr_pages);
> +	}
>  }
>  
>  void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 4c8f36430fe9..1dc759e65471 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -39,6 +39,9 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
>  
> +void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
> +struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
> +
>  /* Cgroup v1-specific declarations */
>  #ifdef CONFIG_MEMCG_V1
>  
> @@ -69,7 +72,6 @@ void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
>  void memcg1_oom_recover(struct mem_cgroup *memcg);
>  
>  void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
> -void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg);
>  void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
>  			   unsigned long nr_memory, int nid);
>  
> @@ -107,8 +109,6 @@ static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
>  static inline void memcg1_commit_charge(struct folio *folio,
>  					struct mem_cgroup *memcg) {}
>  
> -static inline void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg) {}
> -
>  static inline void memcg1_uncharge_batch(struct mem_cgroup *memcg,
>  					 unsigned long pgpgout,
>  					 unsigned long nr_memory, int nid) {}
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 818143b81760..a95cb3fbb2c8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3377,7 +3377,7 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
> +void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
>  					   unsigned int n)
>  {
>  	refcount_add(n, &memcg->id.ref);
> @@ -3398,6 +3398,24 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
>  	mem_cgroup_id_put_many(memcg, 1);
>  }
>  
> +struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
> +{
> +	while (!refcount_inc_not_zero(&memcg->id.ref)) {
> +		/*
> +		 * The root cgroup cannot be destroyed, so it's refcount must
> +		 * always be >= 1.
> +		 */
> +		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
> +			VM_BUG_ON(1);
> +			break;
> +		}
> +		memcg = parent_mem_cgroup(memcg);
> +		if (!memcg)
> +			memcg = root_mem_cgroup;
> +	}
> +	return memcg;
> +}
> +
>  /**
>   * mem_cgroup_from_id - look up a memcg from a memcg id
>   * @id: the memcg id to look up
> @@ -4585,40 +4603,6 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  	return ret;
>  }
>  
> -/*
> - * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
> - * @entry: the first swap entry for which the pages are charged
> - * @nr_pages: number of pages which will be uncharged
> - *
> - * Call this function after successfully adding the charged page to swapcache.
> - *
> - * Note: This function assumes the page for which swap slot is being uncharged
> - * is order 0 page.
> - */
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> -{
> -	/*
> -	 * Cgroup1's unified memory+swap counter has been charged with the
> -	 * new swapcache page, finish the transfer by uncharging the swap
> -	 * slot. The swap slot would also get uncharged when it dies, but
> -	 * it can stick around indefinitely and we'd count the page twice
> -	 * the entire time.
> -	 *
> -	 * Cgroup2 has separate resource counters for memory and swap,
> -	 * so this is a non-issue here. Memory and swap charge lifetimes
> -	 * correspond 1:1 to page and swap slot lifetimes: we charge the
> -	 * page to memory here, and uncharge swap when the slot is freed.
> -	 */
> -	if (do_memsw_account()) {
> -		/*
> -		 * The swap entry might not get freed for a long time,
> -		 * let's not wait for it.  The page already received a
> -		 * memory+swap charge, drop the swap entry duplicate.
> -		 */
> -		mem_cgroup_uncharge_swap(entry, nr_pages);
> -	}
> -}
> -
>  struct uncharge_gather {
>  	struct mem_cgroup *memcg;
>  	unsigned long nr_memory;
> @@ -4944,81 +4928,6 @@ static int __init mem_cgroup_init(void)
>  subsys_initcall(mem_cgroup_init);
>  
>  #ifdef CONFIG_SWAP
> -static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
> -{
> -	while (!refcount_inc_not_zero(&memcg->id.ref)) {
> -		/*
> -		 * The root cgroup cannot be destroyed, so it's refcount must
> -		 * always be >= 1.
> -		 */
> -		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
> -			VM_BUG_ON(1);
> -			break;
> -		}
> -		memcg = parent_mem_cgroup(memcg);
> -		if (!memcg)
> -			memcg = root_mem_cgroup;
> -	}
> -	return memcg;
> -}
> -
> -/**
> - * mem_cgroup_swapout - transfer a memsw charge to swap
> - * @folio: folio whose memsw charge to transfer
> - * @entry: swap entry to move the charge to
> - *
> - * Transfer the memsw charge of @folio to @entry.
> - */
> -void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
> -{
> -	struct mem_cgroup *memcg, *swap_memcg;
> -	unsigned int nr_entries;
> -
> -	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> -	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
> -
> -	if (mem_cgroup_disabled())
> -		return;
> -
> -	if (!do_memsw_account())
> -		return;
> -
> -	memcg = folio_memcg(folio);
> -
> -	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
> -	if (!memcg)
> -		return;
> -
> -	/*
> -	 * In case the memcg owning these pages has been offlined and doesn't
> -	 * have an ID allocated to it anymore, charge the closest online
> -	 * ancestor for the swap instead and transfer the memory+swap charge.
> -	 */
> -	swap_memcg = mem_cgroup_id_get_online(memcg);
> -	nr_entries = folio_nr_pages(folio);
> -	/* Get references for the tail pages, too */
> -	if (nr_entries > 1)
> -		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
> -	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
> -
> -	swap_cgroup_record(folio, entry);
> -
> -	folio_unqueue_deferred_split(folio);
> -	folio->memcg_data = 0;
> -
> -	if (!mem_cgroup_is_root(memcg))
> -		page_counter_uncharge(&memcg->memory, nr_entries);
> -
> -	if (memcg != swap_memcg) {
> -		if (!mem_cgroup_is_root(swap_memcg))
> -			page_counter_charge(&swap_memcg->memsw, nr_entries);
> -		page_counter_uncharge(&memcg->memsw, nr_entries);
> -	}
> -
> -	memcg1_swapout(folio, memcg);
> -	css_put(&memcg->css);
> -}
> -
>  /**
>   * __mem_cgroup_try_charge_swap - try charging swap space for a folio
>   * @folio: folio being added to swap
> diff --git a/mm/memory.c b/mm/memory.c
> index 2a20e3810534..708ae27673b1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4393,7 +4393,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				}
>  				need_clear_cache = true;
>  
> -				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
> +				memcg1_swapin(entry, nr_pages);
>  
>  				shadow = get_shadow_from_swap_cache(entry);
>  				if (shadow)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 44379bee5b96..d885ecb6fe1e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2017,7 +2017,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>  	__folio_set_swapbacked(new);
>  	new->swap = entry;
>  
> -	mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
> +	memcg1_swapin(entry, nr_pages);
>  	shadow = get_shadow_from_swap_cache(entry);
>  	if (shadow)
>  		workingset_refault(new, shadow);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ca42b2be64d9..2e1acb210e57 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -521,7 +521,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
>  		goto fail_unlock;
>  
> -	mem_cgroup_swapin_uncharge_swap(entry, 1);
> +	memcg1_swapin(entry, 1);
>  
>  	if (shadow)
>  		workingset_refault(new_folio, shadow);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3bbe917b6a34..b2b2f27b10a0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -769,7 +769,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
>  		if (reclaimed && !mapping_exiting(mapping))
>  			shadow = workingset_eviction(folio, target_memcg);
>  		__delete_from_swap_cache(folio, swap, shadow);
> -		mem_cgroup_swapout(folio, swap);
> +		memcg1_swapout(folio, swap);
>  		xa_unlock_irq(&mapping->i_pages);
>  		put_swap_folio(folio, swap);
>  	} else {
> -- 
> 2.48.1

-- 
Michal Hocko
SUSE Labs

