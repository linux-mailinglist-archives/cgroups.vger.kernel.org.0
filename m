Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C62633A1
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgIIRIE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgIIRHv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 13:07:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00DC061573;
        Wed,  9 Sep 2020 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BdBPXJ8XQ6dfeqF8dncKUjTFopmPuRS/B/dl8JZcac=; b=hfgEADwyatdZgRCv4HedPewUgr
        Z5yHyqRWXGgLxnBngNkckmik9vLonqHLyt6/X2g0X64afWCiiVrXixO7LMWLj5L65iwEQ04DOAIqW
        W0pR5PZbCGyIMkEO713IdjH8mBkU/FmFPGEWPXSQ4hC6jURyfYG6idODxcWpMgdxyrIgUHxZBlLv9
        +8rLnXwL1R7IW/voe+UYGk6bwztj7l+VQpqkLfxrHU10aEcahIA7WaxW486c2weui77TBhr9DECJ7
        R9nMf6JsMmQTjIHXKEcHK0QPRg1x8DKJJ+iB4U2GbKJNdRsI07LfPl3hXVGRn45fFkhqn6+2MIZzs
        Xi+cpe4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kG3Yz-0008CM-44; Wed, 09 Sep 2020 17:07:17 +0000
Date:   Wed, 9 Sep 2020 18:07:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
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
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
Message-ID: <20200909170717.GK6583@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com>
 <20200909010118.GB6583@casper.infradead.org>
 <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 09, 2020 at 08:43:38AM -0700, Alexander Duyck wrote:
> On Tue, Sep 8, 2020 at 6:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 08:55:04PM +0800, Alex Shi wrote:
> > > +++ b/mm/vmscan.c
> > > @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
> > >
> > >                       if (!TestClearPageLRU(page)) {
> > >                               /*
> > > -                              * This page may in other isolation path,
> > > -                              * but we still hold lru_lock.
> > > +                              * This page is being isolated in another
> > > +                              * thread, but we still hold lru_lock. The
> > > +                              * other thread must be holding a reference
> > > +                              * to the page so this should never hit a
> > > +                              * reference count of 0.
> > >                                */
> > > -                             put_page(page);
> > > +                             WARN_ON(put_page_testzero(page));
> > >                               goto busy;
> >
> > I read Hugh's review and that led me to take a look at this.  We don't
> > do it like this.  Use the same pattern as elsewhere in mm:
> >
> >         page_ref_sub(page, nr);
> >         VM_BUG_ON_PAGE(page_count(page) <= 0, page);
> 
> Actually for this case page_ref_dec(page) would make more sense
> wouldn't it? Otherwise I agree that would be a better change if that
> is the way it has been handled before. I just wasn't familiar with
> those other spots.

Yes, page_ref_dec() should be fine.  It's hard to remember which of
VM_BUG_ON, WARN_ON, etc, compile down to nothing with various CONFIG
options, and which ones actually evalauate their arguments.  Safer not
to put things with side-effects inside macros.
