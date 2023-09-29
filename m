Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE97B3AD9
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjI2T54 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjI2T5z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 15:57:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D581B1
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 12:57:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so15527254a12.0
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696017471; x=1696622271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX+aHywiZMh6T5hoOwSERB1HwKBANBNMXzRrSH3p0ZA=;
        b=rcAT1UwpetFkyHIaBhgqb0g8+H8iIiaupIaMD05EFgeEsDzgJKmIh2pEJSuEVysN2P
         seMcayPT9pFAajaDBvfAJ00pFpaeF9Tiufjl1bcIFrhO5f+WanDZT1kA0pnoIPyHFMwP
         GPV9ISzCboojjfHO2iWzq3z03aEogKE6foSwTrbAq95BXUpiGU8cA1RjEQojlNje7QUv
         st8q/S7wIbc0DsxkuKqw7B3yQiyrvGVRIdtw9V00RtftCOD23pPUYaBdduUiO+2og0B3
         3ICPC2+JhIDvdYWQuimwh6Ap3SJ+UL3kSyBrotnHSL1tfKWrm1eMi9efcnHU4cMhIDEK
         QxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017471; x=1696622271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX+aHywiZMh6T5hoOwSERB1HwKBANBNMXzRrSH3p0ZA=;
        b=fki6M+8BhRoYcslMoCQYxJ1fJKIKtVatDWegWKjnysWhXtIXXmqR7gbpeFZkiYpklh
         3NRZxLHE5AwkFelTSWuoc22JrMvPBxh238xNBAbDcO8lpZb+yRC6Z5xDsnjgIq1lVTCG
         yLxYf4sSY+/denYvZ/hmtIu6eeJkIZxwPSjEy1Y4sjvraMfhzGjfQJnP7qPVGEJypJTI
         NP0P6n95lPYIsVrFEfvWcyoeDqxOoIpOvzgRLuRAyqBORJDwSum+ZyiI/uW7wJh4M3re
         vJDcPJ51FBgZ4dwpwO/3TI0/+6A3dsBJ2p0G52ObnaxX9i0K8YDGcbo+hDS00iunrs6V
         Agaw==
X-Gm-Message-State: AOJu0YxI6v8JDWsT1vmwoblT3X3TOaX+xN+PeppAhmPgo/DEKCp/gYLZ
        Oi2HvsnxxSbTDSx311OwNVNL8OniEUt+veEwkQaEfg==
X-Google-Smtp-Source: AGHT+IGBdBZkLvIP/9LW+Pq1BoJs/7CGzbdYGFWlPNMYHs+EprIEAtfeUnNnT8PIVWtkUsVtEhfKAjh+c1zuW32SOow=
X-Received: by 2002:a17:906:8468:b0:9a1:cdf1:ba6 with SMTP id
 hx8-20020a170906846800b009a1cdf10ba6mr3591377ejc.12.1696017470768; Fri, 29
 Sep 2023 12:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com> <20230921081057.3440885-4-yosryahmed@google.com>
In-Reply-To: <20230921081057.3440885-4-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 29 Sep 2023 12:57:11 -0700
Message-ID: <CAJD7tkYhg_mini5cEZq9SkkwOkThO77D=dbd=uW3NxJOE_b9kw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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

