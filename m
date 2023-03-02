Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A306A7C19
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 08:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCBHu4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 02:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCBHuz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 02:50:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E530295
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 23:50:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso1967408pjr.5
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 23:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vqc1mz3axpFAzdg7lT6JZvRhrAE9v/sPglj8irXA34=;
        b=A4/2a1stP2RqZvmdHdWzCHl/MoO4AaMK6NYTVU/hWPu+lgAh9L1mcGEzGs7eUVWBk3
         qkSqKQ+K9tmPRcgCSbGuAOVjo7OP5rBAhq9IY+JCzinIxLKfaVcITcfZh4kLEOY96sn8
         BMjLXNV9CoLzJgzGkeUD94ur8yyv0fxdTQVniXvF1iMLhj8jb/Ig1gToZoKuqHVDGzkE
         2OIdAZeyFzeC82PI0QLAhBQb4fMmyeZKBnD+feQl1KG0HL/b+WKIZyKoLhDWDg3MuA//
         9onYgEvGxQgje2kep4xtVazaYkoFZU/ew+1MPllbhqev2mV5lt7LKEZwc1dFyGp1d7yA
         OqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vqc1mz3axpFAzdg7lT6JZvRhrAE9v/sPglj8irXA34=;
        b=n1Bg3EFODij6rHbgdCs1GCKYDG+xF+5MIZ28EF1Gev0YVupNOlvEkkXLZJr2QyDUWh
         ZqUI1SWhbjLVN20IFqud9lQPoXY/iY7pHALznI5lh9BrPyP8Iq0AFcMPHHpRYQXrEipf
         eFr/wzQB+Z+l8wOiwFOonPxzmnjAGEd0WuWmXi8nLUywebjSESO6Nd9IG3b7IOuYvBnK
         q8RsfYabivaiZD1H214tS9BunSkPnNULz7DGRstsPQ/oE4q7odS61bKOF7Sgd538Fx6C
         9c6YqS64DVYMA0v9gZONe9eqdTSWSbCWDXr5g+HGaZ1l64iF2iX+7jTIA+ORLkwhoJtV
         QTLQ==
X-Gm-Message-State: AO0yUKWmoY2GNEa7+VC06/9JznFQlS3Hp5xwcwDfyVF/MNMuFukGvtF0
        GGulZr+HGeXtFSMhtv/qtpknbrffSgLgt09+7YbDbQ==
X-Google-Smtp-Source: AK7set/WU+TdS91gbQDp55cM7T6gOGevfshMX5qLYUUCi4vvlJRIdW3N3DRCsaALsxlOyOlhSBVGppifKccE6/zEA8c=
X-Received: by 2002:a17:902:a3cc:b0:19a:fa2f:559e with SMTP id
 q12-20020a170902a3cc00b0019afa2f559emr472492plb.3.1677743431224; Wed, 01 Mar
 2023 23:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-9-vincent.guittot@linaro.org> <4982b608-f8c7-531c-3322-c055643a5b2d@linux.vnet.ibm.com>
