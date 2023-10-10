Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB387C43AB
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 00:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjJJWWb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjJJWWa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 18:22:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350E98
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 15:22:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ad810be221so1046144266b.2
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976546; x=1697581346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9ytv1y2yvSa4MvbD/ZRdqp1EA4N80KA40csq2dEErQ=;
        b=cGQNz3qBuGwIL0oWollP/UdGwjV7RCie2FXDlhQvit8a8pXDdaOigVznTKUKXd034E
         5wa0wac7XnK8vc2zqZa4C6YjObiL7e3q9DtzlTqxFs/lXXNWNiuPpEkXLg/dlkY8qCn7
         2FKWGRlm9l9wBL1w7viVC4H7knpAv9am9OHzmYwYJYkJtXJc7lziz/3itrTDO0q/pNZS
         VAI5A9vR4KVZdOYw8njVJaP+5dMXd3LtAa88G+xf8voexP3z0pUf5BBduCgc23vHV8ii
         xsIvmdBZnNf8oWCtWraxRT+hS0PcS8zbW2LUYn4mE76PfHpOSa+kerIfIjycArp8CTM6
         7i7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976546; x=1697581346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9ytv1y2yvSa4MvbD/ZRdqp1EA4N80KA40csq2dEErQ=;
        b=NtVz6zVCVxLCnK7m7s4gcbbvs6IXTayPOrRI8OJVV4fhwfPMnA0/OoA2xXGwTG3CFd
         NilHsbTcWRXdKUGD+qlrUYvtQDfuxbY2ueLhcYWsteo8yBf3WU1ZqzQJUBlviHIfOMJJ
         +j6UIDpcjYjkG1WTcKs3iJy9aCBn7FzWf6MADIkJZYDBwcwS+NQoO7REcoTPhzPPxgWu
         EUI1RMjmIt7GXjQdd+M91UuMk1eI5Sh9iGCXQnjD1gA/lbOKDfRo/egNmozNB1aHznYY
         KBY/S11fEoz36ay868q4hBCpDEL++2fjaGf2NRGff+JYToxu2tERTJc+Bupf/N+Am3PG
         ZfZw==
X-Gm-Message-State: AOJu0Yz0MZ76gP0dVKcRmq0LPTLmPRp1szSEh0gnnJAh4Jnggw+Aurwx
        DU/tqzgxpdRIY8oA9Em6PdQxDsYbNQI2Qk1fsg+QMQ==
X-Google-Smtp-Source: AGHT+IGiBCpXck43PPvlJ3+rqPaZEMLPOQYkkdbd1Jrk+SG9At/A+vBYi5VVZg79jP3TkAytynbWMp6WW63no4Z9iIY=
X-Received: by 2002:a17:906:5349:b0:9b2:8b14:7a20 with SMTP id
 j9-20020a170906534900b009b28b147a20mr18547846ejo.45.1696976546026; Tue, 10
 Oct 2023 15:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
In-Reply-To: <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 10 Oct 2023 15:21:47 -0700
Message-ID: <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 2:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 10, 2023 at 1:45=E2=80=AFPM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Mon, Oct 9, 2023 at 8:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > A global counter for the magnitude of memcg stats update is maintaine=
d
> > > on the memcg side to avoid invoking rstat flushes when the pending
> > > updates are not significant. This avoids unnecessary flushes, which a=
re
> > > not very cheap even if there isn't a lot of stats to flush. It also
> > > avoids unnecessary lock contention on the underlying global rstat loc=
k.
> > >
> > > Make this threshold per-memcg. The scheme is followed where percpu (n=
ow
> > > also per-memcg) counters are incremented in the update path, and only
> > > propagated to per-memcg atomics when they exceed a certain threshold.
> > >
> > > This provides two benefits:
> > > (a) On large machines with a lot of memcgs, the global threshold can =
be
> > > reached relatively fast, so guarding the underlying lock becomes less
> > > effective. Making the threshold per-memcg avoids this.
> > >
> > > (b) Having a global threshold makes it hard to do subtree flushes, as=
 we
