Return-Path: <cgroups+bounces-3881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E293B37D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B40B21A4B
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19D15956C;
	Wed, 24 Jul 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foq0aGZe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B52D29E;
	Wed, 24 Jul 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834415; cv=none; b=D5r+uEcgeJSfpkuhf7r3StpWglny+Zpuz7aTdYJRSZuc6LmfhM0I/FZEeNJdaXKscIaOBAZbFgMeF2D5/JhW5ONaeIVL1+zkt3zlDzRfc4eDPomhPAs5hG0dgVGPqpnBgoCzUrhnvreTrZwEJB+v2jTecIOw4jaLKRPk7HuNnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834415; c=relaxed/simple;
	bh=qeXLUpoZGsZRPbAT3HnF46SuxY7YTRrZMXLruO62MZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me19OrlCEfYzutpeWH/QfKoGTItNx7KbFeKIpDZJfRZjrvgxWj2QRKSRE5jPm62cWre9Z3/0LqyH0kjXxRdJVcJoZyy6CFR2QGMDbK/dCPZgJVWS0uKLn1UFSPJizzJfyZUyM7WHqYaD0NGsUBec7j8EaZDlfTvGBvUaj927CKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foq0aGZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6D3C32781;
	Wed, 24 Jul 2024 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721834415;
	bh=qeXLUpoZGsZRPbAT3HnF46SuxY7YTRrZMXLruO62MZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=foq0aGZehOfXyqCf95kJdLCejTjAEe6euW8dlRJJ7u9hGgh36hPbajH3m3Suml4LV
	 z61gO5OonvF224YmrWKT1dYlX1XAI9bZezjUI1jfVVqUwY0zGPvG/kP8ttPu6VOokS
	 JxfEX1hGt9bq1tbyACJJi4J+fCwrXPziPYtniQ+HUUSWstnFvwG4x7L15Ec36jyO5u
	 itQ87DTpaNObbcl+W8KnQuLwyng0WIngITLq/J4qvh6TScZSsWmTPYSS3OxKkAOvwq
	 lpFkpGr8FTJXHPniV87OFfsML7dm5u2ppm6NkzcnH964YfzNxuIKgVNohknyOXu2jw
	 rGxJomXCH6pPw==
Message-ID: <610dc6fa-6681-4c9e-bffb-ef6d299dd169@kernel.org>
Date: Wed, 24 Jul 2024 17:20:09 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Content-Language: en-US
To: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240724095307.81264-1-songmuchun@bytedance.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240724095307.81264-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 11:53 AM, Muchun Song wrote:
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
> ---
> v2:
>  - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
> 
>  include/linux/memcontrol.h | 20 +++++++++++++++++---
>  mm/memcontrol.c            |  6 +++---
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fc94879db4dff..742351945f683 100644
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
> +	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_is_held(&cgroup_mutex));

Maybe lockdep_assert_once() would be a better fit?

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


