Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF797AE305
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 02:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIZAn0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 20:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAn0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 20:43:26 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA910A;
        Mon, 25 Sep 2023 17:43:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3512740906dso16742585ab.0;
        Mon, 25 Sep 2023 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695688996; x=1696293796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrrQfLkOf74sV4Rz98CkKWEbP1XnwC88b8t0rYDwJgI=;
        b=A20VJqR0/VmJfM97XwM5clZDHlNi6cn3wD2KOXUWv6KLHD2BfVQAXnJQ3cVSgbFTq2
         WBJLP7s3lTb7Qs2u93Fh4sHpjSQtWuS70iWEBwDMBWeryx+GVIfbSHg3OnboLooUQxql
         p6nYlMNPNe96E16k+YwW/lYh9PnJt755MpvAwW2bIseAYutVeFqI8pQTgi4xMhxHT2gC
         OarZ7Ynp8WmoIvWCiugJpctWTRncU858gWVaE5UG5lMupTSvhhlvnXKSVJFU7tadVw8E
         ca4BoJyuj3OnWprndl2rHgR6msbknXGW4E/h5FHVhsd0qTUhWbaZ+dmfuaN4WiVgEH+7
         EieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695688996; x=1696293796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrrQfLkOf74sV4Rz98CkKWEbP1XnwC88b8t0rYDwJgI=;
        b=GH00gUHXOe78p/cOGuq04Gb0z6QZXUxNRSruHhZszUPK0lClxMGSAWjbWjMNmvhJZd
         kkLyBfg4otG3yeYjZf1pmBHxuG6rpPdAjHghAhLJgCjX0e6hQe++LWaYP1UNSWOaxYyL
         xv7nrQf9HZFNBAnvyjWVW5UtRriWiaeXiKcKzT7XGYXLQy2i/jgyKIYfyWzURCg71bdx
         RXqR1UhqA79lXfUiedR3HmTZZYIQVPnyffR4AMfgRsfMU+5I4Ed50u/wxVQ3A+WV4G7M
         isy5au9wo59tUymzTRCZYcAy5onP3dHOY5mM7jsgtOS8lStowD7KQ77J/MdTcKwx+ucD
         eR3A==
X-Gm-Message-State: AOJu0YxMU8HzIQBEAVUVUEbsuWdQpgElD/f6LKyN2Bn26FhdA1ky8KMp
        fWamZH4pTFAItYa2m70cCslboXNJLe6ipQqCprNNzZVsPvArSg==
X-Google-Smtp-Source: AGHT+IH/YCaJv5YLmGK7KVqxqM6lOmJrj8cAemXTvWiUi7hSHQBUg10FWmvhz79FxyoPw1vExiuKFVpuwpX/kSVbZ+8=
X-Received: by 2002:a05:6e02:1a2e:b0:34b:af03:e2a with SMTP id
 g14-20020a056e021a2e00b0034baf030e2amr11620769ile.31.1695688996376; Mon, 25
 Sep 2023 17:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230919171447.2712746-1-nphamcs@gmail.com> <20230919171447.2712746-3-nphamcs@gmail.com>
 <CAJD7tkY2-S0+NgGvMZMv6YBO1Z8aLAgbQ2KCR6gJm2BuAy9BKw@mail.gmail.com>
 <CAKEwX=M14r1b5Y=9pu9afznn4b9pnuwAkEDL0+q2rJA2=pMRBA@mail.gmail.com> <CAJD7tkaQtqZ-J8Ey+zZk=c3GKpvvR4i3zmT6HFvbCewMeQmeTA@mail.gmail.com>
In-Reply-To: <CAJD7tkaQtqZ-J8Ey+zZk=c3GKpvvR4i3zmT6HFvbCewMeQmeTA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 25 Sep 2023 17:43:05 -0700
Message-ID: <CAKEwX=OGKG_AAu7_3LmTXvX+qmG3Zp-LtYjWNcEA=VnTk2afew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] zswap: shrinks zswap pool based on memory pressure
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 25, 2023 at 5:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Sep 25, 2023 at 4:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Sep 25, 2023 at 1:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Sep 19, 2023 at 10:14=E2=80=AFAM Nhat Pham <nphamcs@gmail.com=
> wrote:
> > > >
> > > > Currently, we only shrink the zswap pool when the user-defined limi=
t is
> > > > hit. This means that if we set the limit too high, cold data that a=
re
> > > > unlikely to be used again will reside in the pool, wasting precious
> > > > memory. It is hard to predict how much zswap space will be needed a=
head
> > > > of time, as this depends on the workload (specifically, on factors =
such
> > > > as memory access patterns and compressibility of the memory pages).
> > > >
> > > > This patch implements a memcg- and NUMA-aware shrinker for zswap, t=
hat
> > > > is initiated when there is memory pressure. The shrinker does not
> > > > have any parameter that must be tuned by the user, and can be opted=
 in
