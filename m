Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4738F406
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 22:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhEXUCd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhEXUCc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 May 2021 16:02:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCADC06138A
        for <cgroups@vger.kernel.org>; Mon, 24 May 2021 13:01:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f9so39734868ybo.6
        for <cgroups@vger.kernel.org>; Mon, 24 May 2021 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZ+5vap6TpdQ9AA+8AlOuVeJiXMIdG8FblxtPftSe80=;
        b=lUCYnRiJdlJz81oEEmS6qigwfCuldHB+KmDZCEx7gueXmrIhOUSb0yV2UoHH0ajGC1
         5cmVZMrop8VdUzorbhofgjMPQZ3s+BCicgNt0A65BMi9f4hMgbb/8bjN6qh43kkY0xDU
         aEohVcgMAuLxXVVAbseRBoDFIx7n4Hm82pk9KyDnoB0S6v6eNWYDtZbPAtwIqIJBWoIO
         vaxgASnC3wfqPjrDw8p+nfG4XcvOUB6v0oGY8I/AX+DrlV69rmSM9yY4zII2upcGQ9rP
         Py3cjhGUI0xJo0abcVyoUwMxWbduVErlEswKcnzqEnZqaWCHVLWGy0KS7CkW313rTE8F
         TZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZ+5vap6TpdQ9AA+8AlOuVeJiXMIdG8FblxtPftSe80=;
        b=YW2sTGSfhr1hI4/Ycts0wrfPHCWWzlxwBgnV0HWlooGyY3fCBIyCnZ+ELSa2Hty2Qr
         Q9jU3tQSIh5+5XQ6UM42SrEYs8iKsfdjBQCa7v6LM16/TwKOJFEGMbk3g8rgHtMnns9L
         wm1UIWrwhHEMayXOAHufmJ7XUPrg9rg9Nqic43uNX2SwZDFQ5X5W6o75jauKQZQK6i2c
         wSkAos4cqvJ8pkkV7qM6ELU8xlofYkOL++JgXRaxMxUKAw0c9b/HhU/QCsKlA3wKCnjb
         qLbUWmA5JtoG1tzSCkZPEsavDfTd922TW19Y+aA42SjT/icSBqjcwuw1xj8hD+eXAq4X
         MleA==
X-Gm-Message-State: AOAM531d3Ao2d+h866NK1T12nNKxZbS1Obvw/HeJoYn5D2FRtfb2S2m3
        ORfIpAvcXgXBV+EPLerzlPtfBKMM1yo9h2XgxYvTfA==
X-Google-Smtp-Source: ABdhPJxrREXfDKjc6rES+0uTFx1TCFqq8cQ1It1ADXoFJ4g1eG4QNJUd22iAdXv311VMZSnryNDhbujDEGAlY2XxZeM=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr31853780ybg.111.1621886461338;
 Mon, 24 May 2021 13:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210524195339.1233449-1-surenb@google.com>
In-Reply-To: <20210524195339.1233449-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 24 May 2021 13:00:50 -0700
Message-ID: <CAJuCfpE-HM7Sv+J15bSMqHnmSOKsP_2CKXWWJVjmbz8-g=NMLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 24, 2021 at 12:53 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> PSI accounts stalls for each cgroup separately and aggregates it at each
> level of the hierarchy. This causes additional overhead with psi_avgs_work
> being called for each cgroup in the hierarchy. psi_avgs_work has been
> highly optimized, however on systems with large number of cgroups the
> overhead becomes noticeable.
> Systems which use PSI only at the system level could avoid this overhead
> if PSI can be configured to skip per-cgroup stall accounting.
> Add "cgroup_disable=pressure" kernel command-line option to allow
> requesting system-wide only pressure stall accounting. When set, it
> keeps system-wide accounting under /proc/pressure/ but skips accounting
> for individual cgroups and does not expose PSI nodes in cgroup hierarchy.

Tejun and other cgroup experts, could you please take a look at the
cgroup-related parts of this patch and provide your feedback? Would
greatly appreciate your opinion on this.
Thanks!

