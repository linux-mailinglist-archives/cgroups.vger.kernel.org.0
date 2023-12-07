Return-Path: <cgroups+bounces-876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA1C807D61
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A7B21174
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611CA7F3;
	Thu,  7 Dec 2023 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj69Ns+x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD336E0;
	Wed,  6 Dec 2023 16:43:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce94f62806so84980b3a.1;
        Wed, 06 Dec 2023 16:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701909809; x=1702514609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eh9CtMoBA+zmGvG+NMP6SS+GUAPZn7ZW9r8sCwWKZF8=;
        b=Pj69Ns+x9Mj6nd11Ln5I2lxbsKW32F0sudERQbezDpJJVN2JvbcQEEotU6IFkhPwql
         U9CRSSaopODLoYRGn0h7oCSmSlDnhFdwJMCuy5d7qudnLeLZ/QtnQ5oNzv8hJWPNIz81
         5bcKCRSnxycyUVAgmvi1GbCnVIV5rMB+XvNOs09NXve0PVNvv9ZCDBg0yxdtmzj3rF7Z
         6gry2hbCasNBKtWCOLcT2AtIosl/g98R7LfK1d9wjhmoxbwGCy9Lohhrz5FQf2UxsYUR
         hk9xe8Q7mu2aKtyERhu3B/XihavSobc4f/vZtOMryOIcdth1+fzK6QIWTmIKy5fhOAnB
         6D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909809; x=1702514609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh9CtMoBA+zmGvG+NMP6SS+GUAPZn7ZW9r8sCwWKZF8=;
        b=kBqJyHFjUfYLW5LL/raL7DgQEVABwOUDNr19XWCjteJWbIbAeVGKpo/VVJGvNk7G/R
         s58CdP4n23eG+rFS7t8+YB09r8TU03ci4XK+LJxHKqv6sVv1FCSIMOM56VckJG/QckA/
         iVNZb0JmkOlfmhpvH0EO1K5rzpzroC7tgUgDADBbVhgCVOUV0YltCcNVZboxppdqI3LK
         IEjTJReudVGSXOinMssj7EQG0DySNHmNsmxg2NYC0YcjNpW4A2zjfBUVeZX0VQJaoExy
         qi4X6Ktua4qmH6v9BAt6YVSX+M2YK9rHBzu3Szv+V6rpj1NUGyn8wNUfc0W7fr6BTt4K
         EMDA==
X-Gm-Message-State: AOJu0YxvitullPMvcZw5MgxgYWFyCPmMLtcN4z1Dh/cw1An2fcLf1LZ4
	ZUpGZnd1ZO4VfzkHERO1uQg=
X-Google-Smtp-Source: AGHT+IHVLxtmkCWrQvVjzfGp4Yyi7Sp2zeTFR6kkuCxxzYtmahqouIYzhFcsyiEwLef13SnL50mS0w==
X-Received: by 2002:a05:6a20:2449:b0:18a:de88:e0d with SMTP id t9-20020a056a20244900b0018ade880e0dmr1780832pzc.15.1701909808906;
        Wed, 06 Dec 2023 16:43:28 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001cf7bd9ade5sm63977plf.3.2023.12.06.16.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:43:28 -0800 (PST)
Date: Thu, 7 Dec 2023 09:43:04 +0900
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
Subject: Re: [PATCH v2 13/21] mm/slab: move pre/post-alloc hooks from slab.h
 to slub.c
