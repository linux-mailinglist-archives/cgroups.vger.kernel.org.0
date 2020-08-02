Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F52359BE
	for <lists+cgroups@lfdr.de>; Sun,  2 Aug 2020 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHBSVF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 2 Aug 2020 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBSVF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 2 Aug 2020 14:21:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE9C06174A;
        Sun,  2 Aug 2020 11:21:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a5so21156451ioa.13;
        Sun, 02 Aug 2020 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eymiZWouRu2pskPk6lLMhIYaDCAUHR+AKe1qVabtwRI=;
        b=e/2c4X4cZyBwPWEhEMz8pWttU6ykLW2oan+3KUk0tfrPc+kfHc6HmskkZsNHKng6iA
         +t04TL3yFnkRGH7cOqnTguGl3MWnY+JBhEXXZjP0SVZtMgl6kLvXH0v8JazbBmQKjyF/
         WDcP7LE91BWEh197Z7ONxFL16Fb2J9qpjPjW47RxlrRSg9gLcZ5M7MDXsiU4T7YWPQG1
         CvxrtHVCgjPDa1zINW8d+VPpc9j2dFxLHRelqS5ZKOfeb8kPmwSKTAWEve+wp83W2/Ur
         HoftnL5dA2b0O+r0FsFFMLZAWBJrsPuYvykQouLc/N6yWH4CUMNpukTsN1J5ZTf59FK7
         Etyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eymiZWouRu2pskPk6lLMhIYaDCAUHR+AKe1qVabtwRI=;
        b=XlMXv77D/bkwIuHNozEKGENYHbKnLFjWHo713RPBAxM90+qmlqSLZNx0vXk7rU2+p/
         QOQq0rNLSk9q2Sa1q4JumLxdhG2ZXcEP66ipJ5MO3Li5uQemF8lxmx2doPAMBBUF1mPa
         DUsQS9qNcwTtnc6WDFXg4/VoKblMHzeqPrQAdH90kiebJFSA3bk3YwHDVy35c2WWSKyr
         ePhBrfV/idEPcs0Plsuhfsuu8XWc0WFa1g60Mf/lLptQiFpc+z/N0xVJywNcCHlbX8bE
         GyXlbLJ6U70fZqWCnM4MamLKuCmY7Vc9thM+1BUc/Miu/tGeqHZcnONUkvqQ/NBOdQHB
         QGyw==
X-Gm-Message-State: AOAM532T2dgosR9KzGSv4SE8+3ZJ/tKno7pubbXExO+f/1CO5xiyxs29
        8aQXI7anrx2iKzlLm567iKIYZu4F71gyy4Wz4HA=
X-Google-Smtp-Source: ABdhPJyw2q9TKbWYE+IgaM7eYFyWbUfG4XEhgbk4ZkyN+Syfvuim9IQtjE/hc410Zayewn3yPOXZqrz3BFKFqHm/xRs=
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr2103300iow.38.1596392464610;
 Sun, 02 Aug 2020 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
 <159622999150.2576729.14455020813024958573.stgit@ahduyck-desk1.jf.intel.com> <0c0a415a-52a0-5c06-b4be-80cbd3cb49c2@linux.alibaba.com>
In-Reply-To: <0c0a415a-52a0-5c06-b4be-80cbd3cb49c2@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sun, 2 Aug 2020 11:20:53 -0700
Message-ID: <CAKgT0UcDbzb_MXynzZANvJ_bV4VEguhxgOt2-hp4cNtvwE-r_Q@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Add function for testing if the current lruvec
 lock is valid
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        cgroups@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, kbuild test robot <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Feel free to fold it into your patches if you want.

I think Hugh was the one that had submitted a patch that addressed it,
and it looks like you folded that into your v17 set. It was probably
what he had identified which was the additional LRU checks needing to
be removed from the code.

Thanks.

- Alex

