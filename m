Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619D522431C
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGQS1L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGQS1L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 14:27:11 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA929C0619D2;
        Fri, 17 Jul 2020 11:27:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so11404042iob.4;
        Fri, 17 Jul 2020 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6x+glSlxiOGUjtI3jr6P1NnovfkvMrIggPzquz62cw=;
        b=Uzi/BmCKS1vdJXccY0TqAH/3oWOn8bQbOKU7Vgi8Y+xZWuRObC1dWx4Lyynr42k8zc
         jVcMADTtIIS64F0+kWtTq2wUFTcDjivKaYRKr6SCZd8OOtbbfZfkyq4SJawE14JSrQiU
         mCV7NajiUcqJXqRiuh6beFVd0gj5apNgbJxNx9hLTflVsiFSiwR/zCGLS4XcpMzux0ZJ
         +uJ3Nccueydk3NgAqAt4t3slRh+U4uWQy6SFnmOVhb3P4kvq9H6c9MmW7C1/s3e9MP+P
         e3pUt6O2R/S8nZyebwOb4LDrMrTD1BC1AgWO41lfKgmp2SExcqcpncFTP0Afy4ug52j3
         x6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6x+glSlxiOGUjtI3jr6P1NnovfkvMrIggPzquz62cw=;
        b=XrKVfIOoRH1Y9h/V35VSA+LM97MS212quzUbT3VGTOoS9JlWPaN9HvVslUTM7hhs+X
         FlkVX5sFNnIPAjjrr6eRicpX3DjO7+3d1jbreXexc+BvUphpPZyVOfz2nGcVjiOYi1li
         JlMTBEehq8UnNa6lYra04SGlYN541AnqwgVpDc7rAH2DQFeBuDk+nuCqgM0az4XoWyil
         AeiZGTIFrrPYPQl8DyNaTxK7yXRRmEGA3dvLJAAe01PEbvHIz69xJ2nHflF8wLRgO8Ay
         4D5kNFXDgwDy7RdTU0UFpjqIWY0qzy9AgJugkLUP7S6tHvtaXiA7ULZghBL15YvUzVyU
         aiMg==
X-Gm-Message-State: AOAM53049+rKtMPBKiAVyZaQrPW5szSof2eCejK0gs51llfptRZaMBkk
        +bvWKxX+EIuX3f/CAPsQZGgvF1ZH1/CfcU0nA4s=
X-Google-Smtp-Source: ABdhPJy6WcCzqVx850TXoaHGVgZtBKBL/mwB++F+IFatXPbZjyvdJ5tnfCLS5iZ0HsXdj6XRoAdsEP08cKLteWLXSBo=
X-Received: by 2002:a05:6638:cc7:: with SMTP id e7mr11986861jak.87.1595010430150;
 Fri, 17 Jul 2020 11:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-14-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfLbVRQ4+TOw-XnjuyZqoVmRmWb5_rbEZZ0povYv-n_Lg@mail.gmail.com> <072b39ac-b95a-94f1-67a2-3293d4550ff8@linux.alibaba.com>
In-Reply-To: <072b39ac-b95a-94f1-67a2-3293d4550ff8@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 17 Jul 2020 11:26:59 -0700
Message-ID: <CAKgT0UdDQp_bptKAjG4A4fJQgS5gJuvu6D7LJfKw_wETLtLG_w@mail.gmail.com>
Subject: Re: [PATCH v16 13/22] mm/lru: introduce TestClearPageLRU
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
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 17, 2020 at 12:46 AM Alex Shi <alex.shi@linux.alibaba.com> wrot=
e:
>
>
>
> =E5=9C=A8 2020/7/17 =E4=B8=8A=E5=8D=885:12, Alexander Duyck =E5=86=99=E9=
=81=93:
> > On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> w=
rote:
> >>
> >> Combine PageLRU check and ClearPageLRU into a function by new
> >> introduced func TestClearPageLRU. This function will be used as page
> >> isolation precondition to prevent other isolations some where else.
> >> Then there are may non PageLRU page on lru list, need to remove BUG
> >> checking accordingly.
> >>
> >> Hugh Dickins pointed that __page_cache_release and release_pages
> >> has no need to do atomic clear bit since no user on the page at that
> >> moment. and no need get_page() before lru bit clear in isolate_lru_pag=
e,
> >> since it '(1) Must be called with an elevated refcount on the page'.
> >>
> >> As Andrew Morton mentioned this change would dirty cacheline for page
> >> isn't on LRU. But the lost would be acceptable with Rong Chen
> >> <rong.a.chen@intel.com> report:
> >> https://lkml.org/lkml/2020/3/4/173
> >>
>
> ...
>
> >> diff --git a/mm/swap.c b/mm/swap.c
> >> index f645965fde0e..5092fe9c8c47 100644
> >> --- a/mm/swap.c
> >> +++ b/mm/swap.c
> >> @@ -83,10 +83,9 @@ static void __page_cache_release(struct page *page)
> >>                 struct lruvec *lruvec;
> >>                 unsigned long flags;
> >>
> >> +               __ClearPageLRU(page);
> >>                 spin_lock_irqsave(&pgdat->lru_lock, flags);
> >>                 lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> >> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
> >> -               __ClearPageLRU(page);
> >>                 del_page_from_lru_list(page, lruvec, page_off_lru(page=
));
> >>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> >>         }
> >
> > So this piece doesn't make much sense to me. Why not use
> > TestClearPageLRU(page) here? Just a few lines above you are testing
> > for PageLRU(page) and it seems like if you are going to go for an
> > atomic test/clear and then remove the page from the LRU list you
> > should be using it here as well otherwise it seems like you could run
> > into a potential collision since you are testing here without clearing
> > the bit.
> >
>
> Hi Alex,
>
> Thanks a lot for comments!
>
> In this func's call path __page_cache_release, the page is unlikely be
> ClearPageLRU, since this page isn't used by anyone, and going to be freed=
.
> just __ClearPageLRU would be safe, and could save a non lru page flags di=
sturb.

