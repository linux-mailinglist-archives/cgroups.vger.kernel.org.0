Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231BD79EE3D
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjIMQ1H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 12:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQ1H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 12:27:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23C90
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 09:27:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso11570003e87.2
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694622421; x=1695227221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImOmWwyz3HgbNLgn7J7BpKMz/6LOvIVMJphJtWNdFH8=;
        b=dpu132IaVVp+relroyqnNAL3TlUDIujgrY3YhrTsTK3iIdtO2UvXmDXiGT6R5kpxC6
         2kc38y4vntXBfNjsZhUnrxCofD5mi/1AMvh1Dp/1UJma/QlDNu5A/sN820r0pPQ8v90r
         aD4IxQ87mKb3ch18nY83HFrIYkAPPng0G+R635TasScQb7LkUGrz0iu2OsI3cqIVwwNw
         yl4TCrm4w39n6T06UaCRx8c41rtrN7hKKMF+Gt/wzKcwrYBWTKJN/dt/tsIjHHfBymQH
         sJm0rzU3MoiJLfBAKBVortdvjzpwac3aIq7Tl4QyjBm2xnuBej9F5LD4c48LVYGIKP19
         IzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622421; x=1695227221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImOmWwyz3HgbNLgn7J7BpKMz/6LOvIVMJphJtWNdFH8=;
        b=EuDcmk4tUPRZO4krZwef9xvLayOUiesDuEXTIcn3FgbAdJtfnlv/j6AsfF/hYywywj
         IVI4kOoI+zh84hmgOV8f/41tpbuLdCvp94O3mtbMbr1VTGoQw6UW/PK83PH8lkuh9pYK
         QU+BGui0pIOkyHHiBPXuC+25yH6U9g9NU4vTfDifHD6vul1qUIfNCvkhVDWQdaDAATKk
         xav5H79yrIQFqpEqvQxWVk9zLREyF6jmoxIxHqdo1cE7E1DnHyKts8E06cdIb99j5bPt
         4QQMKll27DZd10w2z5r3iiBhCRueqScWWSt3wcQ80YYx+1E+jbqPKa+10hAgEDpjqng/
         OShg==
X-Gm-Message-State: AOJu0Yy6pcA1fugLN/C7HgVP0k/wUHkLBmlh2XvXyAHF/QG2M3BoBjO3
        ynPRcFiObSHaDYJehxEdUBVV6cga+327dFcHFTUAyQ==
X-Google-Smtp-Source: AGHT+IEVdrBXV15I+ebTdMHsS+CO9RcO+hxE2cChEkzf2US6/FybJsU7ff11kqhIJmPbKyT3SJ5hc475zEtcYSVRnv4=
X-Received: by 2002:a05:6512:3486:b0:500:d960:8b6d with SMTP id
 v6-20020a056512348600b00500d9608b6dmr2284441lfr.33.1694622420933; Wed, 13 Sep
 2023 09:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <20230913153758.GB45543@cmpxchg.org>
