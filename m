Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F26230E8D
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgG1P4H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgG1P4H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 11:56:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DBC061794;
        Tue, 28 Jul 2020 08:56:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id t15so12336571iob.3;
        Tue, 28 Jul 2020 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OTfwjc1FRQLZQNZD1/9bduGC1jve2EFF+bZqMItMbMI=;
        b=bZo5BpOKVA3FUbeHqes88E2XiqI+1pUiJvaI8Vg2qsZrJ8/WVytv13JK85YM7vRiW7
         7SBoL0m2NQdE0iD7/0In30u7Kh9hnvXHifRNYJq8UfCDDi3139iNiU07/3wrfcA3mtBp
         LrqHVWdXB+qrAzaOUxZgpmJ+rKwBKZOpWvoVw8u/OvICCYBTr2x85Bf0m2v7BAHTwnNx
         vZAnymn3iMjjrDEt58wRcAuKEXhred52FDKC0JS/J/j8lN0FUHVJUAPZzJ/F1kAQVGQ1
         WGlXXVxcOuVZXfPJjRLD6NcKUA0RzFELEfhnHwDlD5lO30mf8DtYbjTzcxfMliqaqxSx
         TuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OTfwjc1FRQLZQNZD1/9bduGC1jve2EFF+bZqMItMbMI=;
        b=U65EY5uuEHtQ8eiMBBEQPe1OdwNKGCj/fSVk2FbOQV+xohJAuEe6ztd5b5l/yl7++R
         OP8LOxprUV1RrU3MpHlyuHDeX3/BrVe83D+p3/aBOsSdO+WUm5FeOajt/N0jDRUd6fkJ
         g0sT5omEWJ/jAiQbp0oGHqD0/393G9AQP4dkRsM9NQat9jeBGtp606B1refy0IJUw2jG
         CSXzJWkjaGDSFA8xrF1yrgFfw1tdk1xWxvu6NRE9ttePbDMxQJmXLmncKkzXx5sNpHUS
         9v6bkkUuufaaxVvwaUKaam5i1Af7iUDChHA1IqCGe8OPbVmeIJsyuZrXnktz7oT4gxhL
         Z3cw==
X-Gm-Message-State: AOAM532l3wZvDzLOasZQsr/7LgD3iLL5s296C/RL7f8Y9rG6q2EdiIDJ
        mvcmSndAmIA7/dKS0eu7btWAPyG4KHT0pG78Sz0=
X-Google-Smtp-Source: ABdhPJwCqe5IctwsE4VLRsK8Zi2PsslTmgFY725Rn4+dwHYPCAonPWWUshwTmD9995054HtivWtW4maSQJv8hdfw2iw=
X-Received: by 2002:a6b:92d5:: with SMTP id u204mr17206025iod.38.1595951766280;
 Tue, 28 Jul 2020 08:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UdaW4Rf43yULhQBuP07vQgmoPbaWHGKv1Z7fEPP6jH83w@mail.gmail.com> <1fd45e69-3a50-aae8-bcc4-47d891a5e263@linux.alibaba.com>
