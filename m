Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B279349FF2
	for <lists+cgroups@lfdr.de>; Fri, 26 Mar 2021 03:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCZCw7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 22:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhCZCw1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 22:52:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93EC06174A;
        Thu, 25 Mar 2021 19:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j0yXJ1+WE4VkDxmjzQaqjTpot8rkL4606fG9ZF6W9ek=; b=DnbaKodC7InpXKBwa/J3VzZTo/
        sZyQf6z6uHDgh8ud6JwPuQXpkB+p54c2q5a4OT9GamfHHicwYwR7796R3L0c+QV1HZGlbXFPdQ9T9
        J2k40pE/5jeV+XEW424SXtGRiZ2OH6NTeMUtxEvrk1FPbtUPJvEE8UUguLSGhJUHWFCvRMX1OChDE
        JjABgnP3XzCYGb38X/twcx4IzFl8dPka+ojqjD+qLrGyrjpk0uPU+4hV1fXOL9dRbeDHHy94Rg533
        8VhVll7kRXvuj4l1hCEgTo/8gnKEluJebWpFp7JndpDv9MOrZm8cBktoJBRfjVTsLXNqB92kcH5pO
        7hscQSpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPcZb-00EAw0-Ju; Fri, 26 Mar 2021 02:51:51 +0000
Date:   Fri, 26 Mar 2021 02:51:43 +0000
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
Message-ID: <20210326025143.GB1719932@casper.infradead.org>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2103191814040.1043@eggly.anvils>
 <YFo7SOni0s0TbXUm@cmpxchg.org>
 <alpine.LSU.2.11.2103231310020.5513@eggly.anvils>
 <alpine.LSU.2.11.2103251716160.12404@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103251716160.12404@eggly.anvils>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 25, 2021 at 06:55:42PM -0700, Hugh Dickins wrote:
> The first reason occurred to me this morning.  I thought I had been
> clever to spot the PageHead race which you fix here.  But now I just feel
> very stupid not to have spotted the very similar memcg_data race.  The
> speculative racer may call mem_cgroup_uncharge() from __put_single_page(),
> and the new call to split_page_memcg() do nothing because page_memcg(head)
> is already NULL.
> 
> And is it even safe there, to sprinkle memcg_data through all of those
> order-0 subpages, when free_the_page() is about to be applied to a
> series of descending orders?  I could easily be wrong, but I think
> free_pages_prepare()'s check_free_page() will find that is not
> page_expected_state().

So back to something more like my original patch then?

+++ b/mm/page_alloc.c
@@ -5081,9 +5081,15 @@ void __free_pages(struct page *page, unsigned int order)
 {
        if (put_page_testzero(page))
                free_the_page(page, order);
-	else if (!PageHead(page))
-               while (order-- > 0)
-                       free_the_page(page + (1 << order), order);
+       else if (!PageHead(page)) {
+               while (order-- > 0) {
+                       struct page *tail = page + (1 << order);
+#ifdef CONFIG_MEMCG
+                       tail->memcg_data = page->memcg_data;
+#endif
+                       free_the_page(tail, order);
+               }
+       }
 }
 EXPORT_SYMBOL(__free_pages);

We can cache page->memcg_data before calling put_page_testzero(),
just like we cache the Head flag in Johannes' patch.

> But, after all that, I'm now thinking that Matthew's original
> e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages")
> is safer reverted.  The put_page_testzero() in __free_pages() was
> not introduced for speculative pagecache: it was there in 2.4.0,
> and atomic_dec_and_test() in 2.2, I don't have older trees to hand.

I think you're confused in that last assertion.  According to
linux-fullhistory, the first introduction of __free_pages was 2.3.29pre3
(September 1999), where it did indeed use put_page_testzero:

+extern inline void __free_pages(struct page *page, unsigned long order)
+{
+       if (!put_page_testzero(page))
+               return;
+       __free_pages_ok(page, order);
+}

Before that, we had only free_pages() and __free_page().

> So, it has "always" been accepted that multiple references to a
> high-order non-compound page can be given out and released: maybe
> they were all released with __free_pages() of the right order, or
> maybe only the last had to get that right; but as __free_pages()
> stands today, all but the last caller frees all but the first
> subpage.  A very rare leak seems much safer.
> 
> I don't have the answer (find somewhere in struct page to squirrel
> away the order, even when it's a non-compound page?), and I think
> each of us would much rather be thinking about other things at the
> moment.  But for now it looks to me like NAK to this patch, and
> revert of e320d3012d25.

We did discuss that possibility prior to the introduction of
e320d3012d25.  Here's one such:
https://lore.kernel.org/linux-mm/20200922031215.GZ32101@casper.infradead.org/T/#m0b08c0c3430e09e20fa6648877dc42b04b18e6f3

