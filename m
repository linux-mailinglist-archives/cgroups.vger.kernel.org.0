Return-Path: <cgroups+bounces-5135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B36C99FADA
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 00:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C20BB22F8A
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0521B0F25;
	Tue, 15 Oct 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hJXZ3al1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842421E3AC
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029912; cv=none; b=nCYpPMqAtRnMIroi4urBLKHSYM6ogDACZGr43e1ZiYz8/ze77hWV3pdKvj2jGGGIBn1BgW0XjWnmK4etDs3mdYXegf4ja49GqDOns9jOzgKeAwFCjeLJzV0CuwA269IRwD0OIhUOJl8VsVAslq9jkRZtNod5xSE28UN1ETS9NFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029912; c=relaxed/simple;
	bh=kABesOHCPWJZ772ylWDu8aelgeOlKu0N1IbhRg9D7nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8aJQKjPb2Z7lXFIa2GTAvxurieP8YSZ8rd8rJtIPeErb5kGDocGOic+vqhrVXwQ2phljeZCbkODOokn7dj7t34rATbVJpvQSHVZ/a/aYKxSRjr4ZzeLpvj68TtSwvbKH3fBJMom1//T5/2t09XhNnzdzuilvgFeLdj9NOJELUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hJXZ3al1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1418058bbso43039685a.3
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729029909; x=1729634709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8Rt/0coizWMv9U5TGodcqB/h7Nys+aGGva5yFYMtmQ=;
        b=hJXZ3al1lGMoOpHCxC2+VjYmp9w0NKnCAGq+V/nQhm0dLp342W/wS1C7ALTOF3uT8Y
         ajREqsdeIF6yqzJkMMfF5Pe+ZYEZT+VpFzdBW23DecBK0G0h5egsYQz3JGaTzmIHKc0j
         /kMw+dLYbyWylCXtUh0x1df1EljUfSUaNMBlCGzOh7+Vf042gS1ndrUmUDdo//CkA2+a
         relUwLfJKofaABD+SCAn//Z0afFlg8crOCyjASeQmmzZMCThMemcV781u/VuDaoVPKvg
         qI1dWyx0ewf9/YxPYPNxxhdLG42KemMRvnnZ8rNtzn4PtUJRsElywRjLVvVr82MAMHU+
         bM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029909; x=1729634709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8Rt/0coizWMv9U5TGodcqB/h7Nys+aGGva5yFYMtmQ=;
        b=AE4IUUeW/P2gNeQ5x3SGvTBottGkBkEzUUM+pIQUfrgUcZmlV57q5iVSP1mkTW4RTw
         CI6TgcIFQn1Zi+KAPDsQgD7oVcvcuXisIJ873QcZdgTT69jwrdKkNMtCCp0jxLic0mlz
         RLmxtwbjxyv1BVkTaXcF31RUGICR4ouxw+EBpnXBSgkLTIJudtpGHHdQodNtV/ct+g9T
         hEXYN0+SefQwooUvN1at3F9ChktnO9KkgsyI5Elakcw0DC2wrzM4iRJtxCQdHWIEXOXn
         wPo5kwAZbD3I1qzEXc5nCQnOWdS3DeSRYOPnY5V70i+nv0altVi74n7UsG3b7KGKWYUI
         im3A==
X-Forwarded-Encrypted: i=1; AJvYcCUwQQ6WF3UW+yAgxgYBzGHPVAWbX99p/8DbjhXjZWb0na0VBL+oo8INYEMkUanpnD0rIxX9idAb@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCW0YIbcFtrHKluzuUuDWKLbda8AlFh0gG4b9IjZg/PXJOLNz
	Ww4njvBX1Li7teuw+6SYy5hNMfut11+h7aMqfrgSQi6Q2mQDM6K3QIQR8SLs9fc=
X-Google-Smtp-Source: AGHT+IF7y+SU8F9fXe7eZrdrUqAogLSCuK4mjnKbn6YFxxFG/WWUEgbUDYBp/aKJyHa6BF/nW/NUHg==
X-Received: by 2002:a05:620a:191f:b0:7a9:d0ec:2d9d with SMTP id af79cd13be357-7b120fb799amr2441036385a.15.1729029908562;
        Tue, 15 Oct 2024 15:05:08 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616e92esm115532285a.41.2024.10.15.15.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 15:05:08 -0700 (PDT)
Date: Tue, 15 Oct 2024 18:05:05 -0400
From: Gregory Price <gourry@gourry.net>
To: kaiyang2@cs.cmu.edu
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, mhocko@kernel.org, nehagholkar@meta.com,
	abhishekd@meta.com, hannes@cmpxchg.org, weixugc@google.com,
	rientjes@google.com
Subject: Re: [RFC PATCH 2/4] calculate memory.low for the local node and
 track its usage
