Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80726F725
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRHiL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 03:38:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:39448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgIRHiL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 03:38:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600414688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPXi6kQP8L4G5JbdCi6kyBUm/qW5BdGObub/lV8WW4A=;
        b=FmiUldVVOw2VqfTujjt5H70pIw9/fl1j/Bwdwljedy7RVwpkZ+NOmyTpGcXU9bhOxQ8rBY
        gKFhGelz+xG3DWrOPDXG9uo27KQxar2NSI3D2axRHwzaJQkxtbS0GfWjakGOcXWa/JZBjs
        IR5xQaB8l7upShWBvC3BL0HA3EN/yXngBS63vTsVqA9geFeeAbvZex3pnIhLUOuorSsLIa
        lprJ0CX+VWvxOm/rfX5ae4cWyyYQYppHf30ed1H7HFj7dK0g7wo8lv6qVNEZSkhvcJQ173
        cMIUG8fvZB2HsUOF7DINsNREJBdutnTE6Pvlj5h8ccoEvrLeASD7DpVpA5y6gQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87A05AC4D;
        Fri, 18 Sep 2020 07:38:42 +0000 (UTC)
Date:   Fri, 18 Sep 2020 09:38:07 +0200
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
Subject: Re: [PATCH 03/13] mm: move __ClearPageLRU() into page_off_lru()
Message-ID: <20200918073807.GF28827@dhcp22.suse.cz>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-4-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030051.650890-4-yuzhao@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-09-20 21:00:41, Yu Zhao wrote:
> Now we have a total of three places that free lru pages when their
> references become zero (after we drop the reference from isolation).
> 
> Before this patch, they all do:
> 	__ClearPageLRU()
> 	page_off_lru()
> 	del_page_from_lru_list()
> 
> After this patch, they become:
> 	page_off_lru()
> 		__ClearPageLRU()
> 	del_page_from_lru_list()
> 
> This change should have no side effects.

Again, why this is desirable?

> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/mm_inline.h | 1 +
>  mm/swap.c                 | 2 --
>  mm/vmscan.c               | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 8fc71e9d7bb0..be9418425e41 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -92,6 +92,7 @@ static __always_inline enum lru_list page_off_lru(struct page *page)
>  {
>  	enum lru_list lru;
>  
> +	__ClearPageLRU(page);
>  	if (PageUnevictable(page)) {
>  		__ClearPageUnevictable(page);
>  		lru = LRU_UNEVICTABLE;
> diff --git a/mm/swap.c b/mm/swap.c
> index 40bf20a75278..8362083f00c9 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -86,7 +86,6 @@ static void __page_cache_release(struct page *page)
>  		spin_lock_irqsave(&pgdat->lru_lock, flags);
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		VM_BUG_ON_PAGE(!PageLRU(page), page);
> -		__ClearPageLRU(page);
>  		del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>  	}
> @@ -895,7 +894,6 @@ void release_pages(struct page **pages, int nr)
>  
>  			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>  			VM_BUG_ON_PAGE(!PageLRU(page), page);
> -			__ClearPageLRU(page);
>  			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  		}
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f257d2f61574..f9a186a96410 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1862,7 +1862,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		add_page_to_lru_list(page, lruvec, lru);
>  
>  		if (put_page_testzero(page)) {
> -			__ClearPageLRU(page);
>  			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  
>  			if (unlikely(PageCompound(page))) {
> -- 
> 2.28.0.681.g6f77f65b4e-goog

-- 
Michal Hocko
SUSE Labs
