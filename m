Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C077C6335
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 05:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjJLDOg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 23:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJLDOg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 23:14:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3594
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 20:14:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso74982366b.2
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 20:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697080473; x=1697685273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4TVrvq8uoH1eycNvhhxc6PoR8dTnuXdQn6h8TXV/H0=;
        b=MSSCDMdvkgfECZeqnL5PtWg2KpByZ8KHXTKdypD9sYCv2fTy4Zzv+rUKhq/45Vl5Ui
         UvYAwdwLcv8/ShX8UB2hO16kYHemcjClPBS90TM82j6L1vrjk6iCrs2tXL3bNRQPpdAK
         xsggR76XbUZoKQecAwYZ5+2iLaar5ujiBa2F/bNNscBLL308C5rhB8+qLVZWqhOTRH0q
         vysKVLGk0EjGWV2A/3UV/yJ0DcA+3MYRmqg+sB7zcrN8+/bdfirLOvbysnW5Xz6dpfvU
         DEmc98SE28DcQoQrUb+AIyfA8C2GRQUT1uIekjtLZwwQpaIlxVYU4/hmvXqNCv5e+buE
         TRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697080473; x=1697685273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4TVrvq8uoH1eycNvhhxc6PoR8dTnuXdQn6h8TXV/H0=;
        b=OnLydrATdgpvPGX5FcS3PpLQgyz5NmWl/BKjRcH2GeNGsnPkuxLE4nq/jO6EpFmQor
         jgxFjyQFYvq1CSS64WHqgH2spcyOfZg0u3a1eb9CWZSEarIDSlmGP/iLLjOUtYs2U6az
         BSeVbfBSusSamR9dM77VUmaIrjIwegvgill4MumWelP6wt/UKZO3gDJlcuJxzFbFULs/
         qNVMTvMid6MPDGDXc3nNN9cHcGyJjN+d6Tn/dO59nz5hPAIegFU0JT3fH4YKNL9qah/O
         K/1cdX8cte2aGWaGNj6ykk1V81rlynGrX65ervm1VLxokoFVdLXKxWnf7QE8Q5ATxpVP
         0QvA==
X-Gm-Message-State: AOJu0YzP5oXR7FtbLRplfDjNhh1cWErFs0daH7PmHmKGntdos5DaaGyR
        lFe7iv7jk7Sc13+EOVrLxilQWlGMFxAX+5Ni6mF1Tg==
X-Google-Smtp-Source: AGHT+IErCQ3tOY754uhLEcdp3aTeunkuxdqdmWI575ba8qvAsvXa0b1TTgbRuhl+wIWMyNjlZ+f7ry2dzvLEnYLpplc=
X-Received: by 2002:a17:906:104e:b0:9b2:ba65:db21 with SMTP id
 j14-20020a170906104e00b009b2ba65db21mr21469636ejj.45.1697080472968; Wed, 11
 Oct 2023 20:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
In-Reply-To: <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 11 Oct 2023 20:13:55 -0700
Message-ID: <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 11, 2023 at 5:46=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Tue, Oct 10, 2023 at 6:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Oct 10, 2023 at 5:36=E2=80=AFPM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> > > [...]
> > > >
> > > > I tried this on a machine with 72 cpus (also ixion), running both
> > > > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > > > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > > > # mkdir /sys/fs/cgroup/a
> > > > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > > > # mkdir /sys/fs/cgroup/a/b
> > > > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > > > # mkdir /sys/fs/cgroup/a/b/c
> > > > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> > > > # mkdir /sys/fs/cgroup/a/b/c/d
> > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > # ./netserver -6
> > > >
> > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE =
--
> > > > -m 10K; done
> > >
> > > You are missing '&' at the end. Use something like below:
> > >
> > > #!/bin/bash
> > > for i in {1..22}
> > > do
> > >    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
> > > done
> > > wait
> > >
> >
> > Oh sorry I missed the fact that you are running instances in parallel, =
my bad.
> >
> > So I ran 36 instances on a machine with 72 cpus. I did this 10 times
> > and got an average from all instances for all runs to reduce noise:
> >
> > #!/bin/bash
> >
> > ITER=3D10
> > NR_INSTANCES=3D36
> >
> > for i in $(seq $ITER); do
> >   echo "iteration $i"
> >   for j in $(seq $NR_INSTANCES); do
> >     echo "iteration $i" >> "out$j"
> >     ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j" &
> >   done
> >   wait
> > done
> >
> > cat out* | grep 540000 | awk '{sum +=3D $5} END {print sum/NR}'
> >
> > Base: 22169 mbps
> > Patched: 21331.9 mbps
> >
> > The difference is ~3.7% in my runs. I am not sure what's different.
> > Perhaps it's the number of runs?
>
> My base kernel is next-20231009 and I am running experiments with
> hyperthreading disabled.

Using next-20231009 and a similar 44 core machine with hyperthreading
disabled, I ran 22 instances of netperf in parallel and got the
following numbers from averaging 20 runs:

Base: 33076.5 mbps
Patched: 31410.1 mbps

That's about 5% diff. I guess the number of iterations helps reduce
the noise? I am not sure.

Please also keep in mind that in this case all netperf instances are
in the same cgroup and at a 4-level depth. I imagine in a practical
setup processes would be a little more spread out, which means less
common ancestors, so less contended atomic operations.
