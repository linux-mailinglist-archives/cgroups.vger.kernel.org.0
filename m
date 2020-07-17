Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1334022402F
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgGQQJ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGQQJ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 12:09:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA9DC0619D2;
        Fri, 17 Jul 2020 09:09:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so10962841ioh.5;
        Fri, 17 Jul 2020 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80duo2UCKGgh3D4vpF1VXWLmX4mSAl0+jky26IF2Kfc=;
        b=rz3oI1vxyD4wEFspA2IXpcN6RZgCG8ugcDQv4pjD++gEX0xWJzrl7/IvE0B5L4OiMN
         n3lSLCuMdLZg9h1a9XUA8isyooRlZIp0Oe7D9CgRkEQ0pNf8NqPD1dhRLxBVIonbLTuH
         rJLeVM/JLCYk8BU7XiOVFLi2U+GNwhp8V6yNnhOXc3KRHH8RRVm7Km3qi4oWqaNlreFc
         Nf4q/lt8EZ1JBoxQcRv4D75VlGItFhNde8Wi0JR7SvZ8DetJSH5t09MP7u3EKVvDFuVD
         6jcccRbVO1SvOYnx0WLDxbbiA2hiNAhErX2ZWtnmy4PR+B/1O3fLfgwwJ/2Fk88FyQJ8
         +Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80duo2UCKGgh3D4vpF1VXWLmX4mSAl0+jky26IF2Kfc=;
        b=iCvbYfnlqB3EmS6i6jUibmQuf0U/FkCOzi7rVLGik9BcIwWfOpq7D8oKftt1QZ9Coj
         bdsx9jd62rIK1tTngQDxo6foDJ464bZY9hMoRDr9M2TZBVg48v8K5pr1jh9LYdgpkMxS
         9Y9eXwoqZSTKehBIkBgMsZJqh1oqckh18om4FbyjiV0C+chGKtFT5yZJwQkh5MMpwbGF
         TUaS3q/clhRSQRofJ5rHYkRVz/PidpFPW4J/QPlQqiXAV5f8pn4GlgqFVrBL7SbCcDMx
         t7UkYaI+GbhL+OW+BqcguyikWO4r2/VW+1z45t80Akaxe5zxPaHgEzajWylibvHyLPgr
         idMA==
X-Gm-Message-State: AOAM533xWUFBbTxaCaARvtBd9xCnPQPRbJMZVD54pBoHTAOiCvPggToS
        UbsSh7g9Hd2XGkizO5FIdxxHtUNP+pyd4oK9g/s=
X-Google-Smtp-Source: ABdhPJxAS5zKXGaRqMgoDBx8B5vS6pgJi7+88Y8nU6nWwsBaz2StwBp/+VMGafhOk/5PifpRQsVX2g3wWOuV+jYMgq8=
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr11930673jaq.121.1595002197726;
 Fri, 17 Jul 2020 09:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-16-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ue72SfAmxCS+tay1NjioW9WBOvVgrhwUtVPz2aDCrcHPQ@mail.gmail.com> <e724c44b-4135-3302-16fa-1df624fa81fa@linux.alibaba.com>
In-Reply-To: <e724c44b-4135-3302-16fa-1df624fa81fa@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 17 Jul 2020 09:09:46 -0700
Message-ID: <CAKgT0UcbvTid8RqDgsZjewdEo1wTD8BDjPHo59UX9gKQEkZUtA@mail.gmail.com>
Subject: Re: [PATCH v16 15/22] mm/compaction: do page isolation first in compaction
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
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 16, 2020 at 10:10 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
> >> @@ -950,6 +951,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
> >>                 if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
> >>                         goto isolate_fail;
> >>
> >> +               /*
> >> +                * Be careful not to clear PageLRU until after we're
> >> +                * sure the page is not being freed elsewhere -- the
> >> +                * page release code relies on it.
> >> +                */
> >> +               if (unlikely(!get_page_unless_zero(page)))
> >> +                       goto isolate_fail;
> >> +
> >> +               if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
> >> +                       goto isolate_fail_put;
> >> +
> >> +               /* Try isolate the page */
> >> +               if (!TestClearPageLRU(page))
> >> +                       goto isolate_fail_put;
> >> +
> >>                 /* If we already hold the lock, we can skip some rechecking */
> >>                 if (!locked) {
> >>                         locked = compact_lock_irqsave(&pgdat->lru_lock,
> >
> > Why not do the __isolate_lru_page_prepare before getting the page?
> > That way you can avoid performing an extra atomic operation on non-LRU
> > pages.
> >
>
> This change come from Hugh Dickins as mentioned from commit log:
> >> trylock_page() is not safe to use at this time: its setting PG_locked
> >> can race with the page being freed or allocated ("Bad page"), and can
> >> also erase flags being set by one of those "sole owners" of a freshly
> >> allocated page who use non-atomic __SetPageFlag().
>
> Hi Hugh,
>
> would you like to show more details of the bug?
>
> ...
>
> >> +                        * sure the page is not being freed elsewhere -- the
> >> +                        * page release code relies on it.
> >> +                        */
> >> +                       if (unlikely(!get_page_unless_zero(page)))
> >> +                               goto busy;
> >> +
> >> +                       if (!TestClearPageLRU(page)) {
> >> +                               /*
> >> +                                * This page may in other isolation path,
> >> +                                * but we still hold lru_lock.
> >> +                                */
> >> +                               put_page(page);
> >> +                               goto busy;
> >> +                       }
> >> +
> >
> > I wonder if it wouldn't make sense to combine these two atomic ops
> > with tests and the put_page into a single inline function? Then it
> > could be possible to just do one check and if succeeds you do the
> > block of code below, otherwise you just fall-through into the -EBUSY
> > case.
> >
>
> Uh, since get_page changes page->_refcount, TestClearPageLRU changes page->flags,
> So I don't know how to combine them, could you make it more clear with code?

Actually it is pretty straight forward. Something like this:
static inline bool get_page_unless_zero_or_nonlru(struct page *page)
{
    if (get_page_unless_zero(page)) {
        if (TestClearPageLRU(page))
            return true;
        put_page(page);
    }
    return false;
}

You can then add comments as necessary. The general idea is you are
having to do this in two different spots anyway so why not combine the
logic? Although it does assume you can change the ordering of the
other test above.
