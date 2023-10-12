Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC5A7C710B
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjJLPKy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjJLPKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 11:10:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD403CF
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 08:10:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso1904002a12.1
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697123446; x=1697728246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpDYHFY2dl9s+q1D4aeetz4SQmaXlkXA2zbUfRxzbYc=;
        b=1vgSpiTF8MDaMpI22ZweEJ9hVWGL11+TLQ7qqObOYNCcCLtPVPb25FFMmEsDSukhm0
         hoFq14DpP02Ya3y5NqjkN0NAd/MhO/j6tFwgSFL/9EAd4+iL04Vt3K7Jn+5ZKzXgY5Wj
         747+Egnuif6W2SepQsK6S6S7AXnk4bcLwOQzhO09+9o4Sd7oWth610VRxf47Ws05j3F7
         OfdZFGmCZxzRV4xsM/4HKOrgJwpxUT6Te0jcdcoy2E+1vu+QQwEeoiPva/eiAnTk+2Bp
         UdINlBPm5nUcgTU+KhetS3pS1sWs7ZWopbA2R5XCGXuWJd7UsQHXYzxpVLHZcpyxlR6v
         yvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123446; x=1697728246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpDYHFY2dl9s+q1D4aeetz4SQmaXlkXA2zbUfRxzbYc=;
        b=OERdUY9iuTYTUeVuOqZKHsbM4dvfgx6lJmAri3TGASidroauC7+H8WQmLN+RW015/J
         0DLG1OY0VmP9FGwkTKYyhyjP1A1nLzSvGivIq7hlyV21+sBBTpOHRnAQVnJdkOWt1Ro2
         HgkoPzK37t4Od2xUs+OQ84vtQreuOskXDDM3YtDpk40b2GWieoSoRfys1+c4KskArcnw
         otS/Q+D2tWXpmtsRD9mXB3GGp6fQ2mbnQMo4FtjKWfjo/0YuMkUV+XCHiAmw1VBV4fMk
         IYY4thNvPVMVdVJpGFP+HpBApqMJLvmxqsjPAEe0JYRLxzXeWyJrOIt9SvJ4dZNoxMr0
         M3AA==
X-Gm-Message-State: AOJu0YziBTEQvMOEuJqc67yI5mCIg67kv/BgOZH8OUaNJNKZq3358IjV
        IC4wRuYb0gLyuXveM7dCBlVE3Hu2DouaAX6LYhmn6A==
X-Google-Smtp-Source: AGHT+IG1NZsBF0x+ysdXPpuvixswdgMB2PNukO+5lnPWO4mvWEBQAq6PrIFm3ho2S4LstGS8XvPCoP0j7q2Idqu37TA=
X-Received: by 2002:a17:907:b0d:b0:9ae:37c2:11b2 with SMTP id
 h13-20020a1709070b0d00b009ae37c211b2mr19347554ejl.15.1697123445857; Thu, 12
 Oct 2023 08:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com> <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
In-Reply-To: <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 08:10:06 -0700
Message-ID: <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 6:35=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Oct 12, 2023 at 1:04=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Wed, Oct 11, 2023 at 8:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 5:46=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Tue, Oct 10, 2023 at 6:48=E2=80=AFPM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > On Tue, Oct 10, 2023 at 5:36=E2=80=AFPM Shakeel Butt <shakeelb@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> > > > > > [...]
> > > > > > >
> > > > > > > I tried this on a machine with 72 cpus (also ixion), running =
both
> > > > > > > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > > > > > > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > > > > > > # mkdir /sys/fs/cgroup/a
> > > > > > > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > > > > > > # mkdir /sys/fs/cgroup/a/b
> > > > > > > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > > > > > > # mkdir /sys/fs/cgroup/a/b/c
> > > > > > > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_contro=
l
> > > > > > > # mkdir /sys/fs/cgroup/a/b/c/d
> > > > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > > > # ./netserver -6
> > > > > > >
> > > > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > > > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SEN=
DFILE --
> > > > > > > -m 10K; done
> > > > > >
> > > > > > You are missing '&' at the end. Use something like below:
> > > > > >
> > > > > > #!/bin/bash
> > > > > > for i in {1..22}
> > > > > > do
> > > > > >    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K =
&
> > > > > > done
> > > > > > wait
> > > > > >
> > > > >
> > > > > Oh sorry I missed the fact that you are running instances in para=
llel, my bad.
> > > > >
> > > > > So I ran 36 instances on a machine with 72 cpus. I did this 10 ti=
mes
> > > > > and got an average from all instances for all runs to reduce nois=
e:
> > > > >
> > > > > #!/bin/bash
> > > > >
> > > > > ITER=3D10
> > > > > NR_INSTANCES=3D36
> > > > >
> > > > > for i in $(seq $ITER); do
> > > > >   echo "iteration $i"
> > > > >   for j in $(seq $NR_INSTANCES); do
> > > > >     echo "iteration $i" >> "out$j"
> > > > >     ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j=
" &
> > > > >   done
> > > > >   wait
> > > > > done
> > > > >
> > > > > cat out* | grep 540000 | awk '{sum +=3D $5} END {print sum/NR}'
> > > > >
> > > > > Base: 22169 mbps
> > > > > Patched: 21331.9 mbps
> > > > >
> > > > > The difference is ~3.7% in my runs. I am not sure what's differen=
t.
> > > > > Perhaps it's the number of runs?
> > > >
> > > > My base kernel is next-20231009 and I am running experiments with
> > > > hyperthreading disabled.
> > >
> > > Using next-20231009 and a similar 44 core machine with hyperthreading
> > > disabled, I ran 22 instances of netperf in parallel and got the
> > > following numbers from averaging 20 runs:
> > >
> > > Base: 33076.5 mbps
> > > Patched: 31410.1 mbps
> > >
> > > That's about 5% diff. I guess the number of iterations helps reduce
> > > the noise? I am not sure.
> > >
> > > Please also keep in mind that in this case all netperf instances are
> > > in the same cgroup and at a 4-level depth. I imagine in a practical
> > > setup processes would be a little more spread out, which means less
> > > common ancestors, so less contended atomic operations.
> >
> >
> > (Resending the reply as I messed up the last one, was not in plain text=
)
> >
> > I was curious, so I ran the same testing in a cgroup 2 levels deep
> > (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> > experience. Here are the numbers:
> >
> > Base: 40198.0 mbps
> > Patched: 38629.7 mbps
> >
> > The regression is reduced to ~3.9%.
> >
> > What's more interesting is that going from a level 2 cgroup to a level
> > 4 cgroup is already a big hit with or without this patch:
> >
> > Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> > Patched: 38629.7 -> 31410.1 (~18.7% regression)
> >
> > So going from level 2 to 4 is already a significant regression for
> > other reasons (e.g. hierarchical charging). This patch only makes it
> > marginally worse. This puts the numbers more into perspective imo than
> > comparing values at level 4. What do you think?
>
> This is weird as we are running the experiments on the same machine. I
> will rerun with 2 levels as well. Also can you rerun the page fault
> benchmark as well which was showing 9% regression in your original
> commit message?

Thanks. I will re-run the page_fault tests, but keep in mind that the
page fault benchmarks in will-it-scale are highly variable. We run
them between kernel versions internally, and I think we ignore any
changes below 10% as the benchmark is naturally noisy.

I have a couple of runs for page_fault3_scalability showing a 2-3%
improvement with this patch :)
