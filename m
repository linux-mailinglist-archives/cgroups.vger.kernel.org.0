Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDB23DBE9
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 18:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHFQg6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Aug 2020 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgHFQfo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Aug 2020 12:35:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B1CC002147;
        Thu,  6 Aug 2020 09:27:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so42072431iod.1;
        Thu, 06 Aug 2020 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ahDyQRQ8qG4y6mT2u2SznObMHtFgTL4ajSNN22kfjp4=;
        b=ZdUtrIiJcl7Nfj9Rvxj9ES6+kDWC9CU4i6LSL72ge1TPy0kr03vTTQEUex02PjmL3u
         OREa/2ZjGChbnkDQPpgqTUPhSe1rrAhOluGC/DnFLngXi6g5zwZGyNbmoRXbsTxxdNht
         fct1LmaMYieptij4rv7VS/p47/4iviUWpBv0w3z9v1hGJLdxx9bBuWkxNdrfMKei+8pm
         iADYistAX6rxg2A/SFtqiU3NnJBJPQZHYT6bkzKb13tAG6buip1ZlNxlEI45+l4cQThT
         FLg479wbNG8iJF15uFtunAfz8Lpk+Y+8WpfyljXhAmTw3Eugcyr9C/nhqPKFGXKkKu3+
         uUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ahDyQRQ8qG4y6mT2u2SznObMHtFgTL4ajSNN22kfjp4=;
        b=ma8hcYstOX/2t0tqA1eUEpt/wM7WuES0R+yB8oMngn2R4NOvRj8tWWOHpoFmijYLiw
         xS3Taii4Pz0b9HaZD/JJ+8EnR0umErapR17o8M0EkSmIYeL3SjL/2dt773MoUzaxrhF0
         5jZ43uCuitf0jcPW4MD+fnqiIOxrWY1ZfHORCO7qWk0ZgvAtBVmTA0qMy5+FvOytY0Uq
         GYW+c9tREOdXogIYjdY+aMC7MOPVHog/lznKoGKBkckiMacjWtcH81Ll4X5HZTD+speg
         lL+x92WXo20o+k/1nSYrxBW7Vc8Ufj1rlPy9wlXfCCxDD+dInnB2uEgYaLo/rCH3afGg
         7rVw==
X-Gm-Message-State: AOAM531rx88ZikX2dn4FJkAgfSFRn5cK3tjihTSdWHmp47Zt67Gv7jx+
        BUtbpJ+GKKxAQ/6JDgqEGyK1Tks/fHy8vic3Oag=
X-Google-Smtp-Source: ABdhPJwp0t3SYC5aIhVbXM5FB0FqySqXQ3e9kH+H7ALWmqQU0x59DnrVnktbemL/IXIyov7ZoZdkXqsBZiq+pkoA6oM=
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr11285893iow.38.1596731248551;
 Thu, 06 Aug 2020 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-22-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfpHjBTHvtZz7=WMhZZAunVYuNMpuYBQCiorERb5seFUQ@mail.gmail.com>
 <f34e790f-50e6-112c-622f-d7ab804c6d22@linux.alibaba.com> <CAKgT0UckqbmYJDE3L2Bg1Nr=Y=GT0OBx1GEhaZ14EbRTzd8tiw@mail.gmail.com>
 <a1c6a3a6-f8e3-7bb5-e881-216a4b57ae84@linux.alibaba.com>
In-Reply-To: <a1c6a3a6-f8e3-7bb5-e881-216a4b57ae84@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 6 Aug 2020 09:27:16 -0700
Message-ID: <CAKgT0UcARhDAVYkJAPe=P5XBfk9fdyGPx0S7rqhiLLhg3s62dQ@mail.gmail.com>
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

