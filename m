Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5457A598D
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjISFrs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 01:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISFrr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 01:47:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0CFC
        for <cgroups@vger.kernel.org>; Mon, 18 Sep 2023 22:47:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so701845666b.0
        for <cgroups@vger.kernel.org>; Mon, 18 Sep 2023 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695102459; x=1695707259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xfIG9KdEKzfzWV48TqKGy8yuhZf/fzFmsvnTAWnZnY=;
        b=KWCmHyAWzkihFp9y/OSsQKsHCiNgBLsUCsySzs+BxWsXUiqjodyRK7Q1lNJW5qyWgk
         kUQUzOm4azitFyBdrJX2nmEqX6nKuvE78n5ww5k0ZiknEoD7f5TXboIBQazK5mvryJY8
         a4SxKKZ6gd3lcRTRp1pUun/La6nEcQcWD4D/GrIgM5hK219ICH9hRaVUWpO6RVc535V9
         +Qkk+NMa07Aa/pRG1zMBaG+9FObDKm1Le8LcxDdp+OQZBgemX0Gnela/N4zFQAzBPL5k
         QVgD6EGQqvvihRDC0TtKZA/LBX7BBZjwyW23wF+amoMBbWhgEDzgxh2UGx/d3gVGHmBL
         /JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102459; x=1695707259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xfIG9KdEKzfzWV48TqKGy8yuhZf/fzFmsvnTAWnZnY=;
        b=UZyexDyybYaiaZ3CeHH8kC7Lib9IfZvMJfrnQnxBmJ7L6sptO/pet67mbBjJ3cKYlP
         NimaDUv7BRANZtxQ4h5FtO4elSlwiJ0U1S6ps4/BSbYsScZPoVR1EhU93SVs9OCt32It
         PLYyFX5kFUwZY4bmUUIfjBwLUpmlmgLKCT7DwAUAxeSwpRHhPNJVEdEHknKoFxysDCF2
         tiftEaXxy5whVhyRzBa0e5+uFlrGfdauGnSqNVSAcP5+XPLz8HzDuK04GsG09+Juvfeo
         LFCzkEKSXHta/3l5e0xL/9ROElR3wEv9+Y1JdJQ7KhR8G8JGcgw1K/DGFyOTmIwwAuBU
         LJTQ==
X-Gm-Message-State: AOJu0YynuPcEmsWsdHWX52zKIHdy843BPEIZEDIMyqe/dw72JcWS/v1m
        eno1L2CMY2HSb8+kh9ma9QkI93cTO3whTmyWHBmVQw==
X-Google-Smtp-Source: AGHT+IGNGBIeFJj6yhb5F27uXDFl+ViMtZsOLJQYKvma9IUQMKmLcRFeePgUAVFqRabRN31OIJ0KGN2KU4ozpMGM+mU=
X-Received: by 2002:a17:906:5188:b0:9a1:db97:62a1 with SMTP id
 y8-20020a170906518800b009a1db9762a1mr9106328ejk.46.1695102458872; Mon, 18 Sep
 2023 22:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <20230913153758.GB45543@cmpxchg.org>
 <CAJD7tka20+zB1aFfmdEBX5a3bLDTbGHuZP7sV3cvLvT8dvvaAA@mail.gmail.com>
 <20230914160646.GA101038@cmpxchg.org> <CAJD7tkaLQ8H4-EiZimyZ4a=CbLb_0KEPE8RkPofFRVceSOqtnw@mail.gmail.com>