In-Reply-To: <1fd45e69-3a50-aae8-bcc4-47d891a5e263@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 28 Jul 2020 08:55:55 -0700
Message-ID: <CAKgT0UfWckn0npij5UhEEmMKuG0bRytN3kPDtvvE3AdJuEZjJg@mail.gmail.com>
Subject: Re: [PATCH v17 17/21] mm/lru: replace pgdat lru_lock with lruvec lock
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
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 28, 2020 at 8:40 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/7/28 =E4=B8=8A=E5=8D=887:34, Alexander Duyck =E5=86=99=E9=
=81=93:
> > It might make more sense to look at modifying
> > compact_unlock_should_abort and compact_lock_irqsave (which always
> > returns true so should probably be a void) to address the deficiencies
> > they have that make them unusable for you.
>
> One of possible reuse for the func compact_unlock_should_abort, could be
> like the following, the locked parameter reused different in 2 places.
> but, it's seems no this style usage in kernel, isn't it?
>
> Thanks
> Alex
>
> From 41d5ce6562f20f74bc6ac2db83e226ac28d56e90 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Tue, 28 Jul 2020 21:19:32 +0800
> Subject: [PATCH] compaction polishing
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> ---
>  mm/compaction.c | 71 ++++++++++++++++++++++++---------------------------=
------
>  1 file changed, 30 insertions(+), 41 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c28a43481f01..36fce988de3e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -479,20 +479,20 @@ static bool test_and_set_skip(struct compact_contro=
l *cc, struct page *page,
>   *
>   * Always returns true which makes it easier to track lock state in call=
ers.
>   */
> -static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> +static void compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
>                                                 struct compact_control *c=
c)
>         __acquires(lock)
>  {
>         /* Track if the lock is contended in async mode */
>         if (cc->mode =3D=3D MIGRATE_ASYNC && !cc->contended) {
>                 if (spin_trylock_irqsave(lock, *flags))
> -                       return true;
> +                       return;
>
>                 cc->contended =3D true;
>         }
>
>         spin_lock_irqsave(lock, *flags);
> -       return true;
> +       return;
>  }
>
>  /*
> @@ -511,11 +511,11 @@ static bool compact_lock_irqsave(spinlock_t *lock, =
unsigned long *flags,
>   *             scheduled)
>   */
>  static bool compact_unlock_should_abort(spinlock_t *lock,
> -               unsigned long flags, bool *locked, struct compact_control=
 *cc)
> +               unsigned long flags, void **locked, struct compact_contro=
l *cc)

Instead of passing both a void pointer and the lock why not just pass
the pointer to the lock pointer? You could combine lock and locked
into a single argument and save yourself some extra effort.

