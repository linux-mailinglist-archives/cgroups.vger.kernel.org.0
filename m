Return-Path: <cgroups+bounces-3911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CFE93CF52
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 10:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A61C222FA
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6C176AB5;
	Fri, 26 Jul 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZqdhyYl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA925745E4;
	Fri, 26 Jul 2024 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981379; cv=none; b=CKlw+a3AjGu1X+K2P4n3teKV4F5n+JrijXtkI9m1RUKU6s/2X1qkM0YLjU2G+tui1mtIyvxbhrg/FtQLXc3v4kCJVYvAqghVpZSH4H9t+rFO+WwYTCrByatVM7MipiCkzG/O7CyIKbOd3F2w0683h+FDnP6rNnLeX4mGjF8O9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981379; c=relaxed/simple;
	bh=Zs672yaxzd0Uq4FobmiIgckn9CgVGQcY++GMEOQ5twQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvc47LQ+Cj8cdu1+tsfe7oxj4Cl304Cu0KTy2Go1LzK1R6KGFOjzhpJfZpXBhJ50K928LyeKIgn5dbxybSU4o4CSgwliNQdnXK8EXPiP/3jyGkiaDcJSG9XvaYWcs2TXTQdbNRZsliZpXjWgyeC5/HbQrvcdJaIh6Srwz5u7NDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZqdhyYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81299C32782;
	Fri, 26 Jul 2024 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721981378;
	bh=Zs672yaxzd0Uq4FobmiIgckn9CgVGQcY++GMEOQ5twQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uZqdhyYl1etnNDCMv+ojEUu/AP3TY0ch2kY/gAw9QJtuF5V/4yg4UUwGWWQ2vOGZr
	 WEo+MJ2BTXcdrcz6YZhU8t+NHkGCEB6ka8vvH6dlr/zGYOVfXP9vaKoH5u6Xg7RgOj
	 jjgHv5jkbtNybRXs1qHoY1oN1UmT0HhZ2GlZ9y56Yp0oX58ltNLkJK6xyLc4Aj03mn
	 DIAUO4WdQGHd8omj8GsZiYiS/iciOd76+edMCyUmsI2XEIZ46HRSlT6stpHiVyou7j
	 IEtzGqWpViVcV1m6oI9+h0ZrjM38kfKi1ZNbKKjvYIood4RqJiLERJk1v5HtFMMKq3
	 +imaony6tHIig==
Message-ID: <8b04dbe3-cbf1-4d97-ab42-ebaae5974b40@kernel.org>
Date: Fri, 26 Jul 2024 10:09:34 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Content-Language: en-US
To: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240725094330.72537-1-songmuchun@bytedance.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240725094330.72537-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/24 11:43 AM, Muchun Song wrote:
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
> assertion (We should export objcg_lock if we really want to do).
> Additionally, this is some internal implementation detail of memcg
> and should not be accessible outside memcg code.
> 
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> v3:
>  - Use lockdep_assert_once(Vlastimil).
> 
> v2:
>  - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
> 
>  include/linux/memcontrol.h | 20 +++++++++++++++++---
>  mm/memcontrol.c            |  6 +++---
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fc94879db4dff..95f823deafeca 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
>   * After the initialization objcg->memcg is always pointing at
>   * a valid memcg, but can be atomically swapped to the parent memcg.
>   *
> - * The caller must ensure that the returned memcg won't be released:
> - * e.g. acquire the rcu_read_lock or css_set_lock.
> + * The caller must ensure that the returned memcg won't be released.
>   */
>  static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
>  {
> +	lockdep_assert_once(rcu_read_lock_held() || lockdep_is_held(&cgroup_mutex));
>  	return READ_ONCE(objcg->memcg);
>  }
>  
> @@ -438,6 +438,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
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
> @@ -454,7 +467,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>  	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
>  
>  	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
> -	WARN_ON_ONCE(!rcu_read_lock_held());
>  
>  	if (memcg_data & MEMCG_DATA_KMEM) {
>  		struct obj_cgroup *objcg;
> @@ -463,6 +475,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
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


