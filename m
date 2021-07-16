Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906413CB775
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhGPMqV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 08:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbhGPMqU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 08:46:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CE2C061760
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 05:43:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 22so15703784lfy.12
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPc9GTX5VyyHJrW3MaVc/E6nclOhvbKeO0mnyiHC1zY=;
        b=jTDn3YWmpC/FctJCzOr8WRnUBwHnxzMHo6DqKPNmiGLy7vDPPPLB4CoOJgvlWnGd69
         1Q8rZ/brO31Gt+Rzo3WlU/IubHn5fpxkY56zOl4KqpgQ4lH+DBu1idCiLO8mq8jqAntK
         rcEUS6HsyPDTmFBi8BsI6igmDhywar8Atu0HGjEyaxOImobB3BSWHN8v9YzMnRJbzXtE
         9ugX++nQzb8nu0PCvHKczzxjDtnaAbCgbAiFQwpBXd13mnzP05IUojyinF4UlVxU9MqB
         IXH3jvOfnbSLwyORz8Afsk4XbTf5MY8KKDQwaEgLxms/twcMUI2wCCtvPK2yX+THlcJx
         zGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPc9GTX5VyyHJrW3MaVc/E6nclOhvbKeO0mnyiHC1zY=;
        b=r0tyreX1g5OIcb1M6WN4MONxLWJFQL4V41hT3nMg2prVJTgDq+G5OTj4/JtruNXmO0
         iqUeo5gluuD+F59ZixPW9G19SHgnXElvn4U6lGaHN1fDJm4G5ROIM9O94CX7Fg2E3kBS
         xlIY0qMUqBw0otWQTAwwzI3Vnv9MYxGF+GvZ9+82cX8ZOuS5t8wMWiXAQD1b9s02IKR8
         kaX+8n2Bs28TfngVWHkmrpkM2YfsuOSqpAFnKaYGsdacXXm05HHomRPXYHbBKpDd+XoZ
         iGpFlcT/kw8i0KEOTuShB34NnnDwbiTL0DoPEddTzC6PTGA+2Diq0ICGQTQXF4dpSpC0
         tROg==
X-Gm-Message-State: AOAM530YPhjqG6u5Hg4S64D+ScUMMzY+p4/WxECHB8Nsv3cDlj1Yj/fJ
        nuxs5ZRzLpQ7IbLvME9tpHrQlZHvhV2xZsbZJlGidw==
X-Google-Smtp-Source: ABdhPJypb+ne/bF2pi7D5wbSASimiWqxfKvpKwgf6g1mYmJZ8KQSKlgp/ZS+hS5L0JSY8vTIjhr/BfGAcCTJhlOp7lE=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr7332429lfe.549.1626439402177;
 Fri, 16 Jul 2021 05:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210716084805.273744-1-yangyingliang@huawei.com>
