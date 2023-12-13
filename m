Return-Path: <cgroups+bounces-942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4292811938
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 17:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68236B21094
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700633CF5;
	Wed, 13 Dec 2023 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/fVA5eV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED24DC
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 08:24:44 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so826512766b.0
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702484683; x=1703089483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al1zKwXigK+nr1dOO4pE4If7myxOPnenyXHtJYZlzFs=;
        b=d/fVA5eVOdfYQ08nQMGjzalwVF4uNqpTXQ26HlB2EnzHRYI2V/FAsFFJiNHG7JhH1d
         fShDe1u0rP/xIm62tiSWY44mdnObC0HQENAJ552L+TvfEablFn4KCUxH4pDZy1k92ZH3
         /dtxxbeMQ8W8TToe0wc2oORmUdLHa+HprRFn+giku909nl65v3nEwmCVyNssM2YS1LXb
         LAyaPvFLba4rF1xmXiAWvHQ26s2ouKxwagJHnjLLoW0O2+v7qa5/O/lN+sRLlApL5gdU
         gi62/4jzTItcHBrVb1H9BQdiFNz/a3BjSCubrcFZ3u5jVg55kYI8g+E4Qhg9tuFozznA
         beog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484683; x=1703089483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al1zKwXigK+nr1dOO4pE4If7myxOPnenyXHtJYZlzFs=;
        b=U2nxQliFRyviRwWEcC18b1J0xoG6t1RZDsWCMVOu/vPJWd6uNglu2CWvdLnxr0XRPB
         TNUGKWYdOgl/iWlOHtiEzLD9F8MqHECYuIFJD4uP2iklRAHAXs72x5yZOiHD+N9gvqmr
         b7Je6KaArCO6DdUqwntAaCKGP9nKHMwFW2GBZjKFpmw+GGNVJw9MrUT5x6Bk34jgw8bd
         Hn9J+ymAwYqnA8fmnTp4ONRwhkCE2Hn+p38yY2Dq0DWoh10HIrcPEdoFGF5EsWsKdta0
         Y8KF6EZJnjr31MzkA4pk3kaouMI0fa7Cm8lyyq/vmfs0rKllNOYhw7ydg2zAKMKeum1N
         yoiA==
X-Gm-Message-State: AOJu0YziGKhpFhKg+DhWUlUhUiY8TDNy/S0v9+vi3GPjVesGHKvfpAlv
	8B0OXnY6PTgAFLQDZOdBFv/+KTwR4UIGU5lIZwd7J7CE785VZo3sgDw=
X-Google-Smtp-Source: AGHT+IGOke13BHo246dTv/nWj/BacYfS2uYRf/2nfvEJ8VMhG8JoarSP8I2l04n8k0DFmc+MGdMyMXGGjWFJYaEIxXY=
X-Received: by 2002:a17:907:7287:b0:a19:a1ba:8ce5 with SMTP id
 dt7-20020a170907728700b00a19a1ba8ce5mr4891437ejc.131.1702484683075; Wed, 13
 Dec 2023 08:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org> <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org> <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org>
In-Reply-To: <ZXnabMOjwASD+RO9@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Dec 2023 08:24:04 -0800
Message-ID: <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 8:23=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Dec 13, 2023 at 07:42:44AM -0800, Yosry Ahmed wrote:
> > On Wed, Dec 13, 2023 at 7:38=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 07:08:52AM -0800, Yosry Ahmed wrote:
> > > > On Wed, Dec 13, 2023 at 7:01=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Wed, Dec 13, 2023 at 01:04:14PM +0000, Yosry Ahmed wrote:
> > > > > > memcg_kmem_uncharge_page() is an inline wrapper around
> > > > > > __memcg_kmem_uncharge_page() that checks memcg_kmem_online() be=
fore
> > > > > > making the function call. Internally, __memcg_kmem_uncharge_pag=
e() has a
> > > > > > folio_memcg_kmem() check.
> > > > > >
> > > > > > The only direct user of __memcg_kmem_uncharge_page(),
> > > > > > free_pages_prepare(), checks PageMemcgKmem() before calling it =
to avoid
> > > > > > the function call if possible. Move the folio_memcg_kmem() chec=
k from
> > > > > > __memcg_kmem_uncharge_page() to memcg_kmem_uncharge_page() as
> > > > > > PageMemcgKmem() -- which does the same thing under the hood. No=
w
> > > > > > free_pages_prepare() can also use memcg_kmem_uncharge_page().
> > > > >
> > > > > I think you've just pessimised all the other places which call
> > > > > memcg_kmem_uncharge_page().  It's a matter of probabilities.  In
> > > > > free_pages_prepare(), most of the pages being freed are not accou=
nted
> > > > > to memcg.  Whereas in fork() we are absolutely certain that the p=
ages
> > > > > were accounted because we accounted them.
> > > >
> > > > The check was already there for other callers, but it was inside
> > > > __memcg_kmem_uncharge_page(). IIUC, the only change for other calle=
rs
> > > > is an extra call to compound_head(), and they are not hot paths AFA=
ICT
> > > > so it shouldn't be noticeable.
> > >
> > > How can you seriously claim that fork() is not a hot path?
> >
> > It's only called in fork() when an error happens. It's normally called
> > when a process is exiting.
>
> process exit is also a hot path.  at least, there have been regressions
> reported that it's "too slow".

I doubt an extra compound_head() will matter in that path, but if you
feel strongly about it that's okay. It's a nice cleanup that's all.