In-Reply-To: <20230913153758.GB45543@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Sep 2023 09:26:21 -0700
Message-ID: <CAJD7tka20+zB1aFfmdEBX5a3bLDTbGHuZP7sV3cvLvT8dvvaAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 8:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Sep 13, 2023 at 07:38:46AM +0000, Yosry Ahmed wrote:
> > Stats flushing for memcg currently follows the following rules:
> > - Always flush the entire memcg hierarchy (i.e. flush the root).
> > - Only one flusher is allowed at a time. If someone else tries to flush
> >   concurrently, they skip and return immediately.
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
> >   be too expensive as it has to flush the entire hierarchy [1].
> > - Sometimes the stats accuracy are compromised if there is an ongoing
> >   flush, and we skip and return before the subtree of interest is
> >   actually flushed. This is more visible when reading stats from
> >   userspace, but can also affect in-kernel flushers.
> >
> > This patch aims to solve both problems by reworking how flushing
> > currently works as follows:
> > - Without contention, there is no need to flush the entire tree. In thi=
s
> >   case, only flush the subtree of interest. This avoids the latency of =
a
> >   full root flush if unnecessary.
> > - With contention, fallback to a coalesced (aka unified) flush of the
> >   entire hierarchy, a root flush. In this case, instead of returning
> >   immediately if a root flush is ongoing, wait for it to finish
> >   *without* attempting to acquire the lock or flush. This is done using
> >   a completion. Compared to competing directly on the underlying lock,
> >   this approach makes concurrent flushing a synchronization point
> >   instead of a serialization point. Once  a root flush finishes, *all*
> >   waiters can wake up and continue at once.
> > - Finally, with very high contention, bound the number of waiters to th=
e
> >   number of online cpus. This keeps the flush latency bounded at the ta=
il
> >   (very high concurrency). We fallback to sacrificing stats freshness o=
nly
> >   in such cases in favor of performance.
> >
> > This was tested in two ways on a machine with 384 cpus:
> > - A synthetic test with 5000 concurrent workers doing allocations and
> >   reclaim, as well as 1000 readers for memory.stat (variation of [2]).
> >   No significant regressions were noticed in the total runtime.
> >   Note that if concurrent flushers compete directly on the spinlock
> >   instead of waiting for a completion, this test shows 2x-3x slowdowns.
> >   Even though subsequent flushers would have nothing to flush, just the
> >   serialization and lock contention is a major problem. Using a
> >   completion for synchronization instead seems to overcome this problem=
.
> >
> > - A synthetic stress test for concurrently reading memcg stats provided
> >   by Wei Xu.
> >   With 10k threads reading the stats every 100ms:
> >   - 98.8% of reads take <100us
> >   - 1.09% of reads take 100us to 1ms.
> >   - 0.11% of reads take 1ms to 10ms.
> >   - Almost no reads take more than 10ms.
> >   With 10k threads reading the stats every 10ms:
> >   - 82.3% of reads take <100us.
> >   - 4.2% of reads take 100us to 1ms.
> >   - 4.7% of reads take 1ms to 10ms.
> >   - 8.8% of reads take 10ms to 100ms.
> >   - Almost no reads take more than 100ms.
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
>
> >       /*
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
> >
> > -     WRITE_ONCE(flush_last_time, jiffies_64);
> > -
> > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> > +     /* A coalesced root flush is in order. Are we the designated flus=
her? */
> > +     spin_lock(&root_flusher_lock);
>
> I can't say I'm crazy about this.
>
> Let's say you have a fairly sprawling and active cgroup tree with lots
> of updates in lots of groups in the system.
>
> Add a periodic memory.stat reader to one of the subgroups, and that
> reader will do very fast, localized aggregation.
>
> Now add a periodic memory.stat reader to some other subgroup. They
> might still both do very fast, localized aggregation. Or they might
> collide; and now - despite having nothing in common, and sharing no
> data besides the rstat lock - will have to flush the entire massive
> tree. The rate at which this happens is purely dependent on timing of
> what should be independent actors. This is really not great for the
> p50 vs p99 gap.

Initially I had a few retry iterations for the subtree flush, where we
fsleep for a bit and trylock again. I thought it was a little bit too
complicated and the fsleep duration would be a magic value.