On Wed, Aug 5, 2020 at 6:39 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2020/8/4 =E4=B8=8B=E5=8D=8810:29, Alexander Duyck =E5=86=99=E9=
=81=93:
> > On Tue, Aug 4, 2020 at 3:04 AM Alex Shi <alex.shi@linux.alibaba.com> wr=
ote:
> >>
> >>
> >>
> >> =E5=9C=A8 2020/8/4 =E4=B8=8A=E5=8D=886:37, Alexander Duyck =E5=86=99=
=E9=81=93:
> >>>>
> >>>>  shrink_inactive_list() also diverts any unevictable pages that it f=
inds on the
> >>>> -inactive lists to the appropriate zone's unevictable list.
> >>>> +inactive lists to the appropriate node's unevictable list.
> >>>>
> >>>>  shrink_inactive_list() should only see SHM_LOCK'd pages that became=
 SHM_LOCK'd
> >>>>  after shrink_active_list() had moved them to the inactive list, or =
pages mapped
> >>> Same here.
> >>
> >> lruvec is used per memcg per node actually, and it fallback to node if=
 memcg disabled.
> >> So the comments are still right.
> >>
> >> And most of changes just fix from zone->lru_lock to pgdat->lru_lock ch=
ange.
> >
> > Actually in my mind one thing that might work better would be to
> > explain what the lruvec is and where it resides. Then replace zone
> > with lruvec since that is really where the unevictable list resides.
> > Then it would be correct for both the memcg and pgdat case.
>
> Could you like to revise the doc as your thought?
> >
> >>>
> >>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >>>> index 64ede5f150dc..44738cdb5a55 100644
> >>>> --- a/include/linux/mm_types.h
> >>>> +++ b/include/linux/mm_types.h
> >>>> @@ -78,7 +78,7 @@ struct page {
> >>>>                 struct {        /* Page cache and anonymous pages */
> >>>>                         /**
> >>>>                          * @lru: Pageout list, eg. active_list prote=
cted by
> >>>> -                        * pgdat->lru_lock.  Sometimes used as a gen=
eric list
> >>>> +                        * lruvec->lru_lock.  Sometimes used as a ge=
neric list
> >>>>                          * by the page owner.
> >>>>                          */
> >>>>                         struct list_head lru;
> >>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>>> index 8af956aa13cf..c92289a4e14d 100644
> >>>> --- a/include/linux/mmzone.h
> >>>> +++ b/include/linux/mmzone.h
> >>>> @@ -115,7 +115,7 @@ static inline bool free_area_empty(struct free_a=
rea *area, int migratetype)
> >>>>  struct pglist_data;
> >>>>
> >>>>  /*
> >>>> - * zone->lock and the zone lru_lock are two of the hottest locks in=
 the kernel.
> >>>> + * zone->lock and the lru_lock are two of the hottest locks in the =
kernel.
> >>>>   * So add a wild amount of padding here to ensure that they fall in=
to separate
> >>>>   * cachelines.  There are very few zone structures in the machine, =
so space
> >>>>   * consumption is not a concern here.
> >>> So I don't believe you are using ZONE_PADDING in any way to try and
> >>> protect the LRU lock currently. At least you aren't using it in the
> >>> lruvec. As such it might make sense to just drop the reference to the
> >>> lru_lock here. That reminds me that we still need to review the
> >>> placement of the lru_lock and determine if there might be a better
> >>> placement and/or padding that might improve performance when under
> >>> heavy stress.
> >>>
> >>
> >> Right, is it the following looks better?
> >>
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index ccc76590f823..0ed520954843 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -113,8 +113,7 @@ static inline bool free_area_empty(struct free_are=
a *area, int migratetype)
> >>  struct pglist_data;
> >>
> >>  /*
> >> - * zone->lock and the lru_lock are two of the hottest locks in the ke=
rnel.
> >> - * So add a wild amount of padding here to ensure that they fall into=
 separate
> >> + * Add a wild amount of padding here to ensure datas fall into separa=
te
> >>   * cachelines.  There are very few zone structures in the machine, so=
 space
> >>   * consumption is not a concern here.
> >>   */
> >>
> >> Thanks!
> >> Alex
> >
> > I would maybe tweak it to make sure it is clear that we are using this
> > to pad out items that are likely to cause cache thrash such as various
> > hot spinocks and such.
> >
>
> I appreciate if you like to change the doc better. :)

Give me a day or so. I will submit a follow-on patch with some cleanup
for the comments.

Thanks.

- Alex
