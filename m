Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD731D4CF
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 06:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhBQFNG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 00:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQFNF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Feb 2021 00:13:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8625FC061574
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 21:12:24 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so7768167pgj.4
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 21:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYvHNjsRzSj3lg/h8/eBWdl0bg6pjg+N/53V5e6DzuQ=;
        b=FCYy9NQ49xDdGoLj67f6UIW8p2z+z+n05jGQwri581J7GMphWlV6A+j7JVZ1V5JXlS
         zw9Y8dvkI79zWY5zAZ0qcyiRUdO3/Nk1dMNx9diSUnZUiTTxVCxt9HhvTDzvWdshddv3
         o4i+YEEs2bDjJBrpfNE5THv62gXQlLMgUplLAExWD1gktcLQT/YF1mIBh620ARqAk7rW
         yQVYFo6/hhqV+RyFY/2nG2ZxH2GQXGpOo4Qqd/YBcFKYgcz8hJGwZ2sw+y1ja/7a8z0U
         kV12YfOCH2wh+EajlGcPZaLE4+f4PCGomXnOyHnyiWRoh8VxPCAUWdrRYPqka8ZYprDM
         0qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYvHNjsRzSj3lg/h8/eBWdl0bg6pjg+N/53V5e6DzuQ=;
        b=S4RZVY4okqEtFc6W8Z+N9lH0zqhebGF5SGkmerBAQAlAQG/SyvSmyCuow2GZNOQ8fP
         1bGMZnALYPxhrGJqsE93DJdsJ5ds1txYxjupK38NxInDpV8Y0e/S2duNN63huW1sdgSm
         pf9OcBI0/dWYL82HW5jnAuUMZPKnFTkf+sK89yBFs4qsyEIDGyJuLGr/wpxD5o+V1Ek0
         Zb6/faT+ev6/Da/p6JQRoTsfl/d7Qatp2hZNS5ggqelHuT4yQ8CwziGDtHOnk7EcxLBr
         cse6rraAdNu3tQarN2D1HU3FwG/KW/ObNFdTW3zSpsw2cXd6hX3J2nRfwBkwNQY8YBss
         NGnw==
X-Gm-Message-State: AOAM532aEvUosSl4eBjb8M37FNmeA4GKLnMU+iGfJPpVn/7Qv/NNh2FY
        XIjg2D++V6/Emr5M8qi/V7CNL+giRNJy6wVklDIvng==
X-Google-Smtp-Source: ABdhPJztTWrBi2XK37iRQE3e6jrMC+zfIZ0VrgdHndnthS77eBVOQCMpFhhB5dIfpwXQ0wbtu+nzQPZ4b99HjWCWDBU=
X-Received: by 2002:a63:480f:: with SMTP id v15mr22395088pga.341.1613538743917;
 Tue, 16 Feb 2021 21:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com> <YCv51LgGIWxVjLHT@cmpxchg.org>
In-Reply-To: <YCv51LgGIWxVjLHT@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 17 Feb 2021 13:11:47 +0800
Message-ID: <CAMZfGtWw14a7MTJzY9MVBTRh5X9Qv0YbaBAqEaYPVHSy-SrcEg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on
 cgroup v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 17, 2021 at 12:59 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Muchun,
>
> On Sat, Feb 13, 2021 at 01:01:59AM +0800, Muchun Song wrote:
> > The swap charges the actual number of swap entries on cgroup v2.
> > If a swap cache page is charged successful, and then we uncharge
> > the swap counter. It is wrong on cgroup v2. Because the swap
> > entry is not freed.
>
> The patch makes sense to me. But this code is a bit tricky, we should
> add more documentation to how it works and what the problem is.
>
> How about this for the changelog?
>
> ---
> mm: memcontrol: fix swap undercounting for shared pages in cgroup2
>
> When shared pages are swapped in partially, we can have some page
> tables referencing the in-memory page and some referencing the swap
> slot. Cgroup1 and cgroup2 handle these overlapping lifetimes slightly
> differently due to the nature of how they account memory and swap:
>
> Cgroup1 has a unified memory+swap counter that tracks a data page
> regardless whether it's in-core or swapped out. On swapin, we transfer
> the charge from the swap entry to the newly allocated swapcache page,
> even though the swap entry might stick around for a while. That's why
> we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().
>
> Cgroup2 tracks memory and swap as separate, independent resources and
> thus has split memory and swap counters. On swapin, we charge the
> newly allocated swapcache page as memory, while the swap slot in turn
> must remain charged to the swap counter as long as its allocated too.
>
> The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
> make swap tracking an integral part of memory control"), because it
> accidentally removed the do_memsw_account() check in the branch inside
> mem_cgroup_uncharge() that was supposed to tell the difference between
> the charge transfer in cgroup1 and the separate counters in cgroup2.
>
> As a result, cgroup2 currently undercounts consumed swap when shared
> pages are partially swapped back in. This in turn allows a cgroup to
> consume more swap than its configured limit intends.
>
> Add the do_memsw_account() check back to fix this problem.

Thanks. Sorry for my poor English. I should improve my changelog.

> ---
>
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.

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
> >       memcg_check_events(memcg, page);
> >       local_irq_enable();
> >
> > -     if (PageSwapCache(page)) {
> > +     if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
>
> It's more descriptive to use do_memsw_account() here, IMO.
>
> We should also add a comment. How about this above the branch?

I will add a comment here. Thanks.

>
>         /*
>          * Cgroup1's unified memory+swap counter has been charged with the
>          * new swapcache page, finish the transfer by uncharging the swap
>          * slot. The swap slot would also get uncharged when it dies, but
>          * for shared pages it can stick around indefinitely and we'd count
>          * the page twice the entire time.
>          *
>          * Cgroup2 has separate resource counters for memory and swap,
>          * so this is a non-issue here. Memory and swap charge lifetimes
>          * correspond 1:1 to page and swap slot lifetimes: we charge the
>          * page to memory here, and uncharge swap when the slot is freed.
>          */