> > > cannot reset the global counter except for a full flush. Per-memcg
> > > counters removes this as a blocker from doing subtree flushes, which
> > > helps avoid unnecessary work when the stats of a small subtree are
> > > needed.
> > >
> > > Nothing is free, of course. This comes at a cost:
> > > (a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * =
4
> > > bytes. The extra memory usage is insigificant.
> > >
> > > (b) More work on the update side, although in the common case it will
> > > only be percpu counter updates. The amount of work scales with the
> > > number of ancestors (i.e. tree depth). This is not a new concept, add=
ing
> > > a cgroup to the rstat tree involves a parent loop, so is charging.
> > > Testing results below show no significant regressions.
> > >
> > > (c) The error margin in the stats for the system as a whole increases
> > > from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
> > > NR_MEMCGS. This is probably fine because we have a similar per-memcg
> > > error in charges coming from percpu stocks, and we have a periodic
> > > flusher that makes sure we always flush all the stats every 2s anyway=
.
> > >
> > > This patch was tested to make sure no significant regressions are
> > > introduced on the update path as follows. The following benchmarks we=
re
> > > ran in a cgroup that is 4 levels deep (/sys/fs/cgroup/a/b/c/d), which=
 is
> > > deeper than a usual setup:
> > >
> > > (a) neper [1] with 1000 flows and 100 threads (single machine). The
> > > values in the table are the average of server and client throughputs =
in
> > > mbps after 30 iterations, each running for 30s:
> > >
> > >                                 tcp_rr          tcp_stream
> > > Base                            9504218.56      357366.84
> > > Patched                         9656205.68      356978.39
> > > Delta                           +1.6%           -0.1%
> > > Standard Deviation              0.95%           1.03%
> > >
> > > An increase in the performance of tcp_rr doesn't really make sense, b=
ut
> > > it's probably in the noise. The same tests were ran with 1 flow and 1
> > > thread but the throughput was too noisy to make any conclusions (the
> > > averages did not show regressions nonetheless).
> > >
> > > Looking at perf for one iteration of the above test, __mod_memcg_stat=
e()
> > > (which is where memcg_rstat_updated() is called) does not show up at =
all
> > > without this patch, but it shows up with this patch as 1.06% for tcp_=
rr
> > > and 0.36% for tcp_stream.
> > >
> > > (b) "stress-ng --vm 0 -t 1m --times --perf". I don't understand
> > > stress-ng very well, so I am not sure that's the best way to test thi=
s,
> > > but it spawns 384 workers and spits a lot of metrics which looks nice=
 :)
> > > I picked a few ones that seem to be relevant to the stats update path=
. I
> > > also included cache misses as this patch introduce more atomics that =
may
> > > bounce between cpu caches:
> > >
> > > Metric                  Base            Patched         Delta
> > > Cache Misses            3.394 B/sec     3.433 B/sec     +1.14%
> > > Cache L1D Read          0.148 T/sec     0.154 T/sec     +4.05%
> > > Cache L1D Read Miss     20.430 B/sec    21.820 B/sec    +6.8%
> > > Page Faults Total       4.304 M/sec     4.535 M/sec     +5.4%
> > > Page Faults Minor       4.304 M/sec     4.535 M/sec     +5.4%
> > > Page Faults Major       18.794 /sec     0.000 /sec
> > > Kmalloc                 0.153 M/sec     0.152 M/sec     -0.65%
> > > Kfree                   0.152 M/sec     0.153 M/sec     +0.65%
> > > MM Page Alloc           4.640 M/sec     4.898 M/sec     +5.56%
> > > MM Page Free            4.639 M/sec     4.897 M/sec     +5.56%
> > > Lock Contention Begin   0.362 M/sec     0.479 M/sec     +32.32%
> > > Lock Contention End     0.362 M/sec     0.479 M/sec     +32.32%
> > > page-cache add          238.057 /sec    0.000 /sec
> > > page-cache del          6.265 /sec      6.267 /sec      -0.03%
> > >
> > > This is only using a single run in each case. I am not sure what to
> > > make out of most of these numbers, but they mostly seem in the noise
> > > (some better, some worse). The lock contention numbers are interestin=
g.
> > > I am not sure if higher is better or worse here. No new locks or lock
> > > sections are introduced by this patch either way.
> > >
> > > Looking at perf, __mod_memcg_state() shows up as 0.00% with and witho=
ut
> > > this patch. This is suspicious, but I verified while stress-ng is
> > > running that all the threads are in the right cgroup.
> > >
> > > (3) will-it-scale page_fault tests. These tests (specifically
> > > per_process_ops in page_fault3 test) detected a 25.9% regression befo=
re
> > > for a change in the stats update path [2]. These are the
> > > numbers from 30 runs (+ is good):
> > >
> > >              LABEL            |     MEAN    |   MEDIAN    |   STDDEV =
  |
