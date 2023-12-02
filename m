Return-Path: <cgroups+bounces-775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0A801B2F
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 08:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683D5281D2E
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978BBE65;
	Sat,  2 Dec 2023 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGhXVd5+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC41A6
	for <cgroups@vger.kernel.org>; Fri,  1 Dec 2023 23:48:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2859d83dfafso3075688a91.3
        for <cgroups@vger.kernel.org>; Fri, 01 Dec 2023 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701503332; x=1702108132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cvKzBKJavSflUIGtTrRq6X4172jeqPmi1cK5nCNC7Y=;
        b=lGhXVd5+RahfUqzurtlTdrVFm5U3IByq92y6SIjGEd1lZxPBIA0tcEAUSkESnXfxnI
         +C19ltlTdNoJCH7svAtp2/TdRVVB1b8KzLCGWr6b7s44p+a5s9cIhLL6uI+H9H8n65fq
         H77ZU5dD7kdkouAPIuFLAPoXGo30K9E6dRrXJ8gduvpRf4J6yOOaVdzVmccylX2yVl6R
         Qm9L8M/ds5NmI+TJBS5/2k9yfg8Rk0eF3dfN2SMXnzzWVIXmXRtXYz8mjm7+vWpe5JyJ
         Dl/6Ynj2NfI04T369q/FpRx3eTqNFAfJL8NZW9CPtKdzSB8fRm1LG7BVqXmTuuLZoIB4
         993g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701503332; x=1702108132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cvKzBKJavSflUIGtTrRq6X4172jeqPmi1cK5nCNC7Y=;
        b=QFOik9XnNyjQw/Pf5ntZFCinFvq+GrWJfETY9JPWykz9gV22DV8IkFXfAfAS9Tr3bI
         irRJx3xd76yiXdgIlPGu2p/MnndF88SC6QS/sOsooiQa5rThPVXz4ikPGV+nblgq7VIv
         OxTHknGCSbK8pMwJkyNbm3VMcPaW/YV2GQHOMhLzMuLcEDErWF+3rIenE8GQap4Y43Vn
         1XsfCOcEJhU9NC/CaZnf71vQqtqazhyGClrtPVtmHudR9tFJqf5CqhgHrpmjwroXgzRA
         gKtZJ8qkxM0KZdKS4wSTlQ5MLnlFsm1Gt5S89om2r7iI0Sw3K1K5AXfVB8/3FuKNzlPh
         rCkg==
X-Gm-Message-State: AOJu0YxRq+aA0JexjnAqJefPwu2LV8sRdJJGFWQBz+akAePvrZvKPOJB
	TGBc4WFHEbQboD8pxcfGskMrS+cBAHlllw==
X-Google-Smtp-Source: AGHT+IG1Jy6ieBWta9B6ASl+QwRtTxB5bmORWCEanuGe38otdWoA6VC0CHHpj+C//1Xxl1xNHpZWcl9Tip2YiA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:a18:0:b0:5c2:2b59:5e6c with SMTP id
 24-20020a630a18000000b005c22b595e6cmr4154075pgk.1.1701503332400; Fri, 01 Dec
 2023 23:48:52 -0800 (PST)
