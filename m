Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9905D226E8E
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgGTSvY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSvX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 14:51:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8796DC061794;
        Mon, 20 Jul 2020 11:51:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so18724297iob.4;
        Mon, 20 Jul 2020 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ys1byASwNVkEu+Q246YpVHsvBGXxnK17v4Z5vC/gYdM=;
        b=U0XUa3D/KFqLSLlbaEmkhi2sfIX7Nm1z6b0d44Zr5cHSCJXWVrYFW2VkIMm0bchIIl
         3kdRHlqtq2Vjs/WbEkSHGStNwviIUl7D2Bcm2OMTxc6bPsshFj5DlQvTza9FrssBA02h
         IWqByP5kBmWKAq+ND7dHTAZ1W+KeSGSrR2W24mNEDn+rtAHIMnc85KsnPy/CR/BUiPup
         a0r6fzYHN4s8pqPuOzCZiuKwssG1j5UzrWd9BSCukkvW/u/EI4NcuulTn/c23RHuXVdi
         BAyPdNP0ZQaIJQSgqlr5RbHuWYojrO0u8SV9Rp7+jH1lLTs+tGFf5x2KVcJ8XFaUBohw
         FprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ys1byASwNVkEu+Q246YpVHsvBGXxnK17v4Z5vC/gYdM=;
        b=pZkR5B9RZLB6MRpk+dkCLP3KXh1lEOFmLf+rOL14zA8/YiVqh4Gw5SkZR0a7DFXi4N
         wv4X8T1x7ZhDuvJnHlkCtH2hqp7rcN9qtMKk4up35/nUarTC4BFII/iwlKB4fsehL/Zb
         UqOaiRYV4rsH+dERTjjKOaLFfZOyTWVXtn+N4xc01En8yTdfXmQx0I7EweMy61zR46c2
         Kk2I5ob1PTrzTsjmBgVRaHOnhcSBfKkzL4ttmmu3dZUX1hLNJGyy/SzMqiBYp828pciq
         tvpWWjjXhG15xjr27C/C/NYDZgDfdGytZzSywXle96d97shJlQdufmAqGPfmukaB81Hp
         QzYg==
X-Gm-Message-State: AOAM531wW+cMsHEZxwtL8t68tKdN1LQcgBtQLA0GL+4Jtp6UZ3149ToK
        6ZzQZ8pHHm0So9ZFqOtFjUWW3kRoWcBQTs+XUO4=
X-Google-Smtp-Source: ABdhPJzzmabbaD388dpz4291CkIrsYE9OGZpb9+pWy+XCsWK5uxsU6BjTAj1Fy3wt0ID+VRMhQ/1jE89UOiqLtSxPqk=
X-Received: by 2002:a6b:f012:: with SMTP id w18mr24125041ioc.5.1595271082782;
 Mon, 20 Jul 2020 11:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-17-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Udcry01samXT54RkurNqFKnVmv-686ZFHF+iw4b+12T_A@mail.gmail.com> <6e37ee32-c6c5-fcc5-3cad-74f7ae41fb67@linux.alibaba.com>
