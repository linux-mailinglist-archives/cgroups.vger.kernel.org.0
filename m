Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B93820AF
	for <lists+cgroups@lfdr.de>; Sun, 16 May 2021 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhEPTyA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 May 2021 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhEPTyA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 May 2021 15:54:00 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BDC061756
        for <cgroups@vger.kernel.org>; Sun, 16 May 2021 12:52:45 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f9so5815648ybo.6
        for <cgroups@vger.kernel.org>; Sun, 16 May 2021 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ary7evgK4Fh3+VZ9pLClSDOtxVZVMHZj5tal7jSEQk=;
        b=f9VUOZsjcrG9gjdHkeYERV0/ckFtVT8c6UIwDfhXIlDktIPZZROcEeDXLSZn+Rzckl
         GQuEkBLZJ2SNsfBTMA/UP3HSllQWaUswDdeqKWbiVObO2Nr9H3iikelavi383mc8T42z
         dGnsJc/P+rAZzMoHtAFuhG+pZeBBqiEH73CaSfOFhJhd+DV48OZ96919RGvuGTtfkvMd
         0eZkjT3P26nh0t7/MNn3TGoMPU6Ig64h2kVlmW3+3egHz+LqfBhxjbjsydygU7PN/cAl
         4MUcUN340G/9KRVoPwaQ/8a1SmJLC1DEAqpk4EyoU7kmRSLYwIJEgxUyVED14iVjsCTN
         clZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ary7evgK4Fh3+VZ9pLClSDOtxVZVMHZj5tal7jSEQk=;
        b=GFQcwplAIAocoba4vqV9Wr6Drt5Xm9G5p4aJJAhiYh17TLUkF/HjWTxE513Mb5pLhO
         jO/ZnF8oxvS9VsCoLIhmBLjsAXo+TFXhoz6EFz+Izfs0mbmn1Ffeeekv+2XCf1wiIhxB
         NvfNsRNRpfaYliy9bKKNVxsANLqhSvm1ks/BqRp69vu0JoK9i53DoCyA4RLlIhglBzX6
         Y3pO2cXJN6RWXDbwwUL86CIJ/NtqD6UFu5aRsWTrhFqQPn8b9yoyoUD9Ukd4nxGKZdDJ
         cTwjUZ7NxU1DXjpVcwTZSI6Hx0JmQiPUP4jHroy3BUWRx3s8SfHXhwhTxxNpCaTFi5ZW
         1iQQ==
X-Gm-Message-State: AOAM533RQ0EFzuK8MpQNlEUq8ymuH/We+w1Dj+ohvoFP7syEcqQjGBQe
        hk1ObMBlfj3PtBMkk49jmotKwZOoFbp+URcINj0X0A==
X-Google-Smtp-Source: ABdhPJwfGwZ2UTn/G2RMe7lKFZ6wNjVtknbYnmx3uaedE35QmNaaKDKPFa0bVuEpjOCvc/CFOhUwT0ycqr6d9SGnYng=
X-Received: by 2002:a25:9c88:: with SMTP id y8mr58063072ybo.294.1621194763585;
 Sun, 16 May 2021 12:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175349.959661-1-surenb@google.com> <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
 <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net> <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
 <CAJuCfpH2X47_3VvfZXs_eWhYDziOh13qdUwcfxPJe=Zg_Nkvqw@mail.gmail.com>
In-Reply-To: <CAJuCfpH2X47_3VvfZXs_eWhYDziOh13qdUwcfxPJe=Zg_Nkvqw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 16 May 2021 12:52:32 -0700
Message-ID: <CAJuCfpEznCYhjbM+1=dMdEn1J2NVw88M+4AThD99PBKg41RgTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
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

