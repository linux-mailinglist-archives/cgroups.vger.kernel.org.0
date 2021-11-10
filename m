Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAA44C42B
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 16:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhKJPUO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 10:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhKJPUO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 10:20:14 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD43C061766
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 07:17:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id s186so7198290yba.12
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YH2xCgHFc2IPo9l8PDtF0qVwo4tUGGVQgv5T/G0WwXc=;
        b=IfQOgq2bV1exhBaasi5sxxlHub5+qb4wI16hxasieT+5BLNe+6H0q2otz39R9mNKwr
         w2N+oq9VlZ1372qm/K/3OutqYpAh9P6SGF93qkH+lpdsqWGcOgjKVeUEpS317V4Yyc0g
         3Zt2M7+L2Zd90RJrsbrSQYL1/4KeBEf8HUu5oxE82lpIxcYLELZgLZ/6mW2J1yCHF8TV
         SM/uZeXrkh/0/AqV6g85TX4sLjICNLK+KLnuU0Zkg7iTX2/Wg8OyVnXKzYvgwFhpFXtw
         lOfc/yjC5oKFO4E7CCU00LJQUDY8DzqnRPONNpeqvEAwmkSnoQOv+FaSt447U+myd/R1
         P5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YH2xCgHFc2IPo9l8PDtF0qVwo4tUGGVQgv5T/G0WwXc=;
        b=gOGeKLIXqEORtQHiKDN3pNXakpT9tgyoxYO/ZL8uSvjtjDgbiM9vDjzTIxemrA0S18
         Kaofbb4T2sV0odppM8xAwC2IbgtUywXn+W5GurmYD2HyQRl9Lnl8pvGihA7wPBXMOntK
         Cu0G3gtB3qhA+RoWP1gtuYx9F6qJPt6eyXDpEXGUw9xU/01jS9TjV76ad8Ry2Hs2lT78
         Tbvp5/LphM/PG3wh4QnBBnS9aDWd7Tzwl2vP25X9xbnmIvPTGd2C14TmqLDNDwRlzS+5
         7kAcwttXNzkYBb7hwnB0HbOJ38cZrGVtvR38dmj5yLA2jtKR4t0hKBE0AJcsFP2LY/tj
         OTFQ==
X-Gm-Message-State: AOAM530SBoxxQ+kIq20mbCWcbAm5Du1DnDRGBeKj6QdYqRqT8hxDk30D
        sWHTtWlIQqaw7OQWkELF3Uyh2wn8g/mCPqu5uDoaQw==
X-Google-Smtp-Source: ABdhPJxWJR4f7Vg+/x3Pa+tNoQKGT1SY34mtcrhfvRYpG+ledCf5DVa4xkF7SeNlxe8wgaDhd/xDHmlBKmOPW8gwwvI=
X-Received: by 2002:a5b:d50:: with SMTP id f16mr20215ybr.350.1636557445540;
 Wed, 10 Nov 2021 07:17:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net> <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net> <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net> <20211105162914.215420-1-minipli@grsecurity.net>
 <20211106104854.GU174703@worktop.programming.kicks-ass.net>
 <9e8b2c49-2a10-2b34-e644-2b99708080bc@grsecurity.net> <YYkMoxLPgMt4uV/g@hirez.programming.kicks-ass.net>
 <20211109184744.GA31882@blackbody.suse.cz>
