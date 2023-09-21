Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4447AA0C4
	for <lists+cgroups@lfdr.de>; Thu, 21 Sep 2023 22:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjIUUs2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Sep 2023 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjIUUsO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Sep 2023 16:48:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A657B45F
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 10:50:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3216ba1b01eso1241075f8f.2
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318631; x=1695923431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cl15FReM+0BOvrBRx7ZaDFvWKYaZDzCR+8xQoQoeQk=;
        b=rfWKokqEceL8xygObJ2tG6Z3G+Bn222vbZ6+kd+diBffjgc/KZoOP1oL1hbTXd5mkW
         R/6JdL5kVQP2sIYWFNE8pH8ZFasZZldVhMqVbML3ZIGyyHB1gEiI3HLT7Dy99aGFYDwQ
         zsJymDVYmMOceERsEUSxcUnXapuL61U+r3sTlvVDFEMCvrYV06adkLBkIuJNEg0KfdJF
         PH2oR/kOnswUdZMhUeEoY2bSMBn1cg7fxGycpuf+nVus1LLigwQ7BleyRybrKDtxYsKz
         NVenQ0EpR0Jtwo+ZbQHjlMNOcT6IZn/2Aj40uT0SuCXJyJ21MoDfT/RD/CjzLrQlvUSa
         abfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318631; x=1695923431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Cl15FReM+0BOvrBRx7ZaDFvWKYaZDzCR+8xQoQoeQk=;
        b=Kl24eL/F1muiU9mi9BXoYnIaC3Q3XN+huB8w+2wCyC3BwQVGCbxwYUS2rqGV1mOwKr
         JtlS/4+LXM0OXYfhtEu4ZDzxabbRYJveQWFbeewkPXZ7o0vuL08T0LQ+zvnYX2oAn5wf
         59JaaLHK7jxVt6J2hTcBlXxLkyN0XvKeQeOIy0d4SddJS0C1Vc3F8uJuE/iOu1dnrEPN
         hsKqOIg/mabk+pUGleAepy33CH52nYoTHaQXOZv+nl5IKQlZKN6juv86eaPMA3PdMfRI
         npCO7begIjcrldyHgYvIogvFL9LLigqu92E73BC89I64Jc2RU/4LDTuI4NaGVTiMw5mc
         3hjA==
X-Gm-Message-State: AOJu0YzdPPtoTQdsLXhRWR8U3ITj3p03aqlRrFU7Xgu7oUgjXOfChlwg
        NOMhJDXcsY9hQMhiKJ5UZqPlMq4afHfHdE27vQxKMb2WA2OS+YMeKhM=
X-Google-Smtp-Source: AGHT+IHRXu+qQsgMk8i/pqSEscfhp/KwvJHJJu8f+ujgpgcmtBn6YNtHGfK16HPFoLtaZY9/THdAkg9SzWdjU4yq9sU=
X-Received: by 2002:a17:906:5dce:b0:9ae:406c:3425 with SMTP id
 p14-20020a1709065dce00b009ae406c3425mr4180099ejv.0.1695284043103; Thu, 21 Sep
 2023 01:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com> <20230921081057.3440885-4-yosryahmed@google.com>
In-Reply-To: <20230921081057.3440885-4-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 21 Sep 2023 01:13:23 -0700
Message-ID: <CAJD7tkabLAwg6D1xfc=+eQZm7Xpp+76KgVyJo8vS2teFeyDAjg@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
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
>
> [1]https://github.com/google/neper
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>


Johannes, I think this might be what you have suggested in our
previous discussion, but I am not sure this is what you meant for the
update path, so I did not add a Suggested-by. Please let me know if
this is what you meant and I can amend the tag as such.

>
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
