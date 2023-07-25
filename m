Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D260C762555
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGYWB1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGYWBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 18:01:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB2213A
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 15:01:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98e39784a85so67444866b.1
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322471; x=1690927271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EitNPpdaQImS+UO+6gfA4PmDrc0gIvXFa/aFMwcLRHY=;
        b=ffXmfym6N4mdb0c+soPvdHw9AnsEOLeiuBQ+yw4S7vov+SQonwJhjpAunJ8MZ/0I5z
         vkrWDPPOpEOEBzeRbv5sOiO30J4bFlm2uaVwSYhHD0F3MKUR9bH25ZV/8P/V4vv+68DQ
         Awc52OT0af4X6ruHifd5tQ1PogYcEQOfve3Ueg+a7WcGr5VWhifbZTc/db4frCI4n7g5
         /cI4O00K/WdfHxccbUgsBgsHT0u3X1wgsRZRcCroOqmlSuxKZyBiWllsAHZDE0aYI863
         HH03aEHMz4BpzVT211siQA6rfn6moa4eIizUAYEDOz1f4m0/qoh/lxD+/YVqk5FZbfS7
         Pe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322471; x=1690927271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EitNPpdaQImS+UO+6gfA4PmDrc0gIvXFa/aFMwcLRHY=;
        b=VwA2ahGVshO3ammXQdDv4XItmwDVlbTOJKk0pjoaoyqPLO4r09Smu44Sn+PsDG7Gql
         NNwbl3ihKSFmt+oM9f53pZ2EOOylQDqIHplKMjbmVqJ1hm+CKzyRjAJNDmKms3y99uOM
         Dxuv+x3Wng4wDD2h6ZFcvFbsx7nLSqJ+BkuQz1O7KNuER2cJd73URMLAYOeTc5ULDITF
         UhrL2Alvf7YOOYB2bRecr3w0sdySoGCrc8/XMp7jEqz7LLtZeIvKxVVnRCP+cTVytHop
         /VZ1iYX7/36G92sZzK5elJFJJFuTeRNUYZ/cdXzbSqq62QcyeQAf8SBJQUHekwDN4t4w
         G4EA==
X-Gm-Message-State: ABy/qLbYRaDT3Wdfbc9X+9oTvU7wDx4zl4vH4zGUdU3O6X0odGRNkM1I
        BLhVtW3C7wX8dbLqA9+8cOn225CeYOzDsIhe3BKLsg==
X-Google-Smtp-Source: APBJJlFgTPyujUtZ8EgbKUjRjcN96PY7sGSk7GdBAe1Uf1XmD95bwOiGIXX+Oe7jKRmrKs4UJhAWrAaQohGw5cQDLp0=
X-Received: by 2002:a17:906:32db:b0:994:5457:269e with SMTP id
 k27-20020a17090632db00b009945457269emr457378ejk.0.1690322471171; Tue, 25 Jul
 2023 15:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230719174613.3062124-1-yosryahmed@google.com>
 <20230725140435.GB1146582@cmpxchg.org> <CAJD7tkaYHvaX6SL=A6TsCQHT+rOTp-WhOiQ1XSN+ywOVN=-QBQ@mail.gmail.com>
 <20230725201811.GA1231514@cmpxchg.org>