> > > > or out on a per-memcg basis.
> > >
> > > What's the use case for having per-memcg opt-in/out?
> > >
> > > If there is memory pressure, reclaiming swap-backed pages will push
> > > pages out of zswap anyway, regardless of this patch. With this patch,
> > > any sort of reclaim can push pages out of zswap. Wouldn't that be
> > > preferable to reclaiming memory that is currently resident in memory
> > > (so arguably hotter than the pages in zswap)? Why would this decision
> > > be different per-memcg?
> > I'm not quite following your argument here. The point of having this
> > be done on a per-memcg basis is that we have different workloads
> > with different memory access pattern (and as a result, different memory
> > coldness distribution).
> >
> > In a workload where there is a lot of cold data, we can really benefit
> > from reclaiming all of those pages and repurpose the memory reclaimed
> > (for e.g for filecache).
> >
> > On the other hand, in a workload where there aren't a lot of cold data,
> > reclaiming its zswapped pages will at best do nothing (wasting CPU
> > cycles on compression/decompression), and at worst hurt performance
> > (due to increased IO when we need those writtenback pages again).
> >
> > Such different workloads could co-exist in the same system, and having
> > a per-memcg knob allows us to crank on the shrinker only on workloads
> > where it makes sense.
>
> I am not sure we are on the same page here.
>
> What you're describing sounds more like proactive reclaim, which we
> wouldn't invoke unless the workload has cold data anyway.
>
> IIUC, outside of that, this shrinker will run when there is memory
> pressure. This means that we need to free memory anyway, regardless of
> its absolute coldness. We want to evict the colder pages in the memcg.
> It seems to be that in ~all cases, evicting pages in zswap will be
> better than evicting pages in memory, as the pages in memory are
> arguably hotter (since they weren't reclaimed first). This seems to be
> something that would be true for all workloads.
>
> What am I missing?

Yup, the shrinker is initiated under memory pressure.
And with it, we can reclaim memory from zswap when
it's (often) not at max capacity.

The kernel has no knowledge of absolute coldness, only relative
coldness thanks to LRU. We don't have a global LRU of all possible
memory pages/objects for a particular memcg either, so we cannot
compare the coldness of objects from different sources.

The "coldest" pages in zswap LRU could very well be warm enough
that swapping them out degrades performance, while there are even
colder memory from other sources (other shrinkers registered for this
memcg). Alternatively, we can also "evict" uncompressed anonymous
memory, which will go to the zswap pool. This also saves memory,
and could potentially be better than zswap reclaim (2 compressed
pages might be better performance-wise than 1 uncompressed,
1 swapped out)

All of this depends on the memory access pattern of the workloads,
which could differ cgroup-by-cgroup within the same system.
Having a per-memcg knob is a way for admins to influence this
decision from userspace, if the admins have knowledge about
workload memory access patterns.

For e.g, if we know that there is one particular cgroup that populates
a bunch of single-use tmpfs pages, then we can target that cgroup
specifically, while leaving the other cgroups in the system alone.

>
> > >
> > > >
> > > > Furthermore, to make it more robust for many workloads and prevent
> > > > overshrinking (i.e evicting warm pages that might be refaulted into
> > > > memory), we build in the following heuristics:
> > > >
> > > > * Estimate the number of warm pages residing in zswap, and attempt =
to
> > > >   protect this region of the zswap LRU.
> > > > * Scale the number of freeable objects by an estimate of the memory
> > > >   saving factor. The better zswap compresses the data, the fewer pa=
ges
> > > >   we will evict to swap (as we will otherwise incur IO for relative=
ly
> > > >   small memory saving).
> > > > * During reclaim, if the shrinker encounters a page that is also be=
ing
> > > >   brought into memory, the shrinker will cautiously terminate its
> > > >   shrinking action, as this is a sign that it is touching the warme=
r
> > > >   region of the zswap LRU.
> > >
> > > I don't have an opinion about the reclaim heuristics here, I will let
> > > reclaim experts chip in.
> > >
> > > >
> > > > On a benchmark that we have run:
> > >
> > > Please add more details (as much as possible) about the benchmarks us=
ed here.
> > Sure! I built the kernel in a memory-limited cgroup a couple times,
> > then measured the build time.
> >
> > To simulate conditions where there are cold, unused data, I
> > also generated a bunch of data in tmpfs (and never touch them
> > again).
>
> Please include such details in the commit message, there is also
> another reference below to "another" benchmark.

Will do if/when I send v3.
The "another" benchmark is just generating even more tmpfs cold data :)

