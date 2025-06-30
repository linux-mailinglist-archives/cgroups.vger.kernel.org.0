Return-Path: <cgroups+bounces-8653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCAAED55F
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 09:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4177816751D
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35520C463;
	Mon, 30 Jun 2025 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HQVg+t3t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA361A2643
	for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267820; cv=none; b=YruIZDpd/KkcLgmdYRPttNX/NfxYfae1cniL/QfuzDbBu04WClFKgzfSdcouj1hSSXfZer2+sZEM8LHKasuUF1enVRzoNgSpoHPnJRsEAUQKLHG8Fd52bcjl9YSIKiq8/e6Ji7NihXQ1HsA4i1dbjumTQfb2mWqNBiL9YsvRniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267820; c=relaxed/simple;
	bh=7VBMU9+r5jBOVZywFu3SghTTZXiC51n564lFkNDbsXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3wXz6ReAqJPv5E0Q5eIKLqfVjHdrkjhVjd/odqKShKA6iZI5QP40unCduVMcKfhiHRSw0H4hkdGlIQJquvntMu3A1jroYEn0mbfI0fplIIsM2WxpcYx28SSUOqqacy7NTdOKpHORl3gEe+8i0DF/YzxsEtGdz31ujUyf1tW4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HQVg+t3t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1970654f8f.1
        for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751267816; x=1751872616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtwfhBZq+/qOoD0+cgMV2ISyypIUfUwX6SyoRcyAoeE=;
        b=HQVg+t3t+9hj2lSvV+CcKjscLIsRMoKQHr2L8msRMXWrK10FaCGwac7baT5RsY50km
         UY+wG+qDI3anG5t0wIQE/0DpIKSh6c6fhR0haCMFTxO4iVJxLI27aB99/+TrzDeOPvkI
         6EaQXosdxrDySkXHZZKSzYciVEdAIgQ8QlaXnQJtLK5HoEr4Cq5/BLEpJpOxd3xRbMpn
         z3o/9Njcld1IIRkG1rFC6WBYqvQ9tGnzL8PCAazfnTshFyeZlJmANyG/Mt7VOUtWQppv
         yx2Lgkj613eXLHmBgxYSEviqzZ2HmQvkK9JVdI5wxIZ8E7YbRNkxG87t8jrXdBWsIxet
         6Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267816; x=1751872616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtwfhBZq+/qOoD0+cgMV2ISyypIUfUwX6SyoRcyAoeE=;
        b=RcJNX9JIzzc3zwYE2LvOU4nHKlrJydp/iXeHra9LzrVP5EXsB5oD7ruCA20gikzMy3
         K97DS1OwYCGRzQq1Mrqb9JBNad/UMN3EkAgdQbpj+OxF+XS2ATLeIDn5eywlwJPSkvGF
         0Bwkh8TTw1cIVi5rmc89mqMU7IZkf5xeWjXl5jih7g1wYKZlfhySAkkuUxHwiMz6SE/P
         J9zBiHq7ZmYKkLWYeT6vn0ncMXiTy6sHt/D9FMKqEFi30rPPMSHl3IST8Cqtf1Rh84jp
         05LQzG51DaqoabdsqBzFDdgVxdpKNfJZf9zjzsBPYv+RT3333nTrq7YwbX/BAd882MYA
         JtSA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/d4a6Zqu7BgLeqqvnwMt6eV6T2u4L6ximf/JdpLJ6rRwIcbGCVfAR/NyCONpBp0ogidhh+zc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyurs6XNGsNzWvxSL348Sf0ElOjClc8+mcPoV6mIozvrggtDjn0
	fmZ6YioWEEuhw+ERxX8FthZjDII8ERQqPkumkoweHQSUkXY9rGkhcBJmszHqjbqJg2sHTe3/0tI
	i40bJWUyiHUw3YPyOOCPBTDbID0O5GBTIIoPwv3jzYw==
X-Gm-Gg: ASbGncvhVWstytYohVSUN4EGnKpbq6Zn/fxnEM3L2ioCY1IoqzHS/aX0/Y91eLbOHEd
	ixqR7g1pGefMgNP0GwZycjM8deY3fqjn+kEjHYt3llhtV1CjRia3Uoqj11nxWAC5/cgS+qDMPre
	6vQUmuvAXuNI0K7zrRxdtwb9Ofx/DidrOSk180WhNjAucUZQ==
X-Google-Smtp-Source: AGHT+IGWcMoGPyQen9EzSdhD+7SA3oKhs+KyVeAZvmZJHvemv5d7E0XLkUi6FCGl+40J2OvnKEDqRXte7pQqFVwSe1A=
X-Received: by 2002:adf:b60b:0:b0:3a4:f939:b53 with SMTP id
 ffacd0b85a97d-3a8ffcc9d53mr8921516f8f.38.1751267816068; Mon, 30 Jun 2025
 00:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-11-songmuchun@bytedance.com> <d84092a7-fc3d-4c3c-98b3-341d63a21b18@huaweicloud.com>
