Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A014ED853
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiCaLVP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiCaLVO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 07:21:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62F16C0AE;
        Thu, 31 Mar 2022 04:19:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v15so19412458qkg.8;
        Thu, 31 Mar 2022 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dItLv4S5SX666mhEd5RtQQbN703HIelUJZMfqElwL7g=;
        b=FQg4/TaqBkwVIRPbCj8sn4TJG6eua30QgX8uzm01xu76PFh+57Kt3o+qdCtoeH8VJi
         +nBbgpT6MU+60O+p8ZyUFTD1ULpSmSkW5KpxNl0whuN+daUem8vB1knulKZW42PHu98l
         lVVZUgqjTLceK14b1v1rqJVOAsAuAZd91BeMXooGeQARiRRoeNo2BxJBNMQGebI8j19L
         HqEolG+L7ro4XMhoNI9WKjXv502scGyHbkzbLV59D8IsE3A+YYY4stQ90aqJD8yx4zIe
         Lr6cJmReRJLlzy/OM4bfdr5L6ZvdRfWazFGHu5q98uig1QOO06W+YWKq+BomOwafw7Bq
         4YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dItLv4S5SX666mhEd5RtQQbN703HIelUJZMfqElwL7g=;
        b=dXlvvRCyyKt62aGGkfjs430QNOvHUnep2dbejqwH9y01Xf8dR8eoK06dUj5I59Sf/P
         DBg/CeDsthfzWwudSi55l+wsbY3LsIazpZb+uXXcxRB6ytV1Y5cf1ckme1vvEIhQODDP
         gvuLQfGfrv2+TukZfedBgvZzOJFmVAePEr9/5bGPdY7HhgDKxHu5SjPsAzftVSyAXUBD
         HXyi/dRX/kMyBLskxNWreI/XlHNmED7R0zQrrt9sR+GtpmH7pzEsyIw/KfhPd15Mggdg
         Wq4vH/rvtFl/cQ2aT6WBvL2/HDH15VGR4UEKKbxL6A3USLPzOsGNTPpyHKPfiGGdAdi1
         vyWg==
X-Gm-Message-State: AOAM533Qs+6MjG66Ts0dh9PzkeE9VJgTUi9DB6My3xwSSv76M8mnxUma
        d0NUSr5hXSv5JoBlweZrlq6Kv3BIk6iQIQQ3k8c=
X-Google-Smtp-Source: ABdhPJziUCd4dgAtolUP0Jd7ZI1D2v+1OCOEQ3TABiUzcM+HwqMh+jTf/6N6/2bm4FcNPCMpbQ4M6DaymwRdvZa4fNs=
X-Received: by 2002:a05:620a:4586:b0:67e:d240:ed1d with SMTP id
 bp6-20020a05620a458600b0067ed240ed1dmr2849529qkb.630.1648725566029; Thu, 31
 Mar 2022 04:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com> <YkVt0m+VxnXgnulq@dhcp22.suse.cz>
In-Reply-To: <YkVt0m+VxnXgnulq@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 31 Mar 2022 19:18:58 +0800
Message-ID: <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > For some kind of memcg, the usage is varies greatly from scenarios. Suc=
h as
> > multimedia app could have the usage range from 50MB to 500MB, which gen=
erated
> > by loading an special algorithm into its virtual address space and make=
 it hard
