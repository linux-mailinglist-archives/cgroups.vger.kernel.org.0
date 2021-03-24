Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0234740C
	for <lists+cgroups@lfdr.de>; Wed, 24 Mar 2021 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhCXI6W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Mar 2021 04:58:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233814AbhCXI6R (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Mar 2021 04:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616576296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVzLgWjtMsEMunfCiqO/qhbiIn6Lcs5ezaAhMGPZ5v0=;
        b=jdR+KJoW214iwOHGKwl3IMT3Tz2nzV3xPjRwYZJPW6Kfw4XyJ+08DLqMLUSe/bcOrxuHHf
        zRnpGguit6cAg7MMNs0CR6V2N9XtBRPVTdpKn9lQZk7Prx9aBAKKVGRD1VIIHoSh+i0QcK
        Yiu9zs0obzcn0PUNwNZoPedEQgUobN8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37766AC16;
        Wed, 24 Mar 2021 08:58:16 +0000 (UTC)
Date:   Wed, 24 Mar 2021 09:58:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
Message-ID: <YFr/IdkW42GtVXk3@dhcp22.suse.cz>
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

On Tue 23-03-21 15:02:32, Johannes Weiner wrote:
[...]
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

Normally I would argue for one fix per patch but considering we need
both anyway then squashing is fine. Especially with the above
explanation. Thanks for updated comments it made it much clear what the
speculative path is doing. I was quite confused about the whole thing
earlier.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_alloc.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c53fe4fa10bf..8aab1e87fa3c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5112,10 +5112,9 @@ static inline void free_the_page(struct page *page, unsigned int order)
>   * the allocation, so it is easy to leak memory.  Freeing more memory
>   * than was allocated will probably emit a warning.
>   *
> - * If the last reference to this page is speculative, it will be released
> - * by put_page() which only frees the first page of a non-compound
> - * allocation.  To prevent the remaining pages from being leaked, we free
> - * the subsequent pages here.  If you want to use the page's reference
> + * This function isn't a put_page(). Don't let the put_page_testzero()
> + * fool you, it's only to deal with speculative cache references. It
> + * WILL free pages directly. If you want to use the page's reference
>   * count to decide when to free the allocation, you should allocate a
>   * compound page, and use put_page() instead of __free_pages().
>   *
> @@ -5124,11 +5123,41 @@ static inline void free_the_page(struct page *page, unsigned int order)
>   */
>  void __free_pages(struct page *page, unsigned int order)
>  {
> -	if (put_page_testzero(page))
> +	bool compound = PageHead(page);
> +
> +	/*
> +	 * Drop the base reference from __alloc_pages and free. In
> +	 * case there is an outstanding speculative reference, from
> +	 * e.g. the page cache, it will put and free the page later.
> +	 */
> +	if (likely(put_page_testzero(page))) {
>  		free_the_page(page, order);
> -	else if (!PageHead(page))
> +		return;
> +	}
> +
> +	/*
> +	 * Ok, the speculative reference will put and free the page.
> +	 *
> +	 * - If this was an order-0 page, we're done.
> +	 *
> +	 * - If the page was compound, the other side will free the
> +	 *   entire page and we're done here as well. Just note that
> +	 *   freeing clears PG_head, so it can only be read reliably
> +	 *   before the put_page_testzero().
> +	 *
> +	 * - If the page was of higher order but NOT marked compound,
> +	 *   the other side will know nothing about our buddy pages
> +	 *   and only free the order-0 page at the start of our block.
> +	 *   We must split off and free the buddy pages here.
> +	 *
> +	 *   The buddy pages aren't individually refcounted, so they
> +	 *   can't have any pending speculative references themselves.
> +	 */
> +	if (order > 0 && !compound) {
> +		split_page_memcg(page, 1 << order);
>  		while (order-- > 0)
>  			free_the_page(page + (1 << order), order);
> +	}
>  }
>  EXPORT_SYMBOL(__free_pages);
>  
> -- 
> 2.31.0

-- 
Michal Hocko
SUSE Labs
