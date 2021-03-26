Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82A349F3B
	for <lists+cgroups@lfdr.de>; Fri, 26 Mar 2021 02:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhCZB4Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 21:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCZBz5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 21:55:57 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE68C06174A
        for <cgroups@vger.kernel.org>; Thu, 25 Mar 2021 18:55:56 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t5so2233903qvs.5
        for <cgroups@vger.kernel.org>; Thu, 25 Mar 2021 18:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZvZ0RS30oAxTLDWRkfqE/2UEJY6hgUZS7U8cJyx4zLY=;
        b=gyRHPbPgpyrmyP7q7H1xnW9kekZkeD2scJjWrijqz9tR9VgWop6RmZNIwDMI4yG7cn
         Q0rK2u3XBKItnj1+UZd+C+qLWkzvPrIeICeY0Ee9WBDWJiMH+iqPVqDaaBy6F5ddAQxb
         +tw/1SxSYWNkvdSPaLz4M/yqNGhJ4XQS22oJlBcXmIWWEcLg1cPotmBtQNL+aURpfjSe
         qZOo3xJWH+7TbPr6GvF7OSOEyyLpUTHDES+WHxjRmelNrkyNhI+Thv1D9lestAosK297
         sLGaOuufx0zQfPXxzCVdzpmM0SKOv6VjOKLYfoK488ehJdEiwEmcJRhuIsN61nNB6WS5
         8pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZvZ0RS30oAxTLDWRkfqE/2UEJY6hgUZS7U8cJyx4zLY=;
        b=ehVIZqoB98DBRurAVeA1jfQfZoHdTARtm/2YkX7Isb0GsqbccNPlqIG5IO64bsNgIG
         q1t834nmUdo2QHyOh2Yd+qfpCQb+nS563tV0KPoZO5sJMWftr/kFyx3ut2Rqd9Iq3YDT
         cBbQeiRq0U9ZiuszsoN0BLHEsmbLaUQTP+uHGh43vdaI5gQXqGm/nbG1chGp7I7CTxUT
         d3QSPMSd1SorJFqx7sROVQH4nuEvGIdBzvmncS3n+oKw6ALK8n+0MxRf0P4GVSEo7eKO
         3ht+KHuyRBzK42MhD3ZbHmAk+eAgavJP+J9bkaNc2n3+eilwQNXzkIRuMSNsihWjNHve
         xwzw==
X-Gm-Message-State: AOAM533v75XlLxCeMzQgvXfO16m7P49iNyz84I+Y91dgxS3LG1KgRjWp
        9BtMdNk64otJTbnw5viWVddcTA==
X-Google-Smtp-Source: ABdhPJx7yLX43m7Leb/Cq6Dq+IZjqJSU+96hAKVSUgrnc277qfH2DVpJwvgHr/8/AiG+PWolHhr3oQ==
X-Received: by 2002:a0c:9ad7:: with SMTP id k23mr11022719qvf.52.1616723755786;
        Thu, 25 Mar 2021 18:55:55 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l129sm5579562qkd.76.2021.03.25.18.55.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Mar 2021 18:55:55 -0700 (PDT)
Date:   Thu, 25 Mar 2021 18:55:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
In-Reply-To: <alpine.LSU.2.11.2103231310020.5513@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2103251716160.12404@eggly.anvils>
References: <20210319071547.60973-1-hannes@cmpxchg.org> <alpine.LSU.2.11.2103191814040.1043@eggly.anvils> <YFo7SOni0s0TbXUm@cmpxchg.org> <alpine.LSU.2.11.2103231310020.5513@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 23 Mar 2021, Hugh Dickins wrote:
> On Tue, 23 Mar 2021, Johannes Weiner wrote:
> > From f6f062a3ec46f4fb083dcf6792fde9723f18cfc5 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Fri, 19 Mar 2021 02:17:00 -0400
> > Subject: [PATCH] mm: page_alloc: fix allocation imbalances from speculative
> >  cache lookup
> > 
> > When the freeing of a higher-order page block (non-compound) races
> > with a speculative page cache lookup, __free_pages() needs to leave
> > the first order-0 page in the chunk to the lookup but free the buddy
> > pages that the lookup doesn't know about separately.
> > 
> > There are currently two problems with it:
> > 
> > 1. It checks PageHead() to see whether we're dealing with a compound
> >    page after put_page_testzero(). But the speculative lookup could
> >    have freed the page after our put and cleared PageHead, in which
> >    case we would double free the tail pages.
> > 
> >    To fix this, test PageHead before the put and cache the result for
> >    afterwards.
> > 
> > 2. If such a higher-order page is charged to a memcg (e.g. !vmap
> >    kernel stack)), only the first page of the block has page->memcg
> >    set. That means we'll uncharge only one order-0 page from the
> >    entire block, and leak the remainder.
> > 
> >    To fix this, add a split_page_memcg() before it starts freeing tail
> >    pages, to ensure they all have page->memcg set up.
> > 
> > While at it, also update the comments a bit to clarify what exactly is
> > happening to the page during that race.
> > 
> > Fixes: e320d3012d25 mm/page_alloc.c: fix freeing non-compound pages

