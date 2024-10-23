Return-Path: <cgroups+bounces-5209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE89AD67B
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 23:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF2E283247
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089171C75FA;
	Wed, 23 Oct 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqaULZh9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC261494B3
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718287; cv=none; b=g6VwdUjhsJLC74Kw/RFQrFZzTLULtcFQMfPdavhcib5xSIomdBDLIM66gpEQFlBA32l7fq1cUbr2/ThZb5PJXtt0wY9mWmtkzFIdjWp7AVQ5BYlEIj/aGJh8xHFw4ChDwo09R+uebJcdpRqTc+fWN2lIkrU0Eh6Dc96YNTnxZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718287; c=relaxed/simple;
	bh=frEEGDVQKw+TS2wjJ7qphBh6ozfZuqQ8KPm5Pf0mae0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcZ6ytqRr1cZVsjnHXPe3riLU9WbHnjar3p2qHpYShhs7Zl36xsB2GmdvyBK5g/G4FN6hZ1dpm7bKqFKidHKzvgOZUu3Wyv8k69UUXg/EtRDBvBSJ0Acum443GtkR/SNfHWGjw157FIslWkZIiV0MY2Qp5Ap8YH7GyXnijRGOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqaULZh9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so22455466b.0
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729718284; x=1730323084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilPZyKpGMSsNsbBI7Ldrq3+g45+Wtx6oTSBt1CXk8Jw=;
        b=sqaULZh9omJwSg9K9Vnd+xC2HknwD3mvW9NKKFMUrs1U7ulXyJ5rMEeWSKDsOr0tlf
         LMa37iOG5xlSunxtWxeuAoKmXr2l4CWQh0X5Ppa7MuQLdwlGD9YVu2ooTzxRo2F+xpx7
         u5d2yY3RgmoPzq/lM2/sbKBDTqtiJFDOTs4yl7JBzz57VuOs6cmYO/f8UcrYhZI6HCsU
         eQllSmBbIC2Mq1R21BbVIxSzcE/myXOlhuLynKva92OW47z75QcAuknn3q4QDwS8nsQb
         JTTLe/ZxJ7chVH5bCL7kehoUXWf/rjcwlqyNqNPi4zEMLKtgG0sO2DterIEHggtbIg5q
         vvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718284; x=1730323084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilPZyKpGMSsNsbBI7Ldrq3+g45+Wtx6oTSBt1CXk8Jw=;
        b=xGjkxpT9t8ohh8MHArXIPkMZbx27z35mJ7qwqsJYlBpHI9ZaK71O99jjeMOw28g56z
         7gKPuldpLlLpbkB9KNOK7QygdsPhU9tFOgUoxyVsNxDYeASBllfGldA927h3ceAVEsnc
         2wOd00R49YDruLrV38sLbUpAEwWtFfoolvFfxo66cHiP1otOUBFEvepbLAL5vXsBLrtE
         RtdOZ2RXp9xYUOIxREAQdDipKoGNCNCorA0tzEWWT65Pn82/LPUxGqRy5+Pc6nY/fnXY
         MpBhUgFHIjJVROC0/6ZnVnQ8LmbMshC9YfC/W/0PTAye64ZWGmjwrnVC3hE4FICR8Gpt
         7OzA==
X-Forwarded-Encrypted: i=1; AJvYcCUGiiPaCiuqbL1rNrqtipZUGHSCDzE1Ok+N9z+z7PPN2CUqwLJsLuo5XAfBhNnomaz/pg1wKeG8@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHfvAnbX/SBtHJ/taMAFnpQRdIVfcqPE8+G2RMlp4+2OzAbU9
	nnN1HlpC3JQUgt9KDcbZFyGkVu1Uux9tH+8CDNbTHLOh0Q2AacAkW/kZbYqbnmAFOECdSgqnwyW
	ZhnGQ+DsSVtKPK1e4N07DwYe7MIX90r53bcav
X-Google-Smtp-Source: AGHT+IECOWm3Yov7lMlSQXgYBedqm9/1v0RFtgObG7JV6huGFtF86BSfMOCPQCOc9ANO7XetCql6YGqSweFJzuWOhLc=
X-Received: by 2002:a17:907:6ea9:b0:a99:fbfc:5ff3 with SMTP id
 a640c23a62f3a-a9abf8675damr404573466b.18.1729718283282; Wed, 23 Oct 2024
 14:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com> <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com>
