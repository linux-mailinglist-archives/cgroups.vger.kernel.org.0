Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2BD7A0B91
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbjINRYB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjINRXf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 13:23:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6B30C8
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:22:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a9cd066db5so172491766b.0
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694712178; x=1695316978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P8Iz0AXrz+yvXhSdzWefKmGB+E6NxTMaN+Ka9Zbzsc=;
        b=FAGDhbzUm8fYwBUzU8t1UQ1PrtOq8au6U1PIQ+YF0ED+DyavoVwTdTCRMnIM1dQFOx
         QeT54VR0nfEdA5VWV4i+KxrZJfTe9Eggji/WXACghUZGYdIbmA6kip9DuY0KF+xlRd5m
         UM/lfR/zTEh8DsyvUJsrRPIjx6MD2XOyKVPpUlECY2gw2j5c/EkrvZSXH962ISyZDhOq
         DHO71trPKGLQ8Fn2u7n4WUy1yFTkdk50+BCuXAtYACbTwe781fGtuu2fnNRxKkWvv8bt
         w51qPFYIALPc2BLuIZ99BeAnnn2ZLjCDTQJTCzPVa/YHzFqEN/nO+unH31KJuUVvpHqL
         HvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712178; x=1695316978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P8Iz0AXrz+yvXhSdzWefKmGB+E6NxTMaN+Ka9Zbzsc=;
        b=Cm09E9hplhcPTPfMDHBEmnxIuFBKgSELi0rJTwvZexisUjwbRFl1qgkCc4AI81dbIC
         xx5qvnki4cns+y7QhIC9Eer7AvE7A2ueCzGPJHXKlrhGvjkRqIs7Umhsl1CGiXpMndH4
         L18blyS7+4EvQbBC4hEuNtFqvm26kaeEXCPDlaW7YtOPpAhapf8EgSRJn0Pw8SK5JtAd
         QEyF6IiSu971cvU3H2FYLA79fkssOigA9W/ArXczSNRkcL2HnPHEnpA1eIDGzrh/xyl3
         olFIEhehmduAyHAX93aF+ekphU/Xwv94xp2U4bi4S1emLVGqzqVk6pXIeHblS7qt6eLQ
         35lg==
X-Gm-Message-State: AOJu0YzK5KT/pudaRCmf/gqdGxNTBg5CDyzBXXFYfsq/k0UXHOw7VNXh
        V/lKtghcOJZ4iC1zZjmFjLPHdqJbRytLx/MhkuGjng==
X-Google-Smtp-Source: AGHT+IFs/OlQ0X2hkz+pYOiU8/CErI+9ARlTKYrPBUE/JYU1jBkndyPNKYHMSI3ubRLgzRJNTrufvQPBaMiMFuUKp/I=
X-Received: by 2002:a17:907:2c6a:b0:9a1:aea2:d18d with SMTP id
 ib10-20020a1709072c6a00b009a1aea2d18dmr4701892ejc.48.1694712177785; Thu, 14
 Sep 2023 10:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <20230913153758.GB45543@cmpxchg.org>
 <CAJD7tka20+zB1aFfmdEBX5a3bLDTbGHuZP7sV3cvLvT8dvvaAA@mail.gmail.com> <20230914160646.GA101038@cmpxchg.org>
In-Reply-To: <20230914160646.GA101038@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Sep 2023 10:22:18 -0700
Message-ID: <CAJD7tkaLQ8H4-EiZimyZ4a=CbLb_0KEPE8RkPofFRVceSOqtnw@mail.gmail.com>
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

[..]
> > > > -
> > > > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> > > > +     /* A coalesced root flush is in order. Are we the designated =
flusher? */
> > > > +     spin_lock(&root_flusher_lock);
> > >
> > > I can't say I'm crazy about this.
> > >
> > > Let's say you have a fairly sprawling and active cgroup tree with lot=
s
> > > of updates in lots of groups in the system.
> > >
> > > Add a periodic memory.stat reader to one of the subgroups, and that
> > > reader will do very fast, localized aggregation.
> > >
> > > Now add a periodic memory.stat reader to some other subgroup. They
> > > might still both do very fast, localized aggregation. Or they might
> > > collide; and now - despite having nothing in common, and sharing no
> > > data besides the rstat lock - will have to flush the entire massive
> > > tree. The rate at which this happens is purely dependent on timing of
> > > what should be independent actors. This is really not great for the
> > > p50 vs p99 gap.
> >
> > Initially I had a few retry iterations for the subtree flush, where we
> > fsleep for a bit and trylock again. I thought it was a little bit too
> > complicated and the fsleep duration would be a magic value.
>
> Hm, how is that different than a mutex / sleepable lock?