>
>
> > >
> > > >
> > > > (without the shrinker)
> > > > real -- mean: 153.27s, median: 153.199s
> > > > sys -- mean: 541.652s, median: 541.903s
> > > > user -- mean: 4384.9673999999995s, median: 4385.471s
> > > >
> > > > (with the shrinker)
> > > > real -- mean: 151.4956s, median: 151.456s
> > > > sys -- mean: 461.14639999999997s, median: 465.656s
> > > > user -- mean: 4384.7118s, median: 4384.675s
> > > >
> > > > We observed a 14-15% reduction in kernel CPU time, which translated=
 to
> > > > over 1% reduction in real time.
> > > >
> > > > On another benchmark, where there was a lot more cold memory residi=
ng in
> > > > zswap, we observed even more pronounced gains:
> > > >
> > > > (without the shrinker)
> > > > real -- mean: 157.52519999999998s, median: 157.281s
> > > > sys -- mean: 769.3082s, median: 780.545s
> > > > user -- mean: 4378.1622s, median: 4378.286s
> > > >
> > > > (with the shrinker)
> > > > real -- mean: 152.9608s, median: 152.845s
> > > > sys -- mean: 517.4446s, median: 506.749s
> > > > user -- mean: 4387.694s, median: 4387.935s
> > > >
> > > > Here, we saw around 32-35% reduction in kernel CPU time, which
> > > > translated to 2.8% reduction in real time. These results confirm ou=
r
> > > > hypothesis that the shrinker is more helpful the more cold memory w=
e
> > > > have.
> > > >
> > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  Documentation/admin-guide/mm/zswap.rst |  12 ++
> > > >  include/linux/memcontrol.h             |   1 +
> > > >  include/linux/mmzone.h                 |  14 ++
> > > >  mm/memcontrol.c                        |  33 +++++
> > > >  mm/swap_state.c                        |  31 ++++-
> > > >  mm/zswap.c                             | 180 +++++++++++++++++++++=
+++-
> > > >  6 files changed, 263 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation=
/admin-guide/mm/zswap.rst
> > > > index 45b98390e938..ae8597a67804 100644
> > > > --- a/Documentation/admin-guide/mm/zswap.rst
> > > > +++ b/Documentation/admin-guide/mm/zswap.rst
> > > > @@ -153,6 +153,18 @@ attribute, e. g.::
> > > >
> > > >  Setting this parameter to 100 will disable the hysteresis.
> > > >
> > > > +When there is a sizable amount of cold memory residing in the zswa=
p pool, it
> > > > +can be advantageous to proactively write these cold pages to swap =
and reclaim
> > > > +the memory for other use cases. By default, the zswap shrinker is =
disabled.
> > > > +User can enable it by first switching on the global knob:
> > > > +
> > > > +  echo Y > /sys/module/zswap/par meters/shrinker_enabled
> > > > +
> > > > +When the kernel is compiled with CONFIG_MEMCG_KMEM, user needs to =
further turn
> > > > +it on for each cgroup that the shrinker should target:
> > > > +
> > > > +  echo 1 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.shrinker.enab=
led
> > > > +
> > > >  A debugfs interface is provided for various statistic about pool s=
ize, number
> > > >  of pages stored, same-value filled pages and various counters for =
the reasons
> > > >  pages are rejected.
> > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.=
h
> > > > index 05d34b328d9d..f005ea667863 100644
> > > > --- a/include/linux/memcontrol.h
> > > > +++ b/include/linux/memcontrol.h
> > > > @@ -219,6 +219,7 @@ struct mem_cgroup {
> > > >
> > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > >         unsigned long zswap_max;
> > > > +       atomic_t zswap_shrinker_enabled;
> > > >  #endif
> > > >
> > > >         unsigned long soft_limit;
> > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > index 4106fbc5b4b3..81f4c5ea3e16 100644
> > > > --- a/include/linux/mmzone.h
> > > > +++ b/include/linux/mmzone.h
> > > > @@ -637,6 +637,20 @@ struct lruvec {
> > > >  #ifdef CONFIG_MEMCG
> > > >         struct pglist_data *pgdat;
> > > >  #endif
> > > > +#ifdef CONFIG_ZSWAP
> > > > +       /*
> > > > +        * Number of pages in zswap that should be protected from t=
he shrinker.
> > > > +        * This number is an estimate of the following counts:
> > > > +        *
> > > > +        * a) Recent page faults.
> > > > +        * b) Recent insertion to the zswap LRU. This includes new =
zswap stores,
> > > > +        *    as well as recent zswap LRU rotations.
> > > > +        *
> > > > +        * These pages are likely to be warm, and might incur IO if=
 the are written
> > > > +        * to swap.
> > > > +        */
> > > > +       unsigned long nr_zswap_protected;
> > > > +#endif
> > >
> > > Would this be better abstracted in a zswap lruvec struct?
> > There is just one field, so that sounds like overkill to me.
> > But if we need to store more data (for smarter heuristics),
> > that'll be a good idea. I'll keep this in mind. Thanks for the
> > suggestion, Yosry!
>
> (A space between the quoted text and the reply usually helps visually :)
>
> It wasn't really about the number of fields, but rather place this
> struct in zswap.h (with the long comment explaining what it's doing),
> and adding an abstracted struct member here. The comment will live in
> an appropriate file, further modifications don't need to touch
> mmzone.h, and struct lruvec is less cluttered for readers that don't
> care about zswap (and we can avoid the ifdef).
>
> Anyway, this is all mostly aesthetic so I don't feel strongly.
>
> > >
> > > >  };
> > > >
> > > >  /* Isolate unmapped pages */
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 9f84b3f7b469..1a2c97cf396f 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5352,6 +5352,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_sta=
te *parent_css)
> > > >         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > >         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> > > > +       /* Disable the shrinker by default */
> > > > +       atomic_set(&memcg->zswap_shrinker_enabled, 0);
> > > >  #endif
> > > >         page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> > > >         if (parent) {
> > > > @@ -7877,6 +7879,31 @@ static ssize_t zswap_max_write(struct kernfs=
_open_file *of,
> > > >         return nbytes;
> > > >  }
> > > >
> > > > +static int zswap_shrinker_enabled_show(struct seq_file *m, void *v=
)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> > > > +
> > > > +       seq_printf(m, "%d\n", atomic_read(&memcg->zswap_shrinker_en=
abled));
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static ssize_t zswap_shrinker_enabled_write(struct kernfs_open_fil=
e *of,
> > > > +                              char *buf, size_t nbytes, loff_t off=
)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of)=
);
> > > > +       int zswap_shrinker_enabled;
> > > > +       ssize_t parse_ret =3D kstrtoint(strstrip(buf), 0, &zswap_sh=
rinker_enabled);
> > > > +
> > > > +       if (parse_ret)
> > > > +               return parse_ret;
> > > > +
> > > > +       if (zswap_shrinker_enabled < 0 || zswap_shrinker_enabled > =
1)
> > > > +               return -ERANGE;
> > > > +
> > > > +       atomic_set(&memcg->zswap_shrinker_enabled, zswap_shrinker_e=
nabled);
> > > > +       return nbytes;
> > > > +}
> > > > +
> > > >  static struct cftype zswap_files[] =3D {
> > > >         {
> > > >                 .name =3D "zswap.current",
> > > > @@ -7889,6 +7916,12 @@ static struct cftype zswap_files[] =3D {
> > > >                 .seq_show =3D zswap_max_show,
> > > >                 .write =3D zswap_max_write,
> > > >         },
> > > > +       {
> > > > +               .name =3D "zswap.shrinker.enabled",
> > > > +               .flags =3D CFTYPE_NOT_ON_ROOT,
> > > > +               .seq_show =3D zswap_shrinker_enabled_show,
> > > > +               .write =3D zswap_shrinker_enabled_write,
> > > > +       },
> > > >         { }     /* terminate */
> > > >  };
> > > >  #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
> > > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > > index 1c826737aacb..788e36a06c34 100644
> > > > --- a/mm/swap_state.c
> > > > +++ b/mm/swap_state.c
> > > > @@ -618,6 +618,22 @@ static unsigned long swapin_nr_pages(unsigned =
long offset)
> > > >         return pages;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_ZSWAP
> > > > +/*
> > > > + * Refault is an indication that warmer pages are not resident in =
memory.
> > > > + * Increase the size of zswap's protected area.
> > > > + */
> > > > +static void inc_nr_protected(struct page *page)
> > > > +{
> > > > +       struct lruvec *lruvec =3D folio_lruvec(page_folio(page));
> > > > +       unsigned long flags;
> > > > +
> > > > +       spin_lock_irqsave(&lruvec->lru_lock, flags);
> > > > +       lruvec->nr_zswap_protected++;
> > > > +       spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> > > > +}
> > > > +#endif
> > > > +
> > >
> > > A few questions:
> > > - Why is this function named in such a generic way?
> > Perhaps inc_nr_zswap_protected would be better? :)
>
> If we use an atomic, the function can go away anyway. See below.
>
> > > - Why is this function here instead of in mm/zswap.c?
> > No particular reason :) It's not being used anywhere else,
> > so I just put it as a static function here.
>
> It is inline in mm/zswap.c in one place. I personally would have
> preferred nr_zswap_protected and the helper to be defined in
> zswap.h/zswap.c as I mentioned below. Anyway, this function can go
> away.
>
> > > - Why is this protected by the heavily contested lruvec lock instead
> > > of being an atomic?
> > nr_zswap_protected can be decayed (see zswap_lru_add), which
> > I don't think it can be implemented with atomics :( It'd be much
> > cleaner indeed.
>
> I think a cmpxchg (or a try_cmpxchg) loop can be used in this case to
> implement it using an atomic?
>
> See https://docs.kernel.org/core-api/wrappers/atomic_t.html.

