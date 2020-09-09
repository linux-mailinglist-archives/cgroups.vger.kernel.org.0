Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC462630CC
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgIIPoZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgIIPnu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 11:43:50 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A6C061757;
        Wed,  9 Sep 2020 08:43:49 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t18so2148131ilp.5;
        Wed, 09 Sep 2020 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njXoLvZWKDzgHgUldBb8FCQl7wLEH3o051fzPgYKUzA=;
        b=OXYBsOpJaPJjHDyrkcUk+PyH9weu7WrPHfYqhpvGyOnyptfQy0qhQz4xgNrVbzAPhG
         4EznyVNSEsu9VZOqoDRavkm19wlITmVn+L4ArXSdcDx3H5CtJXyc04NkdjUY3lRN+9WL
         sk25yW/qryEHSt/mBDKjbyrMFUXSkqajY5GNs5vitrGm+uixoAlcmTXu/i+GhuHe7jvy
         9iL8WzWtmYOb1r8mplrdU9Q06Vz/oiqndgajAhg3ejSIcCONS/qfX28RPQ2dn0VxZiVi
         GixDzQM8W6Qo6vBu/aW4LWCkllKJ1sFszcT4QDnPBxD4kkjptM1gJ3X5+GerPu81XW4F
         5fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njXoLvZWKDzgHgUldBb8FCQl7wLEH3o051fzPgYKUzA=;
        b=qt/3wr3YAUETJ/an4HlE2m/oSxNmJCPl6Nrg1w35gK9P9sCLZB1LZwM8+tSJBpekqZ
         Fidfl2ftw3fkKGX57a/4aNqwcVT1MzKS1nIrUBgMNs9t0y9QJPqXzKGkwQWNbf6E70Xb
         XDb52ANLIWcsN3pBqLAS5A/Y12iRmqG8pc11ap9KYr3Wj9SegiEE9k9bNB3Vv3t4BLc4
         7Mu3DuI1PVfWX3glkePkNwQmkxvBvKbzfAac2tlewfkyPBg3XHFZGtC2GReEk3SncQ3T
         Oxdhi3z9nWmurXWhtlJmM4HUpifgBpl9PmIg4TGzhsia1+bTRvgGPYNU153b/6FdhqhN
         Fjqg==
X-Gm-Message-State: AOAM533ALh3a5kw/aph1P9oQS55JmfzaZTuwDQiHAy3v1PZoq1o6nblv
        /9KLEC45b9gmBzAUh+fJMKYkzgign3MX7I0e/Lk=
X-Google-Smtp-Source: ABdhPJxV5O68/tZXcZi67IqD1nkk8d1bPLPrzfAID+uHo/+XcfTcab6BxAg8uu84CnHd2Idlgyqw3hf07TnQmfzNOuA=
X-Received: by 2002:a92:ae06:: with SMTP id s6mr3963351ilh.64.1599666228968;
 Wed, 09 Sep 2020 08:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com> <20200909010118.GB6583@casper.infradead.org>
In-Reply-To: <20200909010118.GB6583@casper.infradead.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 9 Sep 2020 08:43:38 -0700
Message-ID: <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 8, 2020 at 6:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 24, 2020 at 08:55:04PM +0800, Alex Shi wrote:
> > +++ b/mm/vmscan.c
> > @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
> >
> >                       if (!TestClearPageLRU(page)) {
> >                               /*
> > -                              * This page may in other isolation path,
> > -                              * but we still hold lru_lock.
> > +                              * This page is being isolated in another
> > +                              * thread, but we still hold lru_lock. The
> > +                              * other thread must be holding a reference
> > +                              * to the page so this should never hit a
> > +                              * reference count of 0.
> >                                */
> > -                             put_page(page);
> > +                             WARN_ON(put_page_testzero(page));
> >                               goto busy;
>
> I read Hugh's review and that led me to take a look at this.  We don't
> do it like this.  Use the same pattern as elsewhere in mm:
>
>         page_ref_sub(page, nr);
>         VM_BUG_ON_PAGE(page_count(page) <= 0, page);
>
>

Actually for this case page_ref_dec(page) would make more sense
wouldn't it? Otherwise I agree that would be a better change if that
is the way it has been handled before. I just wasn't familiar with
those other spots.

Thanks.

- Alex
