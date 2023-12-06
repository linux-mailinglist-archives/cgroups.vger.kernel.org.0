Return-Path: <cgroups+bounces-861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0FB806AFA
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24451C209A4
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619301C2A8;
	Wed,  6 Dec 2023 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4XigeDE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D5BB9;
	Wed,  6 Dec 2023 01:45:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2886579d59fso551854a91.1;
        Wed, 06 Dec 2023 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701855928; x=1702460728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDd5Zi7vCvO2ycBR8Ub2HRlOTkCLIJYdUeR29MHQbio=;
        b=k4XigeDEBSgvqyVHmm1bmWjTOxzyB+p/cE2p2kLNf5k2EMHos8h1gTjHars0hURNs/
         RbCmJhkNvQTqKXT2teNq2OZ4Tjk+HH4cC0SsQcT1llQH/+aoTxROhA1E+DAg69e7AuxL
         WCOOul0SuYvkCJjZ2ADm6agXpFuefzfuwL8wDM7EgBQnOkcwczobDEwrzk+DEwCj6gq1
         ujVYef7RPJC0BydIDXJiC/9MWqI6o+z2rEgI1bGg7nbKfgiQzqhEkYeOaQKtPOhT1XIu
         RL1vTgieqs4plIWBgsWcqGBQ5RGE5/RUsFoJSrqoy8C1q6yAuWy1b6PVZcuM4Tssom5O
         R1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855928; x=1702460728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDd5Zi7vCvO2ycBR8Ub2HRlOTkCLIJYdUeR29MHQbio=;
        b=H8qsC7ojIl2tKBQbYuORgvQpgjI9oXVOdrYm7LlPGenjEd+/esUrwUCkkAJfuLCRYk
         zCvt1eOQFly7X/yx3YJzRtR6luvyayytEaBsFpMJGPyxew8PUDDLo0oQfICpP72/QQSX
         CTxf6Gcs4IvjGvf3QIh4e/RnnOQJCWxpULAECHmysJim8lp48ZNbgJMzxR+H+fiP0Jnk
         LN8kc36Beq5euvkWBCq9ECgeH60Yx9LauKIoqBOxHDirY4gJDIWtzuDETTLtWVatjt1m
         SatnYuTSlNG7mNG5+ZgplWVp62c//Bc34BQbRWFoUtI3HA45THirdEKeM7GCI4YY2/iV
         6sKw==
X-Gm-Message-State: AOJu0YyJV3kO7EDxlW6NPJfQS3ztClgrjLrFBnADKVd6PafSoLo/ZFyy
	ZO0YjWI0BZZ3Cp54OXv5U7k=
X-Google-Smtp-Source: AGHT+IHdaI2N+Uyv0y5U6vvyUM83vZn0QO5kyeyTrfCVEOhHY8wZLirKQdWWbZQYJWf2FlKP8QJrdg==
X-Received: by 2002:a17:90b:1298:b0:286:6cc0:cac2 with SMTP id fw24-20020a17090b129800b002866cc0cac2mr546651pjb.57.1701855927932;
        Wed, 06 Dec 2023 01:45:27 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id ms10-20020a17090b234a00b0028679f2ee38sm938188pjb.0.2023.12.06.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:45:27 -0800 (PST)
Date: Wed, 6 Dec 2023 18:45:19 +0900
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
Subject: Re: [PATCH v2 11/21] mm/slab: move the rest of slub_def.h to
 mm/slab.h
