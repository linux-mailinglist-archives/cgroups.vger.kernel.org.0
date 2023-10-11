Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44C7C5440
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjJKMqP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjJKMqO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 08:46:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E4B0
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 05:46:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso37065ad.0
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697028370; x=1697633170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRxnYW++U+8TlQsWmKaGw4xOnyl04ESkzrCSiOYHMOw=;
        b=qAp+K8S1JOrv4Vc471JGQA+DzbmURcp2VnW7zVvKSnLxZcsqjnvD1EyFbYWy1yQvcJ
         cC/z2Gw/e7ugaCWm7gjfZbQq8y6s9fcVGTPFdmA3pZnXuKwoVue/Pr6fGZugZM1pbCOA
         BCS7SB0cbmfxRkcoB3pmxGYZh0BMHry3B4igIIPD8A23wjI+Kagc5TbzRRrhXBPgj0v6
         OgfH9rmczoqwjJhdQwQ83Zy0/Fqcmb5L9QumXCStW6VyUDmlYu7+ig0uC6AI+p7Lxy5v
         aU+UOtCe6vztHNA/UZfIsVQiTrp5GG80RnnsYi70iuwcRsh+/UVg+1iuMnliz8oT9+RW
         jx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028370; x=1697633170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRxnYW++U+8TlQsWmKaGw4xOnyl04ESkzrCSiOYHMOw=;
        b=L+zN6zsRvL9whYlDq9BCxqS2+RhhRTDnW7lSPY5zJyebl8n6CcSxv4oZJUFXK6TRBt
         /TWjgfgSNMC/Twre0is95mPTcGcPAgaQ75Y5aLn3u89b5adumAoFHCgLTuMGdtHHApNM
         YGnnuDmyJydb0WCN+8hZjchvFoMo9o2CBJX/JU2hJyjZK3fzcky424yf8e1Pz+CFn899
         yumiWXTJmMkW+Cw03CyMVGArgcg7FqZDMxtatfS1V2RTOR+MIZ4YwMA2d56B49b773Zg
         LIxm3b9G8td99jHmNmjvdVcI6O37l0RcseDhWgge2J0Y1ggxj5QzW8ovfD6x7+GEXMDb
         mebg==
X-Gm-Message-State: AOJu0YwpVhRqeCehE/yxHTda53YBquVLi/jqYUGoE/HwFVumCQwOazed
        Gx2IiuKiSXjPz/Xtke7jrFi6MEkL1V7SSfpMktwQOg==
X-Google-Smtp-Source: AGHT+IHSO7IpzlUaTsA99RK2xosy3goKI41ZEFNsKGFVZUUg12a2Etj4aZSQgVylWCCjwh0GKeVN7byl8b9dfg6R6Zs=
X-Received: by 2002:a17:902:ecc9:b0:1c6:212f:c8e5 with SMTP id
 a9-20020a170902ecc900b001c6212fc8e5mr218432plh.26.1697028370195; Wed, 11 Oct
 2023 05:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
In-Reply-To: <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 11 Oct 2023 05:45:58 -0700
Message-ID: <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Yosry Ahmed <yosryahmed@google.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 6:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 10, 2023 at 5:36=E2=80=AFPM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> > [...]
> > >
> > > I tried this on a machine with 72 cpus (also ixion), running both
> > > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > > # mkdir /sys/fs/cgroup/a
> > > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > > # mkdir /sys/fs/cgroup/a/b
> > > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > > # mkdir /sys/fs/cgroup/a/b/c
> > > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> > > # mkdir /sys/fs/cgroup/a/b/c/d
> > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > # ./netserver -6
> > >
> > > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE --
> > > -m 10K; done
> >
> > You are missing '&' at the end. Use something like below:
> >
> > #!/bin/bash
> > for i in {1..22}
> > do
> >    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
> > done
> > wait
> >
>
> Oh sorry I missed the fact that you are running instances in parallel, my=
 bad.
>
> So I ran 36 instances on a machine with 72 cpus. I did this 10 times
> and got an average from all instances for all runs to reduce noise:
>
> #!/bin/bash
>
> ITER=3D10
> NR_INSTANCES=3D36
>
> for i in $(seq $ITER); do
>   echo "iteration $i"
>   for j in $(seq $NR_INSTANCES); do
>     echo "iteration $i" >> "out$j"
>     ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j" &
>   done
>   wait
> done
>
> cat out* | grep 540000 | awk '{sum +=3D $5} END {print sum/NR}'
>
> Base: 22169 mbps
> Patched: 21331.9 mbps
>
> The difference is ~3.7% in my runs. I am not sure what's different.
> Perhaps it's the number of runs?

My base kernel is next-20231009 and I am running experiments with
hyperthreading disabled.