Ah I did think about this, but that seems overkill at the time.
But if lruvec lock is indeed hotly contested, this should help.

>
> > > > +               lruvec->nr_zswap_protected++;
> > > >
> > > > +               /*
> > > > +                * Decay to avoid overflow and adapt to changing wo=
rkloads.
> > > > +                * This is based on LRU reclaim cost decaying heuri=
stics.
> > > > +                */
> > > > +               if (lruvec->nr_zswap_protected > lru_size / 4)
> > > > +                       lruvec->nr_zswap_protected /=3D 2;
>
> >
> > I'm wary of adding new locks, so I just re-use this existing lock.
> > But if lruvec lock is heavily congested (I'm not aware/familar with
> > this issue), then perhaps a new, dedicated lock would help?
> > >
> > > >  /**
> > > >   * swap_cluster_readahead - swap in pages in hope we need them soo=
n
> > > >   * @entry: swap entry of this memory
> > > > @@ -686,7 +702,12 @@ struct page *swap_cluster_readahead(swp_entry_=
t entry, gfp_t gfp_mask,
> > > >         lru_add_drain();        /* Push any new pages onto the LRU =
now */
> > > >  skip:
> > > >         /* The page was likely read above, so no need for plugging =
here */
> > > > -       return read_swap_cache_async(entry, gfp_mask, vma, addr, NU=
LL);
> > > > +       page =3D read_swap_cache_async(entry, gfp_mask, vma, addr, =
NULL);
> > > > +#ifdef CONFIG_ZSWAP
> > > > +       if (page)
> > > > +               inc_nr_protected(page);
> > > > +#endif
> > > > +       return page;
> > > >  }
> > > >
> > > >  int init_swap_address_space(unsigned int type, unsigned long nr_pa=
ges)
> > > > @@ -853,8 +874,12 @@ static struct page *swap_vma_readahead(swp_ent=
ry_t fentry, gfp_t gfp_mask,
> > > >         lru_add_drain();
> > > >  skip:
> > > >         /* The page was likely read above, so no need for plugging =
here */
> > > > -       return read_swap_cache_async(fentry, gfp_mask, vma, vmf->ad=
dress,
> > > > -                                    NULL);
> > > > +       page =3D read_swap_cache_async(fentry, gfp_mask, vma, vmf->=
address, NULL);
> > > > +#ifdef CONFIG_ZSWAP
> > > > +       if (page)
> > > > +               inc_nr_protected(page);
> > > > +#endif
> > > > +       return page;
> > > >  }
> > > >
> > > >  /**
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 1a469e5d5197..79cb18eeb8bf 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -145,6 +145,26 @@ module_param_named(exclusive_loads, zswap_excl=
usive_loads_enabled, bool, 0644);
> > > >  /* Number of zpools in zswap_pool (empirically determined for scal=
ability) */
> > > >  #define ZSWAP_NR_ZPOOLS 32
> > > >
> > > > +/*
> > > > + * Global flag to enable/disable memory pressure-based shrinker fo=
r all memcgs.
> > > > + * If CONFIG_MEMCG_KMEM is on, we can further selectively disable
> > > > + * the shrinker for each memcg.
> > > > + */
> > > > +static bool zswap_shrinker_enabled;
> > > > +module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool,=
 0644);