Message-ID: <ZXBCr2n9m/jfXxFw@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-11-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-11-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:22PM +0100, Vlastimil Babka wrote:
> mm/slab.h is the only place to include include/linux/slub_def.h which
> has allowed switching between SLAB and SLUB. Now we can simply move the
> contents over and remove slub_def.h.
> 
> Use this opportunity to fix up some whitespace (alignment) issues.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slub_def.h | 150 -----------------------------------------------
>  mm/slab.h                | 138 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 137 insertions(+), 151 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> deleted file mode 100644
> index a0229ea42977..000000000000
> --- a/include/linux/slub_def.h
> +++ /dev/null
> @@ -1,150 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SLUB_DEF_H
> -#define _LINUX_SLUB_DEF_H
> -
> -/*
> - * SLUB : A Slab allocator without object queues.
> - *
> - * (C) 2007 SGI, Christoph Lameter
> - */
> -#include <linux/kfence.h>
> -#include <linux/kobject.h>
> -#include <linux/reciprocal_div.h>
> -#include <linux/local_lock.h>
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -#define slub_percpu_partial(c)		((c)->partial)
> -
> -#define slub_set_percpu_partial(c, p)		\
> -({						\
> -	slub_percpu_partial(c) = (p)->next;	\
> -})
> -
> -#define slub_percpu_partial_read_once(c)     READ_ONCE(slub_percpu_partial(c))
> -#else
> -#define slub_percpu_partial(c)			NULL
> -
> -#define slub_set_percpu_partial(c, p)
> -
> -#define slub_percpu_partial_read_once(c)	NULL
> -#endif // CONFIG_SLUB_CPU_PARTIAL
> -
> -/*
> - * Word size structure that can be atomically updated or read and that
> - * contains both the order and the number of objects that a slab of the
> - * given order would contain.
> - */
> -struct kmem_cache_order_objects {
> -	unsigned int x;
> -};
> -
> -/*
> - * Slab cache management.
> - */
> -struct kmem_cache {
> -#ifndef CONFIG_SLUB_TINY
> -	struct kmem_cache_cpu __percpu *cpu_slab;
> -#endif
> -	/* Used for retrieving partial slabs, etc. */
> -	slab_flags_t flags;
> -	unsigned long min_partial;
> -	unsigned int size;	/* The size of an object including metadata */
> -	unsigned int object_size;/* The size of an object without metadata */
> -	struct reciprocal_value reciprocal_size;
> -	unsigned int offset;	/* Free pointer offset */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	/* Number of per cpu partial objects to keep around */
> -	unsigned int cpu_partial;
> -	/* Number of per cpu partial slabs to keep around */
> -	unsigned int cpu_partial_slabs;
> -#endif
> -	struct kmem_cache_order_objects oo;
> -
> -	/* Allocation and freeing of slabs */
> -	struct kmem_cache_order_objects min;
> -	gfp_t allocflags;	/* gfp flags to use on each alloc */
> -	int refcount;		/* Refcount for slab cache destroy */
> -	void (*ctor)(void *);
> -	unsigned int inuse;		/* Offset to metadata */
> -	unsigned int align;		/* Alignment */
> -	unsigned int red_left_pad;	/* Left redzone padding size */
> -	const char *name;	/* Name (only for display!) */
> -	struct list_head list;	/* List of slab caches */
> -#ifdef CONFIG_SYSFS
> -	struct kobject kobj;	/* For sysfs */
> -#endif
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	unsigned long random;
> -#endif
> -
> -#ifdef CONFIG_NUMA
> -	/*
> -	 * Defragmentation by allocating from a remote node.
> -	 */
> -	unsigned int remote_node_defrag_ratio;
> -#endif
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -	unsigned int *random_seq;
> -#endif
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -	struct kasan_cache kasan_info;
> -#endif
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	unsigned int useroffset;	/* Usercopy region offset */
> -	unsigned int usersize;		/* Usercopy region size */
> -#endif
> -
> -	struct kmem_cache_node *node[MAX_NUMNODES];
> -};
> -
> -#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> -void sysfs_slab_unlink(struct kmem_cache *);
> -void sysfs_slab_release(struct kmem_cache *);
> -#else
> -static inline void sysfs_slab_unlink(struct kmem_cache *s)
> -{
> -}
> -static inline void sysfs_slab_release(struct kmem_cache *s)
> -{
> -}
> -#endif
> -
> -void *fixup_red_left(struct kmem_cache *s, void *p);
> -
> -static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> -				void *x) {
> -	void *object = x - (x - slab_address(slab)) % cache->size;
> -	void *last_object = slab_address(slab) +
> -		(slab->objects - 1) * cache->size;
> -	void *result = (unlikely(object > last_object)) ? last_object : object;
> -
> -	result = fixup_red_left(cache, result);
> -	return result;
> -}
> -
> -/* Determine object index from a given position */
> -static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
> -					  void *addr, void *obj)
> -{
> -	return reciprocal_divide(kasan_reset_tag(obj) - addr,
> -				 cache->reciprocal_size);
> -}
> -
> -static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct slab *slab, void *obj)
> -{
> -	if (is_kfence_address(obj))
> -		return 0;
> -	return __obj_to_index(cache, slab_address(slab), obj);
> -}
> -
> -static inline int objs_per_slab(const struct kmem_cache *cache,
> -				     const struct slab *slab)
> -{
> -	return slab->objects;
> -}
> -#endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/slab.h b/mm/slab.h
> index 014c36ea51fa..3a8d13c099fa 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -209,7 +209,143 @@ static inline size_t slab_size(const struct slab *slab)
>  	return PAGE_SIZE << slab_order(slab);
>  }
>  
> -#include <linux/slub_def.h>
> +#include <linux/kfence.h>
> +#include <linux/kobject.h>
> +#include <linux/reciprocal_div.h>
> +#include <linux/local_lock.h>
> +
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +#define slub_percpu_partial(c)			((c)->partial)
> +
> +#define slub_set_percpu_partial(c, p)		\
> +({						\
> +	slub_percpu_partial(c) = (p)->next;	\
> +})
> +
> +#define slub_percpu_partial_read_once(c)	READ_ONCE(slub_percpu_partial(c))
> +#else
> +#define slub_percpu_partial(c)			NULL
> +
> +#define slub_set_percpu_partial(c, p)
> +
> +#define slub_percpu_partial_read_once(c)	NULL
> +#endif // CONFIG_SLUB_CPU_PARTIAL
> +
> +/*
> + * Word size structure that can be atomically updated or read and that
> + * contains both the order and the number of objects that a slab of the
> + * given order would contain.
> + */
> +struct kmem_cache_order_objects {
> +	unsigned int x;
> +};
> +
> +/*
> + * Slab cache management.
> + */
> +struct kmem_cache {
> +#ifndef CONFIG_SLUB_TINY
> +	struct kmem_cache_cpu __percpu *cpu_slab;
> +#endif
> +	/* Used for retrieving partial slabs, etc. */
> +	slab_flags_t flags;
> +	unsigned long min_partial;
> +	unsigned int size;		/* Object size including metadata */
> +	unsigned int object_size;	/* Object size without metadata */
> +	struct reciprocal_value reciprocal_size;
> +	unsigned int offset;		/* Free pointer offset */
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +	/* Number of per cpu partial objects to keep around */
> +	unsigned int cpu_partial;
> +	/* Number of per cpu partial slabs to keep around */
> +	unsigned int cpu_partial_slabs;
> +#endif
> +	struct kmem_cache_order_objects oo;
> +
> +	/* Allocation and freeing of slabs */
> +	struct kmem_cache_order_objects min;
> +	gfp_t allocflags;		/* gfp flags to use on each alloc */
> +	int refcount;			/* Refcount for slab cache destroy */
> +	void (*ctor)(void *object);	/* Object constructor */
> +	unsigned int inuse;		/* Offset to metadata */
> +	unsigned int align;		/* Alignment */
> +	unsigned int red_left_pad;	/* Left redzone padding size */
> +	const char *name;		/* Name (only for display!) */
> +	struct list_head list;		/* List of slab caches */
> +#ifdef CONFIG_SYSFS
> +	struct kobject kobj;		/* For sysfs */
> +#endif
> +#ifdef CONFIG_SLAB_FREELIST_HARDENED
> +	unsigned long random;
> +#endif
> +
> +#ifdef CONFIG_NUMA
> +	/*
> +	 * Defragmentation by allocating from a remote node.
> +	 */
> +	unsigned int remote_node_defrag_ratio;
> +#endif
> +
> +#ifdef CONFIG_SLAB_FREELIST_RANDOM
> +	unsigned int *random_seq;
> +#endif
> +
> +#ifdef CONFIG_KASAN_GENERIC
> +	struct kasan_cache kasan_info;
> +#endif
> +
> +#ifdef CONFIG_HARDENED_USERCOPY
> +	unsigned int useroffset;	/* Usercopy region offset */
> +	unsigned int usersize;		/* Usercopy region size */
> +#endif
> +
> +	struct kmem_cache_node *node[MAX_NUMNODES];
> +};
> +
> +#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> +#define SLAB_SUPPORTS_SYSFS
> +void sysfs_slab_unlink(struct kmem_cache *s);
> +void sysfs_slab_release(struct kmem_cache *s);
> +#else
> +static inline void sysfs_slab_unlink(struct kmem_cache *s) { }
> +static inline void sysfs_slab_release(struct kmem_cache *s) { }
> +#endif
> +
> +void *fixup_red_left(struct kmem_cache *s, void *p);
> +
> +static inline void *nearest_obj(struct kmem_cache *cache,
> +				const struct slab *slab, void *x)
> +{
> +	void *object = x - (x - slab_address(slab)) % cache->size;
> +	void *last_object = slab_address(slab) +
> +		(slab->objects - 1) * cache->size;
> +	void *result = (unlikely(object > last_object)) ? last_object : object;
> +
> +	result = fixup_red_left(cache, result);
> +	return result;
> +}
> +
> +/* Determine object index from a given position */
> +static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
> +					  void *addr, void *obj)
> +{
> +	return reciprocal_divide(kasan_reset_tag(obj) - addr,
> +				 cache->reciprocal_size);
> +}
> +
> +static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> +					const struct slab *slab, void *obj)
> +{
> +	if (is_kfence_address(obj))
> +		return 0;
> +	return __obj_to_index(cache, slab_address(slab), obj);
> +}
> +
> +static inline int objs_per_slab(const struct kmem_cache *cache,
> +				const struct slab *slab)
> +{
> +	return slab->objects;
> +}
>  
>  #include <linux/memcontrol.h>
>  #include <linux/fault-inject.h>

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 

