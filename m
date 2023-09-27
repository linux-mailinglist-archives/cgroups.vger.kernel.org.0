Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA17B0D71
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI0U3r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 16:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0U3q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 16:29:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D611F
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 13:29:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b29186e20aso829575966b.2
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695846580; x=1696451380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex9zHiaK+BBbsFTBRUbY+wXPSGG1TeaKimTgtt4LHz0=;
        b=H0tGsRWj3G+byWCnhCTZniaQq4TU+v63nsTOXIhfR1pX7K1IwxqU2IVkODUuRugq4D
         s59qR3Wk1znFqz7SObTKlk4yDqIpD3E2lHTw6WeT0Hohy5wuKn6Yq4oGLAqPM/c7bq4/
         goUhyeYhqsj7/eBPrAqChwbtKjejMlEar7Ej7luNkh1zIBFzRQusB/F6DNimlYboRmQI
         nOldZV4GvykPWMHCYpK+exqA/12PMAF1rgjQkAZ5RRnZ3N2P2wbbtMbbyQXXsBu5wr8z
         nKQDxdDm5OUCvO32YkxhSaRtfRVeteae3XITYc8m94aTqp5NY793ldluabk09Ts+z8Cm
         MOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695846580; x=1696451380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex9zHiaK+BBbsFTBRUbY+wXPSGG1TeaKimTgtt4LHz0=;
        b=Co2S1UtSksg+liCnAX+wLu8plbMRHTRHPEQaMQRZ1go+QjLooowp/qa2DrIe6cN+Ia
         BZK0b6kG0m+Hmgj/HVqmrpXP9jsW55rb+Ny4Jeiut/DPMiE5r44aOIuJMdWaJwF+kP4l
         I8VS/nvJ+Dt0UFRCxb+vItbNWYelw+xZSB5t7p+Ptt/JlNpbMZfVHgVwCPah2dbfq/st
         dxiM376PnOo5usqKMdEyzX/9QmmOeTcuoaPaO97+JLVv6yqkMVdyBgm1IAbbkh+u5IDq
         MXg74Hj6LBml+djC1ep6U5sQ7lZ/ZrkbbNp7ZRElPsDGzKTWoqIxZgn2g9U5KDmS8VrT
         ldDA==
X-Gm-Message-State: AOJu0YyTtapr4jyuXjjOUWma2VNdNINK4jdT/WfncxyNiGpxcdSQZbYe
        WZ4Ds19yDdmVABNyJQCY4PD4/B21IGEjVmC46qpLGw==
X-Google-Smtp-Source: AGHT+IFn3kr4ksnWwGH74wbeWPO63XS4o3pdkRWBen4g3Oovduy/ezAIdBGnlQwzVg9aSg7I+NQbhFVaKTgz6WhcjJo=
X-Received: by 2002:a17:906:10a:b0:9b2:b715:89ee with SMTP id
 10-20020a170906010a00b009b2b71589eemr2042321eje.69.1695846579737; Wed, 27 Sep
 2023 13:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230919171447.2712746-1-nphamcs@gmail.com> <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com> <CA+CLi1httFOg4OM-0Hu3+fOvya4kpacCqN7A0upqOt4-YJiECg@mail.gmail.com>
