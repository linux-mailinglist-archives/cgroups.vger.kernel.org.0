Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B039442D
	for <lists+cgroups@lfdr.de>; Fri, 28 May 2021 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhE1O0L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 May 2021 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhE1O0L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 May 2021 10:26:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3AC06174A
        for <cgroups@vger.kernel.org>; Fri, 28 May 2021 07:24:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v8so5567277lft.8
        for <cgroups@vger.kernel.org>; Fri, 28 May 2021 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qB23gabRSVjg16uX7Swp2PUtcfjaqZT0ss7Q1VTLtc=;
        b=IvyyHPQK78oRsjX1trLtzkEWbZQcBcxDmBNKDEIV+TWkLXpTAhEGYGhUT825yUWDe3
         HOvyK8czIZ8a/ziv8VdJNnsD9f+hyMTaBr5Z+11W2jfphSAUBUxWQl/JWAt3zOXKWK6+
         6WUWRnllmUwqo5uppaUBK2Cq3Rv0mk1NHU+hMS8DvwcBKuUtoI1WQEn+wFV1v1D7FR0h
         R2FBAsikMQO2RkiEx0k/I7Q6IjnpFTWHC+wDb7pTIoo6GmvpGAtbG/NQcT5d/sPtZGxB
         iedBqp2shjY21Mr6l5/B2DiYGmsxz8ofmdNn4UGqxsp/a7/6//BIkloKnws+EG6oNOB2
         sx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qB23gabRSVjg16uX7Swp2PUtcfjaqZT0ss7Q1VTLtc=;
        b=g8dO03T+plXkgDO39L6nxseLYosAWKH1fjI9COOfmw6vvD/7zhxfYO3cGocT7o5wNs
         ZQyB85KXhw7wbHLMzTfZkCKdz5C8stB6C0RaMAyDJiIebKsRjzM8/T9fuaDqrBPX16VI
         4vYQoXkA33v8sCT8SD01ohNU6dcAdkrz+ypWZD5D0TPGPkgizRoD1TXiVFhD8t61TEv2
         kZuN0naaUe5DDb3QC7rLnyM4e8PYsyfDOrhYLPynR7ssAgo94b1nRSQFD8NvOpUcD8e9
         jgzb9Ore8I3e+7E2ve2zMnejefd9Lrg9zrDrMkR2RAWKGJxFsnyLv6slKm47nhbocAIG
         rOWw==
X-Gm-Message-State: AOAM530KyI5N1HH/cptlR9vB5R47oLZCScRhgSUpcDHoqasZg6OXVEwM
        OMcChQ5yfb8xiNRwR60jG4ArPIYNGweuL2VQDTuwX/FIajiXYA==
X-Google-Smtp-Source: ABdhPJy0F/Mm6KcZwDdOCTk1XjyjllVwhD7rJDCScs/W95trYbOm2PhE+XQkRRJf8qLMPSwvPnMGq4ehF/H4gBq/Jbk=
X-Received: by 2002:ac2:5111:: with SMTP id q17mr6128288lfb.277.1622211873614;
 Fri, 28 May 2021 07:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
In-Reply-To: <20210518125202.78658-3-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 May 2021 16:24:22 +0200
Message-ID: <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
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

On Tue, 18 May 2021 at 14:54, Odin Ugedal <odin@uged.al> wrote:
>
> This fixes an issue where fairness is decreased since cfs_rq's can
> end up not being decayed properly. For two sibling control groups with
> the same priority, this can often lead to a load ratio of 99/1 (!!).
>
> This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
> will be removed from the leaf list. When they initial cfs_rq is
> unthrottled, it will currently only re add descendant cfs_rq's if they
> have one or more entities enqueued. This is not a perfect heuristic.

What would be the other condition in addition to the current one
:cfs_rq->nr_running >= 1 ?
We need to add a cfs_rq in the list if it still contributes to the
tg->load_avg and the split of the share. Can't we add a condition for
this instead of adding a new field ?

>
> This fix change this behavior to save what cfs_rq's was removed from the
> list, and readds them properly on unthrottle.
>
> Can often lead to sutiations like this for equally weighted control
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
>  kernel/sched/fair.c  | 11 ++++++-----
>  kernel/sched/sched.h |  1 +
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ceda53c2a87a..e7423d658389 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -376,7 +376,8 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>         return false;
>  }
>
> -static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +/* Returns 1 if cfs_rq was present in the list and removed */
> +static inline bool list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         if (cfs_rq->on_list) {
>                 struct rq *rq = rq_of(cfs_rq);
> @@ -393,7 +394,9 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>
>                 list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
>                 cfs_rq->on_list = 0;
> +               return 1;
>         }
> +       return 0;
>  }
>
>  static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> @@ -4742,9 +4745,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>         if (!cfs_rq->throttle_count) {
>                 cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
>                                              cfs_rq->throttled_clock_task;
> -
> -               /* Add cfs_rq with already running entity in the list */
> -               if (cfs_rq->nr_running >= 1)
> +               if (cfs_rq->insert_on_unthrottle)
>                         list_add_leaf_cfs_rq(cfs_rq);
>         }
>
> @@ -4759,7 +4760,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>         /* group is entering throttled state, stop time */
>         if (!cfs_rq->throttle_count) {
>                 cfs_rq->throttled_clock_task = rq_clock_task(rq);
> -               list_del_leaf_cfs_rq(cfs_rq);
> +               cfs_rq->insert_on_unthrottle = list_del_leaf_cfs_rq(cfs_rq);
>         }
>         cfs_rq->throttle_count++;
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a189bec13729..12a707d99ee6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -602,6 +602,7 @@ struct cfs_rq {
>         u64                     throttled_clock_task_time;
>         int                     throttled;
>         int                     throttle_count;
> +       int                     insert_on_unthrottle;
>         struct list_head        throttled_list;
>  #endif /* CONFIG_CFS_BANDWIDTH */
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
> --
> 2.31.1
>