> > > > +#ifdef CONFIG_MEMCG_KMEM
> > > > +static bool is_shrinker_enabled(struct mem_cgroup *memcg)
> > > > +{
> > > > +       return zswap_shrinker_enabled &&
> > > > +               atomic_read(&memcg->zswap_shrinker_enabled);
> > > > +}
> > > > +#else
> > > > +static bool is_shrinker_enabled(struct mem_cgroup *memcg)
> > > > +{
> > > > +       return zswap_shrinker_enabled;
> > > > +}
> > > > +#endif
> > > > +
> > > >  /*********************************
> > > >  * data structures
> > > >  **********************************/
> > > > @@ -174,6 +194,8 @@ struct zswap_pool {
> > > >         char tfm_name[CRYPTO_MAX_ALG_NAME];
> > > >         struct list_lru list_lru;
> > > >         struct mem_cgroup *next_shrink;
> > > > +       struct shrinker *shrinker;
> > > > +       atomic_t nr_stored;
> > > >  };
> > > >
> > > >  /*
> > > > @@ -273,17 +295,26 @@ static bool zswap_can_accept(void)
> > > >                         DIV_ROUND_UP(zswap_pool_total_size, PAGE_SI=
ZE);
> > > >  }
> > > >
> > > > +static u64 get_zswap_pool_size(struct zswap_pool *pool)
> > > > +{
> > > > +       u64 pool_size =3D 0;
> > > > +       int i;
> > > > +
> > > > +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > > > +               pool_size +=3D zpool_get_total_size(pool->zpools[i]=
);
> > > > +
> > > > +       return pool_size;
> > > > +}
> > > > +
> > > >  static void zswap_update_total_size(void)
> > > >  {
> > > >         struct zswap_pool *pool;
> > > >         u64 total =3D 0;
> > > > -       int i;
> > > >
> > > >         rcu_read_lock();
> > > >
> > > >         list_for_each_entry_rcu(pool, &zswap_pools, list)
> > > > -               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > > > -                       total +=3D zpool_get_total_size(pool->zpool=
s[i]);
> > > > +               total +=3D get_zswap_pool_size(pool);
> > > >
> > > >         rcu_read_unlock();
> > > >
> > > > @@ -318,8 +349,23 @@ static bool zswap_lru_add(struct list_lru *lis=
t_lru, struct zswap_entry *entry)
> > > >  {
> > > >         struct mem_cgroup *memcg =3D entry->objcg ?
> > > >                 get_mem_cgroup_from_objcg(entry->objcg) : NULL;
> > > > +       struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DAT=
A(entry->nid));
> > > >         bool added =3D __list_lru_add(list_lru, &entry->lru, entry-=
>nid, memcg);
> > > > +       unsigned long flags, lru_size;
> > > > +
> > > > +       if (added) {
> > > > +               lru_size =3D list_lru_count_one(list_lru, entry->ni=
d, memcg);
> > > > +               spin_lock_irqsave(&lruvec->lru_lock, flags);
> > > > +               lruvec->nr_zswap_protected++;
> > > >
> > > > +               /*
> > > > +                * Decay to avoid overflow and adapt to changing wo=
rkloads.
> > > > +                * This is based on LRU reclaim cost decaying heuri=
stics.
> > > > +                */
> > > > +               if (lruvec->nr_zswap_protected > lru_size / 4)
> > > > +                       lruvec->nr_zswap_protected /=3D 2;
> > > > +               spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> > > > +       }
> > > >         mem_cgroup_put(memcg);
> > > >         return added;
> > > >  }
> > > > @@ -420,6 +466,7 @@ static void zswap_free_entry(struct zswap_entry=
 *entry)
