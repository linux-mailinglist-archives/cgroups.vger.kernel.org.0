Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C115B34A6E0
	for <lists+cgroups@lfdr.de>; Fri, 26 Mar 2021 13:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCZMI4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Mar 2021 08:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCZMIj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Mar 2021 08:08:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4EC0613B1;
        Fri, 26 Mar 2021 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6CNIiT7q+Ups+0Vc8DJQD9WSyDH1NQMZhuJ6B6CQvG0=; b=AErjpU/dIo4bIDLo86LL6AWQL2
        HyE8BVIZTayV2FqKgSgtRiLrJF/00Hm954Qx1zGZnzw/zMfyyN4EMfyFqq9MfwZIZNya2ibjjkmQb
        1dxMOwVOpBScbtr1f4cJaxnSHm3hvyW3qOTGsuXkoQ6zSGilHwK5VhPAfCiRRrdkk/LW3cvrMs+KJ
        KZOLms9/Wv+Wi22Un8X4Bs+JyeK3GiBEm/99pWtCepRYXol+0gisuuaJ5XzkaNDGgktER4R5wf9j1
        XrH7alkNmm2/q8hNsInB6CHqj7TbsaaqibnOxe37+AbIWuDgWGwSkKiOSwJaDN9Qa/rwkO9q8NdH9
        6yRI+fyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPlFg-00Eljt-Pn; Fri, 26 Mar 2021 12:07:48 +0000
Date:   Fri, 26 Mar 2021 12:07:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
Message-ID: <20210326120744.GD1719932@casper.infradead.org>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2103191814040.1043@eggly.anvils>
 <YFo7SOni0s0TbXUm@cmpxchg.org>
 <alpine.LSU.2.11.2103231310020.5513@eggly.anvils>
 <alpine.LSU.2.11.2103251716160.12404@eggly.anvils>
 <20210326025143.GB1719932@casper.infradead.org>
 <alpine.LSU.2.11.2103252018170.13067@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103252018170.13067@eggly.anvils>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 25, 2021 at 09:04:40PM -0700, Hugh Dickins wrote:
> On Fri, 26 Mar 2021, Matthew Wilcox wrote:
> > On Thu, Mar 25, 2021 at 06:55:42PM -0700, Hugh Dickins wrote:
> > > The first reason occurred to me this morning.  I thought I had been
> > > clever to spot the PageHead race which you fix here.  But now I just feel
> > > very stupid not to have spotted the very similar memcg_data race.  The
> > > speculative racer may call mem_cgroup_uncharge() from __put_single_page(),
> > > and the new call to split_page_memcg() do nothing because page_memcg(head)
> > > is already NULL.
> > > 
> > > And is it even safe there, to sprinkle memcg_data through all of those
> > > order-0 subpages, when free_the_page() is about to be applied to a
> > > series of descending orders?  I could easily be wrong, but I think
> > > free_pages_prepare()'s check_free_page() will find that is not
> > > page_expected_state().

I forgot to say earlier; I did add a test (lib/test_free_pages.c).
Doubling it up to check GFP_KERNEL | GFP_ACCOUNT and GFP_KERNEL |
GFP_COMP | GFP_ACCOUNT should be reasonable.

> > So back to something more like my original patch then?
> > 
> > +++ b/mm/page_alloc.c
> > @@ -5081,9 +5081,15 @@ void __free_pages(struct page *page, unsigned int order)
> >  {
> >         if (put_page_testzero(page))
> >                 free_the_page(page, order);
> > -	else if (!PageHead(page))
> > -               while (order-- > 0)
> > -                       free_the_page(page + (1 << order), order);
> > +       else if (!PageHead(page)) {
> > +               while (order-- > 0) {
> > +                       struct page *tail = page + (1 << order);
> > +#ifdef CONFIG_MEMCG
> > +                       tail->memcg_data = page->memcg_data;
> > +#endif
> > +                       free_the_page(tail, order);
> > +               }
> > +       }
> >  }
> >  EXPORT_SYMBOL(__free_pages);
> > 
> > We can cache page->memcg_data before calling put_page_testzero(),
> > just like we cache the Head flag in Johannes' patch.
> 
> If I still believed in e320d3012d25, yes, that would look right
> (but I don't have much faith in my judgement after all this).
> 
> I'd fallen in love with split_page_memcg() when you posted that
> one, and was put off by your #ifdef, so got my priorities wrong
> and went for the split_page_memcg().

Oh, the ifdef was just a strawman.  I wouldn't want to see that upstream;
something like:

	unsigned long memcg_data = __get_memcg_data(page);
...
			__set_memcg_data(tail, memcg_data);

with the appropriate ifdefs hidden in memcontrol.h would be my preference.

> > > But, after all that, I'm now thinking that Matthew's original
> > > e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages")
> > > is safer reverted.  The put_page_testzero() in __free_pages() was
> > > not introduced for speculative pagecache: it was there in 2.4.0,
> > > and atomic_dec_and_test() in 2.2, I don't have older trees to hand.
> > 
> > I think you're confused in that last assertion.  According to
> > linux-fullhistory, the first introduction of __free_pages was 2.3.29pre3
> > (September 1999), where it did indeed use put_page_testzero:
> 
> Not confused, just pontificating from a misleading subset of the data.
> I knew there's an even-more-history-than-tglx git tree somewhere, but
> what I usually look back to is 2.4 trees, plus a 2.2.26 tree - but of
> course that's a late 2.2, from 2004, around the same time as 2.6.3.

I suspect it got backported ...
https://github.com/mpe/linux-fullhistory/wiki is what I'm using for my
archaeology, and it doesn't have the stable branches (1.0, 1.2, 2.0,
2.2, 2.4), so I don't know for sure.

Anyway, my point is that the truly ancient drivers *don't* depend on this
behaviour because the function didn't even exist when they were written.

