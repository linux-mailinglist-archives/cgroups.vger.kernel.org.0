Return-Path: <cgroups+bounces-8695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21038AFAFB9
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAED3AB7DD
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494B292B32;
	Mon,  7 Jul 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MadFQYoD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8228FFEE
	for <cgroups@vger.kernel.org>; Mon,  7 Jul 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880603; cv=none; b=GsniVxdd9pqAysoNtmMTvlYgvp/acVQ6eTcWcIn4ejbSAeBn8E1AESgUdWTXfIme9YCBVC//eWr5nhc6d94XxqS7mxajh+CYAtrgTmcA/qDufQHY5whYdPpbWDdWVmsNsQG5wvp62OFOQvR4VHEDjmDBaxgx38lP4aJ210wzxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880603; c=relaxed/simple;
	bh=5jvcgDEantFuEhTdDGL+ocpN5YEQvBVC+/WveJlL0us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1D4znxbK89Z1oPQ072zoipa31SKZszCMiExaSzQ5ZKuJmNVIhjGNCloI36HvgIQOLErCVhl9ox+vkYc/F2lwOIH0uefc7roqJIFfdDG8V5gMLQItq7ZTvHAyEz6kY8la8c3bcltXqFL8DgI9TlQvs90rhXpNJ3lUL84Ly//jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MadFQYoD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a582e09144so1775955f8f.1
        for <cgroups@vger.kernel.org>; Mon, 07 Jul 2025 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751880599; x=1752485399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBopqN4/kQa+aOaqKN5s0U/OHv3IvGI0wkWm8ojU9sA=;
        b=MadFQYoDqAbJqP972mFgidGmgvPleg0hGnSkB6iI6aFQ4YFPGay9WHy1UktzDiRiKp
         EEcJOxsLyoijM0UkzbN6+2Lz004RJpRcS9oJ5Zhbk2hEyK/1802bGfOzlLU+LiRBbUto
         nuHvw9gxENRGM49czSeNWA0Gj7VXdsuYCIcioMVRYF60CVYG035vQPfex8Qvypmy2Xfj
         z5eIaJYBOOnFKrjfoIHvAWc2Lsut/q99kTgOhPwwfEjhUZ3DuPeuKY/9JSJL7g9DPvUb
         N+tpW+dkip6QvqojEV7Vl43Z8QTm/eFNA9X2ovHzmmGq7VdG08vlf3ZE2g0nZw4tIpBK
         L5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751880599; x=1752485399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBopqN4/kQa+aOaqKN5s0U/OHv3IvGI0wkWm8ojU9sA=;
        b=TmzRQS9K98OapHAC4ViYBN49SXUpicSAVaQgXeeohfjpv5wVnlWRJQTocEFrxe0k0t
         lC9iqf07oTrUhOz6RNlHW8bIfh4gxWyrZKfvAa3twRiDQPwNobUXNEGCQpKHV5QY9qFu
         aPszSW63ZxmiwgVQaPjWkVarFzqAjNWffBoYOFpExBK3mQ8nPaLZX5S/VcjAQKv9fVCS
         LmFGdv87JvKFD096Yxw9izHwJwhZBUVuEA+a8qADGJp3aokux3AHOFJlIRV2aL5QVUw6
         Lyw5l7X7NvChQRDRfS7ztS1Y4y4NGswkZyVFdtfqbWJIC7eKzTCNVQGyCwnT79wxvwSO
         zRBA==
X-Forwarded-Encrypted: i=1; AJvYcCXc2LtKd4c8iD8sMbKmD7rcKeNi9EBW82t+FqwWBbsYUidFVeHSjk95hfM/99M4rGNWY28ANwSG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx140oXMHDM/XtCBclqVFlgRA1dk/bRJUoZj4L81LrdZt/KS7Mm
	9igbVl8D61kw8R/pdONPz5z52+OlLFcxX+0pdfsQxZYJQOCg4Dp8mM+ynG4T/+NJMmFbLT4c8iv
	5Nb90byqzjUB2m8LTvuxEjnSHda36KM7s5PyUofY6Rg==
X-Gm-Gg: ASbGncvC1M23TKlmE8D2PDek7zGYlx78Yf2W4tYco5RgkxiruQkEVSraKHz5cIBzSb5
	Je3YZl37RC27ypjZob5BidVOWRRmbXT57G3n51lXaMbkyrjtEnrZHqSoiqT5mAYwSt6o5bvgU7a
	Ayzr/3katBElJaI6Z6J8p054MyX0MUlZ/jQW+wl5GnD8IO1Q==
X-Google-Smtp-Source: AGHT+IFYO17VdpJkXKyCPrctRgd0p1eg8twLrHrvA7MgQGyjyYonUinveltNkkukOIhcTx/2KGStT26+0oMi0Y4ix74=
X-Received: by 2002:a05:6000:4909:b0:3a6:d6e4:dffd with SMTP id
 ffacd0b85a97d-3b497019165mr9286179f8f.14.1751880598925; Mon, 07 Jul 2025
 02:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-27-songmuchun@bytedance.com> <aGKHXWJl0ECKN1Zh@hyeyoo> <aGRdVzB5Ao1KkEu1@hyeyoo>
