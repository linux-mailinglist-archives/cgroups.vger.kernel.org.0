Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B52247AD3
	for <lists+cgroups@lfdr.de>; Tue, 18 Aug 2020 00:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHQW6b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Aug 2020 18:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgHQW62 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Aug 2020 18:58:28 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41AC061389;
        Mon, 17 Aug 2020 15:58:27 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u126so19218794iod.12;
        Mon, 17 Aug 2020 15:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUinOKHyVodz4jvTS1Tm95hUcIyZXDORsxNhMipeHNI=;
        b=byIpvA6PXapCvY4kbX9hsHPmMFKCY69IW6PMIvbws4/x8AN3hC6qzvqvx9OoH0NDvs
         K0+ur+V+gik/czeG85229oQgaJMslt/bpivK5ELrz0IRun/ymrxVU3pKlTz/rce9mJT5
         oQ+qmEmqZJ48NuA2NMUtEhzYNqRqAcKYfhLcV6LSxNzWtoCVDiosbiVVcrX7w+BkVx1w
         884NUizKW61AP8E0defZhjbkHF3jdtVA3osKGJbKcWwqHVB4nLH36OeiyJh5y2sxkp1Z
         XPcZiDkxup87SeHU138rtD0cipsLApPga25ffrPjsj7opfL3vKkN2yGeFCUprlbS0XDQ
         pbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUinOKHyVodz4jvTS1Tm95hUcIyZXDORsxNhMipeHNI=;
        b=dNn8LM8+aKlIFOy4t5rlHqvyo1OLYMO/f+Yjsz1lrIS7j6teRdwPAHBET08B6Jkq/k
         wf5SwB/DwfW0UnWdSWZ+Sy8VQY2ruA060k5fnTfgDnELiMuwbtPQo5+0pnelgeVajJF0
         4pk6PRyTXmaDxHv9OS48TFdVdhfL3muaIVdAUuz3Z8nMWXY1AWVxdh5RxAXBYDph6bnQ
         8iawP5DDbpOF40LpYpfQSKO+GC/Qivb6xIyFpJCIyO05X/mmO+ww+DVsQAzueTUeNSdo
         MxsBENKJsJUs2IWLQKKKyk4VLKNwLIklcF5Plfmp6+/TGA+iBk1HOq3PASoCIVqHJt3R
         Wo9g==
X-Gm-Message-State: AOAM532XLtrIqUEdX7/eSoa/8OWzhus9t2XRKiBQ3rqmIixmIXTK6Cxn
        FjTZ8/Ty8G2OMO1hgayCW1X94hAMn8CLdWDRBSA=
X-Google-Smtp-Source: ABdhPJy34kcBAP3BK2E4PxuPNKUrvks5mcEY80IvzNnvrGyoBR82Uo/yk/nsMsmVM+1ZuY5AwRRcBR5TOKdk/ZHJfNI=
X-Received: by 2002:a05:6638:1508:: with SMTP id b8mr16744973jat.96.1597705106519;
 Mon, 17 Aug 2020 15:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 17 Aug 2020 15:58:15 -0700
Message-ID: <CAKgT0Uf-38mNQMN4PptyvL=Jzyooz-K-FsosaVv+P0ok-7R4Sw@mail.gmail.com>
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in compaction
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

> @@ -1691,17 +1680,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>                  * only when the page is being freed somewhere else.
>                  */
>                 scan += nr_pages;
> -               switch (__isolate_lru_page(page, mode)) {
> +               switch (__isolate_lru_page_prepare(page, mode)) {
>                 case 0:
> +                       /*
> +                        * Be careful not to clear PageLRU until after we're
> +                        * sure the page is not being freed elsewhere -- the
> +                        * page release code relies on it.
> +                        */
> +                       if (unlikely(!get_page_unless_zero(page)))
> +                               goto busy;
> +
> +                       if (!TestClearPageLRU(page)) {
> +                               /*
> +                                * This page may in other isolation path,
> +                                * but we still hold lru_lock.
> +                                */
> +                               put_page(page);
> +                               goto busy;
> +                       }
> +

So I was reviewing the code and came across this piece. It has me a
bit concerned since we are calling put_page while holding the LRU lock
which was taken before calling the function. We should be fine in
terms of not encountering a deadlock since the LRU bit is cleared the
page shouldn't grab the LRU lock again, however we could end up
grabbing the zone lock while holding the LRU lock which would be an
issue.

One other thought I had is that this might be safe because the
assumption would be that another thread is holding a reference on the
page, has already called TestClearPageLRU on the page and retrieved
the LRU bit, and is waiting on us to release the LRU lock before it
can pull the page off of the list. In that case put_page will never
decrement the reference count to 0. I believe that is the current case
but I cannot be certain.

I'm just wondering if we should just replace the put_page(page) with a
WARN_ON(put_page_testzero(page)) and a bit more documentation. If I am
not mistaken it should never be possible for the reference count to
actually hit zero here.

Thanks.

- Alex
