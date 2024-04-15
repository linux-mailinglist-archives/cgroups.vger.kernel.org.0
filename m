Return-Path: <cgroups+bounces-2479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D38A474F
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 05:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C34283609
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 03:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6EF1BF31;
	Mon, 15 Apr 2024 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt7OjQvf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0E15E9B;
	Mon, 15 Apr 2024 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713151788; cv=none; b=YL/2ih6udiWT54CIDZyaoDR6cyPuE1SQSWWvVssOe7LRqxMZxvjXi766INBNQ+sT0QuqXMZiarIM7LxLDjNdOLEqPSK7q7MRUwDZFOHgt4FSW7/ObROis1k+auGfV4PfVTjTz+P1zBxuI+1SF3pUswAL6e3vXrh3If3plFq32kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713151788; c=relaxed/simple;
	bh=RZbvyl0ZeKT9OnsFx1FJ8SDfBp9ix87p/F3HNGv9D2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbuISAEl252XXWQZ8ubC5gPmYcyF1EZYEUvhgcGX6Z84qB9Ij5xKx8DZb30mQno7CbeFS7sYvFu9LGVBV115W1aneX115PfJD72oR/b/yJLDuqG6vGYAt7S0KS9RgeZZWC+/al0Bxi5tt4X2Wqmrt1WOHcL8fz5r/4g1+gHf3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt7OjQvf; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-479dd0261c8so1820827137.0;
        Sun, 14 Apr 2024 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713151786; x=1713756586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB/wuwbKBLOFbdciQai/w0/3HaKtb8+rz1RVneK6E10=;
        b=dt7OjQvfUJAEktMlmhaZlqxPZTKSWTaTbIjvr6yAF/kLUkNCycwty3zf3xI2EaSZd0
         ARvrhsvkv0SO1Z9s0uGaX8NazI3wxPN0iSjS1tcSedf4JF+ZVSp6MFOkjAfkA2IL72Tv
         GSByFU64XchLM0Ja3vWzn8DG01O7rai4pTvorPar6A03oREPtKJiPIO3rWvNTAvn3ELu
         oS42ZMFxil2QLaRsnaJeJJityyOMWpf+sZQVQX7IcbslujWoWw6l+frTeVyDaorAJmuu
         pCfYrZ/Qc4LjAgJ2HuJ1Jb5Fkncty1qAhqnyu46Yc4c2s2Uqv7NJpKnl5NlSsq56J+9b
         GPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713151786; x=1713756586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB/wuwbKBLOFbdciQai/w0/3HaKtb8+rz1RVneK6E10=;
        b=B62V/mYbUiJIqNPIja7ReKWNQAyEEgyYyUMBj4lkZzJZjbxsWsAmmvCFe/xcadiaYj
         1YVRd0UjfyXtKVQUXchz7tg/n+y/t3S3ncZJSR4ouNP+iJQPGYz7yjQHRh9fiL8X8+pN
         UIz/Bbz7HrAfsb+zWMSHEzzlvvzSzVnF3dfhBaosIdh3Hnvg5+nfaRx4ZdYJiUtRAZgI
         mNOj8erIO7eYVTH/8CgEEmFpd/EQqaVs9CXzpTYlOpx3H6INLohlvtL+P0/o9d+pXl0v
         3bY44D3maiI4UU0KG8q7jvTjrwA1JSD+K5mFbRPiquSRXVtpaaRva4TPg4ukwn9DOWoQ
         nlYg==
X-Forwarded-Encrypted: i=1; AJvYcCUnmCQVdb9lJ1RoBOycyaaJrsn2BYdLlRysBStIWjtx4je3F/Uz2E/2iCUjxCp3QAOV0fPaeBSvsORGX0brs3db/nMtZnsUJSnlGEj4UPPk4Bu0XlvcvjPZOB5u6NzBFOA906Qx8Q==
X-Gm-Message-State: AOJu0YzLwpjaqqSH9JDSF13ukHGd+omwsOuKG4e7jdXwlEMZU1ngbfCh
	C4tfVvWhkrbxZA0BuasO819WLI3hj571JoRCmIpivDjz7PlnyGvKbMdARNyWQ+VSEcMzWwT53sf
	dABTuPuOY2GEhDYkiCA+X+DdzEW/Qn4rfmwk=
X-Google-Smtp-Source: AGHT+IFs1Z2t8NroKjcqGtfbfkndIykue1SiysAI0d0DBCa1WkYW2TXIM4H+BsgApG55mawaIpkFFQJZry56SI+TfyY=
X-Received: by 2002:a05:6102:50ab:b0:47a:62c5:6423 with SMTP id
 bl43-20020a05610250ab00b0047a62c56423mr7053825vsb.12.1713151785791; Sun, 14
 Apr 2024 20:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415111123924s9IbQkgHF8S4yZv4su8LI@zte.com.cn>
In-Reply-To: <20240415111123924s9IbQkgHF8S4yZv4su8LI@zte.com.cn>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 15:29:34 +1200
Message-ID: <CAGsJ_4y5+3jKx78-TWh_3jWoXQW4mmx=uKHbBSHWpvMj1eYW7A@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: makes the memcg THP deferred split shrinker
 aware of node_id