In-Reply-To: <20230725201811.GA1231514@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Jul 2023 15:00:34 -0700
Message-ID: <CAJD7tkZkTgt9kT_5BqYyB2w4EcL_M4v0zG6rrM+qAAnpq-AQdg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 25, 2023 at 1:18=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jul 25, 2023 at 12:24:19PM -0700, Yosry Ahmed wrote:
> > On Tue, Jul 25, 2023 at 7:04=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > > We used to maintain *all* stats in per-cpu counters at the local
> > > level. memory.stat reads would have to iterate and aggregate the
> > > entire subtree every time. This was obviously very costly, so we adde=
d
> > > batched upward propagation during stat updates to simplify reads:
> > >
> > > commit 42a300353577ccc17ecc627b8570a89fa1678bec
> > > Author: Johannes Weiner <hannes@cmpxchg.org>
> > > Date:   Tue May 14 15:47:12 2019 -0700
> > >
> > >     mm: memcontrol: fix recursive statistics correctness & scalabilty
> > >
> > > However, that caused a regression in the stat write path, as the
> > > upward propagation would bottleneck on the cachelines in the shared
> > > parents. The fix for *that* re-introduced the per-cpu loops in the
> > > local stat reads:
> > >
> > > commit 815744d75152078cde5391fc1e3c2d4424323fb6
> > > Author: Johannes Weiner <hannes@cmpxchg.org>
> > > Date:   Thu Jun 13 15:55:46 2019 -0700
> > >
> > >     mm: memcontrol: don't batch updates of local VM stats and events
> > >
> > > So I wouldn't say it's a regression from rstat. Except for that short
> > > period between the two commits above, the read side for local stats
> > > was always expensive.
> >
> > I was comparing from an 4.15 kernel, so I assumed the major change was
> > from rstat, but that was not accurate. Thanks for the history.
> >
> > However, in that 4.15 kernel the local (non-hierarchical) stats were
> > readily available without iterating percpu counters. There is a
> > regression that was introduced somewhere.
> >
> > Looking at the history you described, it seems like up until
> > 815744d75152 we used to maintain "local" (aka non-hierarchical)
> > counters, so reading local stats was reading one counter, and starting
> > 815744d75152 we started having to loop percpu counters for that.
> >
> > So it is not a regression of rstat, but seemingly it is a regression
> > of 815744d75152. Is my understanding incorrect?
>
> Yes, it actually goes back further. Bear with me.
>
> For the longest time, it used to be local per-cpu counters. Every
> memory.stat read had to do nr_memcg * nr_cpu aggregation. You can
> imagine that this didn't scale in production.
>
> We added local atomics and turned the per-cpu counters into buffers:
>
> commit a983b5ebee57209c99f68c8327072f25e0e6e3da
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Wed Jan 31 16:16:45 2018 -0800
>
>     mm: memcontrol: fix excessive complexity in memory.stat reporting
>
> Local counts became a simple atomic_read(), but the hierarchy counts
> would still have to aggregate nr_memcg counters.
>
> That was of course still too much read-side complexity, so we switched
> to batched upward propagation during the stat updates:
>
> commit 42a300353577ccc17ecc627b8570a89fa1678bec
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Tue May 14 15:47:12 2019 -0700
>
>     mm: memcontrol: fix recursive statistics correctness & scalabilty
>
> This gave us two atomics at each level: one for local and one for
> hierarchical stats.
>
> However, that went too far the other direction: too many counters
> touched during stat updates, and we got a regression report over memcg
> cacheline contention during MM workloads. Instead of backing out
> 42a300353 - since all the previous versions were terrible too - we
> dropped write-side aggregation of *only* the local counters:
>
> commit 815744d75152078cde5391fc1e3c2d4424323fb6
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Thu Jun 13 15:55:46 2019 -0700
>
>     mm: memcontrol: don't batch updates of local VM stats and events
>
> In effect, this kept all the stat optimizations for cgroup2 (which
> doesn't have local counters), and reverted cgroup1 back to how it was
> for the longest time: on-demand aggregated per-cpu counters.
>
> For about a year, cgroup1 didn't have to per-cpu the local stats on
> read. But for the recursive stats, it would either still have to do
> subtree aggregation on read, or too much upward flushing on write.
>
> So if I had to blame one commit for a cgroup1 regression, it would
> probably be 815744d. But it's kind of a stretch to say that it worked
> well before that commit.
>
> For the changelog, maybe just say that there was a lot of back and
> forth between read-side aggregation and write-side aggregation. Since
> with rstat we now have efficient read-side aggregation, attempt a
> conceptual revert of 815744d.

Now that's a much more complete picture. Thanks a lot for all the
history, now it makes much more sense. I wouldn't blame 815744d then,
as you said it's better framed as a conceptual revert of it. I will
rewrite the commit log accordingly and send a v2.

Thanks!

>
> > > But I want to be clear: this isn't a regression fix. It's a new
> > > performance optimization for the deprecated cgroup1 code. And it come=
s
> > > at the cost of higher memory footprint for both cgroup1 AND cgroup2.
> >
> > I still think it is, but I can easily be wrong. I am hoping that the
> > memory footprint is not a problem. There are *roughly* 80 per-memcg
> > stats/events (MEMCG_NR_STAT + NR_MEMCG_EVENTS) and 55 per-lruvec stats
> > (NR_VM_NODE_STAT_ITEMS). For each stat there is an extra 8 bytes, so
> > on a two-node machine that's  8 * (80 + 55 * 2) ~=3D 1.5 KiB per memcg.
> >
> > Given that struct mem_cgroup is already large, and can easily be 100s
> > of KiBs on a large machine with many cpus, I hope there won't be a
> > noticeable regression.
>
> Yes, the concern wasn't so much the memory consumption but the
> cachelines touched during hot paths.
>
> However, that was mostly because we either had a) write-side flushing,
> which is extremely hot during MM stress, or b) read-side flushing with
> huuuge cgroup subtrees due to zombie cgroups. A small cacheline
> difference would be enormously amplified by these factors.
>
> Rstat is very good at doing selective subtree flushing on reads, so
> the big coefficients from a) and b) are no longer such a big concern.
> A slightly bigger cache footprint is probably going to be okay.

Agreed, maintaining the local counters with rstat is much easier than
the previous attempts. I will try to bake most of this into the commit
log.