In-Reply-To: <d84092a7-fc3d-4c3c-98b3-341d63a21b18@huaweicloud.com>
From: Muchun Song <songmuchun@bytedance.com>
Date: Mon, 30 Jun 2025 15:16:18 +0800
X-Gm-Features: Ac12FXw01TxCGLVgLGT-K9XFIEOAOjYaHiqekorDSE1Mqeqfw5mapo0SJXdnmhc
Message-ID: <CAMZfGtX_Ft=OpThZC0vp2TdXxymK-AV6HTyinVhRBJrk6ZkUfA@mail.gmail.com>
Subject: Re: Re: [PATCH RFC 10/28] mm: memcontrol: return root object cgroup
 for root memory cgroup
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, muchun.song@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, yosry.ahmed@linux.dev, 
	Nhat Pham <nphamcs@gmail.com>, chengming.zhou@linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 11:09=E2=80=AFAM Chen Ridong <chenridong@huaweiclou=
d.com> wrote:
>
>
>
> On 2025/4/15 10:45, Muchun Song wrote:
> > Memory cgroup functions such as get_mem_cgroup_from_folio() and
> > get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
> > even for the root memory cgroup. In contrast, the situation for
> > object cgroups has been different.
> >
> > Previously, the root object cgroup couldn't be returned because
> > it didn't exist. Now that a valid root object cgroup exists, for
> > the sake of consistency, it's necessary to align the behavior of
> > object-cgroup-related operations with that of memory cgroup APIs.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 29 ++++++++++++++++++-------
> >  mm/memcontrol.c            | 44 ++++++++++++++++++++------------------
> >  mm/percpu.c                |  2 +-
> >  3 files changed, 45 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index bb4f203733f3..e74922d5755d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -319,6 +319,7 @@ struct mem_cgroup {
> >  #define MEMCG_CHARGE_BATCH 64U
> >
> >  extern struct mem_cgroup *root_mem_cgroup;
> > +extern struct obj_cgroup *root_obj_cgroup;
> >
> >  enum page_memcg_data_flags {
> >       /* page->memcg_data is a pointer to an slabobj_ext vector */
> > @@ -528,6 +529,11 @@ static inline bool mem_cgroup_is_root(struct mem_c=
group *memcg)
> >       return (memcg =3D=3D root_mem_cgroup);
> >  }
> >
> > +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
> > +{
> > +     return objcg =3D=3D root_obj_cgroup;
> > +}
> > +
> >  static inline bool mem_cgroup_disabled(void)
> >  {
> >       return !cgroup_subsys_enabled(memory_cgrp_subsys);
> > @@ -752,23 +758,26 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgr=
oup_subsys_state *css){
> >
> >  static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
> >  {
> > +     if (obj_cgroup_is_root(objcg))
> > +             return true;
> >       return percpu_ref_tryget(&objcg->refcnt);
> >  }
> >
> > -static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> > +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> > +                                    unsigned long nr)
> >  {
> > -     percpu_ref_get(&objcg->refcnt);
> > +     if (!obj_cgroup_is_root(objcg))
> > +             percpu_ref_get_many(&objcg->refcnt, nr);
> >  }
> >
> > -static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> > -                                    unsigned long nr)
> > +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> >  {
> > -     percpu_ref_get_many(&objcg->refcnt, nr);
> > +     obj_cgroup_get_many(objcg, 1);
> >  }
> >
> >  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> >  {
> > -     if (objcg)
> > +     if (objcg && !obj_cgroup_is_root(objcg))
> >               percpu_ref_put(&objcg->refcnt);
> >  }
> >
> > @@ -1101,6 +1110,11 @@ static inline bool mem_cgroup_is_root(struct mem=
_cgroup *memcg)
> >       return true;
> >  }
> >
> > +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
> > +{
> > +     return true;
> > +}
> > +
> >  static inline bool mem_cgroup_disabled(void)
> >  {
> >       return true;
> > @@ -1684,8 +1698,7 @@ static inline struct obj_cgroup *get_obj_cgroup_f=
rom_current(void)
> >  {
> >       struct obj_cgroup *objcg =3D current_obj_cgroup();
> >
> > -     if (objcg)
> > -             obj_cgroup_get(objcg);
> > +     obj_cgroup_get(objcg);
> >
> >       return objcg;
> >  }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a6362d11b46c..4aadc1b87db3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -81,6 +81,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly=
;
> >  EXPORT_SYMBOL(memory_cgrp_subsys);
> >
> >  struct mem_cgroup *root_mem_cgroup __read_mostly;
> > +struct obj_cgroup *root_obj_cgroup __read_mostly;
> >
> >  /* Active memory cgroup to use from an interrupt context */
> >  DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> > @@ -2525,15 +2526,14 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(voi=
d *p)
> >
> >  static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgrou=
p *memcg)
> >  {
> > -     struct obj_cgroup *objcg =3D NULL;
> > +     for (; memcg; memcg =3D parent_mem_cgroup(memcg)) {
> > +             struct obj_cgroup *objcg =3D rcu_dereference(memcg->objcg=
);
> >
> > -     for (; !mem_cgroup_is_root(memcg); memcg =3D parent_mem_cgroup(me=
mcg)) {
> > -             objcg =3D rcu_dereference(memcg->objcg);
> >               if (likely(objcg && obj_cgroup_tryget(objcg)))
> > -                     break;
> > -             objcg =3D NULL;
> > +                     return objcg;
> >       }
> > -     return objcg;
> > +
> > +     return NULL;
> >  }
> >
>
> It appears that the return NULL statement might be dead code in this
> context. And would it be preferable to use return root_obj_cgroup instead=
?

I do not think so. The parameter of @memcg could be NULL passed from
current_objcg_update(). Returning NULL in this case makes sense to me.
It is not reasonable to return root_obj_cgroup for a NULL memcg for me.

Muchun,
Thanks.

>
> Best regards,
> Ridong
>
> >  static struct obj_cgroup *current_objcg_update(void)
> > @@ -2604,18 +2604,17 @@ __always_inline struct obj_cgroup *current_obj_=
cgroup(void)
> >                * Objcg reference is kept by the task, so it's safe
> >                * to use the objcg by the current task.
> >                */
> > -             return objcg;
> > +             return objcg ? : root_obj_cgroup;
> >       }
> >
> >       memcg =3D this_cpu_read(int_active_memcg);
> >       if (unlikely(memcg))
> >               goto from_memcg;
> >
> > -     return NULL;
> > +     return root_obj_cgroup;
> >
> >  from_memcg:
> > -     objcg =3D NULL;
> > -     for (; !mem_cgroup_is_root(memcg); memcg =3D parent_mem_cgroup(me=
mcg)) {
> > +     for (; memcg; memcg =3D parent_mem_cgroup(memcg)) {
> >               /*
> >                * Memcg pointer is protected by scope (see set_active_me=
mcg())
> >                * and is pinning the corresponding objcg, so objcg can't=
 go
> > @@ -2624,10 +2623,10 @@ __always_inline struct obj_cgroup *current_obj_=
cgroup(void)
> >                */
> >               objcg =3D rcu_dereference_check(memcg->objcg, 1);
> >               if (likely(objcg))
> > -                     break;
> > +                     return objcg;
> >       }
> >
> > -     return objcg;
> > +     return root_obj_cgroup;
> >  }
> >
> >  struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
> > @@ -2641,14 +2640,8 @@ struct obj_cgroup *get_obj_cgroup_from_folio(str=
uct folio *folio)
> >               objcg =3D __folio_objcg(folio);
> >               obj_cgroup_get(objcg);
> >       } else {
> > -             struct mem_cgroup *memcg;
> > -
> >               rcu_read_lock();
> > -             memcg =3D __folio_memcg(folio);
> > -             if (memcg)
> > -                     objcg =3D __get_obj_cgroup_from_memcg(memcg);
> > -             else
> > -                     objcg =3D NULL;
> > +             objcg =3D __get_obj_cgroup_from_memcg(__folio_memcg(folio=
));
> >               rcu_read_unlock();
> >       }
> >       return objcg;
> > @@ -2733,7 +2726,7 @@ int __memcg_kmem_charge_page(struct page *page, g=
fp_t gfp, int order)
> >       int ret =3D 0;
> >
> >       objcg =3D current_obj_cgroup();
> > -     if (objcg) {
> > +     if (!obj_cgroup_is_root(objcg)) {
> >               ret =3D obj_cgroup_charge_pages(objcg, gfp, 1 << order);
> >               if (!ret) {
> >                       obj_cgroup_get(objcg);
> > @@ -3036,7 +3029,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cac=
he *s, struct list_lru *lru,
> >        * obj_cgroup_get() is used to get a permanent reference.
> >        */
> >       objcg =3D current_obj_cgroup();
> > -     if (!objcg)
> > +     if (obj_cgroup_is_root(objcg))
> >               return true;
> >
> >       /*
> > @@ -3708,6 +3701,9 @@ static int mem_cgroup_css_online(struct cgroup_su=
bsys_state *css)
> >       if (!objcg)
> >               goto free_shrinker;
> >
> > +     if (unlikely(mem_cgroup_is_root(memcg)))
> > +             root_obj_cgroup =3D objcg;
> > +
> >       objcg->memcg =3D memcg;
> >       rcu_assign_pointer(memcg->objcg, objcg);
> >       obj_cgroup_get(objcg);
> > @@ -5302,6 +5298,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *o=
bjcg, size_t size)
> >       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >               return;
> >
> > +     if (obj_cgroup_is_root(objcg))
> > +             return;
> > +
> >       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> >
> >       /* PF_MEMALLOC context, charging must succeed */
> > @@ -5329,6 +5328,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup =
*objcg, size_t size)
> >       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >               return;
> >
> > +     if (obj_cgroup_is_root(objcg))
> > +             return;
> > +
> >       obj_cgroup_uncharge(objcg, size);
> >
> >       rcu_read_lock();
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index b35494c8ede2..3e54c6fca9bd 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1616,7 +1616,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size=
, gfp_t gfp,
> >               return true;
> >
> >       objcg =3D current_obj_cgroup();
> > -     if (!objcg)
> > +     if (obj_cgroup_is_root(objcg))
> >               return true;
> >
> >       if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))
>

