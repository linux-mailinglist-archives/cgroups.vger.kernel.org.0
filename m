Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0E346866
	for <lists+cgroups@lfdr.de>; Tue, 23 Mar 2021 20:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhCWTC7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Mar 2021 15:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhCWTCf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Mar 2021 15:02:35 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01380C061574
        for <cgroups@vger.kernel.org>; Tue, 23 Mar 2021 12:02:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f12so15779531qtq.4
        for <cgroups@vger.kernel.org>; Tue, 23 Mar 2021 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2NS3knvOsVC8w40oRTuJAV1fjp7aGSVyD5f77gkqujA=;
        b=yS6el+/OtIxurlpnOwHVJYnrbwKbkyYBMbMsL18oFonhgYPFzfpGanTtP6YNhIyUkf
         TEyNkeOkiDtVts7mqCYfAvg/Lg1EFX8JWMt7cPbFGO1hJH0owEWpRiNRK/S1wPWE36wh
         YmB0lud4tB4a6GgMDoQKYXdYjDxHDRhg0dMRIlyhbq36/lJ9LlZxuSk0h3h0v4ahykeZ
         yLwUdUlLL0sNwxT4MTWZwfAuV26ZsmKLPmRTM51g3XNTXtWgJyDHpNlqScOO6W4kvfTx
         xSJBP0N7kswDxh5FtjlrBso8m9S/JBCbqQd92QMlA6GKxAyd3aCIUmuPh7aKwCZeMrE4
         INDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2NS3knvOsVC8w40oRTuJAV1fjp7aGSVyD5f77gkqujA=;
        b=XRbAloTgYs1eHBhCJh/Rv2yiHidffdhubjHjRdA/M047YoBA/dOytkTKeCCcIHsdW6
         nfRMYmRSuARO9gAhWsppTD2vhFJhtkslln0Bu8ZQ6sU90msUie9iXB0WjT78/qv/mzas
         +CbRTk7/g8A3PjyjHBK/Qa0KB2FDSbyOHSJjlmWfHOApWWCOtMrGa87MHnOSd9/gAV9C
         4zm84QqGY88ZTnaLsz5gkRYutD3hxpc18NuzFDaY00TSMvoFYfVTyyk8yORb5gSTqu+H
         VxIVmBaxq+O+JmBEkzBeeixbzK/hgy0WBUeDh3XoApYXxA0yEWgBeGuhDSEZhcWU7f0C
         UFcg==
X-Gm-Message-State: AOAM5307Z4g02YjR6XbJ4IB3V8PNAigUjy3LqitQ/QyFINd8SI3QvhvR
        Q7fo+NW7AUXL6WOHWelCK4mj9g==
X-Google-Smtp-Source: ABdhPJzbiv3C1ZFr8v4W3JsU+Bf67Fc2zDpcWziC0UPGRKKj/5tbdoYGOS23mNhCfgvAssY9RkmMBg==
X-Received: by 2002:ac8:7215:: with SMTP id a21mr5870301qtp.199.1616526153240;
        Tue, 23 Mar 2021 12:02:33 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q2sm14075452qkq.59.2021.03.23.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 12:02:32 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:02:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
Message-ID: <YFo7SOni0s0TbXUm@cmpxchg.org>
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
> On Fri, 19 Mar 2021, Johannes Weiner wrote:
> 
> > When the freeing of a higher-order page block (non-compound) races
> > with a speculative page cache lookup, __free_pages() needs to leave
> > the first order-0 page in the chunk to the lookup but free the buddy
> > pages that the lookup doesn't know about separately.
> > 
> > However, if such a higher-order page is charged to a memcg (e.g. !vmap
> > kernel stack)), only the first page of the block has page->memcg
> > set. That means we'll uncharge only one order-0 page from the entire
> > block, and leak the remainder.
> > 
> > Add a split_page_memcg() to __free_pages() right before it starts
> > taking the higher-order page apart and freeing its individual
> > constituent pages. This ensures all of them will have the memcg
> > linkage set up for correct uncharging. Also update the comments a bit
> > to clarify what exactly is happening to the page during that race.
> > 
> > This bug is old and has its roots in the speculative page cache patch
> > and adding cgroup accounting of kernel pages. There are no known user
> > reports. A backport to stable is therefor not warranted.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> to the split_page_memcg() addition etc, but a doubt just hit me on the
> original e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages"):
> see comment below.
> 
> > ---
> >  mm/page_alloc.c | 33 +++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c53fe4fa10bf..f4bd56656402 100644
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
> > @@ -5124,11 +5123,33 @@ static inline void free_the_page(struct page *page, unsigned int order)
> >   */
> >  void __free_pages(struct page *page, unsigned int order)
> >  {
> > -	if (put_page_testzero(page))
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

That's a good point.

> And would it be wrong to fix that too in this patch?

All aboard the mm-page_alloc-fix-stuff.patch!

No, I think it's fine to sqash them and treat it as a supplement to
Matthew's original patch (although technically it didn't make the
memcg leak any worse).

