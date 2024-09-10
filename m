Return-Path: <cgroups+bounces-4789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140709728E4
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 07:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B70A28672B
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 05:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1E1531F8;
	Tue, 10 Sep 2024 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQQ6FZWa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E241219F3;
	Tue, 10 Sep 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946108; cv=none; b=e2xlj0aTC+7vDOQoad2uJtA99IIRTRvf5jYKJ7ZM5zY1koVSiXQAOT2Dyi7iE9yqzwkfo8MLwovhmFaCkHPCjAQ/kdq15G3O22X3d3/5qh/b0IEOSa4LAiC6FSgVJ/Xgyp5CsjaEFN78F6IiXq0cN5ZFXfEJ1fIqeT20gf6FCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946108; c=relaxed/simple;
	bh=ktL/zXqluwR3xNUIiQy6A8Sj7fy3cC0Lipvmmp2ANVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKBTD0jNqy9q0tsd7zzOspecnQ/ww/DS+z7Wah0VWDjBzLA/O3tQcLXIIl36CFKnqs1jWey6uG6ep/a6RiS50fCYW2AIFhcLZmu/de4+lOpUSQ+59t0Ee8KHlqmoCO7ey8yeE7GXcsg1+wBdDa4wSRu7ZeNY5VwpUj0LTEtVMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQQ6FZWa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717934728adso3718331b3a.2;
        Mon, 09 Sep 2024 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725946107; x=1726550907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYE1wOTrhsQmso9EDO49bYQfX0h+ApJkIr4QBsuXRhs=;
        b=DQQ6FZWa6B73iGIjatRSdbX+Zny3Kb9jx6e3I1zHIwe4nnG8LIbH4VWE/s0qc33PW/
         VsdDMnR5uKFSUHh0YhgrRD1srX6f0oVkWLAeRR49Q92WSgcBwerbephnvwXDwx1jkDnc
         qSqFWRY8m6E7wDfBfjbodNuuAqyyKf/jbOGglYTez6poaywTRZVlkQDqmf8RmZQbHPz9
         1QfPV1j8Vz+1MGW2gvjjmgsA2CD8devwylxJL4HnzVOm4OOr9T9P5jpNnP5EOlfDzemv
         XwGkTd+32AxnfPtOdARQ/TpCJvgMu2zbJWgMdv9LmMkrphQRsPrEhxEAlBxk+K/GbX/q
         SKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946107; x=1726550907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYE1wOTrhsQmso9EDO49bYQfX0h+ApJkIr4QBsuXRhs=;
        b=bEN5L22ZPSM5JbqyNYRs0EnAxwrKV754+l+UkbXy/BeGy6nJGvIMhFLw1lWf/W1384
         HYkiPZP7ZTDOyhQ7QmXaDKksj+OnfP2fm9tyT+NeG+hMd7ntm8rczt3mfUSMPZ61k/hd
         ukiNa2WZyUglPcsNy/OHR0TSJpNUySYbgUvMA040c7/jjRDT89jVIofkLHs2qgZdpp1I
         E/OeU6ZarfqCfH1sonhqHKKB/UxxNhu65H7WEl8uje30QeCtww29BBpcn0UNisGxnUWq
         ajUBnk0rbNnrmSbZD7ACBLWaJ8swqCZWbtFwZ37Ui3V0MHrWPBR6bbGvRkNiBlTIbIK+
         k5LA==
X-Forwarded-Encrypted: i=1; AJvYcCWw9qNnYfhYR+FGp1JZX5cA+AihRW9SCH5IG3QgTpZP2DB7PvP1RgO59vfDGhZvmolcx1B7kQPl@vger.kernel.org, AJvYcCXw5QUwPESDv3o9VMBwnQXVxLezudR1GOUKxIMisucIMuUP8LkIp1G2aPDA3qpampPElgcUGjoZ/wJyfZ57@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qAk+n1G3Nnor11Femxdlztx1SqwVPR6TLVT5qaMIov7p8blu
	QxQIEl4gBxdknduQgEXylWk+nULJ1WnBUMq6T3wFWM3Dc5Q9qzU2H9+pObSv9fyWUNtJ4q2eVAN
	fgfbKeCaN840zaux369uCElPYAxsDThuR