Message-ID: <ZXEVGNxKTNC6v5NR@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-13-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-13-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:24PM +0100, Vlastimil Babka wrote:
> We don't share the hooks between two slab implementations anymore so
> they can be moved away from the header. As part of the move, also move
> should_failslab() from slab_common.c as the pre_alloc hook uses it.
> This means slab.h can stop including fault-inject.h and kmemleak.h.
> Fix up some files that were depending on the includes transitively.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/kasan/report.c |  1 +
>  mm/memcontrol.c   |  1 +
>  mm/slab.h         | 72 -------------------------------------------------
>  mm/slab_common.c  |  8 +-----
>  mm/slub.c         | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 84 insertions(+), 79 deletions(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index e77facb62900..011f727bfaff 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -23,6 +23,7 @@
>  #include <linux/stacktrace.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/vmalloc.h>
>  #include <linux/kasan.h>
>  #include <linux/module.h>
>  #include <linux/sched/task_stack.h>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 947fb50eba31..8a0603517065 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -64,6 +64,7 @@
>  #include <linux/psi.h>
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/kmemleak.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> diff --git a/mm/slab.h b/mm/slab.h
> index 1ac3a2f8d4c0..65ebf86b3fe9 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -9,8 +9,6 @@
>  #include <linux/kobject.h>
>  #include <linux/sched/mm.h>
>  #include <linux/memcontrol.h>
> -#include <linux/fault-inject.h>
> -#include <linux/kmemleak.h>
>  #include <linux/kfence.h>
>  #include <linux/kasan.h>
>  
> @@ -796,76 +794,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
>  	return s->size;
>  }
>  
> -static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> -						     struct list_lru *lru,
> -						     struct obj_cgroup **objcgp,
> -						     size_t size, gfp_t flags)
> -{
> -	flags &= gfp_allowed_mask;
> -
> -	might_alloc(flags);
> -
> -	if (should_failslab(s, flags))
> -		return NULL;
> -
> -	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
> -		return NULL;
> -
> -	return s;
> -}
> -
> -static inline void slab_post_alloc_hook(struct kmem_cache *s,
> -					struct obj_cgroup *objcg, gfp_t flags,
> -					size_t size, void **p, bool init,
> -					unsigned int orig_size)
> -{
> -	unsigned int zero_size = s->object_size;
> -	bool kasan_init = init;
> -	size_t i;
> -
> -	flags &= gfp_allowed_mask;
> -
> -	/*
> -	 * For kmalloc object, the allocated memory size(object_size) is likely
> -	 * larger than the requested size(orig_size). If redzone check is
> -	 * enabled for the extra space, don't zero it, as it will be redzoned
> -	 * soon. The redzone operation for this extra space could be seen as a
> -	 * replacement of current poisoning under certain debug option, and
> -	 * won't break other sanity checks.
> -	 */
> -	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
> -	    (s->flags & SLAB_KMALLOC))
> -		zero_size = orig_size;
> -
> -	/*
> -	 * When slub_debug is enabled, avoid memory initialization integrated
> -	 * into KASAN and instead zero out the memory via the memset below with
> -	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
> -	 * cause false-positive reports. This does not lead to a performance
> -	 * penalty on production builds, as slub_debug is not intended to be
> -	 * enabled there.
> -	 */
> -	if (__slub_debug_enabled())
> -		kasan_init = false;
> -
> -	/*
> -	 * As memory initialization might be integrated into KASAN,
> -	 * kasan_slab_alloc and initialization memset must be
> -	 * kept together to avoid discrepancies in behavior.
> -	 *
> -	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
> -	 */
> -	for (i = 0; i < size; i++) {
> -		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
> -		if (p[i] && init && (!kasan_init || !kasan_has_integrated_init()))
> -			memset(p[i], 0, zero_size);
> -		kmemleak_alloc_recursive(p[i], s->object_size, 1,
> -					 s->flags, flags);
> -		kmsan_slab_alloc(s, p[i], flags);
> -	}
> -
> -	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> -}
>  
>  /*
>   * The slab lists for all objects.
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 63b8411db7ce..bbc2e3f061f1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -21,6 +21,7 @@
>  #include <linux/swiotlb.h>
>  #include <linux/proc_fs.h>
>  #include <linux/debugfs.h>
> +#include <linux/kmemleak.h>
>  #include <linux/kasan.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
> @@ -1470,10 +1471,3 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
>  
> -int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> -{
> -	if (__should_failslab(s, gfpflags))
> -		return -ENOMEM;
> -	return 0;
> -}
> -ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
> diff --git a/mm/slub.c b/mm/slub.c
> index 979932d046fd..9eb6508152c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -34,6 +34,7 @@
>  #include <linux/memory.h>
>  #include <linux/math64.h>
>  #include <linux/fault-inject.h>
> +#include <linux/kmemleak.h>
>  #include <linux/stacktrace.h>
>  #include <linux/prefetch.h>
>  #include <linux/memcontrol.h>
> @@ -3494,6 +3495,86 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>  			0, sizeof(void *));
>  }
>  
> +noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> +{
> +	if (__should_failslab(s, gfpflags))
> +		return -ENOMEM;
> +	return 0;
> +}
> +ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
> +
> +static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> +						     struct list_lru *lru,
> +						     struct obj_cgroup **objcgp,
> +						     size_t size, gfp_t flags)
> +{
> +	flags &= gfp_allowed_mask;
> +
> +	might_alloc(flags);
> +
> +	if (should_failslab(s, flags))
> +		return NULL;
> +
> +	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
> +		return NULL;
> +
> +	return s;
> +}
> +
> +static inline void slab_post_alloc_hook(struct kmem_cache *s,
> +					struct obj_cgroup *objcg, gfp_t flags,
> +					size_t size, void **p, bool init,
> +					unsigned int orig_size)
> +{
> +	unsigned int zero_size = s->object_size;
> +	bool kasan_init = init;
> +	size_t i;
> +
> +	flags &= gfp_allowed_mask;
> +
> +	/*
> +	 * For kmalloc object, the allocated memory size(object_size) is likely
> +	 * larger than the requested size(orig_size). If redzone check is
> +	 * enabled for the extra space, don't zero it, as it will be redzoned
> +	 * soon. The redzone operation for this extra space could be seen as a
> +	 * replacement of current poisoning under certain debug option, and
> +	 * won't break other sanity checks.
> +	 */
> +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
> +	    (s->flags & SLAB_KMALLOC))
> +		zero_size = orig_size;
> +
> +	/*
> +	 * When slub_debug is enabled, avoid memory initialization integrated
> +	 * into KASAN and instead zero out the memory via the memset below with
> +	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
> +	 * cause false-positive reports. This does not lead to a performance
> +	 * penalty on production builds, as slub_debug is not intended to be
> +	 * enabled there.
> +	 */
> +	if (__slub_debug_enabled())
> +		kasan_init = false;
> +
> +	/*
> +	 * As memory initialization might be integrated into KASAN,
> +	 * kasan_slab_alloc and initialization memset must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 *
> +	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
> +	 */
> +	for (i = 0; i < size; i++) {
> +		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
> +		if (p[i] && init && (!kasan_init ||
> +				     !kasan_has_integrated_init()))
> +			memset(p[i], 0, zero_size);
> +		kmemleak_alloc_recursive(p[i], s->object_size, 1,
> +					 s->flags, flags);
> +		kmsan_slab_alloc(s, p[i], flags);
> +	}
> +
> +	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> +}
> +
>  /*
>   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
>   * have the fastpath folded into their functions. So no function call
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 

