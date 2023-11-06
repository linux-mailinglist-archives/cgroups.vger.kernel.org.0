Return-Path: <cgroups+bounces-195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16A7E2E26
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 21:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E73B209FA
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5981B2E631;
	Mon,  6 Nov 2023 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWFOBx5L"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963202E62B
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 20:26:14 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63588D76
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 12:26:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso467448066b.3
        for <cgroups@vger.kernel.org>; Mon, 06 Nov 2023 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699302370; x=1699907170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5TYX6lEuKCahV5efuUP6jLDN7dIzcQfoIdtrIEy2yE=;
        b=JWFOBx5LE6U+yKxQgaLz8qQhRYG7kQeSU2749JDJXc9bJuc+akMVtJoULQXgF5wdGI
         qKAdCjLBemx+LLwIg4D2VWiaTpPnvvb5sQK/7b/MfX8w0fUfCno798BvYzp92czuMw0U
         T89WUcQgIOiLeRSxo+NzNxb9QO8ibNdLU1HVacqiYBqyivQ+U77HMyZLWB6IOyIU01Gn
         mtndT2vytrhuc+A7gPXmaKYW3izgOtLAK/nhfxsRxynr2tkMdKl/2tDolmmUNJ6+TxS3
         n9T8zP/r0kWtrJTqfOG8yb7ZvehBS/E44pZ+cICaAJ6j4ZHaltZjBISsSMRbNqPlG2Fy
         Y9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699302370; x=1699907170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5TYX6lEuKCahV5efuUP6jLDN7dIzcQfoIdtrIEy2yE=;
        b=NmWVZ6EmXF94w/qmjkTgPdd9IJHJexxsZhavAQfa7wk7f668lpHIWM3WWCX9NKm7ku
         kvhaX/BmqM7U4lncH8a7n0Wb/SKPinFsYIKkWiawCJ5QTR1Kb8M7thjnpobrOQT6qu7q
         zRaI9OJw/jimV2mNmgQBlRZThRY+vDwDb88KqFnuGceNM2VqH0xkdcfFsPMIxqZwoOuZ
         +XSA2HAKeYpx9QFeqSip7/G1EzYy1uSdeMK4gJDGfdPpo0m8CP7W5d5K0v11KixUr/gv
         fWZC6Io9tavat2L9zoJiGLlXr9wjfWsYA9Ti/xO+yp0MHqMyYrG3K25ZDuPinL1Gy+yV
         Sgjg==
X-Gm-Message-State: AOJu0Ywm0mwFiO+nEhiI5ngk6DYw9OAHpCus1cnjyF2dVHNGADWbiKsG
	LqgCizH8n142bdpx3KGDdQAqHNFazMnFO+EnGDC3fQ==
X-Google-Smtp-Source: AGHT+IE/P/U+nspRnmXie0ihSzjkMxQma5uYY9b94Sf1X7ObMkz1sGnPPXsA59befGpud1esC1lLX+/xCb8XugZ3QVg=
X-Received: by 2002:a17:907:26c9:b0:9e0:dcf:17d5 with SMTP id
 bp9-20020a17090726c900b009e00dcf17d5mr3945353ejc.43.1699302369549; Mon, 06
 Nov 2023 12:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <20231106183159.3562879-4-nphamcs@gmail.com>
