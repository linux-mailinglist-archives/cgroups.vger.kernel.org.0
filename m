Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFF79279C
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbjIEQWK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIEP6a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 11:58:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218312A
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 08:58:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso392626766b.1
        for <cgroups@vger.kernel.org>; Tue, 05 Sep 2023 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693929505; x=1694534305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa7aT+i5EQ3QihS49Ljt9BqKnGTT4ELtv83ViKOgL14=;
        b=UArbWcRcXVqkPI/gWwdovn2eBFuRbC7cTNXS6U0/8hTT11YZ8+45n3YquwqFdj41Sk
         rWct0MjHHE7y7P/SHg15twTMKCVuXQ1M7anyqRE6AIoKmmqOiIF0Qr9ET3f3jqjKRwUQ
         z/xfZUVAfGyFQtkv+5ZLXSs9arMap7jaBVYKrg2TIi+nE7eeQ2MWkk9/WYcsesfC1gEJ
         gxjNJaIpnbdoMtvhOhW6oiHTfv8XrWb0f9GdVfmn/V/POAnCCkoPSbVgCkVg2WzPPF7I
         rg+Yqf4uF92ZjVJYxPZ/fBfg/FK0fOGmtRgJtY4IOHcZQcRVRiaWzbPFrGbxa6EXpzJ6
         RlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693929505; x=1694534305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa7aT+i5EQ3QihS49Ljt9BqKnGTT4ELtv83ViKOgL14=;
        b=MxCIgoBgolqfInjTltdTh0uAq3BQRIx2zQ+12tTDOnwq1XmgPRDRCO34GcYDrQiPW8
         0gv22jPouQEz7wLHQXm+XUr0s34w+DZ8tfDsbYQuhN2Om+BF2+5FITND367FrX2pRQXL
         U5IROKjx5i2/XEgJFq4gw5Sd3d/dHZNja975018cGHBFASrfj9XVUOdf0QhUF971TkOK
         69obm5GfKE1W9NvKwrqHsPzDjenuMZ21S2sPfDrVUbspDdtdoX2uQOs8h2pI3N/kNID/
         BeE9DhRPqwgsq0aFYPUwKY6/MqSjwTpFLOkevxU9gZCjZ8HGoI5Rcrw2Zl25QxK8/BQ/
         kP7A==
X-Gm-Message-State: AOJu0YyNIBxZ2ezoYGJ4TmfFn0lSrgUlWK237C7Xw1H/EeGx+jhRYdZ9
        GgrrmimbZT3Eeg7e0g/YjZE6cv3wcI5ilhsF40qeyw==
X-Google-Smtp-Source: AGHT+IHjV3kT/fsRM56CZxbDIb5jloyTUmWtIcr9xzj8Z6MUrQT/VCOG7UqITNEAVlfwe9bTc0z+KPP3US9GKxsDU7Y=
X-Received: by 2002:a17:906:1baa:b0:9a1:e941:6f49 with SMTP id
 r10-20020a1709061baa00b009a1e9416f49mr190033ejg.44.1693929505416; Tue, 05 Sep
 2023 08:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
In-Reply-To: <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Sep 2023 08:57:49 -0700
Message-ID: <CAJD7tkbgM-pAPhEpQTzJB+TJ8+JPr2tiuVUe8LYCzztAcpyO3Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
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

