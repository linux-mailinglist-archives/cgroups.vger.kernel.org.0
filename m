Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A340A5DEC
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 01:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfIBXDO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 19:03:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfIBXDN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 19:03:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id k2so14584721wmj.4
        for <cgroups@vger.kernel.org>; Mon, 02 Sep 2019 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/VblNVBjhCk9ht4C6VUiT6zIFA+My7CdyIPrVmDrwc=;
        b=ArQskKo0KTCyeZhYPTIdWTnHIKtr9+pVHPDjmeESnkIqcuBtP28F0nyx0Gn3ODC85o
         3Ojzg4uIuUmHTRFy02OOGT1+dVEEPT6wbKS5JwwK2Y3ukBBhn4YaASwblobwOsNCr5kX
         mKs8foX93xDLxIBC7ITZZRpS+EOtQROG+R3delbG0wL2RkGdZbHbmfXOct+p/0ircmYK
         2Yhk6Ra8DfR4fDBNA8x7VktTXft3/FhPRh9UQBdc8vOl1QOzZTSBgpKaHH20yomjBqhS
         /9wvoJkhlHPQBQE0h6yjYIyh/udPIjvBu3eFSw+0mFifmsoQPME8DZSNEqeHsFX/NoU7
         VX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/VblNVBjhCk9ht4C6VUiT6zIFA+My7CdyIPrVmDrwc=;
        b=slxEBpbOZCRpH92fW3NRUDKuIgqcxnRBESYuyWMcdwmjjbcgGCPtbmuqkXrK3udhwv
         dzxmzQkb1g8N0yDT/e0OdatEKqnvVX5qeGEJsiyuSDdOWfvHaZWeImn0lGAlcl5UEdX9
         Pjdyq1dJ9HMbrAX9z5DujE6a3dg2JivBTU2oTWDWoUJGNLKHxdV1xvV65sf0ydoD3UPj
         XR1fI2S8exb/DmWFaJCGASs0J8he5NXAejMn8c1SIaycKdZXMCrPKyN+zBx5UGGoSKJw
         6r1vP7suFJAu8BY6Ul8dcN/c7EEvK6CDVDeHSu272xsoP4RlAKdXxrL/LC/FqemwkpVd
         3vbA==
X-Gm-Message-State: APjAAAXbxpCsUBqII/Ooue7Uy5x5v2HnsbU1MoqAP6o3CiYi91DuWsaM
        TBO/N6fVlr9HzxxCG7BwiIHMJRUuhGO3hKFeuS/Hig==
X-Google-Smtp-Source: APXvYqwW8DZZ2+PdmJpxYA8t+oqhRiPt6J4v1q8gTD4EQjq+XxTmbKMzAqYDff165GWyHKMDRVWBXRaBDJ3afp6olYQ=
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr39609473wmf.176.1567465388518;
 Mon, 02 Sep 2019 16:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190822132811.31294-1-patrick.bellasi@arm.com> <20190822132811.31294-2-patrick.bellasi@arm.com>
In-Reply-To: <20190822132811.31294-2-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Sep 2019 16:02:57 -0700
Message-ID: <CAJuCfpGWtrg02LNE3PJZag9-LLVT=by2v+9x_tm1PyoXwZ8DqQ@mail.gmail.com>
Subject: Re: [PATCH v14 1/6] sched/core: uclamp: Extend CPU's cgroup controller
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Patrick,