In-Reply-To: <20211109184744.GA31882@blackbody.suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Nov 2021 16:17:14 +0100
Message-ID: <CAKfTPtDsm-46xs26vFJ8wSj1qJUjK-7vOschiqD6BjH-gsyUcw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining cfs_rq's
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 9 Nov 2021 at 19:47, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> Let me add a little summary (and I'm CCing cgroups ML too).
>
> The cgroup API allows following callbacks (simplified explanation):
>
> - .css_offline           called after killing main reference
> - .css_released          called when css.refcnt hits zero
> - .css_free              called after css_released and RCU GP
>
> (The hidden catch is that they're not called directly but through workque=
ues,
> see css_free_work_fn() for details. .css_free() is queued after RCU GP th=
ough.)
>
> How is this currently used in the cpu controller:
>
> - .css_offline           not used
> - .css_released          sched_offline_group / unregister_fair_sched_grou=
p
> - .css_free              sched_free_group / free_fair_sched_group
>
>
> On Mon, Nov 08, 2021 at 12:40:19PM +0100, Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > Something like so good?
>
> Thanks for putting this together, in short I understand it reshuffles as =
follows:
>
> .css_offline    not used
> .css_released   cpu_cgroup_css_released
>                   sched_released_group(tg)
>                     // unlinking from tg tree
> .css_free       cpu_cgroup_css_free
>                   sched_unregister_group(tg)
>                     unregister_fair_sched_group(tg)
>                       for_each(cpu)
>                         remove_entity_load_avg(cfs_rq)
>                         list_del_leaf_cfs_rq(cfs_rq)    (1)
>                       destroy_cfs_bandwidth(tg)         (2)
>                     call_rcu(sched_free_group_rcu)      (3)
>                       [rcu] sched_free_group
>
> I see two following issues with this:
>
> The cfs_bandwidth.period_timer is still active between (1) and (2) and ca=
n be
> fired and tg_unthrottle_up() may add a cfs_rq back to the leaf list (subs=
equent
> GP won't help).
> (Admittedly, this window is shorter than the original window between
> cpu_cgroup_css_released() and cpu_cgroup_css_released().)
>
> Having another call_rcu() at (3) seems overly complex given the cgroup AP=
I
> provides a grace period for free (pun intended :-).
>
>
> Therefore, symbolically, the symbolic ordering should be:
>
> .css_offline    not used
> .css_released   cpu_cgroup_css_released
>                   sched_unregister_group(tg)
>                     unregister_fair_sched_group(tg)
>                       destroy_cfs_bandwidth(tg)
>                       for_each(cpu)
>                         remove_entity_load_avg(cfs_rq)
>                         list_del_leaf_cfs_rq(cfs_rq)

As we are not unlinked from tg tree, parent can walk_tg_tree_from and
add it back

>                   sched_released_group(tg)
>                     // unlinking from tg tree
>
> .css_free       cpu_cgroup_css_free
>                   sched_free_group
>
> That is, the destroy_cfs_bandwidth() is called first to make sure the
> tg_unthrottle_up() won't undo some of the cleanups and the respective
> structures are only freed after RCU grace period.
>
> (Considering Vincent's remark, remove_entity_load_avg() and
> list_del_leaf_cfs_rq() should be swapped but I'd keep that for a differen=
t
> patch.)
>
> To continue the discussion, the suggestion above in a form of diff (I str=
ipped
> the commit message for now).
>
> --8<--
> diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
> index 2067080bb235..8629b37d118e 100644
> --- a/kernel/sched/autogroup.c
> +++ b/kernel/sched/autogroup.c
> @@ -31,7 +31,7 @@ static inline void autogroup_destroy(struct kref *kref)
>         ag->tg->rt_se =3D NULL;
>         ag->tg->rt_rq =3D NULL;
>  #endif
> -       sched_offline_group(ag->tg);
> +       sched_release_group(ag->tg);
>         sched_destroy_group(ag->tg);
>  }
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 523fd602ea90..a5ca3ae6837b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9771,12 +9771,12 @@ void sched_destroy_group(struct task_group *tg)
>         call_rcu(&tg->rcu, sched_free_group_rcu);
>  }
>
> -void sched_offline_group(struct task_group *tg)
> +void sched_release_group(struct task_group *tg)
>  {
>         unsigned long flags;
>
> -       /* End participation in shares distribution: */
>         unregister_fair_sched_group(tg);
> +       unregister_rt_sched_group(tg);
>
>         spin_lock_irqsave(&task_group_lock, flags);
>         list_del_rcu(&tg->list);
> @@ -9896,7 +9896,7 @@ static void cpu_cgroup_css_released(struct cgroup_s=
ubsys_state *css)
>  {
>         struct task_group *tg =3D css_tg(css);
>
> -       sched_offline_group(tg);
> +       sched_release_group(tg);
>  }
>
>  static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 13950beb01a2..6e476f6d9435 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11456,8 +11456,6 @@ void free_fair_sched_group(struct task_group *tg)
>  {
>         int i;
>
> -       destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
> -
>         for_each_possible_cpu(i) {
>                 if (tg->cfs_rq)
>                         kfree(tg->cfs_rq[i]);
> @@ -11534,6 +11532,8 @@ void unregister_fair_sched_group(struct task_grou=
p *tg)
>         struct rq *rq;
>         int cpu;
>
> +       destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
> +
>         for_each_possible_cpu(cpu) {
>                 if (tg->se[cpu])
>                         remove_entity_load_avg(tg->se[cpu]);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index bb945f8faeca..b48baaba2fc2 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -137,13 +137,17 @@ static inline struct rq *rq_of_rt_se(struct sched_r=
t_entity *rt_se)
>         return rt_rq->rq;
>  }
>
> -void free_rt_sched_group(struct task_group *tg)
> +void unregister_rt_sched_group(struct task_group *tg)
>  {
> -       int i;
> -
>         if (tg->rt_se)
>                 destroy_rt_bandwidth(&tg->rt_bandwidth);
>
> +}
> +
> +void free_rt_sched_group(struct task_group *tg)
> +{
> +       int i;
> +
>         for_each_possible_cpu(i) {
>                 if (tg->rt_rq)
>                         kfree(tg->rt_rq[i]);
> @@ -250,6 +254,8 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_=
rt_entity *rt_se)
>         return &rq->rt;
>  }
>
> +void unregister_rt_sched_group(struct task_group *tg) { }
> +
>  void free_rt_sched_group(struct task_group *tg) { }
>
>  int alloc_rt_sched_group(struct task_group *tg, struct task_group *paren=
t)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 7f1612d26c18..0e66749486e7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -488,6 +488,7 @@ extern void __refill_cfs_bandwidth_runtime(struct cfs=
_bandwidth *cfs_b);
>  extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
>  extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
>
> +extern void unregister_rt_sched_group(struct task_group *tg);
>  extern void free_rt_sched_group(struct task_group *tg);
>  extern int alloc_rt_sched_group(struct task_group *tg, struct task_group=
 *parent);
>  extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
> @@ -503,7 +504,7 @@ extern struct task_group *sched_create_group(struct t=
ask_group *parent);
>  extern void sched_online_group(struct task_group *tg,
>                                struct task_group *parent);
>  extern void sched_destroy_group(struct task_group *tg);
> -extern void sched_offline_group(struct task_group *tg);
> +extern void sched_release_group(struct task_group *tg);
>
>  extern void sched_move_task(struct task_struct *tsk);
>
>
