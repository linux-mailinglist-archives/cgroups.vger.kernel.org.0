Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74A7627CF
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 02:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGZAh0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 20:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGZAhZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 20:37:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05431995
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 17:37:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5221e2e69bdso5114925a12.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 17:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690331842; x=1690936642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj8uOQ1xFhK03A6y5unkx5o1F73Orlzpfqc5kQDwjHc=;
        b=xKnoP3BxZtdLidI1PCKarNGWJNWTE8yRAL9mnpHEoI5dPgGXx5McjtBjL9p7XYYL1W
         0ByVZdOKntHLDlNyOMaXno6hoPyJ6bUno1z8gWbZUvkUKI6I30Ev/8cbHbRaNTUbSORF
         nSpn5O0ZOZgXVPpTOApU4ce06qX4rLlnD/NhCTU6OAm06PnZ45fsCMdLFH4pGgikUi48
         3xueAYdeMu1BWhQQLUq6hLic6dHwbz9G1VAl5ETc79cTow9ZCxfPKfCdFl5qr5IA8YeV
         IoGxDVEtglitDQKwO+ZpWsDyoL8iPwbUNMN+H+10tB/r7YUdia2QSuL4f3k5xIQpaOE/
         /WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690331842; x=1690936642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj8uOQ1xFhK03A6y5unkx5o1F73Orlzpfqc5kQDwjHc=;
        b=GOD+Crc84Fblgu8IpHo6x8oK07GzEw3cyFDfDPrJana8QJxpDk0gIwCKwcSiKxytG/
         Ki9MSMTn1HaH99UArvsowvqWFKe13IAUpMo0iOz7Iiwg7+vE/CqD7PEJetLUVeZOppc9
         YbIOsNC75RyEWnEEEWNJwJ3audll3+20bxWPL68PJehiSmFH7cl1Na011ywIZ2MiRYhJ
         raCqLBBrpxA0a6/4r5kQP5J2CVrquHk8k6+ldwVKy6Uka9cyMizc3S9JWguZKw/U66ez
         7y6pl355DXhnp4dJm+guTy1bePPe6LgG8PM/ucm0gmD0/Zmr0WctUZa8tbEco3pfLJYU
         BG2Q==
X-Gm-Message-State: ABy/qLb3ZTTZbnbk5EA0ny3A/mXiZIXPdygT4/TfcoMmik+laJ10IWRN
        ZBkXM4uiDL/orijZtetbijK1fowbj7MLuYqJnTNatQ==
X-Google-Smtp-Source: APBJJlHDLczizjzV239PjazMIjInu33c/gMqALgI5baOCHHh2fPkrny9XpeAXG4B8MrktvjoHVtCH0gCbzcmg0BhFYc=
X-Received: by 2002:a17:906:8472:b0:99b:5161:8e0d with SMTP id
 hx18-20020a170906847200b0099b51618e0dmr261271ejc.21.1690331842179; Tue, 25
 Jul 2023 17:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230726002904.655377-1-yosryahmed@google.com> <20230726002904.655377-2-yosryahmed@google.com>
In-Reply-To: <20230726002904.655377-2-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Jul 2023 17:36:45 -0700
Message-ID: <CAJD7tkZK2T2ebOPw6K0M+YWyKUtx9bE2uyFj4VOehhd+fYnk8w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 25, 2023 at 5:29=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Currently, memcg uses rstat to maintain hierarchical stats. Counters are
> maintained for hierarchical stats at each memcg. Rstat tracks which
> cgroups have updates on which cpus to keep those counters fresh on the
> read-side.
>
> For non-hierarchical stats, we do not maintain counters. Instead, the
> percpu counters for a given stat need to be summed to get the
> non-hierarchical stat value. The original implementation did the same.
> At some point before rstat, non-hierarchical counters were introduced by
> commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> memory.stat reporting"). However, those counters were updated on the
> performance critical write-side, which caused regressions, so they were
> later removed by commit 815744d75152 ("mm: memcontrol: don't batch
> updates of local VM stats and events"). See [1] for more detailed
> history.
>
> Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a
> half) enjoyed cheap reads of non-hierarchical stats, specifically on
> cgroup v1. When moving to more recent kernels, a performance regression
> for reading non-hierarchical stats is observed.
>
> Now that we have rstat, we know exactly which percpu counters have
> updates for each stat. We can maintain non-hierarchical counters again,
> making reads much more efficient, without affecting the performance
> critical write-side. Hence, add non-hierarchical (i.e local) counters
> for the stats, and extend rstat flushing to keep those up-to-date.
>
> A caveat is that we now a stats flush before reading
> local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> or memcg_events_local(), where we previously only needed a flush to
> read hierarchical stats. Most contexts reading non-hierarchical stats
> are already doing a flush, add a flush to the only missing context in
> count_shadow_nodes().
>
> With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> machine with 256 cpus on cgroup v1:
>  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
>  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
>  real    0m0.125s
>  user    0m0.005s
>  sys     0m0.120s
>
> After:
>  real    0m0.032s
>  user    0m0.005s
>  sys     0m0.027s
>
> [1]https://lore.kernel.org/lkml/20230725201811.GA1231514@cmpxchg.org/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> ---
>
> v1 -> v2:
> - Rewrite the changelog based on the history context provided by
>   Johannes (Thanks!).
> - Fix a subtle bug where updating a local counter would be missed if it
>   was cancelled out by a pending update from child memcgs.