> > > >         else {
> > > >                 zswap_lru_del(&entry->pool->list_lru, entry);
> > > >                 zpool_free(zswap_find_zpool(entry), entry->handle);
> > > > +               atomic_dec(&entry->pool->nr_stored);
> > > >                 zswap_pool_put(entry->pool);
> > > >         }
> > > >         zswap_entry_cache_free(entry);
> > > > @@ -461,6 +508,98 @@ static struct zswap_entry *zswap_entry_find_ge=
t(struct rb_root *root,
> > > >         return entry;
> > > >  }
> > > >
> > > > +/*********************************
> > > > +* shrinker functions
> > > > +**********************************/
> > > > +static enum lru_status shrink_memcg_cb(struct list_head *item, str=
uct list_lru_one *l,
> > > > +                                      spinlock_t *lock, void *arg)=
;
> > > > +
> > > > +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker=
,
> > > > +               struct shrink_control *sc)
> > > > +{
> > > > +       struct zswap_pool *pool =3D shrinker->private_data;
> > > > +       unsigned long shrink_ret, nr_zswap_protected, flags,
> > > > +               lru_size =3D list_lru_shrink_count(&pool->list_lru,=
 sc);
> > > > +       struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE=
_DATA(sc->nid));
> > > > +       bool encountered_page_in_swapcache =3D false;
> > > > +
> > > > +       spin_lock_irqsave(&lruvec->lru_lock, flags);
> > > > +       nr_zswap_protected =3D lruvec->nr_zswap_protected;
> > > > +       spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> > > > +
> > > > +       /*
> > > > +        * Abort if the shrinker is disabled or if we are shrinking=
 into the
> > > > +        * protected region.
> > > > +        */
> > > > +       if (!is_shrinker_enabled(sc->memcg) ||
> > > > +                       nr_zswap_protected >=3D lru_size - sc->nr_t=
o_scan) {
> > > > +               sc->nr_scanned =3D 0;
> > > > +               return SHRINK_STOP;
> > > > +       }
> > > > +
> > > > +       shrink_ret =3D list_lru_shrink_walk(&pool->list_lru, sc, &s=
hrink_memcg_cb,
> > > > +               &encountered_page_in_swapcache);
> > > > +
> > > > +       if (encountered_page_in_swapcache)
> > > > +               return SHRINK_STOP;
> > > > +
> > > > +       return shrink_ret ? shrink_ret : SHRINK_STOP;
> > > > +}
> > > > +
> > > > +static unsigned long zswap_shrinker_count(struct shrinker *shrinke=
r,
> > > > +               struct shrink_control *sc)
> > > > +{
> > > > +       struct zswap_pool *pool =3D shrinker->private_data;
> > > > +       struct mem_cgroup *memcg =3D sc->memcg;
> > > > +       struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DAT=
A(sc->nid));
> > > > +       unsigned long nr_backing, nr_stored, nr_freeable, flags;
> > > > +
> > > > +#ifdef CONFIG_MEMCG_KMEM
> > > > +       cgroup_rstat_flush(memcg->css.cgroup);
> > > > +       nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PA=
GE_SHIFT;
> > > > +       nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> > > > +#else
> > > > +       /* use pool stats instead of memcg stats */
> > > > +       nr_backing =3D get_zswap_pool_size(pool) >> PAGE_SHIFT;
> > > > +       nr_stored =3D atomic_read(&pool->nr_stored);
> > > > +#endif
> > > > +
> > > > +       if (!is_shrinker_enabled(memcg) || !nr_stored)
> > > > +               return 0;
> > > > +
> > > > +       nr_freeable =3D list_lru_shrink_count(&pool->list_lru, sc);
> > > > +       /*
> > > > +        * Subtract the lru size by an estimate of the number of pa=
ges
> > > > +        * that should be protected.
> > > > +        */
> > > > +       spin_lock_irqsave(&lruvec->lru_lock, flags);
> > > > +       nr_freeable =3D nr_freeable > lruvec->nr_zswap_protected ?
> > > > +               nr_freeable - lruvec->nr_zswap_protected : 0;
> > > > +       spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> > > > +
> > > > +       /*
> > > > +        * Scale the number of freeable pages by the memory saving =
factor.
> > > > +        * This ensures that the better zswap compresses memory, th=
e fewer
> > > > +        * pages we will evict to swap (as it will otherwise incur =
IO for
> > > > +        * relatively small memory saving).
> > > > +        */
> > > > +       return mult_frac(nr_freeable, nr_backing, nr_stored);
> > > > +}
> > > > +
> > > > +static void zswap_alloc_shrinker(struct zswap_pool *pool)
> > > > +{
> > > > +       pool->shrinker =3D
> > > > +               shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG=
_AWARE, "mm-zswap");
> > > > +       if (!pool->shrinker)
> > > > +               return;
> > > > +
> > > > +       pool->shrinker->private_data =3D pool;
> > > > +       pool->shrinker->scan_objects =3D zswap_shrinker_scan;
> > > > +       pool->shrinker->count_objects =3D zswap_shrinker_count;
> > > > +       pool->shrinker->batch =3D 0;
> > > > +       pool->shrinker->seeks =3D DEFAULT_SEEKS;
> > > > +}
> > > > +
> > > >  /*********************************
> > > >  * per-cpu code
> > > >  **********************************/
> > > > @@ -656,11 +795,14 @@ static enum lru_status shrink_memcg_cb(struct=
 list_head *item, struct list_lru_o
> > > >                                        spinlock_t *lock, void *arg)
> > > >  {
> > > >         struct zswap_entry *entry =3D container_of(item, struct zsw=
ap_entry, lru);
> > > > +       bool *encountered_page_in_swapcache =3D (bool *)arg;
> > > >         struct mem_cgroup *memcg;
> > > >         struct zswap_tree *tree;
> > > > +       struct lruvec *lruvec;
> > > >         pgoff_t swpoffset;
> > > >         enum lru_status ret =3D LRU_REMOVED_RETRY;
> > > >         int writeback_result;
> > > > +       unsigned long flags;
> > > >
> > > >         /*
> > > >          * Once the lru lock is dropped, the entry might get freed.=
 The
> > > > @@ -696,8 +838,24 @@ static enum lru_status shrink_memcg_cb(struct =
list_head *item, struct list_lru_o
> > > >                 /* we cannot use zswap_lru_add here, because it inc=
rements node's lru count */
> > > >                 list_lru_putback(&entry->pool->list_lru, item, entr=
y->nid, memcg);
> > > >                 spin_unlock(lock);
> > > > -               mem_cgroup_put(memcg);
> > > >                 ret =3D LRU_RETRY;
> > > > +
> > > > +               /*
> > > > +                * Encountering a page already in swap cache is a s=
ign that we are shrinking
> > > > +                * into the warmer region. We should terminate shri=
nking (if we're in the dynamic
> > > > +                * shrinker context).
> > > > +                */
> > > > +               if (writeback_result =3D=3D -EEXIST && encountered_=
page_in_swapcache) {
> > > > +                       ret =3D LRU_SKIP;
> > > > +                       *encountered_page_in_swapcache =3D true;
> > > > +               }
> > > > +               lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(entry=
->nid));
> > > > +               spin_lock_irqsave(&lruvec->lru_lock, flags);
> > > > +               /* Increment the protection area to account for the=
 LRU rotation. */
