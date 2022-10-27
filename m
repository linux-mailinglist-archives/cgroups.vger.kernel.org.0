Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DF60FAB9
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiJ0Opj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiJ0OpU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 10:45:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86E95269;
        Thu, 27 Oct 2022 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666881906; x=1698417906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=siNlzOIzbPG5FGOGSJG+VaIMVENHBCOGT1aQFKz3J9Y=;
  b=Yu1ZO64GVuJH7BAExIOYvCLaptSaxpeOe4d0gFF4x55kCWT21XXKf+6r
   K0AsGqU3pQrnSoZFoFsuwVOOoW/09JSA47fcFlh4qkat6AaM67DIxxuGD
   amnhSbAYBM4omvAbsAi5pH+hjOMPGDC1/bbB1zrk6QC9HQ+E7o5Ymrc6s
   yZv9Vfa1UooriXHRo1xJLU3PFNM37ewD5aKE5Xcwo6ds4AYLkLlQ9SCwU
   frL8YkiXhkgNrMYQrxezrXnwArpFjSHZ9MFlHbRswXWmH7qskNuEZFTGf
   6S5W8Hx4QKahXSRgAIvZ27x10pZoIOQj9aDiT+VuQ36JV8U5pW4aa9kMi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="305855009"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="305855009"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 07:45:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961646983"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="961646983"
Received: from rgrilak-mobl.ger.corp.intel.com (HELO [10.213.238.72]) ([10.213.238.72])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 07:45:02 -0700
Message-ID: <7444db68-bcf4-b3a0-09f4-bf24b516054a@linux.intel.com>
Date:   Thu, 27 Oct 2022 15:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC 13/17] cgroup/drm: Ability to periodically scan cgroups for
 over budget GPU usage
Content-Language: en-US
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
 <20221019173254.3361334-14-tvrtko.ursulin@linux.intel.com>
 <CABdmKX3Kca4pbq+KN1RnV+Py1dDw9d_33x-zu7ex7FnE95p1ig@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CABdmKX3Kca4pbq+KN1RnV+Py1dDw9d_33x-zu7ex7FnE95p1ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 21/10/2022 23:52, T.J. Mercier wrote:
