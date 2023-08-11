Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC91C779779
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHKTD3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHKTD2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 15:03:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CB110
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 12:03:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf3f59905so313762566b.3
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691780605; x=1692385405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/sryX5oyAT1OcjzxkuS075LBhWkQfYR3UGrlpCh99U=;
        b=dKctG1GFM+Jh407/MAvdPbf8fvy2f8tU/NAZX1EVR9ab6tHyEHzJ0TRR9NbLFvZNa/
         uJuDpVcGhfi6OejziQiC+fPB0qopemacTt1pqoJYoTjFUnOVkclVFkP14P0Pf/ZvmzcB
         bQXFtreNVS4ATqWWHVWXucbITer2pHwn16sODp+ca/16BUjSEovkmVQHDjcwHssUg/Re
         A1Kqn8Q/Hd2HVhK1MQLNDMSwsHkd2MyNjtHa/1SPkQwToShj/E5FCsX6EE2V6IU4vWRY
         QtsNioHuAmmjhFOcFdvyk1HCf5aSwHfSqXRPhCNlDMFjz01aYt8ch9DEpg298zdChejE
         ZWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780605; x=1692385405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/sryX5oyAT1OcjzxkuS075LBhWkQfYR3UGrlpCh99U=;
        b=K+GznRX+pfgDdgfBD14Fdj/FvokksahNsaLD+H6Dxd1p0RpULWOEo2MJcB48vvZggh
         S9lzZv4WM63HrNs8PZ4JmeUF0MXq3U8ki6vCvwD5IWtjqqx5ZzV0CGdRMEW74cuhLt5q
         4aLEHZTwjI5mdb/WjPwRDq4ec2GNWimk+BktiDBZ+zGi3fXseai5JhKt3mCjEcoYy4jJ
         3esSY3m6PXIAZxglGRql1iOi8tNiGOioh/THHSYEP+M2Be7vMRhKOdZOSPnHWTxdOTCr
         sf1ZPMLDX6I4z9vG70jPgJXk+YwsjkW6zjTScVfB9KyheQTrFFTHV/wJMCYWzf3Fgdoc
         9KKA==
X-Gm-Message-State: AOJu0YyViZGK3b9Q6Lv+mZrDZiItGNX5AVpBelb5puj7MXp0Sjrcivk1
        XxvpHj6pBTEZR2OelCVV9nRZ9ZoHhLT/KKZZlNLKqQ==
X-Google-Smtp-Source: AGHT+IEAbrF/XuKZhIOylLNXBcVYfuLn++BUd6oonTeYObBujPRnONqz3eJmkRsmtDMU1HShg69paZtSuL2OjimXcoQ=
X-Received: by 2002:a17:907:75d5:b0:98d:5333:79c with SMTP id
 jl21-20020a17090775d500b0098d5333079cmr2133043ejc.5.1691780605368; Fri, 11
 Aug 2023 12:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz> <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz> <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz>
In-Reply-To: <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 11 Aug 2023 12:02:48 -0700
Message-ID: <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 11, 2023 at 5:21=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 09-08-23 11:33:20, Yosry Ahmed wrote:
> > On Wed, Aug 9, 2023 at 6:32=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Wed 09-08-23 06:13:05, Yosry Ahmed wrote:
> > > > On Wed, Aug 9, 2023 at 5:58=E2=80=AFAM Michal Hocko <mhocko@suse.co=
m> wrote:
> > > > >
> > > > > On Wed 09-08-23 05:31:04, Yosry Ahmed wrote:
> > > > > > On Wed, Aug 9, 2023 at 1:51=E2=80=AFAM Michal Hocko <mhocko@sus=
e.com> wrote:
> > > > > > >
> > > > > > > On Wed 09-08-23 04:58:10, Yosry Ahmed wrote:
> > > > > > > > Over time, the memcg code added multiple optimizations to t=
he stats
> > > > > > > > flushing path that introduce a tradeoff between accuracy an=
d
> > > > > > > > performance. In some contexts (e.g. dirty throttling, refau=
lts, etc), a
> > > > > > > > full rstat flush of the stats in the tree can be too expens=
ive. Such
> > > > > > > > optimizations include [1]:
> > > > > > > > (a) Introducing a periodic background flusher to keep the s=
ize of the
> > > > > > > > update tree from growing unbounded.
> > > > > > > > (b) Allowing only one thread to flush at a time, and other =
concurrent
> > > > > > > > flushers just skip the flush. This avoids a thundering herd=
 problem
