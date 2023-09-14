Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7777A0BAA
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjINRZq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjINRZ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 13:25:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5160830F9
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:24:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so177066366b.0
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694712248; x=1695317048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAol+H1zFCoUfUfZZsDgx8UsnqMjiiU4tH87PfqSwyE=;
        b=iQa70wecFwmLv+kCAgYaStnuRHfGvXBl7s5U34NvLqhlxlg+tERIMVu52MbTZuKo4C
         L6VMKz6t/YROPEuDzxNOVB3TXbhbmUGlgfvluECwH2BS2ZeHNfrk/v+MIEQxZIj2HPub
         jBC7K+C4mnQnodAcH89sFb+JhOtup6kjyY4OWbYgAVJRhiD6s8VfAj3TM2jyg0baTzsz
         a5/Jbdsiu2IgQWhQ+8dduPlsB5mxlby/34iig0oGAGAAKQhwVbWnJhYCyvy7Ib9OF407
         Bl32Mgk8cpBnm3ca0nI6V7SO5Gw47ReiMytdPSWlrpGzB1pDRegnikIWPJyVG1cdXkgq
         9Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712248; x=1695317048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAol+H1zFCoUfUfZZsDgx8UsnqMjiiU4tH87PfqSwyE=;
        b=ikFBV08gY4I47sK3g6im0925FIeeDc5Jt5qYEjKhwYHFRozUGOnKTTjLWAPHpY9mIc
         o2FAcvSYZslc9WM0Nr9IJ0f8uTZe32Ca47EYiw2DdtVsuFNrX1N1cnTnlGTHjBYyt4vY
         0+WuVP0OLk8f/cgySi6Y9xtZumFJkvI+69KZbqXkzMFRa3wMyo2ze64GwZCC7yJuM9gA
         0DFS2OUo322Ga6DvbMQiLrru4i7YsJ6V6HheesDR12ysnNiOT7pIzq+gBDflnIMATKLj
         U1uxGVB7X4sXloWnKhfBoSdq58j3mizsZ9azqV731wAdhiiedVJXChatjFjsclvhEuVO
         nhgg==
X-Gm-Message-State: AOJu0YzRZcuWWPEp0P01Dv355aUQ7ly6KFaKHowwEi5ssuqQ7D6hT2SP
        loD5OANkhGMvIZmNJ0jNVGDbTOqMrt37MTRKElI4hA==
X-Google-Smtp-Source: AGHT+IHWksLy8b4MaP0yc3guF9uxsIs2zA1FdqPPrF9TCV9z+h3p9HoqX86uQ1qmdgX6yCisUg0TOul1bo5gQuk/K7Y=
X-Received: by 2002:a17:906:76cb:b0:9a5:846d:d829 with SMTP id
 q11-20020a17090676cb00b009a5846dd829mr5071449ejn.18.1694712247530; Thu, 14
 Sep 2023 10:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <cbad0762-892f-229e-280e-1faafbcb36b8@redhat.com>
In-Reply-To: <cbad0762-892f-229e-280e-1faafbcb36b8@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Sep 2023 10:23:31 -0700
Message-ID: <CAJD7tkYGaVVbMpd6RC7QreLGCWpvMEmwJ9LJAZHKqdsTGM22-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 10:19=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
>
> On 9/13/23 03:38, Yosry Ahmed wrote:
> > Stats flushing for memcg currently follows the following rules:
> > - Always flush the entire memcg hierarchy (i.e. flush the root).
> > - Only one flusher is allowed at a time. If someone else tries to flush
> >    concurrently, they skip and return immediately.
> > - A periodic flusher flushes all the stats every 2 seconds.
> >
> > The reason this approach is followed is because all flushes are
> > serialized by a global rstat spinlock. On the memcg side, flushing is
> > invoked from userspace reads as well as in-kernel flushers (e.g.
> > reclaim, refault, etc). This approach aims to avoid serializing all
> > flushers on the global lock, which can cause a significant performance
> > hit under high concurrency.
> >
> > This approach has the following problems:
> > - Occasionally a userspace read of the stats of a non-root cgroup will
> >    be too expensive as it has to flush the entire hierarchy [1].
> > - Sometimes the stats accuracy are compromised if there is an ongoing
> >    flush, and we skip and return before the subtree of interest is
> >    actually flushed. This is more visible when reading stats from
> >    userspace, but can also affect in-kernel flushers.
> >
> > This patch aims to solve both problems by reworking how flushing
> > currently works as follows:
> > - Without contention, there is no need to flush the entire tree. In thi=
s
> >    case, only flush the subtree of interest. This avoids the latency of=
 a