Date: Sat, 2 Dec 2023 07:48:50 +0000
In-Reply-To: <20231129032154.3710765-4-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com> <20231129032154.3710765-4-yosryahmed@google.com>
Message-ID: <20231202074850.aisqdvyc5u2kth6r@google.com>
Subject: Re: [mm-unstable v4 3/5] mm: memcg: make stats flushing threshold per-memcg
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 03:21:51AM +0000, Yosry Ahmed wrote:
> A global counter for the magnitude of memcg stats update is maintained
> on the memcg side to avoid invoking rstat flushes when the pending
> updates are not significant. This avoids unnecessary flushes, which are
> not very cheap even if there isn't a lot of stats to flush. It also
> avoids unnecessary lock contention on the underlying global rstat lock.
> 
> Make this threshold per-memcg. The scheme is followed where percpu (now
> also per-memcg) counters are incremented in the update path, and only
> propagated to per-memcg atomics when they exceed a certain threshold.
> 
> This provides two benefits:
> (a) On large machines with a lot of memcgs, the global threshold can be
> reached relatively fast, so guarding the underlying lock becomes less
> effective. Making the threshold per-memcg avoids this.
> 
> (b) Having a global threshold makes it hard to do subtree flushes, as we
> cannot reset the global counter except for a full flush. Per-memcg
> counters removes this as a blocker from doing subtree flushes, which
> helps avoid unnecessary work when the stats of a small subtree are
> needed.
> 
> Nothing is free, of course. This comes at a cost:
> (a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4
> bytes. The extra memory usage is insigificant.
> 
> (b) More work on the update side, although in the common case it will
> only be percpu counter updates. The amount of work scales with the
> number of ancestors (i.e. tree depth). This is not a new concept, adding
> a cgroup to the rstat tree involves a parent loop, so is charging.
> Testing results below show no significant regressions.
> 
> (c) The error margin in the stats for the system as a whole increases
> from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
> NR_MEMCGS. This is probably fine because we have a similar per-memcg
> error in charges coming from percpu stocks, and we have a periodic
> flusher that makes sure we always flush all the stats every 2s anyway.
> 
> This patch was tested to make sure no significant regressions are
> introduced on the update path as follows. The following benchmarks were
> ran in a cgroup that is 2 levels deep (/sys/fs/cgroup/a/b/):
> 
> (1) Running 22 instances of netperf on a 44 cpu machine with
> hyperthreading disabled. All instances are run in a level 2 cgroup, as
> well as netserver:
>   # netserver -6
>   # netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> 
> Averaging 20 runs, the numbers are as follows:
> Base: 40198.0 mbps
> Patched: 38629.7 mbps (-3.9%)
> 
> The regression is minimal, especially for 22 instances in the same
> cgroup sharing all ancestors (so updating the same atomics).
> 
> (2) will-it-scale page_fault tests. These tests (specifically
> per_process_ops in page_fault3 test) detected a 25.9% regression before
> for a change in the stats update path [1]. These are the
> numbers from 10 runs (+ is good) on a machine with 256 cpus:
> 
>              LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
> ------------------------------+-------------+-------------+-------------
>   page_fault1_per_process_ops |             |             |            |
>   (A) base                    | 270249.164  | 265437.000  | 13451.836  |
>   (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
>                               | -3.29%      | -3.66%      |            |
>   page_fault1_per_thread_ops  |             |             |            |
>   (A) base                    | 242111.345  | 239737.000  | 10026.031  |
>   (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
>                               | -2.09%      | -1.85%      |            |
>   page_fault1_scalability     |             |             |
>   (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
>   (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
>                               | -1.16%      | -1.69%      |            |
>   page_fault2_per_process_ops |             |             |
>   (A) base                    | 203561.836  | 203301.000  | 2550.764   |
>   (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
>                               | -3.13%      | -2.73%      |            |
>   page_fault2_per_thread_ops  |             |             |
>   (A) base                    | 171046.473  | 170776.000  | 1509.679   |
>   (B) patched                 | 166626.327  | 166406.000  | 768.753    |
>                               | -2.58%      | -2.56%      |            |
>   page_fault2_scalability     |             |             |
>   (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
>   (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
>                               | -1.29%      | -1.41%      |            |
>   page_fault3_per_process_ops |             |             |
>   (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
>   (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
>                               | -1.56%      | -1.86%      |            |
>   page_fault3_per_thread_ops  |             |             |
>   (A) base                    | 391234.164  | 390860.000  | 1760.720   |
>   (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
>                               | -3.58%      | -3.71%      |            |
>   page_fault3_scalability     |             |             |
>   (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
>   (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
>                               | +2.26%      | +2.45%      |            |
> 
> All regressions seem to be minimal, and within the normal variance for
> the benchmark. The fix for [1] assumes that 3% is noise -- and there
> were no further practical complaints), so hopefully this means that such
> variations in these microbenchmarks do not reflect on practical
> workloads.
> 
> (3) I also ran stress-ng in a nested cgroup and did not observe any
> obvious regressions.
> 
> [1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

