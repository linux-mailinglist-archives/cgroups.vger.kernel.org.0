Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC45079273B
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbjIEQV6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354931AbjIEP4i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 11:56:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AEE194
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 08:56:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso414941466b.2
        for <cgroups@vger.kernel.org>; Tue, 05 Sep 2023 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693929393; x=1694534193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku5vsXzmlzdjg51CBHusCSCeTyx/p0r0SzuTPz7HFEM=;
        b=1s3emT+FM3c6oavkzYncmCQQ+mlmsAEmMnPK8nJRqwChieWf5koUZ+ES2/8t52KtU2
         nEDr0S6/+3T7mjRot8N9uZXnscbA9qT+5LFpk3AP0d113OvgZJRwwSkIb9THAySSKvad
         Z58RtsNZhOfk8Up4bh21qCzWL8R7dSsmpHK/oeX0/T8dAEw9d/yTxheFqGLm+N5xsnzL
         uqQiiwqwI/K1xRH7R1f081V4VcLpgebhosSSRvyCxwPkVT2AOXvCgsXM7z0XI30b8HSU
         5mtsKoBCeB/tIF76T6ielyoy10rH75vvAEcwm1O8DAQjtzP/86Abd+db7PgqIkEXo/S0
         8WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693929393; x=1694534193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku5vsXzmlzdjg51CBHusCSCeTyx/p0r0SzuTPz7HFEM=;
        b=SdZgo60luf7lM4WevcGnOKHh16CJ6+eB77tSEy0CIuGPyqgyXcy3qcAwF8mzdPgT3c
         bFs0vXuA/TJ8pEU97D0KF8JtexwH5ABZhuPuWHaC8r4XKccA1iWZOmrUO5Od9acNKIg/
         KpJ2z1iWXebPjuZWe495LVBVqw2t2UrbNyrWIGI92wHF7RNnOjzioaWP3WxwMvQLCIow
         zhus+gwuxSmaPy1iM7WWaLlpWU5tnwQcnDVUywWwu2q5KTPKCG5MuMwWwfrAxOF+y3FJ
         m1rAXa7bR9KqIBI0Qo0tcxmSIx6WIDM6aIFdVRdHIqZPRcMEp/IySbxr208Ax92vqw9e
         6S1w==
X-Gm-Message-State: AOJu0YyA06gd5kA7nRXyqjzs814Yk6RVvIqfdeGP9FnaE+H+yrydBDT8
        iWeUO5PIOG5SM8NYH6zvfIBzt+rhe0q1e/k1RDfNhg==
X-Google-Smtp-Source: AGHT+IGzzsaz5hxG0RZEVaIt/5m7iasR/HdcmqFKrawo0vYnZc+yyHQHuiHd7maOlM0Uvj8Qe3Han/QClFUN+Vs7jyY=
X-Received: by 2002:a17:907:1dc3:b0:9a1:bb8f:17de with SMTP id
 og3-20020a1709071dc300b009a1bb8f17demr212504ejc.35.1693929393055; Tue, 05 Sep
 2023 08:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-2-yosryahmed@google.com> <ZPXtVLNIXk8trj2k@dhcp22.suse.cz>
In-Reply-To: <ZPXtVLNIXk8trj2k@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Sep 2023 08:55:56 -0700
Message-ID: <CAJD7tkaCjbkf37naW7dWxq7FovH-3+3QEuRrAD0+3+D9uVq_+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: memcg: properly name and document unified
 stats flushing
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 4, 2023 at 7:44=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 31-08-23 16:56:08, Yosry Ahmed wrote:
> > Most contexts that flush memcg stats use "unified" flushing, where
> > basically all flushers attempt to flush the entire hierarchy, but only
> > one flusher is allowed at a time, others skip flushing.
> >
> > This is needed because we need to flush the stats from paths such as
> > reclaim or refaults, which may have high concurrency, especially on
> > large systems. Serializing such performance-sensitive paths can
> > introduce regressions, hence, unified flushing offers a tradeoff betwee=
n
> > stats staleness and the performance impact of flushing stats.
> >
> > Document this properly and explicitly by renaming the common flushing
> > helper from do_flush_stats() to do_unified_stats_flush(), and adding
> > documentation to describe unified flushing. Additionally, rename
> > flushing APIs to add "try" in the name, which implies that flushing wil=
l
> > not always happen. Also add proper documentation.
> >
> > No functional change intended.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> No objections to renaming but it would be really nice to simplify this.
> It is just "funny" to see 4 different flushing methods (flush from
> userspace, flush, try_flush_with_ratelimit_1 and try_flush_with_ratelimit=
_2).
> This is all internal so I am not all that worried that this would get
> confused but it surely is rather convoluted.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

