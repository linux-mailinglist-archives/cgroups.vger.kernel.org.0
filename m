Return-Path: <cgroups+bounces-3352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0C915FB1
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3301F1C2133F
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DD1474D0;
	Tue, 25 Jun 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BHa5XWqx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BA146A98
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299390; cv=none; b=uOj1lg2A8x2FwKTe1w3SigyYcevxr1OEsa8fo3gkZAh+SDpLFGTy3iKm0I9SJhnfCjekdmio6/QCTpk+NWAnjajXCGmlRYJ2YwQMfJcrm4LgB1KvbNM1dtnrtExGEooH2Ibcq9NhIhSuPbcugf6AE5xOTt5EfAuq6EmedUMulGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299390; c=relaxed/simple;
	bh=UuLcvxgoIYLRXngvi4eCo4dHC1Q9ihdImY3qLsdIDn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRqlYFVwqKHxDazyTBO5I4G5yZP05v7SpsnTC5M2fK++x535pJv3nqrp0NL0ZkI5nH6cYa/aLYrhexHjajRfhxkunDHRXwBdEvLBDjjxhGQqryloZm23dt07eufPLsTg8wjvX8ReTIkIrbetdEy+gjOa+Dn2tAhIKOYInpFnfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BHa5XWqx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6cb130027aso333438066b.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299387; x=1719904187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FlVF62jftBeeziv2TfJtX0hEZ+vRuIG/5jJSL5Ty+Q=;
        b=BHa5XWqxBbtKGtOd1avrZmEOnijLeUP3R/5qU0/LU1smT1CHAHCfq817i+Xoz0t6fc
         xlNmTXDp5sARum1/tohsQKkL2woXM4NHHiIZ1zwHMZsVagvPoFioWwPPmrQEF8P0hRe7
         QKNtJ8ef9q8D1QhaV7dQNfDY1FrAkLhdwYfjIjlUiI1QSTCTprgZlZA5xWDzroyXRXXo
         NJILFAARVJHU6VguUzni40EUs/WrhoTv8KLTU3PpCIhLuzsSptkZWQSxILDonekvvVId
         1+8vk9hR4ppVZVP4891yEE1Pl3zCYTwZ6hvo6Jj3r68o3uEqWAVG9ANAiZtJvGGT/82+
         8CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299387; x=1719904187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FlVF62jftBeeziv2TfJtX0hEZ+vRuIG/5jJSL5Ty+Q=;
        b=Hvk9iGuYC6rIfPpbSVYR90J4gisqd9MN0EXBguKP0j7jgburow9rUTF41RwZ7IhYgP
         Q1XFRRYfF3fOK69iUyv0SiEZi8fvXi/cDGaVkC5Em5Qosn11LEufT7aRsfzej2cdMGBS
         tWPiH1yH4lan9QeDbdxlqKd3KktThGD3zZZ3ytnoBHjFiU6+RnMdw5xMhECRBEmOAgxQ
         0tz9p7g5JTAmwwjboI1WnbWxamrMbjliG2tSky9OjzzXnf5FwZIEZLwk6A67mtDBfy+6
         0Kg7WBaVIUvHzOe1upkCIrq5XHMoUdNkeh+th9heXhFqyqyDwl0bXEMS816yNzJs84SN
         +CTg==
X-Forwarded-Encrypted: i=1; AJvYcCWkiV4x5xh72LE1l4tX9S7+PDa1rAM3FSRz+A5Bu9pVng//9DDMukQC5ZP7v8lHiJSaumFXWIjZltaugya1FxRw0+x+jg0drA==
X-Gm-Message-State: AOJu0YwMKEpzSDm5Jq6gfCj/n0RJWgrddNsO9IvCdtK4EPLuQrfRVJPi
	pByaXA4zXdmO3P9TKTUiJWw1++Af8gwa/Zz3uh3EdvXBQVyHPr2vn08B/P2vdyw=
X-Google-Smtp-Source: AGHT+IEIkM0//edoDpFK3pOGjO68dBBhJP5wZHsA3ogZl2/GgQyjf5B/SU5xaIgIMm7M0tp3kPQyUQ==
X-Received: by 2002:a50:d5d3:0:b0:57c:7c44:74df with SMTP id 4fb4d7f45d1cf-57d4bdcabb7mr5520022a12.29.1719299386820;
        Tue, 25 Jun 2024 00:09:46 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5827db501d9sm45240a12.7.2024.06.25.00.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:09:46 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:09:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 12/14] mm: memcg: group cgroup v1 memcg related
 declarations