In-Reply-To: <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 23 Oct 2024 14:17:27 -0700
Message-ID: <CAJD7tkak6F4nwZLWxNK8zKN5z6y=0MPCCHwfW7kOVKDmn08Ytg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushcin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	lnyng@meta.com, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:15=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Hi Joshua,
>
> On Wed, Oct 23, 2024 at 1:34=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.=
com> wrote:
> >
> > Changelog
> > v2:
> >   * Enables the feature only if memcg accounts for hugeTLB usage
> >   * Moves the counter from memcg_stat_item to node_stat_item
> >   * Expands on motivation & justification in commitlog
> >   * Added Suggested-by: Nhat Pham
>
> Changelogs usually go at the end, after ---, not as part of the commit
> log itself.
>
> >
> > This patch introduces a new counter to memory.stat that tracks hugeTLB
> > usage, only if hugeTLB accounting is done to memory.current. This
> > feature is enabled the same way hugeTLB accounting is enabled, via
> > the memory_hugetlb_accounting mount flag for cgroupsv2.
> >
> > 1. Why is this patch necessary?
> > Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> > hugeTLB usage to memory.current. However, the metric is not reported in
> > memory.stat. Given that users often interpret memory.stat as a breakdow=
n
> > of the value reported in memory.current, the disparity between the two
> > reports can be confusing. This patch solves this problem by including
> > the metric in memory.stat as well, but only if it is also reported in
> > memory.current (it would also be confusing if the value was reported in
> > memory.stat, but not in memory.current)
> >
> > Aside from the consistentcy between the two files, we also see benefits
>
> consistency*
>
> > in observability. Userspace might be interested in the hugeTLB footprin=
t
> > of cgroups for many reasons. For instance, system admins might want to
> > verify that hugeTLB usage is distributed as expected across tasks: i.e.
> > memory-intensive tasks are using more hugeTLB pages than tasks that
> > don't consume a lot of memory, or is seen to fault frequently. Note tha=
t
>
> are* seen
>
> > this is separate from wanting to inspect the distribution for limiting
> > purposes (in which case, hugeTLB controller makes more sense).
> >
> > 2. We already have a hugeTLB controller. Why not use that?
> > It is true that hugeTLB tracks the exact value that we want. In fact, b=
y
> > enabling the hugeTLB controller, we get all of the observability
> > benefits that I mentioned above, and users can check the total hugeTLB
> > usage, verify if it is distributed as expected, etc.
> >
> > With this said, there are 2 problems:
> >   (a) They are still not reported in memory.stat, which means the
> >       disparity between the memcg reports are still there.
> >   (b) We cannot reasonably expect users to enable the hugeTLB controlle=
r
> >       just for the sake of hugeTLB usage reporting, especially since
> >       they don't have any use for hugeTLB usage enforcing [2].
> >
> > [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.c=
om/
> > [2] Of course, we can't make a new patch for every feature that can be
> >     duplicated. However, since the exsting solution of enabling the
>
> existing*
>
> >     hugeTLB controller is an imperfect solution that still leaves a
> >     discrepancy between memory.stat and memory.curent, I think that it
> >     is reasonable to isolate the feature in this case.
> >
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> You should also CC linux-mm on such patches.

+roman.gushchin@linux.dev

CCing Roman's correct email.

>
> >
> > ---
> >  include/linux/mmzone.h |  3 +++
> >  mm/hugetlb.c           |  4 ++++
> >  mm/memcontrol.c        | 11 +++++++++++
> >  mm/vmstat.c            |  3 +++
> >  4 files changed, 21 insertions(+)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 17506e4a2835..d3ba49a974b2 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -215,6 +215,9 @@ enum node_stat_item {
> >  #ifdef CONFIG_NUMA_BALANCING
> >         PGPROMOTE_SUCCESS,      /* promote successfully */
> >         PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> > +#endif
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +       HUGETLB_B,
>
> Why '_B'?
>
> >  #endif
> >         /* PGDEMOTE_*: pages demoted */
> >         PGDEMOTE_KSWAPD,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 190fa05635f4..055bc91858e4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
> >                                      pages_per_huge_page(h), folio);
> >         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> >                                           pages_per_huge_page(h), folio=
);
> > +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
>
> I think we already have a couple of these checks and this patch adds a
> few more, perhaps we should add a helper at this point to improve
> readability? Maybe something like memcg_accounts_hugetlb()?
>
> > +               lruvec_stat_mod_folio(folio, HUGETLB_B, -pages_per_huge=
_page(h));
> >         mem_cgroup_uncharge(folio);
> >         if (restore_reserve)
> >                 h->resv_huge_pages++;
> > @@ -3094,6 +3096,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_=
struct *vma,
> >         if (!memcg_charge_ret)
> >                 mem_cgroup_commit_charge(folio, memcg);
> >         mem_cgroup_put(memcg);
> > +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
> > +               lruvec_stat_mod_folio(folio, HUGETLB_B, pages_per_huge_=
page(h));
> >
> >         return folio;
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7845c64a2c57..de5899eb8203 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -306,6 +306,9 @@ static const unsigned int memcg_node_stat_items[] =
=3D {
> >  #endif
> >  #ifdef CONFIG_NUMA_BALANCING
> >         PGPROMOTE_SUCCESS,
> > +#endif
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +       HUGETLB_B,
> >  #endif
> >         PGDEMOTE_KSWAPD,
> >         PGDEMOTE_DIRECT,
> > @@ -1327,6 +1330,9 @@ static const struct memory_stat memory_stats[] =
=3D {
> >  #ifdef CONFIG_ZSWAP
> >         { "zswap",                      MEMCG_ZSWAP_B                  =
 },
> >         { "zswapped",                   MEMCG_ZSWAPPED                 =
 },
> > +#endif
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +       { "hugeTLB",                    HUGETLB_B                      =
 },
>
> nit: I think we usually use lowercase letters when naming stats.
>
> >  #endif
> >         { "file_mapped",                NR_FILE_MAPPED                 =
 },
> >         { "file_dirty",                 NR_FILE_DIRTY                  =
 },
> > @@ -1441,6 +1447,11 @@ static void memcg_stat_format(struct mem_cgroup =
*memcg, struct seq_buf *s)
> >         for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
> >                 u64 size;
> >
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +               if (unlikely(memory_stats[i].idx =3D=3D HUGETLB_B) &&
> > +                               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMOR=
Y_HUGETLB_ACCOUNTING))
> > +                       continue;
> > +#endif
> >                 size =3D memcg_page_state_output(memcg, memory_stats[i]=
.idx);
> >                 seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, si=
ze);
> >
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index b5a4cea423e1..466c40cffeb0 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1269,6 +1269,9 @@ const char * const vmstat_text[] =3D {
> >  #ifdef CONFIG_NUMA_BALANCING
> >         "pgpromote_success",
> >         "pgpromote_candidate",
> > +#endif
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +       "hugeTLB",
> >  #endif
> >         "pgdemote_kswapd",
> >         "pgdemote_direct",
> > --
> > 2.43.5
> >
> >