So if I understand what you are saying correctly you are indicating
that this page should likely not have the LRU flag set and that we
just transitioned it from 1 -> 0 so there should be nobody else
accessing it correct?

It might be useful to document this somewhere. Essentially what we are
doing then is breaking this up into the following cases.

1. Setting the LRU bit requires holding the LRU lock
2. Clearing the LRU bit requires either:
        a. Use of atomic operations if page count is 1 or more
        b. Non-atomic operations can be used if we cleared last reference c=
ount

Is my understanding on this correct? So we have essentially two
scenarios, one for the get_page_unless_zero case, and another with the
put_page_testzero.

> >> @@ -878,9 +877,8 @@ void release_pages(struct page **pages, int nr)
> >>                                 spin_lock_irqsave(&locked_pgdat->lru_l=
ock, flags);
> >>                         }
> >>
> >> -                       lruvec =3D mem_cgroup_page_lruvec(page, locked=
_pgdat);
> >> -                       VM_BUG_ON_PAGE(!PageLRU(page), page);
> >>                         __ClearPageLRU(page);
> >> +                       lruvec =3D mem_cgroup_page_lruvec(page, locked=
_pgdat);
> >>                         del_page_from_lru_list(page, lruvec, page_off_=
lru(page));
> >>                 }
> >>
> >
> > Same here. You are just moving the flag clearing, but you didn't
> > combine it with the test. It seems like if you are expecting this to
> > be treated as an atomic operation. It should be a relatively low cost
> > to do since you already should own the cacheline as a result of
> > calling put_page_testzero so I am not sure why you are not combining
> > the two.
>
> before the ClearPageLRU, there is a put_page_testzero(), that means no on=
e using
> this page, and isolate_lru_page can not run on this page the in func chec=
king.
>         VM_BUG_ON_PAGE(!page_count(page), page);
> So it would be safe here.

Okay, so this is another 2b case as defined above then.

> >
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index c1c4259b4de5..18986fefd49b 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1548,16 +1548,16 @@ int __isolate_lru_page(struct page *page, isol=
ate_mode_t mode)
> >>  {
> >>         int ret =3D -EINVAL;
> >>
> >> -       /* Only take pages on the LRU. */
> >> -       if (!PageLRU(page))
> >> -               return ret;
> >> -
> >>         /* Compaction should not handle unevictable pages but CMA can =
do so */
> >>         if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
> >>                 return ret;
> >>
> >>         ret =3D -EBUSY;
> >>
> >> +       /* Only take pages on the LRU. */
> >> +       if (!PageLRU(page))
> >> +               return ret;
> >> +
> >>         /*
> >>          * To minimise LRU disruption, the caller can indicate that it=
 only
> >>          * wants to isolate pages it will be able to operate on withou=
t
> >> @@ -1671,8 +1671,6 @@ static unsigned long isolate_lru_pages(unsigned =
long nr_to_scan,
> >>                 page =3D lru_to_page(src);
> >>                 prefetchw_prev_lru_page(page, src, flags);
> >>
> >> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
> >> -
> >>                 nr_pages =3D compound_nr(page);
> >>                 total_scan +=3D nr_pages;
> >>
> >
> > So effectively the changes here are making it so that a !PageLRU page
> > will cycle to the start of the LRU list. Now if I understand correctly
> > we are guaranteed that if the flag is not set it cannot be set while
> > we are holding the lru_lock, however it can be cleared while we are
> > holding the lock, correct? Thus that is why isolate_lru_pages has to
> > call TestClearPageLRU after the earlier check in __isolate_lru_page.
>
> Right.
>
> >
> > It might make it more readable to pull in the later patch that
> > modifies isolate_lru_pages that has it using TestClearPageLRU.
> As to this change, It has to do in this patch, since any TestClearPageLRU=
 may
> cause lru bit miss in the lru list, so the precondication check has to
> removed here.

So I think some of my cognitive dissonance is from the fact that you
really are doing two different things here. You aren't really
implementing the full TestClearPageLRU until patch 15. So this patch
is doing part of 2a and 2b, and then patch 15 is following up and
completing the 2a cases. I still think it might make more sense to
pull out the pieces related to 2b and move them into a patch before
this with documentation explaining that there should be no competition
for the LRU flag because the page has transitioned to a reference
count of zero. Then take the remaining bits and combine them with
patch 15 since the description for the two is pretty similar.
