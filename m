Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26261776056
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHINNt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjHINNq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 09:13:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9402130
        for <cgroups@vger.kernel.org>; Wed,  9 Aug 2023 06:13:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so983312866b.2
        for <cgroups@vger.kernel.org>; Wed, 09 Aug 2023 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691586822; x=1692191622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3q+oF8DcCXzUb0+o6vnkiFGnNZXUzpVlmsAZC2SnCA=;
        b=KFIXC5UzyX9KW1ybbG2szF/GuAnirPt07l/xnJN/LhE7O4xCzhvLsPdgbXKD6E7eMf
         ikIIgzUrA1n/ViVW3Urjqgdo+1QxEiaoyTDPJsg4Jv+ew18M/dXHl3khl255ksGu8tOf
         8MTylTWyWWQsUM+BnJbn2tRySwouFHGc9g4KetOxMFCSVqbU0idDTrNrDig3npuOVsiT
         HswwwIkV7SidVYYiyLMNHTHaXS7/dkUGCZwPT+0E2JO79uhkU2thz6DQpT25eCGt197J
         hY0cZbi+0h5xrfLsyRvIpGFdVz4rUeEd+GPZBGq2menxW0y9J1duxc/Obw5yZdFqn2LY
         Mp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586822; x=1692191622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3q+oF8DcCXzUb0+o6vnkiFGnNZXUzpVlmsAZC2SnCA=;
        b=UPm3haYD9AfUm/U+cxbxs86BtdAxjTH8bhFaBnZpVWXORbo5CJzC2Ia0YkMEulAUFp
         6rf/wRRYsAAT7HVOFKWABD0m/n9PnIhB7bXouzl9XsiE1hlksSHHSvw6m5dbAj3uPN56
         CnGB4XU9bKqJ+FEHusqTaZli73VoU3cADrDJA9ti6LkJW4K+YRtmcZbRbS1ifq/Kss4t
         I9we8J/1rP2/DsqyhmE9kz0ImFP60C4iagUhVq4yMFOyBJ/5MP9ed9ynKqb/H89unSwS
         a1N5Bp4VZFsqGRItdB7/k0L2lmjb5blAu7aH6/woPJLtCEmkW8ahrz5bKSVr41/Nze0B
         8lfA==
X-Gm-Message-State: AOJu0YxLHVYj7ku7OiuHmERPKC9RTiUKWIFsrnCmVqi0/GFD6VfOCeAm
        TYpnroa0rlZAoWM8JnXG5rmomz82vq1fAVmylrAQAUmrpab/aRpQPgA=
X-Google-Smtp-Source: AGHT+IGEB9EVX/XItxVQk5492ynxBiXJbmSMOAf0p28E04IRCS29Zhz82+d3IYv2qzx3ltff4HX5X12ylLOSuA7OeSM=
X-Received: by 2002:a17:906:54:b0:99c:1b9a:b09e with SMTP id
 20-20020a170906005400b0099c1b9ab09emr2112215ejg.75.1691586822187; Wed, 09 Aug
 2023 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz>