> Though it ought then to be backported to 5.10 stable.

Sounds good. It depends on split_page_memcg(), but that patch is
straight-forward enough to backport as well.

---

From f6f062a3ec46f4fb083dcf6792fde9723f18cfc5 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 19 Mar 2021 02:17:00 -0400
Subject: [PATCH] mm: page_alloc: fix allocation imbalances from speculative
 cache lookup

When the freeing of a higher-order page block (non-compound) races
with a speculative page cache lookup, __free_pages() needs to leave
the first order-0 page in the chunk to the lookup but free the buddy
pages that the lookup doesn't know about separately.

There are currently two problems with it:

1. It checks PageHead() to see whether we're dealing with a compound
   page after put_page_testzero(). But the speculative lookup could
   have freed the page after our put and cleared PageHead, in which
   case we would double free the tail pages.

   To fix this, test PageHead before the put and cache the result for
   afterwards.

2. If such a higher-order page is charged to a memcg (e.g. !vmap
   kernel stack)), only the first page of the block has page->memcg
   set. That means we'll uncharge only one order-0 page from the
   entire block, and leak the remainder.

   To fix this, add a split_page_memcg() before it starts freeing tail
   pages, to ensure they all have page->memcg set up.

While at it, also update the comments a bit to clarify what exactly is
happening to the page during that race.

Fixes: e320d3012d25 mm/page_alloc.c: fix freeing non-compound pages
Reported-by: Hugh Dickins <hughd@google.com>
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org> # 5.10+
---
 mm/page_alloc.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c53fe4fa10bf..8aab1e87fa3c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5112,10 +5112,9 @@ static inline void free_the_page(struct page *page, unsigned int order)
  * the allocation, so it is easy to leak memory.  Freeing more memory
  * than was allocated will probably emit a warning.
  *
- * If the last reference to this page is speculative, it will be released
- * by put_page() which only frees the first page of a non-compound
- * allocation.  To prevent the remaining pages from being leaked, we free
- * the subsequent pages here.  If you want to use the page's reference
+ * This function isn't a put_page(). Don't let the put_page_testzero()
+ * fool you, it's only to deal with speculative cache references. It
+ * WILL free pages directly. If you want to use the page's reference
  * count to decide when to free the allocation, you should allocate a
  * compound page, and use put_page() instead of __free_pages().
  *
@@ -5124,11 +5123,41 @@ static inline void free_the_page(struct page *page, unsigned int order)
  */
 void __free_pages(struct page *page, unsigned int order)
 {
-	if (put_page_testzero(page))
+	bool compound = PageHead(page);
+
+	/*
+	 * Drop the base reference from __alloc_pages and free. In
+	 * case there is an outstanding speculative reference, from
+	 * e.g. the page cache, it will put and free the page later.
+	 */
+	if (likely(put_page_testzero(page))) {
 		free_the_page(page, order);
-	else if (!PageHead(page))
+		return;
+	}
+
+	/*
+	 * Ok, the speculative reference will put and free the page.
+	 *
+	 * - If this was an order-0 page, we're done.
+	 *
+	 * - If the page was compound, the other side will free the
+	 *   entire page and we're done here as well. Just note that
+	 *   freeing clears PG_head, so it can only be read reliably
+	 *   before the put_page_testzero().
+	 *
+	 * - If the page was of higher order but NOT marked compound,
+	 *   the other side will know nothing about our buddy pages
+	 *   and only free the order-0 page at the start of our block.
+	 *   We must split off and free the buddy pages here.
+	 *
+	 *   The buddy pages aren't individually refcounted, so they
+	 *   can't have any pending speculative references themselves.
+	 */
+	if (order > 0 && !compound) {
+		split_page_memcg(page, 1 << order);
 		while (order-- > 0)
 			free_the_page(page + (1 << order), order);
+	}
 }
 EXPORT_SYMBOL(__free_pages);
 
-- 
2.31.0

