Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0268E7C688A
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347249AbjJLIEo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347120AbjJLIEn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 04:04:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14BB7
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 01:04:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso107445866b.1
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697097879; x=1697702679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=937YDLhB/LKhEB9XjdalzzUB5ZBYWrU2yT5JnPkc4iE=;
        b=qewU/EcEEx41UZ8lkIg0A87JdPdglDONWNC9sEtjC4y5rLjBYQnL9A61N6cJe8sIif
         pxbUaECuwefSL9FIpNiVJ1xXmyHHhy5R8ot/zXVQ94xDR7R1KHNCLCE2ByQPfotfmpB+
         99eeB+cXxbYMJldlgIpfd9PZuv3nQCjE9oYk9zHXLEicFmmDXdcX/g81Bmi3Dzgep8tF
         QVgUAaQGMahbx0n8yv1uwNz35gYERKvJt9ut5Q4rA0vvLsHgbvxh2I8PgfZiDLQhILyF
         O9sXz8Lr7q+78LX6jpVyjKPcl2Ju538cjsjAT8M5/pTqwk8wanyA4zsLY8DNkMnURwLp
         NyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097879; x=1697702679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=937YDLhB/LKhEB9XjdalzzUB5ZBYWrU2yT5JnPkc4iE=;
        b=c6WovO4Hxr2xbb/gWiAsNhtyxWN3i1Q6GY3QPlNo/rGswdFNerzHzzW32IpKKdyfY9
         +vx4ie29JTB8v9VrTVo4TRQ4fWaRSCukAQzGZuEOu46cNHBHZbzqJXL2twT71NwIIrl0
         Vg1hnZvTBkqxWcBzPH0NSWRyaCeE4IQcAMhnIX4T/m9VTPlW0yJbW9XgEhkObhUlLYBa
         kQHcim977a4QvStlzr4jpjNleRpninRqudylYc3GnDJmMBinO98fascVlhIwh8Ki+G8C
         wvTpUZDtkrtI1nkxhCxf8WgnGn+BiCdTuQCo2R4mcAcPc5R1ZVV9woU4ze1L8+4EwRqx
         2wgQ==
X-Gm-Message-State: AOJu0YxfFGTQz/ipXTgY1faVCpx24JEISWnl4awtZIbt2M1FKIGFLI28
        Kw8ptUKw6mEFB0ycl6ATIQbtEuhKtDFRFkrjREruDg==
X-Google-Smtp-Source: AGHT+IFkw+QlomjvvrPZT6/iMPFPNgS2KfjqRUczRUJTLw7MtE4TQ62uK3MgP17Mrm9Cmj76go5vcIhfgvcNqM1U/xI=
X-Received: by 2002:a17:907:7636:b0:9ba:4163:1801 with SMTP id
 jy22-20020a170907763600b009ba41631801mr5519834ejc.60.1697097879098; Thu, 12
 Oct 2023 01:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com> <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 01:04:03 -0700
Message-ID: <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 11, 2023 at 8:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Oct 11, 2023 at 5:46=E2=80=AFAM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Tue, Oct 10, 2023 at 6:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 5:36=E2=80=AFPM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> > > > [...]
> > > > >
> > > > > I tried this on a machine with 72 cpus (also ixion), running both
> > > > > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > > > > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > > > > # mkdir /sys/fs/cgroup/a
> > > > > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > > > > # mkdir /sys/fs/cgroup/a/b
> > > > > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > > > > # mkdir /sys/fs/cgroup/a/b/c
> > > > > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> > > > > # mkdir /sys/fs/cgroup/a/b/c/d
> > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > # ./netserver -6
> > > > >
> > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFIL=
E --
> > > > > -m 10K; done
> > > >
> > > > You are missing '&' at the end. Use something like below:
> > > >
> > > > #!/bin/bash
> > > > for i in {1..22}
> > > > do
> > > >    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
> > > > done
> > > > wait
> > > >
> > >
> > > Oh sorry I missed the fact that you are running instances in parallel=
, my bad.
> > >
> > > So I ran 36 instances on a machine with 72 cpus. I did this 10 times
> > > and got an average from all instances for all runs to reduce noise:
> > >
> > > #!/bin/bash
> > >
> > > ITER=3D10
> > > NR_INSTANCES=3D36
> > >
> > > for i in $(seq $ITER); do
> > >   echo "iteration $i"
> > >   for j in $(seq $NR_INSTANCES); do
> > >     echo "iteration $i" >> "out$j"
> > >     ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j" &
> > >   done
> > >   wait
> > > done
> > >
> > > cat out* | grep 540000 | awk '{sum +=3D $5} END {print sum/NR}'
> > >
> > > Base: 22169 mbps
> > > Patched: 21331.9 mbps
> > >
> > > The difference is ~3.7% in my runs. I am not sure what's different.
> > > Perhaps it's the number of runs?
> >
> > My base kernel is next-20231009 and I am running experiments with
> > hyperthreading disabled.
>
> Using next-20231009 and a similar 44 core machine with hyperthreading
> disabled, I ran 22 instances of netperf in parallel and got the
> following numbers from averaging 20 runs:
>
> Base: 33076.5 mbps
> Patched: 31410.1 mbps
>
> That's about 5% diff. I guess the number of iterations helps reduce
> the noise? I am not sure.
>
> Please also keep in mind that in this case all netperf instances are
> in the same cgroup and at a 4-level depth. I imagine in a practical
> setup processes would be a little more spread out, which means less
> common ancestors, so less contended atomic operations.


(Resending the reply as I messed up the last one, was not in plain text)

I was curious, so I ran the same testing in a cgroup 2 levels deep
(i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
experience. Here are the numbers:

Base: 40198.0 mbps
Patched: 38629.7 mbps

The regression is reduced to ~3.9%.

What's more interesting is that going from a level 2 cgroup to a level
4 cgroup is already a big hit with or without this patch:

Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
Patched: 38629.7 -> 31410.1 (~18.7% regression)

So going from level 2 to 4 is already a significant regression for
other reasons (e.g. hierarchical charging). This patch only makes it
marginally worse. This puts the numbers more into perspective imo than
comparing values at level 4. What do you think?