In-Reply-To: <20231106183159.3562879-4-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 Nov 2023 12:25:33 -0800
Message-ID: <CAJD7tkYcEc03d+6kwkXu8M_fd9ZDzh6B5G+VjmFXx+H09mhfmg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] zswap: make shrinking memcg-aware
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 10:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> Currently, we only have a single global LRU for zswap. This makes it
> impossible to perform worload-specific shrinking - an memcg cannot
> determine which pages in the pool it owns, and often ends up writing
> pages from other memcgs. This issue has been previously observed in
> practice and mitigated by simply disabling memcg-initiated shrinking:
>
> https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/=
#u
>
> This patch fully resolves the issue by replacing the global zswap LRU
> with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
>
> a) When a store attempt hits an memcg limit, it now triggers a
>    synchronous reclaim attempt that, if successful, allows the new
>    hotter page to be accepted by zswap.
> b) If the store attempt instead hits the global zswap limit, it will
>    trigger an asynchronous reclaim attempt, in which an memcg is
>    selected for reclaim in a round-robin-like fashion.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/memcontrol.h |   5 +
>  include/linux/zswap.h      |   2 +
>  mm/memcontrol.c            |   2 +
>  mm/swap.h                  |   3 +-
>  mm/swap_state.c            |  24 +++-
>  mm/zswap.c                 | 252 +++++++++++++++++++++++++++++--------
>  6 files changed, 227 insertions(+), 61 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 55c85f952afd..95f6c9e60ed1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1187,6 +1187,11 @@ static inline struct mem_cgroup *page_memcg_check(=
struct page *page)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cg=
roup *objcg)
> +{
> +       return NULL;
> +}
> +
>  static inline bool folio_memcg_kmem(struct folio *folio)
>  {
>         return false;
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 2a60ce39cfde..e571e393669b 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -15,6 +15,7 @@ bool zswap_load(struct folio *folio);
>  void zswap_invalidate(int type, pgoff_t offset);
>  void zswap_swapon(int type);
>  void zswap_swapoff(int type);
> +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>
>  #else
>
> @@ -31,6 +32,7 @@ static inline bool zswap_load(struct folio *folio)
>  static inline void zswap_invalidate(int type, pgoff_t offset) {}
>  static inline void zswap_swapon(int type) {}
>  static inline void zswap_swapoff(int type) {}
> +static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>
>  #endif
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f7fc0101252..2ef49b471a16 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5640,6 +5640,8 @@ static void mem_cgroup_css_offline(struct cgroup_su=
bsys_state *css)
>         page_counter_set_min(&memcg->memory, 0);
>         page_counter_set_low(&memcg->memory, 0);
>
> +       zswap_memcg_offline_cleanup(memcg);

I think the "_cleanup" suffix is unnecessary. I guess most calls made
here are cleanup calls anyway.

> +
>         memcg_offline_kmem(memcg);
>         reparent_shrinker_deferred(memcg);
>         wb_memcg_offline(memcg);
> diff --git a/mm/swap.h b/mm/swap.h
> index 73c332ee4d91..c0dc73e10e91 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h

> @@ -289,15 +291,42 @@ static void zswap_update_total_size(void)
>         zswap_pool_total_size =3D total;
>  }
>
> +/* should be called under RCU */
> +static inline struct mem_cgroup *get_mem_cgroup_from_entry(struct zswap_=
entry *entry)

Do not use "get" in the name if we are not actually taking a ref here.
mem_cgroup_from_entry()?

> +{
> +       return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
> +}
> +
> +static inline int entry_to_nid(struct zswap_entry *entry)
> +{
> +       return page_to_nid(virt_to_page(entry));
> +}
> +
> +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> +{
> +       struct zswap_pool *pool;
> +
> +       /* lock out zswap pools list modification */
> +       spin_lock(&zswap_pools_lock);
> +       list_for_each_entry(pool, &zswap_pools, list) {
> +               spin_lock(&pool->next_shrink_lock);

This lock is only needed to synchronize updating pool->next_shrink,
right? Can we just use atomic operations instead? (e.g. cmpxchg()).

> +               if (pool->next_shrink =3D=3D memcg)
> +                       pool->next_shrink =3D
> +                               mem_cgroup_iter(NULL, pool->next_shrink, =
NULL, true);
> +               spin_unlock(&pool->next_shrink_lock);
> +       }
> +       spin_unlock(&zswap_pools_lock);
> +}
> +
>  /*********************************
>  * zswap entry functions
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>
> -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
> +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
>  {
>         struct zswap_entry *entry;
> -       entry =3D kmem_cache_alloc(zswap_entry_cache, gfp);
> +       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>         if (!entry)
>                 return NULL;
>         entry->refcount =3D 1;
[..]
> @@ -1233,15 +1369,15 @@ bool zswap_store(struct folio *folio)
>                 zswap_invalidate_entry(tree, dupentry);
>         }
>         spin_unlock(&tree->lock);
> -
> -       /*
> -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> -        * cgroup-aware entry LRU, we will push out entries system-wide b=
ased on
> -        * local cgroup limits.
> -        */
>         objcg =3D get_obj_cgroup_from_folio(folio);
> -       if (objcg && !obj_cgroup_may_zswap(objcg))
> -               goto reject;
> +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> +               if (shrink_memcg(memcg)) {
> +                       mem_cgroup_put(memcg);
> +                       goto reject;
> +               }
> +               mem_cgroup_put(memcg);

Can we just use RCU here as well? (same around memcg_list_lru_alloc()
call below).

> +       }
>
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
> @@ -1258,7 +1394,7 @@ bool zswap_store(struct folio *folio)
>         }
>
>         /* allocate entry */
> -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
>         if (!entry) {
>                 zswap_reject_kmemcache_fail++;
>                 goto reject;
> @@ -1285,6 +1421,15 @@ bool zswap_store(struct folio *folio)
>         if (!entry->pool)
>                 goto freepage;
>
> +       if (objcg) {
> +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> +               if (memcg_list_lru_alloc(memcg, &entry->pool->list_lru, G=
FP_KERNEL)) {
> +                       mem_cgroup_put(memcg);
> +                       goto put_pool;
> +               }
> +               mem_cgroup_put(memcg);
> +       }
> +
>         /* compress */
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>

