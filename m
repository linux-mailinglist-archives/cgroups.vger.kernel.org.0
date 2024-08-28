Return-Path: <cgroups+bounces-4535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A109961B1A
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 02:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A63284A9F
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E1F9DA;
	Wed, 28 Aug 2024 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpFXbt7v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A215C0
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805306; cv=none; b=dSug8+nX8ponW2/lFrlhdHcoY1RPOwUMYzUYsB+9OZoJEszHwfdRzHWP9MMksKTeh9smOAhK47XvVz++qIvhENBclNebZwxVh/NqjxF4qr7+ssoANGU3Gapz1Kxz4wm2LBthQ/+fE+a+zETBrhMxsa5sxiFdFFgQhL4kv8tZ2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805306; c=relaxed/simple;
	bh=6YjiHox6u5IbI1Zb77dnRL8o5s4bfJZg94KyueuhQiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2rfsP71Nr9DfC9Add1pp0Qmx5GExUepxQoEj3EzfbCt4r879Dt43FYv82FPBXQ+C4ES8gE8Zpc3vclkIGZNMPRdF2pKEQCaZ+ja8hrbdcZHvE8B+hrVQwLaZOLIr+Zvsy4AnhYFJ+JgEBU4AyKF+C+o1xRlzG2C/m7hqDbaFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpFXbt7v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a868b8bb0feso672386966b.0
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724805303; x=1725410103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoNZj1Tzs8pIk5fCddWb5c9E+5Cyp9MArkhioMCWS+Q=;
        b=WpFXbt7vnOFHfk5KAO6AUrYaIHX56aU8eYdimrDf2BZrGAeqrRX7QtzgRTfDrCnkim
         t3VQZApogoSoPqXMGRiKd2qjir9LJNRLw6x8OQRnual1BtQeV+652arRLzKZ45MAiNLv
         XH03+MU7dQz8QPdCpdKSgQowmnDOsADYAZs+x1n5QArBi/OkZ3AaI2eJSmZBJhjJS/Ju
         o8ciOXKkGEjGNIIpD/BC+rMUjYx6PgSZCGAEIFQqcR2BQkxpB0TZ2SUI9Oq0tfvChUIR
         Z9Zmq9VsVtqQFDTURagy868smzzTrE8lkv8DMTqSVklGtJzYk0Tllxk9MOdqiCsmiA9l
         93Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724805303; x=1725410103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoNZj1Tzs8pIk5fCddWb5c9E+5Cyp9MArkhioMCWS+Q=;
        b=PKoJxOC1/1AucGL19uCSCtxUX4tlUkw4XeXFGKzpV3ibKqk7GkgeHqX2+9CapRLmu7
         csfruBcpf4JF4YGeDkl1sW9YgHCG5Gq+p7F+OQ+CwXusIw8ny9NpnoYJsqK94AJ32Ylu
         97D6MOADwdxdW1Afy9fs9lnGi1icA82SXuDYJ/5IKysrcK04DfWbVp5bLNqWFV9gWca+
         ktVeUETXscVZYWaW3E06J0kkFykOgElUwyhDLgq3IhzgRhTrYzXjXnVYJX2tMFzbP+QK
         R6w/JoDgl44PglkLSmxX9v1uoWQrjVZLWb2CciCO5noJS6GR/2HTcCHjKxXXuA7Xwkn3
         MnAw==
X-Forwarded-Encrypted: i=1; AJvYcCVqRyzrRz6QANBqh17T4DV3K6RlQb6dc9ISxajb1QKOKhM+qnsonVrpcznVFxR1kaFRsopGTCJW@vger.kernel.org
X-Gm-Message-State: AOJu0YzPelvd9zpHbv7/mxe5QjA8pahN22GOqIIpBuXuMmmb8HnQVJTy
	vtU+TVi9peIJKuz6feEVeEOxWV5NVNnboFNhYLejPAuevgr7J3TOoXPGtjerizdeARE2Is3qQX8
	v6Ii36Fx2ACbUJSvxla8ufw3GRqsrV75kUqq5
X-Google-Smtp-Source: AGHT+IHIj2cLav5dpbM+Cpe/D+ZzgGmKVOFHTITkPd4YOoOS6J2co1BmJ1zu0pnWibkwcipD4nXhtpS5TFUpOcWVL6E=
X-Received: by 2002:a17:907:f75e:b0:a86:ae0a:a52a with SMTP id
 a640c23a62f3a-a870ab00478mr31261766b.55.1724805302001; Tue, 27 Aug 2024
 17:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
In-Reply-To: <20240827235228.1591842-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 27 Aug 2024 17:34:24 -0700
Message-ID: <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
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
> ---
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
>  include/linux/slab.h            |  1 +
>  mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
>  net/ipv4/inet_connection_sock.c |  5 ++--
>  3 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..05cfab107c72 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *=
s, struct list_lru *lru,
>                             gfp_t gfpflags) __assume_slab_alignment __mal=
loc;
>  #define kmem_cache_alloc_lru(...)      alloc_hooks(kmem_cache_alloc_lru_=
noprof(__VA_ARGS__))
>
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
>  void kmem_cache_free(struct kmem_cache *s, void *objp);
>
>  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..8265ea5f25be 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2185,6 +2185,43 @@ void memcg_slab_free_hook(struct kmem_cache *s, st=
ruct slab *slab, void **p,
>
>         __memcg_slab_free_hook(s, slab, p, objects, obj_exts);
>  }
> +
> +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
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
> +               return __memcg_kmem_charge_page(folio_page(folio, 0), fla=
gs,
> +                                               folio_order(folio)) =3D=
=3D 0;

Will this charge the folio again if it was already charged? It seems
like we avoid this for already charged slab objects below but not
here.

> +       }
> +
> +       slab =3D folio_slab(folio);
> +       s =3D slab->slab_cache;
> +
> +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> +       if ((s->flags & KMALLOC_TYPE) =3D=3D SLAB_KMALLOC)
> +               return true;

Would it be clearer to check if the slab cache is one of
kmalloc_caches[KMALLOC_NORMAL]? This should be doable by comparing the
address of the slab cache with the addresses of
kmalloc_cache[KMALLOC_NORMAL] (perhaps in a helper). I need to refer
to your reply to Roman to understand why this works.

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
> @@ -2198,6 +2235,11 @@ static inline void memcg_slab_free_hook(struct kme=
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
> @@ -4062,6 +4104,15 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cach=
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