In-Reply-To: <6e37ee32-c6c5-fcc5-3cad-74f7ae41fb67@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 20 Jul 2020 11:51:12 -0700
Message-ID: <CAKgT0Ue2i96gL=Tqx_wFmsBj_b1cnM1KQHh8b+oYr5iRg0Tcpw@mail.gmail.com>
Subject: Re: [PATCH v16 16/22] mm/mlock: reorder isolation sequence during munlock
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
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 18, 2020 at 8:56 PM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/7/18 =E4=B8=8A=E5=8D=884:30, Alexander Duyck =E5=86=99=E9=
=81=93:
> > On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> w=
rote:
> >>
> >> This patch reorder the isolation steps during munlock, move the lru lo=
ck
> >> to guard each pages, unfold __munlock_isolate_lru_page func, to do the
> >> preparation for lru lock change.
> >>
> >> __split_huge_page_refcount doesn't exist, but we still have to guard
> >> PageMlocked and PageLRU for tail page in __split_huge_page_tail.
> >>
> >> [lkp@intel.com: found a sleeping function bug ... at mm/rmap.c]
> >> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> >> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  mm/mlock.c | 93 ++++++++++++++++++++++++++++++++++-------------------=
---------
> >>  1 file changed, 51 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/mm/mlock.c b/mm/mlock.c
> >> index 228ba5a8e0a5..0bdde88b4438 100644
> >> --- a/mm/mlock.c
> >> +++ b/mm/mlock.c
> >> @@ -103,25 +103,6 @@ void mlock_vma_page(struct page *page)
> >>  }
> >>
> >>  /*
> >> - * Isolate a page from LRU with optional get_page() pin.
> >> - * Assumes lru_lock already held and page already pinned.
> >> - */
> >> -static bool __munlock_isolate_lru_page(struct page *page, bool getpag=
e)
> >> -{
> >> -       if (TestClearPageLRU(page)) {
> >> -               struct lruvec *lruvec;
> >> -
> >> -               lruvec =3D mem_cgroup_page_lruvec(page, page_pgdat(pag=
e));
> >> -               if (getpage)
> >> -                       get_page(page);
> >> -               del_page_from_lru_list(page, lruvec, page_lru(page));
> >> -               return true;
> >> -       }
> >> -
> >> -       return false;
> >> -}
> >> -
> >> -/*
> >>   * Finish munlock after successful page isolation
> >>   *
> >>   * Page must be locked. This is a wrapper for try_to_munlock()
> >> @@ -181,6 +162,7 @@ static void __munlock_isolation_failed(struct page=
 *page)
> >>  unsigned int munlock_vma_page(struct page *page)
> >>  {
> >>         int nr_pages;
> >> +       bool clearlru =3D false;
> >>         pg_data_t *pgdat =3D page_pgdat(page);
> >>
> >>         /* For try_to_munlock() and to serialize with page migration *=
/
> >> @@ -189,32 +171,42 @@ unsigned int munlock_vma_page(struct page *page)
> >>         VM_BUG_ON_PAGE(PageTail(page), page);
> >>
> >>         /*
> >> -        * Serialize with any parallel __split_huge_page_refcount() wh=
ich
> >> +        * Serialize split tail pages in __split_huge_page_tail() whic=
h
> >>          * might otherwise copy PageMlocked to part of the tail pages =
before
> >>          * we clear it in the head page. It also stabilizes hpage_nr_p=
ages().
> >>          */
> >> +       get_page(page);
> >
> > I don't think this get_page() call needs to be up here. It could be
> > left down before we delete the page from the LRU list as it is really
> > needed to take a reference on the page before we call
> > __munlock_isolated_page(), or at least that is the way it looks to me.
> > By doing that you can avoid a bunch of cleanup in these exception
> > cases.
>
> Uh, It seems unlikely for !page->_refcount, and then got to release_pages=
(),
> if so, get_page do could move down.
> Thanks
>
> >
> >> +       clearlru =3D TestClearPageLRU(page);
> >
> > I'm not sure I fully understand the reason for moving this here. By
> > clearing this flag before you clear Mlocked does this give you some
> > sort of extra protection? I don't see how since Mlocked doesn't
> > necessarily imply the page is on LRU.
> >
>
> Above comments give a reason for the lru_lock usage,

I think things are getting confused here. The problem is that clearing
the page LRU flag is not the same as acquiring the LRU lock.

I was looking through patch 22 and it occured to me that the
documentation in __pagevec_lru_add_fn was never updated. My worry is
that it might have been overlooked, either that or maybe you discussed
it previously and I missed the discussion. There it calls out that you
either have to hold onto the LRU lock, or you have to test PageLRU
after clearing the Mlocked flag otherwise you risk introducing a race.
It seems to me like you could potentially just collapse the lock down
further if you are using it more inline with the 2b case as defined
there rather than trying to still use it to protect the Mlocked flag
even though you have already pulled the LRU bit before taking the
lock. Either that or this is more like the pagevec_lru_move_fn in
which case you are already holding the LRU lock so you just need to
call the test and clear before trying to pull the page off of the LRU
list.

> >> +        * Serialize split tail pages in __split_huge_page_tail() whic=
h
> >>          * might otherwise copy PageMlocked to part of the tail pages =
before
> >>          * we clear it in the head page. It also stabilizes hpage_nr_p=
ages().
>
> Look into the __split_huge_page_tail, there is a tiny gap between tail pa=
ge
> get PG_mlocked, and it is added into lru list.
> The TestClearPageLRU could blocked memcg changes of the page from stoppin=
g
> isolate_lru_page.

I get that there is a gap between the two in __split_huge_page_tail.
My concern is more the fact that you are pulling the bit testing
outside of the locked region when I don't think it needs to be. The
lock is being taken unconditionally, so why pull the testing out when
you could just do it inside the lock anyway? My worry is that you
might be addressing __split_huge_page_tail but in the process you
might be introducing a new race with something like
__pagevec_lru_add_fn.

