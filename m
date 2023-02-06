Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096AE68C82A
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjBFVB4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjBFVBw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:01:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B32942B
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 13:01:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hr39so8361178ejc.7
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 13:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj6PVO99/1/41mMDbbP40I2wqcapGcYDTK9/f9dvL7c=;
        b=Y2q51+4WeKAvEaoE2rzz0347cFYBvj/1awSS9eXT3zk16RmkCQmTB9FckraNxMdB/G
         kbfYvW44VdIbj3uysJpHop7WN3pZzUsPf7B4nbVOcgWHUxzmaka37MUcHMOVGlXIISiv
         ILj3T5k0yuYSczXhgBZue92ckqlUpeBj6ekqRVcxKrkZAlsy1DtligugVhR70adleq1b
         DlLm2raBfsqrQ0Sn7o3IdwVt+Gl+8/HWpFS4b9YTvJTq0a1Xxl2rhgQcziWBK6o2Ng82
         +6iOZVujohKNg9OWP9IBm9eKyzd3Vei4LThjp1mK5GREDKtTDYsj038S3dsjkElbXmNv
         IScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj6PVO99/1/41mMDbbP40I2wqcapGcYDTK9/f9dvL7c=;
        b=dzCnIBFI6xyN97ygUMX6iT9EUEtwff247Xxb+qfoK4d3xWc1onNP5+DmEEtwbFEnUT
         /tyWbhM1Y6UjqEnGqBA60t58osP5+9RUi9Mbvvr/kqp2rXUx46fHJyAq8TlKQdW/qrQ9
         PbXQUJNPC08e+9vi4BjPvkbEIH+7v0Ya5eCeyxVN7NEl9k1FBapovczFlYPwYBi8CpKu
         QF3k6OtusOvRV9xiyqocNwTkFSGW/3XfOsIAb1CNdEdVbZstBHQrW7y/HV3sw6hvkgdA
         kbkdwksJxWYtDt6EeFkxu/BxWdBRWVrS4JdEhduR3U7L3WAMQtpi5rPOy2I3h8swhLpQ
         u6ow==
X-Gm-Message-State: AO0yUKXUA9nkHDopt4iGbxgT92OXNdzVyPEUNZjeRwOtsSraYPyOl7Cf
        QPCbi2wIQm/OMheYimIftYVlmgubBoPo6sT7HObmyxopVBMvL3O6
X-Google-Smtp-Source: AK7set+lFf+t4XoWty23M+KXffMA5ibdPGfdVkQ5TGSI9Jd86OJKdRu+EGbpBcPpYiDtrmhMjdqlksw/ujoGQSzGUkc=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr215456ejc.220.1675717307531; Mon, 06 Feb
 2023 13:01:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