On Fri, Jul 31, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
> It looks much better than mine. and could replace 'mm/lru: introduce the =
relock_page_lruvec function'
> with your author signed. :)
>
> BTW,
> it's the rcu_read_lock cause the will-it-scale/page_fault3 regression whi=
ch you mentained in another
> letter?
>
> Thanks
> Alex
>
> =E5=9C=A8 2020/8/1 =E4=B8=8A=E5=8D=885:14, alexander.h.duyck@intel.com =
=E5=86=99=E9=81=93:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > When testing for relock we can avoid the need for RCU locking if we sim=
ply
> > compare the page pgdat and memcg pointers versus those that the lruvec =
is
> > holding. By doing this we can avoid the extra pointer walks and accesse=
s of
> > the memory cgroup.
> >
> > In addition we can avoid the checks entirely if lruvec is currently NUL=
L.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  include/linux/memcontrol.h |   52 +++++++++++++++++++++++++++---------=
--------
> >  1 file changed, 32 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 6e670f991b42..7a02f00bf3de 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -405,6 +405,22 @@ static inline struct lruvec *mem_cgroup_lruvec(str=
uct mem_cgroup *memcg,
> >
> >  struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_dat=
a *);
> >
> > +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> > +                                           struct lruvec *lruvec)
> > +{
> > +     pg_data_t *pgdat =3D page_pgdat(page);
> > +     const struct mem_cgroup *memcg;
> > +     struct mem_cgroup_per_node *mz;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return lruvec =3D=3D &pgdat->__lruvec;
> > +
> > +     mz =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > +     memcg =3D page->mem_cgroup ? : root_mem_cgroup;
> > +
> > +     return lruvec->pgdat =3D=3D pgdat && mz->memcg =3D=3D memcg;
> > +}
> > +
> >  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
> >
> >  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> > @@ -880,6 +896,14 @@ static inline struct lruvec *mem_cgroup_page_lruve=
c(struct page *page,
> >       return &pgdat->__lruvec;
> >  }
> >
> > +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> > +                                           struct lruvec *lruvec)
> > +{
> > +             pg_data_t *pgdat =3D page_pgdat(page);
> > +
> > +             return lruvec =3D=3D &pgdat->__lruvec;
> > +}
> > +
> >  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *=
memcg)
> >  {
> >       return NULL;
> > @@ -1317,18 +1341,12 @@ static inline void unlock_page_lruvec_irqrestor=
e(struct lruvec *lruvec,
> >  static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
> >               struct lruvec *locked_lruvec)
> >  {
> > -     struct pglist_data *pgdat =3D page_pgdat(page);
> > -     bool locked;
> > +     if (locked_lruvec) {
> > +             if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> > +                     return locked_lruvec;
> >
> > -     rcu_read_lock();
> > -     locked =3D mem_cgroup_page_lruvec(page, pgdat) =3D=3D locked_lruv=
ec;
> > -     rcu_read_unlock();
> > -
> > -     if (locked)
> > -             return locked_lruvec;
> > -
> > -     if (locked_lruvec)
> >               unlock_page_lruvec_irq(locked_lruvec);
> > +     }
> >
> >       return lock_page_lruvec_irq(page);
> >  }
> > @@ -1337,18 +1355,12 @@ static inline struct lruvec *relock_page_lruvec=
_irq(struct page *page,
> >  static inline struct lruvec *relock_page_lruvec_irqsave(struct page *p=
age,
> >               struct lruvec *locked_lruvec, unsigned long *flags)
> >  {
> > -     struct pglist_data *pgdat =3D page_pgdat(page);
> > -     bool locked;
> > -
> > -     rcu_read_lock();
> > -     locked =3D mem_cgroup_page_lruvec(page, pgdat) =3D=3D locked_lruv=
ec;
> > -     rcu_read_unlock();
> > -
> > -     if (locked)
> > -             return locked_lruvec;
> > +     if (locked_lruvec) {
> > +             if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> > +                     return locked_lruvec;
> >
> > -     if (locked_lruvec)
> >               unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
> > +     }
> >
> >       return lock_page_lruvec_irqsave(page, flags);
> >  }
> >
>
