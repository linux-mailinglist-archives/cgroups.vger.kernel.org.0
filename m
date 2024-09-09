Return-Path: <cgroups+bounces-4780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918DE972569
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 00:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EED1C22D15
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 22:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1918C927;
	Mon,  9 Sep 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NykPSQLU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DE130495
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921980; cv=none; b=it3XxgABObYcQSTkCaI9Fxc9XN8uUyTDFII8CjNKfEevRBCXhF7ZW6oZ7jYulP31Px85i9aCkqIcZJx8Cr9xHNZJz9Jr8ZX+irzCbHZo7hKaV8cZmywaUH7wXwMB4ILomSoJaAxB21jhgtyh8OV89X0Hc1eNht5cu2UfZrhLJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921980; c=relaxed/simple;
	bh=ivV8pT1HPafO5qkP6QSSBMPWoTIZ0Ouk7L0wgC1uFLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pocPSoVY0XwUw5w/lqTr3pvxZaFju8dWrS5tKEuLZauPdLxX9pCzxWwFKBGyhidx6zmpgXuL3P1uaA8+e5uC/eCDdNOctwOftpnb5bbn6vEXSdAshF53vQqPOK+MxhVw1m9Wkv16d0vIMun6nHD9SpimCQij5wp79gx6OKpHsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NykPSQLU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso7332266b.1
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725921977; x=1726526777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+4nk3SFLT9yU/DUYdXVzczQcb969uRly8G5xeotbKQ=;
        b=NykPSQLUiDMWnf5sMrZvBYyeN/mtwQrKhVTZFmei7FQQJj5Sj6dWYvxDO6ikS8NG7P
         SenH8FFoRsbNEkmGW+MXY4BxcCWfAytdB6Z39vg2c22VwS9eTpjpmAkA8ZxecHW+PQqr
         AD6S8pvlvXjSUtPVKW00mEUgsOnsBJqVW9otGGhJjqGqysz5kIQWSNOBHByF1WNCaFaO
         xiJYbMuI2Av2SiiqtIFnD+2F5MVJvuUMQkN2YPVPFMnVP1s8Pp5CMQHKmvMXKtnhC2rg
         ArceGVWJGJXs2xFAyntB/EPiikY1wNXkWzTUD12/DfGw4TZv7KAnBY37VEoWz1Z+plne
         Iz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725921977; x=1726526777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+4nk3SFLT9yU/DUYdXVzczQcb969uRly8G5xeotbKQ=;
        b=UiZYcPs3eAeje6rhJVLn7BpO9i7udeJmxCYZ+HFX2YutiZjf8Rh9BTSiAFxRvNGLT/
         0OoI6pHu3f4ZtSNc8dBdmP32vNf0wKqPrUTUkTcRJ/ZtQ3j8MlqjtcNRL2coKb50p6dG
         MHUMdzI7YRxz+FpaLcTzEB5nCknBs+bZDzH3yoS1rqpuzOgp8NPntoNBrMTkUADCVMm8
         puOdItHuCDzpvLsEf/GfqzujPQ8Jn+FejKeBfAX6ef+glKykMZJQyHMShSpV2XokqIoX
         Q7SXFODrqO8v+k0izpSr66nGlS7lUl34HZ+vrRabzedP9jH9TXC86YJQn1aJErp1VUwX
         9YAA==
X-Forwarded-Encrypted: i=1; AJvYcCVlV+BX9p3g7f4Wfypp+1fhKL/ewlYnzwI2hCvN7wfUU+gFqJ6DQdeaVOWu1GzJShIlpKa0k75n@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYJHRv05SJvbxLdaksHAZt11vPmWG3lC90tQtz1w78ZdJ2m1m
	M2h1heeOaMQ7SHqp8qK7XkCvUV8xSsyus3tV7hqLBsRunFEOI3pC7oizz2K2lEDkGMMjpdJ9iBa
	IlpcO4K6tmnnrmPrbXtOe7CrwFXYkOeeTm9NQ
X-Google-Smtp-Source: AGHT+IE8SJIxL8bgKMRqVhb4TImGa7tJCf1vic0Kcz0oVFDND6rhGcAvC4TZk1H/fFVF2PRs4rnKCc4ZpEELaQ+mrDU=
X-Received: by 2002:a17:906:fe4a:b0:a7a:9fe9:99e7 with SMTP id
 a640c23a62f3a-a8a8885da54mr1045293466b.41.1725921976626; Mon, 09 Sep 2024
 15:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 9 Sep 2024 15:45:39 -0700
Message-ID: <CAJD7tkb6320POwiWaSmZFUYRh44_BStwjc2nhL3Wangy1qWYxQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:23=E2=80=AFAM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Jingxiang Zeng <linuszeng@tencent.com>
>
> In proactive memory reclamation scenarios, it is necessary to
> estimate the pswpin and pswpout metrics of the cgroup to
> determine whether to continue reclaiming anonymous pages in
> the current batch. This patch will collect these metrics and
> expose them.

Could you add more details about the use case?

By "reclaiming anonymous pages", do you mean using memory.reclaim with
swappiness=3D200?

Why not just use PGPGOUT to figure out how many pages were reclaimed?
Do you find a significant amount of file pages getting reclaimed with
swappiness=3D200?

>
> Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> ---
>  mm/memcontrol-v1.c | 2 ++
>  mm/memcontrol.c    | 2 ++
>  mm/page_io.c       | 4 ++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d870816..44803cbea38a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] =3D {
>  static const unsigned int memcg1_events[] =3D {
>         PGPGIN,
>         PGPGOUT,
> +       PSWPIN,
> +       PSWPOUT,

memory.reclaim is not exposed in cgroup v1, so assuming these are only
used for such proactive reclaim, we don't need to add them here.

>         PGFAULT,
>         PGMAJFAULT,
>  };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 087a8cb1a6d8..dde3d026f174 100644
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
>         submit_bio(bio);
>  }
> --
> 2.43.5
>
>

