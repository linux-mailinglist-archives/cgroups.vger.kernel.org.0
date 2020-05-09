Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393041CC203
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEIOHF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 May 2020 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727986AbgEIOHD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 May 2020 10:07:03 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE240C05BD09
        for <cgroups@vger.kernel.org>; Sat,  9 May 2020 07:07:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b26so3697094lfa.5
        for <cgroups@vger.kernel.org>; Sat, 09 May 2020 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jc93T48//PCz7sdPyS0gIAsQLpsU+tV5Kt0CzqYwNik=;
        b=uF4uQoe+Y/Rjx41fEplRhUf+B9x5B5F/LKDeKQu+D8rktHPDMcvcrKJ2M9QRQslZfS
         pxpEfjWspPHF07KZa4jVhaeDrW9r2+L6O38kBjVzIONl+siiFRvZHre6UUqVfO5njY4B
         dclVPiAKKVgD9sk/qgxT+kxi1bWfRfD1eDSbafMPpBgtnE3jIzAu//+1lQ4e92NmJfmj
         LCTOgnamNTrgmOw5HmZ+CAhGi7SIJy6XSOZNlSbK8eezV94DWGSsmsC1Idq4uY50QrbP
         w0b4AnWsem9n7jdd6EvNgGuGM5FgnEYGAQe4NPYrBycRSJed3lj+S+y6HdS2UnvQtkqG
         9oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jc93T48//PCz7sdPyS0gIAsQLpsU+tV5Kt0CzqYwNik=;
        b=Co5lH7nVw1xvpQF+ChsY5kIRXlFAGab733fd0mY72tPHZcwtMXKGInifQWwIL5XdFX
         CQph2u8sZ9Lp1ZVb86YLOEiwEe0SevFI3KBRLcKg3ciPqf5yVO268HYhtg0ASLw1BiWE
         eO6mQ0/aQ1uWsXZi6JZNcWsLPNr6PgxAuoeV3Mp2Lg9GmBItZixp7AcMtrQB2gumyCOj
         1t4agjO9Qo5AVOW6OxotdRZHxG8VE2nDXinp+UH3bU7prq/75+uSOELKwthDGGSS418U
         zipwR8g3EUyLwlmKp3UZjGYlR13qEYdxjsR7uR7Kc4sgJVIzxDdWNHDsZQspqljIxZhq
         eqXw==
X-Gm-Message-State: AOAM5324UwJjQI0sSvJEd/kz0lRElwXO3cEzC+fRGVqcm+vKrBmhu60O
        aOl1APmLvBtpbHSZ+ofPgUs4AAaiuD/vVIixHvLoNw==
X-Google-Smtp-Source: ABdhPJwjPYzDPcoNKv0FtPPZDg27RvRDPPE/INXsZ6+T0TDBOd40qBSDRRPucaEnBz644KrZdQwsAsrxFNOD5b1wI6g=
X-Received: by 2002:a19:f512:: with SMTP id j18mr5027730lfb.33.1589033220016;
 Sat, 09 May 2020 07:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200508212215.181307-1-shakeelb@google.com> <20200508212215.181307-3-shakeelb@google.com>
 <20200508215122.GB226164@cmpxchg.org>
In-Reply-To: <20200508215122.GB226164@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 9 May 2020 07:06:48 -0700
Message-ID: <CALvZod5DyMK0uGhPD5oYjds0Q8ew=1LTqjbHK4YLdsqrfYQqWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: swap: fix update_page_reclaim_stat for huge pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 8, 2020 at 2:51 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 08, 2020 at 02:22:15PM -0700, Shakeel Butt wrote:
> > Currently update_page_reclaim_stat() updates the lruvec.reclaim_stats
> > just once for a page irrespective if a page is huge or not. Fix that by
> > passing the hpage_nr_pages(page) to it.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> https://lore.kernel.org/patchwork/patch/685703/
>
> Laughs, then cries.
>

What happened to that patch? Fell through the cracks?

> > @@ -928,7 +928,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
> >       }
> >
> >       if (!PageUnevictable(page))
> > -             update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
> > +             update_page_reclaim_stat(lruvec, file, PageActive(page_tail), 1);
>
> The change to __pagevec_lru_add_fn() below makes sure the tail pages
> are already accounted. This would make them count twice.
>

Yes, you are right. I will just re-send your patch after rebase.



> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > @@ -973,7 +973,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
> >       if (page_evictable(page)) {
> >               lru = page_lru(page);
> >               update_page_reclaim_stat(lruvec, page_is_file_lru(page),
> > -                                      PageActive(page));
> > +                                      PageActive(page), nr_pages);
> >               if (was_unevictable)
> >                       __count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
> >       } else {
