Return-Path: <cgroups+bounces-878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D104D807DA3
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8982824BC
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB77F6;
	Thu,  7 Dec 2023 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc2XVfQO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00B10D;
	Wed,  6 Dec 2023 17:11:19 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5906eac104bso80758eaf.2;
        Wed, 06 Dec 2023 17:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701911478; x=1702516278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2iQ4GZaNaP4TLuVf9scG6OMfAEhFr0GcB530VPLhoU=;
        b=mc2XVfQO1QHhrSD+ppXwi5+S8WGod3W/y74JxPD52WcjvSFjIEZhCG7cnX7qZtVMRM
         vsHq2uqVAdp4otTfWuS4WFFBkb5kpgMLYJOiV79dHXB0OCyVNBD20fWg9sW6UK9JrQ/A
         cUCxvqyh7tiSri3UoRKiPhNHXrcPofCU+GKI818g8Eum3zGyMq9BDl2KgUM5zIhA3NgY
         fshV58sz9U2hfpyPnO9M21AogCdaR4aJUzIDmsu8mHRcldevgKZNVpSXftH4zYyhvXas
         83NAdbG0YXt6wFahhJBM4hNnwqyEhLh9yPHGZfhS60PaBpS3FmNkZmxamUpk4ugtOyhN
         ekVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911478; x=1702516278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2iQ4GZaNaP4TLuVf9scG6OMfAEhFr0GcB530VPLhoU=;
        b=rUSanU991ZVB7yammGONyQ5ymVR1/ZWc3arJnnG0n+j7sdAJlkaoaZ/6M605vNf9uP
         /Hb1x5Me+l1SrfLRwEcKL2ZeMcwx+gslHwgs9yG5S8DrGMhhFSciz14momx9z7Omwpr6
         gY4+NrilFYQw8jqDqqIvjdT09PuRag4vwQSYKjNFxVVeMNv09gHoev059CpNqAFiwnPs
         oZeSp2+OF+0tacrhu72qBQXhsVVcLRXfeRSOdgXCa02u+1KDiQEJasWMvkxuWA6URzXG
         f4/phFkHOzr2/p/EOmmWTLH2ULl7BLh0kJKm7hY4dAxNyeOwxWc9fDGyS8hnELchZeD2
         Z2Ww==
X-Gm-Message-State: AOJu0YxNBAL+yeqFm+y6WFpzhJmclgRHFCOikdxliuiXXu3GZfbWWzzf
	LPwiCL+4G3Bqst66N+PFPK8=
X-Google-Smtp-Source: AGHT+IGc9dkQ2KVuG2CkWKzx9T1jI0zfnEUmwYynupuHvD497P297MjLlX6Fmpv412ssI2djQI620w==
X-Received: by 2002:a05:6358:4320:b0:16e:27b5:3b25 with SMTP id r32-20020a056358432000b0016e27b53b25mr1981299rwc.31.1701911478109;
        Wed, 06 Dec 2023 17:11:18 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006be5af77f06sm141705pfn.2.2023.12.06.17.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:11:17 -0800 (PST)
Date: Thu, 7 Dec 2023 10:11:02 +0900
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
Subject: Re: [PATCH v2 15/21] mm/slab: move struct kmem_cache_node from
 slab.h to slub.c
Message-ID: <ZXEbpvUpmhOBZvuH@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-15-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-15-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:26PM +0100, Vlastimil Babka wrote:
> The declaration and associated helpers are not used anywhere else
> anymore.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h | 29 -----------------------------
>  mm/slub.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index a81ef7c9282d..5ae6a978e9c2 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -588,35 +588,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
>  	return s->size;
>  }
>  
> -
> -/*
> - * The slab lists for all objects.
> - */
> -struct kmem_cache_node {
> -	spinlock_t list_lock;
> -	unsigned long nr_partial;
> -	struct list_head partial;
> -#ifdef CONFIG_SLUB_DEBUG
> -	atomic_long_t nr_slabs;
> -	atomic_long_t total_objects;
> -	struct list_head full;
> -#endif
> -};
> -
> -static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> -{
> -	return s->node[node];
> -}
> -
> -/*
> - * Iterator over all nodes. The body will be executed for each node that has
> - * a kmem_cache_node structure allocated (which is true for all online nodes)
> - */
> -#define for_each_kmem_cache_node(__s, __node, __n) \
> -	for (__node = 0; __node < nr_node_ids; __node++) \
> -		 if ((__n = get_node(__s, __node)))
> -
> -
>  #ifdef CONFIG_SLUB_DEBUG
>  void dump_unreclaimable_slab(void);
>  #else
> diff --git a/mm/slub.c b/mm/slub.c
> index 844e0beb84ee..cc801f8258fe 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -396,6 +396,33 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
>  #endif
>  }
>  
> +/*
> + * The slab lists for all objects.
> + */
> +struct kmem_cache_node {
> +	spinlock_t list_lock;
> +	unsigned long nr_partial;
> +	struct list_head partial;
> +#ifdef CONFIG_SLUB_DEBUG
> +	atomic_long_t nr_slabs;
> +	atomic_long_t total_objects;
> +	struct list_head full;
> +#endif
> +};
> +
> +static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> +{
> +	return s->node[node];
> +}
> +
> +/*
> + * Iterator over all nodes. The body will be executed for each node that has
> + * a kmem_cache_node structure allocated (which is true for all online nodes)
> + */
> +#define for_each_kmem_cache_node(__s, __node, __n) \
> +	for (__node = 0; __node < nr_node_ids; __node++) \
> +		 if ((__n = get_node(__s, __node)))
> +
>  /*
>   * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
>   * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 

