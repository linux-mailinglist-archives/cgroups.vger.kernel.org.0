Return-Path: <cgroups+bounces-951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA4812129
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 23:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAF328271D
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630177FBCD;
	Wed, 13 Dec 2023 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yh7wa64J"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EADAC
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 14:05:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1ca24776c3so2225766b.0
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702505112; x=1703109912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpRHgqfJh5BqpeJeGJK+ZkQ/hLtcXMW8feO7FrAZJh4=;
        b=yh7wa64J0FcXJxFDYB6Ct+S1UNfxfXctiY+6ZQtEUmB0iWnwaG4qxF8+3ffUqro5d/
         1mYwikpTD+brEWDYKjuX2kBDxKj/+HpoTc7Mvs76uT4/wmwRAhkwF95smbR4GWzKyF67
         MB4da14gqw90hUgsg0XUYdTo1+kQkylklBmO5+X28V9oW0phEwOTFz8Vp1jckuvToKih
         HbNGVkJ1PKXYg6qgDaQIWJiWu/hDUP4B+ehsv/wwePE187AOtUHpBXq4xO+b0gVpASBR
         HIYy9lYTJsc5wqAA3AwGQwJKXBXopfMk/lzhPpdjhSEBTMmS0yN0JMJ9YFUgeMJifl2j
         VMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505112; x=1703109912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpRHgqfJh5BqpeJeGJK+ZkQ/hLtcXMW8feO7FrAZJh4=;
        b=BJiLvrgbcn5yF/Cgoo1Twp5ht4XmMAjT5rPYvCdqJRyB+y18cToFahuGgQDMYvZqvz
         rK5gqayl/86GlnBSG9y/mNZal3YLudaOUl5fAylJWV3Y5jrFp0qAlbwUcN9F9hKslvbl
         6TvG/UWLAahHNI9lL/vHu3e1OR9ZfHJ2FoEFIxxj0WmuHr19ZiNTm/NNAE+Vots/1teH
         NOu0x0fi7iVGq/Kf3Qgu2PtwzYx2fEGDl1R0BHeBqpu7qM4Nz133q/Nveg4s7zRmShTK
         PhNRPjAAbXzIuYNq9CpQ7RMVPkDe+R4tG30qvPFUzVh3W+jMeoREzfKgdwzzgsYusCg5
         rTSA==
X-Gm-Message-State: AOJu0YzDz9V4Jy64k9MtdysViR5x6m2knQl/CFBv0GlNc6/1Y9OWlxML
	rP7JdXhZ2s3ERyEscg4zM+hMUwdnxMITp/UQJTxPZQ==
X-Google-Smtp-Source: AGHT+IHj0D439xbVDCZV0vxrTEJ/YZrCU4ZbQgr9c1xscQDm2OJvU6/8IvaINH2YDnAjorfuUlFIqdcki5RouAKQ8X0=
X-Received: by 2002:a17:906:8445:b0:a1c:7671:8806 with SMTP id
 e5-20020a170906844500b00a1c76718806mr8942187ejy.0.1702505112434; Wed, 13 Dec
 2023 14:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org> <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org> <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org> <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
 <ZXnbZlrOmrapIpb4@casper.infradead.org> <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
 <20231213202325.2cq3hwpycsvxcote@google.com> <ZXoTmwIiBoeLItlg@casper.infradead.org>
 <CALvZod7bGiQvEGjiDcKeFFDhdTkAr18rK+20orLX+vCkK4WUUA@mail.gmail.com> <CALvZod5X1E6BrT3ErO4OLn3zK__s9c9YQC+yc0T=Tx-gBD3ADQ@mail.gmail.com>
In-Reply-To: <CALvZod5X1E6BrT3ErO4OLn3zK__s9c9YQC+yc0T=Tx-gBD3ADQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Dec 2023 14:04:33 -0800
Message-ID: <CAJD7tkYGwnbBAen_4P7_gAjxwBKCE6XxcMmmcrqJz27vVXSCMA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Shakeel Butt <shakeelb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:58=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 12:41=E2=80=AFPM Shakeel Butt <shakeelb@google.co=
m> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:27=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> > > > On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > > > > On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy@inf=
radead.org> wrote:
> > > > > >
> > > > > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > > > > > I doubt an extra compound_head() will matter in that path, bu=
t if you
> > > > > > > feel strongly about it that's okay. It's a nice cleanup that'=
s all.
> > > > > >
> > > > > > i don't even understand why you think it's a nice cleanup.
> > > > >
> > > > > free_pages_prepare() is directly calling __memcg_kmem_uncharge_pa=
ge()
> > > > > instead of memcg_kmem_uncharge_page(), and open-coding checks tha=
t
> > > > > already exist in both of them to avoid the unnecessary function c=
all
> > > > > if possible. I think this should be the job of
> > > > > memcg_kmem_uncharge_page(), but it's currently missing the
> > > > > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).
> > > > >
> > > > > So I think moving that check to the wrapper allows
> > > > > free_pages_prepare() to call memcg_kmem_uncharge_page() and witho=
ut
> > > > > worrying about those memcg-specific checks.
> > > >
> > > > There is a (performance) reason these open coded check are present =
in
> > > > page_alloc.c and that is very clear for __memcg_kmem_charge_page() =
but
> > > > not so much for __memcg_kmem_uncharge_page(). So, for uncharge path=
,
> > > > this seems ok. Now to resolve Willy's concern for the fork() path, =
I
> > > > think we can open code the checks there.
> > > >
> > > > Willy, any concern with that approach?
> > >
> > > The justification for this change is insufficient.  Or really any cha=
nge
> > > in this area.  It's fine the way it is.  "The check is done twice" is
> > > really weak, when the check is so cheap (much cheaper than calling
> > > compound_head!)
> >
> > I think that is what Yosry is trying i.e. reducing two calls to
> > page_folio() to one in the page free path.
>
> Actually no, there will still be two calls to page_folio() even after
> Yosry's change. One for PageMemcgKmem() and second in
> __memcg_kmem_uncharge_page().
>
> I think I agree with Willy that this patch is actually adding one more
> page_folio() call to the fork code path.

It is adding one more page_folio(), yes, but to the process exit path.

>
> Maybe we just need to remove PageMemcgKmem() check in the
> free_pages_prepare() and that's all.

You mean call memcg_kmem_charge_page() directly in
free_pages_prepare() without the PageMemcgKmem()? I think we can do
that. My understanding is that this is not the case today because we
want to avoid the function call if !PageMemcgKmem(). Do you believe
the cost of the function call is negligible?