In-Reply-To: <aGRdVzB5Ao1KkEu1@hyeyoo>
From: Muchun Song <songmuchun@bytedance.com>
Date: Mon, 7 Jul 2025 17:29:22 +0800
X-Gm-Features: Ac12FXwHR19F3-OQz6JNsz_IWrXQcKv3piDCzJFFhHLteEbVb23UBkLndGuMBtA
Message-ID: <CAMZfGtVh0bYd5E=kK0ZMqECJraif+t0HrqVR046Q29aSJVZNvQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 26/28] mm: memcontrol: introduce memcg_reparent_ops
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:13=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> On Mon, Jun 30, 2025 at 09:47:25PM +0900, Harry Yoo wrote:
> > On Tue, Apr 15, 2025 at 10:45:30AM +0800, Muchun Song wrote:
> > > In the previous patch, we established a method to ensure the safety o=
f the
> > > lruvec lock and the split queue lock during the reparenting of LRU fo=
lios.
> > > The process involves the following steps:
> > >
> > >     memcg_reparent_objcgs(memcg)
> > >         1) lock
> > >         // lruvec belongs to memcg and lruvec_parent belongs to paren=
t memcg.
> > >         spin_lock(&lruvec->lru_lock);
> > >         spin_lock(&lruvec_parent->lru_lock);
> > >
> > >         2) relocate from current memcg to its parent
> > >         // Move all the pages from the lruvec list to the parent lruv=
ec list.
> > >
> > >         3) unlock
> > >         spin_unlock(&lruvec_parent->lru_lock);
> > >         spin_unlock(&lruvec->lru_lock);
> > >
> > > In addition to the folio lruvec lock, the deferred split queue lock
> > > (specific to THP) also requires a similar approach. Therefore, we abs=
tract
> > > the three essential steps from the memcg_reparent_objcgs() function.
> > >
> > >     memcg_reparent_objcgs(memcg)
> > >         1) lock
> > >         memcg_reparent_ops->lock(memcg, parent);
> > >
> > >         2) relocate
> > >         memcg_reparent_ops->relocate(memcg, reparent);
> > >
> > >         3) unlock
> > >         memcg_reparent_ops->unlock(memcg, reparent);
> > >
> > > Currently, two distinct locks (such as the lruvec lock and the deferr=
ed
> > > split queue lock) need to utilize this infrastructure. In the subsequ=
ent
> > > patch, we will employ these APIs to ensure the safety of these locks
> > > during the reparenting of LRU folios.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/memcontrol.h | 20 ++++++++++++
> > >  mm/memcontrol.c            | 62 ++++++++++++++++++++++++++++++------=
--
> > >  2 files changed, 69 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 27b23e464229..0e450623f8fa 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -311,6 +311,26 @@ struct mem_cgroup {
> > >     struct mem_cgroup_per_node *nodeinfo[];
> > >  };
> > >
> > > +struct memcg_reparent_ops {
> > > +   /*
> > > +    * Note that interrupt is disabled before calling those callbacks=
,
> > > +    * so the interrupt should remain disabled when leaving those cal=
lbacks.
> > > +    */
> > > +   void (*lock)(struct mem_cgroup *src, struct mem_cgroup *dst);
> > > +   void (*relocate)(struct mem_cgroup *src, struct mem_cgroup *dst);
> > > +   void (*unlock)(struct mem_cgroup *src, struct mem_cgroup *dst);
> > > +};
> > > +
> > > +#define DEFINE_MEMCG_REPARENT_OPS(name)                             =
       \
> > > +   const struct memcg_reparent_ops memcg_##name##_reparent_ops =3D {=
 \
> > > +           .lock           =3D name##_reparent_lock,                =
 \
> > > +           .relocate       =3D name##_reparent_relocate,            =
 \
> > > +           .unlock         =3D name##_reparent_unlock,              =
 \
> > > +   }
> > > +
> > > +#define DECLARE_MEMCG_REPARENT_OPS(name)                           \
> > > +   extern const struct memcg_reparent_ops memcg_##name##_reparent_op=
s
> > > +
> > >  /*
> > >   * size of first charge trial.
> > >   * TODO: maybe necessary to use big numbers in big irons or dynamic =
based of the
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 1f0c6e7b69cc..3fac51179186 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -194,24 +194,60 @@ static struct obj_cgroup *obj_cgroup_alloc(void=
)
> > >     return objcg;
> > >  }
> > >
> > > -static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
> > > +static void objcg_reparent_lock(struct mem_cgroup *src, struct mem_c=
group *dst)
> > > +{
> > > +   spin_lock(&objcg_lock);
> > > +}
> > > +
> > > +static void objcg_reparent_relocate(struct mem_cgroup *src, struct m=
em_cgroup *dst)
> > >  {
> > >     struct obj_cgroup *objcg, *iter;
> > > -   struct mem_cgroup *parent =3D parent_mem_cgroup(memcg);
> > >
> > > -   objcg =3D rcu_replace_pointer(memcg->objcg, NULL, true);
> > > +   objcg =3D rcu_replace_pointer(src->objcg, NULL, true);
> > > +   /* 1) Ready to reparent active objcg. */
> > > +   list_add(&objcg->list, &src->objcg_list);
> > > +   /* 2) Reparent active objcg and already reparented objcgs to dst.=
 */
