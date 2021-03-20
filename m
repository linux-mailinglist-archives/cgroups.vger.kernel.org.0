Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE0342A2D
	for <lists+cgroups@lfdr.de>; Sat, 20 Mar 2021 04:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCTD0c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 23:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTD0c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 23:26:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F8C061761;
        Fri, 19 Mar 2021 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kEfEWIhBq2zE+HxZoC4lm1vNYaQCx2j9hxZ78LM+5kQ=; b=ZupSzN80E4VJvwrYB0bcCXNkhO
        Gkg0eqfi2txQszZAkHfFSsz1UHnKwTf1fAnSwtwkfpFDXo739+jczEndpqVQNiOeIS2g9F38+8N7E
        wMc7m4f7H73fzy6hV/cn5HnQ2Ix66O0q238F97ElkNDsvMRNYcpI5JGjruoPPkFE6vOb2qiH5f7/W
        IWLpUj1RXd9Sw1xbieBKa0cT179ibjAocvig7CKTih/ZVAF9V0FvyEa9r3u01r8Ntq6XbEo/8EIZE
        EI1VOmjECBLFc8nEyhtomT14d+WppGRt/ynK9qvjuNVdO5OsA6XhzvHCF5w6aIQMD4izMVhX8u7+m
        H2rpRYOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNSFQ-005Kxb-QF; Sat, 20 Mar 2021 03:25:58 +0000
Date:   Sat, 20 Mar 2021 03:25:56 +0000
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
Message-ID: <20210320032556.GD3420@casper.infradead.org>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2103191814040.1043@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103191814040.1043@eggly.anvils>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 06:52:58PM -0700, Hugh Dickins wrote:
> > +	/*
> > +	 * Drop the base reference from __alloc_pages and free. In
> > +	 * case there is an outstanding speculative reference, from
> > +	 * e.g. the page cache, it will put and free the page later.
> > +	 */
> > +	if (likely(put_page_testzero(page))) {
> >  		free_the_page(page, order);
> > -	else if (!PageHead(page))
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * The speculative reference will put and free the page.
> > +	 *
> > +	 * However, if the speculation was into a higher-order page
> > +	 * chunk that isn't marked compound, the other side will know
> > +	 * nothing about our buddy pages and only free the order-0
> > +	 * page at the start of our chunk! We must split off and free
> > +	 * the buddy pages here.
> > +	 *
> > +	 * The buddy pages aren't individually refcounted, so they
> > +	 * can't have any pending speculative references themselves.
> > +	 */
> > +	if (!PageHead(page) && order > 0) {
> 
> The put_page_testzero() has released our reference to the first
> subpage of page: it's now under the control of the racing speculative
> lookup.  So it seems to me unsafe to be checking PageHead(page) here:
> if it was actually a compound page, PageHead might already be cleared
> by now, and we doubly free its tail pages below?  I think we need to
> use a "bool compound = PageHead(page)" on entry to __free_pages().
> 
> Or alternatively, it's wrong to call __free_pages() on a compound
> page anyway, so we should not check PageHead at all, except in a
> WARN_ON_ONCE(PageCompound(page)) at the start?

Alas ...

$ git grep '__free_pages\>.*compound'
drivers/dma-buf/heaps/system_heap.c:            __free_pages(page, compound_order(page));
drivers/dma-buf/heaps/system_heap.c:            __free_pages(p, compound_order(p));
drivers/dma-buf/heaps/system_heap.c:            __free_pages(page, compound_order(page));
mm/huge_memory.c:               __free_pages(zero_page, compound_order(zero_page));
mm/huge_memory.c:               __free_pages(zero_page, compound_order(zero_page));
mm/slub.c:                      __free_pages(page, compound_order(page));

Maybe we should disallow it!

There are a few other places to check:

$ grep -l __GFP_COMP $(git grep -lw __free_pages) | wc -l
24

(assuming the pages are allocated and freed in the same file, which is a
reasonable approximation, but not guaranteed to catch everything.  Many
of these 24 will be false positives, of course.)