> > > > > > > > when multiple reclaim/refault threads attempt to flush the =
stats at
> > > > > > > > once.
> > > > > > > > (c) Only executing a flush if the magnitude of the stats up=
dates exceeds
> > > > > > > > a certain threshold.
> > > > > > > >
> > > > > > > > These optimizations were necessary to make flushing feasibl=
e in
> > > > > > > > performance-critical paths, and they come at the cost of so=
me accuracy
> > > > > > > > that we choose to live without. On the other hand, for flus=
hes invoked
> > > > > > > > when userspace is reading the stats, the tradeoff is less a=
ppealing
> > > > > > > > This code path is not performance-critical, and the inaccur=
acies can
> > > > > > > > affect userspace behavior. For example, skipping flushing w=
hen there is
> > > > > > > > another ongoing flush is essentially a coin flip. We don't =
know if the
> > > > > > > > ongoing flush is done with the subtree of interest or not.
> > > > > > >
> > > > > > > I am not convinced by this much TBH. What kind of precision d=
o you
> > > > > > > really need and how much off is what we provide?
> > > > > > >
> > > > > > > More expensive read of stats from userspace is quite easy to =
notice
> > > > > > > and usually reported as a regression. So you should have a co=
nvincing
> > > > > > > argument that an extra time spent is really worth it. AFAIK t=
here are
> > > > > > > many monitoring (top like) tools which simply read those file=
s regularly
> > > > > > > just to show numbers and they certainly do not need a high le=
vel of
> > > > > > > precision.
> > > > > >
> > > > > > We used to spend this time before commit fd25a9e0e23b ("memcg: =
unify
> > > > > > memcg stat flushing") which generalized the "skip if ongoing fl=
ush"
> > > > > > for all stat flushing. As far I know, the problem was contentio=
n on
> > > > > > the flushing lock which also affected critical paths like refau=
lt.
> > > > > >
> > > > > > The problem is that the current behavior is indeterministic, if=
 cpu A
> > > > > > tries to flush stats and cpu B is already doing that, cpu A wil=
l just
> > > > > > skip. At that point, the cgroup(s) that cpu A cares about may h=
ave
> > > > > > been fully flushed, partially flushed (in terms of cpus), or no=
t
> > > > > > flushed at all. We have no idea. We just know that someone else=
 is
> > > > > > flushing something. IOW, in some cases the flush request will b=
e
> > > > > > completely ignored and userspace will read stale stats (up to 2=
s + the
> > > > > > periodic flusher runtime).
> > > > >
> > > > > Yes, that is certainly true but why does that matter? Stats are a=
lways a
> > > > > snapshot of the past. Do we get an inconsistent image that would =
be
> > > > > actively harmful.
> > > >
> > > > That can very well be the case because we may be in a state where s=
ome
> > > > cpus are flushed and some aren't. Also sometimes a few seconds is t=
oo
> > > > old. We have some workloads that read the stats every 1-2 seconds t=
o
> > > > keep a fresh state, and they certainly do not expect stats to be 2+
> > > > seconds old when they read them.
> > >
> > > I hate to repeat myself but please be more specific. This all sounds
> > > just too wavy to me.
> >
> > Sorry I didn't have the full story in mind, I had to do my homework.
> > One example is userspace OOM killing. Our userspace OOM killer makes
> > decisions based on some stats from memory.stat, and stale stats (a few
> > seconds in this case) can result in an unrightful OOM kill, which can
> > easily cascade.
>
> OK, but how is this any different from having outdated data because you
> have to wait for memory.stat to read (being blocked inside the rstat
> code)? Either your oom killer is reading the stats directly and then you
> depend on that flushing which is something that could be really harmful
> itself or you rely on another thread doing the blocking and you do not
> have up-to-date numbers anyway. So how does blocking actually help?

I am not sure I understand.

The problem is that when you skip when someone else is flushing, there
is a chance that the stats we care about haven't been flushed since
the last time the periodic flusher ran. Which is supposed to be ~2
seconds ago, but maybe more depending on how busy the workqueue is.

When you block until the flusher finishes, the stats are being
refreshed as you wait. So the stats are not getting more outdated as
you wait in the general case (unless your cgroup was flushed first and
you're waiting for others to be flushed).
[Let's call this approach A]

Furthermore, with the implementation you suggested using a mutex, we
will wait until the ongoing flush is completed, then we will grab the
mutex and do a flush ourselves. That second flush should mostly be
very fast, but it will guarantee even fresher stats.
[Let's call this approach B]

See below for test results with either A or B.

We can add a new API that checks if the specific cgroup we care about
is flushed and wait on that instead of waiting for the entire flush to
finish, which will add stronger guarantees. However, as you said when
you suggested the mutex approach, let's start simple and add more
complexity when needed.

>
> > A simplified example of that is when a hierarchy has a parent cgroup
> > with multiple related children. In this case, there are usually
> > file-backed resources that are shared between those children, and OOM
> > killing one of them will not free those resources. Hence, the OOM
> > killer only considers their anonymous usage to be reap-able when a
> > memcg is nuked. For that we use the "anon" stat (or "rss" in cgroup
> > v1) in memory.stat.
> >
> > >
> > > > > > Some workloads need to read up-to-date stats as feedback to act=
ions
> > > > > > (e.g. after proactive reclaim, or for userspace OOM killing pur=
poses),
> > > > > > and reading such stale stats causes regressions or misbehavior =
by
> > > > > > userspace.
> > > > >
> > > > > Please tell us more about those and why should all others that do=
 not
> > > > > require such a precision should page that price as well.
> > > >
> > > > Everyone used to pay this price though and no one used to complain.
> > >
> > > Right, and then the overhead has been reduced and now you want to bri=
ng
> > > it back and that will be seen as a regression. It doesn't really matt=
er
> > > what used to be the overhead. People always care when something gets
> > > slower.
> >
> > People also care when something gets less accurate :)
>
> Accuracy will never be 100%. We have to carefully balance between
> accuracy and overhead. So far we haven't heard about how much inaccuracy
> you are getting. Numbers help!

Very good question, I should have added numbers since the beginning to
clarify the significance of the problem. To easily produce numbers I
will use another use case that we have that relies on having fresh
stats, which is proactive reclaim. Proactive reclaim usually operates
in a feedback loop where it requests some reclaim, queries the stats,
and decides how to operate based on that (e.g. fallback for a while).

When running a test that is proactively reclaiming some memory and
expecting to see the memory swapped, without this patch, we see
significant inaccuracy. In some failure instances we expect ~2000
pages to be swapped but we only find ~1200. This is observed on
machines with hundreds of cpus, where the problem is most noticeable.
This is a huge difference. Keep in mind that the inaccuracy would
probably be even worse in a production environment if the system is
under enough pressure (e.g. the periodic flusher is late).

For both approach A (wait until flusher finishes and exit, i.e this
patch) and approach B (wait until flusher finishes then flush, i.e the
mutex approach), I stop seeing this failure in the proactive reclaim
test and the stats are accurate.

I have v2 ready that implements approach B with the mutex ready to
fire, just say the word :)

>
> In any case I do get the argument about consistency within a subtree
> (children data largely not matching parents'). Examples like that would
> be really helpful as well. If that is indeed the case then I would
> consider it much more serious than accuracy which is always problematic
> (100ms of an actively allocating context can ruin your just read numbers
> and there is no way around that wihtout stopping the world).

100% agreed. It's more difficult to get testing results for this, but
that can easily be the case when we have no idea how much is flushed
when we return from mem_cgroup_flush_stats().

>
> Last note, for /proc/vmstat we have /proc/sys/vm/stat_refresh to trigger
> an explicit refresh. For those users who really need more accurate
> numbers we might consider interface like that. Or allow to write to stat
> file and do that in the write handler.

This wouldn't be my first option, but if that's the only way to get
accurate stats I'll take it.

Keep in mind that the normal stats read path will always try to
refresh, it's just that it will often skip refreshing due to an
implementation-specific race. So having an interface for an explicit
flush might be too implementation specific, especially if the race
disappears later and the interface is not needed later.

Having said that, I am not opposed to this if that's the only way
forward for accurate stats, but I would rather have the stat reads be
always accurate unless a regression is noticed.

> --
> Michal Hocko
> SUSE Labs