If I am not mistaken the Mlocked flag can still be cleared regardless
of if the LRU bit is set or not. So you can still clear the LRU bit
before you pull the page out of the list, but it can be done after
clearing the Mlocked flag instead of before you have even taken the
LRU lock. In that way it would function more similar to how you
handled pagevec_lru_move_fn() as all this function is really doing is
moving the pages out of the unevictable list into one of the other LRU
lists anyway since the Mlocked flag was cleared.

> >>         spin_lock_irq(&pgdat->lru_lock);
> >>
> >>         if (!TestClearPageMlocked(page)) {
> >> -               /* Potentially, PTE-mapped THP: do not skip the rest P=
TEs */
> >> -               nr_pages =3D 1;
> >> -               goto unlock_out;
> >> +               if (clearlru)
> >> +                       SetPageLRU(page);
> >> +               /*
> >> +                * Potentially, PTE-mapped THP: do not skip the rest P=
TEs
> >> +                * Reuse lock as memory barrier for release_pages raci=
ng.
> >> +                */
> >> +               spin_unlock_irq(&pgdat->lru_lock);
> >> +               put_page(page);
> >> +               return 0;
> >>         }
> >>
> >>         nr_pages =3D hpage_nr_pages(page);
> >>         __mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> >>
> >> -       if (__munlock_isolate_lru_page(page, true)) {
> >> +       if (clearlru) {
> >> +               struct lruvec *lruvec;
> >> +
> >
> > You could just place the get_page() call here.
> >
> >> +               lruvec =3D mem_cgroup_page_lruvec(page, page_pgdat(pag=
e));
> >> +               del_page_from_lru_list(page, lruvec, page_lru(page));
> >>                 spin_unlock_irq(&pgdat->lru_lock);
> >>                 __munlock_isolated_page(page);
> >> -               goto out;
> >> +       } else {
> >> +               spin_unlock_irq(&pgdat->lru_lock);
> >> +               put_page(page);
> >> +               __munlock_isolation_failed(page);
> >
> > If you move the get_page() as I suggested above there wouldn't be a
> > need for the put_page(). It then becomes possible to simplify the code
> > a bit by merging the unlock paths and doing an if/else with the
> > __munlock functions like so:
> > if (clearlru) {
> >     ...
> >     del_page_from_lru..
> > }
> >
> > spin_unlock_irq()
> >
> > if (clearlru)
> >     __munlock_isolated_page();
> > else
> >     __munlock_isolated_failed();
> >
> >>         }
> >> -       __munlock_isolation_failed(page);
> >> -
> >> -unlock_out:
> >> -       spin_unlock_irq(&pgdat->lru_lock);
> >>
> >> -out:
> >>         return nr_pages - 1;
> >>  }
> >>
> >> @@ -297,34 +289,51 @@ static void __munlock_pagevec(struct pagevec *pv=
ec, struct zone *zone)
> >>         pagevec_init(&pvec_putback);
> >>
> >>         /* Phase 1: page isolation */
> >> -       spin_lock_irq(&zone->zone_pgdat->lru_lock);
> >>         for (i =3D 0; i < nr; i++) {
> >>                 struct page *page =3D pvec->pages[i];
> >> +               struct lruvec *lruvec;
> >> +               bool clearlru;
> >>
> >> -               if (TestClearPageMlocked(page)) {
> >> -                       /*
> >> -                        * We already have pin from follow_page_mask()
> >> -                        * so we can spare the get_page() here.
> >> -                        */
> >> -                       if (__munlock_isolate_lru_page(page, false))
> >> -                               continue;
> >> -                       else
> >> -                               __munlock_isolation_failed(page);
> >> -               } else {
> >> +               clearlru =3D TestClearPageLRU(page);
> >> +               spin_lock_irq(&zone->zone_pgdat->lru_lock);
> >
> > I still don't see what you are gaining by moving the bit test up to
> > this point. Seems like it would be better left below with the lock
> > just being used to prevent a possible race while you are pulling the
> > page out of the LRU list.
> >
>
> the same reason as above comments mentained __split_huge_page_tail()
> issue.

I have the same argument here as above. The LRU lock is being used to
protect the Mlocked flag, as such there isn't a need to move the
get_page and clearing of the LRU flag up.  The get_page() call isn't
needed until just before we delete the page from the LRU list, and the
clearing isn't really needed until after we have already cleared the
Mlocked flag to see if we even have any work that we have to do, but
we do need to clear it before we are allowed to delete the page from
the LRU list.
