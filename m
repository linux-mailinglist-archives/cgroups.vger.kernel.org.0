Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2540023DE53
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgHFRYm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Aug 2020 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgHFREE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Aug 2020 13:04:04 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC65C0A888F;
        Thu,  6 Aug 2020 07:41:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z17so25520368ill.6;
        Thu, 06 Aug 2020 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e+hO/GQg5P+bxQrVbS65C7Iq18WrIeXspRsLAKl6TmY=;
        b=TTazq0sCZRjto6OkfUWBKf1/2X3NxXYV0alJTRb9iha5CV4YG5RQoIkNcndd1jABiR
         6arDxJ3PjTvaYsRp6BllbjuvMHvBuTNR+lg4jQNgZ5AVcQMLBVKGZ4UAUBzSxWzbVYg2
         tTCnPg13nUaa3FAtnSUfhTAaz6PZe1omA4g5kN0i1eII5KKVMcO8E3f9lC8xg0C0jB5J
         Zyv4OffZSOkiwZ0V+e4ueUrTF9n2C5jfgfZ8t5TfeDmduvFro3ac3U6b0PBCIfSbloiq
         vgfcxRw9yG6TqBpCInEUWFfmcDx/FTzkyt4QDblpYEgmTXYWO4goZnIgoPEGA2Kxd943
         fRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e+hO/GQg5P+bxQrVbS65C7Iq18WrIeXspRsLAKl6TmY=;
        b=PE17qnaI6U7NeC2sVe1T5BRFs9IWbbpsX4sQEVwcHM9aj5HFHexTRCnmza2oAnkPyB
         v5PqyhdsuBPNQjk1tXowe0wSvBcYagzcGamV+RXWkrtWYL7RgMC7P5uHI+q0+pfujyXY
         BevgpdGRnwJkxxSC3MQKEI3Mtm1WXcg+5k5fknc97Kpz/YcQNmI+xjAZk64QEWUGSasJ
         0XLAC3zdFrqr54afaBWGe63Dx7u57u3Mh/kkwKyHQtXKXuTVtRpbsaIMJxuttSwKWkGw
         La1BlR1+jH6naBss5ugnoN5McKiFnq8mawpfMErScJgi4v48YDUv7BQbHbL30uWG4ChJ
         ulfQ==
X-Gm-Message-State: AOAM530GByZIduTZWbb80Yts9UI0R82Tmk7Mw4t/Kaumn1bxEEQW8yyy
        G9iZQo8ekxj8WT5eBHAHio/8GC081TW2XlGhl6I=
X-Google-Smtp-Source: ABdhPJyMYILla6HQYNcIPeMni5KOhLnUAjTEmattKCsp0+w1QGXrfuR6V4jG4VzEak6WOHcFfOeQS6f4Hb4mhukcP+E=
X-Received: by 2002:a92:5b12:: with SMTP id p18mr3323594ilb.95.1596724918389;
 Thu, 06 Aug 2020 07:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-14-git-send-email-alex.shi@linux.alibaba.com>
 <9b906469-38fb-8a4e-9a47-d617c7669579@linux.alibaba.com> <CAKgT0Ud1+FkJcTXR0MxZYFxd7mr=opdXfXKTqkmiu4NNMyT4bg@mail.gmail.com>
 <f9fa46a4-b341-2470-ce18-03379b9ea5c2@linux.alibaba.com>
In-Reply-To: <f9fa46a4-b341-2470-ce18-03379b9ea5c2@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 6 Aug 2020 07:41:47 -0700
Message-ID: <CAKgT0Ud-z4PH_d824KVgXtakwGNGXhd3Avvx4drBGmGh0nMcZw@mail.gmail.com>
Subject: Re: [PATCH v17 13/21] mm/lru: introduce TestClearPageLRU
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

On Wed, Aug 5, 2020 at 6:54 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2020/8/6 =E4=B8=8A=E5=8D=886:43, Alexander Duyck =E5=86=99=E9=
=81=93:
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
> > The more I look at this piece it seems like this change wasn't really
> > necessary. If anything it seems like it could catch potential bugs as
> > it was testing for the PageLRU flag before and then clearing it
> > manually anyway. In addition it doesn't reduce the critical path by
> > any significant amount so I am not sure these changes are providing
> > any benefit.
>
> Don't know hat kind of bug do you mean here, since the page is no one usi=
ng, means
> no one could ClearPageLRU in other place,  so if you like to keep the VM_=
BUG_ON_PAGE,
> that should be ok.

You kind of answered your own question. Basically the bug it would
catch is if another thread were to clear the flag without getting a
reference to the page first. My preference would be to leave this code
as is for now. There isn't much value in either moving the lruvec or
removing the VM_BUG_ON_PAGE call since the critical path size would
barely be effected as it is only one or two operations anyway. What it
comes down to is that the less unnecessary changes we make the better.