I tried to at least keep the naming consistent and add documentation,
but I agree we can do better :) It's less obvious to me tbh where we
can improve, but hopefully when someone new to this code comes
complaining we'll know better what needs to be changed.

>
> > ---
> >  include/linux/memcontrol.h |  8 ++---
> >  mm/memcontrol.c            | 61 +++++++++++++++++++++++++-------------
> >  mm/vmscan.c                |  2 +-
> >  mm/workingset.c            |  4 +--
> >  4 files changed, 47 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 11810a2cfd2d..d517b0cc5221 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1034,8 +1034,8 @@ static inline unsigned long lruvec_page_state_loc=
al(struct lruvec *lruvec,
> >       return x;
> >  }
> >
> > -void mem_cgroup_flush_stats(void);
> > -void mem_cgroup_flush_stats_ratelimited(void);
> > +void mem_cgroup_try_flush_stats(void);
> > +void mem_cgroup_try_flush_stats_ratelimited(void);
> >
> >  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_it=
em idx,
> >                             int val);
> > @@ -1519,11 +1519,11 @@ static inline unsigned long lruvec_page_state_l=
ocal(struct lruvec *lruvec,
> >       return node_page_state(lruvec_pgdat(lruvec), idx);
> >  }
> >
> > -static inline void mem_cgroup_flush_stats(void)
> > +static inline void mem_cgroup_try_flush_stats(void)
> >  {
> >  }
> >
> > -static inline void mem_cgroup_flush_stats_ratelimited(void)
> > +static inline void mem_cgroup_try_flush_stats_ratelimited(void)
> >  {
> >  }
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index cf57fe9318d5..2d0ec828a1c4 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -588,7 +588,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
> >  static void flush_memcg_stats_dwork(struct work_struct *w);
> >  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dw=
ork);
> >  static DEFINE_PER_CPU(unsigned int, stats_updates);
> > -static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
> > +static atomic_t stats_unified_flush_ongoing =3D ATOMIC_INIT(0);
> >  static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
> >  static u64 flush_next_time;
> >
> > @@ -630,7 +630,7 @@ static inline void memcg_rstat_updated(struct mem_c=
group *memcg, int val)
> >               /*
> >                * If stats_flush_threshold exceeds the threshold
> >                * (>num_online_cpus()), cgroup stats update will be trig=
gered
> > -              * in __mem_cgroup_flush_stats(). Increasing this var fur=
ther
> > +              * in mem_cgroup_try_flush_stats(). Increasing this var f=
urther
> >                * is redundant and simply adds overhead in atomic update=
.
> >                */
> >               if (atomic_read(&stats_flush_threshold) <=3D num_online_c=
pus())
> > @@ -639,15 +639,19 @@ static inline void memcg_rstat_updated(struct mem=
_cgroup *memcg, int val)
> >       }
> >  }
> >
> > -static void do_flush_stats(void)
> > +/*
> > + * do_unified_stats_flush - do a unified flush of memory cgroup statis=
tics
> > + *
> > + * A unified flush tries to flush the entire hierarchy, but skips if t=
here is
> > + * another ongoing flush. This is meant for flushers that may have a l=
ot of
> > + * concurrency (e.g. reclaim, refault, etc), and should not be seriali=
zed to
> > + * avoid slowing down performance-sensitive paths. A unified flush may=
 skip, and
> > + * hence may yield stale stats.
> > + */
> > +static void do_unified_stats_flush(void)
> >  {
> > -     /*
> > -      * We always flush the entire tree, so concurrent flushers can ju=
st
> > -      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > -      */
> > -     if (atomic_read(&stats_flush_ongoing) ||
> > -         atomic_xchg(&stats_flush_ongoing, 1))
> > +     if (atomic_read(&stats_unified_flush_ongoing) ||
> > +         atomic_xchg(&stats_unified_flush_ongoing, 1))
> >               return;
> >
> >       WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> > @@ -655,19 +659,34 @@ static void do_flush_stats(void)
> >       cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> >
> >       atomic_set(&stats_flush_threshold, 0);
> > -     atomic_set(&stats_flush_ongoing, 0);
> > +     atomic_set(&stats_unified_flush_ongoing, 0);
> >  }
> >
> > -void mem_cgroup_flush_stats(void)
> > +/*
> > + * mem_cgroup_try_flush_stats - try to flush memory cgroup statistics
> > + *
> > + * Try to flush the stats of all memcgs that have stat updates since t=
he last
> > + * flush. We do not flush the stats if:
> > + * - The magnitude of the pending updates is below a certain threshold=
.
> > + * - There is another ongoing unified flush (see do_unified_stats_flus=
h()).
> > + *
> > + * Hence, the stats may be stale, but ideally by less than FLUSH_TIME =
due to
> > + * periodic flushing.
> > + */
> > +void mem_cgroup_try_flush_stats(void)
> >  {
> >       if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> > -             do_flush_stats();
> > +             do_unified_stats_flush();
> >  }
> >
> > -void mem_cgroup_flush_stats_ratelimited(void)
> > +/*
> > + * Like mem_cgroup_try_flush_stats(), but only flushes if the periodic=
 flusher
> > + * is late.
> > + */
> > +void mem_cgroup_try_flush_stats_ratelimited(void)
> >  {
> >       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > -             mem_cgroup_flush_stats();
> > +             mem_cgroup_try_flush_stats();
> >  }
> >
> >  static void flush_memcg_stats_dwork(struct work_struct *w)
> > @@ -676,7 +695,7 @@ static void flush_memcg_stats_dwork(struct work_str=
uct *w)
> >        * Always flush here so that flushing in latency-sensitive paths =
is
> >        * as cheap as possible.
> >        */
> > -     do_flush_stats();
> > +     do_unified_stats_flush();
> >       queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_T=
IME);
> >  }
> >
> > @@ -1576,7 +1595,7 @@ static void memcg_stat_format(struct mem_cgroup *=
memcg, struct seq_buf *s)
> >        *
> >        * Current memory state:
> >        */
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_try_flush_stats();
> >
> >       for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
> >               u64 size;
> > @@ -4018,7 +4037,7 @@ static int memcg_numa_stat_show(struct seq_file *=
m, void *v)
> >       int nid;
> >       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> >
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_try_flush_stats();
> >
> >       for (stat =3D stats; stat < stats + ARRAY_SIZE(stats); stat++) {
> >               seq_printf(m, "%s=3D%lu", stat->name,
> > @@ -4093,7 +4112,7 @@ static void memcg1_stat_format(struct mem_cgroup =
*memcg, struct seq_buf *s)
> >
> >       BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) !=3D ARRAY_SIZE(memcg1=
_stats));
> >
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_try_flush_stats();
> >
> >       for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++) {
> >               unsigned long nr;
> > @@ -4595,7 +4614,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb=
, unsigned long *pfilepages,
> >       struct mem_cgroup *memcg =3D mem_cgroup_from_css(wb->memcg_css);
> >       struct mem_cgroup *parent;
> >
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_try_flush_stats();
> >
> >       *pdirty =3D memcg_page_state(memcg, NR_FILE_DIRTY);
> >       *pwriteback =3D memcg_page_state(memcg, NR_WRITEBACK);
> > @@ -6610,7 +6629,7 @@ static int memory_numa_stat_show(struct seq_file =
*m, void *v)
> >       int i;
> >       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> >
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_try_flush_stats();
> >
> >       for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
> >               int nid;
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c7c149cb8d66..457a18921fda 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2923,7 +2923,7 @@ static void prepare_scan_count(pg_data_t *pgdat, =
struct scan_control *sc)
> >        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> >        * lruvec stats for heuristics.
> >        */
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_try_flush_stats();
> >
> >       /*
> >        * Determine the scan balance between anon and file LRUs.
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index da58a26d0d4d..affb8699e58d 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -520,7 +520,7 @@ void workingset_refault(struct folio *folio, void *=
shadow)
> >       }
> >
> >       /* Flush stats (and potentially sleep) before holding RCU read lo=
ck */
> > -     mem_cgroup_flush_stats_ratelimited();
> > +     mem_cgroup_try_flush_stats_ratelimited();
> >
> >       rcu_read_lock();
> >
> > @@ -664,7 +664,7 @@ static unsigned long count_shadow_nodes(struct shri=
nker *shrinker,
> >               struct lruvec *lruvec;
> >               int i;
> >
> > -             mem_cgroup_flush_stats();
> > +             mem_cgroup_try_flush_stats();
> >               lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid=
));
> >               for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
> >                       pages +=3D lruvec_page_state_local(lruvec,
> > --
> > 2.42.0.rc2.253.gd59a3bf2b4-goog
>
> --
> Michal Hocko
> SUSE Labs