On Thu, Sep 21, 2023 at 1:11=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
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
> bytes.
>
> (b) More work on the update side, although in the common case it will
> only be percpu counter updates. The amount of work scales with the
> number of ancestors (i.e. tree depth). This is not a new concept, adding
> a cgroup to the rstat tree involves a parent loop, so is charging.
> Testing in a later patch shows this doesn't introduce significant
> regressions.
>
> (c) The error margin in the stats for the system as a whole increases
> from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
> NR_MEMCGS. This is probably fine because we have a similar per-memcg
> error in charges coming from percpu stocks, and we have a periodic
> flusher that makes sure we always flush all the stats every 2s anyway.
>
> This patch was tested to make sure no significant regressions are
> introduced on the update path as follows. In a cgroup that is 4 levels
> deep (/sys/fs/cgroup/a/b/c/d), the following benchmarks were ran:
>
> (a) neper [1] with 1000 flows and 100 threads (single machine). The
> values in the table are the average of server and client throughputs in
> mbps after 30 iterations, each running for 30s:
>
>                                 tcp_rr          tcp_stream
> Base                            9504218.56      357366.84
> Patched                         9656205.68      356978.39
> Delta                           +1.6%           -0.1%
> Standard Deviation              0.95%           1.03%
>
> An increase in the performance of tcp_rr doesn't really make sense, but
> it's probably in the noise. The same tests were ran with 1 flow and 1
> thread but the throughput was too noisy to make any conclusions (the
> averages did not show regressions nonetheless).
>
> Looking at perf for one iteration of the above test, __mod_memcg_state()
> (which is where memcg_rstat_updated() is called) does not show up at all
> without this patch, but it shows up with this patch as 1.06% for tcp_rr
> and 0.36% for tcp_stream.
>
> (b) Running "stress-ng --vm 0 -t 1m --times --perf". I don't understand
> stress-ng very well, so I am not sure that's the best way to test this,
> but it spawns 384 workers and spits a lot of metrics which looks nice :)
> I picked a few ones that seem to be relevant to the stats update path. I
> also included cache misses as this patch introduce more atomics that may
> bounce between cpu caches:
>
> Metric                  Base            Patched         Delta
> Cache Misses            3.394 B/sec     3.433 B/sec     +1.14%
> Cache L1D Read          0.148 T/sec     0.154 T/sec     +4.05%
> Cache L1D Read Miss     20.430 B/sec    21.820 B/sec    +6.8%
> Page Faults Total       4.304 M/sec     4.535 M/sec     +5.4%
> Page Faults Minor       4.304 M/sec     4.535 M/sec     +5.4%
> Page Faults Major       18.794 /sec     0.000 /sec
> Kmalloc                 0.153 M/sec     0.152 M/sec     -0.65%
> Kfree                   0.152 M/sec     0.153 M/sec     +0.65%
> MM Page Alloc           4.640 M/sec     4.898 M/sec     +5.56%
> MM Page Free            4.639 M/sec     4.897 M/sec     +5.56%
> Lock Contention Begin   0.362 M/sec     0.479 M/sec     +32.32%
> Lock Contention End     0.362 M/sec     0.479 M/sec     +32.32%
> page-cache add          238.057 /sec    0.000 /sec
> page-cache del          6.265 /sec      6.267 /sec      -0.03%
>
> This is only using a single run in each case. I am not sure what to
> make out of most of these numbers, but they mostly seem in the noise
> (some better, some worse). The lock contention numbers are interesting.
> I am not sure if higher is better or worse here. No new locks or lock
> sections are introduced by this patch either way.
>
> Looking at perf, __mod_memcg_state() shows up as 0.00% with and without
> this patch. This is suspicious, but I verified while stress-ng is
> running that all the threads are in the right cgroup.

Here is some additional testing. will-it-scale (specifically
per_process_ops in page_fault3 test) detected a 25.9% regression
before for a change in the stats update path, so I thought it would be
a good idea to run the numbers with this change. I ran all page_fault
tests in will-it-scale in a cgroup nested in a 4th level
($ROOT/a/b/c/d), as the work here scales with nesting, and 4 levels
under root seemed like a worst-ish case scenario. These are the
numbers from 30 runs (+ is good):

             LABEL            |     MIN     |     MAX     |    MEAN
 |   MEDIAN    |   STDDEV   |