>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v3:
> - Replaced psi_cgroups_disabled with psi_cgroups_enabled key, per PeterZ
> - Rebased to ToT after cgroup tree merge
> - Added "Disabling ... control group feature" message in cgroup_disable()
>   similar to the new message generated when a cgroup gets disabled
>
>  .../admin-guide/kernel-parameters.txt         |  9 +++-
>  include/linux/cgroup-defs.h                   |  1 +
>  include/linux/cgroup.h                        |  7 +++
>  kernel/cgroup/cgroup.c                        | 48 +++++++++++++++++++
>  kernel/sched/psi.c                            | 30 +++++++-----
>  5 files changed, 80 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..653c62142f07 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -497,16 +497,21 @@
>         ccw_timeout_log [S390]
>                         See Documentation/s390/common_io.rst for details.
>
> -       cgroup_disable= [KNL] Disable a particular controller
> -                       Format: {name of the controller(s) to disable}
> +       cgroup_disable= [KNL] Disable a particular controller or optional feature
> +                       Format: {name of the controller(s) or feature(s) to disable}
>                         The effects of cgroup_disable=foo are:
>                         - foo isn't auto-mounted if you mount all cgroups in
>                           a single hierarchy
>                         - foo isn't visible as an individually mountable
>                           subsystem
> +                       - if foo is an optional feature then the feature is
> +                         disabled and corresponding cgroup files are not
> +                         created
>                         {Currently only "memory" controller deal with this and
>                         cut the overhead, others just disable the usage. So
>                         only cgroup_disable=memory is actually worthy}
> +                       Specifying "pressure" disables per-cgroup pressure
> +                       stall information accounting feature
>
>         cgroup_no_v1=   [KNL] Disable cgroup controllers and named hierarchies in v1
>                         Format: { { controller | "all" | "named" }
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index fb8f6d2cd104..5a9d898daecb 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -110,6 +110,7 @@ enum {
>         CFTYPE_NO_PREFIX        = (1 << 3),     /* (DON'T USE FOR NEW FILES) no subsys prefix */
>         CFTYPE_WORLD_WRITABLE   = (1 << 4),     /* (DON'T USE FOR NEW FILES) S_IWUGO */
>         CFTYPE_DEBUG            = (1 << 5),     /* create when cgroup_debug */
> +       CFTYPE_PRESSURE         = (1 << 6),     /* only if pressure feature is enabled */
>
>         /* internal flags, do not use outside cgroup core proper */
>         __CFTYPE_ONLY_ON_DFL    = (1 << 16),    /* only on default hierarchy */
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 6bc9c76680b2..5492fcb7f9ca 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -676,6 +676,8 @@ static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
>         return &cgrp->psi;
>  }
>
> +bool cgroup_psi_enabled(void);
> +
>  static inline void cgroup_init_kthreadd(void)
>  {
>         /*
> @@ -735,6 +737,11 @@ static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
>         return NULL;
>  }
>
> +static inline bool cgroup_psi_enabled(void)
> +{
> +       return false;
> +}
> +
>  static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
>                                                struct cgroup *ancestor)
>  {
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 21ecc6ee6a6d..3a15a8407b46 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -209,6 +209,22 @@ struct cgroup_namespace init_cgroup_ns = {
>  static struct file_system_type cgroup2_fs_type;
>  static struct cftype cgroup_base_files[];
>
> +/* cgroup optional features */
> +enum cgroup_opt_features {
> +#ifdef CONFIG_PSI
> +       OPT_FEATURE_PRESSURE,
> +#endif
> +       OPT_FEATURE_COUNT
> +};
> +
> +static const char *cgroup_opt_feature_names[OPT_FEATURE_COUNT] = {
> +#ifdef CONFIG_PSI
> +       "pressure",
> +#endif
> +};
> +
> +static u16 cgroup_feature_disable_mask __read_mostly;
> +
>  static int cgroup_apply_control(struct cgroup *cgrp);
>  static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
>  static void css_task_iter_skip(struct css_task_iter *it,
> @@ -3631,6 +3647,18 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
>  {
>         psi_trigger_replace(&of->priv, NULL);
>  }
> +
> +bool cgroup_psi_enabled(void)
> +{
> +       return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
> +}
> +
> +#else /* CONFIG_PSI */
> +bool cgroup_psi_enabled(void)
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_PSI */
>
>  static int cgroup_freeze_show(struct seq_file *seq, void *v)
> @@ -3881,6 +3909,8 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
>  restart:
>         for (cft = cfts; cft != cft_end && cft->name[0] != '\0'; cft++) {
>                 /* does cft->flags tell us to skip this file on @cgrp? */
> +               if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
> +                       continue;
>                 if ((cft->flags & __CFTYPE_ONLY_ON_DFL) && !cgroup_on_dfl(cgrp))
>                         continue;
>                 if ((cft->flags & __CFTYPE_NOT_ON_DFL) && cgroup_on_dfl(cgrp))
> @@ -3958,6 +3988,9 @@ static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
>
>                 WARN_ON(cft->ss || cft->kf_ops);
>
> +               if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
> +                       continue;
> +
>                 if (cft->seq_start)
>                         kf_ops = &cgroup_kf_ops;
>                 else
> @@ -4866,6 +4899,7 @@ static struct cftype cgroup_base_files[] = {
>  #ifdef CONFIG_PSI
>         {
>                 .name = "io.pressure",
> +               .flags = CFTYPE_PRESSURE,
>                 .seq_show = cgroup_io_pressure_show,
>                 .write = cgroup_io_pressure_write,
>                 .poll = cgroup_pressure_poll,
> @@ -4873,6 +4907,7 @@ static struct cftype cgroup_base_files[] = {
>         },
>         {
>                 .name = "memory.pressure",
> +               .flags = CFTYPE_PRESSURE,
>                 .seq_show = cgroup_memory_pressure_show,
>                 .write = cgroup_memory_pressure_write,
>                 .poll = cgroup_pressure_poll,
> @@ -4880,6 +4915,7 @@ static struct cftype cgroup_base_files[] = {
>         },
>         {
>                 .name = "cpu.pressure",
> +               .flags = CFTYPE_PRESSURE,
>                 .seq_show = cgroup_cpu_pressure_show,
>                 .write = cgroup_cpu_pressure_write,
>                 .poll = cgroup_pressure_poll,
> @@ -6213,6 +6249,15 @@ static int __init cgroup_disable(char *str)
>                         pr_info("Disabling %s control group subsystem\n",
>                                 ss->name);
>                 }
> +
> +               for (i = 0; i < OPT_FEATURE_COUNT; i++) {
> +                       if (strcmp(token, cgroup_opt_feature_names[i]))
> +                               continue;
> +                       cgroup_feature_disable_mask |= 1 << i;
> +                       pr_info("Disabling %s control group feature\n",
> +                               cgroup_opt_feature_names[i]);
> +                       break;
> +               }
>         }
>         return 1;
>  }
> @@ -6511,6 +6556,9 @@ static ssize_t show_delegatable_files(struct cftype *files, char *buf,
>                 if (!(cft->flags & CFTYPE_NS_DELEGATABLE))
>                         continue;
>
> +               if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
> +                       continue;
> +
>                 if (prefix)
>                         ret += snprintf(buf + ret, size - ret, "%s.", prefix);
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3cff41f..b773cae4c24b 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -148,6 +148,7 @@
>  static int psi_bug __read_mostly;
>
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> +DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
>
>  #ifdef CONFIG_PSI_DEFAULT_DISABLED
>  static bool psi_enable;
> @@ -211,6 +212,9 @@ void __init psi_init(void)
>                 return;
>         }
>
> +       if (!cgroup_psi_enabled())
> +               static_branch_disable(&psi_cgroups_enabled);
> +
>         psi_period = jiffies_to_nsecs(PSI_FREQ);
>         group_init(&psi_system);
>  }
> @@ -744,23 +748,23 @@ static void psi_group_change(struct psi_group *group, int cpu,
>
>  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>  {
> +       if (*iter == &psi_system)
> +               return NULL;
> +
>  #ifdef CONFIG_CGROUPS
> -       struct cgroup *cgroup = NULL;
> +       if (static_branch_likely(&psi_cgroups_enabled)) {
> +               struct cgroup *cgroup = NULL;
>
> -       if (!*iter)
> -               cgroup = task->cgroups->dfl_cgrp;
> -       else if (*iter == &psi_system)
> -               return NULL;
> -       else
> -               cgroup = cgroup_parent(*iter);
> +               if (!*iter)
> +                       cgroup = task->cgroups->dfl_cgrp;
> +               else
> +                       cgroup = cgroup_parent(*iter);
>
> -       if (cgroup && cgroup_parent(cgroup)) {
> -               *iter = cgroup;
> -               return cgroup_psi(cgroup);
> +               if (cgroup && cgroup_parent(cgroup)) {
> +                       *iter = cgroup;
> +                       return cgroup_psi(cgroup);
> +               }
>         }
> -#else
> -       if (*iter)
> -               return NULL;
>  #endif
>         *iter = &psi_system;
>         return &psi_system;
> --
> 2.31.1.818.g46aad6cb9e-goog
>
