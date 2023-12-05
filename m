Return-Path: <cgroups+bounces-800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3C804853
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 04:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47847281612
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 03:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC7B8F6C;
	Tue,  5 Dec 2023 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6K24kk7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDDC6;
	Mon,  4 Dec 2023 19:54:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d0538d9bbcso33144485ad.3;
        Mon, 04 Dec 2023 19:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701748447; x=1702353247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAbPD6wQF1oZm18W+YGadKrbUnABiAjudnkBSiNtMNk=;
        b=j6K24kk71kbHS102yFwaK4HFznHq8/pUO0udCrOpXtSw873r5qkAQC3B6RUfFt1rF9
         QhyoAG4jcTqs2lsZXV/zZTenqiB4CHm2lcKIUhY+wt7G5CeA4iEdHX073PYkvk+OSQZj
         csJnyKsLjrQtXB1lCxO/19DQAxfrhNB0lU+Wz4htHDz4tNsNi+PEqHbd4dzydXRLRfwY
         p2vix5GwkdlWykVMfqr69rH/7MoT4r8kZipAzIWUx7nXl12UenDMgMN8YVaG4s0ewRdc
         2oQfp4aZH8beM5rjIK32DgyhR96JQrmGFhFVjEu4ubtJMuLgfnqQ8okPTsoe/f214kmg
         UlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701748447; x=1702353247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAbPD6wQF1oZm18W+YGadKrbUnABiAjudnkBSiNtMNk=;
        b=po4AiPXMwQQVEQjnrHOwCkqJ6mVPH7flUH2ofM/htk0vgi38humxDh9rjHXf78mMV0
         NqmP2z2BNXhftoc4yyhrUFe0mmTcDxeO9qmnKy/RcSJKBFL9sxGAD1fgRkdM+ACJxkLF
         XfJLWw747gP4yZaPdfVCrfS8d6qaZn6TvRdBkuxCDSIflmLsS8a65JHHXS69EBGw/vEN
         h0/wmASqXszCSyEO1uLMldfLQGhL28u853KU5sxWNfayD9z6PVWXvlQNQlPpqJwv4Ttn
         VUog6/wgeBWxQSibZzz+Upw2AQTpvLYyukurmtA3Pn2zBpdZYEsTxBbYpE4O/flyNZFb
         ODLQ==
X-Gm-Message-State: AOJu0YyRxZFefXdaAATEPlw48+iV7fhZuV4DTjONrVGzaSiApC0x9cnr
	OxFmEYzMZNFgLNV2aYa/sx0=
X-Google-Smtp-Source: AGHT+IFHkFZVcbXxpT9yPIquBFa0+sY7wZfP3KL5IkCETaB32tGMnTODGeGvGDme+trhJ5fdRZNd3A==
X-Received: by 2002:a17:902:f54c:b0:1d0:6ffd:e2b0 with SMTP id h12-20020a170902f54c00b001d06ffde2b0mr6599717plf.74.1701748447380;
        Mon, 04 Dec 2023 19:54:07 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090332c800b001b8b2a6c4a4sm9168837plr.172.2023.12.04.19.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:54:06 -0800 (PST)
Date: Tue, 5 Dec 2023 12:53:51 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 01/21] mm/slab, docs: switch mm-api docs generation
 from slab.c to slub.c
Message-ID: <ZW6ez8IvvS9ojnZx@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:12PM +0100, Vlastimil Babka wrote:
> The SLAB implementation is going to be removed, and mm-api.rst currently
> uses mm/slab.c to obtain kerneldocs for some API functions. Switch it to
> mm/slub.c and move the relevant kerneldocs of exported functions from
> one to the other. The rest of kerneldocs in slab.c is for static SLAB
> implementation-specific functions that don't have counterparts in slub.c
> and thus can be simply removed with the implementation.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/core-api/mm-api.rst |  2 +-
>  mm/slab.c                         | 21 ---------------------
>  mm/slub.c                         | 21 +++++++++++++++++++++
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
> index 2d091c873d1e..af8151db88b2 100644
> --- a/Documentation/core-api/mm-api.rst
> +++ b/Documentation/core-api/mm-api.rst
> @@ -37,7 +37,7 @@ The Slab Cache
>  .. kernel-doc:: include/linux/slab.h
>     :internal:
>  
> -.. kernel-doc:: mm/slab.c
> +.. kernel-doc:: mm/slub.c
>     :export:
>  
>  .. kernel-doc:: mm/slab_common.c
> diff --git a/mm/slab.c b/mm/slab.c
> index 9ad3d0f2d1a5..37efe3241f9c 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3491,19 +3491,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>  
> -/**
> - * kmem_cache_alloc_node - Allocate an object on the specified node
> - * @cachep: The cache to allocate from.
> - * @flags: See kmalloc().
> - * @nodeid: node number of the target node.
> - *
> - * Identical to kmem_cache_alloc but it will allocate memory on the given
> - * node, which can improve the performance for cpu bound structures.
> - *
> - * Fallback to other node is possible if __GFP_THISNODE is not set.
> - *
> - * Return: pointer to the new object or %NULL in case of error
> - */
>  void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  {
>  	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
> @@ -3564,14 +3551,6 @@ void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
>  	__do_kmem_cache_free(cachep, objp, caller);
>  }
>  
> -/**
> - * kmem_cache_free - Deallocate an object
> - * @cachep: The cache the allocation was from.
> - * @objp: The previously allocated object.
> - *
> - * Free an object which was previously allocated from this
> - * cache.
> - */
>  void kmem_cache_free(struct kmem_cache *cachep, void *objp)
>  {
>  	cachep = cache_from_obj(cachep, objp);
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..3e01731783df 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3518,6 +3518,19 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>  			       caller, orig_size);
>  }
>  
> +/**
> + * kmem_cache_alloc_node - Allocate an object on the specified node
> + * @s: The cache to allocate from.
> + * @gfpflags: See kmalloc().
> + * @node: node number of the target node.
> + *
> + * Identical to kmem_cache_alloc but it will allocate memory on the given
> + * node, which can improve the performance for cpu bound structures.
> + *
> + * Fallback to other node is possible if __GFP_THISNODE is not set.
> + *
> + * Return: pointer to the new object or %NULL in case of error
> + */
>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
> @@ -3822,6 +3835,14 @@ void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
>  	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
>  }
>  
> +/**
> + * kmem_cache_free - Deallocate an object
> + * @s: The cache the allocation was from.
> + * @x: The previously allocated object.
> + *
> + * Free an object which was previously allocated from this
> + * cache.
> + */
>  void kmem_cache_free(struct kmem_cache *s, void *x)
>  {
>  	s = cache_from_obj(s, x);
> 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> -- 
> 2.42.1
> 
> 