In-Reply-To: <ZNONgeoytpkchHga@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 9 Aug 2023 06:13:05 -0700
Message-ID: <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 9, 2023 at 5:58=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 09-08-23 05:31:04, Yosry Ahmed wrote:
> > On Wed, Aug 9, 2023 at 1:51=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Wed 09-08-23 04:58:10, Yosry Ahmed wrote:
> > > > Over time, the memcg code added multiple optimizations to the stats
> > > > flushing path that introduce a tradeoff between accuracy and
> > > > performance. In some contexts (e.g. dirty throttling, refaults, etc=
), a
> > > > full rstat flush of the stats in the tree can be too expensive. Suc=
h
> > > > optimizations include [1]:
> > > > (a) Introducing a periodic background flusher to keep the size of t=
he
> > > > update tree from growing unbounded.
> > > > (b) Allowing only one thread to flush at a time, and other concurre=
nt
> > > > flushers just skip the flush. This avoids a thundering herd problem
> > > > when multiple reclaim/refault threads attempt to flush the stats at
> > > > once.
> > > > (c) Only executing a flush if the magnitude of the stats updates ex=
ceeds
> > > > a certain threshold.
> > > >
> > > > These optimizations were necessary to make flushing feasible in
> > > > performance-critical paths, and they come at the cost of some accur=
acy
> > > > that we choose to live without. On the other hand, for flushes invo=
ked
> > > > when userspace is reading the stats, the tradeoff is less appealing
> > > > This code path is not performance-critical, and the inaccuracies ca=
n
> > > > affect userspace behavior. For example, skipping flushing when ther=
e is
> > > > another ongoing flush is essentially a coin flip. We don't know if =
the
> > > > ongoing flush is done with the subtree of interest or not.
> > >
> > > I am not convinced by this much TBH. What kind of precision do you
> > > really need and how much off is what we provide?
> > >
> > > More expensive read of stats from userspace is quite easy to notice
> > > and usually reported as a regression. So you should have a convincing
> > > argument that an extra time spent is really worth it. AFAIK there are
> > > many monitoring (top like) tools which simply read those files regula=
rly
> > > just to show numbers and they certainly do not need a high level of
> > > precision.
> >
> > We used to spend this time before commit fd25a9e0e23b ("memcg: unify
> > memcg stat flushing") which generalized the "skip if ongoing flush"
> > for all stat flushing. As far I know, the problem was contention on
> > the flushing lock which also affected critical paths like refault.
> >
> > The problem is that the current behavior is indeterministic, if cpu A
> > tries to flush stats and cpu B is already doing that, cpu A will just
> > skip. At that point, the cgroup(s) that cpu A cares about may have
> > been fully flushed, partially flushed (in terms of cpus), or not
> > flushed at all. We have no idea. We just know that someone else is
> > flushing something. IOW, in some cases the flush request will be
> > completely ignored and userspace will read stale stats (up to 2s + the
> > periodic flusher runtime).
>
> Yes, that is certainly true but why does that matter? Stats are always a
> snapshot of the past. Do we get an inconsistent image that would be
> actively harmful.

That can very well be the case because we may be in a state where some
cpus are flushed and some aren't. Also sometimes a few seconds is too
old. We have some workloads that read the stats every 1-2 seconds to
keep a fresh state, and they certainly do not expect stats to be 2+
seconds old when they read them.

>
> > Some workloads need to read up-to-date stats as feedback to actions
> > (e.g. after proactive reclaim, or for userspace OOM killing purposes),
> > and reading such stale stats causes regressions or misbehavior by
> > userspace.
>
> Please tell us more about those and why should all others that do not
> require such a precision should page that price as well.

Everyone used to pay this price though and no one used to complain.
Even before rstat, we used to iterate the entire hierarchy when
userspace reads the stats. rstat came in and made this much more
efficient by only iterating the subtrees that actually have updates.

The "skip if someone else is flushing" behavior was introduced for
flushers in critical paths (e.g. refault), and hurting the accuracy
for userspace readers was a side effect of it. This patch is trying to
remedy this side effect by restoring the old behavior for userspace
reads.

One other side effect is testing. Some tests started becoming flaky
because a test performs an action and expects the state of the system
to change in a certain way deterministically. In some cases the
flushing race leads to false negatives.

>
> > > [...]
> > > > @@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct=
 mem_cgroup *memcg, int val)
> > > >       }
> > > >  }
> > > >
> > > > -static void do_flush_stats(void)
> > > > +static void do_flush_stats(bool full)
> > > >  {
> > > > +     if (!atomic_read(&stats_flush_ongoing) &&
> > > > +         !atomic_xchg(&stats_flush_ongoing, 1))
> > > > +             goto flush;
> > > > +
> > > >       /*
> > > > -      * We always flush the entire tree, so concurrent flushers ca=
n just
> > > > -      * skip. This avoids a thundering herd problem on the rstat g=
lobal lock
> > > > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > > > +      * We always flush the entire tree, so concurrent flushers ca=
n choose to
> > > > +      * skip if accuracy is not critical. Otherwise, wait for the =
ongoing
> > > > +      * flush to complete. This avoids a thundering herd problem o=
n the rstat
> > > > +      * global lock from memcg flushers (e.g. reclaim, refault, et=
c).
> > > >        */
> > > > -     if (atomic_read(&stats_flush_ongoing) ||
> > > > -         atomic_xchg(&stats_flush_ongoing, 1))
> > > > -             return;
> > > > -
> > > > +     while (full && atomic_read(&stats_flush_ongoing) =3D=3D 1) {
> > > > +             if (!cond_resched())
> > > > +                     cpu_relax();
> > >
> > > You are reinveting a mutex with spinning waiter. Why don't you simply
> > > make stats_flush_ongoing a real mutex and make use try_lock for !full
> > > flush and normal lock otherwise?
> >
> > So that was actually a spinlock at one point, when we used to skip if
> > try_lock failed.
>
> AFAICS cgroup_rstat_flush is allowed to sleep so spinlocks are not
> really possible.
>
> > We opted for an atomic because the lock was only used
> > in a try_lock fashion. The problem here is that the atomic is used to
> > ensure that only one thread actually attempts to flush at a time (and
> > others skip/wait), to avoid a thundering herd problem on
> > cgroup_rstat_lock.
> >
> > Here, what I am trying to do is essentially equivalent to "wait until
> > the lock is available but don't grab it". If we make
> > stats_flush_ongoing a mutex, I am afraid the thundering herd problem
> > will be reintroduced for stats_flush_ongoing this time.
>
> You will have potentially many spinners for something that might take
> quite a lot of time (sleep) if there is nothing else to schedule. I do
> not think this is a proper behavior. Really, you shouldn't be busy
> waiting for a sleeper.
>
> > I am not sure if there's a cleaner way of doing this, but I am
> > certainly open for suggestions. I also don't like how the spinning
> > loop looks as of now.
>
> mutex_try_lock for non-critical flushers and mutex_lock of syncing ones.
> We can talk a custom locking scheme if that proves insufficient or
> problematic.
> --
> Michal Hocko
> SUSE Labs
