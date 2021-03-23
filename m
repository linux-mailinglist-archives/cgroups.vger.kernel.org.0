Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C063468AE
	for <lists+cgroups@lfdr.de>; Tue, 23 Mar 2021 20:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCWTOS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Mar 2021 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhCWTNv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Mar 2021 15:13:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E9C061574;
        Tue, 23 Mar 2021 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Z0WR90dUR0c8O+Ghca91EEE7yMOJD4p7F63jROsdls=; b=icwXA+ar6ra1hlZuLW8OIAW/xA
        Al6ajurXvvGV5WRst3/GGWSzOnrYZVZxCEGKJJIfB+dSF6BTOK/h2cq2ZNrN63RLBMDS5SJa0lyVa
        70IUsot7vahFotNehhva+olPZZvTW9kdHQV2eow5ow70SvWHCFw7jccUWSR9DWW/w1nAn8yp722if
        SzWGyP9sID4+6Mok1PhDAgaltHLzi8Jvq+1z5zDDb2jSWHgepVc2LUd8+iDOevZ2mlJjixvigzj9t
        Ks7n+MJKAtADgkGQe5lMRhd6cGrCLUdiDzYHRWAnjAC6lseavVVdsAMGIgXEA4bQumWAfNpZFKNbw
        TprxQfoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOmRj-00ARsu-4J; Tue, 23 Mar 2021 19:12:20 +0000
Date:   Tue, 23 Mar 2021 19:12:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
Message-ID: <20210323191207.GJ1719932@casper.infradead.org>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2103191814040.1043@eggly.anvils>
 <YFo7SOni0s0TbXUm@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFo7SOni0s0TbXUm@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 23, 2021 at 03:02:32PM -0400, Johannes Weiner wrote:
> >From f6f062a3ec46f4fb083dcf6792fde9723f18cfc5 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 19 Mar 2021 02:17:00 -0400
> Subject: [PATCH] mm: page_alloc: fix allocation imbalances from speculative
>  cache lookup
> 
> When the freeing of a higher-order page block (non-compound) races
> with a speculative page cache lookup, __free_pages() needs to leave
> the first order-0 page in the chunk to the lookup but free the buddy
> pages that the lookup doesn't know about separately.
> 
> There are currently two problems with it:
> 
> 1. It checks PageHead() to see whether we're dealing with a compound
>    page after put_page_testzero(). But the speculative lookup could
>    have freed the page after our put and cleared PageHead, in which
>    case we would double free the tail pages.
> 
>    To fix this, test PageHead before the put and cache the result for
>    afterwards.
> 
> 2. If such a higher-order page is charged to a memcg (e.g. !vmap
>    kernel stack)), only the first page of the block has page->memcg
>    set. That means we'll uncharge only one order-0 page from the
>    entire block, and leak the remainder.
> 
>    To fix this, add a split_page_memcg() before it starts freeing tail
>    pages, to ensure they all have page->memcg set up.
> 
> While at it, also update the comments a bit to clarify what exactly is
> happening to the page during that race.
> 
> Fixes: e320d3012d25 mm/page_alloc.c: fix freeing non-compound pages
> Reported-by: Hugh Dickins <hughd@google.com>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: <stable@vger.kernel.org> # 5.10+

This version makes me happy.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for fixing my buggy fix.