> > to protect the expanded usage without userspace's interaction.
>
> Do I get it correctly that the concern you have is that you do not know
> how much memory your workload will need because that depends on some
> parameters?
right. such as a camera APP will expand the usage from 50MB to 500MB
because of launching a special function(face beauty etc need special
algorithm)
>
> > Furthermore, fixed
> > memory.low is a little bit against its role of soft protection as it wi=
ll response
> > any system's memory pressure in same way.
>
> Could you be more specific about this as well?
As the camera case above, if we set memory.low as 200MB to keep the
APP run smoothly, the system will experience high memory pressure when
another high load APP launched simultaneously. I would like to have
camera be reclaimed under this scenario.
>
> > Taking all above into consideration, we introduce a kind of dynamic pro=
tection
> > based on group's watermark and system's memory pressure in this patch. =
Our aims are:
> > 1. dynamic protection with no fixed setting
> > 2. proper protection value on memory.current
>
> How do you define the "proper protection"
I would like to share more test result in next version
>
> > 3. time based decay protection
> > 4. memory pressue related protection
> >
> > The basic concept could be descripted as bellowing, where we take group=
->watermark
> > as a representative of usage
> >               group->memory.low =3D decayed_watermark * decay_factor
> >               decayed_watermark =3D group->watermark * func_wm_decay(ti=
me)
> >               decay_factor =3D psi_system[PSI_MEM][time]
> >
> > func_wm_decay could be deemed as a linear decay funcion that will decay=
 1/2 in
