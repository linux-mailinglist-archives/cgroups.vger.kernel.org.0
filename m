Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8439DDA6
	for <lists+cgroups@lfdr.de>; Mon,  7 Jun 2021 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhFGNcq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Jun 2021 09:32:46 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38817 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhFGNcn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Jun 2021 09:32:43 -0400
Received: by mail-lj1-f176.google.com with SMTP id s22so1799382ljg.5
        for <cgroups@vger.kernel.org>; Mon, 07 Jun 2021 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pMeBbJnHe0dT56aBjX+SG8tgBkU1RFs5WrTELGr21w=;
        b=S/bfEag7I89zOTS/86dOO6jC4cob1/NUn22kCuKmb2B1z8hvctiuJzA9rY/gEG4b46
         uCDehsvTljcTN45kv7qc+PiPfHVPLL33aKkCVYW/hhbHPi2NrIb3HgmuwO+aZyB5ziJm
         vrMfArzkFmt32vDk+p2RNUzAwaFvWldu76G9Bf3//0WUXjZdOOrGYavx+pit0/8fi/PM
         12vAMOuBoy/HAMNETrGn8p//nNwKorc6LgGQxYNygMcA4kbAytF8+YXmaYqzSgKFTnKs
         NVw2ENxozeJigZymVLo63ReaHlbvhwZDm9gfh2YrzMoB/olyKutSLj7kYbGLimIy1Y6o
         90lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pMeBbJnHe0dT56aBjX+SG8tgBkU1RFs5WrTELGr21w=;
        b=O9lg1bw+wJdWz+wLmvAKxemsVXwrcjOJoqn/9WSyWIGmLpNKXXX5+ADOGxf99g+dPt
         dV2qRpeB1Wxgb0i96OSb4R038+uly2XO6D0ygsylFS6MUGIZpzPPCNLfDclqzKuaWQ6t
         hWvFZM01tueKaIheAbc0EogMazk7lz/nWd+S6Ql5ODeMOM7Vj5W7LsrI2yLpw+wk4Cny
         cUp9ZuO0UwUco9GWQ21SzVbU+oFD1bd3fR678qsHG4e4FdQpIdXz5rPbb2u8uXDBY5w4
         A1NjhFCytdIlYmiHNhFfRiB+xc/3vdj9OyffCh2FjdR+zot1lukKuR2U6qaVu+jB9xzI
         O4TA==
X-Gm-Message-State: AOAM533dbN0YqD7wvz6TN5HQzfy9n+gn9FIV1fFRK0cxUhapCkw7RodZ
        0/hf0XvyVIXAoYFk0Yg8GuCXLfrqTaZHvYThcHF/ug==
X-Google-Smtp-Source: ABdhPJyynPB60BGVh3pTGL9cuYERwmpP/tCiHXNF18eK0N8QEvX+6+NT5menbwA+NAmxn9IyhLYNKn5DboBOEdFSVRU=
X-Received: by 2002:a2e:858a:: with SMTP id b10mr14594374lji.445.1623072591497;
 Mon, 07 Jun 2021 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210604102314.697749-1-odin@uged.al>
In-Reply-To: <20210604102314.697749-1-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Jun 2021 15:29:40 +0200
Message-ID: <CAKfTPtDHrD_QGoLeUkR0ALRakWH+KOopHZk=29fyi-oonerd9g@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on unthrottle
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

On Fri, 4 Jun 2021 at 12:26, Odin Ugedal <odin@uged.al> wrote:
>
> This fixes an issue where fairness is decreased since cfs_rq's can
> end up not being decayed properly. For two sibling control groups with
> the same priority, this can often lead to a load ratio of 99/1 (!!).
>
> This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
> will be removed from the leaf list. When they initial cfs_rq is
> unthrottled, it will currently only re add descendant cfs_rq's if they
> have one or more entities enqueued. This is not a perfect heuristic.
>
> Instead, we insert all cfs_rq's that contain one or more enqueued
> entities, or it its load is not completely decayed.
>
> Can often lead to situations like this for equally weighted control
> groups:
>
> $ ps u -C stress
> USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
> root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1
>
> Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
> Changes since v1:
>  - Replaced cfs_rq field with using tg_load_avg_contrib
>  - Went from 3 to 1 patches; one is merged and one is replaced
>    by a new patchset.
> Changes since v2:
>  - Use !cfs_rq_is_decayed() instead of tg_load_avg_contrib
>  - Moved cfs_rq_is_decayed to above its new use
> Changes since v3:
>  - (hopefully) Fix config for !CONFIG_SMP
>  kernel/sched/fair.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..eec32f214ff8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -712,6 +712,25 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         return calc_delta_fair(sched_slice(cfs_rq, se), se);
>  }
>
> +static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)

It's not the best place for this function:
- pelt.h header file is included below but cfs_rq_is_decayed() uses PELT
- CONFIG_SMP is already defined few lines below
- cfs_rq_is_decayed() is only used with CONFIG_FAIR_GROUP_SCHED and
now with CONFIG_CFS_BANDWIDTH which depends on the former

so moving cfs_rq_is_decayed() just above update_tg_load_avg() with
other functions used for propagating and updating tg load seems a
better place

> +{
> +       if (cfs_rq->load.weight)
> +               return false;
> +
> +#ifdef CONFIG_SMP
> +       if (cfs_rq->avg.load_sum)
> +               return false;
> +
> +       if (cfs_rq->avg.util_sum)
> +               return false;
> +
> +       if (cfs_rq->avg.runnable_sum)
> +               return false;
> +#endif
> +
> +       return true;
> +}
> +
>  #include "pelt.h"
>  #ifdef CONFIG_SMP
>
> @@ -4719,8 +4738,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>                 cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
>                                              cfs_rq->throttled_clock_task;
>
> -               /* Add cfs_rq with already running entity in the list */
> -               if (cfs_rq->nr_running >= 1)
> +               /* Add cfs_rq with load or one or more already running entities to the list */
> +               if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
>                         list_add_leaf_cfs_rq(cfs_rq);
>         }
>
> @@ -7895,23 +7914,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>
> -static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> -{
> -       if (cfs_rq->load.weight)
> -               return false;
> -
> -       if (cfs_rq->avg.load_sum)
> -               return false;
> -
> -       if (cfs_rq->avg.util_sum)
> -               return false;
> -
> -       if (cfs_rq->avg.runnable_sum)
> -               return false;
> -
> -       return true;
> -}
> -
>  static bool __update_blocked_fair(struct rq *rq, bool *done)
>  {
>         struct cfs_rq *cfs_rq, *pos;
> --
> 2.31.1
>
