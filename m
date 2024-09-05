Return-Path: <cgroups+bounces-4722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950C096E15A
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 19:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C827288013
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18155155C87;
	Thu,  5 Sep 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+JbIhZE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826750276
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558570; cv=none; b=sdijwn/cz/7jsWA9KR+kPeD9NGOZYlOW87Q2cKGXsQZNBHUCnbQEAnpHdzmwtgXp4vx59h88Nhe2rtJP7deMgNuFh75/g9jkGGHCfZr+YKYnR4N020at/Uu0bAHUBVoLN4BKb7De1IbO+ncw2ITxUKnZ2nd4CrJevad9BQPbvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558570; c=relaxed/simple;
	bh=rMKw4DJ2B0mGyZLDAry6m6mhmpTC2VYS+VPm4FG1qng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g22lCEgNoKBA5Ds+PbeavnA/+gUM+jIYFyerVkMRIWkhQcjnUyWT3TAkG1qjJqPs0rYg9O+oX5reNdpD4ranYNSaLJBxlZY77Aubgvm/P9s0/X8ZJgRLSIJZMQ25SdBg2apRERx+c4qyVQ5hM0qjtfJr2B97t2N/gLEOO+Wrycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+JbIhZE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so1327430a12.0
        for <cgroups@vger.kernel.org>; Thu, 05 Sep 2024 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725558567; x=1726163367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVYNP0AQu042AEwsGYdloOFpH9oJC7m5TbfPp6Jpayo=;
        b=d+JbIhZErXUFMlGpBJBx9i321bNwzvalA2POceoezB+xvGmA809H++hQrdc9nbw7p0
         Azo/KXMf8XYYEKM4CAxtKptEt81J93UjGEkxEqK/ntIdUF1gmtUOoyxJ4MBEWJLZRxkn
         OTafUA9aPXvIi5qKtKFOgcnwyapTRnP0HvfhYoq8opC3TWEuEu7kjM5F+XpJVWvbWWCN
         t9bl6dhrlWLPMSA+lCsK2WHH/rZQNVToNWTFsGsgYfd1YKA06R/HqNWVTtVwrXIYjptp
         Mk7USuNzDFILwta7aRb5+jWBD2t5vUGAP8kAlHxUtIPV2CYSpiaqVkGZ1axe8Bv/wQch
         B9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725558567; x=1726163367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVYNP0AQu042AEwsGYdloOFpH9oJC7m5TbfPp6Jpayo=;
        b=dC5vMwgfFbEZUe/nqiVbmS3XrcYuWOhCbV32BRj4uYgpvWrWBtvTlmLnPtIuHB8eO3
         R5tu8cg3eJ6/xGFszxGCi2VoDYnbvWWdIG527jfHvU9E4D+Adwbt703JMeCmTESTpxDA
         q3jYbT86W8Zf58u8Zp9UXwnlP40+avGXviRikKo6WC7iNzCT2EdPYXD4HiDxitC//vyo
         R6injdLY4tLXXHQhSS29KW6vjGFiidgY7rt9D1uH5fg1JbBXs19d1L7xha9pyv7wVCc0
         9H3dnqhAeZmZctpZe6c0vJZIX1azQw4Xmbsrk7WzVROWYTo8rPBbO1bVwQd0o/HKgqW7
         6ZKg==
X-Forwarded-Encrypted: i=1; AJvYcCWDAhFj5MzzfNUawM7cihWHK0VZwuQkGD/sB/c8gSc9222CtUH5fUoQM1DiPSoQDEvdtaH3PHd1@vger.kernel.org
X-Gm-Message-State: AOJu0YznExJyJ9QKMuU7DIuSFpHTYuQ9pUy9TxeJ/9GHqA3R8tknrFEb
	+EPKWG11qo7tafKV5AAvz/7fXcPkP4Y/nje1Mj87BSGBZrXQLZJsFpnnW9zMoydTWWTOPkF1R7d
	I+oMkCp7WgeDN25jwVV2JsOdXAv7gmjOrPg9c