Message-ID: <Zw7nEfmkm36JZaae@PC2K9PVX.TheFacebook.com>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
 <20240920221202.1734227-3-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920221202.1734227-3-kaiyang2@cs.cmu.edu>

On Fri, Sep 20, 2024 at 10:11:49PM +0000, kaiyang2@cs.cmu.edu wrote:
> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> 
> Add a memory.low for the top-tier node (locallow) and track its usage.
> locallow is set by scaling low by the ratio of node 0 capacity and
> node 0 + node 1 capacity.
> 
> Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> ---
>  include/linux/page_counter.h | 16 ++++++++---
>  mm/hugetlb_cgroup.c          |  4 +--
>  mm/memcontrol.c              | 42 ++++++++++++++++++++++-------
>  mm/page_counter.c            | 52 ++++++++++++++++++++++++++++--------
>  4 files changed, 88 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 79dbd8bc35a7..aa56c93415ef 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -13,6 +13,7 @@ struct page_counter {
>  	 * memcg->memory.usage is a hot member of struct mem_cgroup.
>  	 */
>  	atomic_long_t usage;
> +	struct mem_cgroup *memcg; /* memcg that owns this counter */

Can you make some comments on the lifetime of this new memcg reference?

How is it referenced, how is it cleaned up, etc.

Probably it's worth added this in a separate patch so it's easier
to review the reference tracking.

>  	CACHELINE_PADDING(_pad1_);
>  
>  	/* effective memory.min and memory.min usage tracking */
> @@ -25,6 +26,10 @@ struct page_counter {
>  	atomic_long_t low_usage;
>  	atomic_long_t children_low_usage;
>  
> +	unsigned long elocallow;
> +	atomic_long_t locallow_usage;

per note on other email - probably want local_low_* instead of locallow.

> +	atomic_long_t children_locallow_usage;
> +
>  	unsigned long watermark;
>  	/* Latest cg2 reset watermark */
>  	unsigned long local_watermark;
> @@ -36,6 +41,7 @@ struct page_counter {
>  	bool protection_support;
>  	unsigned long min;
>  	unsigned long low;
> +	unsigned long locallow;
>  	unsigned long high;
>  	unsigned long max;
>  	struct page_counter *parent;
> @@ -52,12 +58,13 @@ struct page_counter {
>   */
>  static inline void page_counter_init(struct page_counter *counter,
>  				     struct page_counter *parent,
> -				     bool protection_support)
> +				     bool protection_support, struct mem_cgroup *memcg)
>  {
>  	counter->usage = (atomic_long_t)ATOMIC_LONG_INIT(0);
>  	counter->max = PAGE_COUNTER_MAX;
>  	counter->parent = parent;
>  	counter->protection_support = protection_support;
> +	counter->memcg = memcg;
>  }
>  
>  static inline unsigned long page_counter_read(struct page_counter *counter)
> @@ -72,7 +79,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>  			     struct page_counter **fail);
>  void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
>  void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
> -void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
> +void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages,
> +					unsigned long nr_pages_local);
>  
>  static inline void page_counter_set_high(struct page_counter *counter,
>  					 unsigned long nr_pages)
> @@ -99,11 +107,11 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
>  #ifdef CONFIG_MEMCG
>  void page_counter_calculate_protection(struct page_counter *root,
>  				       struct page_counter *counter,
> -				       bool recursive_protection);
> +				       bool recursive_protection, int is_local);

`bool is_local` is preferred

