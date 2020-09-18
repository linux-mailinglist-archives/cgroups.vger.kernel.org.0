Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4826F70F
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRHco (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 03:32:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:35026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgIRHco (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 03:32:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600414361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgNBJtQybUt+aLQlWkB/4yJbkuXmXsDcz8/9t/Jw7us=;
        b=XZPvSCfLPNA9NPNZeW8OYl6SToHj1z2xudwJVjZarJ7zPWa3KAYW8zHxkryTkcv5ODNrM0
        ujQQWcWMcG2b0KnHXk4BBGf3m6TmFQ4LUmA/VHvnMeSW2WmwnJRm/qFCfpGIM0yLShH9Ag
        dg17dOnjgp5v/gDFEKAdstA6Hz64b87yp3A+mn8ydYeOnCGqXFTHSgwokBUHtazJ//CzBM
        xvGf5k80AoNDvkK444ScJqOSO9PygCAYTYTprw4jf9xKPnM/iJkGi3ALe9PGkLuornjOYZ
        JG2Dl/E40rf/W2NnBUgud+kZ7HTs3noIos5cYQyghtXmVWeukJvCyw4+aqY4Xg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C618FAD79;
        Fri, 18 Sep 2020 07:33:15 +0000 (UTC)
Date:   Fri, 18 Sep 2020 09:32:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] mm: use add_page_to_lru_list()
Message-ID: <20200918073240.GD28827@dhcp22.suse.cz>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030051.650890-2-yuzhao@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-09-20 21:00:39, Yu Zhao wrote:
> This patch replaces the only open-coded lru list addition with
> add_page_to_lru_list().
> 
> Before this patch, we have:
> 	update_lru_size()
> 	list_move()
> 
> After this patch, we have:
> 	list_del()
> 	add_page_to_lru_list()
> 		update_lru_size()
> 		list_add()
> 
> The only side effect is that page->lru is temporarily poisoned
> after a page is deleted from its old list, which shouldn't be a
> problem.

"because the lru lock is held" right?

Please always be explicit about your reasoning. "It shouldn't be a
problem" without further justification is just pointless for anybody
reading the code later on.
 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9727dd8e2581..503fc5e1fe32 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1850,8 +1850,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			list_del(&page->lru);
>  			spin_unlock_irq(&pgdat->lru_lock);
>  			putback_lru_page(page);
>  			spin_lock_irq(&pgdat->lru_lock);
> @@ -1862,9 +1862,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		SetPageLRU(page);
>  		lru = page_lru(page);
>  
> -		nr_pages = thp_nr_pages(page);
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_move(&page->lru, &lruvec->lists[lru]);
> +		add_page_to_lru_list(page, lruvec, lru);
>  
>  		if (put_page_testzero(page)) {
>  			__ClearPageLRU(page);
> @@ -1878,6 +1876,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  			} else
>  				list_add(&page->lru, &pages_to_free);
>  		} else {
> +			nr_pages = thp_nr_pages(page);
>  			nr_moved += nr_pages;
>  			if (PageActive(page))
>  				workingset_age_nonresident(lruvec, nr_pages);
> -- 
> 2.28.0.681.g6f77f65b4e-goog

-- 
Michal Hocko
SUSE Labs