To: xu.xin16@zte.com.cn, yang.shi@linux.alibaba.com
Cc: v-songbaohua@oppo.com, mhocko@kernel.org, ryan.roberts@arm.com, 
	david@redhat.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn, 
	yang.yang29@zte.com.cn, lu.zhongjun@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:11=E2=80=AFPM <xu.xin16@zte.com.cn> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Since commit 87eaceb3faa5 ("mm: thp: make deferred split shrinker
> memcg aware"), the THP deferred split queue is per memcg but not
> per mem_cgroup_per_node. This has two aspects of impact:
>
> Impact1: for kswapd reclaim
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   kswapd
>     balance_pgdat
>       kswapd_shrink_node
>         shrink_node(pgdat, sc);
>           shrink_node_memcgs(pgdat, sc);
>             shrink_slab(sc->gfp_mask, pgdat->node_id, memcg...);
>   the parameter "pgdat->node_id"  does not take effectct for
>   THP deferred_split_shrinker, as the deferred_split_queue of
>   specified memcg is not for a certain numa node but for all the nodes.
>   We want to makes the memcg THP deferred split shrinker aware of
>   node_id.
>
> Impact2: thp-deferred_split shrinker debugfs interface
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    for the "count" file:
>    <cgroup inode id> <objects on node 0> <objects on node 1>
>      the output is acctually the sum of all numa nodes.
>    for the "scan" file:
>    <cgroup inode id> <numa id> <number of objects to scan>
>      Also the "numa id" input does not take effect here.
>
> This patch makes memcg deferred_split_queue per mem_cgroup_per_node
> so try to conform to semantic logic.

This seems to be a correct fix to me,  + Yang Shi, the original author of
commit 87eaceb3faa5.

>
> Reviewed-by: Lu Zhongjun <lu.zhongjun@zte.com.cn>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  include/linux/memcontrol.h |  7 +++----
>  mm/huge_memory.c           |  6 +++---
>  mm/memcontrol.c            | 11 +++++------
>  3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 394fd0a887ae..7282861d5a5d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -130,6 +130,9 @@ struct mem_cgroup_per_node {
>         bool                    on_tree;
>         struct mem_cgroup       *memcg;         /* Back pointer, we canno=
t */
>                                                 /* use container_of      =
  */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       struct deferred_split deferred_split_queue;
> +#endif
>  };
>
>  struct mem_cgroup_threshold {
> @@ -327,10 +330,6 @@ struct mem_cgroup {
>         struct list_head event_list;
>         spinlock_t event_list_lock;
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       struct deferred_split deferred_split_queue;
> -#endif
> -
>  #ifdef CONFIG_LRU_GEN_WALKS_MMU
>         /* per-memcg mm_struct list */
>         struct lru_gen_mm_list mm_list;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..338d071070a6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -774,7 +774,7 @@ struct deferred_split *get_deferred_split_queue(struc=
t folio *folio)
>         struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>
>         if (memcg)
> -               return &memcg->deferred_split_queue;
> +               return &memcg->nodeinfo[pgdat->node_id]->deferred_split_q=
ueue;
>         else
>                 return &pgdat->deferred_split_queue;
>  }
> @@ -3305,7 +3305,7 @@ static unsigned long deferred_split_count(struct sh=
rinker *shrink,
>
>  #ifdef CONFIG_MEMCG
>         if (sc->memcg)
> -               ds_queue =3D &sc->memcg->deferred_split_queue;
> +               ds_queue =3D &sc->memcg->nodeinfo[sc->nid]->deferred_spli=
t_queue;
>  #endif
>         return READ_ONCE(ds_queue->split_queue_len);
>  }
> @@ -3322,7 +3322,7 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
>
>  #ifdef CONFIG_MEMCG
>         if (sc->memcg)
> -               ds_queue =3D &sc->memcg->deferred_split_queue;
> +               ds_queue =3D &sc->memcg->nodeinfo[sc->nid]->deferred_spli=
t_queue;
>  #endif
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fabce2b50c69..cdf9f5fa3b8e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5445,7 +5445,11 @@ static int alloc_mem_cgroup_per_node_info(struct m=
em_cgroup *memcg, int node)
>                 kfree(pn);
>                 return 1;
>         }
> -
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       spin_lock_init(&pn->deferred_split_queue.split_queue_lock);
> +       INIT_LIST_HEAD(&pn->deferred_split_queue.split_queue);
> +       pn->deferred_split_queue.split_queue_len =3D 0;
> +#endif
>         lruvec_init(&pn->lruvec);
>         pn->memcg =3D memcg;
>
> @@ -5545,11 +5549,6 @@ static struct mem_cgroup *mem_cgroup_alloc(struct =
mem_cgroup *parent)
>         for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
>                 memcg->cgwb_frn[i].done =3D
>                         __WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
> -#endif
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
> -       INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
> -       memcg->deferred_split_queue.split_queue_len =3D 0;
>  #endif
>         lru_gen_init_memcg(memcg);
>         return memcg;
> --
> 2.15.2
>

Thanks
Barry