------------------------------+-------+-------------+-------------+--------=
-----+-------------+------------+
  page_fault1_per_process_ops |             |             |
 |             |            |
  (A) base                    | 250644.000  | 298351.000  | 265207.738
 | 262941.000  | 12112.379  |
  (B) patched                 | 235885.000  | 276680.000  | 249249.191
 | 248781.000  | 8767.457   |
                              | -5.89%      | -7.26%      | -6.02%
 | -5.39%      |            |
  page_fault1_per_thread_ops  |             |             |
 |             |            |
  (A) base                    | 227214.000  | 271539.000  | 241618.484
 | 240209.000  | 10162.207  |
  (B) patched                 | 220156.000  | 248552.000  | 229820.671
 | 229108.000  | 7506.582   |
                              | -3.11%      | -8.47%      | -4.88%
 | -4.62%      |            |
  page_fault1_scalability     |             |             |
 |             |            |
  (A) base                    | 0.031175    | 0.038742    | 0.03545
 | 0.035705    | 0.0015837  |
  (B) patched                 | 0.026511    | 0.032529    | 0.029952
 | 0.029957    | 0.0013551  |
                              | -9.65%      | -9.21%      | -9.29%
 | -9.35%     |            |
  page_fault2_per_process_ops |             |             |
 |             |            |
  (A) base                    | 197948.000  | 209020.000  | 203916.148
 | 203496.000  | 2908.331   |
  (B) patched                 | 183825.000  | 192870.000  | 186975.419
 | 187023.000  | 1991.100   |
                              | -6.67%      | -6.80%      | -6.85%
 | -6.90%      |            |
  page_fault2_per_thread_ops  |             |             |
 |             |            |
  (A) base                    | 166563.000  | 174843.000  | 170604.972
 | 170532.000  | 1624.834   |
  (B) patched                 | 161051.000  | 165887.000  | 163100.260
 | 163263.000  | 1517.967   |
                              | -3.31%      | -5.12%      | -4.40%
 | -4.26%      |            |
  page_fault2_scalability     |             |             |
 |             |            |
  (A) base                    | 0.052992    | 0.056427    | 0.054603
 | 0.054693    | 0.00080196 |
  (B) patched                 | 0.042582    | 0.046753    | 0.044882
 | 0.044957    | 0.0011766  |
                              | +2.74%      | -0.44%      | -0.05%
 | +0.33%     |            |
  page_fault3_per_process_ops |             |             |
 |             |            |
  (A) base                    | 1282706.000 | 1323143.000 |
1299821.099 | 1297918.000 | 9882.872   |
  (B) patched                 | 1232512.000 | 1269816.000 |
1248700.839 | 1247168.000 | 8454.891   |
                              | -3.91%      | -4.03%      | -3.93%
 | -3.91%      |            |
  page_fault3_per_thread_ops  |             |             |
 |             |            |
  (A) base                    | 383583.000  | 390303.000  | 387216.963
 | 387115.000  | 1605.760   |
  (B) patched                 | 363791.000  | 373960.000  | 368538.213
 | 368826.000  | 1852.594   |
                              | -5.16%      | -4.19%      | -4.82%
 | -4.72%      |            |
  page_fault3_scalability     |             |             |
 |             |            |
  (A) base                    | 0.58206     | 0.62882     | 0.59909
 | 0.59367     | 0.01256    |
  (B) patched                 | 0.57967     | 0.62165     | 0.59995
 | 0.59769     | 0.010088   |
                              | -0.41%      | -1.14%      | +0.14%
 | +0.68%      |            |

Most numbers are within the range of normal variation of this
benchmark results or within the standard deviation (especially that
the fix for [1] assumes that 3% is noise -- and there were no further
practical complaints). These numbers are also from 4-level nesting,
which is more than most standard setups in my experience.


