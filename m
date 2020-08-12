Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E4242DB1
	for <lists+cgroups@lfdr.de>; Wed, 12 Aug 2020 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHLQwD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Aug 2020 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHLQwC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Aug 2020 12:52:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCC9C061383;
        Wed, 12 Aug 2020 09:52:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so3445798ioa.13;
        Wed, 12 Aug 2020 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LuyNk2RHIZQWbMvYqCe4ROEmjWPzfgrGsIMWktrDl60=;
        b=Lfwd+RdahGQLDNUUdaLpgNDDn+37Z83e3bbs3Gf+AJzUtPucLNV8hF34dZr38kIQ6q
         bJtCSq94BdaKQT0+UGvr1KQ10WnxZAKShNOjXRfyiwvzxkS9VFFK9dImLh4wsV1/2SFY
         oluaI4riqSGPqvj10FyCfI4lK5A7fUDVr1f9/FR/PMkr4e5BsB3xNKRLevlS48averp4
         HBjgW6Ohco2d1zHHSIXLuvyZNFNMX+xr4moU+QwMA9ZW5IMYlg3Xa8jK+R70WEE0Sxis
         6aeCnNnGUcklg/T/9VQRy5vBWcr+GCnTk8RclTbgEpERpT9b8t6E2JdTEYID+5Nsc21y
         5ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LuyNk2RHIZQWbMvYqCe4ROEmjWPzfgrGsIMWktrDl60=;
        b=TmWyuqOJZX13JzZrf3oxPgFAXYnM5JJfE1J2VRl9ShPBU6dvUCigZr+RYPOA8jUzWY
         ee5+Mb+IwNrbbwLPtN7aNNZoPIe7lJXq4BvYEW15ujN5O+uZm9WJ1rwmBlufvdXIaAI5
         k1cesdc7e4JXnBFvbMb/Z+IZJfJ2MoATaFr9milck/oLDSctoeE/brEU/On2XID8rLSN
         nkf7PnkSoojj+eKW7T8R3D/IW3GEMVV+aBKQEwnxCOeiKyWema8WmR3EPwHTug/7MEzf
         66B34ofcZxEhEOEW3D+tozQnTJvy2c1fQnaS9uqNwUzMZEipDC1TC9hxgsO2iUyKQFx/
         bQHA==
X-Gm-Message-State: AOAM531EdNla0IBxw6Ig1isiFSlkT+SANx8pVJhBCX+BftPWSZ/BabHH
        9gNTY2Mh97Uc5KIvyuPc0RaXijt0+jm7CfKJZxo=
X-Google-Smtp-Source: ABdhPJwdt1Ck68O8RudZe5N/Q+pDzjII8PVB0ZnD01ErTlRxkmaflQLgXY/KplBbb6IpkiDjllz80f6rJgW3d/9usQk=
X-Received: by 2002:a02:8384:: with SMTP id z4mr321200jag.121.1597251120652;
 Wed, 12 Aug 2020 09:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com>
 <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com> <CAKgT0UdSrarC8j+G=LYRSadcaG6yNCoCfeVpFjEiHRJb4A77-g@mail.gmail.com>
 <8dbd004e-8eba-f1ec-a5eb-5dc551978936@linux.alibaba.com> <CAKgT0UdK-fy+yYGLFK=YgE+maa_0_uecq0_8S_0kM8BiVgRO7g@mail.gmail.com>
 <d9818e06-95f1-9f21-05c0-98f29ea96d89@linux.alibaba.com> <CAKgT0Ues0ShkSbb1XtA7z7EYB8NCPgLGq8zZUjrXK_jcWn8mDQ@mail.gmail.com>
 <9581db48-cef3-788a-7f5a-8548fee56c13@linux.alibaba.com>