In-Reply-To: <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 13:01:11 -0800
Message-ID: <CAJD7tkaC5z3ZqNkZi+dNNOo2R-rrY25CXse3dv9n8Wch-YKxjg@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Sun, Feb 5, 2023 at 11:49 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> If too much memory in a system is pinned or locked it can lead to
> problems such as performance degradation or in the worst case
> out-of-memory errors as such memory cannot be moved or paged out.
>
> In order to prevent users without CAP_IPC_LOCK from causing these
> issues the amount of memory that can be pinned is typically limited by
> RLIMIT_MEMLOCK. However this is inflexible as limits can't be shared
> between tasks and the enforcement of these limits is inconsistent
> between in-kernel users of pinned memory such as mlock() and device
> drivers which may also pin pages with pin_user_pages().
>
> To allow for a single limit to be set introduce a cgroup controller
> which can be used to limit the number of pages being pinned by all
> tasks in the cgroup.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  MAINTAINERS                   |   7 +-
>  include/linux/cgroup.h        |  20 +++-
>  include/linux/cgroup_subsys.h |   4 +-
>  mm/Kconfig                    |  11 +-
>  mm/Makefile                   |   1 +-
>  mm/pins_cgroup.c              | 273 +++++++++++++++++++++++++++++++++++-
>  6 files changed, 316 insertions(+)
>  create mode 100644 mm/pins_cgroup.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f781f93..f8526e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5381,6 +5381,13 @@ F:       tools/testing/selftests/cgroup/memcg_protection.m
>  F:     tools/testing/selftests/cgroup/test_kmem.c
>  F:     tools/testing/selftests/cgroup/test_memcontrol.c
>
> +CONTROL GROUP - PINNED AND LOCKED MEMORY
> +M:     Alistair Popple <apopple@nvidia.com>
> +L:     cgroups@vger.kernel.org
> +L:     linux-mm@kvack.org
> +S:     Maintained
> +F:     mm/pins_cgroup.c
> +
>  CORETEMP HARDWARE MONITORING DRIVER
>  M:     Fenghua Yu <fenghua.yu@intel.com>
>  L:     linux-hwmon@vger.kernel.org
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 3410aec..d98de25 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -857,4 +857,24 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
>
>  #endif /* CONFIG_CGROUP_BPF */
>
> +#ifdef CONFIG_CGROUP_PINS
> +
> +struct pins_cgroup *get_pins_cg(struct task_struct *task);
> +void put_pins_cg(struct pins_cgroup *cg);
> +void pins_uncharge(struct pins_cgroup *pins, int num);
> +bool pins_try_charge(struct pins_cgroup *pins, int num);
> +
> +#else /* CONFIG_CGROUP_PINS */
> +
> +static inline struct pins_cgroup *get_pins_cg(struct task_struct *task)
> +{
> +       return NULL;
> +}
> +
> +static inline void put_pins_cg(struct pins_cgroup *cg) {}
> +static inline void pins_uncharge(struct pins_cgroup *pins, int num) {}
> +static inline bool pins_try_charge(struct pins_cgroup *pins, int num) { return 1; }
> +
> +#endif /* CONFIG_CGROUP_PINS */
> +
>  #endif /* _LINUX_CGROUP_H */
> diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
> index 4452354..c1b4aab 100644
> --- a/include/linux/cgroup_subsys.h
> +++ b/include/linux/cgroup_subsys.h
> @@ -65,6 +65,10 @@ SUBSYS(rdma)
>  SUBSYS(misc)
>  #endif
>
> +#if IS_ENABLED(CONFIG_CGROUP_PINS)
> +SUBSYS(pins)
> +#endif
> +
>  /*
>   * The following subsystems are not supported on the default hierarchy.
>   */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ff7b209..4472043 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1183,6 +1183,17 @@ config LRU_GEN_STATS
>           This option has a per-memcg and per-node memory overhead.
>  # }
>
> +config CGROUP_PINS
> +    bool "Cgroup controller for pinned and locked memory"
> +    depends on CGROUPS
> +    default y
> +    help
> +      Having too much memory pinned or locked can lead to system
> +      instability due to increased likelihood of encountering
> +      out-of-memory conditions. Select this option to enable a cgroup
> +      controller which can be used to limit the overall number of
> +      pages procceses in a cgroup may lock or have pinned by drivers.
> +
>  source "mm/damon/Kconfig"
>
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5..81db189 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> +obj-$(CONFIG_CGROUP_PINS) += pins_cgroup.o
> diff --git a/mm/pins_cgroup.c b/mm/pins_cgroup.c
> new file mode 100644
> index 0000000..2d8c6c7
> --- /dev/null
> +++ b/mm/pins_cgroup.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Controller for cgroups limiting number of pages pinned for FOLL_LONGETERM.
> + *
> + * Copyright (C) 2022 Alistair Popple <apopple@nvidia.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/threads.h>
> +#include <linux/atomic.h>
> +#include <linux/cgroup.h>
> +#include <linux/slab.h>
> +#include <linux/sched/task.h>
> +
> +#define PINS_MAX (-1ULL)
> +#define PINS_MAX_STR "max"
> +
> +struct pins_cgroup {
> +       struct cgroup_subsys_state      css;
> +
> +       atomic64_t                      counter;
> +       atomic64_t                      limit;
> +
> +       struct cgroup_file              events_file;
> +       atomic64_t                      events_limit;
> +};
> +
> +static struct pins_cgroup *css_pins(struct cgroup_subsys_state *css)
> +{
> +       return container_of(css, struct pins_cgroup, css);
> +}
> +
> +static struct pins_cgroup *parent_pins(struct pins_cgroup *pins)
> +{
> +       return css_pins(pins->css.parent);
> +}
> +
> +struct pins_cgroup *get_pins_cg(struct task_struct *task)