In-Reply-To: <20210716084805.273744-1-yangyingliang@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 16 Jul 2021 05:43:10 -0700
Message-ID: <CALvZod4EYKihfOdtX83kzEZX48cu_AptZOQ5f_GHSFJ=4paUyQ@mail.gmail.com>
Subject: Re: [PATCH -next] memcg: fix sleep in invalid context in cgroup_rstat_flush()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 16, 2021 at 1:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> When start the kernel, I got this report:
>
> [   13.787531][  T248] BUG: sleeping function called from invalid context at kernel/cgroup/rstat.c:200
> [   13.788799][  T248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 248, name: kworker/u8:3
> [   13.789971][  T248] 3 locks held by kworker/u8:3/248:
> [   13.790638][  T248]  #0: ffff888100100138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x942/0x17d0
> [   13.792170][  T248]  #1: ffffc900018bfe00 (stats_flush_work){+.+.}-{0:0}, at: process_one_work+0x977/0x17d0
> [   13.793477][  T248]  #2: ffffffff8baccf78 (stats_flush_lock){+.+.}-{2:2}, at: mem_cgroup_flush_stats+0xd/0x50
> [   13.794815][  T248] Preemption disabled at:
> [   13.794821][  T248] [<0000000000000000>] 0x0
> [   13.795951][  T248] CPU: 2 PID: 248 Comm: kworker/u8:3 Tainted: G        W         5.14.0-rc1-next-20210716+ #342
> [   13.797287][  T248] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   13.798564][  T248] Workqueue: events_unbound flush_memcg_stats_work
> [   13.799400][  T248] Call Trace:
> [   13.799817][  T248]  dump_stack_lvl+0xcd/0x134
> [   13.800405][  T248]  ___might_sleep.cold.155+0x1f2/0x238
> [   13.801107][  T248]  cgroup_rstat_flush+0x1c/0x50
> [   13.801724][  T248]  mem_cgroup_flush_stats+0x39/0x50
> [   13.802131][  T248]  process_one_work+0xa6c/0x17d0
> [   13.802131][  T248]  ? pwq_dec_nr_in_flight+0x360/0x360
> [   13.802131][  T248]  ? do_raw_spin_lock+0x121/0x2d0
> [   13.802131][  T248]  worker_thread+0x8c/0xda0
> [   13.802131][  T248]  ? process_one_work+0x17d0/0x17d0
> [   13.802131][  T248]  kthread+0x3d5/0x4c0
> [   13.802131][  T248]  ? set_kthread_struct+0x130/0x130
> [   13.802131][  T248]  ret_from_fork+0x1f/0x30
>
> To fix this, move stats_flush_lock into cgroup_rstat_flush() after might_sleep(),
> unlock stats_flush_lock before sleep in cgroup_rstat_flush_locked() and lock
> stats_flush_lock after wake up.
>
> Fixes: 42265e014ac7 ("memcg: infrastructure to flush memcg stats")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for the report.

> ---
>  kernel/cgroup/rstat.c | 7 +++++++
>  mm/memcontrol.c       | 5 -----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 7f0e58917432..d7ce96ba0105 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -5,6 +5,7 @@
>
>  static DEFINE_SPINLOCK(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static DEFINE_SPINLOCK(stats_flush_lock);
>
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>
> @@ -175,8 +176,10 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
>                 if (may_sleep && (need_resched() ||
>                                   spin_needbreak(&cgroup_rstat_lock))) {
>                         spin_unlock_irq(&cgroup_rstat_lock);
> +                       spin_unlock(&stats_flush_lock);
>                         if (!cond_resched())
>                                 cpu_relax();
> +                       spin_lock(&stats_flush_lock);
>                         spin_lock_irq(&cgroup_rstat_lock);
>                 }
>         }
> @@ -199,9 +202,13 @@ void cgroup_rstat_flush(struct cgroup *cgrp)
>  {
>         might_sleep();
>
> +       if (!spin_trylock(&stats_flush_lock))
> +               return;
> +

No, there is no point of stats_flush_lock if we add this to rstat and
take it for everyone.

>         spin_lock_irq(&cgroup_rstat_lock);
>         cgroup_rstat_flush_locked(cgrp, true);
>         spin_unlock_irq(&cgroup_rstat_lock);
> +       spin_unlock(&stats_flush_lock);
>  }
>
>  /**
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 456f5310ea59..c6b0f5b41893 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -109,7 +109,6 @@ static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>  static void flush_memcg_stats_work(struct work_struct *w);
>  static DECLARE_WORK(stats_flush_work, flush_memcg_stats_work);
>  static DEFINE_PER_CPU(unsigned int, stats_flush_threshold);
> -static DEFINE_SPINLOCK(stats_flush_lock);
>
>  #define THRESHOLDS_EVENTS_TARGET 128
>  #define SOFTLIMIT_EVENTS_TARGET 1024
> @@ -5355,11 +5354,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>
>  void mem_cgroup_flush_stats(void)
>  {
> -       if (!spin_trylock(&stats_flush_lock))
> -               return;
> -
>         cgroup_rstat_flush(root_mem_cgroup->css.cgroup);

We should change this to cgroup_rstat_flush_irqsafe(). One addition we
can do is to change all rstat flush callsites in memcontrol.c to go
through mem_cgroup_flush_stats()

> -       spin_unlock(&stats_flush_lock);
>  }
>
>  static void flush_memcg_stats_dwork(struct work_struct *w)
> --
> 2.25.1
>