In-Reply-To: <9581db48-cef3-788a-7f5a-8548fee56c13@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 12 Aug 2020 09:51:47 -0700
Message-ID: <CAKgT0UeuuQqpYRXXAs_YurWyDOtqx4y3sx7e4Xi2TE6s_7++Fg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 12, 2020 at 4:44 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/11 =E4=B8=8B=E5=8D=8810:47, Alexander Duyck =E5=86=99=E9=
=81=93:
> > On Tue, Aug 11, 2020 at 1:23 AM Alex Shi <alex.shi@linux.alibaba.com> w=
rote:
> >>
> >>
> >>
> >> =E5=9C=A8 2020/8/10 =E4=B8=8B=E5=8D=8810:41, Alexander Duyck =E5=86=99=
=E9=81=93:
> >>> On Mon, Aug 10, 2020 at 6:10 AM Alex Shi <alex.shi@linux.alibaba.com>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2020/8/7 =E4=B8=8B=E5=8D=8810:51, Alexander Duyck =E5=86=
=99=E9=81=93:
> >>>>> I wonder if this entire section shouldn't be restructured. This is =
the
> >>>>> only spot I can see where we are resetting the LRU flag instead of
> >>>>> pulling the page from the LRU list with the lock held. Looking over
> >>>>> the code it seems like something like that should be possible. I am
> >>>>> not sure the LRU lock is really protecting us in either the
> >>>>> PageCompound check nor the skip bits. It seems like holding a
> >>>>> reference on the page should prevent it from switching between
> >>>>> compound or not, and the skip bits are per pageblock with the LRU b=
its
> >>>>> being per node/memcg which I would think implies that we could have
> >>>>> multiple LRU locks that could apply to a single skip bit.
> >>>>
> >>>> Hi Alexander,
> >>>>
> >>>> I don't find problem yet on compound or skip bit usage. Would you cl=
arify the
> >>>> issue do you concerned?
> >>>>
> >>>> Thanks!
> >>>
> >>> The point I was getting at is that the LRU lock is being used to
> >>> protect these and with your changes I don't think that makes sense
> >>> anymore.
> >>>
> >>> The skip bits are per-pageblock bits. With your change the LRU lock i=
s
> >>> now per memcg first and then per node. As such I do not believe it
> >>> really provides any sort of exclusive access to the skip bits. I stil=
l
> >>> have to look into this more, but it seems like you need a lock per
> >>> either section or zone that can be used to protect those bits and dea=
l
> >>> with this sooner rather than waiting until you have found an LRU page=
.
> >>> The one part that is confusing though is that the definition of the
> >>> skip bits seems to call out that they are a hint since they are not
> >>> protected by a lock, but that is exactly what has been happening here=
.
> >>>
> >>
> >> The skip bits are safe here, since even it race with other skip action=
,
> >> It will still skip out. The skip action is try not to compaction too m=
uch,
> >> not a exclusive action needs avoid race.
> >
> > That would be the case if it didn't have the impact that they
> > currently do on the compaction process. What I am getting at is that a
> > race was introduced when you placed this test between the clearing of
> > the LRU flag and the actual pulling of the page from the LRU list. So
> > if you tested the skip bits before clearing the LRU flag then I would
> > be okay with the code, however because it is triggering an abort after
>
> Hi Alexander,
>
> Thanks a lot for comments and suggestions!
>
> I have tried your suggestion:
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> ---
>  mm/compaction.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b99c96c4862d..6c881dee8c9a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -988,6 +988,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 if (__isolate_lru_page_prepare(page, isolate_mode) !=3D 0=
)
>                         goto isolate_fail_put;
>
> +               /* Try get exclusive access under lock */
> +               if (!skip_updated) {
> +                       skip_updated =3D true;
> +                       if (test_and_set_skip(cc, page, low_pfn))
> +                               goto isolate_fail_put;
> +               }
> +
>                 /* Try isolate the page */
>                 if (!TestClearPageLRU(page))
>                         goto isolate_fail_put;

I would have made this much sooner. Probably before you call
get_page_unless_zero so as to avoid the unnecessary atomic operations.

