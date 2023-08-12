Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7AB779F73
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjHLLFS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Aug 2023 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjHLLFJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Aug 2023 07:05:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011381B5
        for <cgroups@vger.kernel.org>; Sat, 12 Aug 2023 04:05:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99cce6f7de2so387631366b.3
        for <cgroups@vger.kernel.org>; Sat, 12 Aug 2023 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691838310; x=1692443110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJxz5Wo5bQtCB2HrXnTdvzAAMp9CCbg8i6pks8wxkuI=;
        b=vW6Bzk3RwWmtvH8JO/t1CTcYatZkRByvpzHoneTQf+aOWO2q6PtapSd13f+GAjvAB9
         dEJtx1rlOAzoje9tcR+r+pWtS7GqPYv+uiN1BQrXS7fiF8u1cJskNVJasN37/yE29xaV
         25z+J4ZFzTd7bVkED/r1019GQ/xvCBJVphitX47LbgN3UYkoo8VziKEpAjytsOe4vc5c
         OhzmBN30ubbXyg3yJpcUqdMmhBYwD18Iu9gOyt6DiYRZUg0ShkUFH32S2DM2E7G/l0Wh
         DTbG0KqyEseULb0XPtYqU+wYqMGsJiZwLIesBg2RUlPJ0TQFKta67UVzVEuN3ConbNBo
         t2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691838310; x=1692443110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJxz5Wo5bQtCB2HrXnTdvzAAMp9CCbg8i6pks8wxkuI=;
        b=iQKcQlEw7Yw9uBSTU3PUucQND6YLbVhYXSubezoi07SE4ibxUag/QVgHWcz2f06Mul
         gAXfha2SvH/C6Z/cYjGpd66I2vSd0rCNInZWioaG+JtDJ6pBfXLb3Js3sNlQR0bLez9T
         dGVYQxUiE/O65W4+iU5ovzkorDP3h4fpmSDhdVXuWPkkzTLR9EnbwaOMZ2FR/CFf/Yn+
         +5lzv4as3GeHfEKZbKZB739pT9JW8j3EaBJcsZhKiE92WUxr8c5Hp8TuG0gPvz75akBS
         e0+FZfuOsRW2qmNzy5OniJXadngKoaDgHzBWJObQllxJxIHvAcDcwPpX9SRLZd2snTST
         0STg==
X-Gm-Message-State: AOJu0YxqT98peDWjQjYBboy1QF3O8SY5Q28ZN34HyVtmzFV6zH/2dnpk
        cJ6dLurF56UsT5oQKz6gI5kTLLFRmU61Mydc6aXzdg==
X-Google-Smtp-Source: AGHT+IHYXLBIXZd13k/Rpvg0NBuf4m8sjrTTdOIVSfAmIedaXM+rET9gqfLJrQnx4b1FjBgDjhmfCt0HQdvp8oO+C8c=
X-Received: by 2002:a17:907:75d8:b0:99c:ae00:f869 with SMTP id
 jl24-20020a17090775d800b0099cae00f869mr3812595ejc.41.1691838310176; Sat, 12
 Aug 2023 04:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz> <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com> <ZNdEaw2nktq1NfmH@dhcp22.suse.cz>
In-Reply-To: <ZNdEaw2nktq1NfmH@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 12 Aug 2023 04:04:32 -0700
Message-ID: <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
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

On Sat, Aug 12, 2023 at 1:35=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 11-08-23 19:48:14, Shakeel Butt wrote:
> > On Fri, Aug 11, 2023 at 7:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Fri, Aug 11, 2023 at 7:29=E2=80=AFPM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Fri, Aug 11, 2023 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > [...]
> > > > >
> > > > > I am worried that writing to a stat for flushing then reading wil=
l
> > > > > increase the staleness window which we are trying to reduce here.
> > > > > Would it be acceptable to add a separate interface to explicitly =
read
> > > > > flushed stats without having to write first? If the distinction
> > > > > disappears in the future we can just short-circuit both interface=
s.
> > > >
> > > > What is the acceptable staleness time window for your case? It is h=
ard
> > > > to imagine that a write+read will always be worse than just a read.
> > > > Even the proposed patch can have an unintended and larger than
> > > > expected staleness window due to some processing on
> > > > return-to-userspace or some scheduling delay.
> > >
> > > Maybe I am worrying too much, we can just go for writing to
> > > memory.stat for explicit stats refresh.
> > >
> > > Do we still want to go with the mutex approach Michal suggested for
> > > do_flush_stats() to support either waiting for ongoing flushes
> > > (mutex_lock) or skipping (mutex_trylock)?
> >
> > I would say keep that as a separate patch.
>
> Separate patches would be better but please make the mutex conversion
> first. We really do not want to have any busy waiting depending on a
> sleep exported to the userspace. That is just no-go.

+tj@kernel.org

That makes sense.

Taking a step back though, and considering there have been other
complaints about unified flushing causing expensive reads from
memory.stat [1], I am wondering if we should tackle the fundamental
problem.

We have a single global rstat lock for flushing, which protects the
global per-cgroup counters as far as I understand. A single lock means
a lot of contention, which is why we implemented unified flushing on
the memcg side in the first place, where we only let one flusher
operate and everyone else skip, but that flusher needs to flush the
entire tree.

This can be unnecessarily expensive (see [1]), and to avoid how
expensive it is we sacrifice accuracy (what this patch is about). I am
exploring breaking down that lock into per-cgroup locks, where a
flusher acquires locks in a top down fashion. This allows for some
concurrency in flushing, and makes unified flushing unnecessary. If we
retire unified flushing we fix both accuracy and expensive reads at
the same time, while not sacrificing performance for concurrent
in-kernel flushers.

What do you think? I am prototyping something now and running some
tests, it seems promising and simple-ish (unless I am missing a big
correctness issue).

[1] https://lore.kernel.org/lkml/CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-=
9QzY-a40A@mail.gmail.com/

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
