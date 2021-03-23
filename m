Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0634699B
	for <lists+cgroups@lfdr.de>; Tue, 23 Mar 2021 21:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCWUK7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Mar 2021 16:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhCWUKb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Mar 2021 16:10:31 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C8C061763
        for <cgroups@vger.kernel.org>; Tue, 23 Mar 2021 13:10:30 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso20724013oti.11
        for <cgroups@vger.kernel.org>; Tue, 23 Mar 2021 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LyHHHSMLFWUeygbV2lU1XgcbhGu+fq/FJm7L8suyFsw=;
        b=pvagIcQfYI9eLKjZ4QGl1Q2Bs9IeTWQSzIY6slDMNYWnvJgF2c8mi2N4adhgHTzfqI
         /SNzU3qxYr1u9PIVkoQXXT7forjchfGfPxahqRaF3+ZItU2zsI6f3QdO1n4dctmeCKTG
         j7UGWys7lo5BpZ6hIiCWZZVycs7TH/l7dQDjs7C2SpHo7lVOrTjJYNGs/umOCg8DgsiQ
         h2RY+s+2k3XdtBv7oi+A3xGCnDCSeyVZ/jRJUxwEGLA8P+7toCLU8fYVOG+mn5vcAb9g
         DhJcA5BFdHDotGdShY6zhZyAGHIJdEwNsR+jln4otYC6raSVzSXjkuAyCPKcfVOOTV/2
         DpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LyHHHSMLFWUeygbV2lU1XgcbhGu+fq/FJm7L8suyFsw=;
        b=uD3vV5JYjoZqRNSogitKNjsx+dd3QSV3Pi2JHBVCDLCxDhT0jSXuCO4anTfg7ugvqQ
         LjV72RGUOAeuFlgdVaU1N/X9vrf/qUfAW6JF+vviZWPrPivsxU/R6zIAFmtYL0eHqbkU
         5xd3/kGrSMrERjiFjP5RAbEuxpBLXIxspaQ/oJkZLhssoThsS+1lstUPnaHDw85vSAz3
         CLZ2sgOCbz7Fj3557vPvBdG4ZI0U/ACHwkap8KoGfTGTqB2xTru7dazFvYEtW3vzRUZl
         TOxNvu1VgMALqKGXxwhPuVT803fRHC9DCvNAOcyE6xQcEFMLNJO6rZ3tExQgBE5erIGx
         7fMQ==
X-Gm-Message-State: AOAM532gD5S3O6M5xSlbmygCrLa/1idkGOkYxiMOwclJnF/HZD5enVmh
        ozff57M8xP+oy0HFB29WEe7yHw==
X-Google-Smtp-Source: ABdhPJwUjtFEPasM6uIHKGE4xAQtgGqVOh2Nei1zxtzNvvJvSYPbSeOchBvzMA4cuSE2mPDREcw9jQ==
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr30718otg.77.1616530229418;
        Tue, 23 Mar 2021 13:10:29 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z25sm1368942otj.68.2021.03.23.13.10.27
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 23 Mar 2021 13:10:28 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:10:13 -0700 (PDT)
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
In-Reply-To: <YFo7SOni0s0TbXUm@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2103231310020.5513@eggly.anvils>
References: <20210319071547.60973-1-hannes@cmpxchg.org> <alpine.LSU.2.11.2103191814040.1043@eggly.anvils> <YFo7SOni0s0TbXUm@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 23 Mar 2021, Johannes Weiner wrote:
> From f6f062a3ec46f4fb083dcf6792fde9723f18cfc5 Mon Sep 17 00:00:00 2001
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

This is great, thanks Hannes.
Acked-by: Hugh Dickins <hughd@google.com>

I know that 5.10-stable rejected the two split_page_memcg() patches:
we shall need those in, I'll send GregKH the fixups, but not today.

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