I think you'll need a version of this that gets multiple refs to the
pins cgroup. I will add more details in the patch that actually hooks
the accounting.

> +{
> +       return css_pins(task_get_css(task, pins_cgrp_id));
> +}
> +
> +void put_pins_cg(struct pins_cgroup *cg)
> +{
> +       css_put(&cg->css);
> +}
> +
> +static struct cgroup_subsys_state *
> +pins_css_alloc(struct cgroup_subsys_state *parent)
> +{
> +       struct pins_cgroup *pins;
> +
> +       pins = kzalloc(sizeof(struct pins_cgroup), GFP_KERNEL);
> +       if (!pins)
> +               return ERR_PTR(-ENOMEM);
> +
> +       atomic64_set(&pins->counter, 0);
> +       atomic64_set(&pins->limit, PINS_MAX);
> +       atomic64_set(&pins->events_limit, 0);
> +       return &pins->css;
> +}
> +
> +static void pins_css_free(struct cgroup_subsys_state *css)
> +{
> +       kfree(css_pins(css));
> +}
> +
> +/**
> + * pins_cancel - uncharge the local pin count
> + * @pins: the pin cgroup state
> + * @num: the number of pins to cancel
> + *
> + * This function will WARN if the pin count goes under 0, because such a case is
> + * a bug in the pins controller proper.
> + */
> +void pins_cancel(struct pins_cgroup *pins, int num)
> +{
> +       /*
> +        * A negative count (or overflow for that matter) is invalid,
> +        * and indicates a bug in the `pins` controller proper.
> +        */
> +       WARN_ON_ONCE(atomic64_add_negative(-num, &pins->counter));
> +}
> +
> +/**
> + * pins_uncharge - hierarchically uncharge the pin count
> + * @pins: the pin cgroup state
> + * @num: the number of pins to uncharge
> + */
> +void pins_uncharge(struct pins_cgroup *pins, int num)
> +{
> +       struct pins_cgroup *p;
> +
> +       for (p = pins; parent_pins(p); p = parent_pins(p))
> +               pins_cancel(p, num);
> +}
> +
> +/**
> + * pins_charge - hierarchically charge the pin count
> + * @pins: the pin cgroup state
> + * @num: the number of pins to charge
> + *
> + * This function does *not* follow the pin limit set. It cannot fail and the new
> + * pin count may exceed the limit. This is only used for reverting failed
> + * attaches, where there is no other way out than violating the limit.
> + */
> +static void pins_charge(struct pins_cgroup *pins, int num)
> +{
> +       struct pins_cgroup *p;
> +
> +       for (p = pins; parent_pins(p); p = parent_pins(p))
> +               atomic64_add(num, &p->counter);
> +}
> +
> +/**
> + * pins_try_charge - hierarchically try to charge the pin count
> + * @pins: the pin cgroup state
> + * @num: the number of pins to charge
> + *
> + * This function follows the set limit. It will fail if the charge would cause
> + * the new value to exceed the hierarchical limit. Returns true if the charge
> + * succeeded, false otherwise.
> + */
> +bool pins_try_charge(struct pins_cgroup *pins, int num)
> +{
> +       struct pins_cgroup *p, *q;
> +
> +       for (p = pins; parent_pins(p); p = parent_pins(p)) {
> +               uint64_t new = atomic64_add_return(num, &p->counter);
> +               uint64_t limit = atomic64_read(&p->limit);
> +
> +               if (limit != PINS_MAX && new > limit)
> +                       goto revert;
> +       }
> +
> +       return true;
> +
> +revert:
> +       for (q = pins; q != p; q = parent_pins(q))
> +               pins_cancel(q, num);
> +       pins_cancel(p, num);
> +
> +       return false;
> +}
> +
> +static int pins_can_attach(struct cgroup_taskset *tset)
> +{
> +       struct cgroup_subsys_state *dst_css;
> +       struct task_struct *task;
> +
> +       cgroup_taskset_for_each(task, dst_css, tset) {
> +               struct pins_cgroup *pins = css_pins(dst_css);
> +               struct cgroup_subsys_state *old_css;
> +               struct pins_cgroup *old_pins;
> +
> +               old_css = task_css(task, pins_cgrp_id);
> +               old_pins = css_pins(old_css);
> +
> +               pins_charge(pins, task->mm->locked_vm);

Why are we not using pins_try_charge() here, and failing attachment if
we cannot charge?

The comment above pins_charge() states that it is only used when
cancelling attachment, but this is not the case here, right?

> +               pins_uncharge(old_pins, task->mm->locked_vm);
> +       }
> +
> +       return 0;
> +}
> +
> +static void pins_cancel_attach(struct cgroup_taskset *tset)
> +{
> +       struct cgroup_subsys_state *dst_css;
> +       struct task_struct *task;
> +
> +       cgroup_taskset_for_each(task, dst_css, tset) {
> +               struct pins_cgroup *pins = css_pins(dst_css);
> +               struct cgroup_subsys_state *old_css;
> +               struct pins_cgroup *old_pins;
> +
> +               old_css = task_css(task, pins_cgrp_id);
> +               old_pins = css_pins(old_css);
> +
> +               pins_charge(old_pins, task->mm->locked_vm);
> +               pins_uncharge(pins, task->mm->locked_vm);
> +       }
> +}
> +
> +
> +static ssize_t pins_max_write(struct kernfs_open_file *of, char *buf,
> +                             size_t nbytes, loff_t off)
> +{
> +       struct cgroup_subsys_state *css = of_css(of);
> +       struct pins_cgroup *pins = css_pins(css);
> +       uint64_t limit;
> +       int err;
> +
> +       buf = strstrip(buf);
> +       if (!strcmp(buf, PINS_MAX_STR)) {
> +               limit = PINS_MAX;
> +               goto set_limit;
> +       }
> +
> +       err = kstrtoll(buf, 0, &limit);
> +       if (err)
> +               return err;
> +
> +       if (limit < 0 || limit >= PINS_MAX)
> +               return -EINVAL;
> +
> +set_limit:
> +       /*
> +        * Limit updates don't need to be mutex'd, since it isn't
> +        * critical that any racing fork()s follow the new limit.
> +        */
> +       atomic64_set(&pins->limit, limit);
> +       return nbytes;
> +}
> +
> +static int pins_max_show(struct seq_file *sf, void *v)
> +{
> +       struct cgroup_subsys_state *css = seq_css(sf);
> +       struct pins_cgroup *pins = css_pins(css);
> +       uint64_t limit = atomic64_read(&pins->limit);
> +
> +       if (limit >= PINS_MAX)
> +               seq_printf(sf, "%s\n", PINS_MAX_STR);
> +       else
> +               seq_printf(sf, "%lld\n", limit);
> +
> +       return 0;
> +}
> +
> +static s64 pins_current_read(struct cgroup_subsys_state *css,
> +                            struct cftype *cft)
> +{
> +       struct pins_cgroup *pins = css_pins(css);
> +
> +       return atomic64_read(&pins->counter);
> +}
> +
> +static int pins_events_show(struct seq_file *sf, void *v)
> +{
> +       struct pins_cgroup *pins = css_pins(seq_css(sf));
> +
> +       seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pins->events_limit));
> +       return 0;
> +}
> +
> +static struct cftype pins_files[] = {
> +       {
> +               .name = "max",
> +               .write = pins_max_write,
> +               .seq_show = pins_max_show,
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +       },
> +       {
> +               .name = "current",
> +               .read_s64 = pins_current_read,
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +       },
> +       {
> +               .name = "events",
> +               .seq_show = pins_events_show,
> +               .file_offset = offsetof(struct pins_cgroup, events_file),
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +       },
> +       { }     /* terminate */
> +};
> +
> +struct cgroup_subsys pins_cgrp_subsys = {
> +       .css_alloc = pins_css_alloc,
> +       .css_free = pins_css_free,
> +       .legacy_cftypes = pins_files,
> +       .dfl_cftypes = pins_files,
> +       .can_attach = pins_can_attach,
> +       .cancel_attach = pins_cancel_attach,
> +};
> --
> git-series 0.9.1
>
