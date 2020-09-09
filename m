Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8481263857
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgIIVSL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIVSI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 17:18:08 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC0C061573;
        Wed,  9 Sep 2020 14:18:07 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l4so3739920ilq.2;
        Wed, 09 Sep 2020 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnLzSOXwd9TzDajenlu2J/UiYOI35S3s5MuiwhlH4dw=;
        b=BXgwd7VW3D3nGXoWuK0FaTrkufYeUNak7/0+6RtcEnJ6W0bmLyQ8zDp5kSvnRkQRRl
         nQYVOIWQcjJGaJ03/x71oDgv3WVCi/AyxI3Ntb92FxAKYj+sZnd6Wyk4Ippt0GFEeH3b
         rmifuCEuadf0B5UcFG1ybSAa1DOzQv4RXqxnaoVmVTzo4ufsGEFMezNJIIuMaybQmwkC
         tSHyhp8b2IjekP3cWYiJTBdy5FZkMRALFIRoAhcBW7VxIPayqkS78WFqnnvZuNZ0tOFv
         EoBf//6JwwM7FPz3JvVbrPx028RKxbnau6F8bjFIDs0qEdOVMqiwFiR0NhDeittZt3Vs
         crPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnLzSOXwd9TzDajenlu2J/UiYOI35S3s5MuiwhlH4dw=;
        b=cGlDQqcr6CVx3hKgyHNlZgHNCRGAGmGxO8nNMLoynUJhFzfhaTY6rPnz22o09c56AJ
         llwDVBusTQKaJ+09jyuaqAGZGYKVKS1qYV+cLGl/qOHhLR6yFUjucSrsq/AnVtSi2Qcg
         +b+zDJcpX37OfN93WuCWJpg+AdBLiTxLAMDzexsF6OwwRwlZARuPNAheqXWO+bvpNJC4
         3J7erp62VBGBVvj5wDkcluu69L+HmFKqji4Uoq8hVMH8VeFEzPldb2ejthASMdUzr75A
         PXHgSdLbsBIKFX6fu+qxZZyES8Xy0FytsGxtamM8TgV8y0Asb2X4EoI1EDIFyYkXP4F5
         tgrA==
X-Gm-Message-State: AOAM532FZKBgwY9vof3/jdVOwdKob8e1QCBWGO3LhHnVY6pAvcouAYWT
        eHzWtyqngIpOcx4kQ+8e9+y2VPbaW/SSzNSXaa0=
X-Google-Smtp-Source: ABdhPJwDD9q+evydM5JmAavC1Zqt3CVOe19TZwOLeuyYz1KIvKPky3ySacOGEqLKS13x8QwzEJXnWJG0Hg6o41n7+Kk=
X-Received: by 2002:a92:1a48:: with SMTP id z8mr5299188ill.95.1599686286899;
 Wed, 09 Sep 2020 14:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com>
 <20200909010118.GB6583@casper.infradead.org> <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
 <alpine.LSU.2.11.2009091100280.9020@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2009091100280.9020@eggly.anvils>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 9 Sep 2020 14:17:56 -0700
Message-ID: <CAKgT0Uc2T-M3hRW_crBTPKj4jbhizp49_ceamS_WGiXLdBdMfw@mail.gmail.com>
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
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

On Wed, Sep 9, 2020 at 11:24 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 9 Sep 2020, Alexander Duyck wrote:
> > On Tue, Sep 8, 2020 at 6:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Mon, Aug 24, 2020 at 08:55:04PM +0800, Alex Shi wrote:
> > > > +++ b/mm/vmscan.c
> > > > @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
> > > >
> > > >                       if (!TestClearPageLRU(page)) {
> > > >                               /*
> > > > -                              * This page may in other isolation path,
> > > > -                              * but we still hold lru_lock.
> > > > +                              * This page is being isolated in another
> > > > +                              * thread, but we still hold lru_lock. The
> > > > +                              * other thread must be holding a reference
> > > > +                              * to the page so this should never hit a
> > > > +                              * reference count of 0.
> > > >                                */
> > > > -                             put_page(page);
> > > > +                             WARN_ON(put_page_testzero(page));
> > > >                               goto busy;
> > >
> > > I read Hugh's review and that led me to take a look at this.  We don't
> > > do it like this.  Use the same pattern as elsewhere in mm:
> > >
> > >         page_ref_sub(page, nr);
> > >         VM_BUG_ON_PAGE(page_count(page) <= 0, page);
> > >
> > >
> >
> > Actually for this case page_ref_dec(page) would make more sense
> > wouldn't it? Otherwise I agree that would be a better change if that
> > is the way it has been handled before. I just wasn't familiar with
> > those other spots.
>
> After overnight reflection, my own preference would be simply to
> drop this patch.  I think we are making altogether too much of a
> fuss here over what was simply correct as plain put_page()
> (and further from correct if we change it to leak the page in an
> unforeseen circumstance).
>
> And if Alex's comment was not quite grammatically correct, never mind,
> it said as much as was worth saying.  I got more worried by his
> placement of the "busy:" label, but that does appear to work correctly.
>
> There's probably a thousand places where put_page() is used, where
> it would be troublesome if it were the final put_page(): this one
> bothered you because you'd been looking at isolate_migratepages_block(),
> and its necessary avoidance of lru_lock recursion on put_page();
> but let's just just leave this put_page() as is.

I'd be fine with that, but I would still like to see the comment
updated. At a minimum we should make it clear that we believe that
put_page is safe here as it should never reach zero and if it does
then we are looking at a bug. Then if this starts triggering soft
lockups  we at least have documentation somewhere that someone can
reference on what we expected and why we triggered a lockup.

- Alex
