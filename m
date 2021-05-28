Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40F394505
	for <lists+cgroups@lfdr.de>; Fri, 28 May 2021 17:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhE1P2w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 May 2021 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhE1P2w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 May 2021 11:28:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABAFC061574
        for <cgroups@vger.kernel.org>; Fri, 28 May 2021 08:27:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i9so5820675lfe.13
        for <cgroups@vger.kernel.org>; Fri, 28 May 2021 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiBjppiA9FauptN85KvTMqQNccpsOQtc4MdQUyiisUU=;
        b=PrLpoLgQH2uoXy+cpWxi30XMNBXflM62zlDxEVygSH0AfIdt7LXr0IPyg2takB7LxZ
         wbT80B3Gm/NTVCarVTWzjI8vFG1NsiX18VTQxjzCpjsNWIb9l3cX3iTvcaDpFUOjWJUz
         i7WFw3zqqS2kUk4SviW7uWTrRLtn+quxOsjhBM6Y82WyRE1qrkNHTZcoJl0fWJz04+Ay
         302v/Ep7yZhWxdYTxzjkYSwHw5zYH5z46BlUY4Y+kFEsic2xIFbnBBAIPSZCpyzV8FSA
         ATB6Om4KQoEqmxxgph7e4cGgnrPcEX0RSStY7CCHKXlk/6NptQIQxKf13j3cNEf7YTTy
         hldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiBjppiA9FauptN85KvTMqQNccpsOQtc4MdQUyiisUU=;
        b=iUArKgK15/ltkBd/m8ZFifQ5GlHjTLhI+vBibmOuW1XAcuZxW+npwESk812+wY/N12
         TuRgvNS/RZCV3vn/0UQtozHx2pph5jLdmDLRk0bQB20J6xkTqPwoUVvN4wmB+oKP54pV
         p2dG8dHJFqvtdM8xcvcHVFO2lwNhlKDEDlU3llxNzsQf1b0XCIiH0VCui8usZbeooTFa
         zCA2YlPIrsTYrVmN2EGaT8NiQbxUoipCUEt0iopfBifxLI1/tj/SsvcL18ThkFbyWney
         7QYhs4VQTldbN/ISFOgwVRH1v9YL5cZesGfvxxI3BA9JhlOTEEk+AkwlLBtK7EYCp5Zh
         bGow==
X-Gm-Message-State: AOAM5307gEkVeQcOwtda6uxG92QBbakghzGs7b6xBDAdyPJx8yqEewmI
        y8W8W02/SFBxlfnxOgbfoOMWPVySV4v0wbKYuQq28Q==
X-Google-Smtp-Source: ABdhPJxUdEPjBZRzpm8p0VTDKH5oHUTT/OOg632voTXDolal8RCA788nZKN+9pNEyifqfRd9POr0NV7s/paPYf3Tm4E=
X-Received: by 2002:ac2:5f44:: with SMTP id 4mr6326007lfz.154.1622215635810;
 Fri, 28 May 2021 08:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
 <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com> <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com>
In-Reply-To: <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 May 2021 17:27:04 +0200
Message-ID: <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com>
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

On Fri, 28 May 2021 at 17:07, Odin Ugedal <odin@uged.al> wrote:
>
> Hi,
>
> > What would be the other condition in addition to the current one
> > :cfs_rq->nr_running >= 1 ?
>
> The condition is that if it has load, we should add it (I don't have
> 100% control on util_avg and runnable_avg tho.). Using
> "!cfs_rq_is_decayed()" is another way, but imo. that is a bit
> overkill.

normally tg_load_avg_contrib should be null when cfs_rq_is_decayed()

>
> > We need to add a cfs_rq in the list if it still contributes to the
> > tg->load_avg and the split of the share. Can't we add a condition for
> > this instead of adding a new field ?
>
> Yes, using cfs_rq->tg_load_avg_contrib as below would also work the
> same way. I still think being explicit that we insert it if we have
> removed it is cleaner in a way, as it makes it consistent with the
> other use of list_add_leaf_cfs_rq() and list_del_leaf_cfs_rq(), but

The reason of this list is to ensure that the load of all cfs_rq are
periodically updated  as it is then used to share the runtime between
groups so we should keep to use the rule whenever possible.

> that is about preference I guess. I do however think that using
> tg_load_avg_contrib will work just fine, as it should always be
> positive in case the cfs_rq has some load. I can resent v2 of this
> patch using this instead;
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ad7556f99b4a..969ae7f930f5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4720,7 +4720,7 @@ static int tg_unthrottle_up(struct task_group
> *tg, void *data)
>                                              cfs_rq->throttled_clock_task;
>
>                 /* Add cfs_rq with already running entity in the list */
> -               if (cfs_rq->nr_running >= 1)
> +               if (cfs_rq->tg_load_avg_contrib)

we probably need to keep (cfs_rq->nr_running >= 1) as we can have case
where tg_load_avg_contrib is null but a task is enqueued

>                         list_add_leaf_cfs_rq(cfs_rq);
>         }
