Return-Path: <cgroups+bounces-859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7AD806ACA
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132381F211BD
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B11A70F;
	Wed,  6 Dec 2023 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVPiMx/N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC3A4;
	Wed,  6 Dec 2023 01:35:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfb30ce241so47470945ad.0;
        Wed, 06 Dec 2023 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701855350; x=1702460150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yma25+fKs5uOP5FQ6tfNto8zkRZRxKoDlNbBVbZifwI=;
        b=XVPiMx/NZ15gA7NzrudB29opyiE5DKkQye9ys/CM/V/GlIG9ZzHE0rLcnOeMFs6qWx
         jZ7R2iyZaF1dUREqgE1fu4xA0DcEK5b0B2Qa3tRL3JIQ4R3mcte9OLaOPHgRgDCMn4IX
         SU5T2UJt+7qHHYrIBIE8Vz4XrVa3feB2cK5HgacYZLjzNdzDLWa+HYloxk7jcKCCc+7a
         MT/pwl0BpzVJxJY2u8ScWhytwMURaCDqxJAJG8mt+BTw6xrbKq4O6k8n7mFECT2aSQV6
         2sNZ1VYgJnWTUzOK/M+zvQXr6kcgL85G+BpyuN9zyBinSP9elzXSgDRwdkak30Hic5Se
         Mt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855350; x=1702460150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yma25+fKs5uOP5FQ6tfNto8zkRZRxKoDlNbBVbZifwI=;
        b=WTjlRP5vUhUqUowm2d1Hu8ZlJtIrd9BUDpyw4+sZPpMHNwZXqosARwNA6/0uRVW34F
         MiDcaTQcvuu37YATiH956wzPxFQt+ijOcXzAQDZazCL80gjyJUZniF00JhP71VbPPGBa
         tr4kQ7kGXo7mIcXTfRancoiWZ0JfBG6uAXA9hSP8Vqt1BeDKpyLPs7eNqlqbb1k34Sam
         33UmaooUQKNG2lAbTjHelVu3skzkJEMEoUadbc0sAr04fXhgEaE+CXRVLeiLWx9MpdAC
         mx6aA7kAFoTwpNAA68U4ZnOsrczzRillGE3iZAVytCIuOyny2LK5Z0Zhu15Dw/TyySqr
         ep7Q==
X-Gm-Message-State: AOJu0Yz4ummoIqPzejYzu9JZa+M3jj95SswV1WyRyueQA4bPmu2Vkno/
	Nl6Y0a550a1P+Nti/i3gMJI=
X-Google-Smtp-Source: AGHT+IHZjom9nz5RbaP6rAPTPYSFyoGmDXl8F1GdAE9vlsDqXtsXUXXEWE/jcur7nyFw7f865jd2sg==
X-Received: by 2002:a17:902:ce92:b0:1d0:7ed3:ea7c with SMTP id f18-20020a170902ce9200b001d07ed3ea7cmr647263plg.29.1701855350258;
        Wed, 06 Dec 2023 01:35:50 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001c9db5e2929sm11663481plr.93.2023.12.06.01.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:35:49 -0800 (PST)
Date: Wed, 6 Dec 2023 18:35:42 +0900
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
Subject: Re: [PATCH v2 10/21] mm/slab: move struct kmem_cache_cpu declaration
 to slub.c