X-Google-Smtp-Source: AGHT+IEfNLWW62TaMg5qGWyYeeDzZZuPeTlQviiykA3/jU7E+9ffcuRDoTd9QZGyOXuUZ94JUsT/UVkIa63AKbXh/Fo=
X-Received: by 2002:a17:907:2d8e:b0:a7a:b73f:7584 with SMTP id
 a640c23a62f3a-a897f92014bmr1810017566b.34.1725558566082; Thu, 05 Sep 2024
 10:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
In-Reply-To: <20240905173422.1565480-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 10:48:50 -0700
Message-ID: <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:34=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> At the moment, the slab objects are charged to the memcg at the
> allocation time. However there are cases where slab objects are
> allocated at the time where the right target memcg to charge it to is
> not known. One such case is the network sockets for the incoming
> connection which are allocated in the softirq context.
>
> Couple hundred thousand connections are very normal on large loaded
> server and almost all of those sockets underlying those connections get
> allocated in the softirq context and thus not charged to any memcg.
> However later at the accept() time we know the right target memcg to
> charge. Let's add new API to charge already allocated objects, so we can
> have better accounting of the memory usage.
>
> To measure the performance impact of this change, tcp_crr is used from
> the neper [1] performance suite. Basically it is a network ping pong
> test with new connection for each ping pong.
>
> The server and the client are run inside 3 level of cgroup hierarchy
> using the following commands:
>
> Server:
>  $ tcp_crr -6
>
> Client:
>  $ tcp_crr -6 -c -H ${server_ip}
>
> If the client and server run on different machines with 50 GBPS NIC,
> there is no visible impact of the change.
>
> For the same machine experiment with v6.11-rc5 as base.
>
>           base (throughput)     with-patch
> tcp_crr   14545 (+- 80)         14463 (+- 56)
>
> It seems like the performance impact is within the noise.
>
> Link: https://github.com/google/neper [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

LGTM from an MM perspective with a few nits below. FWIW:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
> v3: https://lore.kernel.org/all/20240829175339.2424521-1-shakeel.butt@lin=
ux.dev/
> Changes since v3:
> - Add kernel doc for kmem_cache_charge.
>
> v2: https://lore.kernel.org/all/20240827235228.1591842-1-shakeel.butt@lin=
ux.dev/
> Change since v2:
> - Add handling of already charged large kmalloc objects.
> - Move the normal kmalloc cache check into a function.
>
> v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@lin=
ux.dev/
> Changes since v1:
> - Correctly handle large allocations which bypass slab
> - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
>
> RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@li=
nux.dev/
> Changes since the RFC:
> - Added check for already charged slab objects.
> - Added performance results from neper's tcp_crr
>
>
>  include/linux/slab.h            | 20 ++++++++++++++
>  mm/slab.h                       |  7 +++++
>  mm/slub.c                       | 49 +++++++++++++++++++++++++++++++++
>  net/ipv4/inet_connection_sock.c |  5 ++--
>  4 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..68789c79a530 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -547,6 +547,26 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache =
*s, struct list_lru *lru,
>                             gfp_t gfpflags) __assume_slab_alignment __mal=
loc;
>  #define kmem_cache_alloc_lru(...)      alloc_hooks(kmem_cache_alloc_lru_=
noprof(__VA_ARGS__))
>
> +/**
> + * kmem_cache_charge - memcg charge an already allocated slab memory
> + * @objp: address of the slab object to memcg charge.
> + * @gfpflags: describe the allocation context
> + *
> + * kmem_cache_charge is the normal method to charge a slab object to the=
 current
> + * memcg. The objp should be pointer returned by the slab allocator func=
tions
> + * like kmalloc or kmem_cache_alloc. The memcg charge behavior can be co=
ntroller

s/controller/controlled

> + * through gfpflags parameter.
> + *
> + * There are several cases where it will return true regardless. More
> + * specifically:
> + *
> + * 1. For !CONFIG_MEMCG or cgroup_disable=3Dmemory systems.
> + * 2. Already charged slab objects.
> + * 3. For slab objects from KMALLOC_NORMAL caches.
> + *
> + * Return: true if charge was successful otherwise false.
> + */
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
>  void kmem_cache_free(struct kmem_cache *s, void *objp);
>
>  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> diff --git a/mm/slab.h b/mm/slab.h
> index dcdb56b8e7f5..9f907e930609 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -443,6 +443,13 @@ static inline bool is_kmalloc_cache(struct kmem_cach=
e *s)
>         return (s->flags & SLAB_KMALLOC);
>  }
>
> +static inline bool is_kmalloc_normal(struct kmem_cache *s)
> +{
> +       if (!is_kmalloc_cache(s))
> +               return false;
> +       return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACC=
OUNT));
> +}
> +
>  /* Legal flag mask for kmem_cache_create(), for various configurations *=
/
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..3f2a89f7a23a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2185,6 +2185,41 @@ void memcg_slab_free_hook(struct kmem_cache *s, st=
ruct slab *slab, void **p,
>
>         __memcg_slab_free_hook(s, slab, p, objects, obj_exts);
>  }
> +
> +static __fastpath_inline
> +bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +       struct slabobj_ext *slab_exts;
> +       struct kmem_cache *s;
> +       struct folio *folio;
> +       struct slab *slab;
> +       unsigned long off;
> +
> +       folio =3D virt_to_folio(p);
> +       if (!folio_test_slab(folio)) {
> +               return folio_memcg_kmem(folio) ||

If the folio is charged user memory, we will still double charge here,
but that would be a bug. We can put a warning in this case or use
folio_memcg() instead to avoid double charges in that case as well.

> +                       (__memcg_kmem_charge_page(folio_page(folio, 0), f=
lags,
> +                                                 folio_order(folio)) =3D=
=3D 0);
> +       }
> +
> +       slab =3D folio_slab(folio);
> +       s =3D slab->slab_cache;
> +
> +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */

Is it possible to point to the commit that has the explanation here?
The one you pointed me to before? Otherwise it's not really obvious
where the circular dependency comes from (at least to me).

> +       if (is_kmalloc_normal(s))
> +               return true;
> +
> +       /* Ignore already charged objects. */
> +       slab_exts =3D slab_obj_exts(slab);
> +       if (slab_exts) {
> +               off =3D obj_to_index(s, slab, p);
> +               if (unlikely(slab_exts[off].objcg))
> +                       return true;
> +       }
> +
> +       return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
> +}
> +
>  #else /* CONFIG_MEMCG */
>  static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
>                                               struct list_lru *lru,
> @@ -2198,6 +2233,11 @@ static inline void memcg_slab_free_hook(struct kme=
m_cache *s, struct slab *slab,
>                                         void **p, int objects)
>  {
>  }
> +
> +static inline bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +       return true;
> +}
>  #endif /* CONFIG_MEMCG */
>
>  /*
> @@ -4062,6 +4102,15 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cach=
e *s, struct list_lru *lru,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
>
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags)
> +{
> +       if (!memcg_kmem_online())
> +               return true;
> +
> +       return memcg_slab_post_charge(objp, gfpflags);
> +}
> +EXPORT_SYMBOL(kmem_cache_charge);
> +
>  /**
>   * kmem_cache_alloc_node - Allocate an object on the specified node
>   * @s: The cache to allocate from.
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 64d07b842e73..3c13ca8c11fb 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -715,6 +715,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct =
proto_accept_arg *arg)
>         release_sock(sk);
>         if (newsk && mem_cgroup_sockets_enabled) {
>                 int amt =3D 0;
> +               gfp_t gfp =3D GFP_KERNEL | __GFP_NOFAIL;
>
>                 /* atomically get the memory usage, set and charge the
>                  * newsk->sk_memcg.
> @@ -731,8 +732,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct =
proto_accept_arg *arg)
>                 }
>
>                 if (amt)
> -                       mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
> -                                               GFP_KERNEL | __GFP_NOFAIL=
);
> +                       mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp=
);
> +               kmem_cache_charge(newsk, gfp);
>
>                 release_sock(newsk);
>         }
> --
> 2.43.5
>
>

