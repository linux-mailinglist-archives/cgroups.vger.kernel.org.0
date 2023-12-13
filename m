Return-Path: <cgroups+bounces-949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC0812021
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 21:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A431F21872
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 20:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8486068290;
	Wed, 13 Dec 2023 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB0BN5Q8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B4A3
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:42:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0b40bb704so34295ad.0
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702500129; x=1703104929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc9oGz4PPngc6hvAUNgglWjHUohHzdG22g5pc1epW4k=;
        b=TB0BN5Q8dBsxiXRAjJ9GB1Hgel1KbGnc2Bpm1IQbpsIRxHgbHu0cBQFGjnMp4JMVMc
         /QUYfGwt+JpDVrpAFKtpDWwONWiWqkYAZwGShkH4dcik+qK4wht2uWLMPVM4YaH6mAlZ
         GUImBFNee+LsfuDoV0eaR+3kBfd059/s4lDZeTCoWji5wmM9RYDiMyGc/U4dWZY7TnNY
         HkAjQNXW6Hc9Hasi7P4XmjlrklUpVwDmmQK3erjtmUPh3MwJIB+0yHPn5YHdN9iocY8z
         7zPrewkuyT9P2u1gtXEKoayZpkYbewrP0Bjkni/011N+UrONP8BKTIzbhg8F4YDAxmkj
         GAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702500129; x=1703104929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc9oGz4PPngc6hvAUNgglWjHUohHzdG22g5pc1epW4k=;
        b=WDY3QcXk6l4Hp1NwrtCbOGIznhJXoM4terPGh7PZhwEYYRA53Fy0FNj5BOet/I1JVJ
         lzJ6uknb2gu2CmTM3C4CYx4G+mv7ZPH4vGYAeW2Ptvvy0vHlcuROVaAaYfZg8VXaFGx3
         cTSws+zrNqFkNnrLjiw3k1ZRHItv8XjKEnAF/6pReSdj3F8d7hedGHu1ByOAtfeRvg9B
         S0dSx8gMvKUnCErYtu8BxLtGWhS+yD51alamXF1Vriu1sH6e+f1K/7mHfsNLOwFfG+ah
         Bt+5qJADZT7DBMEHcSLwVH5BADH0DVvenxZdQmBB351qoogp/LEpix19TBU/kqYHLEuW
         xiBQ==
X-Gm-Message-State: AOJu0YyWuV22hJWRmIplmlfXTFtvwKgxhnJ7R/gW5qLwY77At0JkK3LW
	h01Eq6nGjEjnxnhh+3jmmGkUyjPJo4BS5Olc2Ab5lg==
X-Google-Smtp-Source: AGHT+IHQ54ciaQGCcxy69sZ2YanjchNAwTBoM18gxTFg282eqf3eggBQDf06UgHTKmLuEqahWSIJITA82qoIIrjNUKU=
X-Received: by 2002:a17:902:c407:b0:1cf:dbef:79c9 with SMTP id
 k7-20020a170902c40700b001cfdbef79c9mr1296915plk.2.1702500128776; Wed, 13 Dec
 2023 12:42:08 -0800 (PST)
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
In-Reply-To: <ZXoTmwIiBoeLItlg@casper.infradead.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 13 Dec 2023 12:41:57 -0800
Message-ID: <CALvZod7bGiQvEGjiDcKeFFDhdTkAr18rK+20orLX+vCkK4WUUA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:27=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> > On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > > On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > > > I doubt an extra compound_head() will matter in that path, but if=
 you
> > > > > feel strongly about it that's okay. It's a nice cleanup that's al=
l.
> > > >
> > > > i don't even understand why you think it's a nice cleanup.
> > >
> > > free_pages_prepare() is directly calling __memcg_kmem_uncharge_page()
> > > instead of memcg_kmem_uncharge_page(), and open-coding checks that
> > > already exist in both of them to avoid the unnecessary function call
> > > if possible. I think this should be the job of
> > > memcg_kmem_uncharge_page(), but it's currently missing the
> > > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).
> > >
> > > So I think moving that check to the wrapper allows
> > > free_pages_prepare() to call memcg_kmem_uncharge_page() and without
> > > worrying about those memcg-specific checks.
> >
> > There is a (performance) reason these open coded check are present in
> > page_alloc.c and that is very clear for __memcg_kmem_charge_page() but
> > not so much for __memcg_kmem_uncharge_page(). So, for uncharge path,
> > this seems ok. Now to resolve Willy's concern for the fork() path, I
> > think we can open code the checks there.
> >
> > Willy, any concern with that approach?
>
> The justification for this change is insufficient.  Or really any change
> in this area.  It's fine the way it is.  "The check is done twice" is
> really weak, when the check is so cheap (much cheaper than calling
> compound_head!)

I think that is what Yosry is trying i.e. reducing two calls to
page_folio() to one in the page free path.

