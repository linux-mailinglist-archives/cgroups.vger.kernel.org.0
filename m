Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1624A209
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHSOwY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgHSOwV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 10:52:21 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F36AC061757;
        Wed, 19 Aug 2020 07:52:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so20837595ilo.13;
        Wed, 19 Aug 2020 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tScvbNwkYnRqhhATPJ7UjpnLY9tTLi+iAPlBc9rB3iY=;
        b=VNV2FDB4prOhD7krvEKqNRccc1tIE3ic5uWeIuDwt90ZWFOeL9havI3q4VWlHeDNlD
         uX4QctT6sFkcZWlNwOUZBAhC/iupzupsuaErPhzT+hlDNLUmnr4kgfjEGWXt8gMext8c
         cwcsyhcty5Qifn13F1KfJQf+979yllT0BJpyWnMYHpQWw+goI30FSA2OJ9jnDoHnwrvx
         idKl3jZ7EBFt5GgiHIEFz8JalGse5Hvwjr4tsZsSU9/99CqD/yc0FyUux/NERNg/tT9L
         /GQFmg6aYSFpKCG/utfJlBNzWbz8PKJEZx5Th8eOvf+1KdoanUNVoXNh55++qa10pIl2
         gQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tScvbNwkYnRqhhATPJ7UjpnLY9tTLi+iAPlBc9rB3iY=;
        b=du2HVlkan4dCRHjafxmN7BOGR3/rnqPfFbCr/hHZZ+deGBusVaxsxe+BD3vtpbNkv4
         s8uUqWuQmgvj1k3rB4OUCHdLEOqhOopGp2e2ziflDxDtCCj/hZNJ4Bekhy6ZNj81sQ0B
         i3iH6vHVbgVASJDaCX1BEJz57JIcSKiqYWYOu1O9VfLlFcAqH0eF7KftXfhA3JNndyIw
         OHTSivjT2b111aE8ENxQ5zFQu5C9+ws6wAyIz6ny1txNy8qhwMpirxk5zT5YmR1to5K2
         f6LyKTcPUN674xPNse+z/UykM6GXmf2csBJJnZ3ZBqZB3ENMEGzbrF8x50Ynqj755u74
         128g==
X-Gm-Message-State: AOAM53328STxgxRxBpWL2LCgaJ/lTNkViPgaEtFja4CNZ4vuSVZeIKWt
        TQTdx65hom+uQo9n6tbciEbHwQrU/I20X49AUJQ=
X-Google-Smtp-Source: ABdhPJwvaKUYj/VF7zowJ3yR+UvMpeYHKVrq9VBPQWNGDV7+EQoQY7JPDmxtWwhYzHg4fV4XNvZfKGYiYzHpxjt6gnM=
X-Received: by 2002:a92:99d4:: with SMTP id t81mr10297363ilk.95.1597848740262;
 Wed, 19 Aug 2020 07:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042722.23414.2654.stgit@localhost.localdomain> <cc993d93-a5af-dd29-19f4-176ba86000e1@linux.alibaba.com>
In-Reply-To: <cc993d93-a5af-dd29-19f4-176ba86000e1@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 19 Aug 2020 07:52:09 -0700
Message-ID: <CAKgT0UeZa_-hpeV5X_PEf3sz9HSRsnLMgPSu6Zqb5wZ-H0jEhw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 12:52 AM Alex Shi <alex.shi@linux.alibaba.com> wrot=
e:
>
>
>
> =E5=9C=A8 2020/8/19 =E4=B8=8B=E5=8D=8812:27, Alexander Duyck =E5=86=99=E9=
=81=93:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > In isolate_lru_pages we have an exception path where if we call
> > get_page_unless_zero and that succeeds, but TestClearPageLRU fails we c=
all
> > put_page. Normally this would be problematic but due to the way that th=
e
> > calls are ordered and the fact that we are holding the LRU lock we know
> > that the caller must be holding another reference for the page. Since w=
e
> > can assume that we can replace the put_page with a call to
> > put_page_testzero contained within a WARN_ON. By doing this we should s=
ee
> > if we ever leak a page as a result of the reference count somehow hitti=
ng
> > zero when it shouldn't, and can avoid the overhead and confusion of usi=
ng
> > the full put_page call.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  mm/vmscan.c |    9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 5bc0c2322043..3ebe3f9b653b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned=
 long nr_to_scan,
> >
> >                       if (!TestClearPageLRU(page)) {
> >                               /*
> > -                              * This page may in other isolation path,
> > -                              * but we still hold lru_lock.
> > +                              * This page is being isolated in another
> > +                              * thread, but we still hold lru_lock. Th=
e
> > +                              * other thread must be holding a referen=
ce
> > +                              * to the page so this should never hit a
> > +                              * reference count of 0.
> >                                */
> > -                             put_page(page);
> > +                             WARN_ON(put_page_testzero(page));
>
> seems WARN_ON is always enabled.
>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

Yeah, it is always enabled however it should never be triggered. I had
considered just putting a page_ref_dec here since in theory this path
should never be triggered but I thought as a debug catch I add the
WARN_ON and put_page_testzero. If we ever do encounter this being
triggered then it will leak a page of memory which isn't the end of
the world but I thought would warrant a WARN_ON.