In-Reply-To: <CA+CLi1httFOg4OM-0Hu3+fOvya4kpacCqN7A0upqOt4-YJiECg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 27 Sep 2023 13:28:59 -0700
Message-ID: <CAJD7tkbpqMrRrp7Khsgn9Ow5r3ufCgMv+S3Vf_KRTxbrhFLngA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 12:48=E2=80=AFPM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Mon, Sep 25, 2023 at 10:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > +Chris Li
> >
> > On Tue, Sep 19, 2023 at 10:14=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > >
> > > Currently, we only have a single global LRU for zswap. This makes it
> > > impossible to perform worload-specific shrinking - an memcg cannot
> > > determine which pages in the pool it owns, and often ends up writing
> > > pages from other memcgs. This issue has been previously observed in
> > > practice and mitigated by simply disabling memcg-initiated shrinking:
> > >
> > > https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.co=
m/T/#u
> > >
> > > This patch fully resolves the issue by replacing the global zswap LRU
> > > with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
> > >
> > > a) When a store attempt hits an memcg limit, it now triggers a
> > >    synchronous reclaim attempt that, if successful, allows the new
> > >    hotter page to be accepted by zswap.
> > > b) If the store attempt instead hits the global zswap limit, it will
> > >    trigger an asynchronous reclaim attempt, in which an memcg is
> > >    selected for reclaim in a round-robin-like fashion.
> >
> > Hey Nhat,
> >
> > I didn't take a very close look as I am currently swamped, but going
> > through the patch I have some comments/questions below.
> >
> > I am not very familiar with list_lru, but it seems like the existing
> > API derives the node and memcg from the list item itself. Seems like
> > we can avoid a lot of changes if we allocate struct zswap_entry from
> > the same node as the page, and account it to the same memcg. Would
> > this be too much of a change or too strong of a restriction? It's a
> > slab allocation and we will free memory on that node/memcg right
> > after.
> >
> > >
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  include/linux/list_lru.h   |  39 +++++++
> > >  include/linux/memcontrol.h |   5 +
> > >  include/linux/zswap.h      |   9 ++
> > >  mm/list_lru.c              |  46 ++++++--
> > >  mm/swap_state.c            |  19 ++++
> > >  mm/zswap.c                 | 221 +++++++++++++++++++++++++++++------=
--
> > >  6 files changed, 287 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> > > index b35968ee9fb5..b517b4e2c7c4 100644
> > > --- a/include/linux/list_lru.h
> > > +++ b/include/linux/list_lru.h
> > > @@ -89,6 +89,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *m=
emcg, struct mem_cgroup *paren
> > >   */
> > >  bool list_lru_add(struct list_lru *lru, struct list_head *item);
> > >
> > > +/**
> > > + * __list_lru_add: add an element to a specific sublist.
> > > + * @list_lru: the lru pointer
> > > + * @item: the item to be added.
> > > + * @memcg: the cgroup of the sublist to add the item to.
> > > + * @nid: the node id of the sublist to add the item to.
> > > + *
> > > + * This function is similar to list_lru_add(), but it allows the cal=
ler to
> > > + * specify the sublist to which the item should be added. This can b=
e useful
> > > + * when the list_head node is not necessarily in the same cgroup and=
 NUMA node
> > > + * as the data it represents, such as zswap, where the list_head nod=
e could be
> > > + * from kswapd and the data from a different cgroup altogether.
> > > + *
> > > + * Return value: true if the list was updated, false otherwise
> > > + */
> > > +bool __list_lru_add(struct list_lru *lru, struct list_head *item, in=
t nid,
> > > +               struct mem_cgroup *memcg);
> > > +
> > >  /**
> > >   * list_lru_del: delete an element to the lru list
> > >   * @list_lru: the lru pointer
> > > @@ -102,6 +120,18 @@ bool list_lru_add(struct list_lru *lru, struct l=
ist_head *item);
> > >   */
> > >  bool list_lru_del(struct list_lru *lru, struct list_head *item);
> > >
> > > +/**
> > > + * __list_lru_delete: delete an element from a specific sublist.
> > > + * @list_lru: the lru pointer
> > > + * @item: the item to be deleted.
> > > + * @memcg: the cgroup of the sublist to delete the item from.
> > > + * @nid: the node id of the sublist to delete the item from.
> > > + *
> > > + * Return value: true if the list was updated, false otherwise.
> > > + */
> > > +bool __list_lru_del(struct list_lru *lru, struct list_head *item, in=
t nid,
> > > +               struct mem_cgroup *memcg);
> > > +
> > >  /**
> > >   * list_lru_count_one: return the number of objects currently held b=
y @lru
> > >   * @lru: the lru pointer.
> > > @@ -137,6 +167,15 @@ void list_lru_isolate(struct list_lru_one *list,=
 struct list_head *item);
> > >  void list_lru_isolate_move(struct list_lru_one *list, struct list_he=
ad *item,
> > >                            struct list_head *head);
> > >
> > > +/*
> > > + * list_lru_putback: undo list_lru_isolate.
> > > + *
> > > + * Since we might have dropped the LRU lock in between, recompute li=
st_lru_one
> > > + * from the node's id and memcg.
> > > + */
> > > +void list_lru_putback(struct list_lru *lru, struct list_head *item, =
int nid,
> > > +               struct mem_cgroup *memcg);
> > > +
> > >  typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
> > >                 struct list_lru_one *list, spinlock_t *lock, void *cb=
_arg);
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 67b823dfa47d..05d34b328d9d 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -1179,6 +1179,11 @@ static inline struct mem_cgroup *page_memcg_ch=
eck(struct page *page)
> > >         return NULL;
> > >  }
> > >
> > > +static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct ob=
j_cgroup *objcg)
> > > +{
> > > +       return NULL;
> > > +}
> > > +
> > >  static inline bool folio_memcg_kmem(struct folio *folio)
> > >  {
> > >         return false;
> > > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > > index 2a60ce39cfde..04f80b64a09b 100644
> > > --- a/include/linux/zswap.h
> > > +++ b/include/linux/zswap.h
> > > @@ -15,6 +15,8 @@ bool zswap_load(struct folio *folio);
> > >  void zswap_invalidate(int type, pgoff_t offset);
> > >  void zswap_swapon(int type);
> > >  void zswap_swapoff(int type);
> > > +bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry);
> > > +void zswap_insert_swpentry_into_lru(swp_entry_t swpentry);
> > >
> > >  #else
> > >
> > > @@ -32,6 +34,13 @@ static inline void zswap_invalidate(int type, pgof=
f_t offset) {}
> > >  static inline void zswap_swapon(int type) {}
> > >  static inline void zswap_swapoff(int type) {}
> > >
> > > +static inline bool zswap_remove_swpentry_from_lru(swp_entry_t swpent=
ry)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > > +static inline void zswap_insert_swpentry_into_lru(swp_entry_t swpent=
ry) {}
> > > +
> > >  #endif
> > >
> > >  #endif /* _LINUX_ZSWAP_H */
> > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > index a05e5bef3b40..37c5c2ef6c0e 100644
> > > --- a/mm/list_lru.c
> > > +++ b/mm/list_lru.c
> > > @@ -119,18 +119,26 @@ list_lru_from_kmem(struct list_lru *lru, int ni=
d, void *ptr,
> > >  bool list_lru_add(struct list_lru *lru, struct list_head *item)
> > >  {
> > >         int nid =3D page_to_nid(virt_to_page(item));
> > > +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> > > +               mem_cgroup_from_slab_obj(item) : NULL;
> > > +
> > > +       return __list_lru_add(lru, item, nid, memcg);
> > > +}
> > > +EXPORT_SYMBOL_GPL(list_lru_add);
> > > +
> > > +bool __list_lru_add(struct list_lru *lru, struct list_head *item, in=
t nid,
> > > +               struct mem_cgroup *memcg)
> > > +{
> > >         struct list_lru_node *nlru =3D &lru->node[nid];
> > > -       struct mem_cgroup *memcg;
> > >         struct list_lru_one *l;
> > >
> > >         spin_lock(&nlru->lock);
> > >         if (list_empty(item)) {
> > > -               l =3D list_lru_from_kmem(lru, nid, item, &memcg);
> > > +               l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id=
(memcg));
> > >                 list_add_tail(item, &l->list);
> > >                 /* Set shrinker bit if the first element was added */
> > >                 if (!l->nr_items++)
> > > -                       set_shrinker_bit(memcg, nid,
> > > -                                        lru_shrinker_id(lru));
> > > +                       set_shrinker_bit(memcg, nid, lru_shrinker_id(=
lru));
> >
> > Unrelated diff.
> >
> > >                 nlru->nr_items++;
> > >                 spin_unlock(&nlru->lock);
> > >                 return true;
> > > @@ -138,17 +146,27 @@ bool list_lru_add(struct list_lru *lru, struct =
list_head *item)
> > >         spin_unlock(&nlru->lock);
> > >         return false;
> > >  }
> > > -EXPORT_SYMBOL_GPL(list_lru_add);
> > > +EXPORT_SYMBOL_GPL(__list_lru_add);
> > >
> > >  bool list_lru_del(struct list_lru *lru, struct list_head *item)
> > >  {
> > >         int nid =3D page_to_nid(virt_to_page(item));
> > > +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> > > +               mem_cgroup_from_slab_obj(item) : NULL;
> > > +
> > > +       return __list_lru_del(lru, item, nid, memcg);
> > > +}
> > > +EXPORT_SYMBOL_GPL(list_lru_del);
> > > +
> > > +bool __list_lru_del(struct list_lru *lru, struct list_head *item, in=
t nid,
> > > +               struct mem_cgroup *memcg)
> > > +{
> > >         struct list_lru_node *nlru =3D &lru->node[nid];
> > >         struct list_lru_one *l;
> > >
> > >         spin_lock(&nlru->lock);
> > >         if (!list_empty(item)) {
> > > -               l =3D list_lru_from_kmem(lru, nid, item, NULL);
> >
> > If we decide to keep the list_lru.c changes, do we have any other
> > callers of list_lru_from_kmem()?
>
> I see a commit already in mm-unstable that removes it.
>
> >
> > > +               l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id=
(memcg));
> > >                 list_del_init(item);
> > >                 l->nr_items--;
> > >                 nlru->nr_items--;
> > > @@ -158,7 +176,7 @@ bool list_lru_del(struct list_lru *lru, struct li=
st_head *item)
> > >         spin_unlock(&nlru->lock);
> > >         return false;
> > >  }
> > > -EXPORT_SYMBOL_GPL(list_lru_del);
> > > +EXPORT_SYMBOL_GPL(__list_lru_del);
> > >
> > >  void list_lru_isolate(struct list_lru_one *list, struct list_head *i=
tem)
> > >  {
> > > @@ -175,6 +193,20 @@ void list_lru_isolate_move(struct list_lru_one *=
list, struct list_head *item,
> > >  }
> > >  EXPORT_SYMBOL_GPL(list_lru_isolate_move);
> > >
> > > +void list_lru_putback(struct list_lru *lru, struct list_head *item, =
int nid,
> > > +               struct mem_cgroup *memcg)
> > > +{
> > > +       struct list_lru_one *list =3D
> > > +               list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg=
));
> > > +
> > > +       if (list_empty(item)) {
> > > +               list_add_tail(item, &list->list);
> > > +               if (!list->nr_items++)
> > > +                       set_shrinker_bit(memcg, nid, lru_shrinker_id(=
lru));
> > > +       }
> > > +}
> > > +EXPORT_SYMBOL_GPL(list_lru_putback);
> > > +
> > >  unsigned long list_lru_count_one(struct list_lru *lru,
> > >                                  int nid, struct mem_cgroup *memcg)
> > >  {
> > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > index b3b14bd0dd64..1c826737aacb 100644
> > > --- a/mm/swap_state.c
> > > +++ b/mm/swap_state.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/swap_slots.h>
> > >  #include <linux/huge_mm.h>
> > >  #include <linux/shmem_fs.h>
> > > +#include <linux/zswap.h>
> > >  #include "internal.h"
> > >  #include "swap.h"
> > >
> > > @@ -417,6 +418,7 @@ struct page *__read_swap_cache_async(swp_entry_t =
entry, gfp_t gfp_mask,
> > >         struct folio *folio;
> > >         struct page *page;
> > >         void *shadow =3D NULL;
> > > +       bool zswap_lru_removed =3D false;
> > >
> > >         *new_page_allocated =3D false;
> > >         si =3D get_swap_device(entry);
> > > @@ -485,6 +487,17 @@ struct page *__read_swap_cache_async(swp_entry_t=
 entry, gfp_t gfp_mask,
> > >         __folio_set_locked(folio);
> > >         __folio_set_swapbacked(folio);
> > >
> > > +       /*
> > > +        * Page fault might itself trigger reclaim, on a zswap object=
 that
> > > +        * corresponds to the same swap entry. However, as the swap e=
ntry has
> > > +        * previously been pinned, the task will run into an infinite=
 loop trying
> > > +        * to pin the swap entry again.
> > > +        *
> > > +        * To prevent this from happening, we remove it from the zswa=
p
> > > +        * LRU to prevent its reclamation.
> > > +        */
> > > +       zswap_lru_removed =3D zswap_remove_swpentry_from_lru(entry);
> > > +
> >
> > This will add a zswap lookup (and potentially an insertion below) in
> > every single swap fault path, right?. Doesn't this introduce latency
> > regressions? I am also not a fan of having zswap-specific details in
> > this path.
> >
> > When you say "pinned", do you mean the call to swapcache_prepare()
> > above (i.e. setting SWAP_HAS_CACHE)? IIUC, the scenario you are
> > worried about is that the following call to charge the page may invoke
> > reclaim, go into zswap, and try to writeback the same page we are
> > swapping in here. The writeback call will recurse into
> > __read_swap_cache_async(), call swapcache_prepare() and get EEXIST,
> > and keep looping indefinitely. Is this correct?
> >
> > If yes, can we handle this by adding a flag to
> > __read_swap_cache_async() that basically says "don't wait for
> > SWAP_HAS_CACHE and the swapcache to be consistent, if
> > swapcache_prepare() returns EEXIST just fail and return"? The zswap
> > writeback path can pass in this flag and skip such pages. We might
> > want to modify the writeback code to put back those pages at the end
> > of the lru instead of in the beginning.
>
> Thanks for the suggestion, this actually works and it seems cleaner so I =
think
> we'll go for your solution.
>
> >
> > >         if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, ent=
ry))
> > >                 goto fail_unlock;
> > >
> > > @@ -497,6 +510,9 @@ struct page *__read_swap_cache_async(swp_entry_t =
entry, gfp_t gfp_mask,
> > >         if (shadow)
> > >                 workingset_refault(folio, shadow);
> > >
> > > +       if (zswap_lru_removed)
> > > +               zswap_insert_swpentry_into_lru(entry);
> > > +
> > >         /* Caller will initiate read into locked folio */
> > >         folio_add_lru(folio);
> > >         *new_page_allocated =3D true;
> > > @@ -506,6 +522,9 @@ struct page *__read_swap_cache_async(swp_entry_t =
entry, gfp_t gfp_mask,
> > >         return page;
> > >
> > >  fail_unlock:
> > > +       if (zswap_lru_removed)
> > > +               zswap_insert_swpentry_into_lru(entry);
> > > +
> > >         put_swap_folio(folio, entry);
> > >         folio_unlock(folio);
> > >         folio_put(folio);
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 412b1409a0d7..1a469e5d5197 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -34,6 +34,7 @@
> > >  #include <linux/writeback.h>
> > >  #include <linux/pagemap.h>
> > >  #include <linux/workqueue.h>
> > > +#include <linux/list_lru.h>
> > >
> > >  #include "swap.h"
> > >  #include "internal.h"
> > > @@ -171,8 +172,8 @@ struct zswap_pool {
> > >         struct work_struct shrink_work;
> > >         struct hlist_node node;
> > >         char tfm_name[CRYPTO_MAX_ALG_NAME];
> > > -       struct list_head lru;
> > > -       spinlock_t lru_lock;
> > > +       struct list_lru list_lru;
> > > +       struct mem_cgroup *next_shrink;
> > >  };
> > >
> > >  /*
> > > @@ -209,6 +210,7 @@ struct zswap_entry {
> > >                 unsigned long value;
> > >         };
> > >         struct obj_cgroup *objcg;
> > > +       int nid;
> > >         struct list_head lru;
> > >  };
> >
> > Ideally this can be avoided if we can allocate struct zswap_entry on
> > the correct node.
>
> We didn't consider allocating the entry on the node without charging it t=
o the
> memcg, we'll try it and if it's doable it would be a good compromise to a=
void
> adding the node id here.
>
> >
> > >
> > > @@ -309,6 +311,29 @@ static void zswap_entry_cache_free(struct zswap_=
entry *entry)
> > >         kmem_cache_free(zswap_entry_cache, entry);
> > >  }
> > >
> > > +/*********************************
> > > +* lru functions
> > > +**********************************/
> > > +static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_en=
try *entry)
> > > +{
> > > +       struct mem_cgroup *memcg =3D entry->objcg ?
> > > +               get_mem_cgroup_from_objcg(entry->objcg) : NULL;
> >
> > This line is repeated at least 3 times, perhaps add a helper for it?
> > get_mem_cgroup_from_zswap()?
> >
> > > +       bool added =3D __list_lru_add(list_lru, &entry->lru, entry->n=
id, memcg);
> > > +
> > > +       mem_cgroup_put(memcg);
> > > +       return added;
> > > +}
> > > +
> > > +static bool zswap_lru_del(struct list_lru *list_lru, struct zswap_en=
try *entry)
> > > +{
> > > +       struct mem_cgroup *memcg =3D entry->objcg ?
> > > +               get_mem_cgroup_from_objcg(entry->objcg) : NULL;
> > > +       bool removed =3D __list_lru_del(list_lru, &entry->lru, entry-=
>nid, memcg);
> > > +
> > > +       mem_cgroup_put(memcg);
> > > +       return removed;
> > > +}
> > > +
> > >  /*********************************
> > >  * rbtree functions
> > >  **********************************/
> > > @@ -393,9 +418,7 @@ static void zswap_free_entry(struct zswap_entry *=
entry)
> > >         if (!entry->length)
> > >                 atomic_dec(&zswap_same_filled_pages);
> > >         else {
> > > -               spin_lock(&entry->pool->lru_lock);
> > > -               list_del(&entry->lru);
> > > -               spin_unlock(&entry->pool->lru_lock);
> > > +               zswap_lru_del(&entry->pool->list_lru, entry);
> > >                 zpool_free(zswap_find_zpool(entry), entry->handle);
> > >                 zswap_pool_put(entry->pool);
> > >         }
> > > @@ -629,21 +652,16 @@ static void zswap_invalidate_entry(struct zswap=
_tree *tree,
> > >                 zswap_entry_put(tree, entry);
> > >  }
> > >
> > > -static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > +static enum lru_status shrink_memcg_cb(struct list_head *item, struc=
t list_lru_one *l,
> > > +                                      spinlock_t *lock, void *arg)
> > >  {
> > > -       struct zswap_entry *entry;
> > > +       struct zswap_entry *entry =3D container_of(item, struct zswap=
_entry, lru);
> > > +       struct mem_cgroup *memcg;
> > >         struct zswap_tree *tree;
> > >         pgoff_t swpoffset;
> > > -       int ret;
> > > +       enum lru_status ret =3D LRU_REMOVED_RETRY;
> > > +       int writeback_result;
> > >
> > > -       /* Get an entry off the LRU */
> > > -       spin_lock(&pool->lru_lock);
> > > -       if (list_empty(&pool->lru)) {
> > > -               spin_unlock(&pool->lru_lock);
> > > -               return -EINVAL;
> > > -       }
> > > -       entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
> > > -       list_del_init(&entry->lru);
> > >         /*
> > >          * Once the lru lock is dropped, the entry might get freed. T=
he
> > >          * swpoffset is copied to the stack, and entry isn't deref'd =
again
> > > @@ -651,26 +669,35 @@ static int zswap_reclaim_entry(struct zswap_poo=
l *pool)
> > >          */
> > >         swpoffset =3D swp_offset(entry->swpentry);
> > >         tree =3D zswap_trees[swp_type(entry->swpentry)];
> > > -       spin_unlock(&pool->lru_lock);
> > > +       list_lru_isolate(l, item);
> > > +       spin_unlock(lock);
> > >
> > >         /* Check for invalidate() race */
> > >         spin_lock(&tree->lock);
> > >         if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
> > > -               ret =3D -EAGAIN;
> > >                 goto unlock;
> > >         }
> > >         /* Hold a reference to prevent a free during writeback */
> > >         zswap_entry_get(entry);
> > >         spin_unlock(&tree->lock);
> > >
> > > -       ret =3D zswap_writeback_entry(entry, tree);
> > > +       writeback_result =3D zswap_writeback_entry(entry, tree);
> > >
> > >         spin_lock(&tree->lock);
> > > -       if (ret) {
> > > -               /* Writeback failed, put entry back on LRU */
> > > -               spin_lock(&pool->lru_lock);
> > > -               list_move(&entry->lru, &pool->lru);
> > > -               spin_unlock(&pool->lru_lock);
> > > +       if (writeback_result) {
> > > +               zswap_reject_reclaim_fail++;
> > > +
> > > +               /* Check for invalidate() race */
> > > +               if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffs=
et))
> > > +                       goto put_unlock;
> > > +
> > > +               memcg =3D entry->objcg ? get_mem_cgroup_from_objcg(en=
try->objcg) : NULL;
> > > +               spin_lock(lock);
> > > +               /* we cannot use zswap_lru_add here, because it incre=
ments node's lru count */
> > > +               list_lru_putback(&entry->pool->list_lru, item, entry-=
>nid, memcg);
> > > +               spin_unlock(lock);
> > > +               mem_cgroup_put(memcg);
> > > +               ret =3D LRU_RETRY;
> > >                 goto put_unlock;
> > >         }
> > >
> > > @@ -686,19 +713,63 @@ static int zswap_reclaim_entry(struct zswap_poo=
l *pool)
> > >         zswap_entry_put(tree, entry);
> > >  unlock:
> > >         spin_unlock(&tree->lock);
> > > -       return ret ? -EAGAIN : 0;
> > > +       spin_lock(lock);
> > > +       return ret;
> > > +}
> > > +
> > > +static int shrink_memcg(struct mem_cgroup *memcg)
> > > +{
> > > +       struct zswap_pool *pool;
> > > +       int nid, shrunk =3D 0;
> > > +       bool is_empty =3D true;
> > > +
> > > +       pool =3D zswap_pool_current_get();
> > > +       if (!pool)
> > > +               return -EINVAL;
> > > +
> > > +       for_each_node_state(nid, N_NORMAL_MEMORY) {
> > > +               unsigned long nr_to_walk =3D 1;
> > > +
> > > +               if (list_lru_walk_one(&pool->list_lru, nid, memcg, &s=
hrink_memcg_cb,
> > > +                                     NULL, &nr_to_walk))
> > > +                       shrunk++;
> > > +               if (!nr_to_walk)
> >
> > nr_to_walk will be 0 if we shrunk 1 page, so it's the same condition
> > as the above, right?
> >
> > is_empty seems to be shrunk =3D=3D 0 if I understand correctly, seems l=
ike
> > there is no need for both.
>
> It is indeed 0 when we shrunk 1 page, but it could also be 0 also when th=
e
> reclaim failed and the list was not empty.

I see.

I still think the function can be clearer / more aesthetic, but I
don't really know how off the top of my head :)

>
> >
> > > +                       is_empty =3D false;
> > > +       }
> > > +       zswap_pool_put(pool);
> > > +
> > > +       if (is_empty)
> > > +               return -EINVAL;
> > > +       if (shrunk)
> > > +               return 0;
> > > +       return -EAGAIN;
> > >  }
> > >
> > >  static void shrink_worker(struct work_struct *w)
> > >  {
> > >         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> > >                                                 shrink_work);
> > > -       int ret, failures =3D 0;
> > > +       int ret, failures =3D 0, memcg_selection_failures =3D 0;
> > >
> > > +       /* global reclaim will select cgroup in a round-robin fashion=
. */
> > >         do {
> > > -               ret =3D zswap_reclaim_entry(pool);
> > > +               /* previous next_shrink has become a zombie - restart=
 from the top */
> >
> > Do we skip zombies because all zswap entries are reparented with the ob=
jcg?
> >
> > If yes, why do we restart from the top instead of just skipping them?
> > memcgs after a zombie will not be reachable now IIUC.
> >
> > Also, why explicitly check for zombies instead of having
> > shrink_memcg() just skip memcgs with no zswap entries? The logic is
> > slightly complicated.
>
> I think you have a point here, I'm not sure if the iteration can go on on=
ce we
> get a zombie, if it can, we'll just skip it.

If the point of skipping zombies is that we know their list_lrus are
reparented, so we will end up scanning their parents again, then I
believe we can just skip them. This should be "hidden" within
shrink_memcg() in my opinion, with a clear comment explaining why we
skip zombies.

>
> >
> > > +               if (pool->next_shrink && !mem_cgroup_online(pool->nex=
t_shrink)) {
> > > +                       mem_cgroup_put(pool->next_shrink);
> > > +                       pool->next_shrink =3D NULL;
> > > +               }
> > > +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->nex=
t_shrink, NULL);
> > > +
> > > +               /* fails to find a suitable cgroup - give the worker =
another chance. */
> > > +               if (!pool->next_shrink) {
> > > +                       if (++memcg_selection_failures =3D=3D 2)
> > > +                               break;
> > > +                       continue;
> > > +               }
> > > +
> > > +               ret =3D shrink_memcg(pool->next_shrink);
> > > +
> > >                 if (ret) {
> > > -                       zswap_reject_reclaim_fail++;
> > >                         if (ret !=3D -EAGAIN)
> > >                                 break;
> > >                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > > @@ -764,9 +835,8 @@ static struct zswap_pool *zswap_pool_create(char =
*type, char *compressor)
> > >          */
> > >         kref_init(&pool->kref);
> > >         INIT_LIST_HEAD(&pool->list);
> > > -       INIT_LIST_HEAD(&pool->lru);
> > > -       spin_lock_init(&pool->lru_lock);
> > >         INIT_WORK(&pool->shrink_work, shrink_worker);
> > > +       list_lru_init_memcg(&pool->list_lru, NULL);
> > >
> > >         zswap_pool_debug("created", pool);
> > >
> > > @@ -831,6 +901,9 @@ static void zswap_pool_destroy(struct zswap_pool =
*pool)
> > >
> > >         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool=
->node);
> > >         free_percpu(pool->acomp_ctx);
> > > +       list_lru_destroy(&pool->list_lru);
> > > +       if (pool->next_shrink)
> > > +               mem_cgroup_put(pool->next_shrink);
> > >         for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > >                 zpool_destroy_pool(pool->zpools[i]);
> > >         kfree(pool);
> > > @@ -1199,8 +1272,10 @@ bool zswap_store(struct folio *folio)
> > >         struct scatterlist input, output;
> > >         struct crypto_acomp_ctx *acomp_ctx;
> > >         struct obj_cgroup *objcg =3D NULL;
> > > +       struct mem_cgroup *memcg =3D NULL;
> > >         struct zswap_pool *pool;
> > >         struct zpool *zpool;
> > > +       int lru_alloc_ret;
> > >         unsigned int dlen =3D PAGE_SIZE;
> > >         unsigned long handle, value;
> > >         char *buf;
> > > @@ -1218,14 +1293,15 @@ bool zswap_store(struct folio *folio)
> > >         if (!zswap_enabled || !tree)
> > >                 return false;
> > >
> > > -       /*
> > > -        * XXX: zswap reclaim does not work with cgroups yet. Without=
 a
> > > -        * cgroup-aware entry LRU, we will push out entries system-wi=
de based on
> > > -        * local cgroup limits.
> > > -        */
> > >         objcg =3D get_obj_cgroup_from_folio(folio);
> > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > -               goto reject;
> > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > > +               if (shrink_memcg(memcg)) {
> > > +                       mem_cgroup_put(memcg);
> > > +                       goto reject;
> > > +               }
> > > +               mem_cgroup_put(memcg);
> > > +       }
> > >
> > >         /* reclaim space if needed */
> > >         if (zswap_is_full()) {
> > > @@ -1240,7 +1316,11 @@ bool zswap_store(struct folio *folio)
> > >                 else
> > >                         zswap_pool_reached_full =3D false;
> > >         }
> > > -
> > > +       pool =3D zswap_pool_current_get();
> > > +       if (!pool) {
> > > +               ret =3D -EINVAL;
> > > +               goto reject;
> > > +       }
> > >         /* allocate entry */
> > >         entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> > >         if (!entry) {
> > > @@ -1256,6 +1336,7 @@ bool zswap_store(struct folio *folio)
> > >                         entry->length =3D 0;
> > >                         entry->value =3D value;
> > >                         atomic_inc(&zswap_same_filled_pages);
> > > +                       zswap_pool_put(pool);
> > >                         goto insert_entry;
> > >                 }
> > >                 kunmap_atomic(src);
> > > @@ -1264,6 +1345,15 @@ bool zswap_store(struct folio *folio)
> > >         if (!zswap_non_same_filled_pages_enabled)
> > >                 goto freepage;
> > >
> > > +       if (objcg) {
> > > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > > +               lru_alloc_ret =3D memcg_list_lru_alloc(memcg, &pool->=
list_lru, GFP_KERNEL);
> > > +               mem_cgroup_put(memcg);
> > > +
> > > +               if (lru_alloc_ret)
> > > +                       goto freepage;
> > > +       }
> > > +
> > >         /* if entry is successfully added, it keeps the reference */
> > >         entry->pool =3D zswap_pool_current_get();
> > >         if (!entry->pool)
> > > @@ -1325,6 +1415,7 @@ bool zswap_store(struct folio *folio)
> > >
> > >  insert_entry:
> > >         entry->objcg =3D objcg;
> > > +       entry->nid =3D page_to_nid(page);
> > >         if (objcg) {
> > >                 obj_cgroup_charge_zswap(objcg, entry->length);
> > >                 /* Account before objcg ref is moved to tree */
> > > @@ -1338,9 +1429,8 @@ bool zswap_store(struct folio *folio)
> > >                 zswap_invalidate_entry(tree, dupentry);
> > >         }
> > >         if (entry->length) {
> > > -               spin_lock(&entry->pool->lru_lock);
> > > -               list_add(&entry->lru, &entry->pool->lru);
> > > -               spin_unlock(&entry->pool->lru_lock);
> > > +               INIT_LIST_HEAD(&entry->lru);
> > > +               zswap_lru_add(&pool->list_lru, entry);
> > >         }
> > >         spin_unlock(&tree->lock);
> > >
> > > @@ -1447,9 +1537,8 @@ bool zswap_load(struct folio *folio)
> > >                 zswap_invalidate_entry(tree, entry);
> > >                 folio_mark_dirty(folio);
> > >         } else if (entry->length) {
> > > -               spin_lock(&entry->pool->lru_lock);
> > > -               list_move(&entry->lru, &entry->pool->lru);
> > > -               spin_unlock(&entry->pool->lru_lock);
> > > +               zswap_lru_del(&entry->pool->list_lru, entry);
> > > +               zswap_lru_add(&entry->pool->list_lru, entry);
> > >         }
> > >         zswap_entry_put(tree, entry);
> > >         spin_unlock(&tree->lock);
> > > @@ -1507,6 +1596,48 @@ void zswap_swapoff(int type)
> > >         zswap_trees[type] =3D NULL;
> > >  }
> > >
> > > +bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry)
> > > +{
> > > +       struct zswap_tree *tree =3D zswap_trees[swp_type(swpentry)];
> > > +       struct zswap_entry *entry;
> > > +       struct zswap_pool *pool;
> > > +       bool removed =3D false;
> > > +
> > > +       /* get the zswap entry and prevent it from being freed */
> > > +       spin_lock(&tree->lock);
> > > +       entry =3D zswap_rb_search(&tree->rbroot, swp_offset(swpentry)=
);
> > > +       /* skip if the entry is already written back or is a same fil=
led page */
> > > +       if (!entry || !entry->length)
> > > +               goto tree_unlock;
> > > +
> > > +       pool =3D entry->pool;
> > > +       removed =3D zswap_lru_del(&pool->list_lru, entry);
> > > +
> > > +tree_unlock:
> > > +       spin_unlock(&tree->lock);
> > > +       return removed;
> > > +}
> > > +
> > > +void zswap_insert_swpentry_into_lru(swp_entry_t swpentry)
> > > +{
> > > +       struct zswap_tree *tree =3D zswap_trees[swp_type(swpentry)];
> > > +       struct zswap_entry *entry;
> > > +       struct zswap_pool *pool;
> > > +
> > > +       /* get the zswap entry and prevent it from being freed */
> > > +       spin_lock(&tree->lock);
> > > +       entry =3D zswap_rb_search(&tree->rbroot, swp_offset(swpentry)=
);
> > > +       /* skip if the entry is already written back or is a same fil=
led page */
> > > +       if (!entry || !entry->length)
> > > +               goto tree_unlock;
> > > +
> > > +       pool =3D entry->pool;
> > > +       zswap_lru_add(&pool->list_lru, entry);
> > > +
> > > +tree_unlock:
> > > +       spin_unlock(&tree->lock);
> > > +}
> > > +
> > >  /*********************************
> > >  * debugfs functions
> > >  **********************************/
> > > @@ -1560,7 +1691,7 @@ static int zswap_setup(void)
> > >         struct zswap_pool *pool;
> > >         int ret;
> > >
> > > -       zswap_entry_cache =3D KMEM_CACHE(zswap_entry, 0);
> > > +       zswap_entry_cache =3D KMEM_CACHE(zswap_entry, SLAB_ACCOUNT);
> > >         if (!zswap_entry_cache) {
> > >                 pr_err("entry cache creation failed\n");
> > >                 goto cache_fail;
> > > --
> > > 2.34.1