>
> I think this whole thing is getting away from us.
>
> When we first switched to rstat, every reader would take the global
> rstat lock and then flush its local subtree of interest.
>
> This was changed in the following commit:
>
> commit fd25a9e0e23b995fd0ba5e2f00a1099452cbc3cf
> Author: Shakeel Butt <shakeelb@google.com>
> Date:   Fri Nov 5 13:37:34 2021 -0700
>
>     memcg: unify memcg stat flushing
>
>     The memcg stats can be flushed in multiple context and potentially in
>     parallel too.  For example multiple parallel user space readers for
>     memcg stats will contend on the rstat locks with each other.  There i=
s
>     no need for that.  We just need one flusher and everyone else can
>     benefit.
>
>     In addition after aa48e47e3906 ("memcg: infrastructure to flush memcg
>     stats") the kernel periodically flush the memcg stats from the root, =
so,
>     the other flushers will potentially have much less work to do.
>
>     Link: https://lkml.kernel.org/r/20211001190040.48086-2-shakeelb@googl=
e.com
>     Signed-off-by: Shakeel Butt <shakeelb@google.com>
>     Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>     Cc: Michal Hocko <mhocko@kernel.org>
>     Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> The idea was that we can avoid lock contention if somebody is already
> doing the flushing. However, you're now bringing global serialization.
> Clearly that idea didn't work out. What would be an obstacle to go
> back to the original way of doing it?

The obstacle is high concurrency among flushers. A good example is
reclaim code, we can have a lot of concurrent reclaimers. When I tried
to go back to the original way of doing it, a stress test with high
reclaim concurrency (100s or 1000s) would be 2x-3x slower. I think
high concurrency among userspace reads would have a similar outcome,
but I hadn't really checked.

Basically this patch is trying to switch to root flushing when the
cost of contending on the lock is roughly the same as a root flush (or
waiting for one). It's doing that too eagerly now of course (if
contenders > 1), we can try to calibrate this better.

>
> With one reader, this will work the same as in your proposal.
>
> With two readers, just like in your proposal, flushing must be
> serialized against the root level. But at least the two flushes only
> aggregate the local data they actually care about - not the entire
> tree data that doesn't even have readers! This is much better for lock
> contention and performance.

Keep in mind that in my testing, I noticed that synchronization using
a completion is more performant than serialization on a lock. I am
assuming because when we contend on the underlying lock, we serially
wake up and do the flush. Even if there is nothing to do (as you
mention below), we still do this work. On the contrary, in this
proposal we just wait for the root flush to finish and return
immediately, and all waiters return at once (that's a lie because of
scheduling internals).

Also, in the current code, in the two reader scenario, the first
reader will flush the entire tree anyway. The only difference is that
the second reader will wait for it to finish instead of just skipping,
which is the right thing to do from a correctness point of view. Right
now it's a coin flip on whether you get updated stats if someone else
is already flushing.

Having said that, I understand your concern, but I am not really sure
how to bring back subtree flushing for all cases without regressing
in-kernel flushers with high concurrency. I tried and it seemed to
harm performance (at least of synthetic benchmarks). I also tried to
break down the underlying rstat global lock, but that didn't turn out
to be simple either.

>
> One concern is the thresholding code. The cost of flushing on every
> read is too high: even when there is no flush work, checking for it is
> kind of expensive due to the locks and the for_each_possible_cpu().
>
> Could we do something like the following?
>
>         mem_cgroup_flush(memcg)
>         {
>                 mutex_lock(&memcg_flush_mutex);
>                 if (atomic_read(&memcg->stat_delta) > THRESHOLD)
>                         cgroup_rstat_flush(memcg);
>                 mutex_unlock(&memcg_flush_mutex);
>         }
>
>         mem_cgroup_css_rstat_flush(css, cpu)
>         {
>                 ...
>                 /*
>                  * Reset here instead of mem_cgroup_flush()
>                  * so that each flushed subgroup is reset
>                  * recursively. A recent parent flush will
>                  * allow a child flush to skip.
>                  */
>                 atomic_set(&mem_cgroup_from_css(css)->stat_delta, 0);
>         }
>
>         memcg_rstat_updated(memcg, val)
>         {
>                 atomic_add(&memcg->stat_delta, val);

We need to do this for each parent in the hierarchy, not just the
memcg being updated, right? I guess that may be too expensive for the
update path.

I thought about doing it percpu and propagating to global "stat
deltas" when each cpu has enough updates, similar to what we do now
with the global delta. To do this efficiently we would want to move
that to the cgroup core code, since we already have parents iteration
in cgroup_rstat_updated() and we might want to reuse that. I also
thought that may be too complex.

Anyway, I am open to suggestions on how to improve this.

>         }
