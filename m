Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C322F6A0
	for <lists+cgroups@lfdr.de>; Mon, 27 Jul 2020 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgG0R3S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jul 2020 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgG0R3S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jul 2020 13:29:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E8C061794;
        Mon, 27 Jul 2020 10:29:18 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so9663868iod.1;
        Mon, 27 Jul 2020 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Twl8egs2sgu9K2jUzyioOJdzChfT8oqMYRNtXj1w94Y=;
        b=bmEegtJgjmIbLBbTat5MprW8AbcHi/GCR+b/be88P4z6uYRhqOPQwZvY+KgtlwvHg1
         N4ICNnkrSuvMfHyrhCaMPTSaCWpTNZiYMoaBCFSEiX6+67oaI2o2Df46D+cTiuk6RKdH
         LWIB01sC9tVfimdUuCkacMamqOI4goVj7R8ybw+7+k22pVMpYzsI0LGnufsKU5FycBKV
         2q73J0Qm7SMd32tsPQMf3QShXIO6yNCb3aa4W9pF7X/T24ON0LbQvPOAuKLjAIkIiUYx
         ZyhLhQaLzj6rP7kU8egE6STMuJZQjb41Nkl75U7o8ci1ybC3TTzICtF1T3ozEhlXjbbt
         MncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Twl8egs2sgu9K2jUzyioOJdzChfT8oqMYRNtXj1w94Y=;
        b=ZOw7tQ9WlQgOqCxf8shf5TkZpdYXX64wYNNxhoqzAoYYDGZ/cLoIO3AVEcLuh30R1d
         jPycdmeMRCbG7HQlpAduZVQ7JP6yZNZTgf/ZGRtsQao7vyHX4Y8FSTo7GIHNaXhsrKNc
         l+dfH0HQMV+SdyrfF15uqoluQo334U6DmqfQsCbkpG7dUG6RjOBO+8Yf8JqjP75osOzL
         vS9VJqzf1RpU5tfz/xsZMbZ4eiM6+Msu6uHB2c3w+QfDUK2UEKC5Xg2ajXDVTxqK4Czy
         WwDKrHa+dt3XXM7BYmUtOE/+sHJr3R/eUWoiBdvQVhvmTPT+X4djf6LSM+g0Y3v2cAb9
         Uzag==
X-Gm-Message-State: AOAM531alpy9GJrHWqLYCV9eF5VWd+MtDjdG6OD8KTitVzXCHP8nHRuz
        3IiOdlTUclxoZ5A0XySB8TSXRv3a/Pzn7gsuLuc=
X-Google-Smtp-Source: ABdhPJxxgfdHHeyfu9fL+ZOZXfFlu0kc7hS7ebEk7MvDy1g28AJrX540XgnyyU+MlbYM5jUv6exPXnqOeN3OwC8/9tI=
X-Received: by 2002:a5d:9051:: with SMTP id v17mr6151014ioq.88.1595870957629;
 Mon, 27 Jul 2020 10:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-4-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-4-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 27 Jul 2020 10:29:06 -0700
Message-ID: <CAKgT0UfmbdhpUdGy+4VircovmJfiJy9m-MN_o0LChNT_kWRUng@mail.gmail.com>
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

On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
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
> index 86375605faa9..cd1ef9e5e638 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -136,7 +136,7 @@ void __ClearPageMovable(struct page *page)
>
>  /*
>   * Compaction is deferred when compaction fails to result in a page
> - * allocation success. 1 << compact_defer_limit compactions are skipped up
> + * allocation success. compact_defer_shift++, compactions are skipped up
>   * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
>   */
>  void defer_compaction(struct zone *zone, int order)

So this doesn't read right. I wouldn't keep the "++," in the
explanation, and if we are going to refer to a limit of "1 <<
COMPACT_MAX_DEFER_SHIFT" then maybe this should be left as "1 <<
compact_defer_shift".
