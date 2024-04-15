Return-Path: <cgroups+bounces-2487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE5B8A59EE
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC631C203C0
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56C153800;
	Mon, 15 Apr 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTbfQH60"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D115357D;
	Mon, 15 Apr 2024 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205930; cv=none; b=e+Gy8pg7+YoU7XR2P3W47xwNdLMG1m65xgOoCEDZRobsT3HaGUe+HDZbB/+q6vKfLWl5ajMp3yURusGp6LSdHtA+BncW+bL+GvKaQdPPmttUYU72cGm0xgOTP8o1Tj0l4s9saP4ZISnW8KNjB+EXLJJ1PmgPrXDmKugO0ZooV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205930; c=relaxed/simple;
	bh=ypB0M/yxYiVpSpTfJMOKUEFFxzQJxHzjaQ8flno2ylM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gphzp9iEOagu4t1TvcAJqHDcfCw0vazU+9i7qCno7GMqS4eD3cKNaywU1TdnGQDtTgZ1Dy6DpCn049/rsYtOYmBYD0e/vr+eeZoI2LbBAMYgtVjzM7xIOedoDNTxQ3NEpPf3epFwPOEHH+Nvz9uShthxVIOoIX1Mj5OFL21lvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTbfQH60; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d6e23253so3867970e87.1;
        Mon, 15 Apr 2024 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205927; x=1713810727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BObtzxYiY3PmGcxZPMQAa4vztvNYgpogv+uT8X9uMc=;
        b=jTbfQH60SmGseWXDQtLxf5XdTaweEEvzHAOpU6DZmcotkHjiCWJrymFZ6a8gZZMeix
         7Wrywp8drxxY+PUgY265IXhOHKrBcei6sBJH69nif+39cS9RVBYj0DCnzmZquoAM0g8l
         pZPZCuNq+H0Eypim52p8YAM7goCykgO1QIHPu1/QlCkTXfvTOFrQq8WLgsxU+Osuf3P4
         6RdXUjL3cuz8iRwPR3V9Yx1WdUuTEK7FZaSdRXVZbR0cq+7wrUs4WEdxyrOLc+uKSbMD
         UCoMg5GZ3PKlcG/XoPAYypkVs9gZ/J/T4HGWfAeQTsv9epV/0ngC3Mn0mfv3uVCAL2U5
         w9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205927; x=1713810727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BObtzxYiY3PmGcxZPMQAa4vztvNYgpogv+uT8X9uMc=;
        b=kyWBKjV1T9sneOuJ+o5eohDW1RJACT0q1r/M+DccJfTbDd9lrpnpWYYDov/+G1oO7K
         GtdpVrDM1b8GIzl5/0c3dmzKtosbH1t6At69HsXhP7rxOzdZb8tzvPWMyz82EqWJWSjI
         cu47VYPUYKm9fF/xiBfBcYIBgkG/Ja38JzrrAAHTA9Y41YmfNDhXUhUYgOx5ZfEFi98h
         AIl6tE33HC7YhPkLQyTetr7WxdnqXyAvaSZR+VUffH0qQIk8vzutCBzA3y8pf07y4qmG
         sj9NyI24TbjXTOk8+qhm+yxnpscxNKuL2Nd/+o0h9u5/DkA4ZfPdkYkRvedEK4ACZTOY
         CODA==
X-Forwarded-Encrypted: i=1; AJvYcCXvnOef6IeCV9jZZf11VKzNvbtVmfODKr/5mNHyaZ7HcACam7C0v4Z1oIzTUfNd9KQFr6J28TV0lhK7h3htWLyVL5/o0QhmlFZ7dAAylNvK06XwZCKlW6rCvpOUi/b4Z14KfHC9YQ==
X-Gm-Message-State: AOJu0YxJCnOCNJ/LjW1kWaOuXkwdAexUeGAfeOty3UFAn2ETAPdCtGd2
	6NoyIKRGQUUkwiKM+YTRirj61vSj6CJLU9ktFuDmuCiYtpkp1GxO8btjJEoRib2sDt4yHj1uye6
	/Ahka1x20gkAj2lswvE7p978CXoE=
X-Google-Smtp-Source: AGHT+IELpdHs5oFeoJ4R5hMXIeoaGuXsJr1uljvlhUTakFT+LkeDspHihOeO/Bws+LtHWr6XekRPiGt1x2fxr1ncTWU=
X-Received: by 2002:ac2:51a7:0:b0:518:bb6e:7985 with SMTP id
 f7-20020ac251a7000000b00518bb6e7985mr4869628lfk.51.1713205926682; Mon, 15 Apr
 2024 11:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415111123924s9IbQkgHF8S4yZv4su8LI@zte.com.cn> <CAGsJ_4y5+3jKx78-TWh_3jWoXQW4mmx=uKHbBSHWpvMj1eYW7A@mail.gmail.com>
In-Reply-To: <CAGsJ_4y5+3jKx78-TWh_3jWoXQW4mmx=uKHbBSHWpvMj1eYW7A@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 15 Apr 2024 11:31:55 -0700
Message-ID: <CAHbLzkqwHiSb4e=soerK1qtA7FoJz8PEPXiCmnFx8i1Bhvp2-g@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: makes the memcg THP deferred split shrinker
 aware of node_id
To: Barry Song <21cnbao@gmail.com>
Cc: xu.xin16@zte.com.cn, yang.shi@linux.alibaba.com, v-songbaohua@oppo.com, 
	mhocko@kernel.org, ryan.roberts@arm.com, david@redhat.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn, yang.yang29@zte.com.cn, 
	lu.zhongjun@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 8:30=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Apr 15, 2024 at 3:11=E2=80=AFPM <xu.xin16@zte.com.cn> wrote:
> >
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > Since commit 87eaceb3faa5 ("mm: thp: make deferred split shrinker
> > memcg aware"), the THP deferred split queue is per memcg but not
> > per mem_cgroup_per_node. This has two aspects of impact:
> >
> > Impact1: for kswapd reclaim
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   kswapd
> >     balance_pgdat
> >       kswapd_shrink_node
> >         shrink_node(pgdat, sc);
> >           shrink_node_memcgs(pgdat, sc);
> >             shrink_slab(sc->gfp_mask, pgdat->node_id, memcg...);
> >   the parameter "pgdat->node_id"  does not take effectct for
> >   THP deferred_split_shrinker, as the deferred_split_queue of
> >   specified memcg is not for a certain numa node but for all the nodes.
> >   We want to makes the memcg THP deferred split shrinker aware of
> >   node_id.
> >
> > Impact2: thp-deferred_split shrinker debugfs interface
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    for the "count" file:
> >    <cgroup inode id> <objects on node 0> <objects on node 1>
> >      the output is acctually the sum of all numa nodes.
> >    for the "scan" file:
> >    <cgroup inode id> <numa id> <number of objects to scan>
> >      Also the "numa id" input does not take effect here.
> >
> > This patch makes memcg deferred_split_queue per mem_cgroup_per_node
> > so try to conform to semantic logic.

I used to have a similar patch before,
https://lore.kernel.org/linux-mm/1569968203-64647-1-git-send-email-yang.shi=
@linux.alibaba.com/

But it was somehow lost in discussion.

I have no objection to this patch. However, I was thinking about using
list_lru for deferred split queue, but I didn't have time to look
deeper. Maybe we should try now?

>
> This seems to be a correct fix to me,  + Yang Shi, the original author of
> commit 87eaceb3faa5.
>
> >
> > Reviewed-by: Lu Zhongjun <lu.zhongjun@zte.com.cn>
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > Cc: xu xin <xu.xin16@zte.com.cn>
> > Cc: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  include/linux/memcontrol.h |  7 +++----
> >  mm/huge_memory.c           |  6 +++---
> >  mm/memcontrol.c            | 11 +++++------
> >  3 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 394fd0a887ae..7282861d5a5d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -130,6 +130,9 @@ struct mem_cgroup_per_node {
> >         bool                    on_tree;
> >         struct mem_cgroup       *memcg;         /* Back pointer, we can=
not */
> >                                                 /* use container_of    =
    */
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       struct deferred_split deferred_split_queue;
> > +#endif
> >  };
> >
> >  struct mem_cgroup_threshold {
> > @@ -327,10 +330,6 @@ struct mem_cgroup {
> >         struct list_head event_list;
> >         spinlock_t event_list_lock;
> >
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -       struct deferred_split deferred_split_queue;
> > -#endif
> > -
> >  #ifdef CONFIG_LRU_GEN_WALKS_MMU
> >         /* per-memcg mm_struct list */
> >         struct lru_gen_mm_list mm_list;
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9859aa4f7553..338d071070a6 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -774,7 +774,7 @@ struct deferred_split *get_deferred_split_queue(str=
uct folio *folio)
> >         struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
> >
> >         if (memcg)
> > -               return &memcg->deferred_split_queue;
> > +               return &memcg->nodeinfo[pgdat->node_id]->deferred_split=
_queue;
> >         else
> >                 return &pgdat->deferred_split_queue;
> >  }
> > @@ -3305,7 +3305,7 @@ static unsigned long deferred_split_count(struct =
shrinker *shrink,
> >
> >  #ifdef CONFIG_MEMCG
> >         if (sc->memcg)
> > -               ds_queue =3D &sc->memcg->deferred_split_queue;
> > +               ds_queue =3D &sc->memcg->nodeinfo[sc->nid]->deferred_sp=
lit_queue;
> >  #endif
> >         return READ_ONCE(ds_queue->split_queue_len);
> >  }
> > @@ -3322,7 +3322,7 @@ static unsigned long deferred_split_scan(struct s=
hrinker *shrink,
> >
> >  #ifdef CONFIG_MEMCG
> >         if (sc->memcg)
> > -               ds_queue =3D &sc->memcg->deferred_split_queue;
> > +               ds_queue =3D &sc->memcg->nodeinfo[sc->nid]->deferred_sp=
lit_queue;
> >  #endif
> >
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index fabce2b50c69..cdf9f5fa3b8e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5445,7 +5445,11 @@ static int alloc_mem_cgroup_per_node_info(struct=
 mem_cgroup *memcg, int node)
> >                 kfree(pn);
> >                 return 1;
> >         }
> > -
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       spin_lock_init(&pn->deferred_split_queue.split_queue_lock);
> > +       INIT_LIST_HEAD(&pn->deferred_split_queue.split_queue);
> > +       pn->deferred_split_queue.split_queue_len =3D 0;
> > +#endif
> >         lruvec_init(&pn->lruvec);
> >         pn->memcg =3D memcg;
> >
> > @@ -5545,11 +5549,6 @@ static struct mem_cgroup *mem_cgroup_alloc(struc=
t mem_cgroup *parent)
> >         for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> >                 memcg->cgwb_frn[i].done =3D
> >                         __WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
> > -#endif
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -       spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
> > -       INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
> > -       memcg->deferred_split_queue.split_queue_len =3D 0;
> >  #endif
> >         lru_gen_init_memcg(memcg);
> >         return memcg;
> > --
> > 2.15.2
> >
>
> Thanks
> Barry
>

