Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB59A3429B7
	for <lists+cgroups@lfdr.de>; Sat, 20 Mar 2021 02:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCTBxW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 21:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTBxD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 21:53:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362CC061761
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 18:53:03 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j7so8288161qtx.5
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 18:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bbqnt/9Bz0dwgnbwz2YuuMVEFJVwyS/lwtSrMVzL3KQ=;
        b=k3LlzQxQcReO0CIi6WRFB0czD21cyNNYz88NKLNL4trrdRK5/zKFure+Q8GTtYZJF2
         wFEqKvwzbNIC0IxUXvaK1jGVB14NNssZRUTv4Tncl1yvFTtYxXuUjAeOhGp+k8MAnZcH
         F8/l9+cOiCI4vpuXIyH+iNtx3elBg7YuThEUEBE1WjjCddczzu/OOGSvpju6tiFZxYVb
         tqopjrM2cCRs0H2EKjcPCEVMs8YgFxRyzztWcBWOjKkppl7k1zpDiL91mypTRvEPDAmC
         YC0s7nFCbOfv3icqQPTV3c0D9Jr/TowdgyY0nmwR1mLSgCtyg7iEAMZqUF1xNCh3PnCF
         Tf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bbqnt/9Bz0dwgnbwz2YuuMVEFJVwyS/lwtSrMVzL3KQ=;
        b=bMaAU+LAHyfNHY6SAQ91/P8EgY8wEjs1oFg0Ayu6nuTH4qcfZJ/skMhLeuh555lcUj
         hsPZfs/Fv8In1g6by8xMKGszuSb7Q6B7omthkSeGDz+WGau17KF9ZIX4+dHn9HnF7/51
         2P4wmQeWXm9AgKr/xzIHV8OCrMGtAjJfcg2II19/yZVfTmeYP1ZQlPGpui+fSauip1Lo
         FT5t4K1DFoXH8Ys1RRCjynLlEhl2VPKxySp2FMRBKVWJo3QfqvX5VuZu9aE2woqHWmeE
         4bloE9ECZFyk75Vif1Otb0NxZ0j7A2xbx/zeAsP04CCiPu2BYG4+4v+Hm6D5ubTr/L2d
         BaqQ==
X-Gm-Message-State: AOAM531snyagzrV0TXvXsMtPN6fYZv4cGP3Bpcbw+rrBV4kbZbbwenpz
        ruT6qtla0mMAuI7uw8E32eNqhw==
X-Google-Smtp-Source: ABdhPJzzjEbotetWZHFKP7VrKS2ICsxuth1Oh6ejUFZP1EJCs+8xTDk1awsjyQbZEb2AP4oeNdqQsw==
X-Received: by 2002:ac8:7d52:: with SMTP id h18mr1372267qtb.175.1616205181920;
        Fri, 19 Mar 2021 18:53:01 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k4sm5877496qke.13.2021.03.19.18.53.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 19 Mar 2021 18:53:01 -0700 (PDT)
Date:   Fri, 19 Mar 2021 18:52:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
In-Reply-To: <20210319071547.60973-1-hannes@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2103191814040.1043@eggly.anvils>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 19 Mar 2021, Johannes Weiner wrote:

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

Acked-by: Hugh Dickins <hughd@google.com>

to the split_page_memcg() addition etc, but a doubt just hit me on the
original e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages"):
see comment below.

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

The put_page_testzero() has released our reference to the first
subpage of page: it's now under the control of the racing speculative
lookup.  So it seems to me unsafe to be checking PageHead(page) here:
if it was actually a compound page, PageHead might already be cleared
by now, and we doubly free its tail pages below?  I think we need to
use a "bool compound = PageHead(page)" on entry to __free_pages().

Or alternatively, it's wrong to call __free_pages() on a compound
page anyway, so we should not check PageHead at all, except in a
WARN_ON_ONCE(PageCompound(page)) at the start?

And would it be wrong to fix that too in this patch?
Though it ought then to be backported to 5.10 stable.

> +		split_page_memcg(page, 1 << order);
>  		while (order-- > 0)
>  			free_the_page(page + (1 << order), order);
> +	}
>  }
>  EXPORT_SYMBOL(__free_pages);
>  
> -- 
> 2.30.1
