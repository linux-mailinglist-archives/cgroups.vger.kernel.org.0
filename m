Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7226823D3FF
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 00:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgHEWnl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Aug 2020 18:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHEWnj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Aug 2020 18:43:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157EBC061574;
        Wed,  5 Aug 2020 15:43:38 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 77so10358677ilc.5;
        Wed, 05 Aug 2020 15:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfR6T7oCaeLyjQ9SxVMOY64V3krO/aimxcAQ4bPIbX8=;
        b=WX7ocpjDWB4JEf5Vxc+bT7cgMR54ylfB0nbKx/qzh7bkB0tA+cJZEHy8v92TB+FSli
         yAb8tqjCXpaKNxV3c4mVPitLtQ3GD8PsOmxbGmkwASJI3nHicBPfYsD/QCMGwO3JVlye
         Ww5LE/35K3MqDoMsJAWFZfJwev8RbOSsDnXI8ZTFYy9lUdHnRYwb7UCucAl4RI+tZulZ
         HCP2BE4fPKbsUQhGEXIVV4K9GsxbJ9Ut9j/UmvlFtSA8fRMx1FbumPmln8vOY+WnKQJ4
         jIcjtWftqgCVQ9Gdd6ewkRxrIktn3qEczHiAjDFDh1Qforkax2YUAkzOni17zqB6W3bY
         4M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfR6T7oCaeLyjQ9SxVMOY64V3krO/aimxcAQ4bPIbX8=;
        b=B7GhP8sIcrdOp9hG52eo4stBDW0oOZkMMTP0EPVHXRasvG3ogGX43xTvBzs7+v4Vhu
         6q3zT5Sgm/OhCYBdQ8hblSA6EGTFJ8K5TYECpLET6Mcf0k8aaLXkBIOM525EtVAnHzGU
         WMsVdqGRhuVRv3duEDQjPlc5l01iff6DY03YPYYcg9rTh0DzcWW9HFoX21EYIYmYAV1y
         KgplJGUP1iHw8EMTz88v0HtkPtbKuC+3hQkj8X8OmHbiY6u9z6ffefsgthCBjnWRRaeV
         L5S5L3KDYNVaaT2avULiaU3+bkuJLWlUt5ZzZY9gsLyiabvy70lL3qLo7dHUSiMysgIm
         xA8Q==
X-Gm-Message-State: AOAM530SfJuXxhU3WURwZjspsfytpO19WwY4+TTQNzY2QgP/vllP5mjW
        xMgBzoJZhyDoSLDP34T2BumaoGkNfIw2A2AUDHU=
X-Google-Smtp-Source: ABdhPJy1iTjipZHLfFa2tpUoCXh3KbOtUScwfAP9RwbBuwBH2LowKi2GRFNbixTAX5YssLItPPQWb9LObtijLB7HC78=
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr5940509ilr.97.1596667417710;
 Wed, 05 Aug 2020 15:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-14-git-send-email-alex.shi@linux.alibaba.com> <9b906469-38fb-8a4e-9a47-d617c7669579@linux.alibaba.com>
In-Reply-To: <9b906469-38fb-8a4e-9a47-d617c7669579@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Aug 2020 15:43:26 -0700
Message-ID: <CAKgT0Ud1+FkJcTXR0MxZYFxd7mr=opdXfXKTqkmiu4NNMyT4bg@mail.gmail.com>
Subject: Re: [PATCH v17 13/21] mm/lru: introduce TestClearPageLRU
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 28, 2020 at 8:53 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> rewrite the commit log.
>
> From 9310c359b0049e3cc9827b771dc583d504bbf022 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Sat, 25 Apr 2020 12:03:30 +0800
> Subject: [PATCH v17 13/23] mm/lru: introduce TestClearPageLRU
>
> Currently lru_lock still guards both lru list and page's lru bit, that's
> ok. but if we want to use specific lruvec lock on the page, we need to
> pin down the page's lruvec/memcg during locking. Just taking lruvec
> lock first may be undermined by the page's memcg charge/migration. To
> fix this problem, we could clear the lru bit out of locking and use
> it as pin down action to block the page isolation in memcg changing.
>
> So now a standard steps of page isolation is following:
>         1, get_page();         #pin the page avoid to be free
>         2, TestClearPageLRU(); #block other isolation like memcg change
>         3, spin_lock on lru_lock; #serialize lru list access
>         4, delete page from lru list;
> The step 2 could be optimzed/replaced in scenarios which page is
> unlikely be accessed or be moved between memcgs.
>
> This patch start with the first part: TestClearPageLRU, which combines
> PageLRU check and ClearPageLRU into a macro func TestClearPageLRU. This
> function will be used as page isolation precondition to prevent other
> isolations some where else. Then there are may !PageLRU page on lru
> list, need to remove BUG() checking accordingly.
>
> There 2 rules for lru bit now:
> 1, the lru bit still indicate if a page on lru list, just in some
>    temporary moment(isolating), the page may have no lru bit when
>    it's on lru list.  but the page still must be on lru list when the
>    lru bit set.
> 2, have to remove lru bit before delete it from lru list.
>
> Hugh Dickins pointed that when a page is in free path and no one is
> possible to take it, non atomic lru bit clearing is better, like in
> __page_cache_release and release_pages.
> And no need get_page() before lru bit clear in isolate_lru_page,
> since it '(1) Must be called with an elevated refcount on the page'.
>
> As Andrew Morton mentioned this change would dirty cacheline for page
> isn't on LRU. But the lost would be acceptable with Rong Chen
> <rong.a.chen@intel.com> report:
> https://lkml.org/lkml/2020/3/4/173
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/page-flags.h |  1 +
>  mm/mlock.c                 |  3 +--
>  mm/swap.c                  |  6 ++----
>  mm/vmscan.c                | 18 +++++++-----------
>  4 files changed, 11 insertions(+), 17 deletions(-)
>

<snip>

> diff --git a/mm/swap.c b/mm/swap.c
> index f645965fde0e..5092fe9c8c47 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -83,10 +83,9 @@ static void __page_cache_release(struct page *page)
>                 struct lruvec *lruvec;
>                 unsigned long flags;
>
> +               __ClearPageLRU(page);
>                 spin_lock_irqsave(&pgdat->lru_lock, flags);
>                 lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
> -               __ClearPageLRU(page);
>                 del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>         }
> @@ -878,9 +877,8 @@ void release_pages(struct page **pages, int nr)
>                                 spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
>                         }
>
> -                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
> -                       VM_BUG_ON_PAGE(!PageLRU(page), page);
>                         __ClearPageLRU(page);
> +                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 }
>

The more I look at this piece it seems like this change wasn't really
necessary. If anything it seems like it could catch potential bugs as
it was testing for the PageLRU flag before and then clearing it
manually anyway. In addition it doesn't reduce the critical path by
any significant amount so I am not sure these changes are providing
any benefit.
