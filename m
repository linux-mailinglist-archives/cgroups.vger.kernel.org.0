Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878D331AA4E
	for <lists+cgroups@lfdr.de>; Sat, 13 Feb 2021 07:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBMGtf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Feb 2021 01:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhBMGte (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 13 Feb 2021 01:49:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30DC061574
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 22:48:54 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x136so951125pfc.2
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SvQPbY0JLL8of3BGGDOMIdtAbjg+M4/SFz/IP/02qIQ=;
        b=Qmi3QON0oQEQ54YUbGatNEp0xc3/YNtLOTVVx5KzgbwD6xLzcXH/g0Co9uJ4dpyYop
         wCV9HN1/bZZtAG7NippRen0hStG1KmbBWuUhyoPCUPn0aVe76tYiOAJRG2YYt6hRQtKv
         Bx6NTRQBgq79QZVKQHdOufm5Xia6818VExEwaGiI+EqLuZfqqdfab+u/NcZ0IK2NeM7V
         SXIbsxeWwFN8VB7pcGuHkvYGNVhb9kVO695jHYGzPvZrQEaTmOiyCfe28kfQGRN5NYPm
         KFtsQOlyUxqbSqeq9FONIci5vl5CNHjpXEZpy6cOU+C1ILj9zOOagrDctqSrFJdxYJ4W
         hyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvQPbY0JLL8of3BGGDOMIdtAbjg+M4/SFz/IP/02qIQ=;
        b=l8ecJx7jixHjTvBqIDpzFbeNW9MQm3iGwoK8i3aIGE7sjktzW4L2aV2DCtb8cMBxdI
         Rad5hY2q2kJzHTR5Ukwk6JMYhVMFuBNr4gWpJSfLLkyHTc9O1nx9STpa/QJ0YCfruFZ8
         l+dwakgfVjzapT3YrJfEQBNu2DgKFwIw1Jvg/cv4m/xp+wqI6ffcRROv9mgCk6up5q2g
         fUo1uxklisv3VNiAeeDLFZwuo+b3f5um8rApw7J8nCR3I6NAtMyE7ioWuUbf/XZF2CAr
         fqoaDbTteULTxLF4VC4TdQpOUhOxg+AAQ56hnTYR3GqznPaB8dlavduI75+/emLzA7VV
         jMcw==
X-Gm-Message-State: AOAM530xM2uh7oeJHXq/xaubJIAWPoUwhOFxPepahOUhVhmC9jHsDHWP
        SjWd33YsL79kxdpKBKlXucmufW3rJu4oKi0TMeNNDw==
X-Google-Smtp-Source: ABdhPJxFm5ytrRIuo5OjrqHSAJy0svKyn32Z3N76DjduuptVRhBbBAX9PzKNFsNshl5LDiFRrqXBfTlYJZrJPN0ykdg=
X-Received: by 2002:a63:480f:: with SMTP id v15mr6451732pga.341.1613198933433;
 Fri, 12 Feb 2021 22:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com> <CALvZod6tXn9qrRmzyspp+7usB-Xx4ayu6KrzmKvoU7zWajx85g@mail.gmail.com>
In-Reply-To: <CALvZod6tXn9qrRmzyspp+7usB-Xx4ayu6KrzmKvoU7zWajx85g@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 13 Feb 2021 14:48:16 +0800
Message-ID: <CAMZfGtUpsbiVW7AtBtfYjFvppv+7MmAcff_x872gbeMuv8zs3Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on
 cgroup v2
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Feb 13, 2021 at 2:57 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> CCing more folks.
>
> On Fri, Feb 12, 2021 at 9:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The swap charges the actual number of swap entries on cgroup v2.
> > If a swap cache page is charged successful, and then we uncharge
> > the swap counter. It is wrong on cgroup v2. Because the swap
> > entry is not freed.
> >
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> What's the user visible impact of this change?

IIUC, I think that we cannot limit the swap to memory.swap.max
on cgroup v2.

  cd /sys/fs/cgroup/
  mkdir test
  cd test
  echo 8192 > memory.max
  echo 4096 > memory.swap.max

OK. Now we limit swap to 1 page and memory to 2 pages.
Firstly, we allocate 1 page from this memory cgroup and
swap this page to swap disk. We can see:

  memory.current: 0
  memory.swap.current: 1

Then we touch this page, we will swap in and charge
the swap cache page to the memory counter and uncharge
the swap counter.

  memory.current: 1
  memory.swap.current: 0 (but actually we use a swap entry)

Then we allocate another 1 page from this memory cgroup.

  memory.current: 2
  memory.swap.current: 0 (but actually we use a swap entry)

If we swap those 2 pages to swap disk. We can charge and swap
those 2 pages successfully. Right? Maybe I am wrong.

>
> One impact I can see is that without this patch meminfo's (SwapTotal -
> SwapFree) is larger than the sum of top level memory.swap.current.
> This change will reduce that gap.
>
> BTW what about per-cpu slots_ret cache? Should we call
> mem_cgroup_uncharge_swap() before putting in the cache after this
> change?
>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c737c8f05992..be6bc5044150 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >         memcg_check_events(memcg, page);
> >         local_irq_enable();
> >
> > -       if (PageSwapCache(page)) {
> > +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
> >                 swp_entry_t entry = { .val = page_private(page) };
> >                 /*
> >                  * The swap entry might not get freed for a long time,
> > --
> > 2.11.0
> >
