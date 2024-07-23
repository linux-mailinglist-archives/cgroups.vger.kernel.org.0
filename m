Return-Path: <cgroups+bounces-3864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161693A6E2
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EB4282CE1
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC4158873;
	Tue, 23 Jul 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lf69A3py"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89313D600
	for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759985; cv=none; b=hb+NnwFx8i42EfuLWrZFhSoeF8+TfIWcOldw2qbUfQou1ZWXEVB/4Rl18ds72eP9saeFhCVPmq7n1n8+YWA3L4Hlrjzul4Uug0YEvpPYK/4+94VkDwiIY5d7S8rP67sjMiF5Ez5gy0FytKbEJLlRG7HQ8uRfSoLf9aI4vJG0x9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759985; c=relaxed/simple;
	bh=npOXAJAXWdonyqNOK+IhpoN3O1dHycSFUkOtHGv9yhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3L7HleEwaeM+9bNHxKF19z8CGl41JqG8QFEktVGicy2UKjJfraeTU1YpujZ772hKcSZ91huSGU1F3Fi5EOxNzuAB3eqF9473lgvbAJkVA8Vo8UyUtKD4mScF3/9Hv0iEcohnM1TOVmWOINBB0nW8DJ/O0wBdXbWArWaB03/gJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lf69A3py; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Jul 2024 11:39:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721759981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5VmKZyH3j0WUjWPZGHhKWDE4amCUXUtXuqAGRmce9Q=;
	b=Lf69A3pyC9Cl+9XC0Cm/jXZKXUMDzQlH6WeHZLuZWXjQO0gxunzf8a7sFijcJ3oRHe037C
	s4daK/hPZ8xnvgv1Jt5yLH1T0EUyuG8MOox2KCMaDExg0PZsu9DLz0pvWKwXs0VzQ58Dyp
	sqApIQ2S8IAn3CGyRAf7/PICmZSbyTo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Message-ID: <i2oflmxuymmqrn37l5uxadibfrfapr3rf5vwzbvrsfenc6fdjy@xqk2ttcxtswi>
References: <20240722070810.46016-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722070810.46016-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 22, 2024 at 03:08:10PM GMT, Muchun Song wrote:
> The obj_cgroup_memcg() is supposed to safe to prevent the returned
> memory cgroup from being freed only when the caller is holding the
> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> ignore thoes conditions when users call some upper APIs which call
> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> the link below). So it is better to add lockdep assertion to
> obj_cgroup_memcg() to find those issues ASAP.
> 
> Because there is no user of obj_cgroup_memcg() holding objcg_lock
> to make the returned memory cgroup safe, do not add objcg_lock
> assertion (We should export objcg_lock if we really want to do)
> and leave a comment to indicate it is intentional.
> 

Do we expect non-memcg code to access objcg_lock? To me this is some
internal implementation detail of memcg and should not be accessible
outside memcg code. So, I would recommend to not mention objcg_lock at
all.

> Some users like __mem_cgroup_uncharge() do not care the lifetime
> of the returned memory cgroup, which just want to know if the
> folio is charged to a memory cgroup, therefore, they do not need
> to hold the needed locks. In which case, introduce a new helper
> folio_memcg_charged() to do this. Compare it to folio_memcg(), it
> could eliminate a memory access of objcg->memcg for kmem, actually,
> a really small gain.
> 
> Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 22 +++++++++++++++++++---
>  mm/memcontrol.c            |  6 +++---
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fc94879db4dff..d616c50025098 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -360,11 +360,13 @@ static inline bool folio_memcg_kmem(struct folio *folio);
>   * After the initialization objcg->memcg is always pointing at
>   * a valid memcg, but can be atomically swapped to the parent memcg.
>   *
> - * The caller must ensure that the returned memcg won't be released:
> - * e.g. acquire the rcu_read_lock or css_set_lock.
> + * The caller must ensure that the returned memcg won't be released.
>   */
>  static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
>  {
> +	WARN_ON_ONCE(!rcu_read_lock_held() &&
> +		  /* !lockdep_is_held(&objcg_lock) && */

> +		     !lockdep_is_held(&cgroup_mutex));
>  	return READ_ONCE(objcg->memcg);
>  }
>  
> @@ -438,6 +440,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>  	return __folio_memcg(folio);
>  }
>  
> +/*
> + * folio_memcg_charged - If a folio is charged to a memory cgroup.
> + * @folio: Pointer to the folio.
> + *
> + * Returns true if folio is charged to a memory cgroup, otherwise returns false.
> + */
> +static inline bool folio_memcg_charged(struct folio *folio)
> +{
> +	if (folio_memcg_kmem(folio))
> +		return __folio_objcg(folio) != NULL;
> +	return __folio_memcg(folio) != NULL;
> +}
> +
>  /**
>   * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
>   * @folio: Pointer to the folio.
> @@ -454,7 +469,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>  	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
>  
>  	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
> -	WARN_ON_ONCE(!rcu_read_lock_held());
>  
>  	if (memcg_data & MEMCG_DATA_KMEM) {
>  		struct obj_cgroup *objcg;
> @@ -463,6 +477,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>  		return obj_cgroup_memcg(objcg);
>  	}
>  
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
>  	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 622d4544edd24..3da0284573857 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  
>  static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
> -	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
>  	/*
>  	 * Any of the following ensures page's memcg stability:
>  	 *
> @@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>  	struct uncharge_gather ug;
>  
>  	/* Don't touch folio->lru of any random page, pre-check: */
> -	if (!folio_memcg(folio))
> +	if (!folio_memcg_charged(folio))
>  		return;
>  
>  	uncharge_gather_clear(&ug);
> @@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>  		return;
>  
>  	/* Page cache replacement: new folio already charged? */
> -	if (folio_memcg(new))
> +	if (folio_memcg_charged(new))
>  		return;
>  
>  	memcg = folio_memcg(old);
> -- 
> 2.20.1
> 

