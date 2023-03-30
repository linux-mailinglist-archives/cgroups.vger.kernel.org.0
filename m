Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED86CFA2A
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC3E1H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 00:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC3E1F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 00:27:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A95272
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 21:27:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t10so71408360edd.12
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 21:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680150421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPxXZwrGY9EQBVrz+rM6XeJQecrNiNwMGKoahuxks9c=;
        b=UB9ilX9x0DFClvH2MBsafXYctyfQiMtqneVbDgIn8dlkb7SeJEzllIUHniTmROr9zA
         QNEcN1WFlEJGxgMboHiWeAft9d3KIZB6LTea9dtS1hOwT9F0hILhYXmS0E6kIWINYTZy
         vBEL04m8KhM3aacYuUlP7egfig+eopFO62We1ZE3+r978w7tMG7VVUF5nAvktNbztfWy
         DPIUhgo3yBtBMUXACd+J8qLZYHzhxPnNgyVg366YOY7pdoxSIli5kTx+TEp3cf9hhDzv
         kmAe2yK9UIVG5k/8muUa7zOO6grvclhgaCpWWvyR2kWnYuNTZ48TJfXwnL+iNuR2zeoS
         O3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680150421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPxXZwrGY9EQBVrz+rM6XeJQecrNiNwMGKoahuxks9c=;
        b=nVD19nJBMrAGA6KyCGujwk+c7LYiozasAkw5RmHwQMYQswo3et0nlIRx1La7ApYccZ
         PZDHAoVWXcw7bOLMBEALVB+yln0q4RB4XZysgzLrDmvJgWm8GdYcrHwxxT+yMn0OD4RG
         7dHuHxn7hP4hJ72E4qj+BZSpJxpoDB17CQ/4RWXw89MhWSeFtMKN+oOjDPxQwWFOfcTm
         D8L0UbnUpjgY6Ul85PpnLpNsQNfBgDxExArkO22wRZ38Q+LurO73YIaX/BzHZX/dwqdW
         Fs5lP78dKXykAnke2hrOFGdWYK6yzEAAPJVSxb/9blGPkStvTggyWIzstnETe0IYOy1X
         qpqg==
X-Gm-Message-State: AAQBX9c5Vug74IdacKBmQ7vEQd/hVkh2RSUZlNnTkde9TtXxFeejhAVu
        sJqfLL8AFaDv2CZjFUGHzQNeAeiAcKGGDs0TT2PRxg==
X-Google-Smtp-Source: AKy350Y3jW8mXAik9Znw5lXXT0a3LkoBTafwWbTIHw4pWyMN7nAmXuXsz/YasuYog2yKCeL23uzXcExl0Qv0CZmiwXM=
X-Received: by 2002:a50:d756:0:b0:4fc:e5c:902 with SMTP id i22-20020a50d756000000b004fc0e5c0902mr10775755edj.8.1680150421386;
 Wed, 29 Mar 2023 21:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZBz/V5a7/6PZeM7S@slm.duckdns.org> <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
 <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
 <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
 <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com>
 <ZCSJDpPPOVvBYfOy@slm.duckdns.org> <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com>
 <ZCSY8l/jVwszF6iA@slm.duckdns.org> <98cb3ce-7ed9-3d17-9015-ef7193d6627@google.com>
In-Reply-To: <98cb3ce-7ed9-3d17-9015-ef7193d6627@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 29 Mar 2023 21:26:24 -0700
Message-ID: <CAJD7tkaFhG39LHUNuKmxj2LEvojavOnpnREXz2vvuLrbBAHyEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Hugh Dickins <hughd@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for a great discussion, Tejun and Hugh.

