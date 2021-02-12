Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3360731A4DE
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBLS5t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 13:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLS5s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Feb 2021 13:57:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD54BC061574
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 10:57:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v30so922081lfq.6
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcvglq6lm2v5NtoaNp7KAMjtS1nc2H/6Xlbtuy2KR4E=;
        b=kYi+d4wWq5tEorGxBX7x8+FRyebVeyXfgD+pv7bsDTvGDW8T9FZMxZ8g6MBVNoA1xw
         MdGVwA1ePiWKy6yUW7yk7ZIUeAdaHebjjsy7bdTYokCBK/uOVggZWmLLWyJ/FakeDvHD
         pITpd+Y+ovlJbJaRSfT1OhZDWxJGYRmPFnzgKNHKmJbY4kh6kMrGrQaJi5ZfEodvZYg7
         nRop1AU9UXtKRKxN/GkyrhIFevvhuH9TPjnkO/w2xFGk3sqfafJ4putZUFsI+egd78OH
         NjgpXytBano01WNQR9Q1xjCDLp9DiIraeVFqgMe/txbV5MqPvK24L5MbCbZ3Fh9pntB5
         NowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcvglq6lm2v5NtoaNp7KAMjtS1nc2H/6Xlbtuy2KR4E=;
        b=Wq9npqgde4z51B2/ONOLBdqsBHJyYq9BYyXNPWzkEAP8jpd33fW2RXuIsQMBvI7ntJ
         b21bOkyLFVxwgAfIeAAhFmpSgQtk3gjHUh7hXvGNPGrGFiUO5tZCvwEGJudHUOngptfC
         IT2yRrGz7SU1+t4LzCQoJIcKRHiPuWvj25MSql6EM66u6y3sy60MgVqwHeFNKA8fRDP+
         TUIu9vgeaUFxeS7JY1EUVR4CMb0utVBlCd7KeEx9jCLlEgnou/bBlAY95JkO/uT1E5b8
         TsST7a+Ztzb1QHxRhOWBaNZ/tG89IbqmJMH9AMuU6iLeMjtG1SiC3RTkIm7xgD7ftpJ/
         TrkA==
X-Gm-Message-State: AOAM530bssVZuu2jQ+vmxLz39RkbIjBk8aVUPISMyNDoNtmSk22R0WNF
        RBWTEqDsaWY2TpxM/Epgu7WwJ3bmr2AMGHh3euWAdA==
X-Google-Smtp-Source: ABdhPJwAOYDXAEN5WNwZAeVEMl2GGPFdRVNq1BAUEoKLv2s+gMFyHinl5X5g7/6SIVbIDkAvSIVoxVNRJ3j4rqMyA8I=
X-Received: by 2002:a19:ad03:: with SMTP id t3mr2292251lfc.358.1613156226042;
 Fri, 12 Feb 2021 10:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com> <20210212170159.32153-4-songmuchun@bytedance.com>
In-Reply-To: <20210212170159.32153-4-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Feb 2021 10:56:54 -0800
Message-ID: <CALvZod6tXn9qrRmzyspp+7usB-Xx4ayu6KrzmKvoU7zWajx85g@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CCing more folks.

On Fri, Feb 12, 2021 at 9:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The swap charges the actual number of swap entries on cgroup v2.
> If a swap cache page is charged successful, and then we uncharge
> the swap counter. It is wrong on cgroup v2. Because the swap
> entry is not freed.
>
> Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

What's the user visible impact of this change?

One impact I can see is that without this patch meminfo's (SwapTotal -
SwapFree) is larger than the sum of top level memory.swap.current.
This change will reduce that gap.

BTW what about per-cpu slots_ret cache? Should we call
mem_cgroup_uncharge_swap() before putting in the cache after this
change?

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c737c8f05992..be6bc5044150 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>         memcg_check_events(memcg, page);
>         local_irq_enable();
>
> -       if (PageSwapCache(page)) {
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
>                 swp_entry_t entry = { .val = page_private(page) };
>                 /*
>                  * The swap entry might not get freed for a long time,
> --
> 2.11.0
>
