Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50C73A6636
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhFNMEl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhFNME0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 08:04:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC4C061767
        for <cgroups@vger.kernel.org>; Mon, 14 Jun 2021 05:02:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r16so19791383ljk.9
        for <cgroups@vger.kernel.org>; Mon, 14 Jun 2021 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+lA9naaKsakWVrnjr3YXHM+z9q5nmlt/676DWB5bB0=;
        b=BEXyZr+Mqcby06OU4xPayd0j5B1e+t+U8QVogAiv1eM8rGXa4EhjdAscNmJXLAnDH6
         fQcREIFx0bsNQqvqWU2OJ9SIRCrnbWuaNylL69JF6DvXhGuDQ732KE3ZK9nmKofx3h9t
         Ch7i0UN9fGhyInjb+Gx48+UROjgrsdvFc/R25WN6XVbKGUNWwkFxb9uDEK/+j2Q/CGON
         lesYdJSmMMA2UD75Q/Sq+GJ7ytjr7OjCMJWJB3BP9xMTsa6TvYFlnptHOWZLf/wx3o+P
         WA1FJOI0vU9hS1OBce+QAnJg5G4G+aLVRXegSxlu/hXMgk5MIgI9fGygMciMJOa4/Sis
         lCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+lA9naaKsakWVrnjr3YXHM+z9q5nmlt/676DWB5bB0=;
        b=Mc5YT3qnY5K8flIzEfN/urbcYlX9rfPdFm6vaf8mJ6SZ+8eMc32+HADZLST06q9PUJ
         JuaFPEBz4B5lgDPEUJlYm2x7g3yobuX7O7/+QEEyw2AS1xsbTyeCkDGj5oHSsO9IYGBw
         Q8/ndqJVqVMPiEJNlB8TkpErUqPUhL62t7q9FNABBVq1/YKFuo8keOC/wHKnWR9om8Db
         G6p/Csvk5EVkI4P+hnx2csHybNWGKwVV7J3vCiM4KvRbpAKB6/5nLY/q6Sk7ujRmAM9e
         vH9Zctrg1VyuKA1SM407Llo7ujg4mIZcrrKq+XhyVlN1hln/iMEB8AuLD8O5IiO1Oa7x
         vTWQ==
X-Gm-Message-State: AOAM533I3TcgkvFT1AHM/Q5WQlXed1twbxkIYjFiC8v4QK3XA4fYAsi4
        fH8fCXqXgxzmqEuSUOtukkiDSRYFHt20MdX4t96ksQ==
X-Google-Smtp-Source: ABdhPJyLz+rY5Xii9PF4m5z3K5a8OiOHq0P/xtHtKI5bakv0f5FrmJ+ofjcRsGKB6Laqmj7eo2iN0EvbXhjW3NIcnuc=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr13037673lji.209.1623672126423;
 Mon, 14 Jun 2021 05:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210612112815.61678-1-odin@uged.al>
In-Reply-To: <20210612112815.61678-1-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Jun 2021 14:01:55 +0200
Message-ID: <CAKfTPtCMqZZnbwfhw0gz1Bne4j7PcG-Ma02a=gmcGbjY1bHk=g@mail.gmail.com>
Subject: Re: [PATCH v5] sched/fair: Correctly insert cfs_rq's to list on unthrottle
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

On Sat, 12 Jun 2021 at 13:31, Odin Ugedal <odin@uged.al> wrote:
>
> This fixes an issue where fairness is decreased since cfs_rq's can
> end up not being decayed properly. For two sibling control groups with
> the same priority, this can often lead to a load ratio of 99/1 (!!).
>
> This happen because when a cfs_rq is throttled, all the descendant cfs_rq's

s/happen/happens/

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

minor typo in the commit message otherwise

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

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
> Changes since v4:
>  - Move cfs_rq_is_decayed again
>
>  kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..c48d1d409b20 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3283,6 +3283,24 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>
>  #ifdef CONFIG_SMP
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> +
> +static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> +{
> +       if (cfs_rq->load.weight)
> +               return false;
> +
> +       if (cfs_rq->avg.load_sum)
> +               return false;
> +
> +       if (cfs_rq->avg.util_sum)
> +               return false;
> +
> +       if (cfs_rq->avg.runnable_sum)
> +               return false;
> +
> +       return true;
> +}
> +
>  /**
>   * update_tg_load_avg - update the tg's load avg
>   * @cfs_rq: the cfs_rq whose avg changed
> @@ -4719,8 +4737,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
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
> @@ -7895,23 +7913,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
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