X-Google-Smtp-Source: AGHT+IHRbCXMg8gaubCG92lOyYR9i+NdeacENJhKZWLfl4jKuGQK/aQEpTjCQOJmLCCCxXeVGddTAIX6sdIEYRGcKG4=
X-Received: by 2002:a05:6a20:c99a:b0:1cf:4c1e:8b53 with SMTP id
 adf61e73a8af0-1cf4c1e8c45mr3702971637.9.1725946106647; Mon, 09 Sep 2024
 22:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com> <CAJD7tkb6320POwiWaSmZFUYRh44_BStwjc2nhL3Wangy1qWYxQ@mail.gmail.com>
In-Reply-To: <CAJD7tkb6320POwiWaSmZFUYRh44_BStwjc2nhL3Wangy1qWYxQ@mail.gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Tue, 10 Sep 2024 13:28:15 +0800
Message-ID: <CAJqJ8ihKy133afN=qTAiYAV3W4ifop+b18PbANVZf3FT-9auzg@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sept 2024 at 06:46, Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Fri, Aug 30, 2024 at 1:23=E2=80=AFAM Jingxiang Zeng
> <jingxiangzeng.cas@gmail.com> wrote:
> >
> > From: Jingxiang Zeng <linuszeng@tencent.com>
> >
> > In proactive memory reclamation scenarios, it is necessary to
> > estimate the pswpin and pswpout metrics of the cgroup to
> > determine whether to continue reclaiming anonymous pages in
> > the current batch. This patch will collect these metrics and
> > expose them.
>
> Could you add more details about the use case?
>
> By "reclaiming anonymous pages", do you mean using memory.reclaim with
> swappiness=3D200?

Yes.
>
> Why not just use PGPGOUT to figure out how many pages were reclaimed?
> Do you find a significant amount of file pages getting reclaimed with
> swappiness=3D200?
>

Currently, it's not possible to know the swap out situation of a
cgroup, and the
PGPGOUT metric, which includes the reclaim count of file pages and
anonymous pages, cannot accurately reflect the swap out situation.
> >
> > Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> > ---
> >  mm/memcontrol-v1.c | 2 ++
> >  mm/memcontrol.c    | 2 ++
> >  mm/page_io.c       | 4 ++++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index b37c0d870816..44803cbea38a 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] =3D =
{
> >  static const unsigned int memcg1_events[] =3D {
> >         PGPGIN,
> >         PGPGOUT,
> > +       PSWPIN,
> > +       PSWPOUT,
>
> memory.reclaim is not exposed in cgroup v1, so assuming these are only
> used for such proactive reclaim, we don't need to add them here.

Your point makes sense. I will remove these fields in the v2 version.
>
> >         PGFAULT,
> >         PGMAJFAULT,
> >  };
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 087a8cb1a6d8..dde3d026f174 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -418,6 +418,8 @@ static const unsigned int memcg_vm_event_stat[] =3D=
 {
> >         PGPGIN,
> >         PGPGOUT,
> >  #endif
> > +       PSWPIN,
> > +       PSWPOUT,
> >         PGSCAN_KSWAPD,
> >         PGSCAN_DIRECT,
> >         PGSCAN_KHUGEPAGED,
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index b6f1519d63b0..4bc77d1c6bfa 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -310,6 +310,7 @@ static inline void count_swpout_vm_event(struct fol=
io *folio)
> >         }
> >         count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
> >  #endif
> > +       count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio))=
;
> >         count_vm_events(PSWPOUT, folio_nr_pages(folio));
> >  }
> >
> > @@ -505,6 +506,7 @@ static void sio_read_complete(struct kiocb *iocb, l=
ong ret)
> >                 for (p =3D 0; p < sio->pages; p++) {
> >                         struct folio *folio =3D page_folio(sio->bvec[p]=
.bv_page);
> >
> > +                       count_memcg_folio_events(folio, PSWPIN, folio_n=
r_pages(folio));
> >                         folio_mark_uptodate(folio);
> >                         folio_unlock(folio);
> >                 }
> > @@ -588,6 +590,7 @@ static void swap_read_folio_bdev_sync(struct folio =
*folio,
> >          * attempt to access it in the page fault retry time check.
> >          */
> >         get_task_struct(current);
> > +       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
> >         count_vm_event(PSWPIN);
> >         submit_bio_wait(&bio);
> >         __end_swap_bio_read(&bio);
> > @@ -603,6 +606,7 @@ static void swap_read_folio_bdev_async(struct folio=
 *folio,
> >         bio->bi_iter.bi_sector =3D swap_folio_sector(folio);
> >         bio->bi_end_io =3D end_swap_bio_read;
> >         bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> > +       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
> >         count_vm_event(PSWPIN);
> >         submit_bio(bio);
> >  }
> > --
> > 2.43.5
> >
> >
>

