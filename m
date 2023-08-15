Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD7C77C492
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjHOAkP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjHOAjy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:39:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABAF4
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:39:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bfcf4c814so655095566b.0
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692059991; x=1692664791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUQhhVLOh6qVlfYVa6vB28rLbeIPVQEya3teNIVSHU8=;
        b=jp2hKW8+cT+9BIqBvImxERQxPLIhNiBP/eE4OjQULk+2t9+AW9OG8RsWIa7O8bL5AA
         6SMdlFMG163klFvruDYh20QUH9xHwjHYDNRgpju60THKIMmW69yQIEbK2ZDkXEs61oC4
         rZ6BT5Wz/YbnmD8OUACA5AB3QECE263UTei1K/Xmg3uh3y3z2qec3y59u64Gs4VvNPlI
         27Tphcei621LPX0MpfJM+4Dqe59z1HzPM6M9O2JjTKpg+s3DbX8iJqWTcc4xeIywuhDE
         QmYojV7hVgDhTCJkdN88IlzUz2K1qwW+5wDAionPs0FCK+4dCQZ8Tgs0EOkLpxMiiuVn
         KeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059991; x=1692664791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUQhhVLOh6qVlfYVa6vB28rLbeIPVQEya3teNIVSHU8=;
        b=lxWK5b+Bk+O3rF84up3N9zIvfCZp9/jupAbbpI2FY9vP4V8mLr8pHwT5Gr40NgvMXt
         vL7pUiz9FGm/TdGoa1TYXT3Iw7mr2PPnON9ZdCy2TbOLiX+XS3ZL33byDDRFoBN5iVgX
         jzqTXpz/KrZZN/QVJXDobOtU4D5YNv1wENfQXcrZ/RBtdo0copxHpbdUYf3d+/qD8eQh
         OY/bK3hkgI5RS5/h9zdc+73PipYVCbMDbs3LP5FAciSH/EW2eHuR40ob3odbt5Oreqry
         zsSXOivH17ywiinh28BlJIpD6KzltrW6veG09ipxG3eOPCXihLXNaZWIkwhl9W+7bmYH
         ySxA==
X-Gm-Message-State: AOJu0Yxa24GH8fobekNyaEjO2Z/qNjY5hc19ue74GI/3vz7EZeTiyLiB
        VUp47Gx/chZedfM8GNgOFxs1ZEYWEZbYOW1XWCk2yQ==
X-Google-Smtp-Source: AGHT+IGd80Yh38r7ND9UV8X81gz5g3oHz8jVaPo0JV5xcL5knZQL2XaC2Z/lONuBN+iOCjcw19UDy7fICHwKzfN7oc4=
X-Received: by 2002:a17:907:2beb:b0:973:fd02:a41f with SMTP id
 gv43-20020a1709072beb00b00973fd02a41fmr10317990ejc.40.1692059991412; Mon, 14
 Aug 2023 17:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org> <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org>
In-Reply-To: <ZNrITZVTf2EILRJq@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 14 Aug 2023 17:39:15 -0700
Message-ID: <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 14, 2023 at 5:35=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Aug 14, 2023 at 05:28:22PM -0700, Yosry Ahmed wrote:
> > > So, the original design used mutex for synchronize flushing with the =
idea
> > > being that updates are high freq but reads are low freq and can be
> > > relatively slow. Using rstats for mm internal operations changed this
> > > assumption quite a bit and we ended up switching that mutex with a lo=
ck.
> >
> > Naive question, do mutexes handle thundering herd problems better than
> > spinlocks? I would assume so but I am not sure.
>
> I don't know. We can ask Waiman if that becomes a problem.
>
> > > * Flush-side, maybe we can break flushing into per-cpu or whatnot but
> > >   there's no avoiding the fact that flushing can take quite a while i=
f there
> > >   are a lot to flush whether locks are split or not. I wonder whether=
 it'd
> > >   be possible to go back to mutex for flushing and update the users t=
o
> > >   either consume the cached values or operate in a sleepable context =
if
> > >   synchronous read is necessary, which is the right thing to do anywa=
y given
> > >   how long flushes can take.
> >
> > Unfortunately it cannot be broken down into per-cpu as all flushers
> > update the same per-cgroup counters, so we need a bigger locking
> > scope. Switching to atomics really hurts performance. Breaking down
> > the lock to be per-cgroup is doable, but since we need to lock both
> > the parent and the cgroup, flushing top-level cgroups (which I assume
> > is most common) will lock the root anyway.
>
> Plus, there's not much point in flushing in parallel, so I don't feel too
> enthusiastic about splitting flush locking.
>
> > All flushers right now operate in sleepable context, so we can go
> > again to the mutex if you think this will make things better. The
>
> Yes, I think that'd be more sane.
>
> > slowness problem reported recently is in a sleepable context, it's
> > just too slow for userspace if I understand correctly.
>
> I mean, there's a certain amount of work to do. There's no way around it =
if
> you wanna read the counters synchronously. The only solution there would =
be
> using a cached value or having some sort of auto-flushing mechanism so th=
at
> the amount to flush don't build up too much - e.g. keep a count of the
> number of entries to flush and trigger flush if it goes over some thresho=
ld.

I really hoped you'd continue reading past this point :)

My proposed solution was to only flush the needed subtree rather than
flushing the entire tree all the time, which is what we do now on the
memcg side. We already have an asynchronous flusher on the memcg side
that runs every 2s to try to keep the tree size bounded, and we
already keep track of the magnitude of updates and only flush if it's
significant.

The problems in this thread and the other one are:
(a) Sometimes reading from userspace is slow because we needlessly
flush the entire tree.
(b) Sometimes reading from userspace is inaccurate because we skip
flushing if someone else is flushing, even though we don't know if
they flushed the subtree we care about yet or not.

I believe dropping unified flushing, if possible of course, may fix
both problems.

>
> Thanks.
>
> --
> tejun