>  {
>         if (*locked) {
>                 spin_unlock_irqrestore(lock, flags);
> -               *locked =3D false;
> +               *locked =3D NULL;
>         }
>
>         if (fatal_signal_pending(current)) {
> @@ -543,7 +543,7 @@ static unsigned long isolate_freepages_block(struct c=
ompact_control *cc,
>         int nr_scanned =3D 0, total_isolated =3D 0;
>         struct page *cursor;
>         unsigned long flags =3D 0;
> -       bool locked =3D false;
> +       struct compact_control *locked =3D NULL;
>         unsigned long blockpfn =3D *start_pfn;
>         unsigned int order;
>
> @@ -565,7 +565,7 @@ static unsigned long isolate_freepages_block(struct c=
ompact_control *cc,
>                  */
>                 if (!(blockpfn % SWAP_CLUSTER_MAX)
>                     && compact_unlock_should_abort(&cc->zone->lock, flags=
,
> -                                                               &locked, =
cc))
> +                                                       (void**)&locked, =
cc))
>                         break;
>
>                 nr_scanned++;
> @@ -599,8 +599,8 @@ static unsigned long isolate_freepages_block(struct c=
ompact_control *cc,
>                  * recheck as well.
>                  */
>                 if (!locked) {
> -                       locked =3D compact_lock_irqsave(&cc->zone->lock,
> -                                                               &flags, c=
c);
> +                       compact_lock_irqsave(&cc->zone->lock, &flags, cc)=
;
> +                       locked =3D cc;
>
>                         /* Recheck this is a buddy page under lock */
>                         if (!PageBuddy(page))

If you have to provide a pointer you might as well just provide a
pointer to the zone lock since that is the thing that is actually
holding the lock at this point and would be consistent with your other
uses of the locked value. One possibility would be to change the
return type so that you return a pointer to the lock you are using.
Then the code would look closer to the lruvec code you are already
using.

> @@ -787,7 +787,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>         unsigned long nr_scanned =3D 0, nr_isolated =3D 0;
>         struct lruvec *lruvec;
>         unsigned long flags =3D 0;
> -       struct lruvec *locked_lruvec =3D NULL;
> +       struct lruvec *locked =3D NULL;
>         struct page *page =3D NULL, *valid_page =3D NULL;
>         unsigned long start_pfn =3D low_pfn;
>         bool skip_on_failure =3D false;
> @@ -847,21 +847,11 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                  * contention, to give chance to IRQs. Abort completely i=
f
>                  * a fatal signal is pending.
>                  */
> -               if (!(low_pfn % SWAP_CLUSTER_MAX)) {
> -                       if (locked_lruvec) {
> -                               unlock_page_lruvec_irqrestore(locked_lruv=
ec,
> -                                                                       f=
lags);
> -                               locked_lruvec =3D NULL;
> -                       }
> -
> -                       if (fatal_signal_pending(current)) {
> -                               cc->contended =3D true;
> -
> -                               low_pfn =3D 0;
> -                               goto fatal_pending;
> -                       }
> -
> -                       cond_resched();
> +               if (!(low_pfn % SWAP_CLUSTER_MAX)
> +                   && compact_unlock_should_abort(&locked->lru_lock, fla=
gs,
> +                                               (void**)&locked, cc)) {

An added advantage to making locked a pointer to a spinlock is that
you could reduce the number of pointers you have to pass. Instead of
messing with &locked->lru_lock you would just pass the pointer to
locked resulting in fewer arguments being passed and if it is NULL you
skip the whole unlock pass.

> +                       low_pfn =3D 0;
> +                       goto fatal_pending;
>                 }
>
>                 if (!pfn_valid_within(low_pfn))
> @@ -932,9 +922,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                          */
>                         if (unlikely(__PageMovable(page)) &&
>                                         !PageIsolated(page)) {
> -                               if (locked_lruvec) {
> -                                       unlock_page_lruvec_irqrestore(loc=
ked_lruvec, flags);
> -                                       locked_lruvec =3D NULL;
> +                               if (locked) {
> +                                       unlock_page_lruvec_irqrestore(loc=
ked, flags);
> +                                       locked =3D NULL;
>                                 }
>
>                                 if (!isolate_movable_page(page, isolate_m=
ode))
> @@ -979,13 +969,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>
>                 /* If we already hold the lock, we can skip some rechecki=
ng */
> -               if (lruvec !=3D locked_lruvec) {
> -                       if (locked_lruvec)
> -                               unlock_page_lruvec_irqrestore(locked_lruv=
ec,
> +               if (lruvec !=3D locked) {
> +                       if (locked)
> +                               unlock_page_lruvec_irqrestore(locked,
>                                                                         f=
lags);
>
>                         compact_lock_irqsave(&lruvec->lru_lock, &flags, c=
c);
> -                       locked_lruvec =3D lruvec;
> +                       locked =3D lruvec;
>                         rcu_read_unlock();
>
>                         lruvec_memcg_debug(lruvec, page);
> @@ -1041,9 +1031,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
>
>  isolate_fail_put:
>                 /* Avoid potential deadlock in freeing page under lru_loc=
k */
> -               if (locked_lruvec) {
> -                       unlock_page_lruvec_irqrestore(locked_lruvec, flag=
s);
> -                       locked_lruvec =3D NULL;
> +               if (locked) {
> +                       unlock_page_lruvec_irqrestore(locked, flags);
> +                       locked =3D NULL;
>                 }
>                 put_page(page);
>
> @@ -1057,10 +1047,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                  * page anyway.
>                  */
>                 if (nr_isolated) {
> -                       if (locked_lruvec) {
> -                               unlock_page_lruvec_irqrestore(locked_lruv=
ec,
> -                                                                       f=
lags);
> -                               locked_lruvec =3D NULL;
> +                       if (locked) {
> +                               unlock_page_lruvec_irqrestore(locked, fla=
gs);
> +                               locked =3D NULL;
>                         }
>                         putback_movable_pages(&cc->migratepages);
>                         cc->nr_migratepages =3D 0;
> @@ -1087,8 +1076,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
>         page =3D NULL;
>
>  isolate_abort:
> -       if (locked_lruvec)
> -               unlock_page_lruvec_irqrestore(locked_lruvec, flags);
> +       if (locked)
> +               unlock_page_lruvec_irqrestore(locked, flags);
>         if (page) {
>                 SetPageLRU(page);
>                 put_page(page);
> --
> 1.8.3.1
>
