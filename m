Return-Path: <cgroups+bounces-4547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2B96346F
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 00:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166261C23DAD
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253551AC429;
	Wed, 28 Aug 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyTo2tSg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E4167D97
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883098; cv=none; b=U8M3Y8vJhB9MZx3DVwguJ5h3EESkRAn6NKDCCX3QnabNSxMOe6BQ3qZy7SQomRHKiOS8HtqrnYBoH7qZ2VMsFwMou2OPprMYvOGMrV+tfyW2+sVOpgIuzUl3E4Qvgosf8JBhs51rndUXCoiqMI3HpNL8qazfJG+UB/aeyFoOBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883098; c=relaxed/simple;
	bh=+4ZR8TmNP149UNg/rEkmkqbp5wBf3ItFGqtlod4sc+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrBOWhHHgEXp5Yp2kDYCxrIAOffi6XArPGjHMOiGJfLLZg5fXobhZBAQ3ICDSbX/YF+0CfwEvKDF0Tsyq5rK4j4nYYatt/TLIGkLpGn5MgzuufaFtP51wDKUvVO6Ghv9t5kkAjHIg4VfKT1gbq1pKuDBArbuBoy6fwYRypJ+vMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyTo2tSg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-534366c1aa2so6367726e87.1
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724883095; x=1725487895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cedSdGJF8fk6JLURCpMr14nIZjcEqUjClDXhK33nqo=;
        b=YyTo2tSgVStr9F/JLEqOAdUV+waOFlrRgKZ5jb4SP1FR1/PosaVWu2CmELsKVuUGtm
         eqVVhZoP4FvKkIUuxFYNufGYgkJskZ1K0hIJMbuYRyh9+SDAXYBZCgQiiDfIXRmKenvc
         4YXPkWJxBqcvh5nXF0UEHLvDe+XULXk6jbCZc50d8gBK8SESeFuVYBk7ELqdKWls9jyQ
         yFlaQjIe+PGfAL/EoTmGlbHCF5gcxCiWfuJOenAT/H9LCdQ0mF8Ri/OT//RBZ0vPIyJB
         HML75JkwFeNGdwt8aqGet5vUypAydbDjt0SDAYcsWSJpvxLzn0qudiLKJ13a+KfwpvOS
         qBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724883095; x=1725487895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cedSdGJF8fk6JLURCpMr14nIZjcEqUjClDXhK33nqo=;
        b=JOq9LQltqnyRt/L/IKQ9UFm0rdezA6QyZWOyTAnHLfavMpOdQ8XnbIrhkLvqapNho3
         hdLVIMnnomd0FuobC6P458OeYEaIoGR2k7/vk2kko2XBb9HKUJV9Nvq8kWOXma4nneNV
         JuwdtJe6fngEV5RNk2srMEQPbU9MIjhZ7ZPTMsRtO/nDaYB+EEofuISn7ZYGn7tnczrY
         B0Xk4BA+jUCxWcBA++5k2m2882oRA+Hfo+7rmCdotYV4uyg1vy5sAfw8IOAvQTUHLTb9
         Lqj0O6J+DhyUYkcmUoDFZT5ArWe44pqjXpEZks7fSPfsiYSLTLxlxBTv0TCndts5xOIg
         ofMw==
X-Forwarded-Encrypted: i=1; AJvYcCUtt9VfVy/u/CvRjEmFBv6PPG3ZxuYb0kHyNfzCUZFnaw24RApWwvdg0cmSY6mY0IvglnvC2VSi@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyvEh3A//GKWaR5mj+Hz7UgD/7oohqfxU26ZNhrzbasRWIdkz
	10GteH8HeEZIENiulAP28HokwHKPf/dWHxkZlXkXU5DuuxgN7znlTzsUYDdFWVh7Ge+QJqw6Znh
	ELZfn+iaE3G4hP6cnjbZMeKhDuIccCJDk5ljz
X-Google-Smtp-Source: AGHT+IE7FgxeEp3oK3h/EHwPYj0Q+GKF27lVD8LDpzLVsN055ZLe7P8ayw7s6FdJcYtn6UQg5NpMNs5TEutsWVNnHFI=
X-Received: by 2002:a05:6512:3d07:b0:533:4191:fa47 with SMTP id
 2adb3069b0e04-5353e5b1135mr381607e87.47.1724883094592; Wed, 28 Aug 2024
 15:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com>
 <pq2zzjvxxzxcqtnf2eabp3whooysr7qbh75ts6fyzhipmtxjwf@q2jw57d5qkir>
 <CAJD7tka_OKPisXGDO56WMb6sRnYxHe2UDAh14d6VX1BW2E3usA@mail.gmail.com> <zjvmhbfzxpv4ujc5v7c4aojpsecmaqrznyd34lukst57kx5h43@2necqcieafy5>
