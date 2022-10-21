Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAD6081D7
	for <lists+cgroups@lfdr.de>; Sat, 22 Oct 2022 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJUWwV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Oct 2022 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUWwU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Oct 2022 18:52:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635212A8A44
        for <cgroups@vger.kernel.org>; Fri, 21 Oct 2022 15:52:18 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y72so4885662yby.13
        for <cgroups@vger.kernel.org>; Fri, 21 Oct 2022 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZBQ2aQiaFbyWaj+6gHG60vNMKQG/zkRl0GYsas2Gg8=;
        b=jFz+omc2+oGz76Afirbzq/8w1C3zecHh65UaQl8SJYwvc7Y5yFiUr2Yktk3+V0vPm/
         9RtK6ZDohlC7gpuyFHkpb/E7gAlQlBE15F0sk9vGR5LkLK4Kq50Z0n9zyR4wn20f9Ymp
         bIhnqsSW0YaRwBthfNfvgHGHAwqpbyNPOO5mdVB0pUKX5R4rnxYrkh2QhxXZ73i7OVmo
         +TJcwH71Bo6Q84FZbxTAyBduMnORCSxX/EY6F6di+bpLRKkQ1ul10j1ISH/5OUTyd8zh
         qUSCfgD32TVOWSpjART1HOxAxOTEZ7icTjNw3N5LqLWR9ummdLB07eTXy4rKxnoZVMvV
         q3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZBQ2aQiaFbyWaj+6gHG60vNMKQG/zkRl0GYsas2Gg8=;
        b=sKFciLAo+b8e1aN5Y3hZ4gDEL8DlXsKsRzpW0jYSCFE0WfI9Gs30Bj1QBydZTAkO/v
         uUcVAKH1WcOQAixHBX3YOuIGlvoHhb116xizUBc+Pdf7/0HGKq0RqqO3gho8WMy+CRu/
         tznwB0/dxLkAGU5ICDdBJwpVmDo1IPw6H5pl0UQ8vtM3eh8vEaqd4rC0L6jbpQ8+RBHS
         e2sIPhwdkjfbcx+0Hk49Gft6J1gfM05DYvITHMZ9rlXXyKrHGcIk0KqG1gvGs1NEdkO2
         0C5bUcGmgp067yzurSiaG/qHgXXHfKT6oUnpZaWpENJMDrrsFOlYqCIxhnvWcVLeokWi
         w2pQ==
X-Gm-Message-State: ACrzQf3gQ8f4RIbrR15vYJ5K9WGCvsz4QMnEXMcUc+56avadG3j4Vufq
        tXjSZvh9WJZUc5BgzZFXzM7hNTsbLlqt4SCk7nFGgA==
X-Google-Smtp-Source: AMsMyM6r4/sAh9LzjRWHBXFsFeGWTDXZGKcsQAZ5r5LvDUNr1VXtQb04U7MaSKHc2ATg5Mp95bEJfBp4uIjT20TSP8o=
X-Received: by 2002:a5b:f4a:0:b0:6c1:46d2:c7d3 with SMTP id
 y10-20020a5b0f4a000000b006c146d2c7d3mr18719070ybr.169.1666392737394; Fri, 21
 Oct 2022 15:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com> <20221019173254.3361334-14-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20221019173254.3361334-14-tvrtko.ursulin@linux.intel.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 21 Oct 2022 15:52:05 -0700
