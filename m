Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E645D23BC2E
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgHDOas (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDOaL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 10:30:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25961C06174A;
        Tue,  4 Aug 2020 07:30:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so34330475iln.1;
        Tue, 04 Aug 2020 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DSILtMaPZVkkWKSXWo0XxONGdj0mqua+F4iUMIFu5jo=;
        b=dbt3cGyXK0zGkFNIC+R9pXNutUkFJp04mRi+AlD6bPj6TtJ2sBFrNr9I+9rfQpo6hX
         yHwRsJIC9S0+7cLucGvZPblimft6ur5BNrp0vaHJfrkMUAn00H7skzug6KA7LYH+4fKE
         JJBI5zZkXe8hA7I3uvZ338dmSi4v2qZNctvJM93IjxLHCi8GroNaCxQ2VkZGa9DpOSZM
         WeR6/T8+HnIDg5YEvSDD1xKeLfigme727LtghevcFLf/u+mt1kIC3gkOpQj+EDtyWPOn
         KsukeoiHTZkxannG30Cf8DMv4sKlp2kx6wQlG25ckRZG/PD0ywxC7bPb0TfoiW/k0OU7
         AyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DSILtMaPZVkkWKSXWo0XxONGdj0mqua+F4iUMIFu5jo=;
        b=guS2ZRuDV7JDWeS4OwUZmXfkn+Nci6hL7g25n0Q1NnPDFioFhuSmAXqzzrl4yIYrnk
         2gn+uZDs5yr8S3UAVKZpO4BKsJA21p3jMVzgbvMqv/sjX4rqc+wkM71PZhcWxyQq5pYD
         y8v6jHSpfc2PUSiexHAq875bwgk856cjtYv+5ONrNxtwoDzsg7eqyTDY293ZCHYPbyD1
         cTlCH24Y7UhohMjm0NSPbO6LcrdpbEnE6kLzqvin7S4Vg3EvxS4KvpTKTv5lcQDhmakC
         YtZZg9gpPX+wyYH5DYfpkXLksBNf6iOhABLi6oD3d+Xk+F051/O9AqUSiDMslha5gjZK
         4c0w==
X-Gm-Message-State: AOAM532quilBQr/kFh2O1pGUXLrCHMhen4a6bVqHS1+9hVWGgD6+pCu8
        OoQHfcY7aKZymt5/kMcI25+Tll6yYIT2zbNHVg8=
X-Google-Smtp-Source: ABdhPJx+/R4HDpNXzSmnTKJFKIeOAikwhjnVzXBltUix+rq+uHJyiD1Knr/XfbuHnHbULKOrMwOwjP83EPxhYVDIjew=
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr4680115ilr.97.1596551409234;
 Tue, 04 Aug 2020 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-22-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfpHjBTHvtZz7=WMhZZAunVYuNMpuYBQCiorERb5seFUQ@mail.gmail.com> <f34e790f-50e6-112c-622f-d7ab804c6d22@linux.alibaba.com>
In-Reply-To: <f34e790f-50e6-112c-622f-d7ab804c6d22@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 4 Aug 2020 07:29:58 -0700
Message-ID: <CAKgT0UckqbmYJDE3L2Bg1Nr=Y=GT0OBx1GEhaZ14EbRTzd8tiw@mail.gmail.com>
Subject: Re: [PATCH v17 21/21] mm/lru: revise the comments of lru_lock
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 4, 2020 at 3:04 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2020/8/4 =E4=B8=8A=E5=8D=886:37, Alexander Duyck =E5=86=99=E9=
=81=93:
> >>
> >>  shrink_inactive_list() also diverts any unevictable pages that it fin=
ds on the
> >> -inactive lists to the appropriate zone's unevictable list.
> >> +inactive lists to the appropriate node's unevictable list.
> >>
> >>  shrink_inactive_list() should only see SHM_LOCK'd pages that became S=
HM_LOCK'd
> >>  after shrink_active_list() had moved them to the inactive list, or pa=
ges mapped
> > Same here.
>
> lruvec is used per memcg per node actually, and it fallback to node if me=
mcg disabled.
> So the comments are still right.
>
> And most of changes just fix from zone->lru_lock to pgdat->lru_lock chang=
e.

Actually in my mind one thing that might work better would be to
explain what the lruvec is and where it resides. Then replace zone
with lruvec since that is really where the unevictable list resides.
Then it would be correct for both the memcg and pgdat case.

> >
> >> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >> index 64ede5f150dc..44738cdb5a55 100644
> >> --- a/include/linux/mm_types.h
> >> +++ b/include/linux/mm_types.h
> >> @@ -78,7 +78,7 @@ struct page {
> >>                 struct {        /* Page cache and anonymous pages */
> >>                         /**
> >>                          * @lru: Pageout list, eg. active_list protect=
ed by
> >> -                        * pgdat->lru_lock.  Sometimes used as a gener=
ic list
> >> +                        * lruvec->lru_lock.  Sometimes used as a gene=
ric list
> >>                          * by the page owner.
> >>                          */
> >>                         struct list_head lru;
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index 8af956aa13cf..c92289a4e14d 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -115,7 +115,7 @@ static inline bool free_area_empty(struct free_are=
a *area, int migratetype)
> >>  struct pglist_data;
> >>
> >>  /*
> >> - * zone->lock and the zone lru_lock are two of the hottest locks in t=
he kernel.
> >> + * zone->lock and the lru_lock are two of the hottest locks in the ke=
rnel.
> >>   * So add a wild amount of padding here to ensure that they fall into=
 separate
> >>   * cachelines.  There are very few zone structures in the machine, so=
 space
> >>   * consumption is not a concern here.
> > So I don't believe you are using ZONE_PADDING in any way to try and
> > protect the LRU lock currently. At least you aren't using it in the
> > lruvec. As such it might make sense to just drop the reference to the
> > lru_lock here. That reminds me that we still need to review the
> > placement of the lru_lock and determine if there might be a better
> > placement and/or padding that might improve performance when under
> > heavy stress.
> >
>
> Right, is it the following looks better?
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ccc76590f823..0ed520954843 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -113,8 +113,7 @@ static inline bool free_area_empty(struct free_area *=
area, int migratetype)
>  struct pglist_data;
>
>  /*
> - * zone->lock and the lru_lock are two of the hottest locks in the kerne=
l.
> - * So add a wild amount of padding here to ensure that they fall into se=
parate
> + * Add a wild amount of padding here to ensure datas fall into separate
>   * cachelines.  There are very few zone structures in the machine, so sp=
ace
>   * consumption is not a concern here.
>   */
>
> Thanks!
> Alex

I would maybe tweak it to make sure it is clear that we are using this
to pad out items that are likely to cause cache thrash such as various
hot spinocks and such.