It is essentially a lock with a timeout, which IIUC we don't support
explicitly in the kernel. What I was trying to do was basically to try
and do a subtree flush, but if we are waiting for too long then a lot
of people are probably flushing, so let's all switch to a root flush
and wait for one flusher instead of contending among ourselves.

>
> > > I think this whole thing is getting away from us.
> > >
> > > When we first switched to rstat, every reader would take the global
> > > rstat lock and then flush its local subtree of interest.
> > >
> > > This was changed in the following commit:
> > >
> > > commit fd25a9e0e23b995fd0ba5e2f00a1099452cbc3cf
> > > Author: Shakeel Butt <shakeelb@google.com>
> > > Date:   Fri Nov 5 13:37:34 2021 -0700
> > >
> > >     memcg: unify memcg stat flushing
> > >
> > >     The memcg stats can be flushed in multiple context and potentiall=
y in
> > >     parallel too.  For example multiple parallel user space readers f=
or
> > >     memcg stats will contend on the rstat locks with each other.  The=
re is
> > >     no need for that.  We just need one flusher and everyone else can
> > >     benefit.
> > >
> > >     In addition after aa48e47e3906 ("memcg: infrastructure to flush m=
emcg
> > >     stats") the kernel periodically flush the memcg stats from the ro=
ot, so,
> > >     the other flushers will potentially have much less work to do.
> > >
> > >     Link: https://lkml.kernel.org/r/20211001190040.48086-2-shakeelb@g=
oogle.com
> > >     Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > >     Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >     Cc: Michal Hocko <mhocko@kernel.org>
> > >     Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > >
> > > The idea was that we can avoid lock contention if somebody is already
> > > doing the flushing. However, you're now bringing global serialization=
.
> > > Clearly that idea didn't work out. What would be an obstacle to go
> > > back to the original way of doing it?
> >
> > The obstacle is high concurrency among flushers. A good example is
> > reclaim code, we can have a lot of concurrent reclaimers. When I tried
> > to go back to the original way of doing it, a stress test with high
> > reclaim concurrency (100s or 1000s) would be 2x-3x slower. I think
> > high concurrency among userspace reads would have a similar outcome,
> > but I hadn't really checked.
> >
> > Basically this patch is trying to switch to root flushing when the
> > cost of contending on the lock is roughly the same as a root flush (or
> > waiting for one). It's doing that too eagerly now of course (if
> > contenders > 1), we can try to calibrate this better.
>
> I don't quite understand this.
>
> If you have two readers on separate subtrees, why is it cheaper to
> flush the entire tree in sequence (where both readers don't care about
> the majority of the data), than having each reader flush their own
> small subset one after another? It's not like the whole tree flush
> parallelizes its work.
>
> Where is that overhead actually coming from?

If you have N concurrent readers flushing different parts of the
subtree, at some point the overhead of N sequential subtree flushes
will exceed the overhead of a single root flush.

Ideally, we would be able to identify this point, and switch to a
single root flush with everyone else waiting.

>
> > > With one reader, this will work the same as in your proposal.
> > >
> > > With two readers, just like in your proposal, flushing must be
> > > serialized against the root level. But at least the two flushes only
> > > aggregate the local data they actually care about - not the entire
> > > tree data that doesn't even have readers! This is much better for loc=
k
> > > contention and performance.
> >
> > Keep in mind that in my testing, I noticed that synchronization using
> > a completion is more performant than serialization on a lock. I am
> > assuming because when we contend on the underlying lock, we serially
> > wake up and do the flush. Even if there is nothing to do (as you
> > mention below), we still do this work. On the contrary, in this
> > proposal we just wait for the root flush to finish and return
> > immediately, and all waiters return at once (that's a lie because of
> > scheduling internals).
>
> Right, because rstat's do-nothing case is still somewhat costly due to
> the per-cpu loop and the tree walk.
>
> But that should be possible to avoid with the outlined caching of
> recently-flushed state at the memcg level.

