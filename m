Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F77A0BD6
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbjINRfk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbjINRfi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 13:35:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F35268D
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:26:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adca291f99so2212566b.2
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694712410; x=1695317210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPpwdq8G8RSqUrohA8xVfXt68tiwNJksEyoBIju0/jI=;
        b=J7d0KB3brYaw1NVG650yQgPo1xitv05+FSDFoZVlPf5d5GgJlogz7qCsB0M3xyuJe7
         diclStL0J423eM6d8VQf+Suq1QSIliW4TuWd2EdLHGbSx+G52k1Eqmr6CuuBdQyCxGPG
         54+5UOkRmQEtig2tqyV6s1H1m9vqd5oq9VMXV90YZOjnv87y0KLZXnFNhDLRXJqVxMf1
         r4AHWnfC6pVNUZx3mvn0uF/Fa7gIrf6hetsYoau+Mah3JJASQK78yyI3n0qMTe2P9OHK
         OR94KK2y+eQf+9LXlnkpcTAjnkCJtdBQ0SxCY40/JwZQYcsSDWuwogq3+VkmIt9WwDSF
         9EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712410; x=1695317210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPpwdq8G8RSqUrohA8xVfXt68tiwNJksEyoBIju0/jI=;
        b=B3UHIqOB+eTmRJUa3epe/ZDji5zOsOLct2xVA9v8Trz1zcMLywfAtqbc/cpZx/VT2G
         Qqg4gLibUo+pY/RaIbxfHIK1aNnXeSCqtxur1KIRxG6rERT79CLO2BTbMkOrMHlBGP0R
         63Bh4CXvbsRvaZzswSU7nYmynoFbUIcAupJmHjEPT1w9F8fiNH1V5mn/8B8Eo8u0vE06
         L/NdNmpw71qmfMZMMrRhMkVgvGNxvLdRJYyl3XxFOZm98huxbuR5MJa1MYueVCXk2Ph4
         2/zENh7YebYcyvV8EYmZY7D0Fbba8ygRMSluqACUri9iIQ2o8tPP9PlR31xp860k4/Kc
         cUig==
X-Gm-Message-State: AOJu0Yygeat1Jl+C/l2F0wkHmWv+XZAEs6aGjnYbp2hqsYi91nbBPKOk
        HPPl7EgfpcCD7XKEfh8YPK5xLOGZtPHV9gi4uuycuA==
X-Google-Smtp-Source: AGHT+IHzc3by5RZfH01NpCRYp2iBm0qf84qHRUGRD6axGr0/E/X2ANUEnA+CGS2ev4TU9lsPuI18ZMpno/NlwmcprGU=
X-Received: by 2002:a17:906:5385:b0:9a5:852f:10ae with SMTP id
 g5-20020a170906538500b009a5852f10aemr4983073ejo.60.1694712409563; Thu, 14 Sep
 2023 10:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <20230913153758.GB45543@cmpxchg.org>
 <CAJD7tka20+zB1aFfmdEBX5a3bLDTbGHuZP7sV3cvLvT8dvvaAA@mail.gmail.com>
 <20230914160646.GA101038@cmpxchg.org> <CAJD7tkaLQ8H4-EiZimyZ4a=CbLb_0KEPE8RkPofFRVceSOqtnw@mail.gmail.com>
In-Reply-To: <CAJD7tkaLQ8H4-EiZimyZ4a=CbLb_0KEPE8RkPofFRVceSOqtnw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Sep 2023 10:26:13 -0700
Message-ID: <CAJD7tkbx4X6KM+2X6qTPhr+RvJQCOyCutCj4zFVE9-fATMbcpA@mail.gmail.com>
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

per cgroup*

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
