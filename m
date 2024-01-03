Return-Path: <cgroups+bounces-1055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338DD8225EC
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 01:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D625E1F22D73
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 00:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895BE37E;
	Wed,  3 Jan 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqpSmB3i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC960364
	for <cgroups@vger.kernel.org>; Wed,  3 Jan 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d41a32effso23755e9.0
        for <cgroups@vger.kernel.org>; Tue, 02 Jan 2024 16:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704241676; x=1704846476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D/ScSo67diCtOm5/uS067tATdpuyW3M9IteQeNMCkw=;
        b=JqpSmB3i0ZnEz+ULTVT8IdFiudtV9vFjgJ8aIWrR3anz0xnFIcQHtPVAMQwAomaHPa
         TCY4wZjvT35xB4UcEhH9ZIhDb+jWpChBHYkEK4jxxF3YfG3qEHxC2Zt1ce8g93Tr7UeL
         0duLITVaAnY4Qr87ScwH8gzN447fTR8icJvqUphyUWriaeJfTQyGfw0TcIXMO1JsfRVg
         iioW2F9+au2bktirWFwNC500zpNy0FBDVcO1f32S6VlSbz0teRC7b42GmxAQ73GVCXl2
         xxFT/lXbKPaybU985Y1LgCt+2Z5XroSQQu9JAhE+Oy1m0FZipHySMafdbXZnoToF0Wrr
         N66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704241676; x=1704846476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D/ScSo67diCtOm5/uS067tATdpuyW3M9IteQeNMCkw=;
        b=huPDWPN9u0G95xT8Hbqsd4ijgkZRtug5iccnu9LlIb97eddmrR3n4AJ/pjD/iVc7EC
         15IhHENjkUoEzBSlymG/FHaJAH9Cafxk2uYuHiqn070TuBT7+nDDc+Tq6J1b/WRhCuAl
         SBZRNZuYzK5fJQwuUAYQ60NUJpEfBUiQSruauwoe9QFewMNsIKjYWooNoTsLrdY0xk+H
         VmvkxydvEzLPnqou7RZXmptF6u8wCOaP91JJPJ4O7ZsIpw9uIJnPBcDNfCRSomqD4al6
         NfmES/7SCBXMHYYrexvGvT2CkwNu7tZepOjQ4+X8hKgCVAPwwHqnH6kmDztOv0B+ob7u
         25NA==
X-Gm-Message-State: AOJu0YxN5YyI5a0hCbesxcBwTaLhB9VNzIHlg3Xh8r42CkYJnyqXI9R1
	d9P2qPijUw2gUJ/K3t1sP5mr/GRpp+Y7OwOhR2utpIIdtlri
X-Google-Smtp-Source: AGHT+IECRhHL8i6EJhapjrPvjjkUFOBxuyxbDGo4rPMdOTQKZfID1ZODqsqG+FaBVNta653qz6jqVW1If/xon1YfzGs=
X-Received: by 2002:a05:600c:354f:b0:40d:87df:92ca with SMTP id
 i15-20020a05600c354f00b0040d87df92camr17552wmq.3.1704241675743; Tue, 02 Jan
 2024 16:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
 <20231220152653.3273778-3-schatzberg.dan@gmail.com> <CAOUHufYwPzZ7k=ecFkxaw+26hUkiTODEnmKM8b3=Lk=n+bm29w@mail.gmail.com>
 <ZZQqCHmocwUFvuTz@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZZQqCHmocwUFvuTz@dschatzberg-fedora-PF3DHTBV>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 2 Jan 2024 17:27:18 -0700
Message-ID: <CAOUHufaTDcLNipHQC3sJuoOVcCkKnmzHt=tiiZrOxmOg5EUVYA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Yue Zhao <findns94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 8:21=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmail=
.com> wrote:
>
> Hi Yu Zhao,
>
> Thanks for the feedback, sorry for the delayed response.
>
> On Thu, Dec 21, 2023 at 10:31:59PM -0700, Yu Zhao wrote:
> > On Wed, Dec 20, 2023 at 8:27=E2=80=AFAM Dan Schatzberg <schatzberg.dan@=
gmail.com> wrote:
> > >
> > > ...
> >
> > The cover letter says:
> > "Previously, this exact interface addition was proposed by Yosry[3]."
> >
> > So I think it should be acknowledged with a Suggested-by, based on:
> > "A Suggested-by: tag indicates that the patch idea is suggested by the
> > person named and ensures credit to the person for the idea."
> > from
> > https://docs.kernel.org/process/submitting-patches.html#using-reported-=
by-tested-by-reviewed-by-suggested-by-and-fixes
>
> Sure, will do.
>
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index d91963e2d47f..aa5666842c49 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -92,6 +92,9 @@ struct scan_control {
> > >         unsigned long   anon_cost;
> > >         unsigned long   file_cost;
> > >
> > > +       /* Swappiness value for reclaim. NULL will fall back to per-m=
emcg/global value */
> > > +       int *swappiness;
> >
> > Using a pointer to indicate whether the type it points to is
> > overridden isn't really a good practice.
> >
> > A better alternative was suggested during the v2:
> > "Perhaps the negative to avoid unnecessary dereferences."
> > https://lore.kernel.org/linux-mm/dhhjw4h22q4ngwtxmhuyifv32zjd6z2relrcjg=
nxsw6zys3mod@o6dh5dy53ae3/
>
> I did have a couple versions with a negative but it creates
> initialization issues where every instantiation of scan_control needs
> to make sure to initialize swappiness or else it will behave as if
> swappiness is 0. That's pretty error prone so using the pointer seemed
> the better approach.
>
> > Since only proactive reclaim can override swappiness, meaning it only
> > happens if sc->proactive is true, I think the best way to make it work
> > without spending much effort is create a helper as Michal suggest but
> > it should look like:
> >
> > sc_swappiness()
> > {
> >   return sc->proactive ? sc->swappiness : mem_cgroup_swappiness(memcg);
> > }
> >
> > In this patchset, sc->swappiness really means
> > sc->proactive_swappiness. So it should be renamed accordingly.
>
> Helper aside, I disagree with this point about coupling with the
> proactive flag.

Sure. But I would like to hear a *concrete* counterexample.

> The fact that the only user currently is proactive
> reclaim

Yes, that's a fact, and we should make the decision based on the
current known facts.

> doesn't imply to me that the interface (in scan_control)
> should be coupled to the use-case.

Future always has its uncertainty which I would not worry so much about.

> It's easier to reason about a
> swappiness field that overrides swappiness for all scans that set it
> regardless of the users.

For example? And how likely would that happen in the next few years?