On Thu, Aug 22, 2019 at 6:28 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> The cgroup CPU bandwidth controller allows to assign a specified
> (maximum) bandwidth to the tasks of a group. However this bandwidth is
> defined and enforced only on a temporal base, without considering the
> actual frequency a CPU is running on. Thus, the amount of computation
> completed by a task within an allocated bandwidth can be very different
> depending on the actual frequency the CPU is running that task.
> The amount of computation can be affected also by the specific CPU a
> task is running on, especially when running on asymmetric capacity
> systems like Arm's big.LITTLE.
>
> With the availability of schedutil, the scheduler is now able
> to drive frequency selections based on actual task utilization.
> Moreover, the utilization clamping support provides a mechanism to
> bias the frequency selection operated by schedutil depending on
> constraints assigned to the tasks currently RUNNABLE on a CPU.
>
> Giving the mechanisms described above, it is now possible to extend the
> cpu controller to specify the minimum (or maximum) utilization which
> should be considered for tasks RUNNABLE on a cpu.
> This makes it possible to better defined the actual computational
> power assigned to task groups, thus improving the cgroup CPU bandwidth
> controller which is currently based just on time constraints.
>
> Extend the CPU controller with a couple of new attributes uclamp.{min,max}
> which allow to enforce utilization boosting and capping for all the
> tasks in a group.
>
> Specifically:
>
> - uclamp.min: defines the minimum utilization which should be considered
>               i.e. the RUNNABLE tasks of this group will run at least at a
>                  minimum frequency which corresponds to the uclamp.min
>                  utilization
>
> - uclamp.max: defines the maximum utilization which should be considered
>               i.e. the RUNNABLE tasks of this group will run up to a
>                  maximum frequency which corresponds to the uclamp.max
>                  utilization
>
> These attributes:
>
> a) are available only for non-root nodes, both on default and legacy
>    hierarchies, while system wide clamps are defined by a generic
>    interface which does not depends on cgroups. This system wide
>    interface enforces constraints on tasks in the root node.
>
> b) enforce effective constraints at each level of the hierarchy which
>    are a restriction of the group requests considering its parent's
>    effective constraints. Root group effective constraints are defined
>    by the system wide interface.
>    This mechanism allows each (non-root) level of the hierarchy to:
>    - request whatever clamp values it would like to get
>    - effectively get only up to the maximum amount allowed by its parent
>
> c) have higher priority than task-specific clamps, defined via
>    sched_setattr(), thus allowing to control and restrict task requests.
>
> Add two new attributes to the cpu controller to collect "requested"
> clamp values. Allow that at each non-root level of the hierarchy.
> Keep it simple by not caring now about "effective" values computation
> and propagation along the hierarchy.
>
> Update sysctl_sched_uclamp_handler() to use the newly introduced
> uclamp_mutex so that we serialize system default updates with cgroup
> relate updates.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Michal Koutny <mkoutny@suse.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
>
> ---
> Changes in v14:
>  Message-ID: <20190806161133.GA18532@blackbody.suse.cz>
>  - move uclamp_mutex usage here from the following patch
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  34 +++++
>  init/Kconfig                            |  22 +++
>  kernel/sched/core.c                     | 188 +++++++++++++++++++++++-
>  kernel/sched/sched.h                    |   8 +
>  4 files changed, 248 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3b29005aa981..5f1c266131b0 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -951,6 +951,13 @@ controller implements weight and absolute bandwidth limit models for
>  normal scheduling policy and absolute bandwidth allocation model for
>  realtime scheduling policy.
>
> +In all the above models, cycles distribution is defined only on a temporal
> +base and it does not account for the frequency at which tasks are executed.
> +The (optional) utilization clamping support allows to hint the schedutil
> +cpufreq governor about the minimum desired frequency which should always be
> +provided by a CPU, as well as the maximum desired frequency, which should not
> +be exceeded by a CPU.
> +
>  WARNING: cgroup2 doesn't yet support control of realtime processes and
>  the cpu controller can only be enabled when all RT processes are in
>  the root cgroup.  Be aware that system management software may already
> @@ -1016,6 +1023,33 @@ All time durations are in microseconds.
>         Shows pressure stall information for CPU. See
>         Documentation/accounting/psi.rst for details.
>
> +  cpu.uclamp.min
> +        A read-write single value file which exists on non-root cgroups.
> +        The default is "0", i.e. no utilization boosting.
> +
> +        The requested minimum utilization (protection) as a percentage
> +        rational number, e.g. 12.34 for 12.34%.
> +
> +        This interface allows reading and setting minimum utilization clamp
> +        values similar to the sched_setattr(2). This minimum utilization
> +        value is used to clamp the task specific minimum utilization clamp.
> +
> +        The requested minimum utilization (protection) is always capped by
> +        the current value for the maximum utilization (limit), i.e.
> +        `cpu.uclamp.max`.
> +
> +  cpu.uclamp.max
> +        A read-write single value file which exists on non-root cgroups.
> +        The default is "max". i.e. no utilization capping
> +
> +        The requested maximum utilization (limit) as a percentage rational
> +        number, e.g. 98.76 for 98.76%.
> +
> +        This interface allows reading and setting maximum utilization clamp
> +        values similar to the sched_setattr(2). This maximum utilization
> +        value is used to clamp the task specific maximum utilization clamp.
> +
> +
>
>  Memory
>  ------
> diff --git a/init/Kconfig b/init/Kconfig
> index bd7d650d4a99..ac285cfa78b6 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -928,6 +928,28 @@ config RT_GROUP_SCHED
>
>  endif #CGROUP_SCHED
>
> +config UCLAMP_TASK_GROUP
> +       bool "Utilization clamping per group of tasks"
> +       depends on CGROUP_SCHED
> +       depends on UCLAMP_TASK
> +       default n
> +       help
> +         This feature enables the scheduler to track the clamped utilization
> +         of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> +
> +         When this option is enabled, the user can specify a min and max
> +         CPU bandwidth which is allowed for each single task in a group.
> +         The max bandwidth allows to clamp the maximum frequency a task
> +         can use, while the min bandwidth allows to define a minimum
> +         frequency a task will always use.
> +
> +         When task group based utilization clamping is enabled, an eventually
> +         specified task-specific clamp value is constrained by the cgroup
> +         specified clamp value. Both minimum and maximum task clamping cannot
> +         be bigger than the corresponding clamping defined at task group level.
> +
> +         If in doubt, say N.
> +
>  config CGROUP_PIDS
>         bool "PIDs controller"
>         help
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a6661852907b..7b610e1a4cda 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -773,6 +773,18 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>  }
>
>  #ifdef CONFIG_UCLAMP_TASK
> +/*
> + * Serializes updates of utilization clamp values
> + *
> + * The (slow-path) user-space triggers utilization clamp value updates which
> + * can require updates on (fast-path) scheduler's data structures used to
> + * support enqueue/dequeue operations.
> + * While the per-CPU rq lock protects fast-path update operations, user-space
> + * requests are serialized using a mutex to reduce the risk of conflicting
> + * updates or API abuses.
> + */
> +static DEFINE_MUTEX(uclamp_mutex);
> +
>  /* Max allowed minimum utilization */
>  unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
>
> @@ -1010,10 +1022,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>                                 loff_t *ppos)
>  {
>         int old_min, old_max;
> -       static DEFINE_MUTEX(mutex);
>         int result;
>
> -       mutex_lock(&mutex);
> +       mutex_lock(&uclamp_mutex);
>         old_min = sysctl_sched_uclamp_util_min;
>         old_max = sysctl_sched_uclamp_util_max;
>
> @@ -1048,7 +1059,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>         sysctl_sched_uclamp_util_min = old_min;
>         sysctl_sched_uclamp_util_max = old_max;
>  done:
> -       mutex_unlock(&mutex);
> +       mutex_unlock(&uclamp_mutex);
>
>         return result;
>  }
> @@ -1137,6 +1148,8 @@ static void __init init_uclamp(void)
>         unsigned int clamp_id;
>         int cpu;
>
> +       mutex_init(&uclamp_mutex);
> +
>         for_each_possible_cpu(cpu) {
>                 memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
>                 cpu_rq(cpu)->uclamp_flags = 0;
> @@ -1149,8 +1162,12 @@ static void __init init_uclamp(void)
>
>         /* System defaults allow max clamp values for both indexes */
>         uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX), false);
> -       for_each_clamp_id(clamp_id)
> +       for_each_clamp_id(clamp_id) {
>                 uclamp_default[clamp_id] = uc_max;
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +               root_task_group.uclamp_req[clamp_id] = uc_max;
> +#endif
> +       }
>  }
>
>  #else /* CONFIG_UCLAMP_TASK */
> @@ -6798,6 +6815,19 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
>  /* task_group_lock serializes the addition/removal of task groups */
>  static DEFINE_SPINLOCK(task_group_lock);
>
> +static inline void alloc_uclamp_sched_group(struct task_group *tg,
> +                                           struct task_group *parent)
> +{
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       int clamp_id;
> +
> +       for_each_clamp_id(clamp_id) {
> +               uclamp_se_set(&tg->uclamp_req[clamp_id],
> +                             uclamp_none(clamp_id), false);
> +       }
> +#endif
> +}
> +
>  static void sched_free_group(struct task_group *tg)
>  {
>         free_fair_sched_group(tg);
> @@ -6821,6 +6851,8 @@ struct task_group *sched_create_group(struct task_group *parent)
>         if (!alloc_rt_sched_group(tg, parent))
>                 goto err;
>
> +       alloc_uclamp_sched_group(tg, parent);
> +
>         return tg;
>
>  err:
> @@ -7037,6 +7069,126 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>                 sched_move_task(task);
>  }
>
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +
> +#define _POW10(exp) ((unsigned int)1e##exp)
> +#define POW10(exp) _POW10(exp)
> +
> +struct uclamp_request {
> +#define UCLAMP_PERCENT_SHIFT   2
> +#define UCLAMP_PERCENT_SCALE   (100 * POW10(UCLAMP_PERCENT_SHIFT))
> +       s64 percent;
> +       u64 util;
> +       int ret;
> +};
> +
> +static inline struct uclamp_request
> +capacity_from_percent(char *buf)
> +{
> +       struct uclamp_request req = {
> +               .percent = UCLAMP_PERCENT_SCALE,
> +               .util = SCHED_CAPACITY_SCALE,
> +               .ret = 0,
> +       };
> +
> +       buf = strim(buf);
> +       if (strncmp("max", buf, 4)) {
> +               req.ret = cgroup_parse_float(buf, UCLAMP_PERCENT_SHIFT,
> +                                            &req.percent);
> +               if (req.ret)
> +                       return req;
> +               if (req.percent > UCLAMP_PERCENT_SCALE) {
> +                       req.ret = -ERANGE;
> +                       return req;
> +               }
> +
> +               req.util = req.percent << SCHED_CAPACITY_SHIFT;
> +               req.util = DIV_ROUND_CLOSEST_ULL(req.util, UCLAMP_PERCENT_SCALE);
> +       }
> +
> +       return req;
> +}
> +
> +static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
> +                               size_t nbytes, loff_t off,
> +                               enum uclamp_id clamp_id)
> +{
> +       struct uclamp_request req;
> +       struct task_group *tg;
> +
> +       req = capacity_from_percent(buf);
> +       if (req.ret)
> +               return req.ret;
> +
> +       mutex_lock(&uclamp_mutex);
> +       rcu_read_lock();
> +
> +       tg = css_tg(of_css(of));
> +       if (tg->uclamp_req[clamp_id].value != req.util)
> +               uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
> +
> +       /*
> +        * Because of not recoverable conversion rounding we keep track of the
> +        * exact requested value
> +        */
> +       tg->uclamp_pct[clamp_id] = req.percent;
> +
> +       rcu_read_unlock();
> +       mutex_unlock(&uclamp_mutex);
> +
> +       return nbytes;
> +}
> +
> +static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
> +                                   char *buf, size_t nbytes,
> +                                   loff_t off)
> +{
> +       return cpu_uclamp_write(of, buf, nbytes, off, UCLAMP_MIN);
> +}
> +
> +static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
> +                                   char *buf, size_t nbytes,
> +                                   loff_t off)
> +{
> +       return cpu_uclamp_write(of, buf, nbytes, off, UCLAMP_MAX);
> +}
> +
> +static inline void cpu_uclamp_print(struct seq_file *sf,
> +                                   enum uclamp_id clamp_id)
> +{
> +       struct task_group *tg;
> +       u64 util_clamp;
> +       u64 percent;
> +       u32 rem;
> +
> +       rcu_read_lock();
> +       tg = css_tg(seq_css(sf));
> +       util_clamp = tg->uclamp_req[clamp_id].value;
> +       rcu_read_unlock();
> +
> +       if (util_clamp == SCHED_CAPACITY_SCALE) {
> +               seq_puts(sf, "max\n");
> +               return;
> +       }
> +
> +       percent = tg->uclamp_pct[clamp_id];

You are taking RCU lock when accessing tg->uclamp_req but not when
accessing tg->uclamp_pct. Is that intentional? Can tg be destroyed
under you?

> +       percent = div_u64_rem(percent, POW10(UCLAMP_PERCENT_SHIFT), &rem);
> +       seq_printf(sf, "%llu.%0*u\n", percent, UCLAMP_PERCENT_SHIFT, rem);
> +}
> +
> +static int cpu_uclamp_min_show(struct seq_file *sf, void *v)
> +{
> +       cpu_uclamp_print(sf, UCLAMP_MIN);
> +       return 0;
> +}
> +
> +static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
> +{
> +       cpu_uclamp_print(sf, UCLAMP_MAX);
> +       return 0;
> +}
> +#endif /* CONFIG_UCLAMP_TASK_GROUP */
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
>                                 struct cftype *cftype, u64 shareval)
> @@ -7381,6 +7533,20 @@ static struct cftype cpu_legacy_files[] = {
>                 .read_u64 = cpu_rt_period_read_uint,
>                 .write_u64 = cpu_rt_period_write_uint,
>         },
> +#endif
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       {
> +               .name = "uclamp.min",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .seq_show = cpu_uclamp_min_show,
> +               .write = cpu_uclamp_min_write,
> +       },
> +       {
> +               .name = "uclamp.max",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .seq_show = cpu_uclamp_max_show,
> +               .write = cpu_uclamp_max_write,
> +       },
>  #endif
>         { }     /* Terminate */
>  };
> @@ -7548,6 +7714,20 @@ static struct cftype cpu_files[] = {
>                 .seq_show = cpu_max_show,
>                 .write = cpu_max_write,
>         },
> +#endif
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       {
> +               .name = "uclamp.min",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .seq_show = cpu_uclamp_min_show,
> +               .write = cpu_uclamp_min_write,
> +       },
> +       {
> +               .name = "uclamp.max",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .seq_show = cpu_uclamp_max_show,
> +               .write = cpu_uclamp_max_write,
> +       },
>  #endif
>         { }     /* terminate */
>  };
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 7111e3a1eeb4..ae1be61fb279 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -391,6 +391,14 @@ struct task_group {
>  #endif
>
>         struct cfs_bandwidth    cfs_bandwidth;
> +
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       /* The two decimal precision [%] value requested from user-space */
> +       unsigned int            uclamp_pct[UCLAMP_CNT];
> +       /* Clamp values requested for a task group */
> +       struct uclamp_se        uclamp_req[UCLAMP_CNT];
> +#endif
> +
>  };
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> --
> 2.22.0
>