> >    full root flush if unnecessary.
> > - With contention, fallback to a coalesced (aka unified) flush of the
> >    entire hierarchy, a root flush. In this case, instead of returning
> >    immediately if a root flush is ongoing, wait for it to finish
> >    *without* attempting to acquire the lock or flush. This is done usin=
g
> >    a completion. Compared to competing directly on the underlying lock,
> >    this approach makes concurrent flushing a synchronization point
> >    instead of a serialization point. Once  a root flush finishes, *all*
> >    waiters can wake up and continue at once.
> > - Finally, with very high contention, bound the number of waiters to th=
e
> >    number of online cpus. This keeps the flush latency bounded at the t=
ail
> >    (very high concurrency). We fallback to sacrificing stats freshness =
only
> >    in such cases in favor of performance.
> >
> > This was tested in two ways on a machine with 384 cpus:
> > - A synthetic test with 5000 concurrent workers doing allocations and
> >    reclaim, as well as 1000 readers for memory.stat (variation of [2]).
> >    No significant regressions were noticed in the total runtime.
> >    Note that if concurrent flushers compete directly on the spinlock
> >    instead of waiting for a completion, this test shows 2x-3x slowdowns=
.
> >    Even though subsequent flushers would have nothing to flush, just th=
e
> >    serialization and lock contention is a major problem. Using a
> >    completion for synchronization instead seems to overcome this proble=
m.
> >
> > - A synthetic stress test for concurrently reading memcg stats provided
> >    by Wei Xu.
> >    With 10k threads reading the stats every 100ms:
> >    - 98.8% of reads take <100us
> >    - 1.09% of reads take 100us to 1ms.
> >    - 0.11% of reads take 1ms to 10ms.
> >    - Almost no reads take more than 10ms.
> >    With 10k threads reading the stats every 10ms:
> >    - 82.3% of reads take <100us.
> >    - 4.2% of reads take 100us to 1ms.
> >    - 4.7% of reads take 1ms to 10ms.
> >    - 8.8% of reads take 10ms to 100ms.
> >    - Almost no reads take more than 100ms.
> >
> > [1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43=
KO9ME4-dsgfoQ@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcO=
BZcz6POYTV-4g@mail.gmail.com/
> > [3] https://lore.kernel.org/lkml/CAAPL-u9D2b=3DiF5Lf_cRnKxUfkiEe0AMDTu6=
yhrUAzX0b6a6rDg@mail.gmail.com/
> >
> > [weixugc@google.com: suggested the fallback logic and bounding the
> > number of waiters]
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >   include/linux/memcontrol.h |   4 +-
> >   mm/memcontrol.c            | 100 ++++++++++++++++++++++++++++--------=
-
> >   mm/vmscan.c                |   2 +-
> >   mm/workingset.c            |   8 ++-
> >   4 files changed, 85 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 11810a2cfd2d..4453cd3fc4b8 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1034,7 +1034,7 @@ static inline unsigned long lruvec_page_state_loc=
al(struct lruvec *lruvec,
> >       return x;
> >   }
> >
> > -void mem_cgroup_flush_stats(void);
> > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
> >   void mem_cgroup_flush_stats_ratelimited(void);
> >
> >   void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_i=
tem idx,
> > @@ -1519,7 +1519,7 @@ static inline unsigned long lruvec_page_state_loc=
al(struct lruvec *lruvec,
> >       return node_page_state(lruvec_pgdat(lruvec), idx);
> >   }
> >
> > -static inline void mem_cgroup_flush_stats(void)
> > +static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >   {
> >   }
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d729870505f1..edff41e4b4e7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -588,7 +588,6 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
> >   static void flush_memcg_stats_dwork(struct work_struct *w);
> >   static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_d=
work);
> >   static DEFINE_PER_CPU(unsigned int, stats_updates);
> > -static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
> >   /* stats_updates_order is in multiples of MEMCG_CHARGE_BATCH */
> >   static atomic_t stats_updates_order =3D ATOMIC_INIT(0);
> >   static u64 flush_last_time;
> > @@ -639,36 +638,87 @@ static inline void memcg_rstat_updated(struct mem=
_cgroup *memcg, int val)
> >       }
> >   }
> >
> > -static void do_flush_stats(void)
> > +/*
> > + * do_flush_stats - flush the statistics of a memory cgroup and its tr=
ee
> > + * @memcg: the memory cgroup to flush
> > + * @wait: wait for an ongoing root flush to complete before returning
> > + *
> > + * All flushes are serialized by the underlying rstat global lock. If =
there is
> > + * no contention, we try to only flush the subtree of the passed @memc=
g to
> > + * minimize the work. Otherwise, we coalesce multiple flushing request=
s into a
> > + * single flush of the root memcg. When there is an ongoing root flush=
, we wait
> > + * for its completion (unless otherwise requested), to get fresh stats=
. If the
> > + * number of waiters exceeds the number of cpus just skip the flush to=
 bound the
> > + * flush latency at the tail with very high concurrency.
> > + *
> > + * This is a trade-off between stats accuracy and flush latency.
> > + */
> > +static void do_flush_stats(struct mem_cgroup *memcg, bool wait)
> >   {
> > +     static DECLARE_COMPLETION(root_flush_done);
> > +     static DEFINE_SPINLOCK(root_flusher_lock);
> > +     static DEFINE_MUTEX(subtree_flush_mutex);
> > +     static atomic_t waiters =3D ATOMIC_INIT(0);
> > +     static bool root_flush_ongoing;
> > +     bool root_flusher =3D false;
> > +
> > +     /* Ongoing root flush, just wait for it (unless otherwise request=
ed) */
> > +     if (READ_ONCE(root_flush_ongoing))
> > +             goto root_flush_or_wait;
> > +
> >       /*
> > -      * We always flush the entire tree, so concurrent flushers can ju=
st
> > -      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > +      * Opportunistically try to only flush the requested subtree. Oth=
erwise
> > +      * fallback to a coalesced flush below.
> >        */
> > -     if (atomic_read(&stats_flush_ongoing) ||
> > -         atomic_xchg(&stats_flush_ongoing, 1))
> > +     if (!mem_cgroup_is_root(memcg) && mutex_trylock(&subtree_flush_mu=
tex)) {
> > +             cgroup_rstat_flush(memcg->css.cgroup);
> > +             mutex_unlock(&subtree_flush_mutex);
> >               return;
> > +     }
>
> If mutex_trylock() is the only way to acquire subtree_flush_mutex, you
> don't really need a mutex. Just a simple integer flag with xchg() call
> should be enough.

Thanks for pointing this out. Agreed.

If we keep this approach I will drop that mutex.

>
> Cheers,
> Longman
>
