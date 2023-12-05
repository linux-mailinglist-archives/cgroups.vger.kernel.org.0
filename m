Return-Path: <cgroups+bounces-802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6413180488C
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 05:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E75B1F21475
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 04:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EACA78;
	Tue,  5 Dec 2023 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8OlvDFi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F73138;
	Mon,  4 Dec 2023 20:27:17 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d048c171d6so34531685ad.1;
        Mon, 04 Dec 2023 20:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701750436; x=1702355236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECB8bTrkothGumH+K2V0Img+vaTChlA6bV4xhaiY7v4=;
        b=D8OlvDFigxgHKtTeGZZqjyOjVmYZC0mzXRDm/ZDOtsYBcjw6ncFwgvBzaVSuXXi/Pn
         Vy1lpCUwvnkAGi1CT/VJaMJwo/o9mCUgmLjI0Hmy52G70tEekbosqPc5j81tmo6XcJdg
         XbKKc8uguVGaIqw5D94zHht7XCedxsWnhhCGFKa8s2/e3i86iforxK9JQgzeeVPU6bD5
         q/kotz5/npc75Trrz8nhp9Yd+AJzJRymSkL8Y9pN6MK42XXW8g0seLXlcZiT2l7mGQ4s
         ZGM2hkw4pcuvaH0BvOgB5WmEp0GGvoxM5fGfl13l8X/54msIGULVfJCvEkZajl4yWF4d
         Ho3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701750436; x=1702355236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECB8bTrkothGumH+K2V0Img+vaTChlA6bV4xhaiY7v4=;
        b=CEvryTyuCFEkKgpWPGyyRZoRkigXtLXROJpuMKts7AzNn0z2fNpBSeMrFctvweWOn9
         0mhyJhRvIihISWQklV0DZqxhf3ri/eQK/Y+vtov8E64Xpq2r7kW9fiq8KaUQPUi43ZwZ
         Nj3kXpiMb7zguJzFEpUDxI31DBgXvkccWJiGC3AeUhUmuZ09WtqmcM7PztdaAVlxO3Bi
         yKHiqRtaLXRL8eIrS4kVycA769mfRc1aVC9MlzA0ezdH/tz2ppp+rPLxyi1ZKo4yadKQ
         q1le9cFpWeAcrboQcIrIeKa/t7fnE194gk907u/BJ9CSLmi1nXp/cOrgoNb/Fyin7FEm
         iE2w==
X-Gm-Message-State: AOJu0YyonNuuHRIG9vYcJ7rOxsuDmbedVB8+0/xEaTyMEd0171yJ/4kI
	Ko6hfJCM4ZcPCemaV+qvQ3Q=
X-Google-Smtp-Source: AGHT+IGQVjAMROauTKmnu7ClBNGKjAep0qlnJ/ZUCDBqOMhEU2u2uILx5djML1VjxL2tnJ6QPtGYaw==
X-Received: by 2002:a17:903:1109:b0:1d0:6ffd:9e10 with SMTP id n9-20020a170903110900b001d06ffd9e10mr5482369plh.98.1701750436129;
        Mon, 04 Dec 2023 20:27:16 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001d087d2c42fsm3831273ple.24.2023.12.04.20.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 20:27:15 -0800 (PST)
Date: Tue, 5 Dec 2023 13:26:52 +0900
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
Subject: Re: [PATCH v2 03/21] KASAN: remove code paths guarded by CONFIG_SLAB
Message-ID: <ZW6mjFlmm0ME18OQ@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:14PM +0100, Vlastimil Babka wrote:
> With SLAB removed and SLUB the only remaining allocator, we can clean up
> some code that was depending on the choice.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/kasan/common.c     | 13 ++-----------
>  mm/kasan/kasan.h      |  3 +--
>  mm/kasan/quarantine.c |  7 -------
>  3 files changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 256930da578a..5d95219e69d7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -153,10 +153,6 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>   * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
>   *    accessed after being freed. We preassign tags for objects in these
>   *    caches as well.
> - * 3. For SLAB allocator we can't preassign tags randomly since the freelist
> - *    is stored as an array of indexes instead of a linked list. Assign tags
> - *    based on objects indexes, so that objects that are next to each other
> - *    get different tags.
>   */
>  static inline u8 assign_tag(struct kmem_cache *cache,
>  					const void *object, bool init)
> @@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>  	if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>  		return init ? KASAN_TAG_KERNEL : kasan_random_tag();
>  
> -	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
> -#ifdef CONFIG_SLAB
> -	/* For SLAB assign tags based on the object index in the freelist. */
> -	return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
> -#else
>  	/*
> -	 * For SLUB assign a random tag during slab creation, otherwise reuse
> +	 * For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU,
> +	 * assign a random tag during slab creation, otherwise reuse
>  	 * the already assigned tag.
>  	 */
>  	return init ? kasan_random_tag() : get_tag(object);
> -#endif
>  }
>  
>  void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8b06bab5c406..eef50233640a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -373,8 +373,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
>  void kasan_save_free_info(struct kmem_cache *cache, void *object);
>  
> -#if defined(CONFIG_KASAN_GENERIC) && \
> -	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> +#ifdef CONFIG_KASAN_GENERIC
>  bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
>  void kasan_quarantine_reduce(void);
>  void kasan_quarantine_remove_cache(struct kmem_cache *cache);
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index ca4529156735..138c57b836f2 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>  {
>  	void *object = qlink_to_object(qlink, cache);
>  	struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> -	unsigned long flags;
> -
> -	if (IS_ENABLED(CONFIG_SLAB))
> -		local_irq_save(flags);
>  
>  	/*
>  	 * If init_on_free is enabled and KASAN's free metadata is stored in
> @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>  	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
>  
>  	___cache_free(cache, object, _THIS_IP_);
> -
> -	if (IS_ENABLED(CONFIG_SLAB))
> -		local_irq_restore(flags);
>  }
>  
>  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 