On Wed, Mar 29, 2023 at 1:38=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Wed, 29 Mar 2023, Tejun Heo wrote:
>
> > Hello, Hugh. How have you been?
> >
> > On Wed, Mar 29, 2023 at 12:22:24PM -0700, Hugh Dickins wrote:
> > > Hi Tejun,
> > > Butting in here, I'm fascinated.  This is certainly not my area, I kn=
ow
> > > nothing about rstat, but this is the first time I ever heard someone
> > > arguing for more disabling of interrupts rather than less.
> > >
> > > An interrupt coming in while holding a contended resource can certain=
ly
> > > add to latencies, that I accept of course.  But until now, I thought =
it
> > > was agreed best practice to disable irqs only regretfully, when stric=
tly
> > > necessary.
> > >
> > > If that has changed, I for one want to know about it.  How should we
> > > now judge which spinlocks should disable interrupts and which should =
not?
> > > Page table locks are currently my main interest - should those be cha=
nged?
> >
> > For rstat, it's a simple case because the global lock here wraps around
> > per-cpu locks which have to be irq-safe, so the only difference we get
> > between making the global irq-unsafe and keeping it so but releasing
> > inbetween is:
> >
> >  Global lock held: G
> >  IRQ disabled: I
> >  Percpu lock held: P
> >
> > 1. IRQ unsafe
> >
> >  GGGGGGGGGGGGGGG~~GGGGG
> >  IIII IIII IIII ~~ IIII
> >  PPPP PPPP PPPP ~~ PPPP
> >
> > 2. IRQ safe released inbetween cpus
> >
> >  GGGG GGGG GGGG ~~ GGGG
> >  IIII IIII IIII ~~ IIII
> >  PPPP PPPP PPPP ~~ PPPP
> >
> > #2 seems like the obvious thing to do here given how the lock is used a=
nd
> > each P section may take a bit of time.
>
> Many thanks for the detailed response.  I'll leave it to the rstat folks,
> to agree or disagree with your analysis there.

Thanks for the analysis, Tejun, it does indeed make sense. I perf'd
releasing and reacquiring the lock at each CPU boundary and the
overhead seems to be minimal. It would be higher with contention, but
all memcg flushers should be held back by the memcg code, and flushers
outside memcg are not frequent (reading blkcg and cpu base stats from
user space, and when a cgroup is being removed).

I realized that after v2 of this patch series [1], we would only end
up with two atomic flushing contexts, mem_cgroup_wb_stats() and
mem_cgroup_usage(). The latter is already disabling irqs for other
reasons, so anything we do within the rstat core code doesn't really
help, it needs to be addressed separately. So only the call site in
mem_cgroup_wb_stats() would benefit from not having irqs disabled
throughout the flush.

I will hold off on sending a patch until I observe that this call site
is causing us pain and/or other atomic call sites emerge (or we have
to revert one of the ones we made non-atomic), so that we don't hurt
other flushers unnecessarily. Does this make sense to you?

[1] https://lore.kernel.org/linux-mm/20230328221644.803272-1-yosryahmed@goo=
gle.com/

>
> >
> > So, in the rstat case, the choice is, at least to me, obvious, but even=
 for
> > more generic cases where the bulk of actual work isn't done w/ irq disa=
bled,
> > I don't think the picture is as simple as "use the least protected vari=
ant
> > possible" anymore because the underlying hardware changed.
> >
> > For an SMP kernel running on an UP system, "the least protected variant=
" is
> > the obvious choice to make because you don't lose anything by holding a
> > spinlock longer than necessary. However, as you increase the number of =
CPUs,
> > there rises a tradeoff between local irq servicing latency and global l=
ock
> > contention.
> >
> > Imagine a, say, 128 cpu system with a few cores servicing relatively hi=
gh
> > frequency interrupts. Let's say there's a mildly hot lock. Usually, it =
shows
> > up in the system profile but only just. Let's say something happens and=
 the
> > irq rate on those cores went up for some reason to the point where it
> > becomes a rather common occurrence when the lock is held on one of thos=
e
> > cpus, irqs are likely to intervene lengthening how long the lock is hel=
d,
> > sometimes, signficantly. Now because the lock is on average held for mu=
ch
> > longer, it become a lot hotter as more CPUs would stall on it and depen=
ding
> > on luck or lack thereof these stalls can span many CPUs on the system f=
or
> > quite a while. This is actually something we saw in production.
> >
> > So, in general, there's a trade off between local irq service latency a=
nd
> > inducing global lock contention when using unprotected locks. With more=
 and
> > more CPUs, the balance keeps shifting. The balance still very much depe=
nds
> > on the specifics of a given lock but yeah I think it's something we nee=
d to
> > be a lot more careful about now.
>
> And this looks a very plausible argument to me: I'll let it sink in.
>
> But I hadn't heard that the RT folks were clamouring for more irq disabli=
ng:
> perhaps they partition their machines with more care, and are not devotee=
s
> of high CPU counts.
>
> What I hope is that others will chime in one way or the other -
> it does sound as if a reappraisal of the balances is overdue.
>
> Thanks,
> Hugh (disabling interrupts for as long as he can)