> On Wed, Oct 19, 2022 at 10:34 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> Add a scanning worker, which if enabled, periodically queries the cgroup
>> for GPU usage and if over budget (as configured by it's relative weight
>> share) notifies the drm core about the fact.
>>
>> This is off by default and can be enabled by configuring a scanning
>> period using the drm.period_us cgroup control file.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  35 +-
>>   kernel/cgroup/drm.c                     | 426 +++++++++++++++++++++++-
>>   2 files changed, 459 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 1f3cca4e2572..318f463a1316 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2401,7 +2401,8 @@ HugeTLB Interface Files
>>   DRM
>>   ---
>>
>> -The DRM controller allows configuring static hierarchical scheduling priority.
>> +The DRM controller allows configuring static hierarchical scheduling priority
>> +and scheduling soft limits.
>>
>>   DRM static priority control
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> @@ -2458,6 +2459,38 @@ DRM static priority interface files
>>          Read only integer showing the current effective priority level for the
>>          group. Effective meaning taking into account the chain of inherited
>>
>> +DRM scheduling soft limits
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Because of the heterogenous hardware and driver DRM capabilities, soft limits
>> +are implemented as a loose co-operative (bi-directional) interface between the
>> +controller and DRM core.
>> +
>> +The controller configures the GPU time allowed per group and periodically scans
>> +the belonging tasks to detect the over budget condition, at which point it
>> +invokes a callback notifying the DRM core of the condition.
>> +
>> +DRM core provides an API to query per process GPU utilization and 2nd API to
>> +receive notification from the cgroup controller when the group enters or exits
>> +the over budget condition.
>> +
>> +Individual DRM drivers which implement the interface are expected to act on this
>> +in the best-effort manner only. There are no guarantees that the soft limits
>> +will be respected.
>> +
>> +DRM scheduling soft limits interface files
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +  drm.weight
>> +       Standard cgroup weight based control [1, 10000] used to configure the
>> +       relative distributing of GPU time between the sibling groups.
>> +
>> +  drm.period_us
>> +       An integer representing the period with which the controller should look
>> +       at the GPU usage by the group and potentially send the over/under budget
>> +       signal.
>> +       Value of zero (defaul) disables the soft limit checking.
>> +
>>   Misc
>>   ----
>>
>> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
>> index 48f1eaaa1c07..af50ead1564a 100644
>> --- a/kernel/cgroup/drm.c
>> +++ b/kernel/cgroup/drm.c
>> @@ -18,6 +18,29 @@ struct drm_cgroup_state {
>>          int priority;
>>          int effective_priority;
>>          unsigned int weight;
>> +       unsigned int period_us;
>> +
>> +       bool scanning_suspended;
>> +       unsigned int suspended_period_us;
>> +
>> +       struct delayed_work scan_work;
>> +
>> +       /*
>> +        * Below fields are owned and updated by the scan worker. Either the
>> +        * worker accesses them, or worker needs to be suspended and synced
>> +        * before they can be touched from the outside.
>> +        */
>> +       bool scanned;
>> +
>> +       ktime_t prev_timestamp;
>> +
>> +       u64 sum_children_weights;
>> +       u64 children_active_us;
>> +       u64 per_s_budget_ns;
>> +       u64 prev_active_us;
>> +       u64 active_us;
>> +
>> +       bool over_budget;
>>   };
>>
>>   static DEFINE_MUTEX(drmcg_mutex);
>> @@ -33,6 +56,31 @@ static inline struct drm_cgroup_state *get_task_drmcs(struct task_struct *task)
>>          return css_to_drmcs(task_get_css(task, drm_cgrp_id));
>>   }
>>
>> +static u64 drmcs_get_active_time_us(struct drm_cgroup_state *drmcs)
>> +{
>> +       struct cgroup *cgrp = drmcs->css.cgroup;
>> +       struct task_struct *task;
>> +       struct css_task_iter it;
>> +       u64 total = 0;
>> +
>> +       css_task_iter_start(&cgrp->self,
>> +                           CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
>> +                           &it);
>> +       while ((task = css_task_iter_next(&it))) {
>> +               u64 time;
>> +
>> +               /* Ignore kernel threads here. */
>> +               if (task->flags & PF_KTHREAD)
>> +                       continue;
>> +
>> +               time = drm_pid_get_active_time_us(task_pid(task));
>> +               total += time;
>> +       }
>> +       css_task_iter_end(&it);
>> +
>> +       return total;
>> +}
>> +
>>   int drmcgroup_lookup_effective_priority(struct task_struct *task)
>>   {
>>          struct drm_cgroup_state *drmcs = get_task_drmcs(task);
>> @@ -202,9 +250,301 @@ static int drmcs_online(struct cgroup_subsys_state *css)
>>          return 0;
>>   }
>>
>> +static void
>> +signal_drm_budget(struct drm_cgroup_state *drmcs, u64 usage, u64 budget)
>> +{
>> +       struct cgroup *cgrp = drmcs->css.cgroup;
>> +       struct task_struct *task;
>> +       struct css_task_iter it;
>> +
>> +       css_task_iter_start(&cgrp->self,
>> +                           CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
>> +                           &it);
>> +       while ((task = css_task_iter_next(&it))) {
>> +               /* Ignore kernel threads here. */
>> +               if (task->flags & PF_KTHREAD)
>> +                       continue;
>> +
>> +               drm_pid_signal_budget(task_pid(task), usage, budget);
>> +       }
>> +       css_task_iter_end(&it);
>> +}
>> +
>> +static bool __start_scanning(struct drm_cgroup_state *root)
>> +{
>> +       struct cgroup_subsys_state *node;
>> +       bool ok = true;
>> +
>> +       rcu_read_lock();
>> +       css_for_each_descendant_pre(node, &root->css) {
>> +               struct drm_cgroup_state *drmcs = css_to_drmcs(node);
>> +               unsigned long active;
>> +
>> +               if (!css_tryget_online(node)) {
>> +                       ok = false;
>> +                       continue;
>> +               }
>> +
>> +               drmcs->scanned = false;
>> +               drmcs->sum_children_weights = 0;
>> +               drmcs->children_active_us = 0;
>> +               if (node == &root->css)
>> +                       drmcs->per_s_budget_ns = NSEC_PER_SEC;
>> +               else
>> +                       drmcs->per_s_budget_ns = 0;
>> +
>> +               active = drmcs_get_active_time_us(drmcs);
>> +               if (active >= drmcs->prev_active_us)
>> +                       drmcs->active_us = active - drmcs->prev_active_us;
>> +               else
>> +                       drmcs->active_us = 0;
>> +               drmcs->prev_active_us = active;
>> +
>> +               css_put(node);
>> +       }
>> +       rcu_read_unlock();
>> +
>> +       return ok;
>> +}
>> +
>> +static void scan_worker(struct work_struct *work)
>> +{
>> +       struct drm_cgroup_state *root =
>> +               container_of(work, typeof(*root), scan_work.work);
>> +       struct cgroup_subsys_state *node;
>> +       unsigned int period_us;
>> +       ktime_t now;
>> +
>> +       rcu_read_lock();
> 
> Hi Tvrtko, I think this lock needs to come after the return for the
> online check just below here to avoid missing the rcu_read_unlock at
> out_retry. Although it doesn't look like this should ever run in the
> first place if the DRM controller is disabled.

Yep - thank you. I've fixed it up locally.

Another TODO note for me is to see if I can hook into the cgroup offline 
hook to avoid all this checks by perhaps making sure scan worker is not 
running as transitions are happening. Will see if that works.

>> +
>> +       if (WARN_ON_ONCE(!css_tryget_online(&root->css)))
>> +               return;
>> +
>> +       /*
>> +        * 1st pass - reset accumulated values and update group GPU activity.
>> +        */
>> +       if (!__start_scanning(root))
>> +               goto out_retry; /*
>> +                                * Always come back later if scanner races with
>> +                                * core cgroup management. (Repeated pattern.)
>> +                                */
>> +
>> +       now = ktime_get();
>> +       period_us = ktime_to_us(ktime_sub(now, root->prev_timestamp));
>> +       root->prev_timestamp = now;
>> +
>> +       /*
>> +        * 2nd pass - calculate accumulated GPU activity and relative weights
>> +        * for each parent's children.
>> +        */
>> +       css_for_each_descendant_pre(node, &root->css) {
>> +               struct drm_cgroup_state *drmcs = css_to_drmcs(node);
>> +
>> +               if (!css_tryget_online(node))
>> +                       goto out_retry;
>> +
>> +               if (!drmcs->scanned) {
>> +                       struct cgroup_subsys_state *css;
>> +
>> +                       css_for_each_child(css, &drmcs->css) {
>> +                               struct drm_cgroup_state *sibling =
>> +                                                       css_to_drmcs(css);
>> +
>> +                               if (!css_tryget_online(css)) {
>> +                                       css_put(node);
>> +                                       goto out_retry;
>> +                               }
>> +
>> +                               drmcs->children_active_us += sibling->active_us;
>> +                               drmcs->sum_children_weights += sibling->weight;
>> +
>> +                               css_put(css);
>> +                       }
>> +
>> +                       drmcs->scanned = true;
>> +               }
>> +
>> +               css_put(node);
>> +       }
>> +
>> +       /*
>> +        * 3rd pass - calculate relative budgets for each group based on
>> +        * relative weights and parent's budget.
>> +        *
>> +        * FIXME: This is for now incomplete in more than one way. There is
>> +        * no downward propagation of unused budgets, and even no utilisation of
>> +        * the unused budgets at all.
>> +        */
>> +       css_for_each_descendant_pre(node, &root->css) {
>> +               struct drm_cgroup_state *drmcs, *pdrmcs;
>> +               bool over, was_over;
>> +               u64 budget;
>> +
>> +               if (!css_tryget_online(node))
>> +                       goto out_retry;
>> +               if (node->cgroup->level == 1) {
>> +                       css_put(node);
>> +                       continue;
>> +               }
>> +               if (!css_tryget_online(node->parent)) {
>> +                       css_put(node);
>> +                       goto out_retry;
>> +               }
>> +
>> +               drmcs = css_to_drmcs(node);
>> +               pdrmcs = css_to_drmcs(node->parent);
>> +
>> +               drmcs->per_s_budget_ns  =
>> +                       DIV_ROUND_UP_ULL(pdrmcs->per_s_budget_ns *
>> +                                        drmcs->weight,
>> +                                        pdrmcs->sum_children_weights);
>> +               budget = DIV_ROUND_UP_ULL(drmcs->per_s_budget_ns * period_us,
>> +                                         NSEC_PER_SEC);
>> +               over = drmcs->active_us > budget;
>> +               was_over = drmcs->over_budget;
>> +               drmcs->over_budget = over;
>> +               if (over || (!over && was_over))
>> +                       signal_drm_budget(drmcs, drmcs->active_us, budget);
>> +
>> +               css_put(node);
>> +               css_put(node->parent);
>> +       }
>> +
>> +out_retry:
>> +       rcu_read_unlock();
>> +
>> +       period_us = READ_ONCE(root->period_us);
>> +       if (period_us)
>> +               schedule_delayed_work(&root->scan_work,
>> +                                     usecs_to_jiffies(period_us));
>> +
>> +       css_put(&root->css);
>> +}
>> +
>> +static void start_scanning(struct drm_cgroup_state *drmcs, u64 period_us)
>> +{
>> +       drmcs->period_us = (unsigned int)period_us;
>> +       WARN_ON_ONCE(!__start_scanning(drmcs));
>> +       drmcs->prev_timestamp = ktime_get();
>> +       mod_delayed_work(system_wq, &drmcs->scan_work,
>> +                        usecs_to_jiffies(period_us));
>> +}
>> +
>> +static void stop_scanning(struct drm_cgroup_state *drmcs)
>> +{
>> +       drmcs->period_us = 0;
>> +       cancel_delayed_work_sync(&drmcs->scan_work);
>> +       if (drmcs->over_budget) {
>> +               /*
>> +                * Signal under budget when scanning goes off so drivers
>> +                * correctly update their state.
>> +                */
>> +               signal_drm_budget(drmcs, 0, drmcs->per_s_budget_ns);
>> +               drmcs->over_budget = false;
>> +       }
>> +}
>> +
>> +static struct drm_cgroup_state *drmcs_scanner(struct drm_cgroup_state *drmcs)
>> +{
>> +       while (drmcs->css.cgroup->level > 1)
>> +               drmcs = css_to_drmcs(drmcs->css.parent);
>> +
>> +       return drmcs;
>> +}
>> +
>> +static void start_suspend_scanning(struct drm_cgroup_state *drmcs)
>> +{
>> +       drmcs = drmcs_scanner(drmcs);
>> +
>> +       if (drmcs->scanning_suspended)
>> +               return;
>> +
>> +       drmcs->scanning_suspended = true;
>> +       drmcs->suspended_period_us = drmcs->period_us;
>> +       drmcs->period_us = 0;
>> +}
>> +
>> +static void finish_suspend_scanning(struct drm_cgroup_state *drmcs)
>> +{
>> +       drmcs = drmcs_scanner(drmcs);
>> +
>> +       if (drmcs->suspended_period_us)
>> +               cancel_delayed_work_sync(&drmcs->scan_work);
>> +}
>> +
>> +static void resume_scanning(struct drm_cgroup_state *drmcs)
>> +{
>> +       drmcs = drmcs_scanner(drmcs);
>> +
>> +       if (!drmcs->scanning_suspended)
>> +               return;
>> +
>> +       drmcs->scanning_suspended = false;
>> +       if (drmcs->suspended_period_us) {
>> +               start_scanning(drmcs, drmcs->suspended_period_us);
>> +               drmcs->suspended_period_us = 0;
>> +       }
>> +}
>> +
>>   static void drmcs_free(struct cgroup_subsys_state *css)
>>   {
>> -       kfree(css_to_drmcs(css));
>> +       struct drm_cgroup_state *drmcs = css_to_drmcs(css);
>> +
>> +       stop_scanning(drmcs);
>> +
>> +       kfree(drmcs);
>> +}
>> +
>> +static int drmcs_can_attach(struct cgroup_taskset *tset)
>> +{
>> +       struct cgroup_subsys_state *new_css;
>> +       struct task_struct *task;
>> +       int ret;
>> +
>> +       /*
>> +        * As processes are getting moved between groups we need to ensure
>> +        * both that the old group does not see a sudden downward jump in the
>> +        * GPU utilisation, and that the new group does not see a sudden jump
>> +        * up with all the GPU time clients belonging to the migrated process
>> +        * have accumulated.
>> +        *
>> +        * To achieve that we suspend the scanner until the migration is
>> +        * completed where the resume at the end ensures both groups start
>> +        * observing GPU utilisation from a reset state.
>> +        */
>> +
>> +       ret = mutex_lock_interruptible(&drmcg_mutex);
>> +       if (ret)
>> +               return ret;
>> +
>> +       cgroup_taskset_for_each(task, new_css, tset) {
>> +               start_suspend_scanning(css_to_drmcs(task_css(task,
>> +                                                            drm_cgrp_id)));
>> +               start_suspend_scanning(css_to_drmcs(new_css));
>> +       }
>> +
>> +       mutex_unlock(&drmcg_mutex);
>> +
>> +       cgroup_taskset_for_each(task, new_css, tset) {
>> +               finish_suspend_scanning(css_to_drmcs(task_css(task,
>> +                                                             drm_cgrp_id)));
>> +               finish_suspend_scanning(css_to_drmcs(new_css));
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void tset_resume_scanning(struct cgroup_taskset *tset)
>> +{
>> +       struct cgroup_subsys_state *new_css;
>> +       struct task_struct *task;
>> +
>> +       mutex_lock(&drmcg_mutex);
>> +       cgroup_taskset_for_each(task, new_css, tset) {
>> +               resume_scanning(css_to_drmcs(task_css(task, drm_cgrp_id)));
>> +               resume_scanning(css_to_drmcs(new_css));
>> +       }
>> +       mutex_unlock(&drmcg_mutex);
>>   }
>>
>>   static void drmcs_attach(struct cgroup_taskset *tset)
>> @@ -219,12 +559,86 @@ static void drmcs_attach(struct cgroup_taskset *tset)
>>          cgroup_taskset_for_each(task, css, tset)
>>                  drm_pid_update_priority(task_pid(task),
>>                                          css_to_drmcs(css)->effective_priority);
>> +
>> +       tset_resume_scanning(tset);
>> +}
>> +
>> +static void drmcs_cancel_attach(struct cgroup_taskset *tset)
>> +{
>> +       tset_resume_scanning(tset);
>> +}
>> +
>> +static u64
>> +drmcs_read_period_us(struct cgroup_subsys_state *css, struct cftype *cft)
>> +{
>> +       struct drm_cgroup_state *drmcs = css_to_drmcs(css);
>> +
>> +       return drmcs->period_us;
>> +}
>> +
>> +static int
>> +drmcs_write_period_us(struct cgroup_subsys_state *css, struct cftype *cftype,
>> +                     u64 period_us)
>> +{
>> +       struct drm_cgroup_state *drmcs = css_to_drmcs(css);
>> +       int ret;
>> +
>> +       if (WARN_ON_ONCE(!css->parent))
>> +               return -EINVAL;
>> +       if (css->cgroup->level != 1)
>> +               return -EINVAL;
>> +       if ((period_us && period_us < 500000) || period_us > USEC_PER_SEC * 60)
>> +               return -EINVAL;
>> +
>> +       ret = mutex_lock_interruptible(&drmcg_mutex);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!drmcs->scanning_suspended) {
>> +               if (period_us)
>> +                       start_scanning(drmcs, period_us);
>> +               else
>> +                       stop_scanning(drmcs);
>> +       } else {
>> +               /*
>> +                * If scanning is temporarily suspended just update the period
>> +                * which will apply once resumed, or simply skip resuming in
>> +                * case of disabling.
>> +                */
>> +               drmcs->suspended_period_us = period_us;
>> +               if (!period_us)
>> +                       drmcs->scanning_suspended = false;
>> +       }
>> +
>> +       mutex_unlock(&drmcg_mutex);
>> +
>> +       return 0;
>>   }
>>
>>   void drmcgroup_client_exited(struct task_struct *task)
>>   {
>>          struct drm_cgroup_state *drmcs = get_task_drmcs(task);
>>
>> +       /*
>> +        * Since we are not tracking accumulated GPU time for each cgroup,
>> +        * avoid jumps in group observed GPU usage by re-setting the scanner
>> +        * at a point when GPU usage can suddenly jump down.
>> +        *
>> +        * Downside is clients can influence the effectiveness of the over-
>> +        * budget scanning by continuosly closing DRM file descriptors but for
> 
> "continuously"

Thanks, fixed locally.

> 
> And I think also if a user has permission to create and migrate
> processes between cgroups even just under the same parent, since
> css_tryget_online failure would cause an early exit during scanning?

I will need to double check if migration causes online/offline events. I 
didn't think it does. I know it causes "attach" "family" of events which 
I hooked into to ensure no sudden jumps in usage during migration. See 
comment in drmcs_can_attach(). But that is a pretty rare event I think.

Unless you are thinking from the ChromeOS angle and browser 
foreground/backgroun tabs cgroups? Those are not doing GPU rendering so 
I did not envisage hooking up the DRM controller there. To start with I 
only planned to hook it up with the children of the vms cgroup. The 
model in that branch is not to migrate processes but to change cgroup 
CPU share based on ::OnWindowActivated hooks.

Regards,

Tvrtko

>> +        * now we do not worry about it.
>> +        */
>> +
>> +       mutex_lock(&drmcg_mutex);
>> +       start_suspend_scanning(drmcs);
>> +       mutex_unlock(&drmcg_mutex);
>> +
>> +       finish_suspend_scanning(drmcs);
>> +
>> +       mutex_lock(&drmcg_mutex);
>> +       resume_scanning(drmcs);
>> +       mutex_unlock(&drmcg_mutex);
>> +
>>          css_put(&drmcs->css);
>>   }
>>   EXPORT_SYMBOL_GPL(drmcgroup_client_exited);
>> @@ -232,6 +646,7 @@ EXPORT_SYMBOL_GPL(drmcgroup_client_exited);
>>   static struct drm_cgroup_state root_drmcs = {
>>          .priority = DRM_CGROUP_PRIORITY_DEF,
>>          .effective_priority = DRM_CGROUP_PRIORITY_DEF,
>> +       .weight = CGROUP_WEIGHT_DFL,
>>   };
>>
>>   static struct cgroup_subsys_state *
>> @@ -247,6 +662,7 @@ drmcs_alloc(struct cgroup_subsys_state *parent_css)
>>                  return ERR_PTR(-ENOMEM);
>>
>>          drmcs->weight = CGROUP_WEIGHT_DFL;
>> +       INIT_DELAYED_WORK(&drmcs->scan_work, scan_worker);
>>
>>          return &drmcs->css;
>>   }
>> @@ -274,6 +690,12 @@ struct cftype files[] = {
>>                  .read_u64 = drmcs_read_weight,
>>                  .write_u64 = drmcs_write_weight,
>>          },
>> +       {
>> +               .name = "period_us",
>> +               .flags = CFTYPE_NOT_ON_ROOT,
>> +               .read_u64 = drmcs_read_period_us,
>> +               .write_u64 = drmcs_write_period_us,
>> +       },
>>          { } /* Zero entry terminates. */
>>   };
>>
>> @@ -281,7 +703,9 @@ struct cgroup_subsys drm_cgrp_subsys = {
>>          .css_alloc      = drmcs_alloc,
>>          .css_free       = drmcs_free,
>>          .css_online     = drmcs_online,
>> +       .can_attach     = drmcs_can_attach,
>>          .attach         = drmcs_attach,
>> +       .cancel_attach  = drmcs_cancel_attach,
>>          .early_init     = false,
>>          .legacy_cftypes = files,
>>          .dfl_cftypes    = files,
>> --
>> 2.34.1
>>
