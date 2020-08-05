Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98BD23D388
	for <lists+cgroups@lfdr.de>; Wed,  5 Aug 2020 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgHEVSl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Aug 2020 17:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVSk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Aug 2020 17:18:40 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA130C061575;
        Wed,  5 Aug 2020 14:18:40 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y18so30216182ilp.10;
        Wed, 05 Aug 2020 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47Asclv1FK7U2jk7VK/Qqzc/1uZms3QEdnET+4/Hxhw=;
        b=hOGXqAlmNmwjcpWgNq+i7sz0gXOY45BTpoSEyZ7rQgxc8KoTFIq72+Sp3FqRmWUGch
         BzMjQw9EsuXc1EkXuw4M/HNTKNKhWg44QfrlbEhDfVbFKVwxiTH5fO+RBDpeSKYxhAOr
         97nXaQN3SqulrQyeviEqOelMhLmtmdfPAGHC0nT6CaFiG+qOGEZpu2Ks27v8ughOlpC1
         us7d21TosVqDjmVTvwK4B6ovXoFxFbmAQXDdijY/4Ha+hwaSLqvZ1ShYcNjiOS3ASxsx
         nfMOwaEzMpqofoyw6UO9W6ksT52pUAYn7Fq1VrJHLjX1Fae7VbB0QTJ/W1+55pFwDJNQ
         CPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47Asclv1FK7U2jk7VK/Qqzc/1uZms3QEdnET+4/Hxhw=;
        b=hefQ2q6qD6cboAb4CQjry3Jv0Cq3jjY/HZiqof3KHLz5NvlxNJw+ZWPoIm+GL+1iR/
         mZxosLlM77ZOWc+N8iJn81EQClQ5qKwZPrDfV6YqHn7mP6o7jEFbiv0Ft57/MqUJYrbE
         oN6Jkuoq1PnHRXsLs8wqGB6ody02RvlWOogwP6r2pBatFIYZeEiA9H9w8SQWR7PgGcOi
         vbfGD0lMmcR5IHNZ0avxRUgQCBp7YQp0TlfXQ3M68Wn9pBu2Gl5Xk4EZrBWumtCJsmOx
         6SOqF3HEMZv0ucSprOPu+vce2WlzNH/viSFYFO5vc2z6RxW1eYCmdnbEFiPpu0YzrxBm
         Mv/A==
X-Gm-Message-State: AOAM5309HF4k1q5TQn15WajYHkQZYb0Su/B9qpdWshiISI19SFMhdq98
        rCIAtrh4kQCrn6aqUgdNzbMNPVWb2swvAT0ixNU=
X-Google-Smtp-Source: ABdhPJz5HQXy+KXF8yn3h980J3l9bX6POO/8Sp49m+jlrztwg9zijubXJFLCSGZH4IRvp2PhB9SCfieVsb8nS8m+WR0=
X-Received: by 2002:a92:bb92:: with SMTP id x18mr5788263ilk.64.1596662319442;
 Wed, 05 Aug 2020 14:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-12-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-12-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Aug 2020 14:18:28 -0700
Message-ID: <CAKgT0Udo=DSH76YF9L_qmWFNSCJW22UQaL57jHWnKstdB2wngg@mail.gmail.com>
Subject: Re: [PATCH v17 11/21] mm/lru: move lru_lock holding in func lru_note_cost_page
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
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> It's a clean up patch w/o function changes.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> ---
>  mm/memory.c     | 3 ---
>  mm/swap.c       | 2 ++
>  mm/swap_state.c | 2 --
>  mm/workingset.c | 2 --
>  4 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 87ec87cdc1ff..dafc5585517e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3150,10 +3150,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                  * XXX: Move to lru_cache_add() when it
>                                  * supports new vs putback
>                                  */
> -                               spin_lock_irq(&page_pgdat(page)->lru_lock);
>                                 lru_note_cost_page(page);
> -                               spin_unlock_irq(&page_pgdat(page)->lru_lock);
> -
>                                 lru_cache_add(page);
>                                 swap_readpage(page, true);
>                         }
> diff --git a/mm/swap.c b/mm/swap.c
> index dc8b02cdddcb..b88ca630db70 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -298,8 +298,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>
>  void lru_note_cost_page(struct page *page)
>  {
> +       spin_lock_irq(&page_pgdat(page)->lru_lock);
>         lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
>                       page_is_file_lru(page), hpage_nr_pages(page));
> +       spin_unlock_irq(&page_pgdat(page)->lru_lock);
>  }
>
>  static void __activate_page(struct page *page, struct lruvec *lruvec)
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 05889e8e3c97..080be52db6a8 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -440,9 +440,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>         }
>
>         /* XXX: Move to lru_cache_add() when it supports new vs putback */
> -       spin_lock_irq(&page_pgdat(page)->lru_lock);
>         lru_note_cost_page(page);
> -       spin_unlock_irq(&page_pgdat(page)->lru_lock);
>
>         /* Caller will initiate read into locked page */
>         SetPageWorkingset(page);
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 50b7937bab32..337d5b9ad132 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -372,9 +372,7 @@ void workingset_refault(struct page *page, void *shadow)
>         if (workingset) {
>                 SetPageWorkingset(page);
>                 /* XXX: Move to lru_cache_add() when it supports new vs putback */
> -               spin_lock_irq(&page_pgdat(page)->lru_lock);
>                 lru_note_cost_page(page);
> -               spin_unlock_irq(&page_pgdat(page)->lru_lock);
>                 inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
>         }
>  out:
> --
> 1.8.3.1
>