> > 68s(36bit).If we take 2048 as "1", it could be descripted as:
> >               decayed_watermark =3D time >> (group->wm_dec_factor - 10)
> >               decayed_watermark =3D new_usage(if new_usage > decayed_wa=
termark)
> >
> > decay_factor is as simple as a table lookingup and compose the final va=
lue by
> > weight of some and full as
> >               some =3D psi_system.avg[PSI_MEM * 2][time]
> >               full =3D psi_system.avg[PSI_MEM * 2 + 1][time]
> >               decay_factor =3D some * 70% + full *30%
>
> One very important thing that I am missing here is the overall objective =
of this
> tuning. From the above it seems that you want to (ab)use memory->low to
> protect some portion of the charged memory and that the protection
> shrinks over time depending on the the global PSI metrict and time.
> But why this is a good thing?
'Good' means it meets my original goal of keeping the usage during a
period of time and responding to the system's memory pressure. For an
android like system, memory is almost forever being in a tight status
no matter how many RAM it has. What we need from memcg is more than
control and grouping, we need it to be more responsive to the system's
load and could  sacrifice its usage  under certain criteria.
>
> Also you seem to base your back off on the global PSI numbers. How does
> that cope with a memcg memory pressure?
For simplification, just only take global PSI into consideration now.
>
> > We simply test above change on a v5.4 based system in bellowing topolog=
y and
> > observe some behavious as we expected:
> >       A
> >      / \
> >     B   C
> > 1. With regard to the protection, elow is in a proper range as proporti=
on of watermark.
> > 2. Elapsed time has positive impact on elow via decayed_watermark.
> > 3. Memory pressure has negitive impact on elow which could keep more us=
age when
> >    system is under less pressure.
>
> I am sorry but this doesn't really help much. As pointed out out above,
> I completely fail to see what is the expected behavior and why it makes
> sense.
I will test it under real scenarios and provide more intuitive result=E3=80=
=82
>
> > PS: It should be configured as a sub-type of memcg and choosed by the u=
ser when
> > create the group.
>
> I do not understand but I suspect that a non-RFC proposal would use a
> dedicated user interface. Your current implementation is surely not
> acceptable as it changes semantic of a limit without any way to opt-out
> of that behavior. Memory low has a well established semantic so this
> cannot really be changed without an explicit opt-in.
opt-in changes will be added in next version and would NOT affect
current design.
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/memcontrol.h   | 50 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/page_counter.h |  4 ++++
> >  include/linux/psi.h          |  2 ++
> >  kernel/sched/psi.c           | 18 ++++++++++++++++
> >  mm/memcontrol.c              |  4 ++++
> >  mm/page_counter.c            |  4 ++++
> >  6 files changed, 82 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 0c5c403..a510057 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -21,6 +21,9 @@
> >  #include <linux/vmstat.h>
> >  #include <linux/writeback.h>
> >  #include <linux/page-flags.h>
> > +#include <linux/sched/loadavg.h>
> > +#include <linux/sched/clock.h>
> > +#include <linux/psi.h>
> >
> >  struct mem_cgroup;
> >  struct obj_cgroup;
> > @@ -28,6 +31,8 @@
> >  struct mm_struct;
> >  struct kmem_cache;
> >
> > +#define MEMCG_INTERVAL       (2*HZ+1)        /* 2 sec intervals */
> > +
> >  /* Cgroup-specific page state, on top of universal node page state */
> >  enum memcg_stat_item {
> >       MEMCG_SWAP =3D NR_VM_NODE_STAT_ITEMS,
> > @@ -340,6 +345,10 @@ struct mem_cgroup {
> >       struct deferred_split deferred_split_queue;
> >  #endif
> >
> > +     u64 wm_dec_fact;
> > +     u64 avg_next_update;
> > +     u64 avg_last_update;
> > +
> >       struct mem_cgroup_per_node *nodeinfo[];
> >  };
> >
> > @@ -608,6 +617,47 @@ static inline bool mem_cgroup_disabled(void)
> >       return !cgroup_subsys_enabled(memory_cgrp_subsys);
> >  }
> >
> > +/*
> > + * calculate memory.low based on the historic watermark and memory pre=
ssure
> > + */
> > +static inline void calc_protected_low(struct mem_cgroup *group)
> > +{
> > +     u64 now, decay_factor;
> > +     u64 decayed_watermark;
> > +     u64 delta_time;
> > +
> > +     now =3D sched_clock();
> > +
> > +     if (!group->avg_next_update) {
> > +             group->avg_next_update =3D now + jiffies_to_nsecs(5*HZ);
> > +             return;
> > +     }
> > +
> > +     if (time_before((unsigned long)now, (unsigned long)group->avg_nex=
t_update))
> > +             return;
> > +
> > +     delta_time =3D group->avg_last_update ? now - group->avg_last_upd=
ate : 0;
> > +     /*
> > +      * we take 2048 as "1" and 68s decay 1/2(36bit) by default
> > +      * decay_factor =3D 1024 * delta_time / 68s(0x1000000000)
> > +      * 0.5(1024)/68s =3D decay_factor/delta_time =3D=3D> decay_factor=
 =3D delta_time >> 26
> > +      */
> > +     decay_factor =3D (2048 - min(2048ULL, delta_time >> (group->wm_de=
c_fact - 10)));
> > +     decayed_watermark =3D group->memory.decayed_watermark * decay_fac=
tor / 2048;
> > +     /* decay_factor: based on average memory pressure over elapsed ti=
me */
> > +     decay_factor =3D psi_mem_get(delta_time);
> > +     group->memory.low =3D decayed_watermark * (100 - decay_factor) / =
100;
> > +
> > +     /*
> > +      * avg_next_update: expected expire time according to current sta=
tus
> > +      */
> > +     group->memory.decayed_watermark =3D decayed_watermark;
> > +     group->avg_last_update =3D now;
> > +     group->avg_next_update =3D now + jiffies_to_nsecs(2*HZ);
> > +
> > +     return;
> > +}
> > +
> >  static inline void mem_cgroup_protection(struct mem_cgroup *root,
> >                                        struct mem_cgroup *memcg,
> >                                        unsigned long *min,
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.=
h
> > index 6795913..2720eb9f 100644
> > --- a/include/linux/page_counter.h
>
>
>
> > +++ b/include/linux/page_counter.h
> > @@ -25,8 +25,12 @@ struct page_counter {
> >
> >       /* legacy */
> >       unsigned long watermark;
> > +     unsigned long decayed_watermark;
> >       unsigned long failcnt;
> >
> > +     /* proportional protection */
> > +     unsigned long min_prop;
> > +     unsigned long low_prop;
> >       /*
> >        * 'parent' is placed here to be far from 'usage' to reduce
> >        * cache false sharing, as 'usage' is written mostly while
> > diff --git a/include/linux/psi.h b/include/linux/psi.h
> > index 65eb147..6c76993 100644
> > --- a/include/linux/psi.h
> > +++ b/include/linux/psi.h
> > @@ -25,6 +25,8 @@ void psi_task_switch(struct task_struct *prev, struct=
 task_struct *next,
> >
> >  int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res=
 res);
> >
> > +unsigned long psi_mem_get(unsigned long time);
> > +
> >  #ifdef CONFIG_CGROUPS
> >  int psi_cgroup_alloc(struct cgroup *cgrp);
> >  void psi_cgroup_free(struct cgroup *cgrp);
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index dd80bd2..8d315e0 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -291,6 +291,24 @@ static void get_recent_times(struct psi_group *gro=
up, int cpu,
> >       }
> >  }
> >
> > +unsigned long psi_mem_get(unsigned long time_ns)
> > +{
> > +     unsigned long time_sec =3D time_ns / (1000 * 1000 * 1000);
> > +     unsigned long some, full;
> > +     if (time_sec < 10) {
> > +             some =3D LOAD_INT(psi_system.avg[PSI_MEM * 2][0]);
> > +             full =3D LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][0]);
> > +     } else if (time_sec < 60) {
> > +             some =3D LOAD_INT(psi_system.avg[PSI_MEM * 2][1]);
> > +             full =3D LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][1]);
> > +     } else {
> > +             some =3D LOAD_INT(psi_system.avg[PSI_MEM * 2][2]);
> > +             full =3D LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][2]);
> > +     }
> > +
> > +     return (some * 768 + full * 256) / 1024;
> > +}
> > +
> >  static void calc_avgs(unsigned long avg[3], int missed_periods,
> >                     u64 time, u64 period)
> >  {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 508bcea..6b579a4 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5188,6 +5188,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
> >       page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
> >       memcg->soft_limit =3D PAGE_COUNTER_MAX;
> >       page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> > +     memcg->wm_dec_fact =3D 36;
> >       if (parent) {
> >               memcg->swappiness =3D mem_cgroup_swappiness(parent);
> >               memcg->oom_kill_disable =3D parent->oom_kill_disable;
> > @@ -6616,6 +6617,8 @@ void mem_cgroup_calculate_protection(struct mem_c=
group *root,
> >  {
> >       unsigned long usage, parent_usage;
> >       struct mem_cgroup *parent;
> > +     unsigned long memcg_emin, memcg_elow, parent_emin, parent_elow;
> > +     unsigned long watermark;
> >
> >       if (mem_cgroup_disabled())
> >               return;
> > @@ -6642,6 +6645,7 @@ void mem_cgroup_calculate_protection(struct mem_c=
group *root,
> >       if (!parent)
> >               return;
> >
> > +     calc_protected_low(memcg);
> >       if (parent =3D=3D root) {
> >               memcg->memory.emin =3D READ_ONCE(memcg->memory.min);
> >               memcg->memory.elow =3D READ_ONCE(memcg->memory.low);
> > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > index 7d83641..18abfdd 100644
> > --- a/mm/page_counter.c
> > +++ b/mm/page_counter.c
> > @@ -83,6 +83,8 @@ void page_counter_charge(struct page_counter *counter=
, unsigned long nr_pages)
> >                */
> >               if (new > READ_ONCE(c->watermark))
> >                       WRITE_ONCE(c->watermark, new);
> > +             if (new > READ_ONCE(c->decayed_watermark))
> > +                     WRITE_ONCE(c->decayed_watermark, new);
> >       }
> >  }
> >
> > @@ -137,6 +139,8 @@ bool page_counter_try_charge(struct page_counter *c=
ounter,
> >                */
> >               if (new > READ_ONCE(c->watermark))
> >                       WRITE_ONCE(c->watermark, new);
> > +             if (new > READ_ONCE(c->decayed_watermark))
> > +                     WRITE_ONCE(c->decayed_watermark, new);
> >       }
> >       return true;
> >
> > --
> > 1.9.1
>
> --
> Michal Hocko
> SUSE Labs