Message-ID: <ZXBAbu7pR4o7JIa5@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-10-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-10-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:21PM +0100, Vlastimil Babka wrote:
> Nothing outside SLUB itself accesses the struct kmem_cache_cpu fields so
> it does not need to be declared in slub_def.h. This allows also to move
> enum stat_item.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slub_def.h | 54 ------------------------------------------------
>  mm/slub.c                | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index deb90cf4bffb..a0229ea42977 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -12,60 +12,6 @@
>  #include <linux/reciprocal_div.h>
>  #include <linux/local_lock.h>
>  
> -enum stat_item {
> -	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> -	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
> -	FREE_FASTPATH,		/* Free to cpu slab */
> -	FREE_SLOWPATH,		/* Freeing not to cpu slab */
> -	FREE_FROZEN,		/* Freeing to frozen slab */
> -	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
> -	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
> -	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
> -	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
> -	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
> -	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
> -	FREE_SLAB,		/* Slab freed to the page allocator */
> -	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
> -	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
> -	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
> -	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
> -	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
> -	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
> -	DEACTIVATE_BYPASS,	/* Implicit deactivation */
> -	ORDER_FALLBACK,		/* Number of times fallback was necessary */
> -	CMPXCHG_DOUBLE_CPU_FAIL,/* Failure of this_cpu_cmpxchg_double */
> -	CMPXCHG_DOUBLE_FAIL,	/* Number of times that cmpxchg double did not match */
> -	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
> -	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
> -	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
> -	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
> -	NR_SLUB_STAT_ITEMS
> -};
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * When changing the layout, make sure freelist and tid are still compatible
> - * with this_cpu_cmpxchg_double() alignment requirements.
> - */
> -struct kmem_cache_cpu {
> -	union {
> -		struct {
> -			void **freelist;	/* Pointer to next available object */
> -			unsigned long tid;	/* Globally unique transaction id */
> -		};
> -		freelist_aba_t freelist_tid;
> -	};
> -	struct slab *slab;	/* The slab from which we are allocating */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	struct slab *partial;	/* Partially allocated frozen slabs */
> -#endif
> -	local_lock_t lock;	/* Protects the fields above */
> -#ifdef CONFIG_SLUB_STATS
> -	unsigned stat[NR_SLUB_STAT_ITEMS];
> -#endif
> -};
> -#endif /* CONFIG_SLUB_TINY */
> -
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  #define slub_percpu_partial(c)		((c)->partial)
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 3e01731783df..979932d046fd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -330,6 +330,60 @@ static void debugfs_slab_add(struct kmem_cache *);
>  static inline void debugfs_slab_add(struct kmem_cache *s) { }
>  #endif
>  
> +enum stat_item {
> +	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> +	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
> +	FREE_FASTPATH,		/* Free to cpu slab */
> +	FREE_SLOWPATH,		/* Freeing not to cpu slab */
> +	FREE_FROZEN,		/* Freeing to frozen slab */
> +	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
> +	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
> +	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
> +	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
> +	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
> +	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
> +	FREE_SLAB,		/* Slab freed to the page allocator */
> +	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
> +	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
> +	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
> +	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
> +	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
> +	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
> +	DEACTIVATE_BYPASS,	/* Implicit deactivation */
> +	ORDER_FALLBACK,		/* Number of times fallback was necessary */
> +	CMPXCHG_DOUBLE_CPU_FAIL,/* Failures of this_cpu_cmpxchg_double */
> +	CMPXCHG_DOUBLE_FAIL,	/* Failures of slab freelist update */
> +	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
> +	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
> +	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
> +	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
> +	NR_SLUB_STAT_ITEMS
> +};
> +
> +#ifndef CONFIG_SLUB_TINY
> +/*
> + * When changing the layout, make sure freelist and tid are still compatible
> + * with this_cpu_cmpxchg_double() alignment requirements.
> + */
> +struct kmem_cache_cpu {
> +	union {
> +		struct {
> +			void **freelist;	/* Pointer to next available object */
> +			unsigned long tid;	/* Globally unique transaction id */
> +		};
> +		freelist_aba_t freelist_tid;
> +	};
> +	struct slab *slab;	/* The slab from which we are allocating */
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +	struct slab *partial;	/* Partially allocated frozen slabs */
> +#endif
> +	local_lock_t lock;	/* Protects the fields above */
> +#ifdef CONFIG_SLUB_STATS
> +	unsigned int stat[NR_SLUB_STAT_ITEMS];
> +#endif
> +};
> +#endif /* CONFIG_SLUB_TINY */
> +
>  static inline void stat(const struct kmem_cache *s, enum stat_item si)
>  {
>  #ifdef CONFIG_SLUB_STATS

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 

