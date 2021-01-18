Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C82F980F
	for <lists+cgroups@lfdr.de>; Mon, 18 Jan 2021 04:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbhARDJF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Jan 2021 22:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbhARDJE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Jan 2021 22:09:04 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860EC061573
        for <cgroups@vger.kernel.org>; Sun, 17 Jan 2021 19:08:23 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id i30so2032974ota.6
        for <cgroups@vger.kernel.org>; Sun, 17 Jan 2021 19:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlQe4ElMPvugk6/KnMDsBpLgn9qSpVd0RRGjY15TtBQ=;
        b=jEOTuxeeQdSsqnGagWGslg43TXvsjT1GjS43nG6bpxn/Q7TiDnkuEnWBWopiiNc2Si
         o6RVR1YEam7YDczQFb6qnMaGUL3WvdVZBWy3Yak+6iDUPxkF8iyYGfncJxipvOv4+QYB
         bsEd7l/iJIF0C43x8UeAjysvewqGoQWGedgYEO5PDxAFuO6Ssmb+PtUd13Ar2FbCmnAK
         /Hp58BiE1RKUXDzd1UFZatihz1VFurXjXVFZIJihoPXLXU5VTvGitPZd0+6u8QYmjCZ4
         G39JY3u1pOzCoiuluklb/G8chXju9jw2T2mb8a6ba2rJ59IC8DsFhxy9HiRaXKwKjreB
         oUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlQe4ElMPvugk6/KnMDsBpLgn9qSpVd0RRGjY15TtBQ=;
        b=NSWphC/psfFwz7UkTZKlGqZlk+tAV1n04RndyK4Vkq+uDWygOj5InPcN8JApkDHb5y
         /04T8IDd/cgFC1J5XBPzjoKjXdmaRhg7nRQtqg8w2r5S8gw/onHT/U57xnnRjSOYd0PW
         xGQ2fmucufgJt2J7bW4AITMkJNrruTwBf/mlKmaTw/2wmN/K3Wjd2i5bOFGe97+qhHQ/
         ZmgdqOyezyFfBs9VEFs5ETvA0jt5UVo1A8uLTHTfk+UlUSOdODNMqd4JBEQ22sT7YNcj
         5NLekK5xNmw7Bfta7ubx/7HKLi6SNZYAEgfcTsYL4AAjht9+u5uQ8CdGWYp+RbAPHih/
         VmgA==
X-Gm-Message-State: AOAM531yMfo8sXkvpFsPt0YViXoSoil/mdNIa8fSWUD+NFXLprQDqpCm
        usX9jcOTJ+fE5kcjF5IM8OTKt94T+0ZHsaDlP64=
X-Google-Smtp-Source: ABdhPJxmdCMJQzAjbC3KGwarCU74LQcVM/+5TUEZ5bdmRnXKhVLlUfEAPXoM4zwgtOC1reWBRHjWkZS0ckvy4o1K0SU=
X-Received: by 2002:a05:6830:8c:: with SMTP id a12mr15941981oto.167.1610939303353;
 Sun, 17 Jan 2021 19:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20210115143005.7071-1-wu860403@gmail.com> <YAH4w5T3/oCTGJny@mtj.duckdns.org>
In-Reply-To: <YAH4w5T3/oCTGJny@mtj.duckdns.org>
From:   liming wu <wu860403@gmail.com>
Date:   Mon, 18 Jan 2021 11:07:47 +0800
Message-ID: <CAPnMXWWmfzWh9J_G4OPT=eCFySaD2NAFE0_OiWFQKL-1R0uOkA@mail.gmail.com>
Subject: Re: [PATCH] tg: add cpu's wait_count of a task group
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, 398776277 <398776277@qq.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello tejun:
On Sat, Jan 16, 2021 at 4:20 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jan 15, 2021 at 10:30:05PM +0800, wu860403@gmail.com wrote:
> > -     seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
> ...
> > +     seq_printf(sf, "nr_periods %d\n"
> > +                "nr_throttled %d\n"
> > +                "throttled_usec %llu\n",
> > +                cfs_b->nr_periods, cfs_b->nr_throttled,
> > +                throttled_usec);
>
> This is interface breaking change. I don't think we can do this at this
> point.
Thanks for your reply, agree with it.
> > @@ -8255,6 +8265,19 @@ static int cpu_extra_stat_show(struct seq_file *sf,
> >                          "throttled_usec %llu\n",
> >                          cfs_b->nr_periods, cfs_b->nr_throttled,
> >                          throttled_usec);
> > +             if (schedstat_enabled() && tg != &root_task_group) {
> > +                     u64 ws = 0;
> > +                     u64 wc = 0;
> > +                     int i;
> > +
> > +                     for_each_possible_cpu(i) {
> > +                             ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> > +                             wc += schedstat_val(tg->se[i]->statistics.wait_count);
> > +                     }
> > +
> > +                     seq_printf(sf, "wait_sum %llu\n"
> > +                             "wait_count %llu\n", ws, wc);
> > +             }
>
> What does sum/count tell?
It can tell the task group average latency of every context switch
wait_sum is equivalent to sched_info->run_delay (the second parameter
of /proc/$pid/schedstat)
wait_count is equivalent to sched_info->pcount(the third parameter of
/proc/$pid/schedstat)

Thanks

Liming
