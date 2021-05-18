Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96845386FCA
	for <lists+cgroups@lfdr.de>; Tue, 18 May 2021 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbhERCGb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 May 2021 22:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbhERCGb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 May 2021 22:06:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19BC06175F
        for <cgroups@vger.kernel.org>; Mon, 17 May 2021 19:05:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id l7so11143612ybf.8
        for <cgroups@vger.kernel.org>; Mon, 17 May 2021 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZm5cS0Op3FLJ1htgR1p5EodcjeArnY0szqtWe/bTlE=;
        b=tEsQCNpKqbPJ1GszI9UYQvdpTWUwJRo9+c8TdRSFGjJe3xvNWN3/+5mYVQeYZeGTUl
         E9LPTljYrGwLHHt61jU+BYYBIWqzvc4vK4WS6xT/3zBzRobwN1Zn3TMxyS8KFshdbLQ6
         nEIwYDMLI4Bwn/FySzkjuwj5E0TLAZ8bwpacmcIAXzs5fsz9JFvr2EPbFPAGN0TZGA81
         qs1lBPSuRUW3CCNJiykAbRDYU/rI12igKQ+VTvSpwNjcu5irlWe7VuhtqRsKRUiUKCFC
         wLFWgq1rFqojnSW7oSNlv8nZFr+OtGgsJhZB58KTWLUoxlWABUCQy1yDWE/cZYFdp7Q7
         thZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZm5cS0Op3FLJ1htgR1p5EodcjeArnY0szqtWe/bTlE=;
        b=JeZEKPHqb6zJhR4pBpbse4hg9YzCzbDSW7A+3NgVh5OltZaOxe4ngD+8VHYtkybIft
         57yson2NyG0GSwJMRtPNQ7xbSa1qdA0wFTsMRpKj4v9JOO51bcTNX53NoiyohBfRB/2O
         KFbXKVAjb0ckGc2gwdYzT07uDSyE5bm0ziPHYKIkl/PV+UplPFUNJtyB+77Btk52ILsw
         muGSbmDAMoUAQFKjq7efMGRFTXGBhoCTfkrPuV0ZXEsbdW4WDExFwwQ0DS7Pu+AScE9f
         6esVuo5DT3bPZ6wYfH+5l/Milin1IJRNfkh3OEsdWLdfZTevLOFJYAyLgMCc8yxa0JMT
         Ekwg==
X-Gm-Message-State: AOAM531uo8iE3bozbezX3aEltrBbOT9hLiBrpclDfdrtTyQEAJtG77Lq
        fOT4hxp1Hs1oJl7PvRBGKx+KvgiiuGHnr/tM48qaAA==
X-Google-Smtp-Source: ABdhPJydZNdAGwNtBFRCQVuhsrhElqwRPaQ029byznL53KiS6oGv0a5CCtO+wcXRe+c4GA3NHpDoofI7SgXJZBgKuXE=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr4033359ybq.190.1621303513064;
 Mon, 17 May 2021 19:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175349.959661-1-surenb@google.com> <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
 <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net> <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
 <CAJuCfpH2X47_3VvfZXs_eWhYDziOh13qdUwcfxPJe=Zg_Nkvqw@mail.gmail.com>
 <CAJuCfpEznCYhjbM+1=dMdEn1J2NVw88M+4AThD99PBKg41RgTw@mail.gmail.com>
 <YKK2ZumDWcaGWvBj@cmpxchg.org> <CAJuCfpGx7w2E8Bq7jcq7HS41i40r4Lp+-z9m1P095B+MkAOWqg@mail.gmail.com>
In-Reply-To: <CAJuCfpGx7w2E8Bq7jcq7HS41i40r4Lp+-z9m1P095B+MkAOWqg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 May 2021 19:05:02 -0700
Message-ID: <CAJuCfpFW_LkqcmC_0FE8fyBY75yXYAjeLnOxU0-0R8WxksYoSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        lizefan.x@bytedance.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bristot@redhat.com,
        "Paul E . McKenney" <paulmck@kernel.org>, rdunlap@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 17, 2021 at 1:02 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, May 17, 2021 at 11:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Sun, May 16, 2021 at 12:52:32PM -0700, Suren Baghdasaryan wrote:
