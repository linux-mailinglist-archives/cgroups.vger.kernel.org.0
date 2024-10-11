Return-Path: <cgroups+bounces-5102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F199AD50
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2024 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5170282512
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365741D0492;
	Fri, 11 Oct 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC4d/Rm7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B2191F6A;
	Fri, 11 Oct 2024 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676919; cv=none; b=fTS+gQg50mmTnebswkTCJf9gEPFe2oTJscqdE9pjc/8JvX4B1mg4Y2RsG8Zzg8lsYUkYeMJnydk5p5m8xWQGu5snMV0imk6W8gShRR37HBAI8o1CDk4uRafmLish4pSjxfDR8pvjklesqjMOd7RvNbG6bBXcSc+Gj6ai6mjFKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676919; c=relaxed/simple;
	bh=u6x2F7kYxJShqouov78lhe2rWSGhzJklLDRR2FLJ5gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvR726EPgWN3H8xxEDANwc8CTARBo7gkaChA0aFc10ZXsQ4iDKqhZ+XQWYm2JvaU5y+NqOtUFtgeacBVP+biHtslyCOSb+Mn/6fWe4Na9EENQyxMAmiyc7FuzMOrWqHV3o+BqNwkIBVP/Y3Xx7lGQi74tOrQEldKQzFMcLOzvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC4d/Rm7; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e290222fdd0so2227012276.2;
        Fri, 11 Oct 2024 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676916; x=1729281716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFTSYYgQTrjqFPb7GzXc8fohdEBdKKLzVr+J+gh04vg=;
        b=GC4d/Rm7b+VB4OqduEVn7uqGp5FdA72F3MmFWtzYeQFjmLa7duYajoIHgwqOYeURPP
         WBGo1MIkxRpHHm9+f3Uu2rgk5Z1oXmINgOVifbhlSkX8ebZJkNhUOfLn4MVS9rnOGVwV
         hJpWWxNdaPCGeYF6SmTAQVYaF3EEjxBIIdkuFgCSv+Rr4u6BwOe9UgDwMNx4MH8UQMPg
         Ec7tKBJ47559pK3BC4qPtXziHzf7ol611ixhuM9rLn6XfYcHA1gidzUMPFGECmadYUta
         ZyKz0SSYzuVjPMcjxsl492EdYa63usuhjO6goV8BM9aHAvh5SmgAetGn4mceiWABoz0i
         6/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676916; x=1729281716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFTSYYgQTrjqFPb7GzXc8fohdEBdKKLzVr+J+gh04vg=;
        b=ISHWRRftXKOZbrWKosI61j5DPhYkeM1QOV5c+4U8ZMhNsYct13K8XdnhfDR57VgXPX
         +o5Uwz8Xc4js+g97/Qp/1T+iBSHCQSLdKxsnZA5BXJoI4z0IlZ90MPVNcVPYXCroAKtq
         RAabwYlLTkMIELw//7iZSIebAk/udh3NJLvPJqWLpsAaJQ56IYCPnYlp9ZVyxOAQcJeE
         k2v5PsbuVSpO8ff9oU4GKVZlE2EIwd7Ohxg20MNIFQzJjj4CeWbaYw2xnvKtC6bZ2Rcg
         +kM0TutkRVqZ1Ywy+sUPkDzhHZGy72BUuFLaVvCwaYkvFtxY6KramJ5JVYy+tbcNJ94j
         /73w==
X-Forwarded-Encrypted: i=1; AJvYcCWo3NwKTU/F0/4ntbImGCQSvTKglwAaalrsmaRtn6mFxn+JLmD8lDl3Lj+tRLn+B61+RZYRJxZd@vger.kernel.org, AJvYcCXxv2MJc0yPvMkQEebWzv8Ggl3xl6cNj9AEbv251gMf5JgsNN2ZO4cda2eJGXcbtLcw/a/zyfEopTZ53oTf@vger.kernel.org
X-Gm-Message-State: AOJu0YyricV1wSggbz3kzdujB8ZhdcwcwUQeBRrB7ZJHJ2PIq15p37ru
	ROtyhHejI+rmbGfsDE3MH0VrkRjxR3Z+EhN1TIbl4lK/eHueYORypd2dSDj4h/jIhlWwiH0a4z5
	Z2Ltg9v6lr+MA3YSh3nkYIRjsXYE=
