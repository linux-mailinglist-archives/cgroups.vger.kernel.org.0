Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E415343D50
	for <lists+cgroups@lfdr.de>; Mon, 22 Mar 2021 10:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVJ4H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Mar 2021 05:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhCVJzt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Mar 2021 05:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616406947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/2ozR1dCacTTh1U7cY+Z5HNl+3fI6dqE+W2ZDjDPYM=;
        b=Z6gyafmxwULS2CLLmU6+9rxjA+6VdYu/ZVVzqZlu7ZW2khYcqWt3VZyW5URwptKGH6FfHt
        sOevZnUMpkVLYHYkXIePZhVkyMlsMuiNktVNXkSE6PL2a/NmVOtnGSkGFZjvGIPtrfHSNB
        S8V4aYfbUQ73RzmerBVBOySZw2B6MjI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 817FFAD38;
        Mon, 22 Mar 2021 09:55:47 +0000 (UTC)
Date:   Mon, 22 Mar 2021 10:55:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
Message-ID: <YFhpkrK7MZ1mDQhi@dhcp22.suse.cz>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319071547.60973-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 19-03-21 03:15:47, Johannes Weiner wrote:
> When the freeing of a higher-order page block (non-compound) races
> with a speculative page cache lookup, __free_pages() needs to leave
> the first order-0 page in the chunk to the lookup but free the buddy
> pages that the lookup doesn't know about separately.
> 
> However, if such a higher-order page is charged to a memcg (e.g. !vmap
> kernel stack)), only the first page of the block has page->memcg
> set. That means we'll uncharge only one order-0 page from the entire
> block, and leak the remainder.
> 
> Add a split_page_memcg() to __free_pages() right before it starts
> taking the higher-order page apart and freeing its individual
> constituent pages. This ensures all of them will have the memcg
> linkage set up for correct uncharging. Also update the comments a bit
> to clarify what exactly is happening to the page during that race.
> 
> This bug is old and has its roots in the speculative page cache patch
> and adding cgroup accounting of kernel pages. There are no known user
> reports. A backport to stable is therefor not warranted.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_alloc.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c53fe4fa10bf..f4bd56656402 100644
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
> @@ -5124,11 +5123,33 @@ static inline void free_the_page(struct page *page, unsigned int order)
>   */
>  void __free_pages(struct page *page, unsigned int order)
>  {
> -	if (put_page_testzero(page))
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
> +	 * The speculative reference will put and free the page.
> +	 *
> +	 * However, if the speculation was into a higher-order page
> +	 * chunk that isn't marked compound, the other side will know
> +	 * nothing about our buddy pages and only free the order-0
> +	 * page at the start of our chunk! We must split off and free
> +	 * the buddy pages here.
> +	 *
> +	 * The buddy pages aren't individually refcounted, so they
> +	 * can't have any pending speculative references themselves.
> +	 */
> +	if (!PageHead(page) && order > 0) {
> +		split_page_memcg(page, 1 << order);
>  		while (order-- > 0)
>  			free_the_page(page + (1 << order), order);
> +	}
>  }
>  EXPORT_SYMBOL(__free_pages);
>  
> -- 
> 2.30.1
> 

-- 
Michal Hocko
SUSE Labs
