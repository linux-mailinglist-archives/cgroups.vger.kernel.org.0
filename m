Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49507C6F27
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbjJLN3v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJLN3u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 09:29:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA494
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 06:29:48 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41959feaae2so5885021cf.0
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697117388; x=1697722188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ybk+sUTEHYxJD085NMJHTHmsqfChe2BT9mQZhimnZfU=;
        b=jIuNn9BpNZ5E0CMi0rcrvn45N7C0GjqytSfQslPSzr9InqVKk9jkq8WGvuxTDJxisY
         8doClCialO18/c0W4KBXdbq2b3VQrJOaXI1gR2l16L+tzuKuxVvC2KfBepJwyEWWJ7Cx
         RKQXv3Ff31I0mgZooTn1TPTCUEDlfwYT7rmoRPqO/0bGsqjCgEn68Z8XBhiGMHICNr6V
         1trdWQc032Em+0mlqzUfmcrGffCSywJw/QadkpUk129XEGjq5MaS485arIHI6gaTPh2Y
         vJ7eJ0h6tH+/c1tlt4mzHhh2/GhNIyOF+oO6gTX/rk2TV8wqGlf7gfu4u9SuojgUe965
         5hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697117388; x=1697722188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ybk+sUTEHYxJD085NMJHTHmsqfChe2BT9mQZhimnZfU=;
        b=KdxbyJRFnTGKQn0WrSlsXPi31Xb3lXBofNVQYAxROzM0pkUMgi9AEu4IBWxSdp4S0F
         9CN7UZr01OA8xgofJN3bngB+KvMBQS1F+F4t8CsL9eXT3yQvTldo4PEvwrSMNH57COuQ
         MUs2JG0NQhWL2U584apASloSQasG9jl5SCa3alDeXDS+4AMxvPUeaORND2OzCO0PJT5x
         xg2sCPhh3Sib4yMsyMV0MiBdMM8JCPt41MvOANMqlJa21UulgOfepCe644HkZjbiVjPI
         yM5O5PWYeQLLVuxjulgfHKX/cIJ9Hz4NfNCscIayYkWGhtW6nWZjA0djX1Na/v7xBRCk
         K7Ng==
X-Gm-Message-State: AOJu0Yx23p1nG9ziBgHo3ZpyRoZ64XgDXgqZ8bgwWRnOgbauptit4jgD
        dqL658/fV3UfYoda1zWMJaWRuA==
X-Google-Smtp-Source: AGHT+IEu9EQEyDkwsQbhuGY67hZLMSeQYZ5ijIozLtPEEZ9plkLT155cbIZs7B+UAUVtPaIKEj7Fzg==
X-Received: by 2002:a05:622a:11d4:b0:416:5e11:f7ec with SMTP id n20-20020a05622a11d400b004165e11f7ecmr31277304qtk.52.1697117387879;
        Thu, 12 Oct 2023 06:29:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id g26-20020ac870da000000b00400a99b8b38sm6146339qtp.78.2023.10.12.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:29:47 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:29:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <20231012132946.GA470544@cmpxchg.org>
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com>
 <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com>
 <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 12, 2023 at 01:04:03AM -0700, Yosry Ahmed wrote:
> On Wed, Oct 11, 2023 at 8:13 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 5:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 6:48 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Tue, Oct 10, 2023 at 5:36 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> > > > > [...]
> > > > > >
> > > > > > I tried this on a machine with 72 cpus (also ixion), running both
> > > > > > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > > > > > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a
> > > > > > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a/b
> > > > > > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a/b/c
> > > > > > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> > > > > > # mkdir /sys/fs/cgroup/a/b/c/d
> > > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > > # ./netserver -6
> > > > > >
> > > > > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > > > > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE --
> > > > > > -m 10K; done
> > > > >
> > > > > You are missing '&' at the end. Use something like below:
> > > > >
> > > > > #!/bin/bash
> > > > > for i in {1..22}
> > > > > do
> > > > >    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
> > > > > done
> > > > > wait
> > > > >
> > > >
> > > > Oh sorry I missed the fact that you are running instances in parallel, my bad.
> > > >
> > > > So I ran 36 instances on a machine with 72 cpus. I did this 10 times
> > > > and got an average from all instances for all runs to reduce noise:
> > > >
> > > > #!/bin/bash
> > > >
> > > > ITER=10
> > > > NR_INSTANCES=36
> > > >
> > > > for i in $(seq $ITER); do
> > > >   echo "iteration $i"
> > > >   for j in $(seq $NR_INSTANCES); do
> > > >     echo "iteration $i" >> "out$j"
> > > >     ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j" &
> > > >   done
> > > >   wait
> > > > done
> > > >
> > > > cat out* | grep 540000 | awk '{sum += $5} END {print sum/NR}'
> > > >
> > > > Base: 22169 mbps
> > > > Patched: 21331.9 mbps
> > > >
> > > > The difference is ~3.7% in my runs. I am not sure what's different.
> > > > Perhaps it's the number of runs?
> > >
> > > My base kernel is next-20231009 and I am running experiments with
> > > hyperthreading disabled.
> >
> > Using next-20231009 and a similar 44 core machine with hyperthreading
> > disabled, I ran 22 instances of netperf in parallel and got the
> > following numbers from averaging 20 runs:
> >
> > Base: 33076.5 mbps
> > Patched: 31410.1 mbps
> >
> > That's about 5% diff. I guess the number of iterations helps reduce
> > the noise? I am not sure.
> >
> > Please also keep in mind that in this case all netperf instances are
> > in the same cgroup and at a 4-level depth. I imagine in a practical
> > setup processes would be a little more spread out, which means less
> > common ancestors, so less contended atomic operations.
> 
> 
> (Resending the reply as I messed up the last one, was not in plain text)
> 
> I was curious, so I ran the same testing in a cgroup 2 levels deep
> (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> experience. Here are the numbers:
> 
> Base: 40198.0 mbps
> Patched: 38629.7 mbps
> 
> The regression is reduced to ~3.9%.
> 
> What's more interesting is that going from a level 2 cgroup to a level
> 4 cgroup is already a big hit with or without this patch:
> 
> Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> Patched: 38629.7 -> 31410.1 (~18.7% regression)
> 
> So going from level 2 to 4 is already a significant regression for
> other reasons (e.g. hierarchical charging). This patch only makes it
> marginally worse. This puts the numbers more into perspective imo than
> comparing values at level 4. What do you think?

I think it's reasonable.

Especially comparing to how many cachelines we used to touch on the
write side when all flushing happened there. This looks like a good
trade-off to me.
