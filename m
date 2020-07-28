Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28445230C43
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgG1OR7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgG1OR7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 10:17:59 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F9C061794;
        Tue, 28 Jul 2020 07:17:58 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w12so7283339iom.4;
        Tue, 28 Jul 2020 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiRcDeb6ox2yLj5fXNdoo05VO5CcXhShAkGVYjl04bA=;
        b=Ys6zUE87HGooZo1PtEgKd0uJDkaEkHFGsY1EOydtoSvjPDQl51Ix2N7rg4aqhB71lC
         j2VW2HZTKNWlVWHcU7VD2D5+PhV6cpWsdtKKe1/SK8sNiTxNDTNjkGR4BS0y22ANyoCC
         4aHYx2avcGsIGwy2/PotHxNQwmXTqKRa2HRaUcQWN3yeLutu0lSdYw3Yx73YEYag5hPu
         QdgUT4EjVX27slSACOg8fzHrZP3TWN0F7LvKm5bkNOY9GRgQr+OVwFVrevJrsqF+FkCR
         q/sCLBF+MDkBqYZuWXN0ov2yL64I7sPhzA9kdFAHZulnJ9VKWgvOi5PKdoH56dAwi1m3
         +Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiRcDeb6ox2yLj5fXNdoo05VO5CcXhShAkGVYjl04bA=;
        b=YdjxD/gyyDfZrflAMXQ9vqDkFWmrOInZVfVFbc5BfQhjaV4Zmn1uHmnN+getaYZw7j
         suRF4BS0J2YTFtfx6aj32GLhMLuZ0cFpNZlDMbErn8l3EoXX807x2YCPMAwg8NyITe2O
         SrZ/Tk9ZeUAvi4Rer868T8LPEVMwl+z+OV9TfCqrWqH0RKLln1uGdSiXtvNdNKvxG2jc
         PD3NTFahza78ZI/EulJdlkST6zBOX8/EYPYPgnp/IhCoAZGMokK+Tt2Ps4g3IbWuvXcT
         KtafTqjpt7UIWn87r0mHFvx74Q4ZvFFNXp5i1YUIj+eNm3WpSn/7TYLO74Tzv99A29HC
         sxUg==
X-Gm-Message-State: AOAM532xpaqW5vl6fvaBTP5O4coyQzJj+qLkKpF4J3ego9W0wpTIWYpz
        ef6SeRBFjU1bVvSJhBhGisr8C3wtTO5FTAB7VcFRzf3T
X-Google-Smtp-Source: ABdhPJwBbS1GB98Y4FyDLwh4H/OtvXDdnPzhnInC0IVz8ECy3gVFmEqGDS9cDDfxjL49EqZh49ZaMH3Ncm+/fBVSf8Q=
X-Received: by 2002:a5e:980f:: with SMTP id s15mr14176280ioj.5.1595945878359;
 Tue, 28 Jul 2020 07:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-4-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfmbdhpUdGy+4VircovmJfiJy9m-MN_o0LChNT_kWRUng@mail.gmail.com> <3bd60e1b-a74e-050d-ade4-6e8f54e00b92@linux.alibaba.com>
In-Reply-To: <3bd60e1b-a74e-050d-ade4-6e8f54e00b92@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 28 Jul 2020 07:17:47 -0700
Message-ID: <CAKgT0UdyVKS00UzSGuVL7WASkz5h3MpnWT4VnYPa7Par08XxAg@mail.gmail.com>
Subject: Re: [PATCH v17 03/21] mm/compaction: correct the comments of compact_defer_shift
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

On Tue, Jul 28, 2020 at 4:59 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
> >>   * Compaction is deferred when compaction fails to result in a page
> >> - * allocation success. 1 << compact_defer_limit compactions are skipped up
> >> + * allocation success. compact_defer_shift++, compactions are skipped up
> >>   * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
> >>   */
> >>  void defer_compaction(struct zone *zone, int order)
> >
> > So this doesn't read right. I wouldn't keep the "++," in the
> > explanation, and if we are going to refer to a limit of "1 <<
> > COMPACT_MAX_DEFER_SHIFT" then maybe this should be left as "1 <<
> > compact_defer_shift".
> >
>
> Thanks for comments! So is the changed patch fine?
> --
>
> From 80ffde4c8e13ba2ad1ad5175dbaef245c2fe49bc Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Tue, 26 May 2020 09:47:01 +0800
> Subject: [PATCH] mm/compaction: correct the comments of compact_defer_shift
>
> There is no compact_defer_limit. It should be compact_defer_shift in
> use. and add compact_order_failed explanation.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmzone.h | 1 +
>  mm/compaction.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index f6f884970511..14c668b7e793 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -512,6 +512,7 @@ struct zone {
>          * On compaction failure, 1<<compact_defer_shift compactions
>          * are skipped before trying again. The number attempted since
>          * last failure is tracked with compact_considered.
> +        * compact_order_failed is the minimum compaction failed order.
>          */
>         unsigned int            compact_considered;
>         unsigned int            compact_defer_shift;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 86375605faa9..4950240cd455 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -136,7 +136,7 @@ void __ClearPageMovable(struct page *page)
>
>  /*
>   * Compaction is deferred when compaction fails to result in a page
> - * allocation success. 1 << compact_defer_limit compactions are skipped up
> + * allocation success. 1 << compact_defer_shift, compactions are skipped up
>   * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
>   */
>  void defer_compaction(struct zone *zone, int order)

Yes, that looks better to me.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
