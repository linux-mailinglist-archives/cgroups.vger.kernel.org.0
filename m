Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073D7C476F
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 03:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjJKBs5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 21:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbjJKBsx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 21:48:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089893
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 18:48:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a6190af24aso1095670666b.0
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696988930; x=1697593730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgmTMfuU3cCeLGy5YhBbbvizhGvmrwNUjrSNHCgxSVM=;
        b=r1m8eAQgu1YxRdB3F9oK28HWMMvq/OJmOQokmNkjXMGb/csXzN5OLDAgbB6VykiMVx
         q/JqUfFFCBfFZnbCXgnn9ktZZ2TVNqC1pXzAVb3rBQNT1OdPbSG3gPi3k29pLJ5FU++J
         eyk/M2Vqx0W30Zrd2ogiAyjz8RySKxnTNkLYp8V+SpgSoh22o2zoeo8AEeKkSDN1z5rK
         EgMBMVjShbODqGGIS+UDwIrYdhGFAu2XWN/Dqutd5wdChGjiO89I4Qmy1NmfmM84AO9B
         xYVsQ2b09UAwPue2nGa7hF5qMiBF1ax32H+A8xcIw9G9HwvrchFsOnW/WTsbt3fFcvwG
         40jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988930; x=1697593730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgmTMfuU3cCeLGy5YhBbbvizhGvmrwNUjrSNHCgxSVM=;
        b=oFCX65dnkssn78uLH46cBpXBrTroX1GKMCMuYohCyqAtIz+eJOKHqrdLZAzFuQ39r8
         QliL4/LitWtga6wiBF9oEnNwaW2PgHssLRfgPbapLqlnUC9crXjCW0tidSsnSPUO5m7Q
         HKQWkB9SwTZWOiIEFe7oxcJ1OnZ2CS270ksCm1cs8Iv2tKUibUREK2TDUCUo9FhGLKUv
         6mjF6T/+deLkHVvjTfA0L4Xd5iFjNjOwh30NS8b5rCUl5sT065p/GbQMlPcTEKiIGfVR
         zw+p9ikgkQvw5pW1MSzdb96PhOySNa11Ok1eglrjbE2w7HsjvpO/UgjZQU4JwPRe2vCA
         QdEQ==
X-Gm-Message-State: AOJu0YzMOEGjqIbzKfj3YSjlViVuYQZKpiDs7yFuXKf3NABx2hvRWPc6
        USeimcxXe/4M27FZjQDKjXGvitKpfisC7KziMWvX9Q==
X-Google-Smtp-Source: AGHT+IFG8zP5Syqi5MZ6+G6K9VUFI90ompaJz3mzhBWqc14rM6pucl7DnlfREAkMgADEGF+ZpGnbG1KidG8/lnu9PFw=
X-Received: by 2002:a17:906:32cb:b0:9ae:7622:eed9 with SMTP id
 k11-20020a17090632cb00b009ae7622eed9mr17959783ejk.50.1696988930108; Tue, 10
 Oct 2023 18:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com> <20231011003646.dt5rlqmnq6ybrlnd@google.com>
In-Reply-To: <20231011003646.dt5rlqmnq6ybrlnd@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 10 Oct 2023 18:48:11 -0700
Message-ID: <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
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

On Tue, Oct 10, 2023 at 5:36=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
> [...]
> >
> > I tried this on a machine with 72 cpus (also ixion), running both
> > netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> > # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> > # mkdir /sys/fs/cgroup/a
> > # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> > # mkdir /sys/fs/cgroup/a/b
> > # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> > # mkdir /sys/fs/cgroup/a/b/c
> > # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> > # mkdir /sys/fs/cgroup/a/b/c/d
> > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > # ./netserver -6
> >
> > # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> > # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE --
> > -m 10K; done
>
> You are missing '&' at the end. Use something like below:
>
> #!/bin/bash
> for i in {1..22}
> do
>    /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
> done
> wait
>

Oh sorry I missed the fact that you are running instances in parallel, my b=
ad.

So I ran 36 instances on a machine with 72 cpus. I did this 10 times
and got an average from all instances for all runs to reduce noise:

#!/bin/bash

ITER=3D10
NR_INSTANCES=3D36

for i in $(seq $ITER); do
  echo "iteration $i"
  for j in $(seq $NR_INSTANCES); do
    echo "iteration $i" >> "out$j"
    ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K >> "out$j" &
  done
  wait
done

cat out* | grep 540000 | awk '{sum +=3D $5} END {print sum/NR}'

Base: 22169 mbps
Patched: 21331.9 mbps

The difference is ~3.7% in my runs. I am not sure what's different.
Perhaps it's the number of runs?
