Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E729F372660
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhEDHPV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhEDHPU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 03:15:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C27C061574
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 00:14:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so11891335lft.1
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3fJtS3ag0x38yekpEIajbjelrhY1TxoOI6xRz6q4h0=;
        b=X22FSap+30zbdRml4+tYesbBLG/84suRP4UdeSfYPFUkRa3ZYSTSQOqWGhvyXvRmSC
         VLzaPEjZHf8mG38W584jjFxx+/YHPKfcyNNvuLUuGjz6+1m+033WaKL5el5uRILdI+rK
         03R3c4XDIL330t+iSyz+dbwtEiw+KlLDbMyqJ4XcIhZFokhzlUaaaIrLmrqkPg6T3Zw3
         bZooEXZ/0jw2glT+mU1Sk+AxL8o3YaGO1L5HaQaoN8dhPAsMxs5v54riRDhwLgjosaLT
         1R7MX8jeh+D3N332K7Cmx0872bH5Uqgnvrp4SnMaRw9l88M2CphFgdXg8+qZqIOBYlLq
         WlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3fJtS3ag0x38yekpEIajbjelrhY1TxoOI6xRz6q4h0=;
        b=go3SsP89/4IHsSs/+j3iMGycVi302N9KY+iLXqJAoy6niOLivoS5wIkfyo/ndlztt5
         b77zdhF9nzoDe47rx+C8fPptWLAof+BItQbajwxRJUS3EzqbF6RrwpaS2yEH0i7zHNQN
         QUyb9rdg/j9MtdNQi6WGQ/iyfJrYUxq0i2Y9L7Y2dmTodVpI4xa4fRdBHKqRr2dPjwyD
         exuNVOk1TrqQUm5x4tgmrB+HVl2svLsdKEngHPIXFSbtWjXspd7R1SZ55HD6P/2azd9r
         8da8Cfa/pGn/0QBt711+FDpUekv1XjhQ3JJ9HOEx8sPOXRY3aVe+f9POx5lYYXGa0PHT
         j+Dg==
X-Gm-Message-State: AOAM532S0B0arW+6+cunW1TQG4/v4YwNQ0/0kVV9m/rqDPTef1FC0xaP
        Xp2I5TRY06YDMdt5PBe1FDBONAcAnjrkLTNs6RI6K2JHl30=
X-Google-Smtp-Source: ABdhPJydplB/zexpiT4WdAF6Snw8gvEeYJedATjQZjhE/xELCXLn4mw0xYCEZdyRqrmR3in/d/umAHDEmIdSzZBzWAI=
X-Received: by 2002:a05:6512:c14:: with SMTP id z20mr15295085lfu.277.1620112463206;
 Tue, 04 May 2021 00:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210501141950.23622-1-odin@uged.al> <20210501141950.23622-2-odin@uged.al>
In-Reply-To: <20210501141950.23622-2-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 4 May 2021 09:14:12 +0200
Message-ID: <CAKfTPtDmYcr82o4V=Hovc3+Ht4bqhj_NNiSG2Zm+CfdpcAX9iA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched/fair: Fix unfairness caused by missing load decay
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 1 May 2021 at 16:22, Odin Ugedal <odin@uged.al> wrote:
>
> This fixes an issue where old load on a cfs_rq is not properly decayed,
> resulting in strange behavior where fairness can decrease drastically.
> Real workloads with equally weighted control groups have ended up
> getting a respective 99% and 1%(!!) of cpu time.
>
> When an idle task is attached to a cfs_rq by attaching a pid to a cgroup,
> the old load of the task is attached to the new cfs_rq and sched_entity by
> attach_entity_cfs_rq. If the task is then moved to another cpu (and
> therefore cfs_rq) before being enqueued/woken up, the load will be moved
> to cfs_rq->removed from the sched_entity. Such a move will happen when
> enforcing a cpuset on the task (eg. via a cgroup) that force it to move.
>
> The load will however not be removed from the task_group itself, making
> it look like there is a constant load on that cfs_rq. This causes the
> vruntime of tasks on other sibling cfs_rq's to increase faster than they
> are supposed to; causing severe fairness issues. If no other task is
> started on the given cfs_rq, and due to the cpuset it would not happen,
> this load would never be properly unloaded. With this patch the load
> will be properly removed inside update_blocked_averages. This also
> applies to tasks moved to the fair scheduling class and moved to another
> cpu, and this path will also fix that. For fork, the entity is queued
> right away, so this problem does not affect that.
>
> This applies to cases where the new process is the first in the cfs_rq,
> issue introduced 3d30544f0212 ("sched/fair: Apply more PELT fixes"), and
> when there has previously been load on the cgroup but the cgroup was
> removed from the leaflist due to having null PELT load, indroduced
> in 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing
> path").
>
> For a simple cgroup hierarchy (as seen below) with two equally weighted
> groups, that in theory should get 50/50 of cpu time each, it often leads
> to a load of 60/40 or 70/30.
>
> parent/
>   cg-1/
>     cpu.weight: 100
>     cpuset.cpus: 1
>   cg-2/
>     cpu.weight: 100
>     cpuset.cpus: 1
>
> If the hierarchy is deeper (as seen below), while keeping cg-1 and cg-2
> equally weighted, they should still get a 50/50 balance of cpu time.
> This however sometimes results in a balance of 10/90 or 1/99(!!) between
> the task groups.
>
> $ ps u -C stress
> USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
> root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1
>
> parent/
>   cg-1/
>     cpu.weight: 100
>     sub-group/
>       cpu.weight: 1
>       cpuset.cpus: 1
>   cg-2/
>     cpu.weight: 100
>     sub-group/
>       cpu.weight: 10000
>       cpuset.cpus: 1
>
> This can be reproduced by attaching an idle process to a cgroup and
> moving it to a given cpuset before it wakes up. The issue is evident in
> many (if not most) container runtimes, and has been reproduced
> with both crun and runc (and therefore docker and all its "derivatives"),
> and with both cgroup v1 and v2.
>
> Fixes: 3d30544f0212 ("sched/fair: Apply more PELT fixes")
> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> Signed-off-by: Odin Ugedal <odin@uged.al>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks

> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..9e189727a457 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10844,16 +10844,22 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq;
>
> +       list_add_leaf_cfs_rq(cfs_rq_of(se));
> +
>         /* Start to propagate at parent */
>         se = se->parent;
>
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
> -               if (cfs_rq_throttled(cfs_rq))
> -                       break;
> +               if (!cfs_rq_throttled(cfs_rq)){
> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
> +                       list_add_leaf_cfs_rq(cfs_rq);
> +                       continue;
> +               }
>
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> +               if (list_add_leaf_cfs_rq(cfs_rq))
> +                       break;
>         }
>  }
>  #else
> --
> 2.31.1
>
