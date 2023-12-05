Return-Path: <cgroups+bounces-804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E478048C2
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 05:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C45528157A
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7ED6117;
	Tue,  5 Dec 2023 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkCp/7ns"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA6C3;
	Mon,  4 Dec 2023 20:48:19 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c59ac49f12so1640355241.1;
        Mon, 04 Dec 2023 20:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701751698; x=1702356498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6U7HYB+MMDXs4im/MnwOh3wT6+xRnbqGtkbQLiIJbE=;
        b=NkCp/7ns32k2qkHc2tAWEEGEk4EYBXlUlVXG5Y5LTzzGG8dgXuy0LxjAhhyhPkuynO
         A8/M1EA4NP+VACv5tTXUM2pUJ6DL9fzkEExHhnaOHJnLFgJHjc8Yz8QbtTrfr7xlqLS7
         7xmzYNvqyk4li1rmX5agcGXzVdW1Af/YcsuFX0tEypuXFl85RCLAd0YO0Xhmmuneb6g0
         MP6tmGXMn9QIv1HbZXx4wojrks20qnxkSMMUGJTr7VpCHY3pChzJ9ALltQ2/BfQkIU6h
         BelxxYy06rNx3rl9Ec6Cpdrcj3EzZEtpvB/b6Xg/vwhlYuW8F8NICE8Gn/+imwagksRz
         w6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701751698; x=1702356498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6U7HYB+MMDXs4im/MnwOh3wT6+xRnbqGtkbQLiIJbE=;
        b=hpMN6rK0O2R2/vtGGQrqVWYOpy9yYlJHARslctbWR3zdwkUWbrdFsnE2C+2foizLm3
         IB/vehAzh+uTv6B0kAeQIMVAJvda35ibtO6G3OS1jLyOtDzp+kQh2oY+acQPRiFjo1a5
         FgMiJ9XCdE2TuKA8N4p5jS9liOCSkDMMGd/hvNVppvOUYtoOQa+XjXNu73/mshfYE0al
         Nf1ux0lQkA1lz+rQk7M5gpPBUB7oVXL+zB0QyTXondaRIKdIBqzu1oB+9XfGM/rnHfCt
         4T+PY/AMosJ8KfaWerlTSJSmuvkTslnnrpd72vaXsPJfwjw06N7PpUh6jcG8C6AU3e4I
         RCQA==
X-Gm-Message-State: AOJu0YzSoeRYidf27rgOeYMNUplsgSChFdz10dLWBQdmTKmiHKzQ5TTg
	ReEIuQ+98y86RddGDyJnj0lUEHHAft+/SbUboHM=
X-Google-Smtp-Source: AGHT+IHhiPX7qYso93UYGFEAvtKnVFmjurUEPV8H0b76lJVRAkF5m5mLg9HHSDTrpxGGrM2rareCQf4N1EafMBxIQN0=
X-Received: by 2002:a05:6102:2dc:b0:464:77f1:f34e with SMTP id
 h28-20020a05610202dc00b0046477f1f34emr651042vsh.28.1701751698506; Mon, 04 Dec
 2023 20:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz> <ZW6mjFlmm0ME18OQ@localhost.localdomain>
In-Reply-To: <ZW6mjFlmm0ME18OQ@localhost.localdomain>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 5 Dec 2023 13:48:07 +0900
Message-ID: <CAB=+i9R+zZo-AGuEAYDzEZV7f=YSC9fdczARQijk-WPZUr0iDA@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] KASAN: remove code paths guarded by CONFIG_SLAB
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:27=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com> =
wrote:
>
> On Mon, Nov 20, 2023 at 07:34:14PM +0100, Vlastimil Babka wrote:
> > With SLAB removed and SLUB the only remaining allocator, we can clean u=
p
> > some code that was depending on the choice.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/kasan/common.c     | 13 ++-----------
> >  mm/kasan/kasan.h      |  3 +--
> >  mm/kasan/quarantine.c |  7 -------
> >  3 files changed, 3 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 256930da578a..5d95219e69d7 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -153,10 +153,6 @@ void __kasan_poison_object_data(struct kmem_cache =
*cache, void *object)
> >   * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can b=
e
> >   *    accessed after being freed. We preassign tags for objects in the=
se
> >   *    caches as well.
> > - * 3. For SLAB allocator we can't preassign tags randomly since the fr=
eelist
> > - *    is stored as an array of indexes instead of a linked list. Assig=
n tags
> > - *    based on objects indexes, so that objects that are next to each =
other
> > - *    get different tags.
> >   */
> >  static inline u8 assign_tag(struct kmem_cache *cache,
> >                                       const void *object, bool init)
> > @@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *ca=
che,
> >       if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
> >               return init ? KASAN_TAG_KERNEL : kasan_random_tag();
> >
> > -     /* For caches that either have a constructor or SLAB_TYPESAFE_BY_=
RCU: */
> > -#ifdef CONFIG_SLAB
> > -     /* For SLAB assign tags based on the object index in the freelist=
. */
> > -     return (u8)obj_to_index(cache, virt_to_slab(object), (void *)obje=
ct);
> > -#else
> >       /*
> > -      * For SLUB assign a random tag during slab creation, otherwise r=
euse
> > +      * For caches that either have a constructor or SLAB_TYPESAFE_BY_=
RCU,
> > +      * assign a random tag during slab creation, otherwise reuse
> >        * the already assigned tag.
> >        */
> >       return init ? kasan_random_tag() : get_tag(object);
> > -#endif
> >  }
> >
> >  void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 8b06bab5c406..eef50233640a 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -373,8 +373,7 @@ void kasan_set_track(struct kasan_track *track, gfp=
_t flags);
> >  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp=
_t flags);
> >  void kasan_save_free_info(struct kmem_cache *cache, void *object);
> >
> > -#if defined(CONFIG_KASAN_GENERIC) && \
> > -     (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> > +#ifdef CONFIG_KASAN_GENERIC
> >  bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
> >  void kasan_quarantine_reduce(void);
> >  void kasan_quarantine_remove_cache(struct kmem_cache *cache);
> > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> > index ca4529156735..138c57b836f2 100644
> > --- a/mm/kasan/quarantine.c
> > +++ b/mm/kasan/quarantine.c
> > @@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, s=
truct kmem_cache *cache)
> >  {
> >       void *object =3D qlink_to_object(qlink, cache);
> >       struct kasan_free_meta *meta =3D kasan_get_free_meta(cache, objec=
t);
> > -     unsigned long flags;
> > -
> > -     if (IS_ENABLED(CONFIG_SLAB))
> > -             local_irq_save(flags);
> >
> >       /*
> >        * If init_on_free is enabled and KASAN's free metadata is stored=
 in
> > @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, st=
ruct kmem_cache *cache)
> >       *(u8 *)kasan_mem_to_shadow(object) =3D KASAN_SLAB_FREE;
> >
> >       ___cache_free(cache, object, _THIS_IP_);
> > -
> > -     if (IS_ENABLED(CONFIG_SLAB))
> > -             local_irq_restore(flags);
> >  }
> >
> >  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *ca=
che)
>
> Looks good to me,
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

nit: Some KASAN tests depends on SLUB, but as now it's the only allocator
      KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB); in
      mm/kasan/kasan_test.c can be removed

>
> >
> > --
> > 2.42.1
> >
> >

