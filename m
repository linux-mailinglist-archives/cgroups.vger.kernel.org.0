Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6624A1F0
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHSOmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSOmx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 10:42:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5FC061757;
        Wed, 19 Aug 2020 07:42:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u126so24841884iod.12;
        Wed, 19 Aug 2020 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mcVXNr/miBqBqBzPd9zMl9/P3yj0Py/DDVO/2K9/W8w=;
        b=We78s8aeZBHNS8HsXJOECFtjGX0yBLXCmD9JNUeoRZJB6mQznUcKYUARlp2d8bBHSj
         3MYtOox2aoiTCMZJHQ0aLbKAufrXDvLthlw1SYtqfpmsKIMKJ2AKJcyGEV9+c8l1w3Z1
         gCVfjavBkDJIkR3fUr3gg57fqGnCjcqa0v128cNDQur3H2RzKvtWNedO3MfQvg9dIMe3
         FJzHgpcTQvnbz5Ng96Mgg/91NthBPq/wlMFrT2EQKdfpKbLD5aEGeARJ24zu4Vn9Jf2V
         ilqu/6IJiEUpeCdUs/PwxW30G3jBBEkpPghitItA81NmeiUXeGHVXCopiMY4J/OlNh08
         ToMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mcVXNr/miBqBqBzPd9zMl9/P3yj0Py/DDVO/2K9/W8w=;
        b=Z4VwzbNc2ltbym/9G81bgWJET4hcOZm1w9Zxouqzq+sApPF6dIXvAwaAJpH9tolhvM
         Z4O5e/uRTd3dw978vDeXB8P+1Tj1EoF3G828V57s8k2iRWCVzvphwB7oxlWnIolzQE1o
         egu8fh26khdR1ipHCq9eUR8/z1++1jKxKU5Ztgplq+d5VffCN/Ip3aCxANvt2xXiUD5n
         AoqUfEI5jwcaimvf00BQeyEdkR8Vb3bSqFL09y2oNqeyk6IlOD8FqxRpVU55JZxT4KR7
         9fsrRGFxuqxzr7tputz1G17Um9l2CKEl4wKyVm5i1wl9s7AYtA0nLNwfVwphB668uzwe
         wR0g==
X-Gm-Message-State: AOAM530ZMvnlyMSTDkdJr2o9uQWJJ5fI6xKCDu3hj7MyqwYOmSKE4i2j
        p4JajsKNUZ/Fj4/ayRA1oWY5H6M4QCYd/Ggq1xBcKqfHDN4=
X-Google-Smtp-Source: ABdhPJy0G9erP9ijJ2vX8Ai98AthvnT14z2zO5yP9aZ0guBPsZfdROzXXArHkB7NYbBxnMOHqKwUMXP/pKWqLBtWNUU=
X-Received: by 2002:a6b:da0d:: with SMTP id x13mr20832998iob.138.1597848172300;
 Wed, 19 Aug 2020 07:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042738.23414.60815.stgit@localhost.localdomain> <084c58a7-7aac-820c-9606-19391c35b9b5@linux.alibaba.com>
In-Reply-To: <084c58a7-7aac-820c-9606-19391c35b9b5@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 19 Aug 2020 07:42:41 -0700
Message-ID: <CAKgT0Ud3CZ8KHLXCrWNGJAX85x23-EWLnAV63-NMmJ+5vD1JAA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] mm: Split move_pages_to_lru into 3 separate passes
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 12:58 AM Alex Shi <alex.shi@linux.alibaba.com> wrot=
e:
>
>
>
> =E5=9C=A8 2020/8/19 =E4=B8=8B=E5=8D=8812:27, Alexander Duyck =E5=86=99=E9=
=81=93:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > The current code for move_pages_to_lru is meant to release the LRU lock
> > every time it encounters an unevictable page or a compound page that mu=
st
> > be freed. This results in a fair amount of code bulk because the lruvec=
 has
> > to be reacquired every time the lock is released and reacquired.
> >
> > Instead of doing this I believe we can break the code up into 3 passes.=
 The
> > first pass will identify the pages we can move to LRU and move those. I=
n
> > addition it will sort the list out leaving the unevictable pages in the
> > list and moving those pages that have dropped to a reference count of 0=
 to
> > pages_to_free. The second pass will return the unevictable pages to the
> > LRU. The final pass will free any compound pages we have in the
> > pages_to_free list before we merge it back with the original list and
> > return from the function.
> >
> > The advantage of doing it this way is that we only have to release the =
lock
> > between pass 1 and 2, and then we reacquire the lock after pass 3 after=
 we
> > merge the pages_to_free back into the original list. As such we only ha=
ve
> > to release the lock at most once in an entire call instead of having to
> > test to see if we need to relock with each page.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  mm/vmscan.c |   68 ++++++++++++++++++++++++++++++++++-----------------=
--------
> >  1 file changed, 39 insertions(+), 29 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 3ebe3f9b653b..6a2bdbc1a9eb 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1850,22 +1850,21 @@ static unsigned noinline_for_stack move_pages_t=
o_lru(struct lruvec *lruvec,
> >  {
> >       int nr_pages, nr_moved =3D 0;
> >       LIST_HEAD(pages_to_free);
> > -     struct page *page;
> > -     struct lruvec *orig_lruvec =3D lruvec;
> > +     struct page *page, *next;
> >       enum lru_list lru;
> >
> > -     while (!list_empty(list)) {
> > -             page =3D lru_to_page(list);
> > +     list_for_each_entry_safe(page, next, list, lru) {
> >               VM_BUG_ON_PAGE(PageLRU(page), page);
> > -             list_del(&page->lru);
> > -             if (unlikely(!page_evictable(page))) {
> > -                     if (lruvec) {
> > -                             spin_unlock_irq(&lruvec->lru_lock);
> > -                             lruvec =3D NULL;
> > -                     }
> > -                     putback_lru_page(page);
> > +
> > +             /*
> > +              * if page is unevictable leave it on the list to be retu=
rned
> > +              * to the LRU after we have finished processing the other
> > +              * entries in the list.
> > +              */
> > +             if (unlikely(!page_evictable(page)))
> >                       continue;
> > -             }
> > +
> > +             list_del(&page->lru);
> >
> >               /*
> >                * The SetPageLRU needs to be kept here for list intergri=
ty.
> > @@ -1878,20 +1877,14 @@ static unsigned noinline_for_stack move_pages_t=
o_lru(struct lruvec *lruvec,
> >                *     list_add(&page->lru,)
> >                *                                        list_add(&page-=
>lru,)
> >                */
> > -             lruvec =3D relock_page_lruvec_irq(page, lruvec);
>
> It's actually changed the meaning from current func. which I had seen a b=
ug if no relock.
> but after move to 5.9 kernel, I can not reprodce the bug any more. I am n=
ot sure if 5.9 fixed
> the problem, and we don't need relock here.

So I am not sure what you mean here about "changed the meaning from
the current func". Which function are you referring to and what
changed?

From what I can tell the pages cannot change memcg because they were
isolated and had the LRU flag stripped. They shouldn't be able to
change destination LRU vector as a result. Assuming that, then they
can all be processed under same LRU lock and we can avoid having to
release it until we are forced to do so to call putback_lru_page or
destroy the compound pages that were freed while we were shrinking the
LRU lists.

> For the rest of this patch.
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

Thanks for the review.

- Alex
