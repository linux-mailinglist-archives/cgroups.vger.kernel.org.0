Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C54797FDD
	for <lists+cgroups@lfdr.de>; Fri,  8 Sep 2023 02:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjIHAwb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbjIHAwa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 20:52:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AAB1BD3
        for <cgroups@vger.kernel.org>; Thu,  7 Sep 2023 17:52:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso1456085f8f.0
        for <cgroups@vger.kernel.org>; Thu, 07 Sep 2023 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694134344; x=1694739144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VStEmC2d3lSClPUpgmJvy5b6zbqPqzfpia11cjoASts=;
        b=19ytN4KlBi238MGmmajGiauETDE1kpCY+HKSMH6cuuCbX4sg2OOPz2sLlCXFbnhk2/
         G/RAeuFPEQdZeeujUvdVeLqiHGlpbTMiOg2iAAeA8s1NsJ5ec8Sq+0ZK4424Ni4KUJbC
         O1/GdoZ7kvax817jaujUr6IpA9DtkclhmxMakHRuH4R3ymAmosUbSfNWVyjoaA864I77
         50F9Ar03kIp+s6AWRss0oOSPm3pvC2j0cEDg75hgfl9NdTeDCI2Hp45T4rBYV4YMRGa4
         K3Gd9c/T3g312NRSYSiuYhKA+PHI8jLTDJbjrgp4TO1qsS0MYkZ8AXm92Dz8FKgeugre
         f53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694134344; x=1694739144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VStEmC2d3lSClPUpgmJvy5b6zbqPqzfpia11cjoASts=;
        b=NsnER8DR+z2rCXl1kyjeqStTjR2Td6KDOXL2r384RAnQzGT1617In5OAH9epkJ9LLq
         G7PREnFNtZglB9c4608ANmk3vgbaQPEpjAwZRtf1d9MIwdgQ4PGMjTNVJj+BPgoxg522
         ob900q3FYwBFHvtaaTtZUeFJHLs4VsO8anmx+6QD+GEOKEZXf5/gRHCcOJi04s3UIf/o
         rPkSHhNfYwxB3UPIxGQPCAZsCm6bhntvG8oKvfo/Rp4B9WCV8CIo71IKPFfrYbEJ81fb
         CiglmHspThhN988ipyB3MfNtu1aO02MIMmaY6iJT47g6YtrdtXbsk26OjljFEW3rFMfd
         gimQ==
X-Gm-Message-State: AOJu0YyyezAGAfko8HNS2nMFSe/gJ7vH6xRsXqdqwS2yVwBApiYtploj
        3436DzAn8hltt53xaMuMNobcjGbENlfQRPnES7yG2Q==
X-Google-Smtp-Source: AGHT+IFGI0BOxcczvYZ8YFk2kwetao3eJlDShw0PhL4mmrPBxy3Pmtq0a4l3PWJi+6WTNIX0Gn23lYr/4Rz5i0XEowg=
X-Received: by 2002:adf:e5ce:0:b0:319:62ba:5d08 with SMTP id
 a14-20020adfe5ce000000b0031962ba5d08mr752853wrn.33.1694134343906; Thu, 07 Sep
 2023 17:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
In-Reply-To: <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 7 Sep 2023 17:52:12 -0700
Message-ID: <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
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

Indeed, even though the new global mutex protects the kernel from the
userspace contention on the rstats spinlock, its current
implementation doesn't have any protection for the lock contention
among the userspace threads and can cause significant delays to memcg
stats reads.

I tested this patch on a machine with 384 CPUs using a microbenchmark
that spawns 10K threads, each reading its memory.stat every 100
milliseconds.  Most of memory.stat reads take 5ms-10ms in kernel, with
~5% reads even exceeding 1 second. This is a significant regression.
In comparison, without contention, each memory.stat read only takes
20us-50us in the kernel.  Almost all of the extra read time is spent
on waiting for the new mutex. The time to flush rstats only accounts
for 10us-50us (This test creates only 1K memory cgroups and doesn't
generate any loads other than these stat reader threads).

 Here are some ideas to control the lock contention on the mutex and
reduce both the median and tail latencies of concurrent memcg stat
reads:

- Bring back the stats_flush_threshold check in
mem_cgroup_try_flush_stats() to mem_cgroup_user_flush_stats().  This
check provides a reasonable bound on the stats staleness while being
able to filter out a large number of rstats flush requests, which
reduces the contention on the mutex.

- When contended, upgrade the per-memcg rstats flush in
mem_cgroup_user_flush_stats() to a root memcg flush and coalesce these
contended flushes together.  We can wait for the ongoing flush to
complete and eliminate repeated flush requests.

- Wait for the mutex and the ongoing flush with a timeout.  We should
not use busy-wait, though.  We can bail out to read the stats without
a flush after enough wait.  A long-stalled system call is much worse
than somewhat stale stats in the corner cases in my opinion.

Wei Xu

> Acked-by: Michal Hocko <mhocko@suse.com>
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
>