> > > ------------------------------+-------------+-------------+----------=
---
> > >   page_fault1_per_process_ops |             |             |          =
  |
> > >   (A) base                    | 265207.738  | 262941.000  | 12112.379=
  |
> > >   (B) patched                 | 249249.191  | 248781.000  | 8767.457 =
  |
> > >                               | -6.02%      | -5.39%      |          =
  |
> > >   page_fault1_per_thread_ops  |             |             |          =
  |
> > >   (A) base                    | 241618.484  | 240209.000  | 10162.207=
  |
> > >   (B) patched                 | 229820.671  | 229108.000  | 7506.582 =
  |
> > >                               | -4.88%      | -4.62%      |          =
  |
> > >   page_fault1_scalability     |             |             |
> > >   (A) base                    | 0.03545     | 0.035705    | 0.0015837=
  |
> > >   (B) patched                 | 0.029952    | 0.029957    | 0.0013551=
  |
> > >                               | -9.29%      | -9.35%      |          =
  |
> >
> > This much regression is not acceptable.
> >
> > In addition, I ran netperf with the same 4 level hierarchy as you have
> > run and I am seeing ~11% regression.
>
> Interesting, I thought neper and netperf should be similar. Let me try
> to reproduce this.
>
> Thanks for testing!
>
> >
> > More specifically on a machine with 44 CPUs (HT disabled ixion machine)=
:
> >
> > # for server
> > $ netserver -6
> >
> > # 22 instances of netperf clients
> > $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> >
> > (averaged over 4 runs)
> >
> > base (next-20231009): 33081 MBPS
> > patched: 29267 MBPS
> >
> > So, this series is not acceptable unless this regression is resolved.

I tried this on a machine with 72 cpus (also ixion), running both
netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
# echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
# mkdir /sys/fs/cgroup/a
# echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
# mkdir /sys/fs/cgroup/a/b
# echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
# mkdir /sys/fs/cgroup/a/b/c
# echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
# mkdir /sys/fs/cgroup/a/b/c/d
# echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
# ./netserver -6

# echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
# for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE --
-m 10K; done

Base:
540000 262144 10240 60.00 54613.89
540000 262144 10240 60.00 54940.52
540000 262144 10240 60.00 55168.86
540000 262144 10240 60.00 54800.15
540000 262144 10240 60.00 54452.55
540000 262144 10240 60.00 54501.60
540000 262144 10240 60.00 55036.11
540000 262144 10240 60.00 52018.91
540000 262144 10240 60.00 54877.78
540000 262144 10240 60.00 55342.38

Average: 54575.275

Patched:
540000 262144 10240 60.00 53694.86
540000 262144 10240 60.00 54807.68
540000 262144 10240 60.00 54782.89
540000 262144 10240 60.00 51404.91
540000 262144 10240 60.00 55024.00
540000 262144 10240 60.00 54725.84
540000 262144 10240 60.00 51400.40
540000 262144 10240 60.00 54212.63
540000 262144 10240 60.00 51951.47
540000 262144 10240 60.00 51978.27

Average: 53398.295

That's ~2% regression. Did I do anything incorrectly?