In-Reply-To: <4982b608-f8c7-531c-3322-c055643a5b2d@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Mar 2023 08:50:20 +0100
Message-ID: <CAKfTPtAEbzrxKOGXYRxp0qMM-TPj1q8BdcaVpK7ObZfe8QWn4g@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] sched/fair: Add latency list
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 1 Mar 2023 at 19:48, shrikanth hegde <sshegde@linux.vnet.ibm.com> wrote:
>
>
> On 2/24/23 3:04 PM, Vincent Guittot wrote:
> > Add a rb tree for latency sensitive entities so we can schedule the most
> > sensitive one first even when it failed to preempt current at wakeup or
> > when it got quickly preempted by another entity of higher priority.
> >
> > In order to keep fairness, the latency is used once at wakeup to get a
> > minimum slice and not during the following scheduling slice to prevent
> > long running entity to got more running time than allocated to his nice
> > priority.
> >
> > The rb tree enables to cover the last corner case where latency
> > sensitive entity can't got schedule quickly after the wakeup.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> >  include/linux/sched.h |   1 +
> >  kernel/sched/core.c   |   1 +
> >  kernel/sched/fair.c   | 109 ++++++++++++++++++++++++++++++++++++++++--
> >  kernel/sched/sched.h  |   1 +
> >  4 files changed, 109 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 38decae3e156..41bb92be5ecc 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -548,6 +548,7 @@ struct sched_entity {
> >       /* For load-balancing: */
> >       struct load_weight              load;
> >       struct rb_node                  run_node;
> > +     struct rb_node                  latency_node;
>
> Ran pahole to see if the frequently accessed fields change across cachelines.
> There is no change in cachelines of task_struct, whereas sched_entity differs
> due to latency_node.  Maybe the latency_node could be placed after
> runnable_weight as there is space available in that cacheline.

I will run some test on my system to confimr your results but we can
move latency_node field if it helps cache hit stats

>
>
> 6.2
> #pahole sched_entity
> struct sched_entity {
>         struct load_weight         load;                 /*     0    16 */
>
>         /* XXX last struct has 4 bytes of padding */
>
>         struct rb_node             run_node;             /*    16    24 */
>         struct list_head           group_node;           /*    40    16 */
>         unsigned int               on_rq;                /*    56     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         u64                        exec_start;           /*    64     8 */
>         u64                        sum_exec_runtime;     /*    72     8 */
>         u64                        vruntime;             /*    80     8 */
>         u64                        prev_sum_exec_runtime; /*    88     8 */
>         u64                        nr_migrations;        /*    96     8 */
>         int                        depth;                /*   104     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct sched_entity *      parent;               /*   112     8 */
>         struct cfs_rq *            cfs_rq;               /*   120     8 */
>         /* --- cacheline 1 boundary (128 bytes) --- */
>         struct cfs_rq *            my_q;                 /*   128     8 */
>         long unsigned int          runnable_weight;      /*   136     8 */
>
>         /* XXX 112 bytes hole, try to pack */
>
>         /* --- cacheline 2 boundary (256 bytes) --- */
>         struct sched_avg           avg;                  /*   256   128 */
>
>
> 6.2 + V12 patch
> #pahole sched_entity
> struct sched_entity {
>         struct load_weight         load;                 /*     0    16 */
>
>         /* XXX last struct has 4 bytes of padding */
>
>         struct rb_node             run_node;             /*    16    24 */
>         struct rb_node             latency_node;         /*    40    24 */
>         struct list_head           group_node;           /*    64    16 */
>         unsigned int               on_rq;                /*    80     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         u64                        exec_start;           /*    88     8 */
>         u64                        sum_exec_runtime;     /*    96     8 */
>         u64                        vruntime;             /*   104     8 */
>         u64                        prev_sum_exec_runtime; /*   112     8 */
>         u64                        nr_migrations;        /*   120     8 */
>         /* --- cacheline 1 boundary (128 bytes) --- */
>         int                        depth;                /*   128     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct sched_entity *      parent;               /*   136     8 */
>         struct cfs_rq *            cfs_rq;               /*   144     8 */
>         struct cfs_rq *            my_q;                 /*   152     8 */
>
>
> 6.2 + V12 patch + Re-shuffle of latency_node
> #pahole sched_entity
> struct sched_entity {
>         struct load_weight         load;                 /*     0    16 */
>
>         /* XXX last struct has 4 bytes of padding */
>
>         struct rb_node             run_node;             /*    16    24 */
>         struct list_head           group_node;           /*    40    16 */
>         unsigned int               on_rq;                /*    56     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         u64                        exec_start;           /*    64     8 */
>         u64                        sum_exec_runtime;     /*    72     8 */
>         u64                        vruntime;             /*    80     8 */
>         u64                        prev_sum_exec_runtime; /*    88     8 */
>         u64                        nr_migrations;        /*    96     8 */
>         int                        depth;                /*   104     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct sched_entity *      parent;               /*   112     8 */
>         struct cfs_rq *            cfs_rq;               /*   120     8 */
>         /* --- cacheline 1 boundary (128 bytes) --- */
>         struct cfs_rq *            my_q;                 /*   128     8 */
>         long unsigned int          runnable_weight;      /*   136     8 */
>         struct rb_node             latency_node;         /*   144    24 */
>         long int                   latency_offset;       /*   168     8 */
>
>         /* XXX 80 bytes hole, try to pack */
>
>         /* --- cacheline 2 boundary (256 bytes) --- */
>
>
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a2b52cf5e1bb..1e93aaaeead2 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -548,7 +548,6 @@ struct sched_entity {
>         /* For load-balancing: */
>         struct load_weight              load;
>         struct rb_node                  run_node;
> -       struct rb_node                  latency_node;
>         struct list_head                group_node;
>         unsigned int                    on_rq;
>
> @@ -569,6 +568,7 @@ struct sched_entity {
>         /* cached value of my_q->h_nr_running */
>         unsigned long                   runnable_weight;
>  #endif
> +       struct rb_node                  latency_node;
>         /* preemption offset in ns */
>         long                            latency_offset;
>
>
> Ran the schbench and hackbench with this patch series. Here comparison is
> between 6.2 stable tree, 6.2 + Patch and 6.2 + patch + above re-arrange of
> latency_node. Ran two cgroups, in one cgroup running stress-ng at 50%(group1)
> and other is running these benchmarks (group2). Set the latency nice
> of group2 to -20. These are run on Power system with 12 cores with SMT=8.
> Total of 96 CPU.
>
> schbench gets lower latency compared to stabletree. Whereas hackbench seems
> to regress under this case. Maybe i am doing something wrong. I will re-run
> and attach the numbers to series.
> Please suggest if any variation in the test i need to try.

hackbench takes advanatge of a latency nice 19 as it mainly wants to
run longer slice to move forward rather than preempting others all the
time

>
> Re-arrange seems to help the patch series by avoiding an cacheline miss.
>
> =========================
> schbench
> =========================
>                  6.2   |  6.2 + V12     |     6.2 + V12 + re-arrange
> 1 Thread
>   50.0th:        9.00  |    9.00        |        9.50
>   75.0th:       10.50  |   10.00        |        9.50
>   90.0th:       11.00  |   11.00        |       10.50
>   95.0th:       11.00  |   11.00        |       11.00
>   99.0th:       11.50  |   11.50        |       11.50
>   99.5th:       12.50  |   12.00        |       12.00
>   99.9th:       14.50  |   13.50        |       12.00
> 2 Threads
>   50.0th:        9.50  |    9.50        |        8.50
>   75.0th:       11.00  |   10.50        |        9.50
>   90.0th:       13.50  |   11.50        |       10.50
>   95.0th:       14.00  |   12.00        |       11.00
>   99.0th:       15.50  |   13.50        |       12.00
>   99.5th:       16.00  |   14.00        |       12.00
>   99.9th:       17.00  |   16.00        |       16.50
> 4 Threads
>   50.0th:       11.50  |   11.50        |       10.50
>   75.0th:       13.50  |   12.50        |       12.50
>   90.0th:       15.50  |   14.50        |       14.00
>   95.0th:       16.50  |   15.50        |       14.50
>   99.0th:       20.00  |   17.50        |       16.50
>   99.5th:       20.50  |   18.50        |       17.00
>   99.9th:       22.50  |   21.00        |       19.00
> 8 Threads
>   50.0th:       14.00  |   14.00        |       14.00
>   75.0th:       16.00  |   16.00        |       16.00
>   90.0th:       18.00  |   18.00        |       17.50
>   95.0th:       18.50  |   18.50        |       18.50
>   99.0th:       20.00  |   20.00        |       20.00
>   99.5th:       20.50  |   21.50        |       21.00
>   99.9th:       22.50  |   23.50        |       23.00
> 16 Threads
>   50.0th:       19.00  |   18.50        |       19.00
>   75.0th:       23.00  |   22.50        |       23.00
>   90.0th:       25.00  |   25.50        |       25.00
>   95.0th:       26.50  |   26.50        |       26.00
>   99.0th:       28.50  |   29.00        |       28.50
>   99.5th:       31.00  |   30.00        |       30.00
>   99.9th:     5626.00  | 4761.50        |       32.50
> 32 Threads
>   50.0th:       27.00  |   27.50        |       29.00
>   75.0th:       35.50  |   36.50        |       38.50
>   90.0th:       42.00  |   44.00        |       50.50
>   95.0th:      447.50  | 2959.00        |     8544.00
>   99.0th:     7372.00  | 17032.00       |    19136.00
>   99.5th:    15360.00  | 19808.00       |    20704.00
>   99.9th:    20640.00  | 30048.00       |    30048.00
>
> ====================
> hackbench
> ====================
>                         6.2     |  6.2 + V12        |     6.2+ V12 +re-arrange
>
> Process 10 Time:        0.35    |       0.42        |           0.41
> Process 20 Time:        0.61    |       0.76        |           0.76
> Process 30 Time:        0.87    |       1.06        |           1.05
> thread 10 Time:         0.35    |       0.43        |           0.42
> thread 20 Time:         0.66    |       0.79        |           0.78
> Process(Pipe) 10 Time:  0.21    |       0.33        |           0.32
> Process(Pipe) 20 Time:  0.34    |       0.52        |           0.52
> Process(Pipe) 30 Time:  0.46    |       0.72        |           0.71
> thread(Pipe) 10 Time:   0.21    |       0.34        |           0.34
> thread(Pipe) 20 Time:   0.36    |       0.56        |           0.56
>
>
> >       struct list_head                group_node;
> >       unsigned int                    on_rq;
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 093cc1af73dc..752fd364216c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4434,6 +4434,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >       p->se.nr_migrations             = 0;
> >       p->se.vruntime                  = 0;
> >       INIT_LIST_HEAD(&p->se.group_node);
> > +     RB_CLEAR_NODE(&p->se.latency_node);
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >       p->se.cfs_rq                    = NULL;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 125a6ff53378..e2aeb4511686 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -680,7 +680,85 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
> >
> >       return __node_2_se(last);
> >  }
> > +#endif
> >
> > +/**************************************************************
> > + * Scheduling class tree data structure manipulation methods:
> > + * for latency
> > + */
> > +
> > +static inline bool latency_before(struct sched_entity *a,
> > +                             struct sched_entity *b)
> > +{
> > +     return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
> > +}
> > +
> > +#define __latency_node_2_se(node) \
> > +     rb_entry((node), struct sched_entity, latency_node)
> > +
> > +static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
> > +{
> > +     return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
> > +}
> > +
> > +/*
> > + * Enqueue an entity into the latency rb-tree:
> > + */
> > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +{
> > +
> > +     /* Only latency sensitive entity can be added to the list */
> > +     if (se->latency_offset >= 0)
> > +             return;
> > +
> > +     if (!RB_EMPTY_NODE(&se->latency_node))
> > +             return;
> > +
> > +     /*
> > +      * The entity is always added the latency list at wakeup.
> > +      * Then, a not waking up entity that is put back in the list after an
> > +      * execution time less than sysctl_sched_min_granularity, means that
> > +      * the entity has been preempted by a higher sched class or an entity
> > +      * with higher latency constraint. In thi case, the entity is also put
> > +      * back in the latency list so it gets a chance to run 1st during the
> > +      * next slice.
> > +      */
> > +     if (!(flags & ENQUEUE_WAKEUP)) {
> > +             u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > +
> > +             if (delta_exec >= sysctl_sched_min_granularity)
> > +                     return;
> > +     }
> > +
> > +     rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
> > +}
> > +
> > +/*
> > + * Dequeue an entity from the latency rb-tree and return true if it was really
> > + * part of the rb-tree:
> > + */
> > +static bool __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +{
> > +     if (!RB_EMPTY_NODE(&se->latency_node)) {
> > +             rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
> > +             RB_CLEAR_NODE(&se->latency_node);
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
> > +{
> > +     struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
> > +
> > +     if (!left)
> > +             return NULL;
> > +
> > +     return __latency_node_2_se(left);
> > +}
> > +
> > +#ifdef CONFIG_SCHED_DEBUG
> >  /**************************************************************
> >   * Scheduling class statistics methods:
> >   */
> > @@ -4758,8 +4836,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >       check_schedstat_required();
> >       update_stats_enqueue_fair(cfs_rq, se, flags);
> >       check_spread(cfs_rq, se);
> > -     if (!curr)
> > +     if (!curr) {
> >               __enqueue_entity(cfs_rq, se);
> > +             __enqueue_latency(cfs_rq, se, flags);
> > +     }
> >       se->on_rq = 1;
> >
> >       if (cfs_rq->nr_running == 1) {
> > @@ -4845,8 +4925,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >
> >       clear_buddies(cfs_rq, se);
> >
> > -     if (se != cfs_rq->curr)
> > +     if (se != cfs_rq->curr) {
> >               __dequeue_entity(cfs_rq, se);
> > +             __dequeue_latency(cfs_rq, se);
> > +     }
> >       se->on_rq = 0;
> >       account_entity_dequeue(cfs_rq, se);
> >
> > @@ -4941,6 +5023,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                */
> >               update_stats_wait_end_fair(cfs_rq, se);
> >               __dequeue_entity(cfs_rq, se);
> > +             __dequeue_latency(cfs_rq, se);
> >               update_load_avg(cfs_rq, se, UPDATE_TG);
> >       }
> >
> > @@ -4979,7 +5062,7 @@ static struct sched_entity *
> >  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >  {
> >       struct sched_entity *left = __pick_first_entity(cfs_rq);
> > -     struct sched_entity *se;
> > +     struct sched_entity *latency, *se;
> >
> >       /*
> >        * If curr is set we have to see if its left of the leftmost entity
> > @@ -5021,6 +5104,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >               se = cfs_rq->last;
> >       }
> >
> > +     /* Check for latency sensitive entity waiting for running */
> > +     latency = __pick_first_latency(cfs_rq);
> > +     if (latency && (latency != se) &&
> > +         wakeup_preempt_entity(latency, se) < 1)
> > +             se = latency;
> > +
> >       return se;
> >  }
> >
> > @@ -5044,6 +5133,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
> >               update_stats_wait_start_fair(cfs_rq, prev);
> >               /* Put 'current' back into the tree. */
> >               __enqueue_entity(cfs_rq, prev);
> > +             __enqueue_latency(cfs_rq, prev, 0);
> >               /* in !on_rq case, update occurred at dequeue */
> >               update_load_avg(cfs_rq, prev, 0);
> >       }
> > @@ -12222,6 +12312,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> >  void init_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >       cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> > +     cfs_rq->latency_timeline = RB_ROOT_CACHED;
> >       u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
> >  #ifdef CONFIG_SMP
> >       raw_spin_lock_init(&cfs_rq->removed.lock);
> > @@ -12378,6 +12469,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
> >       se->my_q = cfs_rq;
> >
> >       se->latency_offset = calc_latency_offset(tg->latency_prio);
> > +     RB_CLEAR_NODE(&se->latency_node);
> >
> >       /* guarantee group entities always have weight */
> >       update_load_set(&se->load, NICE_0_LOAD);
> > @@ -12529,8 +12621,19 @@ int sched_group_set_latency(struct task_group *tg, int prio)
> >
> >       for_each_possible_cpu(i) {
> >               struct sched_entity *se = tg->se[i];
> > +             struct rq *rq = cpu_rq(i);
> > +             struct rq_flags rf;
> > +             bool queued;
> > +
> > +             rq_lock_irqsave(rq, &rf);
> >
> > +             queued = __dequeue_latency(se->cfs_rq, se);
> >               WRITE_ONCE(se->latency_offset, latency_offset);
> > +             if (queued)
> > +                     __enqueue_latency(se->cfs_rq, se, ENQUEUE_WAKEUP);
> > +
> > +
> > +             rq_unlock_irqrestore(rq, &rf);
> >       }
> >
> >       mutex_unlock(&shares_mutex);
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 9a2e71231083..21dd309e98a9 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -570,6 +570,7 @@ struct cfs_rq {
> >  #endif
> >
> >       struct rb_root_cached   tasks_timeline;
> > +     struct rb_root_cached   latency_timeline;
> >
> >       /*
> >        * 'curr' points to currently running entity on this cfs_rq.
>