> @@ -1006,13 +1013,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>
>                         lruvec_memcg_debug(lruvec, page);
>
> -                       /* Try get exclusive access under lock */
> -                       if (!skip_updated) {
> -                               skip_updated =3D true;
> -                               if (test_and_set_skip(cc, page, low_pfn))
> -                                       goto isolate_abort;
> -                       }
> -
>                         /*
>                          * Page become compound since the non-locked chec=
k,
>                          * and it's on LRU. It can only be a THP so the o=
rder
> --
>
> Performance of case-lru-file-mmap-read in vm-scalibity is dropped a bit. =
not
> helpful

So one issue with this change is that it is still too late to be of
much benefit. Really you should probably be doing this much sooner,
for example somewhere before the get_page_unless_zero(). Also the
thing that still has me scratching my head is the "Try get exclusive
access under lock" comment. The function declaration says this is
supposed to be a hint, but we were using the LRU lock to synchronize
it. I'm wondering if we should really be protecting this with the zone
lock since we are modifying the pageblock flags which also contain the
migration type value for the pageblock and are only modified while
holding the zone lock.

> > the LRU flag is cleared then you are creating a situation where
> > multiple processes will be stomping all over each other as you can
> > have each thread essentially take a page via the LRU flag, but only
> > one thread will process a page and it could skip over all other pages
> > that preemptively had their LRU flag cleared.
>
> It increase a bit crowd here, but lru_lock do reduce some them, and skip_=
bit
> could stop each other in a array check(bitmap). So compare to whole node
> lru_lock, the net profit is clear in patch 17.

My concern is that what you can end up with is multiple threads all
working over the same pageblock for isolation. With the old code the
LRU lock was used to make certain that test_and_set_skip was being
synchronized on the first page in the pageblock so you would only have
one thread going through and working a single pageblock. However after
your changes it doesn't seem like the test_and_set_skip has that
protection since only one thread will ever be able to successfully
call it for the first page in the pageblock assuming that the LRU flag
is set on the first page in the pageblock block.

> >
> > If you take a look at the test_and_set_skip the function only acts on
> > the pageblock aligned PFN for a given range. WIth the changes you have
> > in place now that would mean that only one thread would ever actually
> > call this function anyway since the first PFN would take the LRU flag
> > so no other thread could follow through and test or set the bit as
>
> Is this good for only one process could do test_and_set_skip? is that
> the 'skip' meaning to be?

So only one thread really getting to fully use test_and_set_skip is
good, however the issue is that there is nothing to synchronize the
testing from the other threads. As a result the other threads could
have isolated other pages within the pageblock before the thread that
is calling test_and_set_skip will get to complete the setting of the
skip bit. This will result in isolation failures for the thread that
set the skip bit which may be undesirable behavior.

With the old code the threads were all synchronized on testing the
first PFN in the pageblock while holding the LRU lock and that is what
we lost. My concern is the cases where skip_on_failure =3D=3D true are
going to fail much more often now as the threads can easily interfere
with each other.

> > well. The expectation before was that all threads would encounter this
> > test and either proceed after setting the bit for the first PFN or
> > abort after testing the first PFN. With you changes only the first
> > thread actually runs this test and then it and the others will likely
> > encounter multiple failures as they are all clearing LRU bits
> > simultaneously and tripping each other up. That is why the skip bit
> > must have a test and set done before you even get to the point of
> > clearing the LRU flag.
>
> It make the things warse in my machine, would you like to have a try by y=
ourself?

I plan to do that. I have already been working on a few things to
clean up and optimize your patch set further. I will try to submit an
RFC this evening so we can discuss.

> >
> >>> The point I was getting at with the PageCompound check is that instea=
d
> >>> of needing the LRU lock you should be able to look at PageCompound as
> >>> soon as you call get_page_unless_zero() and preempt the need to set
> >>> the LRU bit again. Instead of trying to rely on the LRU lock to
> >>> guarantee that the page hasn't been merged you could just rely on the
> >>> fact that you are holding a reference to it so it isn't going to
> >>> switch between being compound or order 0 since it cannot be freed. It
> >>> spoils the idea I originally had of combining the logic for
> >>> get_page_unless_zero and TestClearPageLRU into a single function, but
> >>> the advantage is you aren't clearing the LRU flag unless you are
> >>> actually going to pull the page from the LRU list.
> >>
> >> Sorry, I still can not follow you here. Compound code part is unchange=
d
> >> and follow the original logical. So would you like to pose a new code =
to
> >> see if its works?
> >
> > No there are significant changes as you reordered all of the
> > operations. Prior to your change the LRU bit was checked, but not
> > cleared before testing for PageCompound. Now you are clearing it
> > before you are testing if it is a compound page. So if compaction is
> > running we will be seeing the pages in the LRU stay put, but the
> > compound bit flickering off and on if the compound page is encountered
> > with the wrong or NULL lruvec. What I was suggesting is that the
>
> The lruvec could be wrong or NULL here, that is the base stone of whole
> patchset.

Sorry I had a typo in my comment as well as it is the LRU bit that
will be flickering, not the compound. The goal here is to avoid
clearing the LRU bit unless we are sure we are going to take the
lruvec lock and pull the page from the list.

> > PageCompound test probably doesn't need to be concerned with the lock
> > after your changes. You could test it after you call
> > get_page_unless_zero() and before you call
> > __isolate_lru_page_prepare(). Instead of relying on the LRU lock to
> > protect us from the page switching between compound and not we would
> > be relying on the fact that we are holding a reference to the page so
> > it should not be freed and transition between compound or not.
> >
>
> I have tried the patch as your suggested, it has no clear help on perform=
ance
> on above vm-scaliblity case. Maybe it's due to we checked the same thing
> before lock already.
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b99c96c4862d..cf2ac5148001 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -985,6 +985,16 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 if (unlikely(!get_page_unless_zero(page)))
>                         goto isolate_fail;
>
> +                       /*
> +                        * Page become compound since the non-locked chec=
k,
> +                        * and it's on LRU. It can only be a THP so the o=
rder
> +                        * is safe to read and it's 0 for tail pages.
> +                        */
> +                       if (unlikely(PageCompound(page) && !cc->alloc_con=
tig)) {
> +                               low_pfn +=3D compound_nr(page) - 1;
> +                               goto isolate_fail_put;
> +                       }
> +
>                 if (__isolate_lru_page_prepare(page, isolate_mode) !=3D 0=
)
>                         goto isolate_fail_put;
>
> @@ -1013,16 +1023,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                                         goto isolate_abort;
>                         }
>
> -                       /*
> -                        * Page become compound since the non-locked chec=
k,
> -                        * and it's on LRU. It can only be a THP so the o=
rder
> -                        * is safe to read and it's 0 for tail pages.
> -                        */
> -                       if (unlikely(PageCompound(page) && !cc->alloc_con=
tig)) {
> -                               low_pfn +=3D compound_nr(page) - 1;
> -                               SetPageLRU(page);
> -                               goto isolate_fail_put;
> -                       }
>                 } else
>                         rcu_read_unlock();
>

So actually there is more we could do than just this. Specifically a
few lines below the rcu_read_lock there is yet another PageCompound
check that sets low_pfn yet again. So in theory we could combine both
of those and modify the code so you end up with something more like:
@@ -968,6 +974,16 @@ isolate_migratepages_block(struct compact_control
*cc, unsigned long low_pfn,
                if (unlikely(!get_page_unless_zero(page)))
                        goto isolate_fail;

+               if (PageCompound(page)) {
+                       const unsigned int order =3D compound_order(page);
+
+                       if (likely(order < MAX_ORDER))
+                               low_pfn +=3D (1UL << order) - 1;
+
+                       if (unlikely(!cc->alloc_contig))
+                               goto isolate_fail_put;
+               }
+
                if (__isolate_lru_page_prepare(page, isolate_mode) !=3D 0)
                        goto isolate_fail_put;

Doing this you would be more likely to skip over the entire compound
page in a single jump should you not be able to either take the LRU
bit or encounter a busy page in __isolate_Lru_page_prepare. I had
copied this bit from an earlier check and modified it as I was not
sure I can guarantee that this is a THP since we haven't taken the LRU
lock yet. However I believe the page cannot be split up while we are
holding the extra reference so the PageCompound flag and order should
not change until we call put_page.