On Fri, May 14, 2021 at 11:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, May 14, 2021 at 11:20 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, May 14, 2021 at 10:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, May 14, 2021 at 08:54:47AM -0700, Suren Baghdasaryan wrote:
> > >
> > > > Correct, for this function CONFIG_CGROUPS=n and
> > > > cgroup_disable=pressure are treated the same. True, from the code it's
> > > > not very obvious. Do you have some refactoring in mind that would make
> > > > it more explicit?
> > >
> > > Does this make sense?
> > >
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -744,24 +744,26 @@ static void psi_group_change(struct psi_
> > >
> > >  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> > >  {
> > > +       if (cgroup_psi_enabled()) {
> > >  #ifdef CONFIG_CGROUPS
> > > -       struct cgroup *cgroup = NULL;
> > > +               struct cgroup *cgroup = NULL;
> > >
> > > -       if (!*iter)
> > > -               cgroup = task->cgroups->dfl_cgrp;
> > > -       else if (*iter == &psi_system)
> > > -               return NULL;
> > > -       else
> > > -               cgroup = cgroup_parent(*iter);
> > > +               if (!*iter)
> > > +                       cgroup = task->cgroups->dfl_cgrp;
> > > +               else if (*iter == &psi_system)
> > > +                       return NULL;
> > > +               else
> > > +                       cgroup = cgroup_parent(*iter);
> > >
> > > -       if (cgroup && cgroup_parent(cgroup)) {
> > > -               *iter = cgroup;
> > > -               return cgroup_psi(cgroup);
> > > -       }
> > > -#else
> > > -       if (*iter)
> > > -               return NULL;
> > > +               if (cgroup && cgroup_parent(cgroup)) {
> > > +                       *iter = cgroup;
> > > +                       return cgroup_psi(cgroup);
> > > +               }
> > >  #endif
> > > +       } else {
> > > +               if (*iter)
> > > +                       return NULL;
> > > +       }
> > >         *iter = &psi_system;
> > >         return &psi_system;
> > >  }
> >
> > Hmm. Looks like the case when cgroup_psi_enabled()==true and
> > CONFIG_CGROUPS=n would miss the "if (*iter) return NULL;" condition.
> > Effectively with CONFIG_CGROUPS=n this becomes:
> >
> >        if (cgroup_psi_enabled()) {           <== assume this is true
> > #ifdef CONFIG_CGROUPS                <== compiled out
> > #endif
> >        } else {
> >                if (*iter)                                  <== this
> > statement will never execute
> >                        return NULL;
> >        }
> >        *iter = &psi_system;
> >         return &psi_system;
> >
>
> Ah, sorry. I forgot that CONFIG_CGROUPS=n would force
> cgroup_psi_enabled()==false (the way function is defined in cgroup.h),
> so (CONFIG_CGROUPS=n && cgroup_psi_enabled()==true) is an invalid
> configuration. I think adding a comment to your suggestion would make
> it more clear.
> So your suggestion seems to work. I'll test it and include it in the
> next revision. Thanks!

After reworking the code to add a static key I had to expand the
#ifdef CONFIG_CGROUPS section, so I think a code refactoring below
would make sense. It localizes config-specific code and it has the
same exact code for CONFIG_CGROUPS=n and for
cgroup_psi_enabled()==false. WDYT?:

--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -181,6 +181,7 @@ struct psi_group psi_system = {
 };

 static void psi_avgs_work(struct work_struct *work);
+static void cgroup_iterator_init(void);

 static void group_init(struct psi_group *group)
 {
@@ -211,6 +212,8 @@ void __init psi_init(void)
                 return;
         }

+        cgroup_iterator_init();
+
         psi_period = jiffies_to_nsecs(PSI_FREQ);
         group_init(&psi_system);
 }
@@ -742,11 +745,31 @@ static void psi_group_change(struct psi_group
*group, int cpu,
                 schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }

-static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+static inline struct psi_group *sys_group_iterator(struct task_struct *task,
+                                                   void **iter)
 {
+        *iter = &psi_system;
+        return &psi_system;
+}
+
 #ifdef CONFIG_CGROUPS
+
+DEFINE_STATIC_KEY_FALSE(psi_cgroups_disabled);
+
+static void cgroup_iterator_init(void)
+{
+        if (!cgroup_psi_enabled())
+                static_branch_enable(&psi_cgroups_disabled);
+}
+
+static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+{
         struct cgroup *cgroup = NULL;

+        /* Skip to psi_system if per-cgroup accounting is disabled */
+        if (static_branch_unlikely(&psi_cgroups_disabled))
+                return *iter ? NULL : sys_group_iterator(task, iter);
+
         if (!*iter)
                 cgroup = task->cgroups->dfl_cgrp;
         else if (*iter == &psi_system)
@@ -758,14 +781,20 @@ static struct psi_group *iterate_groups(struct
task_struct *task, void **iter)
                 *iter = cgroup;
                 return cgroup_psi(cgroup);
         }
-#else
-        if (*iter)
-                return NULL;
-#endif
-        *iter = &psi_system;
-        return &psi_system;
+
+        return sys_group_iterator(task, iter);
 }

+#else /* CONFIG_CGROUPS */
+static inline void cgroup_iterator_init(void) {}
+
+static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+{
+        return *iter ? NULL : sys_group_iterator(task, iter);
+}
+
+#endif /* CONFIG_CGROUPS */
+


>
>
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > >
