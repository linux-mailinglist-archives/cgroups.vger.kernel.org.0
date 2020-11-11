Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9992AEAEE
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgKKIRc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 03:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKIRc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Nov 2020 03:17:32 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE2C0613D1;
        Wed, 11 Nov 2020 00:17:30 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id b190so308417vka.0;
        Wed, 11 Nov 2020 00:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyCZne5cZpLNOqDry4HVxqltreV+5uSXk934/wIueCQ=;
        b=LkrweCrNctWBJmZhOmVK1Rzbd5NVaaKQuUZ7ogoTkNLtcKS1qRptELkjFKxAoo/BW0
         P35onUOxdrqcVXzz35VtvWEvfj38Gdbm+Bdv/lwhCcDrizl6PzXh9JlZJrdPeYOs/ybe
         cwY7GQAwEF7/Mg2wY4aoFKT97vFprivkS5vVY4PuA8xcoo0iyfTevwWEIupadrC6yQQX
         spp3O5rZ/q1Wx4AE+znuA+rOIR+kZy1SYrJYXh7+Yk1TCx2/dj6tB0ZLia4HA+GPSsSW
         b5eXL06oey9MVpiBqb43EKDBlW5ai1A2WseVlAgbIFfOcDrT8Svl/de7lOLaM8arvWRP
         Vrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyCZne5cZpLNOqDry4HVxqltreV+5uSXk934/wIueCQ=;
        b=iZx/C0f3QvYOpcWKQ3sLK+1uOPyZyq88OJASlHxfKd9YuwDqddgQiKtptk38/kQ9lC
         eDMMggGYcqJa7IB9PfTedWeUghEwEHRwwJeZ4Cp+UeM6MxuoJHudV43n1poX4ZXgqlTV
         dZcaE28RmeD4xYMaXTVamFpv7l/XfUj82IdibCMxKHqMUXEa64gUmgLBCGfrkJ1vwqtL
         XBScSDiRTcbynAE33UGwr8bf3MjofGQY1ps1PzbAoW4d9+l8HWdYc0BofBMjhdTCgBKs
         pHG9CTpf1wl91yS4r9yeNF7KRI5aaRbRusoyXxSy81IqzPk+hfvMpegft/YKHHQXw29p
         vUPw==
X-Gm-Message-State: AOAM531r3hoJqWeu/JD6swwGhi7dJ6SWoYNyFqqLkuzepeebjjZSKSaz
        /14onc2/IHD3/rWHlyelfq8vQ/QgQbsP0TmnVc8=
X-Google-Smtp-Source: ABdhPJw9LAaNIBuOND3zftoBkxCQN1Q5Cr0eSOTm3JEn3FdwtGO4po/GZTsKLe/R3gJlhxPFwrPo+aQ/EuY0i/U+sM4=
X-Received: by 2002:a05:6122:84f:: with SMTP id 15mr9455291vkk.25.1605082649083;
 Wed, 11 Nov 2020 00:17:29 -0800 (PST)
MIME-Version: 1.0
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <1604566549-62481-8-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1604566549-62481-8-git-send-email-alex.shi@linux.alibaba.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 11 Nov 2020 16:17:17 +0800
Message-ID: <CAC=cRTPYgD4qi=-dj=PY4804Y96k7fU065vLA8mNBmucZTnFSw@mail.gmail.com>
Subject: Re: [PATCH v21 07/19] mm: page_idle_get_page() does not need lru_lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, Johannes Weiner <hannes@cmpxchg.org>,
        lkp@intel.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 5, 2020 at 4:56 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> From: Hugh Dickins <hughd@google.com>
>
> It is necessary for page_idle_get_page() to recheck PageLRU() after
> get_page_unless_zero(), but holding lru_lock around that serves no
> useful purpose, and adds to lru_lock contention: delete it.
>
> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> discussion that led to lru_lock there; but __page_set_anon_rmap() now
> uses WRITE_ONCE(), and I see no other risk in page_idle_clear_pte_refs()
> using rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly
> but not entirely prevented by page_count() check in ksm.c's
> write_protect_page(): that risk being shared with page_referenced() and
> not helped by lru_lock).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/page_idle.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index 057c61df12db..64e5344a992c 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -32,19 +32,15 @@
>  static struct page *page_idle_get_page(unsigned long pfn)
>  {
>         struct page *page = pfn_to_online_page(pfn);
> -       pg_data_t *pgdat;
>
>         if (!page || !PageLRU(page) ||
>             !get_page_unless_zero(page))
>                 return NULL;
>
> -       pgdat = page_pgdat(page);
> -       spin_lock_irq(&pgdat->lru_lock);

get_page_unless_zero() is a full memory barrier.  But do we need a
compiler barrier here to prevent the compiler to cache PageLRU()
results here?  Otherwise looks OK to me,

Acked-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

>         if (unlikely(!PageLRU(page))) {
>                 put_page(page);
>                 page = NULL;
>         }
> -       spin_unlock_irq(&pgdat->lru_lock);
>         return page;
>  }
>
> --
> 1.8.3.1
>
>