>  #else
>  static inline void page_counter_calculate_protection(struct page_counter *root,
>  						     struct page_counter *counter,
> -						     bool recursive_protection) {}
> +						     bool recursive_protection, int is_local) {}
>  #endif
>  
>  #endif /* _LINUX_PAGE_COUNTER_H */
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index d8d0e665caed..0e07a7a1d5b8 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -114,10 +114,10 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>  		}
>  		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
>  								     idx),
> -				  fault_parent, false);
> +				  fault_parent, false, NULL);
>  		page_counter_init(
>  			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
> -			rsvd_parent, false);
> +			rsvd_parent, false, NULL);
>  
>  		limit = round_down(PAGE_COUNTER_MAX,
>  				   pages_per_huge_page(&hstates[idx]));
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 20b715441332..d7c5fff12105 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1497,6 +1497,9 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  			       vm_event_name(memcg_vm_event_stat[i]),
>  			       memcg_events(memcg, memcg_vm_event_stat[i]));
>  	}
> +
> +	seq_buf_printf(s, "local_usage %lu\n",
> +		       get_cgroup_local_usage(memcg, true));
>  }
>  
>  static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> @@ -3597,8 +3600,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	if (parent) {
>  		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
>  
> -		page_counter_init(&memcg->memory, &parent->memory, true);
> -		page_counter_init(&memcg->swap, &parent->swap, false);
> +		page_counter_init(&memcg->memory, &parent->memory, true, memcg);
> +		page_counter_init(&memcg->swap, &parent->swap, false, NULL);
>  #ifdef CONFIG_MEMCG_V1
>  		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
>  		page_counter_init(&memcg->kmem, &parent->kmem, false);
> @@ -3607,8 +3610,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	} else {
>  		init_memcg_stats();
>  		init_memcg_events();
> -		page_counter_init(&memcg->memory, NULL, true);
> -		page_counter_init(&memcg->swap, NULL, false);
> +		page_counter_init(&memcg->memory, NULL, true, memcg);
> +		page_counter_init(&memcg->swap, NULL, false, NULL);
>  #ifdef CONFIG_MEMCG_V1
>  		page_counter_init(&memcg->kmem, NULL, false);
>  		page_counter_init(&memcg->tcpmem, NULL, false);
> @@ -3677,7 +3680,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	memcg1_css_offline(memcg);
>  
>  	page_counter_set_min(&memcg->memory, 0);
> -	page_counter_set_low(&memcg->memory, 0);
> +	page_counter_set_low(&memcg->memory, 0, 0);
>  
>  	zswap_memcg_offline_cleanup(memcg);
>  
> @@ -3748,7 +3751,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
>  #endif
>  	page_counter_set_min(&memcg->memory, 0);
> -	page_counter_set_low(&memcg->memory, 0);
> +	page_counter_set_low(&memcg->memory, 0, 0);
>  	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
>  	memcg1_soft_limit_reset(memcg);
>  	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> @@ -4051,6 +4054,12 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static int memory_locallow_show(struct seq_file *m, void *v)
> +{
> +	return seq_puts_memcg_tunable(m,
> +		READ_ONCE(mem_cgroup_from_seq(m)->memory.locallow));
> +}
> +
>  static int memory_low_show(struct seq_file *m, void *v)
>  {
>  	return seq_puts_memcg_tunable(m,
> @@ -4061,7 +4070,8 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
>  				char *buf, size_t nbytes, loff_t off)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> -	unsigned long low;
> +	struct sysinfo si;
> +	unsigned long low, locallow, local_capacity, total_capacity;
>  	int err;
>  
>  	buf = strstrip(buf);
> @@ -4069,7 +4079,15 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
>  	if (err)
>  		return err;
>  
> -	page_counter_set_low(&memcg->memory, low);
> +	/* Hardcoded 0 for local node and 1 for remote. */

I know we've talked about this before about this, but this is obviously broken
for multi-socket systems.  If so, this needs a FIXME or a TODO at least so that
it's at least obvious that this patch isn't ready for upstream - even as an RFC.

Probably we can't move forward until we figure out how to solve this problem
out ahead of this patch set.  Worth discussing this issue explicitly.

Maybe rather than guessing, a preferred node should be set for local and
remote if this mechanism is in use.  Otherwise just guessing which local
and which remote node seems like it will be wrong - especially for sufficiently
large-threaded processes.

> +	si_meminfo_node(&si, 0);
> +	local_capacity = si.totalram; /* In pages. */
> +	total_capacity = local_capacity;
> +	si_meminfo_node(&si, 1);
> +	total_capacity += si.totalram;
> +	locallow = low * local_capacity / total_capacity;
> +
> +	page_counter_set_low(&memcg->memory, low, locallow);
>  
>  	return nbytes;
>  }
> @@ -4394,6 +4412,11 @@ static struct cftype memory_files[] = {
>  		.seq_show = memory_low_show,
>  		.write = memory_low_write,
>  	},
> +	{
> +		.name = "locallow",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = memory_locallow_show,
> +	},
>  	{
>  		.name = "high",
>  		.flags = CFTYPE_NOT_ON_ROOT,
> @@ -4483,7 +4506,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  	if (!root)
>  		root = root_mem_cgroup;
>  
> -	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
> +	page_counter_calculate_protection(&root->memory, &memcg->memory,
> +					recursive_protection, false);
>  }
>  
>  static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index b249d15af9dd..97205aafab46 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -18,8 +18,10 @@ static bool track_protection(struct page_counter *c)
>  	return c->protection_support;
>  }
>  
> +extern unsigned long get_cgroup_local_usage(struct mem_cgroup *memcg, bool flush);
> +
>  static void propagate_protected_usage(struct page_counter *c,
> -				      unsigned long usage)
> +				      unsigned long usage, unsigned long local_usage)
>  {
>  	unsigned long protected, old_protected;
>  	long delta;
> @@ -44,6 +46,15 @@ static void propagate_protected_usage(struct page_counter *c,
>  		if (delta)
>  			atomic_long_add(delta, &c->parent->children_low_usage);
>  	}
> +
> +	protected = min(local_usage, READ_ONCE(c->locallow));
> +	old_protected = atomic_long_read(&c->locallow_usage);
> +	if (protected != old_protected) {
> +		old_protected = atomic_long_xchg(&c->locallow_usage, protected);
> +		delta = protected - old_protected;
> +		if (delta)
> +			atomic_long_add(delta, &c->parent->children_locallow_usage);
> +	}
>  }
>  
>  /**
> @@ -63,7 +74,8 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
>  		atomic_long_set(&counter->usage, new);
>  	}
>  	if (track_protection(counter))
> -		propagate_protected_usage(counter, new);
> +		propagate_protected_usage(counter, new,
> +				get_cgroup_local_usage(counter->memcg, false));
>  }
>  
>  /**
> @@ -83,7 +95,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  
>  		new = atomic_long_add_return(nr_pages, &c->usage);
>  		if (protection)
> -			propagate_protected_usage(c, new);
> +			propagate_protected_usage(c, new,
> +					get_cgroup_local_usage(counter->memcg, false));
>  		/*
>  		 * This is indeed racy, but we can live with some
>  		 * inaccuracy in the watermark.
> @@ -151,7 +164,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>  			goto failed;
>  		}
>  		if (protection)
> -			propagate_protected_usage(c, new);
> +			propagate_protected_usage(c, new,
> +					get_cgroup_local_usage(counter->memcg, false));
>  
>  		/* see comment on page_counter_charge */
>  		if (new > READ_ONCE(c->local_watermark)) {
> @@ -238,7 +252,8 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
>  	WRITE_ONCE(counter->min, nr_pages);
>  
>  	for (c = counter; c; c = c->parent)
> -		propagate_protected_usage(c, atomic_long_read(&c->usage));
> +		propagate_protected_usage(c, atomic_long_read(&c->usage),
> +				get_cgroup_local_usage(counter->memcg, false));
>  }
>  
>  /**
> @@ -248,14 +263,17 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
>   *
>   * The caller must serialize invocations on the same counter.
>   */
> -void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
> +void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages,
> +				unsigned long nr_pages_local)
>  {
>  	struct page_counter *c;
>  
>  	WRITE_ONCE(counter->low, nr_pages);
> +	WRITE_ONCE(counter->locallow, nr_pages_local);
>  
>  	for (c = counter; c; c = c->parent)
> -		propagate_protected_usage(c, atomic_long_read(&c->usage));
> +		propagate_protected_usage(c, atomic_long_read(&c->usage),
> +				get_cgroup_local_usage(counter->memcg, false));
>  }
>  
>  /**
> @@ -421,9 +439,9 @@ static unsigned long effective_protection(unsigned long usage,
>   */
>  void page_counter_calculate_protection(struct page_counter *root,
>  				       struct page_counter *counter,
> -				       bool recursive_protection)
> +				       bool recursive_protection, int is_local)
>  {
> -	unsigned long usage, parent_usage;
> +	unsigned long usage, parent_usage, local_usage, parent_local_usage;
>  	struct page_counter *parent = counter->parent;
>  
>  	/*
> @@ -437,16 +455,19 @@ void page_counter_calculate_protection(struct page_counter *root,
>  		return;
>  
>  	usage = page_counter_read(counter);
> -	if (!usage)
> +	local_usage = get_cgroup_local_usage(counter->memcg, true);
> +	if (!usage || !local_usage)
>  		return;
>  
>  	if (parent == root) {
>  		counter->emin = READ_ONCE(counter->min);
>  		counter->elow = READ_ONCE(counter->low);
> +		counter->elocallow = READ_ONCE(counter->locallow);
>  		return;
>  	}
>  
>  	parent_usage = page_counter_read(parent);
> +	parent_local_usage = get_cgroup_local_usage(parent->memcg, true);
>  
>  	WRITE_ONCE(counter->emin, effective_protection(usage, parent_usage,
>  			READ_ONCE(counter->min),
> @@ -454,7 +475,16 @@ void page_counter_calculate_protection(struct page_counter *root,
>  			atomic_long_read(&parent->children_min_usage),
>  			recursive_protection));
>  
> -	WRITE_ONCE(counter->elow, effective_protection(usage, parent_usage,
> +	if (is_local)
> +		WRITE_ONCE(counter->elocallow,
> +			effective_protection(local_usage, parent_local_usage,
> +			READ_ONCE(counter->locallow),
> +			READ_ONCE(parent->elocallow),
> +			atomic_long_read(&parent->children_locallow_usage),
> +			recursive_protection));
> +	else
> +		WRITE_ONCE(counter->elow,
> +			effective_protection(usage, parent_usage,
>  			READ_ONCE(counter->low),
>  			READ_ONCE(parent->elow),
>  			atomic_long_read(&parent->children_low_usage),
> -- 
> 2.43.0
> 

