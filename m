Return-Path: <cgroups+bounces-1110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2382910A
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 00:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B01B23D8C
	for <lists+cgroups@lfdr.de>; Tue,  9 Jan 2024 23:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B103E492;
	Tue,  9 Jan 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRDd3Gmz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04863E483
	for <cgroups@vger.kernel.org>; Tue,  9 Jan 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so9005e9.1
        for <cgroups@vger.kernel.org>; Tue, 09 Jan 2024 15:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704844493; x=1705449293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8TS1nLrUKAIFkkWa3SxEx8yDQZVgIO6/irtFJFIovg=;
        b=fRDd3Gmz+q4QVgB9cK9jFwrWYbFNR1wbJQP7XGWDQgwcpVjyPO4OWeX4B3MA04wlR6
         nVRrJZT+ireW+2dwHo5eiNzYHfqVMSeh2/fGcX0haBHLT01dS83XH6ldP2O8HDxALIww
         7pqm80vFJL+ZFqnTbzSTbFVBar3/mq7F5NFnKrAqoiFGkALB4sFNw8Mmvsb8FKNpytDc
         V4/LVK7A00ycnUVoGrKGGsFA7+KpH6dQC9OtFH8YETm6MTvSCufZH56xWex5Lfxxit90
         fsPwFViVw0NVrtxkg+RHpjUR2JABfA/WpzXOUYCC2j/vevLWAkj5BRAd2ap6etZDtuk2
         xCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844493; x=1705449293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8TS1nLrUKAIFkkWa3SxEx8yDQZVgIO6/irtFJFIovg=;
        b=SxbphYW5oZC+aQYKXBN50F8uxgOFIuAjl8vRto7Fx0A7Qgf745/jMsRtZklLD9u59L
         lDm5s5hGaYlZ6Mdvo7ytedewfcD4ORvswbqtnk3TyMzQ00yslTs9CZUMBWL2QjyMyquk
         K9NLRJsXH0BGdpLEAmbHVaEOgMqAWPDsSg45kgJM6EVVOrRvAXjBsR82LIAELA6eGl3k
         houJlt0Oo8x32OjcVH/Z9yp3rcD2iB0ewgjnKBJRnW/Z1/OTypyY9BbnnSOt+3iIL7ii
         ATimKQFhcumhbpM8BcsiLZTgkfWpfPCd7SjoSxRmdtHR/CEwapr9EWEa81DrXdDjLezk
         USgA==
X-Gm-Message-State: AOJu0YwQWnl4ryCU1xpvSk81dvXtPlPe1ivXpBEy/zDZTCau4be/Ud00
	DbxhN2e+8sujLMoSWlDNbN6xJ7EDCx11EXti0qLGztdRmgHR
X-Google-Smtp-Source: AGHT+IHnVyCz6SSfqCzYFM+Jm12othHqlyx9vavQpdTKez22yrHgvpFo4duCvDoolAcTA2kj8bvDBtUqSdv5GmLPHQM=
X-Received: by 2002:a05:600c:5118:b0:40d:887b:6979 with SMTP id
 o24-20020a05600c511800b0040d887b6979mr102042wms.0.1704844492708; Tue, 09 Jan
 2024 15:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com> <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>
 <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN> <ZZYE36e0BFFzi0X3@google.com> <ZZZw5NSEFNYwbjZM@tiehlicka>
In-Reply-To: <ZZZw5NSEFNYwbjZM@tiehlicka>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 9 Jan 2024 16:54:15 -0700
Message-ID: <CAOUHufbEuAWwz-51tq6OB7SPJ8W3UJ9Roq2-yXesWAbmzstdKw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, David Rientjes <rientjes@google.com>, 
	Chris Li <chrisl@kernel.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:48=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-01-24 18:07:43, Yu Zhao wrote:
> > On Wed, Jan 03, 2024 at 01:19:59PM -0500, Dan Schatzberg wrote:
> > > On Wed, Jan 03, 2024 at 10:19:40AM -0700, Yu Zhao wrote:
> > > [...]
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index d91963e2d47f..394e0dd46b2e 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -92,6 +92,11 @@ struct scan_control {
> > > > >         unsigned long   anon_cost;
> > > > >         unsigned long   file_cost;
> > > > >
> > > > > +#ifdef CONFIG_MEMCG
> > > > > +       /* Swappiness value for proactive reclaim. Always use sc_=
swappiness()! */
> > > > > +       int *proactive_swappiness;
> > > > > +#endif
> > > >
> > > > Why is proactive_swappiness still a pointer? The whole point of the
> > > > previous conversation is that sc->proactive can tell whether
> > > > sc->swappiness is valid or not, and that's less awkward than using =
a
> > > > pointer.
> > >
> > > It's the same reason as before - zero initialization ensures that the
> > > pointer is NULL which tells us if it's valid or not. Proactive reclai=
m
> > > might not set swappiness and you need to distinguish swappiness of 0
> > > and not-set. See this discussion with Michal:
> > >
> > > https://lore.kernel.org/linux-mm/ZZUizpTWOt3gNeqR@tiehlicka/
> >
> >  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> >                               size_t nbytes, loff_t off)
> >  {
> >         struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> >         unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
> >         unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
> > +       int swappiness =3D -1;
> > ...
> >                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> >                                         min(nr_to_reclaim - nr_reclaime=
d, SWAP_CLUSTER_MAX),
> > -                                       GFP_KERNEL, reclaim_options);
> > +                                       GFP_KERNEL, reclaim_options,
> > +                                       swappiness);
> >
> > ...
> >
> > +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *m=
emcg)
> > +{
> > +       return sc->proactive && sc->proactive_swappiness > -1 ?
> > +              sc->proactive_swappiness : mem_cgroup_swappiness(memcg);
> > +}
>
> Tpo be completely honest I really fail to see why this is such a hot
> discussion point. To be completely clear both approaches are feasible.

Feasible but not equal.

> The main argument for NULL check based approach is that it is less error
> prone from an incorrect ussage because any bug becomes obvious.

Any bug becomes *fatal*, and fatal isn't only obvious but also hurts
in production systems.

This was the reason for going through the trouble switching from
VM_BUG_ON() to VM_WARN_ON() and documenting it in
Documentation/process/coding-style.rst:

22) Do not crash the kernel
---------------------------

In general, the decision to crash the kernel belongs to the user, rather
than to the kernel developer.

Isn't?

> If we
> use any other special constant a missing initialization would be much
> harder to spot because they would be subtle behavior change.
>
> Are there really any strong arguments to go against this "default
> initialization is safe" policy?

Just wanted to point out an alternative. Fine details (best practices)
matter to me.

