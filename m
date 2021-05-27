Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C60392F57
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhE0NUX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhE0NUW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 09:20:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B8C061574
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 06:18:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w15so734616ljo.10
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfylii+y+Ojxu7E7KT+8vH0OFzsUpSqBPwQ/qgziQBk=;
        b=W3fRkD3lLeYB/4+AHVLLqJf7qv0yMm9bwfQ+wjR+/HZVP4sihm1Ai/PRMvuH//POO/
         3eEKuOhr2VmDl6z2lCWdqJ5S/mXYn/reSSul4695W8nwMpqeb9UVE5sr/VXiZ7PR+rmk
         2N/liwj7qqiWtfKyE608rYU527j3V0yQjbiaCIlvH7JbO7ZTgORZghg3HHd9JIbLutux
         1hBgoiG4wCKvY9r2iuYFvE4LJOzBHSZZM4eXK2vUhmxXhn9tFGS/HnKh3YyN/AwYiKjp
         kNf/iL+jUEWu7lCGgAAIx12TY8GQMYTavD06/kB5ULiZmHKxJ3HJ7F/168syCUtuuQkj
         NnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfylii+y+Ojxu7E7KT+8vH0OFzsUpSqBPwQ/qgziQBk=;
        b=VkmFKE8iCtn2u0BxwmD/uFqTENkuIaW88Vjrsqad3Ryj5Jm3ma7VJE4aJIxN2QdVdo
         d58EcJeobTxB1Zb6Yu+Uu4C0z3n9+533D4L7PmKHQUfjAKHoVaKtIULt1MJP4iZx6m+d
         /WABB8QlCYstQUr8SiP6A2ny3LM2soYkEdItbX6Y4Pr+rDVSAmSPqQXmwznDaMgRqjYP
         bNd8HsU0KNIb6rmBbjJEGtTTji5KDEN8u+XNWoIXe9o9HwYi2FyE4C7+3xucEmRSuxY2
         P7AqTa1ySkbrtUSBsFC+mEn8ZnkKurYcCsg5YWVH4zxMPe1TKcr51jpLwUlWcfWT8X87
         oWVA==
X-Gm-Message-State: AOAM530S2M+HW5wdG1dy2RylQydStiWp5TwlgxysfMf0tqfws6iPWpGv
        hmtkRB7bRANikAu0PGEun4324QAYS73F7qazeFjbYiuBMycAVA==
X-Google-Smtp-Source: ABdhPJx+g50YsqGERtBJWbjP0RO83HlKxLtDbwGI40zbm4jhS5b+PkT9bNNso8STazlP6np243ZAFKK6qOSrOBPB+cU=
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr2559240ljp.209.1622121526742;
 Thu, 27 May 2021 06:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
 <20210527122916.27683-2-vincent.guittot@linaro.org> <YK+ZGlfPxK3JCySS@hirez.programming.kicks-ass.net>
In-Reply-To: <YK+ZGlfPxK3JCySS@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 15:18:35 +0200
Message-ID: <CAKfTPtAE6DJTwxZ996BJoUJF++fFHdFk-C2bpUQ8aG0NQusApA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: keep load_avg and load_sum synced
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 27 May 2021 at 15:06, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 27, 2021 at 02:29:15PM +0200, Vincent Guittot wrote:
>
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3509,7 +3509,8 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
> >       se->avg.load_sum = runnable_sum;
> >       se->avg.load_avg = load_avg;
> >       add_positive(&cfs_rq->avg.load_avg, delta_avg);
> > -     add_positive(&cfs_rq->avg.load_sum, delta_sum);
> > +     cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
>
> If I'm not mistaken, this makes delta_sum unused, so we can remove it
> entirely, see below.

yes, you're right

>
> > +
>
> This extra blank space, we really need that? :-)
>
> >  }
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..2b99e687fe7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3453,10 +3453,9 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
>  static inline void
>  update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
> -       long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
> +       long running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
>         unsigned long load_avg;
>         u64 load_sum = 0;
> -       s64 delta_sum;
>         u32 divider;
>
>         if (!runnable_sum)
> @@ -3503,13 +3502,11 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>         load_sum = (s64)se_weight(se) * runnable_sum;
>         load_avg = div_s64(load_sum, divider);
>
> -       delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
> -       delta_avg = load_avg - se->avg.load_avg;
> -
>         se->avg.load_sum = runnable_sum;
>         se->avg.load_avg = load_avg;
> -       add_positive(&cfs_rq->avg.load_avg, delta_avg);
> -       add_positive(&cfs_rq->avg.load_sum, delta_sum);
> +
> +       add_positive(&cfs_rq->avg.load_avg, (long)(load_avg - se->avg.load_avg));

you have to keep:
delta_avg = load_avg - se->avg.load_avg
or move se->avg.load_avg = load_avg after
add_positive(&cfs_rq->avg.load_avg, ..);
because otherwise (load_avg - se->avg.load_avg) == 0


> +       cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
>  }
>
>  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