Whoops, misses ("...") around the title.

> > Reported-by: Hugh Dickins <hughd@google.com>
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: <stable@vger.kernel.org> # 5.10+
> 
> This is great, thanks Hannes.
> Acked-by: Hugh Dickins <hughd@google.com>

Sorry, I am ashamed to do this, but now I renege and say NAK:
better now than before Andrew picks it up.

The first reason occurred to me this morning.  I thought I had been
clever to spot the PageHead race which you fix here.  But now I just feel
very stupid not to have spotted the very similar memcg_data race.  The
speculative racer may call mem_cgroup_uncharge() from __put_single_page(),
and the new call to split_page_memcg() do nothing because page_memcg(head)
is already NULL.

And is it even safe there, to sprinkle memcg_data through all of those
order-0 subpages, when free_the_page() is about to be applied to a
series of descending orders?  I could easily be wrong, but I think
free_pages_prepare()'s check_free_page() will find that is not
page_expected_state().

And what gets to do the uncharging when memcg_data is properly set
on the appropriate order-N subpages?  I believe it's the (second)
__memcg_kmem_uncharge_page() in free_pages_prepare(), but that's
only called if PageMemcgKmem().  Ah, good, Roman's changes have put
that flag into memcg_data, so it will automatically be set: but this
patch will not port back to 5.10 without some addition.

But, after all that, I'm now thinking that Matthew's original
e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages")
is safer reverted.  The put_page_testzero() in __free_pages() was
not introduced for speculative pagecache: it was there in 2.4.0,
and atomic_dec_and_test() in 2.2, I don't have older trees to hand.

So, it has "always" been accepted that multiple references to a
high-order non-compound page can be given out and released: maybe
they were all released with __free_pages() of the right order, or
maybe only the last had to get that right; but as __free_pages()
stands today, all but the last caller frees all but the first
subpage.  A very rare leak seems much safer.

I don't have the answer (find somewhere in struct page to squirrel
away the order, even when it's a non-compound page?), and I think
each of us would much rather be thinking about other things at the
moment.  But for now it looks to me like NAK to this patch, and
revert of e320d3012d25.

> 
> I know that 5.10-stable rejected the two split_page_memcg() patches:
> we shall need those in, I'll send GregKH the fixups, but not today.

Done, and Sasha has picked them up.  But in writing that "Ah, good,
Roman's changes ..." paragraph, I've begun to wonder if what I sent
was complete - does a 5.10 split_page_memcg(), when called from
split_page(), also need to copy head's PageKmemcg? I rather think
yes, but by now I'm unsure of everything...

Hugh

> 
> > ---
> >  mm/page_alloc.c | 41 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c53fe4fa10bf..8aab1e87fa3c 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5112,10 +5112,9 @@ static inline void free_the_page(struct page *page, unsigned int order)
> >   * the allocation, so it is easy to leak memory.  Freeing more memory
> >   * than was allocated will probably emit a warning.
> >   *
> > - * If the last reference to this page is speculative, it will be released
> > - * by put_page() which only frees the first page of a non-compound
> > - * allocation.  To prevent the remaining pages from being leaked, we free
> > - * the subsequent pages here.  If you want to use the page's reference
> > + * This function isn't a put_page(). Don't let the put_page_testzero()
> > + * fool you, it's only to deal with speculative cache references. It
> > + * WILL free pages directly. If you want to use the page's reference
> >   * count to decide when to free the allocation, you should allocate a
> >   * compound page, and use put_page() instead of __free_pages().
> >   *
> > @@ -5124,11 +5123,41 @@ static inline void free_the_page(struct page *page, unsigned int order)
> >   */
> >  void __free_pages(struct page *page, unsigned int order)
> >  {
> > -	if (put_page_testzero(page))
> > +	bool compound = PageHead(page);
> > +
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
> > +	 * Ok, the speculative reference will put and free the page.
> > +	 *
> > +	 * - If this was an order-0 page, we're done.
> > +	 *
> > +	 * - If the page was compound, the other side will free the
> > +	 *   entire page and we're done here as well. Just note that
> > +	 *   freeing clears PG_head, so it can only be read reliably
> > +	 *   before the put_page_testzero().
> > +	 *
> > +	 * - If the page was of higher order but NOT marked compound,
> > +	 *   the other side will know nothing about our buddy pages
> > +	 *   and only free the order-0 page at the start of our block.
> > +	 *   We must split off and free the buddy pages here.
> > +	 *
> > +	 *   The buddy pages aren't individually refcounted, so they
> > +	 *   can't have any pending speculative references themselves.
> > +	 */
> > +	if (order > 0 && !compound) {
> > +		split_page_memcg(page, 1 << order);
> >  		while (order-- > 0)
> >  			free_the_page(page + (1 << order), order);
> > +	}
> >  }
> >  EXPORT_SYMBOL(__free_pages);
> >  
> > -- 
> > 2.31.0
