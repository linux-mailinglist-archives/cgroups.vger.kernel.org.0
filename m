Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118AC7C796B
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbjJLWXu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442981AbjJLWXt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 18:23:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAD1CA
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 15:23:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so246336266b.0
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149425; x=1697754225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ryb9YsIL7H3sv3lFpG42u/WGG4wjx7QPr3zVCs+YE7o=;
        b=b0gdRMoaQAg3h741A3Z1sp1yA3ry8SroDj2YbvjlhVb+T5FcJy4AlKPzL+Tmtiype/
         57wdmxQpz600nRevn2QsyufOOxHQxbkZwmAvQQjRmOba/s0Yze+oVP0Fd6q4uHD++JaT
         OoCzoSC99gQOMKw95mjmsajDwSlJ5cquyqqTuKyiLY6oB/MH+v+hZteV6+3WMgDz4/Jv
         bVSpnMkF8X+NjPQZ3dCd7fbUfhi145qk9Jckv9NG+Lfp3uyoxHISoiklnvmIVXFj7BKU
         gwcuTPLePucqlEEMEywt7qy+o9y+pZdeVxlLlpMIF1Ijdp+oc96Ua5koy69CTsYxmkAa
         XAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149425; x=1697754225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ryb9YsIL7H3sv3lFpG42u/WGG4wjx7QPr3zVCs+YE7o=;
        b=Hr45QEtWfqGb8Q8Fy2ryp9ygWd6PAkaG4niPplClJothCXrnjff4abUI7fPBk43FVz
         8LhNm6E5VQVVsXK9fyQOCLmya0wFxdS3sLfEPw+i48JD54a8BjotkV8sUFhwslbqLrid
         v/nEdXB4GvuwZzm/Bv4d7OZFbMOmZ2uHrgq2aHln+BDyiPh3saWW5472ERJCkGeKWadE
         cDb0Hc0iYgt8Hd4S9ObBhkzRUdN3pQUGkUJG8B0BBrnduwVt8yPd1060I5kAO63BN7z2
         9e7DbdANjfKQe6L5NDCugVfzv8OmC8mlUdZClWZYaGuB03QZUAPcC4/0cyYRxf5/BAqW
         9oYw==
X-Gm-Message-State: AOJu0YyfL3lyRDssBl1NM8nmZbwnDlOq+M8MARVxEOz29zYWzI6gUIyc
        08kuAyuVtaFTA1oy6attpi295qOAzIGNXfYBRxwNdQ==
X-Google-Smtp-Source: AGHT+IG0znS342LSOtk4SWPPirgo9vg1+/7qOA8TH7gv7MxLcFqaaOg3V8ctTNCqsueaU3VEQyrXqhkXbPCSr4qKaKU=
X-Received: by 2002:a17:906:6a19:b0:9a5:a0c6:9e8e with SMTP id
 qw25-20020a1709066a1900b009a5a0c69e8emr29493117ejc.31.1697149425195; Thu, 12
 Oct 2023 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
 <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
 <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
 <CALvZod5fWDWZDa=WoyOyckvx5ptjmFBMO9sOG0Sk0MgiDX4DSQ@mail.gmail.com>
 <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com> <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
In-Reply-To: <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 15:23:06 -0700
Message-ID: <CAJD7tkavJDMSZdwtfxUc67mNBSkrz7XCa_z8FGH0FGg6m4RuAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     michael@phoronix.com, Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 12, 2023 at 2:39=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Oct 12, 2023 at 2:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> > >
> > > Yes this looks better. I think we should also ask intel perf and
> > > phoronix folks to run their benchmarks as well (but no need to block
> > > on them).
> >
> > Anything I need to do for this to happen? (I thought such testing is
> > already done on linux-next)
>
> Just Cced the relevant folks.
>
> Michael, Oliver & Feng, if you have some time/resource available,
> please do trigger your performance benchmarks on the following series
> (but nothing urgent):
>
> https://lore.kernel.org/all/20231010032117.1577496-1-yosryahmed@google.co=
m/

Thanks for that.

>
> >
> > Also, any further comments on the patch (or the series in general)? If
> > not, I can send a new commit message for this patch in-place.
>
> Sorry, I haven't taken a look yet but will try in a week or so.

Sounds good, thanks.

Meanwhile, Andrew, could you please replace the commit log of this
patch as follows for more updated testing info:

Subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg

A global counter for the magnitude of memcg stats update is maintained
on the memcg side to avoid invoking rstat flushes when the pending
updates are not significant. This avoids unnecessary flushes, which are
not very cheap even if there isn't a lot of stats to flush. It also
avoids unnecessary lock contention on the underlying global rstat lock.

Make this threshold per-memcg. The scheme is followed where percpu (now
also per-memcg) counters are incremented in the update path, and only
propagated to per-memcg atomics when they exceed a certain threshold.

This provides two benefits:
(a) On large machines with a lot of memcgs, the global threshold can be
reached relatively fast, so guarding the underlying lock becomes less
effective. Making the threshold per-memcg avoids this.

(b) Having a global threshold makes it hard to do subtree flushes, as we
cannot reset the global counter except for a full flush. Per-memcg
counters removes this as a blocker from doing subtree flushes, which
helps avoid unnecessary work when the stats of a small subtree are
needed.

Nothing is free, of course. This comes at a cost:
(a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4
bytes. The extra memory usage is insigificant.

(b) More work on the update side, although in the common case it will
only be percpu counter updates. The amount of work scales with the
number of ancestors (i.e. tree depth). This is not a new concept, adding
a cgroup to the rstat tree involves a parent loop, so is charging.
Testing results below show no significant regressions.

(c) The error margin in the stats for the system as a whole increases
from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
NR_MEMCGS. This is probably fine because we have a similar per-memcg
error in charges coming from percpu stocks, and we have a periodic
flusher that makes sure we always flush all the stats every 2s anyway.

This patch was tested to make sure no significant regressions are
introduced on the update path as follows. The following benchmarks were
ran in a cgroup that is 2 levels deep (/sys/fs/cgroup/a/b/):

(1) Running 22 instances of netperf on a 44 cpu machine with
hyperthreading disabled. All instances are run in a level 2 cgroup, as
well as netserver:
  # netserver -6
  # netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

Averaging 20 runs, the numbers are as follows:
Base: 40198.0 mbps
Patched: 38629.7 mbps (-3.9%)

The regression is minimal, especially for 22 instances in the same
cgroup sharing all ancestors (so updating the same atomics).

(2) will-it-scale page_fault tests. These tests (specifically
per_process_ops in page_fault3 test) detected a 25.9% regression before
for a change in the stats update path [1]. These are the
numbers from 10 runs (+ is good) on a machine with 256 cpus:

               LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
------------------------------+-------------+-------------+-------------
  page_fault1_per_process_ops |             |             |            |
  (A) base                    | 270249.164  | 265437.000  | 13451.836  |
  (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
                              | -3.29%      | -3.66%      |            |
  page_fault1_per_thread_ops  |             |             |            |
  (A) base                    | 242111.345  | 239737.000  | 10026.031  |
  (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
                              | -2.09%      | -1.85%      |            |
  page_fault1_scalability     |             |             |
  (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
  (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
                              | -1.16%      | -1.69%      |            |
  page_fault2_per_process_ops |             |             |
  (A) base                    | 203561.836  | 203301.000  | 2550.764   |
  (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
                              | -3.13%      | -2.73%      |            |
  page_fault2_per_thread_ops  |             |             |
  (A) base                    | 171046.473  | 170776.000  | 1509.679   |
  (B) patched                 | 166626.327  | 166406.000  | 768.753    |
                              | -2.58%      | -2.56%      |            |
  page_fault2_scalability     |             |             |
  (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
  (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
                              | -1.29%      | -1.41%      |            |
  page_fault3_per_process_ops |             |             |
  (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
  (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
                              | -1.56%      | -1.86%      |            |
  page_fault3_per_thread_ops  |             |             |
  (A) base                    | 391234.164  | 390860.000  | 1760.720   |
  (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
                              | -3.58%      | -3.71%      |            |
  page_fault3_scalability     |             |             |
  (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
  (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
                              | +2.26%      | +2.45%      |            |

All regressions seem to be minimal, and within the normal variance for
the benchmark. The fix for [1] assumes that 3% is noise -- and there were n=
o
further practical complaints), so hopefully this means that such variations
in these microbenchmarks do not reflect on practical workloads.

(3) I also ran stress-ng in a nested cgroup and did not observe any
obvious regressions.

[1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/