On Mon, Sep 4, 2023 at 8:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 31-08-23 16:56:11, Yosry Ahmed wrote:
> > Unified flushing allows for great concurrency for paths that attempt to
> > flush the stats, at the expense of potential staleness and a single
> > flusher paying the extra cost of flushing the full tree.
> >
> > This tradeoff makes sense for in-kernel flushers that may observe high
> > concurrency (e.g. reclaim, refault). For userspace readers, stale stats
> > may be unexpected and problematic, especially when such stats are used
> > for critical paths such as userspace OOM handling. Additionally, a
> > userspace reader will occasionally pay the cost of flushing the entire
> > hierarchy, which also causes problems in some cases [1].
> >
> > Opt userspace reads out of unified flushing. This makes the cost of
> > reading the stats more predictable (proportional to the size of the
> > subtree), as well as the freshness of the stats. Userspace readers are
> > not expected to have similar concurrency to in-kernel flushers,
> > serializing them among themselves and among in-kernel flushers should b=
e
> > okay. Nonetheless, for extra safety, introduce a mutex when flushing fo=
r
> > userspace readers to make sure only a single userspace reader can compe=
te
> > with in-kernel flushers at a time. This takes away userspace ability to
> > directly influence or hurt in-kernel lock contention.
>
> I think it would be helpful to note that the primary reason this is a
> concern is that the spinlock is dropped during flushing under
> contention.
>
> > An alternative is to remove flushing from the stats reading path
> > completely, and rely on the periodic flusher. This should be accompanie=
d
> > by making the periodic flushing period tunable, and providing an
> > interface for userspace to force a flush, following a similar model to
> > /proc/vmstat. However, such a change will be hard to reverse if the
> > implementation needs to be changed because:
> > - The cost of reading stats will be very cheap and we won't be able to
> >   take that back easily.
> > - There are user-visible interfaces involved.
> >
> > Hence, let's go with the change that's most reversible first and revisi=
t
> > as needed.
> >
> > This was tested on a machine with 256 cpus by running a synthetic test
> > script [2] that creates 50 top-level cgroups, each with 5 children (250
> > leaf cgroups). Each leaf cgroup has 10 processes running that allocate
> > memory beyond the cgroup limit, invoking reclaim (which is an in-kernel
> > unified flusher). Concurrently, one thread is spawned per-cgroup to rea=
d
> > the stats every second (including root, top-level, and leaf cgroups --
> > so total 251 threads). No significant regressions were observed in the
> > total run time, which means that userspace readers are not significantl=
y
> > affecting in-kernel flushers:
> >
> > Base (mm-unstable):
> >
> > real  0m22.500s
> > user  0m9.399s
> > sys   73m41.381s
> >
> > real  0m22.749s
> > user  0m15.648s
> > sys   73m13.113s
> >
> > real  0m22.466s
> > user  0m10.000s
> > sys   73m11.933s
> >
> > With this patch:
> >
> > real  0m23.092s
> > user  0m10.110s
> > sys   75m42.774s
> >
> > real  0m22.277s
> > user  0m10.443s
> > sys   72m7.182s
> >
> > real  0m24.127s
> > user  0m12.617s
> > sys   78m52.765s
> >
> > [1]https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43K=
O9ME4-dsgfoQ@mail.gmail.com/
> > [2]https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOB=
Zcz6POYTV-4g@mail.gmail.com/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> OK, I can live with that but I still believe that locking involved in
> the user interface only begs for issues later on as there is no control
> over that lock contention other than the number of processes involved.
> As it seems that we cannot make a consensus on this concern now and this
> should be already helping existing workloads then let's just buy some
> more time ;)
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

I agree, let's fix problems if/when they arise, maybe it will be just fine =
:)

I will send a v5 collecting Ack's and augmenting the changelog and
comment below as you suggested (probably after we resolve patch 3).

>
> Thanks!
>
> > ---
> >  mm/memcontrol.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 94d5a6751a9e..46a7abf71c73 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -588,6 +588,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
> >  static void flush_memcg_stats_dwork(struct work_struct *w);
> >  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dw=
ork);
> >  static DEFINE_PER_CPU(unsigned int, stats_updates);
> > +static DEFINE_MUTEX(stats_user_flush_mutex);
> >  static atomic_t stats_unified_flush_ongoing =3D ATOMIC_INIT(0);
> >  static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
> >  static u64 flush_next_time;
> > @@ -655,6 +656,21 @@ static void do_stats_flush(struct mem_cgroup *memc=
g)
> >       cgroup_rstat_flush(memcg->css.cgroup);
> >  }
> >
> > +/*
> > + * mem_cgroup_user_flush_stats - do a stats flush for a user read
> > + * @memcg: memory cgroup to flush
> > + *
> > + * Flush the subtree of @memcg. A mutex is used for userspace readers =
to gate
> > + * the global rstat spinlock. This protects in-kernel flushers from us=
erspace
> > + * readers hogging the lock.
>
> readers hogging the lock as do_stats_flush drops the spinlock under
> contention.
>
> > + */
> > +static void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
> > +{
> > +     mutex_lock(&stats_user_flush_mutex);
> > +     do_stats_flush(memcg);
> > +     mutex_unlock(&stats_user_flush_mutex);
> > +}
> > +
> >  /*
> >   * do_unified_stats_flush - do a unified flush of memory cgroup statis=
tics
> >   *
> --
> Michal Hocko
> SUSE Labs