Johannes, I fixed a subtle bug here and I kept your Ack, I wasn't sure
what the Ack retention policy should be here. A quick look at the fix
would be great.

Thanks!

>
>
> ---
>  include/linux/memcontrol.h |  7 ++--
>  mm/memcontrol.c            | 67 +++++++++++++++++++++-----------------
>  mm/workingset.c            |  1 +
>  3 files changed, 43 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5818af8eca5a..a9f2861a57a5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -112,6 +112,9 @@ struct lruvec_stats {
>         /* Aggregated (CPU and subtree) state */
>         long state[NR_VM_NODE_STAT_ITEMS];
>
> +       /* Non-hierarchical (CPU aggregated) state */
> +       long state_local[NR_VM_NODE_STAT_ITEMS];
> +
>         /* Pending child counts during tree propagation */
>         long state_pending[NR_VM_NODE_STAT_ITEMS];
>  };
> @@ -1020,14 +1023,12 @@ static inline unsigned long lruvec_page_state_loc=
al(struct lruvec *lruvec,
>  {
>         struct mem_cgroup_per_node *pn;
>         long x =3D 0;
> -       int cpu;
>
>         if (mem_cgroup_disabled())
>                 return node_page_state(lruvec_pgdat(lruvec), idx);
>
>         pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -       for_each_possible_cpu(cpu)
> -               x +=3D per_cpu(pn->lruvec_stats_percpu->state[idx], cpu);
> +       x =3D READ_ONCE(pn->lruvec_stats.state_local[idx]);
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..50f8035e998a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -742,6 +742,10 @@ struct memcg_vmstats {
>         long                    state[MEMCG_NR_STAT];
>         unsigned long           events[NR_MEMCG_EVENTS];
>
> +       /* Non-hierarchical (CPU aggregated) page state & events */
> +       long                    state_local[MEMCG_NR_STAT];
> +       unsigned long           events_local[NR_MEMCG_EVENTS];
> +
>         /* Pending child counts during tree propagation */
>         long                    state_pending[MEMCG_NR_STAT];
>         unsigned long           events_pending[NR_MEMCG_EVENTS];
> @@ -775,11 +779,8 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int=
 idx, int val)
>  /* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, in=
t idx)
>  {
> -       long x =3D 0;
> -       int cpu;
> +       long x =3D READ_ONCE(memcg->vmstats->state_local[idx]);
>
> -       for_each_possible_cpu(cpu)
> -               x +=3D per_cpu(memcg->vmstats_percpu->state[idx], cpu);
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -926,16 +927,12 @@ static unsigned long memcg_events(struct mem_cgroup=
 *memcg, int event)
>
>  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int ev=
ent)
>  {
> -       long x =3D 0;
> -       int cpu;
>         int index =3D memcg_events_index(event);
>
>         if (index < 0)
>                 return 0;
>
> -       for_each_possible_cpu(cpu)
> -               x +=3D per_cpu(memcg->vmstats_percpu->events[index], cpu)=
;
> -       return x;
> +       return READ_ONCE(memcg->vmstats->events_local[index]);
>  }
>
>  static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
> @@ -5526,7 +5523,7 @@ static void mem_cgroup_css_rstat_flush(struct cgrou=
p_subsys_state *css, int cpu)
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
>         struct mem_cgroup *parent =3D parent_mem_cgroup(memcg);
>         struct memcg_vmstats_percpu *statc;
> -       long delta, v;
> +       long delta, delta_cpu, v;
>         int i, nid;
>
>         statc =3D per_cpu_ptr(memcg->vmstats_percpu, cpu);
> @@ -5542,19 +5539,23 @@ static void mem_cgroup_css_rstat_flush(struct cgr=
oup_subsys_state *css, int cpu)
>                         memcg->vmstats->state_pending[i] =3D 0;
>
>                 /* Add CPU changes on this level since the last flush */
> +               delta_cpu =3D 0;
>                 v =3D READ_ONCE(statc->state[i]);
>                 if (v !=3D statc->state_prev[i]) {
> -                       delta +=3D v - statc->state_prev[i];
> +                       delta_cpu =3D v - statc->state_prev[i];
> +                       delta +=3D delta_cpu;
>                         statc->state_prev[i] =3D v;
>                 }
>
> -               if (!delta)
> -                       continue;
> -
>                 /* Aggregate counts on this level and propagate upwards *=
/
> -               memcg->vmstats->state[i] +=3D delta;
> -               if (parent)
> -                       parent->vmstats->state_pending[i] +=3D delta;
> +               if (delta_cpu)
> +                       memcg->vmstats->state_local[i] +=3D delta_cpu;
> +
> +               if (delta) {
> +                       memcg->vmstats->state[i] +=3D delta;
> +                       if (parent)
> +                               parent->vmstats->state_pending[i] +=3D de=
lta;
> +               }
>         }
>
>         for (i =3D 0; i < NR_MEMCG_EVENTS; i++) {
> @@ -5562,18 +5563,22 @@ static void mem_cgroup_css_rstat_flush(struct cgr=
oup_subsys_state *css, int cpu)
>                 if (delta)
>                         memcg->vmstats->events_pending[i] =3D 0;
>
> +               delta_cpu =3D 0;
>                 v =3D READ_ONCE(statc->events[i]);
>                 if (v !=3D statc->events_prev[i]) {
> -                       delta +=3D v - statc->events_prev[i];
> +                       delta_cpu =3D v - statc->events_prev[i];
> +                       delta +=3D delta_cpu;
>                         statc->events_prev[i] =3D v;
>                 }
>
> -               if (!delta)
> -                       continue;
> +               if (delta_cpu)
> +                       memcg->vmstats->events_local[i] +=3D delta_cpu;
>
> -               memcg->vmstats->events[i] +=3D delta;
> -               if (parent)
> -                       parent->vmstats->events_pending[i] +=3D delta;
> +               if (delta) {
> +                       memcg->vmstats->events[i] +=3D delta;
> +                       if (parent)
> +                               parent->vmstats->events_pending[i] +=3D d=
elta;
> +               }
>         }
>
>         for_each_node_state(nid, N_MEMORY) {
> @@ -5591,18 +5596,22 @@ static void mem_cgroup_css_rstat_flush(struct cgr=
oup_subsys_state *css, int cpu)
>                         if (delta)
>                                 pn->lruvec_stats.state_pending[i] =3D 0;
>
> +                       delta_cpu =3D 0;
>                         v =3D READ_ONCE(lstatc->state[i]);
>                         if (v !=3D lstatc->state_prev[i]) {
> -                               delta +=3D v - lstatc->state_prev[i];
> +                               delta_cpu =3D v - lstatc->state_prev[i];
> +                               delta +=3D delta_cpu;
>                                 lstatc->state_prev[i] =3D v;
>                         }
>
> -                       if (!delta)
> -                               continue;
> +                       if (delta_cpu)
> +                               pn->lruvec_stats.state_local[i] +=3D delt=
a_cpu;
>
> -                       pn->lruvec_stats.state[i] +=3D delta;
> -                       if (ppn)
> -                               ppn->lruvec_stats.state_pending[i] +=3D d=
elta;
> +                       if (delta) {
> +                               pn->lruvec_stats.state[i] +=3D delta;
> +                               if (ppn)
> +                                       ppn->lruvec_stats.state_pending[i=
] +=3D delta;
> +                       }
>                 }
>         }
>  }
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 4686ae363000..da58a26d0d4d 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -664,6 +664,7 @@ static unsigned long count_shadow_nodes(struct shrink=
er *shrinker,
>                 struct lruvec *lruvec;
>                 int i;
>
> +               mem_cgroup_flush_stats();
>                 lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid=
));
>                 for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
>                         pages +=3D lruvec_page_state_local(lruvec,
> --
> 2.41.0.487.g6d72f3e995-goog
>