In-Reply-To: <zjvmhbfzxpv4ujc5v7c4aojpsecmaqrznyd34lukst57kx5h43@2necqcieafy5>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 15:10:56 -0700
Message-ID: <CAJD7tkZNMsw9NjE8Xh7vDhbbr2p4QPN8C3W4Jpp+-a_OXuhQLQ@mail.gmail.com>
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

On Wed, Aug 28, 2024 at 1:16=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Aug 28, 2024 at 12:42:02PM GMT, Yosry Ahmed wrote:
> > On Wed, Aug 28, 2024 at 12:14=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Aug 27, 2024 at 05:34:24PM GMT, Yosry Ahmed wrote:
> > > > On Tue, Aug 27, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > [...]
> > > > > +
> > > > > +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> > > > > +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> > > > > +
> > > > > +static __fastpath_inline
> > > > > +bool memcg_slab_post_charge(void *p, gfp_t flags)
> > > > > +{
> > > > > +       struct slabobj_ext *slab_exts;
> > > > > +       struct kmem_cache *s;
> > > > > +       struct folio *folio;
> > > > > +       struct slab *slab;
> > > > > +       unsigned long off;
> > > > > +
> > > > > +       folio =3D virt_to_folio(p);
> > > > > +       if (!folio_test_slab(folio)) {
> > > > > +               return __memcg_kmem_charge_page(folio_page(folio,=
 0), flags,
> > > > > +                                               folio_order(folio=
)) =3D=3D 0;
> > > >
> > > > Will this charge the folio again if it was already charged? It seem=
s
> > > > like we avoid this for already charged slab objects below but not
> > > > here.
> > > >
> > >
> > > Thanks for catchig this. It's an easy fix and will do in v3.
> > >
> > > > > +       }
> > > > > +
> > > > > +       slab =3D folio_slab(folio);
> > > > > +       s =3D slab->slab_cache;
> > > > > +
> > > > > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependen=
cy. */
> > > > > +       if ((s->flags & KMALLOC_TYPE) =3D=3D SLAB_KMALLOC)
> > > > > +               return true;
> > > >
> > > > Would it be clearer to check if the slab cache is one of
> > > > kmalloc_caches[KMALLOC_NORMAL]? This should be doable by comparing =
the
> > > > address of the slab cache with the addresses of
> > > > kmalloc_cache[KMALLOC_NORMAL] (perhaps in a helper). I need to refe=
r
> > > > to your reply to Roman to understand why this works.
> > > >
> > >
> > > Do you mean looping over kmalloc_caches[KMALLOC_NORMAL] and comparing
> > > the given slab cache address? Nah man why do long loop of pointer
> > > comparisons when we can simply check the flag of the given kmem cache=
.
> > > Also this array will increase with the recent proposed random kmalloc
> > > caches.
> >
> > Oh I thought kmalloc_caches[KMALLOC_NORMAL] is an array of the actual
> > struct kmem_cache objects, so I thought we can just check if:
> > s >=3D kmalloc_caches[KMALLOC_NORMAL][0] &&
> > s >=3D kmalloc_caches[KMALLOC_NORMAL][LAST_INDEX]
> >
> > I just realized it's an array of pointers, so we would need to loop
> > and compare them.
> >
> > I still find the flags comparisons unclear and not very future-proof
> > tbh. I think we can just store the type in struct kmem_cache? I think
> > there are multiple holes there.
>
> Do you mean adding a new SLAB_KMALLOC_NORMAL? I will wait for SLAB
> maintainers for their opinion on that. BTW this kind of checks are in
> the kernel particularly for gfp flags.

I meant maybe in new_kmalloc_cache() pass in 'type' to
create_kmalloc_cache() and store it in struct kmem_cache (we'd want a
KMALLOC_NONE a similar for non-kmalloc caches). Having a new flag like
SLAB_KMALLOC_NORMAL would also work.

Or maybe using the flags to deduce the kmalloc cache type is fine, but
in this case I think a well-documented helper that takes in a
kmem_cache and restores a type based on the combination of flags would
be better.

I just think in this case it's easy for the flags to change from under
us here, and the code is not very clear.

Hopefully the slab maintainers will tell us what they think here, my
concerns could very possibly be unfounded.

