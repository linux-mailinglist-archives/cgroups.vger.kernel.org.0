Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACD223B058
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 00:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHCWnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Aug 2020 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCWnL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Aug 2020 18:43:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B29C06174A;
        Mon,  3 Aug 2020 15:43:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k23so40191152iom.10;
        Mon, 03 Aug 2020 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UQWcxeOoEkXTJIt/PdyNhlScRBnQycvZyIEzHIohI0=;
        b=gYJDWc5mAAFpapjvwlC/qoPFpgfc1nYNN2CnELkmZiBmOg8SjVJKWP+KkOaZ+C3yEZ
         q35cDxlG/PGbtI/fYuoMlPtncITQ6VyUZQoLBt+T7vW9722CmtWiqJDAQaPRT7UEQVy4
         ytAh+MCsSXKJn2Mks5RBPbn1F6/tbEnd/L508a2mX40hNLFAovPeECh+rV/K+viBoGwo
         +ZMvOVZQNrprdF3Q198T6HinK81k3OA6L579C0xU27auPB5IlpuC4jHfNaQR3JNRMHq8
         H8aG4rLiD1yk2rtKAdl0EX6hByWwofrEeAXl1hrOZTGcKkh1qJlhnLYf1OQEFBVsmHhX
         Og9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UQWcxeOoEkXTJIt/PdyNhlScRBnQycvZyIEzHIohI0=;
        b=ABhS/cU2xdGGMuy2PSJ0TUof+QfIccQUIRLVYfQTHkiBjFehRks1alWpZtK5crT0IM
         VXCIHRMrpSUCCAT3Fn2sCXzuu1RhG1TYe8trl0kdqTXE2dUhQYhOyN7LV0Pe9LYiE1cU
         a3wnkVZBA0/hIzSGDlb6V+LSdbjw1zBkDNfjkp4D5H4jAB2WGsHtQAkirQa9FsDmflCr
         /rn9OIRYeE8rDChfhl37WRaETHpOHDlo4UbKMME27EwbsmiCv/bX7pl1ZoZVH/PHZzAp
         9l5rEpnAWkCRZhn09ES79quZ8E01z7yv8365C5b+oipG7LbJdHeXJ17JFdfkjpxHsTUL
         WG/g==
X-Gm-Message-State: AOAM5325jxSI/S2j+G8P3Opmaz6S8HB2YRGGTyZqkJaUUtdDK4VcqpjH
        foJvnfCEnt3vsmgh5GLfz8b9Q01VEFnPoXW4FFQ=
X-Google-Smtp-Source: ABdhPJyqt6Lz8s8fnLPOkfkvfDf9MkrPyuGA+XA0z7oJJrlxxzKSwE3+p1mJIfvntpTVepyp0RsOvh5+M8vPFm4LIXI=
X-Received: by 2002:a6b:da0d:: with SMTP id x13mr2199562iob.138.1596494590289;
 Mon, 03 Aug 2020 15:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-21-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-21-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 3 Aug 2020 15:42:59 -0700
Message-ID: <CAKgT0UfZg5Wf2qNJ_=VPO1Cj8YuifZN8rG_X4Btq86ADmsVZFw@mail.gmail.com>
Subject: Re: [PATCH v17 20/21] mm/pgdat: remove pgdat lru_lock
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
> Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org

I really think this would be better just squashed into patch 18
instead of as a standalone patch since you were moving all of the
locking anyway so it would be more likely to trigger build errors if
somebody didn't move a lock somewhere that was referencing this.

That said this change is harmless at this point.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> ---
>  include/linux/mmzone.h | 1 -
>  mm/page_alloc.c        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 30b961a9a749..8af956aa13cf 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -735,7 +735,6 @@ struct deferred_split {
>
>         /* Write-intensive fields used by page reclaim */
>         ZONE_PADDING(_pad1_)
> -       spinlock_t              lru_lock;
>
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>         /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e028b87ce294..4d7df42b32d6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6721,7 +6721,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>         init_waitqueue_head(&pgdat->pfmemalloc_wait);
>
>         pgdat_page_ext_init(pgdat);
> -       spin_lock_init(&pgdat->lru_lock);
>         lruvec_init(&pgdat->__lruvec);
>  }
>
> --
> 1.8.3.1
>