> > > > +               lruvec->nr_zswap_protected++;
> > > > +               spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> > > > +
> > > > +               mem_cgroup_put(memcg);
> > > >                 goto put_unlock;
> > > >         }
> > > >
> > > > @@ -828,6 +986,11 @@ static struct zswap_pool *zswap_pool_create(ch=
ar *type, char *compressor)
> > > >                                        &pool->node);
> > > >         if (ret)
> > > >                 goto error;
> > > > +
> > > > +       zswap_alloc_shrinker(pool);
> > > > +       if (!pool->shrinker)
> > > > +               goto error;
> > > > +
> > > >         pr_debug("using %s compressor\n", pool->tfm_name);
> > > >
> > > >         /* being the current pool takes 1 ref; this func expects th=
e
> > > > @@ -836,12 +999,17 @@ static struct zswap_pool *zswap_pool_create(c=
har *type, char *compressor)
> > > >         kref_init(&pool->kref);
> > > >         INIT_LIST_HEAD(&pool->list);
> > > >         INIT_WORK(&pool->shrink_work, shrink_worker);
> > > > -       list_lru_init_memcg(&pool->list_lru, NULL);
> > > > +       if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> > > > +               goto lru_fail;
> > > > +       shrinker_register(pool->shrinker);
> > > >
> > > >         zswap_pool_debug("created", pool);
> > > >
> > > >         return pool;
> > > >
> > > > +lru_fail:
> > > > +       list_lru_destroy(&pool->list_lru);
> > > > +       shrinker_free(pool->shrinker);
> > > >  error:
> > > >         if (pool->acomp_ctx)
> > > >                 free_percpu(pool->acomp_ctx);
> > > > @@ -899,6 +1067,7 @@ static void zswap_pool_destroy(struct zswap_po=
ol *pool)
> > > >
> > > >         zswap_pool_debug("destroying", pool);
> > > >
> > > > +       shrinker_free(pool->shrinker);
> > > >         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &po=
ol->node);
> > > >         free_percpu(pool->acomp_ctx);
> > > >         list_lru_destroy(&pool->list_lru);
> > > > @@ -1431,6 +1600,7 @@ bool zswap_store(struct folio *folio)
> > > >         if (entry->length) {
> > > >                 INIT_LIST_HEAD(&entry->lru);
> > > >                 zswap_lru_add(&pool->list_lru, entry);
> > > > +               atomic_inc(&pool->nr_stored);
> > > >         }
> > > >         spin_unlock(&tree->lock);
> > > >
> > > > --
> > > > 2.34.1
> > Thanks for the comments/suggestion, Yosry!
