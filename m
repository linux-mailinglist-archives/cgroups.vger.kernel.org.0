Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF3B386508
	for <lists+cgroups@lfdr.de>; Mon, 17 May 2021 22:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhEQUEH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 May 2021 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhEQUEG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 May 2021 16:04:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6851C06175F
        for <cgroups@vger.kernel.org>; Mon, 17 May 2021 13:02:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so10178845ybo.6
        for <cgroups@vger.kernel.org>; Mon, 17 May 2021 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOt8pDHxf8UyV1g+frGSSeqaqXf66O0fXn4ZHmPI4BY=;
        b=IBDLeDDyYTZmykeL/+LFDwgPTgobab9QhFzNZXP5nCatE9wX6vMPUuVFw47KyiCuJj
         s3tU2+Z6FlHGFt5jub3pypsxakKfEMMWX8JATwGw+A6DOZ7IcS97vNj0j58FP2I6dMra
         9aucHTVz60UpOes9MJ1DrxSliX2MFb2qU8bNHwF+dmLlJbtrVzgsT+g1gqcM26hZKqiP
         LdOdJAhVBxMrYEXcMZv3cYMHzJm32/KS5+qeTwTRxUFE9jek/lSR+D1+lQbN5wleKBMO
         1RICp7/Xo9U75cigVEV0k4hoFPPHitNmba1xyZzwzQ3Ij2DYpLc+nHIHgFjOFHf82Pwh
         um3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOt8pDHxf8UyV1g+frGSSeqaqXf66O0fXn4ZHmPI4BY=;
        b=S/GWEpvk3WG5s8RhGkZMvfIlt+jTbIAEVSui8DzF7xitYYAKJvx0RJxkDXDaFW8b30
         Y8Yo8R7VjlmRNS5AljsfwZiTc08vkI4/tfDDplZ0nwPkEpKO+qGzeqs4VyC7gw2okx+C
         Pq4uwJDMMCSApCSo/Bnb+itHLvf6l2p6O1jE16CGJjZd+RDAs+ts+OonXOli6hO+XfZz
         eZyp/NsI6g/IuHXg8VcA7v54mvYS32PPniDs3izZD6E+blHQfyGbDq9ZQHX9ugnVmwUs
         W/vnoUiaImzG5DS2p7gJGHN3uxydjkndJvG8ROI4i/aNHqHcj6PeHY+7xSdkFCi+p9k4
         7Y0Q==
X-Gm-Message-State: AOAM531bzlesfTSgrO6yRfDHU/+Ur3TLbtR2vT9CwE6QTxpyxzZOvfoL
        94P2aAVWWJQ9n2plEXwd+pmQdx/DIy2yW821YquG4w==
X-Google-Smtp-Source: ABdhPJwS6fAI4vrD9cHbCMoV0PUsmjjznxmSh8H/3YOVLg1P9jZ7axn+uajLPV4AvemovAOd5w3sbp0WFM4/ejFVXUc=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr2189351ybq.190.1621281767582;
 Mon, 17 May 2021 13:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175349.959661-1-surenb@google.com> <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
 <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net> <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
 <CAJuCfpH2X47_3VvfZXs_eWhYDziOh13qdUwcfxPJe=Zg_Nkvqw@mail.gmail.com>
 <CAJuCfpEznCYhjbM+1=dMdEn1J2NVw88M+4AThD99PBKg41RgTw@mail.gmail.com> <YKK2ZumDWcaGWvBj@cmpxchg.org>
In-Reply-To: <YKK2ZumDWcaGWvBj@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 May 2021 13:02:36 -0700
Message-ID: <CAJuCfpGx7w2E8Bq7jcq7HS41i40r4Lp+-z9m1P095B+MkAOWqg@mail.gmail.com>
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

On Mon, May 17, 2021 at 11:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, May 16, 2021 at 12:52:32PM -0700, Suren Baghdasaryan wrote:
> > After reworking the code to add a static key I had to expand the
> > #ifdef CONFIG_CGROUPS section, so I think a code refactoring below
> > would make sense. It localizes config-specific code and it has the
> > same exact code for CONFIG_CGROUPS=n and for
> > cgroup_psi_enabled()==false. WDYT?:
> >
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -181,6 +181,7 @@ struct psi_group psi_system = {
> >  };
> >
> >  static void psi_avgs_work(struct work_struct *work);
> > +static void cgroup_iterator_init(void);
> >
> >  static void group_init(struct psi_group *group)
> >  {
> > @@ -211,6 +212,8 @@ void __init psi_init(void)
> >                  return;
> >          }
> >
> > +        cgroup_iterator_init();
> > +
> >          psi_period = jiffies_to_nsecs(PSI_FREQ);
> >          group_init(&psi_system);
> >  }
> > @@ -742,11 +745,31 @@ static void psi_group_change(struct psi_group
> > *group, int cpu,
> >                  schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> >  }
> >
> > -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> > +static inline struct psi_group *sys_group_iterator(struct task_struct *task,
> > +                                                   void **iter)
> >  {
> > +        *iter = &psi_system;
> > +        return &psi_system;
> > +}
> > +
> >  #ifdef CONFIG_CGROUPS
> > +
> > +DEFINE_STATIC_KEY_FALSE(psi_cgroups_disabled);
> > +
> > +static void cgroup_iterator_init(void)
> > +{
> > +        if (!cgroup_psi_enabled())
> > +                static_branch_enable(&psi_cgroups_disabled);
> > +}
> > +
> > +static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> > +{
> >          struct cgroup *cgroup = NULL;
> >
> > +        /* Skip to psi_system if per-cgroup accounting is disabled */
> > +        if (static_branch_unlikely(&psi_cgroups_disabled))
> > +                return *iter ? NULL : sys_group_iterator(task, iter);
> > +
> >          if (!*iter)
> >                  cgroup = task->cgroups->dfl_cgrp;
>
> That looks over-engineered. You have to check iter whether cgroups are
> enabled or not. Pulling the jump label check up doesn't save anything,
> but it ends up duplicating code.
>
> What you had in the beginning was better, it just had the system label
> in an unexpected place where it would check iter twice in a row.
>
> The (*iter == &psi_system) check inside the cgroups branch has the
> same purpose as the (*iter) check in the else branch. We could
> consolidate that by pulling it up front.
>
> If we wrap the entire cgroup iteration block into the static branch,
> IMO it becomes a bit clearer as well.
>
> How about this?
>
> static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> {
>         if (*iter == &psi_system)
>                 return NULL;
>
> #ifdef CONFIG_CGROUPS
>         if (!static_branch_likely(&psi_cgroups_disabled)) {
>                 struct cgroup *cgroup = NULL;
>
>                 if (!*iter)
>                         cgroup = task->cgroups->dfl_cgrp;
>                 else
>                         cgroup = cgroup_parent(*iter);
>
>                 if (cgroup && cgroup_parent(cgroup)) {
>                         *iter = cgroup;
>                         return cgroup_psi(cgroup);
>                 }
>         }
> #endif
>
>         *iter = &psi_system;
>         return &psi_system;
> }

This looks great to me. Will use it in the next version. Thanks!