This helps only if concurrent flushers are overlapping, right?

>
> > Also, in the current code, in the two reader scenario, the first
> > reader will flush the entire tree anyway. The only difference is that
> > the second reader will wait for it to finish instead of just skipping,
> > which is the right thing to do from a correctness point of view. Right
> > now it's a coin flip on whether you get updated stats if someone else
> > is already flushing.
>
> Agreed, it should wait. My mutex would accomplish this, right?

I think what you're describing here is v4 of the patchset I mention in
the cover letter:
https://lore.kernel.org/lkml/20230831165611.2610118-5-yosryahmed@google.com=
/

The problem with that was that with very high concurrency among
readers, the read latency is unbounded and can get out of hand. Wei
shared some numbers in that thread.

What this patch is trying to do is to switch to root flushing if the
mutex is contended to avoid that scenario.  Also, if we keep acquiring
more flushers at some point we just skip the flush in favor of
performance (if the number of waiters exceeds the number of cpus). Now
that I think about it, perhaps we can just go back to the mutex
approach w/ limiting the number of waiters, without ever falling back
to a root flush. Not sure how that would work.

Taking a step back, I think what you are implying is that if we make
the thresholding code per cpu instead of global, this should mitigate
the issue in a different way than falling back to root flushing or
limiting the number of waiters, is that right?
If yes, I think it will work in some cases where the flushes are
overlapping as I mentioned above, but not if concurrent readers are
flushing different parts of the tree. Right?

>
> > > One concern is the thresholding code. The cost of flushing on every
> > > read is too high: even when there is no flush work, checking for it i=
s
> > > kind of expensive due to the locks and the for_each_possible_cpu().
> > >
> > > Could we do something like the following?
> > >
> > >         mem_cgroup_flush(memcg)
> > >         {
> > >                 mutex_lock(&memcg_flush_mutex);
> > >                 if (atomic_read(&memcg->stat_delta) > THRESHOLD)
> > >                         cgroup_rstat_flush(memcg);
> > >                 mutex_unlock(&memcg_flush_mutex);
> > >         }
> > >
> > >         mem_cgroup_css_rstat_flush(css, cpu)
> > >         {
> > >                 ...
> > >                 /*
> > >                  * Reset here instead of mem_cgroup_flush()
> > >                  * so that each flushed subgroup is reset
> > >                  * recursively. A recent parent flush will
> > >                  * allow a child flush to skip.
> > >                  */
> > >                 atomic_set(&mem_cgroup_from_css(css)->stat_delta, 0);
> > >         }
> > >
> > >         memcg_rstat_updated(memcg, val)
> > >         {
> > >                 atomic_add(&memcg->stat_delta, val);
> >
> > We need to do this for each parent in the hierarchy, not just the
> > memcg being updated, right? I guess that may be too expensive for the
> > update path.
>
> How so?
>
> We need to mark the subgroups that are flushed, so that if you have
>
>         root - a - a1 - foo
>                 `- a2
>
> and somebody flushes a, then a1 and a2 also don't need to be flushed
> for a while.
>
> But if we flush a1 first, foo is aggregated into a1. Reading a still
> needs to aggregate a1 and a2 into a.
>
> Maybe I'm missing something blatant, but I don't see how we have to
> mark parents in any way. We only have to tag cgroups up to the point
> to which they were recently flushed, and we already visit all those.
>
> Let me know if I'm missing something blatant here.

I think we are talking about different paths. I believe you are
talking about resetting memcg->stat_delta, which I agree should be
done during the flush. What I am talking about is updating
memcg->stat_delta when memcg_rstat_updated() is called. We would need
to update that for all parents. In your example hierarchy, if stat
updates happened in a2, and someone tries to flush a, they should be
aware that there are stats to flush.
