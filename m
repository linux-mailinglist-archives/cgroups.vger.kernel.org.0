Return-Path: <cgroups+bounces-503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA37F342C
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D53B21B48
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52038DE1;
	Tue, 21 Nov 2023 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzxB0nT8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF6100;
	Tue, 21 Nov 2023 08:47:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bde80aad05so4518816a12.2;
        Tue, 21 Nov 2023 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700585235; x=1701190035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pN2u4fGcywnuJpGPzQlph9Q+P1Toihu44zlYs+cFFQ=;
        b=DzxB0nT8p4NyIUu5ZtyBP5LEh8DnTN2KVJL5FLUCbVf5q5ovC7zgcJol4TBTRCXb2o
         7SSQlDq9vPWcYSkWsk141E+Vmm4w+Hnwd1nOMkd0RKZEa2SIhsd+oXaU3QqB4VGkCTIU
         5nQhZW/+dmG/p0L8f6+AlaFXwVxAdJx5nsGXAxt1JNiQF+8cHcndF0T9MagiDsMc47cT
         Bdi4sQubI5zt+eGRlU18z9tkzmiLUZTGZYS9O1tYFCbancpswn66M4zh1FmcnqSQI6Sm
         1ET82DcJGjh/6bY8GQ2T193dPEPm3Dgt04/K6TWeqWMXTVUwuZp/ovQw5H2q0nctmVEv
         MpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700585235; x=1701190035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pN2u4fGcywnuJpGPzQlph9Q+P1Toihu44zlYs+cFFQ=;
        b=a3ig5k9fgIlUoWRhFi57mhhjeldpHY6Oc48+r44lVN/y/ATw7HzrKFCv32rXJ47NSk
         gcGS5P19PqTYDE0ZFlc5l7i1P3Oeq2Tn3PI+23oWNd7xJM7jd/J2G08oHeto46TIQH7G
         KLKvmxiwNSLotlqgjW3biw6I6hB6PvCkuI3a2CnChwHipLkJMwvHfHFpNAYoZhTpVjnX
         3XaOFGOxUY8Dqa31U29o++Wdd5vOl/aZBXHo75cHoyZd39Aw5SyZi/M9MNsRuzX5IRZw
         YjQHaVZ0Z59w5KyT8vZwGDn9Fr2BW04u6Cj9WXBsYKGn+KWBwPnpQyWx8HG5uZkgdgnA
         FUww==
X-Gm-Message-State: AOJu0YxjBnNYLaFsLgR0/L6eoFjsYwPbT/JA4mD0IiSH7FPiqRNnuHjD
	tPZsQtAEpb0tfRFZIJvW5FD7zToPA5gWOXBL2DM=
X-Google-Smtp-Source: AGHT+IEgB8wdH50KpUTsCwM7hxb8hnHbggXC75EKjN4In3uMlNFDFNmIEv3gFB7XElvbm6ezJrT/0+1/Sj7dKS+3aBM=
X-Received: by 2002:a17:90a:4411:b0:280:18bd:ffe7 with SMTP id
 s17-20020a17090a441100b0028018bdffe7mr9875785pjg.48.1700585234819; Tue, 21
 Nov 2023 08:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz> <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 21 Nov 2023 17:47:03 +0100
Message-ID: <CA+fCnZdwLn_h3rsamXZMPcjcvqY3TwDmd+3gRUtjkfEad445Nw@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] KASAN: remove code paths guarded by CONFIG_SLAB
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 7:34=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
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
> @@ -153,10 +153,6 @@ void __kasan_poison_object_data(struct kmem_cache *c=
ache, void *object)
>   * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
>   *    accessed after being freed. We preassign tags for objects in these
>   *    caches as well.
> - * 3. For SLAB allocator we can't preassign tags randomly since the free=
list
> - *    is stored as an array of indexes instead of a linked list. Assign =
tags
> - *    based on objects indexes, so that objects that are next to each ot=
her
> - *    get different tags.
>   */
>  static inline u8 assign_tag(struct kmem_cache *cache,
>                                         const void *object, bool init)
> @@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *cach=
e,
>         if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return init ? KASAN_TAG_KERNEL : kasan_random_tag();
>
> -       /* For caches that either have a constructor or SLAB_TYPESAFE_BY_=
RCU: */
> -#ifdef CONFIG_SLAB
> -       /* For SLAB assign tags based on the object index in the freelist=
. */
> -       return (u8)obj_to_index(cache, virt_to_slab(object), (void *)obje=
ct);
> -#else
>         /*
> -        * For SLUB assign a random tag during slab creation, otherwise r=
euse
> +        * For caches that either have a constructor or SLAB_TYPESAFE_BY_=
RCU,
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
> @@ -373,8 +373,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t=
 flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t=
 flags);
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
> @@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, str=
uct kmem_cache *cache)
>  {
>         void *object =3D qlink_to_object(qlink, cache);
>         struct kasan_free_meta *meta =3D kasan_get_free_meta(cache, objec=
t);
> -       unsigned long flags;
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_save(flags);
>
>         /*
>          * If init_on_free is enabled and KASAN's free metadata is stored=
 in
> @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, stru=
ct kmem_cache *cache)
>         *(u8 *)kasan_mem_to_shadow(object) =3D KASAN_SLAB_FREE;
>
>         ___cache_free(cache, object, _THIS_IP_);
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_restore(flags);
>  }
>
>  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cach=
e)
>
> --
> 2.42.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Very nice to see SLAB-induced complexity being gone :)

Thank you!