In-Reply-To: <CAJD7tkaLQ8H4-EiZimyZ4a=CbLb_0KEPE8RkPofFRVceSOqtnw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 18 Sep 2023 22:46:59 -0700
Message-ID: <CAJD7tkZcee3CmZ3Zgi1HSeD9O=z3t52856SgUJNHNV8Xu-k3jQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 14, 2023 at 10:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> [..]
> > > > > -
> > > > > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> > > > > +     /* A coalesced root flush is in order. Are we the designate=
d flusher? */
> > > > > +     spin_lock(&root_flusher_lock);
> > > >
> > > > I can't say I'm crazy about this.
> > > >
> > > > Let's say you have a fairly sprawling and active cgroup tree with l=
ots
> > > > of updates in lots of groups in the system.
> > > >
> > > > Add a periodic memory.stat reader to one of the subgroups, and that
> > > > reader will do very fast, localized aggregation.
> > > >
> > > > Now add a periodic memory.stat reader to some other subgroup. They
> > > > might still both do very fast, localized aggregation. Or they might
> > > > collide; and now - despite having nothing in common, and sharing no
> > > > data besides the rstat lock - will have to flush the entire massive
> > > > tree. The rate at which this happens is purely dependent on timing =
of
> > > > what should be independent actors. This is really not great for the
> > > > p50 vs p99 gap.
> > >
> > > Initially I had a few retry iterations for the subtree flush, where w=
e
> > > fsleep for a bit and trylock again. I thought it was a little bit too
> > > complicated and the fsleep duration would be a magic value.
> >
> > Hm, how is that different than a mutex / sleepable lock?
>
> It is essentially a lock with a timeout, which IIUC we don't support
> explicitly in the kernel. What I was trying to do was basically to try
> and do a subtree flush, but if we are waiting for too long then a lot
> of people are probably flushing, so let's all switch to a root flush
> and wait for one flusher instead of contending among ourselves.
>
> >
> > > > I think this whole thing is getting away from us.
> > > >
> > > > When we first switched to rstat, every reader would take the global
> > > > rstat lock and then flush its local subtree of interest.
> > > >
> > > > This was changed in the following commit:
> > > >
> > > > commit fd25a9e0e23b995fd0ba5e2f00a1099452cbc3cf
> > > > Author: Shakeel Butt <shakeelb@google.com>
> > > > Date:   Fri Nov 5 13:37:34 2021 -0700
> > > >
> > > >     memcg: unify memcg stat flushing
> > > >
> > > >     The memcg stats can be flushed in multiple context and potentia=
lly in
> > > >     parallel too.  For example multiple parallel user space readers=
 for
> > > >     memcg stats will contend on the rstat locks with each other.  T=
here is
> > > >     no need for that.  We just need one flusher and everyone else c=
an
> > > >     benefit.
> > > >
> > > >     In addition after aa48e47e3906 ("memcg: infrastructure to flush=
 memcg
> > > >     stats") the kernel periodically flush the memcg stats from the =
root, so,
> > > >     the other flushers will potentially have much less work to do.
> > > >
> > > >     Link: https://lkml.kernel.org/r/20211001190040.48086-2-shakeelb=
@google.com
> > > >     Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > >     Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >     Cc: Michal Hocko <mhocko@kernel.org>
> > > >     Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > >
> > > > The idea was that we can avoid lock contention if somebody is alrea=
dy
> > > > doing the flushing. However, you're now bringing global serializati=
on.
> > > > Clearly that idea didn't work out. What would be an obstacle to go
> > > > back to the original way of doing it?
> > >
> > > The obstacle is high concurrency among flushers. A good example is
> > > reclaim code, we can have a lot of concurrent reclaimers. When I trie=
d
> > > to go back to the original way of doing it, a stress test with high
> > > reclaim concurrency (100s or 1000s) would be 2x-3x slower. I think
> > > high concurrency among userspace reads would have a similar outcome,
> > > but I hadn't really checked.
> > >
> > > Basically this patch is trying to switch to root flushing when the
> > > cost of contending on the lock is roughly the same as a root flush (o=
r
> > > waiting for one). It's doing that too eagerly now of course (if
> > > contenders > 1), we can try to calibrate this better.
> >
> > I don't quite understand this.
> >
> > If you have two readers on separate subtrees, why is it cheaper to
> > flush the entire tree in sequence (where both readers don't care about
> > the majority of the data), than having each reader flush their own
> > small subset one after another? It's not like the whole tree flush
> > parallelizes its work.
> >
> > Where is that overhead actually coming from?
>
> If you have N concurrent readers flushing different parts of the
> subtree, at some point the overhead of N sequential subtree flushes
> will exceed the overhead of a single root flush.
>
> Ideally, we would be able to identify this point, and switch to a
> single root flush with everyone else waiting.
>
> >
> > > > With one reader, this will work the same as in your proposal.
> > > >
> > > > With two readers, just like in your proposal, flushing must be
> > > > serialized against the root level. But at least the two flushes onl=
y
> > > > aggregate the local data they actually care about - not the entire
> > > > tree data that doesn't even have readers! This is much better for l=
ock
> > > > contention and performance.
> > >
> > > Keep in mind that in my testing, I noticed that synchronization using
> > > a completion is more performant than serialization on a lock. I am
> > > assuming because when we contend on the underlying lock, we serially
> > > wake up and do the flush. Even if there is nothing to do (as you
> > > mention below), we still do this work. On the contrary, in this
> > > proposal we just wait for the root flush to finish and return
> > > immediately, and all waiters return at once (that's a lie because of
> > > scheduling internals).
> >
> > Right, because rstat's do-nothing case is still somewhat costly due to
> > the per-cpu loop and the tree walk.
> >
> > But that should be possible to avoid with the outlined caching of
> > recently-flushed state at the memcg level.
>
> This helps only if concurrent flushers are overlapping, right?
>
> >
> > > Also, in the current code, in the two reader scenario, the first
> > > reader will flush the entire tree anyway. The only difference is that
> > > the second reader will wait for it to finish instead of just skipping=
,
> > > which is the right thing to do from a correctness point of view. Righ=
t
> > > now it's a coin flip on whether you get updated stats if someone else
> > > is already flushing.
> >
> > Agreed, it should wait. My mutex would accomplish this, right?
>
> I think what you're describing here is v4 of the patchset I mention in
> the cover letter:
> https://lore.kernel.org/lkml/20230831165611.2610118-5-yosryahmed@google.c=
om/
>
> The problem with that was that with very high concurrency among
> readers, the read latency is unbounded and can get out of hand. Wei
> shared some numbers in that thread.
>
> What this patch is trying to do is to switch to root flushing if the
> mutex is contended to avoid that scenario.  Also, if we keep acquiring
> more flushers at some point we just skip the flush in favor of
> performance (if the number of waiters exceeds the number of cpus). Now
> that I think about it, perhaps we can just go back to the mutex
> approach w/ limiting the number of waiters, without ever falling back
> to a root flush. Not sure how that would work.
>
> Taking a step back, I think what you are implying is that if we make
> the thresholding code per cpu instead of global, this should mitigate
> the issue in a different way than falling back to root flushing or
> limiting the number of waiters, is that right?
> If yes, I think it will work in some cases where the flushes are
> overlapping as I mentioned above, but not if concurrent readers are
> flushing different parts of the tree. Right?
>
> >
> > > > One concern is the thresholding code. The cost of flushing on every
> > > > read is too high: even when there is no flush work, checking for it=
 is
> > > > kind of expensive due to the locks and the for_each_possible_cpu().
> > > >
> > > > Could we do something like the following?
> > > >
> > > >         mem_cgroup_flush(memcg)
> > > >         {
> > > >                 mutex_lock(&memcg_flush_mutex);
> > > >                 if (atomic_read(&memcg->stat_delta) > THRESHOLD)
> > > >                         cgroup_rstat_flush(memcg);
> > > >                 mutex_unlock(&memcg_flush_mutex);
> > > >         }
> > > >
> > > >         mem_cgroup_css_rstat_flush(css, cpu)
> > > >         {
> > > >                 ...
> > > >                 /*
> > > >                  * Reset here instead of mem_cgroup_flush()
> > > >                  * so that each flushed subgroup is reset
> > > >                  * recursively. A recent parent flush will
> > > >                  * allow a child flush to skip.
> > > >                  */
> > > >                 atomic_set(&mem_cgroup_from_css(css)->stat_delta, 0=
);
> > > >         }
> > > >
> > > >         memcg_rstat_updated(memcg, val)
> > > >         {
> > > >                 atomic_add(&memcg->stat_delta, val);
> > >
> > > We need to do this for each parent in the hierarchy, not just the
> > > memcg being updated, right? I guess that may be too expensive for the
> > > update path.
> >
> > How so?
> >
> > We need to mark the subgroups that are flushed, so that if you have
> >
> >         root - a - a1 - foo
> >                 `- a2
> >
> > and somebody flushes a, then a1 and a2 also don't need to be flushed
> > for a while.
> >
> > But if we flush a1 first, foo is aggregated into a1. Reading a still
> > needs to aggregate a1 and a2 into a.
> >
> > Maybe I'm missing something blatant, but I don't see how we have to
> > mark parents in any way. We only have to tag cgroups up to the point
> > to which they were recently flushed, and we already visit all those.
> >
> > Let me know if I'm missing something blatant here.
>
> I think we are talking about different paths. I believe you are
> talking about resetting memcg->stat_delta, which I agree should be
> done during the flush. What I am talking about is updating
> memcg->stat_delta when memcg_rstat_updated() is called. We would need
> to update that for all parents. In your example hierarchy, if stat
> updates happened in a2, and someone tries to flush a, they should be
> aware that there are stats to flush.

Following up on this. I tried a simpler approach where the
stats_updates threshold is broken down to be per-memcg instead of
global, the update path looks like this:

  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
  {
          int cpu =3D smp_processor_id();
          unsigned int x;

          if (!val)
                  return;

          cgroup_rstat_updated(memcg->css.cgroup, cpu);

          for(; memcg; memcg =3D parent_mem_cgroup(memcg)) {
                  x =3D
__this_cpu_add_return(memcg->vmstats_percpu->stats_updates,
                                            abs(val));

                  if (x < MEMCG_CHARGE_BATCH)
                          continue;

                  /*
                   * If @memcg is already flush-able, increasing
stats_updates is
                   * redundant. Avoid the overhead of the atomic update.
                   */
                  if (!memcg_should_flush_stats(memcg))
                          atomic64_add(x, &memcg->vmstats->stats_updates);
                  __this_cpu_write(memcg->vmstats_percpu->stats_updates, 0)=
;
          }
  }

, and the flush path looks like this:

static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
  {
          return atomic64_read(&memcg->vmstats->stats_updates) >
                  MEMCG_CHARGE_BATCH * num_online_cpus();
  }

static void do_flush_stats(struct mem_cgroup *memcg)
  {
          if (mem_cgroup_is_root(memcg))
                  WRITE_ONCE(flush_last_time, jiffies_64);

          cgroup_rstat_flush(memcg->css.cgroup);
  }

  void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
  {
          static DEFINE_MUTEX(memcg_stats_flush_mutex);

          if (!memcg)
                  memcg =3D root_mem_cgroup;

          if (!memcg_should_flush_stats(memcg))
                  return;

          mutex_lock(&memcg_stats_flush_mutex);
          /* An overlapping flush may have occurred, check again after
locking */
          if (memcg_should_flush_stats(memcg))
                  do_flush_stats(memcg);
          mutex_unlock(&memcg_stats_flush_mutex);
  }

I tested this on a machine with 384 cpus. The flush latency looks very
promising for both in-kernel flushers and userspace readers with high
concurrency using the tests mentioned in the commit message.

On the update side, I wanted to check if this introduces a significant
regression, so I ran neper (https://github.com/google/neper) on two
machines running the same kernel with/without the above changes. I
used the tcp_stream test with 100/1000 flows and 50/500 threads. Neper
is running in a cgroup with 4 ancestors (In /$ROOT/a/b/c/d) to
exercise the parent loop. The throughput difference compared to the
base kernel is in the noise:

Base:
100 Flows, 50 Threads (3 runs):
Server: 125140.00 mbps, 122887.50 mbps, 113245.91 mbps  (average:
120424.47 mbps)
Client:133516.86 mbps, 124805.01 mbps, 140530.75 mbps (average: 132950.87 m=
bps)

1000 Flows, 100 Threads (3 runs):
Server:116898.27 mbps, 118676.94 mbps, 120715.44 mbps (average: 118763.55 m=
bps)
Client:122787.29 mbps, 122280.43 mbps, 126153.22 mbps (average: 123740.31 m=
bps)

Per-memcg thresholding:
100 Flows, 50 Threads (3 runs):
Server: 128207.34 mbps, 127585.55 mbps, 130776.84 mbps (average: 128856.57 =
mbps)
Client: 143734.97 mbps, 128632.56 mbps, 131616.10 mbps (average: 134661.21 =
mbps)

1000 Flows, 100 Threads (3 runs):
Server: 117790.86 mbps, 125489.63 mbps, 124459.77 mbps (average: 122580.09 =
mbps)
Client: 119257.34 mbps, 124650.42 mbps, 123717.24 mbps (average: 122541.67 =
mbps)

Looking at perf, the time spent in mem_cgroup_charge_skmem() increases
from 1.2% to 2.2% when running with 100 flows and 50 threads, but
stays almost the same when running with 1000 flows and 500 threads. I
guess at very high concurrency the overhead is negligible compared to
other potential bottlenecks.

I am not sure if that's enough signal that the update side can take
this change, but on the flush side things are looking really promising
with this approach. If the overhead is considered high we can split
the extra work between the update and the flush sides. Instead of a
single global atomic (memcg->vmstats->stats_updates), we can have N of
them and multiplex cpus onto them. memcg_should_flush_stats() would
iterate N counters instead of 1. I'd rather not jump to such
approaches if they are not needed.

Any thoughts?