[1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/

>
> [1]https://github.com/google/neper
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/memcontrol.c | 49 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ef7ad66a9e4c..c273c65bb642 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -627,6 +627,9 @@ struct memcg_vmstats_percpu {
>         /* Cgroup1: threshold notifications & softlimit tree updates */
>         unsigned long           nr_page_events;
>         unsigned long           targets[MEM_CGROUP_NTARGETS];
> +
> +       /* Stats updates since the last flush */
> +       unsigned int            stats_updates;
>  };
>
>  struct memcg_vmstats {
> @@ -641,6 +644,9 @@ struct memcg_vmstats {
>         /* Pending child counts during tree propagation */
>         long                    state_pending[MEMCG_NR_STAT];
>         unsigned long           events_pending[NR_MEMCG_EVENTS];
> +
> +       /* Stats updates since the last flush */
> +       atomic64_t              stats_updates;
>  };
>
>  /*
> @@ -660,9 +666,7 @@ struct memcg_vmstats {
>   */
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwor=
k);
> -static DEFINE_PER_CPU(unsigned int, stats_updates);
>  static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
> -static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
>  static u64 flush_last_time;
>
>  #define FLUSH_TIME (2UL*HZ)
> @@ -689,26 +693,37 @@ static void memcg_stats_unlock(void)
>         preempt_enable_nested();
>  }
>
> +
> +static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
> +{
> +       return atomic64_read(&memcg->vmstats->stats_updates) >
> +               MEMCG_CHARGE_BATCH * num_online_cpus();
> +}
> +
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val=
)
>  {
> +       int cpu =3D smp_processor_id();
>         unsigned int x;
>
>         if (!val)
>                 return;
>
> -       cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
> +       cgroup_rstat_updated(memcg->css.cgroup, cpu);
> +
> +       for (; memcg; memcg =3D parent_mem_cgroup(memcg)) {
> +               x =3D __this_cpu_add_return(memcg->vmstats_percpu->stats_=
updates,
> +                                         abs(val));
> +
> +               if (x < MEMCG_CHARGE_BATCH)
> +                       continue;
>
> -       x =3D __this_cpu_add_return(stats_updates, abs(val));
> -       if (x > MEMCG_CHARGE_BATCH) {
>                 /*
> -                * If stats_flush_threshold exceeds the threshold
> -                * (>num_online_cpus()), cgroup stats update will be trig=
gered
> -                * in __mem_cgroup_flush_stats(). Increasing this var fur=
ther
> -                * is redundant and simply adds overhead in atomic update=
.
> +                * If @memcg is already flush-able, increasing stats_upda=
tes is
> +                * redundant. Avoid the overhead of the atomic update.
>                  */
> -               if (atomic_read(&stats_flush_threshold) <=3D num_online_c=
pus())
> -                       atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_t=
hreshold);
> -               __this_cpu_write(stats_updates, 0);
> +               if (!memcg_should_flush_stats(memcg))
> +                       atomic64_add(x, &memcg->vmstats->stats_updates);
> +               __this_cpu_write(memcg->vmstats_percpu->stats_updates, 0)=
;
>         }
>  }
>
> @@ -727,13 +742,12 @@ static void do_flush_stats(void)
>
>         cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
>
> -       atomic_set(&stats_flush_threshold, 0);
>         atomic_set(&stats_flush_ongoing, 0);
>  }
>
>  void mem_cgroup_flush_stats(void)
>  {
> -       if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> +       if (memcg_should_flush_stats(root_mem_cgroup))
>                 do_flush_stats();
>  }
>
> @@ -747,8 +761,8 @@ void mem_cgroup_flush_stats_ratelimited(void)
>  static void flush_memcg_stats_dwork(struct work_struct *w)
>  {
>         /*
> -        * Always flush here so that flushing in latency-sensitive paths =
is
> -        * as cheap as possible.
> +        * Deliberately ignore memcg_should_flush_stats() here so that fl=
ushing
> +        * in latency-sensitive paths is as cheap as possible.
>          */
>         do_flush_stats();
>         queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_T=
IME);
> @@ -5622,6 +5636,9 @@ static void mem_cgroup_css_rstat_flush(struct cgrou=
p_subsys_state *css, int cpu)
>                         }
>                 }
>         }
> +       /* We are in a per-cpu loop here, only do the atomic write once *=
/
> +       if (atomic64_read(&memcg->vmstats->stats_updates))
> +               atomic64_set(&memcg->vmstats->stats_updates, 0);
>  }
>
>  #ifdef CONFIG_MMU
> --
> 2.42.0.459.ge4e396fd5e-goog
>
