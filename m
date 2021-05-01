Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32A370793
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhEAOfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 May 2021 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhEAOfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 May 2021 10:35:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989BC06138B
        for <cgroups@vger.kernel.org>; Sat,  1 May 2021 07:34:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k127so1066611qkc.6
        for <cgroups@vger.kernel.org>; Sat, 01 May 2021 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35m+0g71EHp5JplTjNeuJu6NM0nqBbYx65WIaAvO81I=;
        b=Td0Qom2EuAirsDIjUOJ5NTSXMc6m+HoFdvNW0EXDUhwC96V38cn6E5O/bRpDdyBQnm
         uiWzjyJZoMTN5y1XpAumatFyMlf7QmF72mHuNAmk/HIh5ZmlSpeje2HpMJGXRvjt4OML
         3bCPXB3bH4JnS70m0uLbFi6wI2vjBPOvcWx7de8Yc93nEhFkZ5IlskiqazIkNCPEwtOt
         5PLVCbJhez74FqLCbWYhISCvuSpEtTFSJ0VznD7pRztIrVh/AVHnh1X7sqfPsRsO1IVG
         w8Q/muGzvFG1YpIFxJZbB4ekUm+LTxM4o4z+glwtB+o5YhYtxqbane1csM1IRJ2tB7Sf
         lwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35m+0g71EHp5JplTjNeuJu6NM0nqBbYx65WIaAvO81I=;
        b=sqc7P9a7R0GQNwXFMJjWSsM9PCjNdZ4HglPVwK9KuWOrZaq88ttZNwOWJbSPmVbX92
         wh5AuiTY9QxaP7qUPZCwDgYqlQG4NVwuuGvZkaSM6r9uODeKvMetHJmwxlO19RjLxkRW
         mSXxce3lHRFkI0gThK+ugywrsuMQl9toIHOMBBw2QTo4xC4W1PxhUnvHgYpfUEg9CcuD
         Hdz1oUpSDsbFKUCC0SEc4aoxND13aH5TcD3o5r8BmrMK3oaU+Ra5WMDm86j4ABH6wUXv
         D7DASMmgzncdg1PkTFUfuJHaJM6XZHcNqjgdMUtal8GiQQfQp1hHlC+tWYV4zngy8mpv
         +ywg==
X-Gm-Message-State: AOAM533qEeIArDvFqmJjsJ3dXEEOSf1dQjvQJq2s9TLp0Y7BkZxw5UXR
        kaB82fwFR/RHSPxU57i9CwzK1ehOAmWbNuVYLhPKoQ==
X-Google-Smtp-Source: ABdhPJxfigbEVrRhx6S8Gv2veQDPeufN51YDgEvvGsR4HvobRxvQn9OdI3B+cY5gBsBmAbVt6Z4yCltvrjHP3le99W4=
X-Received: by 2002:a37:4496:: with SMTP id r144mr1989828qka.242.1619879662008;
 Sat, 01 May 2021 07:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <20210425080902.11854-2-odin@uged.al>
 <20210427142611.GA22056@vingu-book> <CAFpoUr1KOvLSUoUac8MMTD+TREDWmDpeku950U=_p-oBDE4Avw@mail.gmail.com>
 <CAKfTPtCtt9V69AvkJTuMDRPJXGPboFsnSmwLM5RExnU2h5stSw@mail.gmail.com>
In-Reply-To: <CAKfTPtCtt9V69AvkJTuMDRPJXGPboFsnSmwLM5RExnU2h5stSw@mail.gmail.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Sat, 1 May 2021 16:33:49 +0200
Message-ID: <CAFpoUr1D5URSODXKaOOHaBbmkNiNNbsCL1WCcEAWrdhJ8gXs8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load decay
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ons. 28. apr. 2021 kl. 17:36 skrev Vincent Guittot <vincent.guittot@linaro.org>:
> You can keep both fixes tags

ACK

> If the cfs_rq is already in the list list_add_leaf_cfs_rq() will exit
> early but if it's not, we don't have to make sure that the whole
> branch in the list

Yeah, thats right. Calling list_add_leaf_cfs_rq once "too much" doesnt
hurt after all.

> In fact, we can break as soon as list_add_leaf_cfs_rq() and
> cfs_rq_throttled() return true

ACK, that makes sense.

> When a cfs_rq is throttled, it is not accounted in its parent anymore
> so we don't have to update and propagate the load down.

Okay. Still need to wrap my head around this a bit more I guess. I
have looked a bit around, and there
is actually a similar issue as "this one" for the case when a
throttled cgroup is "moved" via cpuset. It is however waaay
harder to reproduce, but it is doable, and it _will_ happen in real
life systems if the timing is "correct". I will dig deeper
and finish the patch for that case some time next week (hopefully). I
think that however deserve a separate patchset,
so I will come back with that later.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 33b1ee31ae0f..18441ce7316c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11026,10 +11026,10 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
> -               if (cfs_rq_throttled(cfs_rq))
> -                       break;
> +               if (!cfs_rq_throttled(cfs_rq))
> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
>
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> +               list_add_leaf_cfs_rq(cfs_rq);
>         }
> }

Sent a v2 with something like this now; that exit if
(list_add_leaf_cfs_rq(cfs_rq) && throttled). Since this loop start at
the parent of
the cfs_rq of the supplied se, I added a list_add_leaf_cfs_rq to the
top in order to insert the leaf cfs_rq as well.

Thanks
Odin
