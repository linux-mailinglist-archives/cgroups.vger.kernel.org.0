Return-Path: <cgroups+bounces-405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816907EAF99
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEFC2811BF
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0F3D978;
	Tue, 14 Nov 2023 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGCuizFk"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DA3D3BC
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 12:01:29 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD0F1
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:01:28 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49369d29be3so2524188e0c.3
        for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699963287; x=1700568087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+cNKD/DZD2lkmgn//C/a4VZOCUEay1a0fxR4tTnP1Y=;
        b=hGCuizFkQJDvUZM8SlED/YrkZ5wzev7JTsJNC93J48EK6Gp4Y3AzhWfaaxAH6jgEfH
         FNcYFV+Uxmy4UGcqI5zf3qVeEvCnSLWmrluJM/cFkp3FXxgutjX7jujp2Oh1Vw3JPfr3
         MneCNJ9tzqysS3x0E3V8yI0eSamvHgMKj/tUpoaUpWgfbnW2OkKpChN0zJhc25ilO7B6
         AuJvYc5wEFWZeEU1XDMYMawMxhbnbKPcv1MnqRD9cS/osoqIrbxc0JgYMy8U07q3Jf0p
         ezzTSI+rSKp5wmuD1Q4Bf7VNwhdJ+AWLhBHrLcA/8c3adlxqlp1GxSUBJJlK27/vgoPM
         Ad7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699963287; x=1700568087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+cNKD/DZD2lkmgn//C/a4VZOCUEay1a0fxR4tTnP1Y=;
        b=VPePVG5wMx8es1lVhPfUBGNRE4mLBWbi6JtFhYDtaSEiCWxqlrudUP8tp9FpYP5dfy
         NFQbbNKlq2t9DLPvlDB04NQ5H33Ng5/Lg+VVQY40ltICL1Y93WaS5vEWzOLdf0qSz+s0
         SIOOj4W27ReO1GMFyMaE2kh45I32YYzlgzAHFlK+o9cGLVXGZYCX2dYXyggAQPPSuYaJ
         1+Zn6Fis6SS3s/+88tAhSHUqVzel0Z59/sw4cPCmxt62xzQf1ZTtch9MZzbITEhVZIhQ
         kgVDG/8H6RSFvfRUWMgzfJBp3V/yPcIcLBb7gTTRX67pHw4wo8D8scX3ESvKMxWVWFpX
         n2IQ==
X-Gm-Message-State: AOJu0YzsmCIm6RCbBU6cOJEavdaTl/PyEAydrmUS/Ulcw7uCAp8eFlWj
	0UMYFJhS5j96WzVoySy2n020i6jr+PcopQHL62d0Uw==
X-Google-Smtp-Source: AGHT+IGdPTgrNucIG+Lo6vRM+7FUzSZPC0zMXelLtqwy0mDzkjNg/l2YT2+nTW9YrVKzffzwqrRySMvvW/+/It1UJuA=
X-Received: by 2002:a05:6122:1689:b0:4ac:593b:e9f4 with SMTP id
 9-20020a056122168900b004ac593be9f4mr9715321vkl.9.1699963287127; Tue, 14 Nov
 2023 04:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113191340.17482-22-vbabka@suse.cz> <20231113191340.17482-24-vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-24-vbabka@suse.cz>
From: Marco Elver <elver@google.com>
Date: Tue, 14 Nov 2023 13:00:00 +0100
Message-ID: <CANpmjNOy+K_jBkaZ9_+He9tT83PaYLama517YvQ1TH13ayg3vg@mail.gmail.com>
Subject: Re: [PATCH 02/20] KASAN: remove code paths guarded by CONFIG_SLAB
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> With SLAB removed and SLUB the only remaining allocator, we can clean up
> some code that was depending on the choice.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Marco Elver <elver@google.com>

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
>                                         const void *object, bool init)
> @@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>         if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return init ? KASAN_TAG_KERNEL : kasan_random_tag();
>
> -       /* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
> -#ifdef CONFIG_SLAB
> -       /* For SLAB assign tags based on the object index in the freelist. */
> -       return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
> -#else
>         /*
> -        * For SLUB assign a random tag during slab creation, otherwise reuse
> +        * For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU,
> +        * assign a random tag during slab creation, otherwise reuse
>          * the already assigned tag.
>          */
>         return init ? kasan_random_tag() : get_tag(object);
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
> -       (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
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
>         void *object = qlink_to_object(qlink, cache);
>         struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> -       unsigned long flags;
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_save(flags);
>
>         /*
>          * If init_on_free is enabled and KASAN's free metadata is stored in
> @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>         *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
>
>         ___cache_free(cache, object, _THIS_IP_);
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_restore(flags);
>  }
>
>  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
> --
> 2.42.1
>

