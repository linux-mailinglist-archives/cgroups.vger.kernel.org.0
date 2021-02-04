Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B530F6F8
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbhBDP52 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 10:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbhBDP5C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 10:57:02 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E75C061786
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 07:56:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so2403817pgj.4
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCCaUVi9BPMivSd/JjnmDZicqO5VGVuxEY7PUQjIT88=;
        b=rlZgV+XQhv7Yhfg2tHnSnXCKKbzm84eznk312M6PxgAwzfTh4Ik7suX8rLMrd8rXzW
         ELbY53/nujaDFMiP14r3bJRXJe2SLOoDDm7sffhsqmt4GKW+wmpKq6Gdtfj2QdFO17T+
         WrG64+XjOEDDvget+WoHZdNRbg5IRNW8ARaNBPxIRGcCFwjnSRzV0hu2+Sg9n5s1otFy
         dIe6RG99T8b1bYWd9JqmT4Sgzp+tBEy+/04B4IeuCr5ItLShwKeV6hjbqyEvOKR40jJe
         PdJGOuMShSOj8Gf4D32HY3XPIV4w8c5fUSBIfYPjxjpKYoZdYKnWF1oTvlasKNpW/y0T
         fP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCCaUVi9BPMivSd/JjnmDZicqO5VGVuxEY7PUQjIT88=;
        b=L8VyzfrBJGnsLc7Q+FHpjyc7f6cnOAF32ie5+TQRq3C/cIBbObAXsexUlizDwlhqRR
         0/d+kZ7/vpBcPevSc+vpPU8BmMFQHPfCCc+yjU4tdMzOZN1+BjoeyhFfNK6XAlFX/SRo
         UWQxgj2hftHZY0ulWqpejypwlLCPs3IUfVR20CqlHvf/i7KoVM/2/aFLeWag309Q2Zvf
         52M2nPePNL4FcZi1TiQa43nEmg6N/9a1Gr3MbAidtNf3AWKY+YvgfNUArYxgSIRrnf83
         CMNEtilJuwJCN9fsBzvbzviJHEgSE9n4U+16EUvwxGnefS22LPZqVnvYhU9tQ33e+Rsr
         FWrQ==
X-Gm-Message-State: AOAM531dqGkQ1M3NjXPA4cuXSFOGJ5/q5XtSYCERO7ilxRFqam3we6U+
        DZBRu5+UjJdDDEBkkNmKqJkVqtuquROK6dRKvda9ew==
X-Google-Smtp-Source: ABdhPJzXtbVw14PHJVJ/P6K8tkRvunxd2TP14mtVIL9yWCyPsjhzxjQLtCgjheeh3TtrPvDyiMiinT+N4rjzr0uQEhw=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr9775637pgf.31.1612454181401;
 Thu, 04 Feb 2021 07:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20210204105320.46072-1-songmuchun@bytedance.com> <YBwPQUwLQ6hAbdSV@cmpxchg.org>
In-Reply-To: <YBwPQUwLQ6hAbdSV@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 4 Feb 2021 23:55:45 +0800
Message-ID: <CAMZfGtX6VKKyBNhUJk+a2NTub8nfHbET=N_1ERHAqjUDEVJnZg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: replace the loop with a list_for_each_entry()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 4, 2021 at 11:14 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Feb 04, 2021 at 06:53:20PM +0800, Muchun Song wrote:
> > The rule of list walk has gone since:
> >
> >  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> >
> > So remove the strange comment and replace the loop with a
> > list_for_each_entry().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 17 ++---------------
> >  1 file changed, 2 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6c7f1ea3955e..43341bd7ea1c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6891,24 +6891,11 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  static void uncharge_list(struct list_head *page_list)
> >  {
> >       struct uncharge_gather ug;
> > -     struct list_head *next;
> > +     struct page *page;
> >
> >       uncharge_gather_clear(&ug);
> > -
> > -     /*
> > -      * Note that the list can be a single page->lru; hence the
> > -      * do-while loop instead of a simple list_for_each_entry().
> > -      */
> > -     next = page_list->next;
> > -     do {
> > -             struct page *page;
> > -
> > -             page = list_entry(next, struct page, lru);
> > -             next = page->lru.next;
> > -
> > +     list_for_each_entry(page, page_list, lru)
> >               uncharge_page(page, &ug);
> > -     } while (next != page_list);
> > -
> >       uncharge_batch(&ug);
>
> Good catch, this makes things much simpler.
>
> Looking at the surrounding code, there also seems to be no reason
> anymore to have uncharge_list() as a separate function: there is only
> one caller after the mentioned commit, and it's trivial after your
> change. Would you mind folding it into mem_cgroup_uncharge_list()?

Will do. Thanks.

>
> The list_empty() check in that one is also unnecessary now: the
> do-while loop required at least one page to be on the list or it would
> crash, but list_for_each() will be just fine on an empty list.

Right. It makes things more simple.

>
> Thanks