Message-ID: <CABdmKX3Kca4pbq+KN1RnV+Py1dDw9d_33x-zu7ex7FnE95p1ig@mail.gmail.com>
Subject: Re: [RFC 13/17] cgroup/drm: Ability to periodically scan cgroups for
 over budget GPU usage
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 19, 2022 at 10:34 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> Add a scanning worker, which if enabled, periodically queries the cgroup
> for GPU usage and if over budget (as configured by it's relative weight
> share) notifies the drm core about the fact.
>
> This is off by default and can be enabled by configuring a scanning
> period using the drm.period_us cgroup control file.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  35 +-
>  kernel/cgroup/drm.c                     | 426 +++++++++++++++++++++++-
>  2 files changed, 459 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1f3cca4e2572..318f463a1316 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2401,7 +2401,8 @@ HugeTLB Interface Files
>  DRM
>  ---
>
> -The DRM controller allows configuring static hierarchical scheduling priority.
> +The DRM controller allows configuring static hierarchical scheduling priority
> +and scheduling soft limits.
>
>  DRM static priority control
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -2458,6 +2459,38 @@ DRM static priority interface files
>         Read only integer showing the current effective priority level for the
>         group. Effective meaning taking into account the chain of inherited
>
> +DRM scheduling soft limits
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Because of the heterogenous hardware and driver DRM capabilities, soft limits
> +are implemented as a loose co-operative (bi-directional) interface between the
> +controller and DRM core.
> +
> +The controller configures the GPU time allowed per group and periodically scans
> +the belonging tasks to detect the over budget condition, at which point it
> +invokes a callback notifying the DRM core of the condition.
> +
> +DRM core provides an API to query per process GPU utilization and 2nd API to
> +receive notification from the cgroup controller when the group enters or exits
> +the over budget condition.
> +
> +Individual DRM drivers which implement the interface are expected to act on this
> +in the best-effort manner only. There are no guarantees that the soft limits
> +will be respected.
> +
> +DRM scheduling soft limits interface files
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +  drm.weight
> +       Standard cgroup weight based control [1, 10000] used to configure the
> +       relative distributing of GPU time between the sibling groups.
> +
> +  drm.period_us
> +       An integer representing the period with which the controller should look
> +       at the GPU usage by the group and potentially send the over/under budget
> +       signal.
> +       Value of zero (defaul) disables the soft limit checking.
> +
>  Misc
>  ----
>
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 48f1eaaa1c07..af50ead1564a 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -18,6 +18,29 @@ struct drm_cgroup_state {
>         int priority;
>         int effective_priority;
>         unsigned int weight;
> +       unsigned int period_us;
> +
> +       bool scanning_suspended;
> +       unsigned int suspended_period_us;
> +
> +       struct delayed_work scan_work;
> +
> +       /*
> +        * Below fields are owned and updated by the scan worker. Either the
> +        * worker accesses them, or worker needs to be suspended and synced
> +        * before they can be touched from the outside.
> +        */
> +       bool scanned;
> +
> +       ktime_t prev_timestamp;
> +
> +       u64 sum_children_weights;
> +       u64 children_active_us;
> +       u64 per_s_budget_ns;
> +       u64 prev_active_us;
> +       u64 active_us;
> +
> +       bool over_budget;
>  };
>
>  static DEFINE_MUTEX(drmcg_mutex);
> @@ -33,6 +56,31 @@ static inline struct drm_cgroup_state *get_task_drmcs(struct task_struct *task)
>         return css_to_drmcs(task_get_css(task, drm_cgrp_id));
>  }
>
> +static u64 drmcs_get_active_time_us(struct drm_cgroup_state *drmcs)
> +{
> +       struct cgroup *cgrp = drmcs->css.cgroup;
> +       struct task_struct *task;
> +       struct css_task_iter it;
> +       u64 total = 0;
> +
> +       css_task_iter_start(&cgrp->self,
> +                           CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
> +                           &it);
> +       while ((task = css_task_iter_next(&it))) {
> +               u64 time;
> +
> +               /* Ignore kernel threads here. */
> +               if (task->flags & PF_KTHREAD)
> +                       continue;
> +
> +               time = drm_pid_get_active_time_us(task_pid(task));
> +               total += time;
> +       }
> +       css_task_iter_end(&it);
> +
> +       return total;
> +}
> +
>  int drmcgroup_lookup_effective_priority(struct task_struct *task)
>  {
>         struct drm_cgroup_state *drmcs = get_task_drmcs(task);
> @@ -202,9 +250,301 @@ static int drmcs_online(struct cgroup_subsys_state *css)
>         return 0;
>  }
>
> +static void
> +signal_drm_budget(struct drm_cgroup_state *drmcs, u64 usage, u64 budget)
> +{
> +       struct cgroup *cgrp = drmcs->css.cgroup;
> +       struct task_struct *task;
> +       struct css_task_iter it;
> +
> +       css_task_iter_start(&cgrp->self,
> +                           CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
> +                           &it);
> +       while ((task = css_task_iter_next(&it))) {
> +               /* Ignore kernel threads here. */
> +               if (task->flags & PF_KTHREAD)
> +                       continue;
> +
> +               drm_pid_signal_budget(task_pid(task), usage, budget);
> +       }
> +       css_task_iter_end(&it);
> +}
> +
> +static bool __start_scanning(struct drm_cgroup_state *root)
> +{
> +       struct cgroup_subsys_state *node;
> +       bool ok = true;
> +
> +       rcu_read_lock();
> +       css_for_each_descendant_pre(node, &root->css) {
> +               struct drm_cgroup_state *drmcs = css_to_drmcs(node);
> +               unsigned long active;
> +
> +               if (!css_tryget_online(node)) {
> +                       ok = false;
> +                       continue;
> +               }
> +
> +               drmcs->scanned = false;
> +               drmcs->sum_children_weights = 0;
> +               drmcs->children_active_us = 0;
> +               if (node == &root->css)
> +                       drmcs->per_s_budget_ns = NSEC_PER_SEC;
> +               else
> +                       drmcs->per_s_budget_ns = 0;
> +
> +               active = drmcs_get_active_time_us(drmcs);
> +               if (active >= drmcs->prev_active_us)
> +                       drmcs->active_us = active - drmcs->prev_active_us;
> +               else
> +                       drmcs->active_us = 0;
> +               drmcs->prev_active_us = active;
> +
> +               css_put(node);
> +       }
> +       rcu_read_unlock();
> +
> +       return ok;
> +}
> +
> +static void scan_worker(struct work_struct *work)
> +{
> +       struct drm_cgroup_state *root =
> +               container_of(work, typeof(*root), scan_work.work);
> +       struct cgroup_subsys_state *node;
> +       unsigned int period_us;
> +       ktime_t now;
> +
> +       rcu_read_lock();

Hi Tvrtko, I think this lock needs to come after the return for the
online check just below here to avoid missing the rcu_read_unlock at
out_retry. Although it doesn't look like this should ever run in the
first place if the DRM controller is disabled.

> +
> +       if (WARN_ON_ONCE(!css_tryget_online(&root->css)))
> +               return;
> +
> +       /*
> +        * 1st pass - reset accumulated values and update group GPU activity.
> +        */
> +       if (!__start_scanning(root))
> +               goto out_retry; /*
> +                                * Always come back later if scanner races with
> +                                * core cgroup management. (Repeated pattern.)
> +                                */
> +
> +       now = ktime_get();
> +       period_us = ktime_to_us(ktime_sub(now, root->prev_timestamp));
> +       root->prev_timestamp = now;
> +
> +       /*
> +        * 2nd pass - calculate accumulated GPU activity and relative weights
> +        * for each parent's children.
> +        */
> +       css_for_each_descendant_pre(node, &root->css) {
> +               struct drm_cgroup_state *drmcs = css_to_drmcs(node);
> +
> +               if (!css_tryget_online(node))
> +                       goto out_retry;
> +
> +               if (!drmcs->scanned) {
> +                       struct cgroup_subsys_state *css;
> +
> +                       css_for_each_child(css, &drmcs->css) {
> +                               struct drm_cgroup_state *sibling =
> +                                                       css_to_drmcs(css);
> +
> +                               if (!css_tryget_online(css)) {
> +                                       css_put(node);
> +                                       goto out_retry;
> +                               }
> +
> +                               drmcs->children_active_us += sibling->active_us;
> +                               drmcs->sum_children_weights += sibling->weight;
> +
> +                               css_put(css);
> +                       }
> +
> +                       drmcs->scanned = true;
> +               }
> +
> +               css_put(node);
> +       }
> +
> +       /*
> +        * 3rd pass - calculate relative budgets for each group based on
> +        * relative weights and parent's budget.
> +        *
> +        * FIXME: This is for now incomplete in more than one way. There is
> +        * no downward propagation of unused budgets, and even no utilisation of
> +        * the unused budgets at all.
> +        */
> +       css_for_each_descendant_pre(node, &root->css) {
> +               struct drm_cgroup_state *drmcs, *pdrmcs;
> +               bool over, was_over;
> +               u64 budget;
> +
> +               if (!css_tryget_online(node))
> +                       goto out_retry;
> +               if (node->cgroup->level == 1) {
> +                       css_put(node);
> +                       continue;
> +               }
> +               if (!css_tryget_online(node->parent)) {
> +                       css_put(node);
> +                       goto out_retry;
> +               }
> +
> +               drmcs = css_to_drmcs(node);
> +               pdrmcs = css_to_drmcs(node->parent);
> +
> +               drmcs->per_s_budget_ns  =
> +                       DIV_ROUND_UP_ULL(pdrmcs->per_s_budget_ns *
> +                                        drmcs->weight,
> +                                        pdrmcs->sum_children_weights);
> +               budget = DIV_ROUND_UP_ULL(drmcs->per_s_budget_ns * period_us,
> +                                         NSEC_PER_SEC);
> +               over = drmcs->active_us > budget;
> +               was_over = drmcs->over_budget;
> +               drmcs->over_budget = over;
> +               if (over || (!over && was_over))
> +                       signal_drm_budget(drmcs, drmcs->active_us, budget);
> +
> +               css_put(node);
> +               css_put(node->parent);
> +       }
> +
> +out_retry:
> +       rcu_read_unlock();
> +
> +       period_us = READ_ONCE(root->period_us);
> +       if (period_us)
> +               schedule_delayed_work(&root->scan_work,
> +                                     usecs_to_jiffies(period_us));
> +
> +       css_put(&root->css);
> +}
> +
> +static void start_scanning(struct drm_cgroup_state *drmcs, u64 period_us)
> +{
> +       drmcs->period_us = (unsigned int)period_us;
> +       WARN_ON_ONCE(!__start_scanning(drmcs));
> +       drmcs->prev_timestamp = ktime_get();
> +       mod_delayed_work(system_wq, &drmcs->scan_work,
> +                        usecs_to_jiffies(period_us));
> +}
> +
> +static void stop_scanning(struct drm_cgroup_state *drmcs)
> +{
> +       drmcs->period_us = 0;
> +       cancel_delayed_work_sync(&drmcs->scan_work);
> +       if (drmcs->over_budget) {
> +               /*
> +                * Signal under budget when scanning goes off so drivers
> +                * correctly update their state.
> +                */
> +               signal_drm_budget(drmcs, 0, drmcs->per_s_budget_ns);
> +               drmcs->over_budget = false;
> +       }
> +}
> +
> +static struct drm_cgroup_state *drmcs_scanner(struct drm_cgroup_state *drmcs)
> +{
> +       while (drmcs->css.cgroup->level > 1)
> +               drmcs = css_to_drmcs(drmcs->css.parent);
> +
> +       return drmcs;
> +}
> +
> +static void start_suspend_scanning(struct drm_cgroup_state *drmcs)
> +{
> +       drmcs = drmcs_scanner(drmcs);
> +
> +       if (drmcs->scanning_suspended)
> +               return;
> +
> +       drmcs->scanning_suspended = true;
> +       drmcs->suspended_period_us = drmcs->period_us;
> +       drmcs->period_us = 0;
> +}
> +
> +static void finish_suspend_scanning(struct drm_cgroup_state *drmcs)
> +{
> +       drmcs = drmcs_scanner(drmcs);
> +
> +       if (drmcs->suspended_period_us)
> +               cancel_delayed_work_sync(&drmcs->scan_work);
> +}
> +
> +static void resume_scanning(struct drm_cgroup_state *drmcs)
> +{
> +       drmcs = drmcs_scanner(drmcs);
> +
> +       if (!drmcs->scanning_suspended)
> +               return;
> +
> +       drmcs->scanning_suspended = false;
> +       if (drmcs->suspended_period_us) {
> +               start_scanning(drmcs, drmcs->suspended_period_us);
> +               drmcs->suspended_period_us = 0;
> +       }
> +}
> +
>  static void drmcs_free(struct cgroup_subsys_state *css)
>  {
> -       kfree(css_to_drmcs(css));
> +       struct drm_cgroup_state *drmcs = css_to_drmcs(css);
> +
> +       stop_scanning(drmcs);
> +
> +       kfree(drmcs);
> +}
> +
> +static int drmcs_can_attach(struct cgroup_taskset *tset)
> +{
> +       struct cgroup_subsys_state *new_css;
> +       struct task_struct *task;
> +       int ret;
> +
> +       /*
> +        * As processes are getting moved between groups we need to ensure
> +        * both that the old group does not see a sudden downward jump in the
> +        * GPU utilisation, and that the new group does not see a sudden jump
> +        * up with all the GPU time clients belonging to the migrated process
> +        * have accumulated.
> +        *
> +        * To achieve that we suspend the scanner until the migration is
> +        * completed where the resume at the end ensures both groups start
> +        * observing GPU utilisation from a reset state.
> +        */
> +
> +       ret = mutex_lock_interruptible(&drmcg_mutex);
> +       if (ret)
> +               return ret;
> +
> +       cgroup_taskset_for_each(task, new_css, tset) {
> +               start_suspend_scanning(css_to_drmcs(task_css(task,
> +                                                            drm_cgrp_id)));
> +               start_suspend_scanning(css_to_drmcs(new_css));
> +       }
> +
> +       mutex_unlock(&drmcg_mutex);
> +
> +       cgroup_taskset_for_each(task, new_css, tset) {
> +               finish_suspend_scanning(css_to_drmcs(task_css(task,
> +                                                             drm_cgrp_id)));
> +               finish_suspend_scanning(css_to_drmcs(new_css));
> +       }
> +
> +       return 0;
> +}
> +
> +static void tset_resume_scanning(struct cgroup_taskset *tset)
> +{
> +       struct cgroup_subsys_state *new_css;
> +       struct task_struct *task;
> +
> +       mutex_lock(&drmcg_mutex);
> +       cgroup_taskset_for_each(task, new_css, tset) {
> +               resume_scanning(css_to_drmcs(task_css(task, drm_cgrp_id)));
> +               resume_scanning(css_to_drmcs(new_css));
> +       }
> +       mutex_unlock(&drmcg_mutex);
>  }
>
>  static void drmcs_attach(struct cgroup_taskset *tset)
> @@ -219,12 +559,86 @@ static void drmcs_attach(struct cgroup_taskset *tset)
>         cgroup_taskset_for_each(task, css, tset)
>                 drm_pid_update_priority(task_pid(task),
>                                         css_to_drmcs(css)->effective_priority);
> +
> +       tset_resume_scanning(tset);
> +}
> +
> +static void drmcs_cancel_attach(struct cgroup_taskset *tset)
> +{
> +       tset_resume_scanning(tset);
> +}
> +
> +static u64
> +drmcs_read_period_us(struct cgroup_subsys_state *css, struct cftype *cft)
> +{
> +       struct drm_cgroup_state *drmcs = css_to_drmcs(css);
> +
> +       return drmcs->period_us;
> +}
> +
> +static int
> +drmcs_write_period_us(struct cgroup_subsys_state *css, struct cftype *cftype,
> +                     u64 period_us)
> +{
> +       struct drm_cgroup_state *drmcs = css_to_drmcs(css);
> +       int ret;
> +
> +       if (WARN_ON_ONCE(!css->parent))
> +               return -EINVAL;
> +       if (css->cgroup->level != 1)
> +               return -EINVAL;
> +       if ((period_us && period_us < 500000) || period_us > USEC_PER_SEC * 60)
> +               return -EINVAL;
> +
> +       ret = mutex_lock_interruptible(&drmcg_mutex);
> +       if (ret)
> +               return ret;
> +
> +       if (!drmcs->scanning_suspended) {
> +               if (period_us)
> +                       start_scanning(drmcs, period_us);
> +               else
> +                       stop_scanning(drmcs);
> +       } else {
> +               /*
> +                * If scanning is temporarily suspended just update the period
> +                * which will apply once resumed, or simply skip resuming in
> +                * case of disabling.
> +                */
> +               drmcs->suspended_period_us = period_us;
> +               if (!period_us)
> +                       drmcs->scanning_suspended = false;
> +       }
> +
> +       mutex_unlock(&drmcg_mutex);
> +
> +       return 0;
>  }
>
>  void drmcgroup_client_exited(struct task_struct *task)
>  {
>         struct drm_cgroup_state *drmcs = get_task_drmcs(task);
>
> +       /*
> +        * Since we are not tracking accumulated GPU time for each cgroup,
> +        * avoid jumps in group observed GPU usage by re-setting the scanner
> +        * at a point when GPU usage can suddenly jump down.
> +        *
> +        * Downside is clients can influence the effectiveness of the over-
> +        * budget scanning by continuosly closing DRM file descriptors but for

"continuously"

And I think also if a user has permission to create and migrate
processes between cgroups even just under the same parent, since
css_tryget_online failure would cause an early exit during scanning?

> +        * now we do not worry about it.
> +        */
> +
> +       mutex_lock(&drmcg_mutex);
> +       start_suspend_scanning(drmcs);
> +       mutex_unlock(&drmcg_mutex);
> +
> +       finish_suspend_scanning(drmcs);
> +
> +       mutex_lock(&drmcg_mutex);
> +       resume_scanning(drmcs);
> +       mutex_unlock(&drmcg_mutex);
> +
>         css_put(&drmcs->css);
>  }
>  EXPORT_SYMBOL_GPL(drmcgroup_client_exited);
> @@ -232,6 +646,7 @@ EXPORT_SYMBOL_GPL(drmcgroup_client_exited);
>  static struct drm_cgroup_state root_drmcs = {
>         .priority = DRM_CGROUP_PRIORITY_DEF,
>         .effective_priority = DRM_CGROUP_PRIORITY_DEF,
> +       .weight = CGROUP_WEIGHT_DFL,
>  };
>
>  static struct cgroup_subsys_state *
> @@ -247,6 +662,7 @@ drmcs_alloc(struct cgroup_subsys_state *parent_css)
>                 return ERR_PTR(-ENOMEM);
>
>         drmcs->weight = CGROUP_WEIGHT_DFL;
> +       INIT_DELAYED_WORK(&drmcs->scan_work, scan_worker);
>
>         return &drmcs->css;
>  }
> @@ -274,6 +690,12 @@ struct cftype files[] = {
>                 .read_u64 = drmcs_read_weight,
>                 .write_u64 = drmcs_write_weight,
>         },
> +       {
> +               .name = "period_us",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .read_u64 = drmcs_read_period_us,
> +               .write_u64 = drmcs_write_period_us,
> +       },
>         { } /* Zero entry terminates. */
>  };
>
> @@ -281,7 +703,9 @@ struct cgroup_subsys drm_cgrp_subsys = {
>         .css_alloc      = drmcs_alloc,
>         .css_free       = drmcs_free,
>         .css_online     = drmcs_online,
> +       .can_attach     = drmcs_can_attach,
>         .attach         = drmcs_attach,
> +       .cancel_attach  = drmcs_cancel_attach,
>         .early_init     = false,
>         .legacy_cftypes = files,
>         .dfl_cftypes    = files,
> --
> 2.34.1
>