> > > After reworking the code to add a static key I had to expand the
> > > #ifdef CONFIG_CGROUPS section, so I think a code refactoring below
> > > would make sense. It localizes config-specific code and it has the
> > > same exact code for CONFIG_CGROUPS=n and for
> > > cgroup_psi_enabled()==false. WDYT?:
> > >
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -181,6 +181,7 @@ struct psi_group psi_system = {
> > >  };
> > >
> > >  static void psi_avgs_work(struct work_struct *work);
> > > +static void cgroup_iterator_init(void);
> > >
> > >  static void group_init(struct psi_group *group)
> > >  {
> > > @@ -211,6 +212,8 @@ void __init psi_init(void)
> > >                  return;
> > >          }
> > >
> > > +        cgroup_iterator_init();
> > > +
> > >          psi_period = jiffies_to_nsecs(PSI_FREQ);
> > >          group_init(&psi_system);
> > >  }
> > > @@ -742,11 +745,31 @@ static void psi_group_change(struct psi_group
> > > *group, int cpu,
> > >                  schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> > >  }
> > >
> > > -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> > > +static inline struct psi_group *sys_group_iterator(struct task_struct *task,
> > > +                                                   void **iter)
> > >  {
> > > +        *iter = &psi_system;
> > > +        return &psi_system;
> > > +}
> > > +
> > >  #ifdef CONFIG_CGROUPS
> > > +
> > > +DEFINE_STATIC_KEY_FALSE(psi_cgroups_disabled);
> > > +
> > > +static void cgroup_iterator_init(void)
> > > +{
> > > +        if (!cgroup_psi_enabled())
> > > +                static_branch_enable(&psi_cgroups_disabled);
> > > +}
> > > +
> > > +static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> > > +{
> > >          struct cgroup *cgroup = NULL;
> > >
> > > +        /* Skip to psi_system if per-cgroup accounting is disabled */
> > > +        if (static_branch_unlikely(&psi_cgroups_disabled))
> > > +                return *iter ? NULL : sys_group_iterator(task, iter);
> > > +
> > >          if (!*iter)
> > >                  cgroup = task->cgroups->dfl_cgrp;
> >
> > That looks over-engineered. You have to check iter whether cgroups are
> > enabled or not. Pulling the jump label check up doesn't save anything,
> > but it ends up duplicating code.
> >
> > What you had in the beginning was better, it just had the system label
> > in an unexpected place where it would check iter twice in a row.
> >
> > The (*iter == &psi_system) check inside the cgroups branch has the
> > same purpose as the (*iter) check in the else branch. We could
> > consolidate that by pulling it up front.
> >
> > If we wrap the entire cgroup iteration block into the static branch,
> > IMO it becomes a bit clearer as well.
> >
> > How about this?
> >
> > static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> > {
> >         if (*iter == &psi_system)
> >                 return NULL;
> >
> > #ifdef CONFIG_CGROUPS
> >         if (!static_branch_likely(&psi_cgroups_disabled)) {
> >                 struct cgroup *cgroup = NULL;
> >
> >                 if (!*iter)
> >                         cgroup = task->cgroups->dfl_cgrp;
> >                 else
> >                         cgroup = cgroup_parent(*iter);
> >
> >                 if (cgroup && cgroup_parent(cgroup)) {
> >                         *iter = cgroup;
> >                         return cgroup_psi(cgroup);
> >                 }
> >         }
> > #endif
> >
> >         *iter = &psi_system;
> >         return &psi_system;
> > }
>
> This looks great to me. Will use it in the next version. Thanks!

V2 is posted at https://lore.kernel.org/patchwork/patch/1430980