X-Google-Smtp-Source: AGHT+IG/JCerRgXDMRDql3rEMdWpBm1gETivW5Hg7kglkNxGoToDxKLr95vvW0A1tkFPsxczILpsmiHG1AtLwVT2fvU=
X-Received: by 2002:a05:690c:670e:b0:6e2:636:d9ee with SMTP id
 00721157ae682-6e3477bae02mr33006157b3.9.1728676916301; Fri, 11 Oct 2024
 13:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240913084453.3605621-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240913084453.3605621-1-jingxiangzeng.cas@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 11 Oct 2024 16:01:45 -0400
Message-ID: <CAKEwX=N104p+yJvZEfG0B4kEURjc6CLzY1NqM09cxDFfHBzdVA@mail.gmail.com>
Subject: Re: [PATCH V2] mm/memcontrol: add per-memcg pgpgin/pswpin counter
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linuszeng@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:21=E2=80=AFAM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Jingxiang Zeng <linuszeng@tencent.com>
>
> In proactive memory reclamation scenarios, it is necessary to estimate th=
e
> pswpin and pswpout metrics of the cgroup to determine whether to continue
> reclaiming anonymous pages in the current batch.  This patch will collect
> these metrics and expose them.

+1 - this is also useful for zswap shrinker enablement, after which an
anon page can be loaded back in either from swap or zswap.
Differentiating these two situations helps a lot with performance
regression diagnostics.

We have host level metrics, but they become less useful when we
combine workloads with different characteristics in the same host.

>
> Link: https://lkml.kernel.org/r/20240830082244.156923-1-jingxiangzeng.cas=
@gmail.com
> Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/memcontrol.c | 2 ++
>  mm/page_io.c    | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6efbfc9399d0..dbc1d43a5c4c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -418,6 +418,8 @@ static const unsigned int memcg_vm_event_stat[] =3D {
>         PGPGIN,
>         PGPGOUT,
>  #endif
> +       PSWPIN,
> +       PSWPOUT,
>         PGSCAN_KSWAPD,
>         PGSCAN_DIRECT,
>         PGSCAN_KHUGEPAGED,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index b6f1519d63b0..4bc77d1c6bfa 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -310,6 +310,7 @@ static inline void count_swpout_vm_event(struct folio=
 *folio)
>         }
>         count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>  #endif
> +       count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
>
> @@ -505,6 +506,7 @@ static void sio_read_complete(struct kiocb *iocb, lon=
g ret)
>                 for (p =3D 0; p < sio->pages; p++) {
>                         struct folio *folio =3D page_folio(sio->bvec[p].b=
v_page);
>
> +                       count_memcg_folio_events(folio, PSWPIN, folio_nr_=
pages(folio));
>                         folio_mark_uptodate(folio);
>                         folio_unlock(folio);
>                 }
> @@ -588,6 +590,7 @@ static void swap_read_folio_bdev_sync(struct folio *f=
olio,
>          * attempt to access it in the page fault retry time check.
>          */
>         get_task_struct(current);
> +       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>         count_vm_event(PSWPIN);
>         submit_bio_wait(&bio);
>         __end_swap_bio_read(&bio);
> @@ -603,6 +606,7 @@ static void swap_read_folio_bdev_async(struct folio *=
folio,
>         bio->bi_iter.bi_sector =3D swap_folio_sector(folio);
>         bio->bi_end_io =3D end_swap_bio_read;
>         bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> +       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>         count_vm_event(PSWPIN);

Not related to this patch, but why does the global stats not take into
account large folios here... `count_vm_event(PSWPIN);`?

Acked-by: Nhat Pham <nphamcs@gmail.com>