> > > +   list_for_each_entry(iter, &src->objcg_list, list)
> > > +           WRITE_ONCE(iter->memcg, dst);
> > > +   /* 3) Move already reparented objcgs to the dst's list */
> > > +   list_splice(&src->objcg_list, &dst->objcg_list);
> > > +}
> > >
> > > -   spin_lock_irq(&objcg_lock);
> > > +static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem=
_cgroup *dst)
> > > +{
> > > +   spin_unlock(&objcg_lock);
> > > +}
> > >
> > > -   /* 1) Ready to reparent active objcg. */
> > > -   list_add(&objcg->list, &memcg->objcg_list);
> > > -   /* 2) Reparent active objcg and already reparented objcgs to pare=
nt. */
> > > -   list_for_each_entry(iter, &memcg->objcg_list, list)
> > > -           WRITE_ONCE(iter->memcg, parent);
> > > -   /* 3) Move already reparented objcgs to the parent's list */
> > > -   list_splice(&memcg->objcg_list, &parent->objcg_list);
> > > -
> > > -   spin_unlock_irq(&objcg_lock);
> > > +static DEFINE_MEMCG_REPARENT_OPS(objcg);
> > > +
> > > +static const struct memcg_reparent_ops *memcg_reparent_ops[] =3D {
> > > +   &memcg_objcg_reparent_ops,
> > > +};
> > > +
> > > +#define DEFINE_MEMCG_REPARENT_FUNC(phase)                          \
> > > +   static void memcg_reparent_##phase(struct mem_cgroup *src,      \
> > > +                                      struct mem_cgroup *dst)      \
> > > +   {                                                               \
> > > +           int i;                                                  \
> > > +                                                                   \
> > > +           for (i =3D 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)   =
 \
> > > +                   memcg_reparent_ops[i]->phase(src, dst);         \
> > > +   }
> > > +
> > > +DEFINE_MEMCG_REPARENT_FUNC(lock)
> > > +DEFINE_MEMCG_REPARENT_FUNC(relocate)
> > > +DEFINE_MEMCG_REPARENT_FUNC(unlock)
> > > +
> > > +static void memcg_reparent_objcgs(struct mem_cgroup *src)
> > > +{
> > > +   struct mem_cgroup *dst =3D parent_mem_cgroup(src);
> > > +   struct obj_cgroup *objcg =3D rcu_dereference_protected(src->objcg=
, true);
> > > +
> > > +   local_irq_disable();
> > > +   memcg_reparent_lock(src, dst);
> > > +   memcg_reparent_relocate(src, dst);
> > > +   memcg_reparent_unlock(src, dst);
> > > +   local_irq_enable();
> >
> > Hi,
> >
> > It seems unnecessarily complicated to 1) acquire objcg, lruvec and
> > thp_sq locks, 2) call their ->relocate() callbacks, and
> > 3) release those locks.
> >
> > Why not simply do the following instead?
> >
> > for (i =3D 0; i < ARRAY_SIZE(memcg_reparent_ops); i++) {
> >       local_irq_disable();
> >       memcg_reparent_ops[i]->lock(src, dst);
> >       memcg_reparent_ops[i]->relocate(src, dst);
> >       memcg_reparent_ops[i]->unlock(src, dst);
> >       local_irq_enable();
> > }
> >
> > As there is no actual lock dependency between the three.
> >
> > Or am I missing something important about the locking requirements?
>
> Hmm... looks like I was missing some important requirements!
>
> It seems like:
>
> 1) objcg should be reparented under lruvec locks, otherwise
>    users can observe folio_memcg(folio) !=3D lruvec_memcg(lruvec)
>
> 2) Similarly, lruvec_reparent_relocate() should reparent all folios
>    at once under lruvec locks, otherwise users can observe
>    folio_memcg(folio) !=3D lruvec_memcg(lruvec) for some folios.
>
>    IoW, lruvec_reparent_relocate() cannot do something like this:
>    while (lruvec is not empty) {
>            move some pages;
>            unlock lruvec locks;
>            cond_resched();
>            lock lruvec locks;
>    }
>
> Failing to satisfy 1) and 2) means user can't rely on a stable binding
> between a folio and a memcg, which is a no-go.
>
> Also, 2) makes it quite undesirable to iterate over folios and move each
> one to the right generation in MGLRU as this will certainly introduce
> soft lockups as the memcg size grows...

Sorry for the late reply. Yes, you are right. We should iterate each folio
without holding any spinlocks. So I am confirming if we could do some
preparation work like making it suitable for reparenting without holding an=
y
spinlock. Then we could reparent those folios like the non-MGLRU case.

Thanks.

>
> Is my reasoning correct?
> If so, adding a brief comment about 1 and 2 wouldn't hurt ;)

OK.

>
> --
> Cheers,
> Harry / Hyeonggon