Message-ID: <ZnptOT1R3PC6vYYU@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-13-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-13-roman.gushchin@linux.dev>

On Mon 24-06-24 17:59:04, Roman Gushchin wrote:
> Group all cgroup v1-related declarations at the end of memcontrol.h
> and mm/memcontrol-v1.h with an intention to put them all together
> under a config option later on. It should make things easier to
> follow and maintain too.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 144 +++++++++++++++++++------------------
>  mm/memcontrol-v1.h         |  89 ++++++++++++-----------
>  2 files changed, 123 insertions(+), 110 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 588179d29849..a70d64ed04f5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -950,39 +950,13 @@ static inline void mem_cgroup_exit_user_fault(void)
>  	current->in_user_fault = 0;
>  }
>  
> -static inline bool task_in_memcg_oom(struct task_struct *p)
> -{
> -	return p->memcg_in_oom;
> -}
> -
> -bool mem_cgroup_oom_synchronize(bool wait);
>  struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  					    struct mem_cgroup *oom_domain);
>  void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>  
> -void folio_memcg_lock(struct folio *folio);
> -void folio_memcg_unlock(struct folio *folio);
> -
>  void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
>  		       int val);
>  
> -/* try to stablize folio_memcg() for all the pages in a memcg */
> -static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> -{
> -	rcu_read_lock();
> -
> -	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
> -		return true;
> -
> -	rcu_read_unlock();
> -	return false;
> -}
> -
> -static inline void mem_cgroup_unlock_pages(void)
> -{
> -	rcu_read_unlock();
> -}
> -
>  /* idx can be of type enum memcg_stat_item or node_stat_item */
>  static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  				   enum memcg_stat_item idx, int val)
> @@ -1109,10 +1083,6 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>  
> -unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -					gfp_t gfp_mask,
> -					unsigned long *total_scanned);
> -
>  #else /* CONFIG_MEMCG */
>  
>  #define MEM_CGROUP_ID_SHIFT	0
> @@ -1423,26 +1393,6 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
>  }
>  
> -static inline void folio_memcg_lock(struct folio *folio)
> -{
> -}
> -
> -static inline void folio_memcg_unlock(struct folio *folio)
> -{
> -}
> -
> -static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> -{
> -	/* to match folio_memcg_rcu() */
> -	rcu_read_lock();
> -	return true;
> -}
> -
> -static inline void mem_cgroup_unlock_pages(void)
> -{
> -	rcu_read_unlock();
> -}
> -
>  static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  {
>  }
> @@ -1455,16 +1405,6 @@ static inline void mem_cgroup_exit_user_fault(void)
>  {
>  }
>  
> -static inline bool task_in_memcg_oom(struct task_struct *p)
> -{
> -	return false;
> -}
> -
> -static inline bool mem_cgroup_oom_synchronize(bool wait)
> -{
> -	return false;
> -}
> -
>  static inline struct mem_cgroup *mem_cgroup_get_oom_group(
>  	struct task_struct *victim, struct mem_cgroup *oom_domain)
>  {
> @@ -1558,14 +1498,6 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  static inline void split_page_memcg(struct page *head, int old_order, int new_order)
>  {
>  }
> -
> -static inline
> -unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -					gfp_t gfp_mask,
> -					unsigned long *total_scanned)
> -{
> -	return 0;
> -}
>  #endif /* CONFIG_MEMCG */
>  
>  /*
> @@ -1916,4 +1848,80 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>  }
>  #endif
>  
> +
> +/* Cgroup v1-related declarations */
> +
> +#ifdef CONFIG_MEMCG
> +unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					gfp_t gfp_mask,
> +					unsigned long *total_scanned);
> +
> +bool mem_cgroup_oom_synchronize(bool wait);
> +
> +static inline bool task_in_memcg_oom(struct task_struct *p)
> +{
> +	return p->memcg_in_oom;
> +}
> +
> +void folio_memcg_lock(struct folio *folio);
> +void folio_memcg_unlock(struct folio *folio);
> +
> +/* try to stablize folio_memcg() for all the pages in a memcg */
> +static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> +{
> +	rcu_read_lock();
> +
> +	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
> +		return true;
> +
> +	rcu_read_unlock();
> +	return false;
> +}
> +
> +static inline void mem_cgroup_unlock_pages(void)
> +{
> +	rcu_read_unlock();
> +}
> +
> +#else /* CONFIG_MEMCG */
> +static inline
> +unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					gfp_t gfp_mask,
> +					unsigned long *total_scanned)
> +{
> +	return 0;
> +}
> +
> +static inline void folio_memcg_lock(struct folio *folio)
> +{
> +}
> +
> +static inline void folio_memcg_unlock(struct folio *folio)
> +{
> +}
> +
> +static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> +{
> +	/* to match folio_memcg_rcu() */
> +	rcu_read_lock();
> +	return true;
> +}
> +
> +static inline void mem_cgroup_unlock_pages(void)
> +{
> +	rcu_read_unlock();
> +}
> +
> +static inline bool task_in_memcg_oom(struct task_struct *p)
> +{
> +	return false;
> +}
> +
> +static inline bool mem_cgroup_oom_synchronize(bool wait)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_MEMCG */
> +
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 7d6ac4a4fb36..89d420793048 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -5,15 +5,9 @@
>  
>  #include <linux/cgroup-defs.h>
>  
> -void memcg1_remove_from_trees(struct mem_cgroup *memcg);
> -
> -static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
> -{
> -	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> -}
> +/* Cgroup v1 and v2 common declarations */
>  
>  void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
> -void memcg1_check_events(struct mem_cgroup *memcg, int nid);
>  int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		     unsigned int nr_pages);
>  
> @@ -29,30 +23,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
>  void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
>  
> -bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
> -struct cgroup_taskset;
> -int memcg1_can_attach(struct cgroup_taskset *tset);
> -void memcg1_cancel_attach(struct cgroup_taskset *tset);
> -void memcg1_move_task(void);
> -
> -/*
> - * Per memcg event counter is incremented at every pagein/pageout. With THP,
> - * it will be incremented by the number of pages. This counter is used
> - * to trigger some periodic events. This is straightforward and better
> - * than using jiffies etc. to handle periodic memcg event.
> - */
> -enum mem_cgroup_events_target {
> -	MEM_CGROUP_TARGET_THRESH,
> -	MEM_CGROUP_TARGET_SOFTLIMIT,
> -	MEM_CGROUP_NTARGETS,
> -};
> -
> -/* Whether legacy memory+swap accounting is active */
> -static bool do_memsw_account(void)
> -{
> -	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> -}
> -
>  /*
>   * Iteration constructs for visiting all cgroups (under a tree).  If
>   * loops are exited prematurely (break), mem_cgroup_iter_break() must
> @@ -68,24 +38,28 @@ static bool do_memsw_account(void)
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -void memcg1_css_offline(struct mem_cgroup *memcg);
> +/* Whether legacy memory+swap accounting is active */
> +static bool do_memsw_account(void)
> +{
> +	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> +}
>  
> -/* for encoding cft->private value on file */
> -enum res_type {
> -	_MEM,
> -	_MEMSWAP,
> -	_KMEM,
> -	_TCP,
> +/*
> + * Per memcg event counter is incremented at every pagein/pageout. With THP,
> + * it will be incremented by the number of pages. This counter is used
> + * to trigger some periodic events. This is straightforward and better
> + * than using jiffies etc. to handle periodic memcg event.
> + */
> +enum mem_cgroup_events_target {
> +	MEM_CGROUP_TARGET_THRESH,
> +	MEM_CGROUP_TARGET_SOFTLIMIT,
> +	MEM_CGROUP_NTARGETS,
>  };
>  
>  bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>  				enum mem_cgroup_events_target target);
>  unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  
> -bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
> -void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
> -void memcg1_oom_recover(struct mem_cgroup *memcg);
> -
>  void drain_all_stock(struct mem_cgroup *root_memcg);
>  unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
>  				      unsigned int lru_mask, bool tree);
> @@ -100,6 +74,37 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
>  
> +/* Cgroup v1-specific declarations */
> +
> +void memcg1_remove_from_trees(struct mem_cgroup *memcg);
> +
> +static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
> +{
> +	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> +}
> +
> +bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
> +
> +struct cgroup_taskset;
> +int memcg1_can_attach(struct cgroup_taskset *tset);
> +void memcg1_cancel_attach(struct cgroup_taskset *tset);
> +void memcg1_move_task(void);
> +void memcg1_css_offline(struct mem_cgroup *memcg);
> +
> +/* for encoding cft->private value on file */
> +enum res_type {
> +	_MEM,
> +	_MEMSWAP,
> +	_KMEM,
> +	_TCP,
> +};
> +
> +bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
> +void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
> +void memcg1_oom_recover(struct mem_cgroup *memcg);
> +
> +void memcg1_check_events(struct mem_cgroup *memcg, int nid);
> +
>  void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
>  
>  extern struct cftype memsw_files[];
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

