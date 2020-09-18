Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD626F721
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRHhE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 03:37:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgIRHhE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 03:37:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600414621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IerR+PY+4rUTIGV+zw/7iB09Mc+/bTYrczgrwaDRFBc=;
        b=nLnFRe/mcq7skGBJw+mM5/YGg8I+WZlkCTqLblWIL7NmP9BSPZzBnMgpJGm5x7QMYdFbEq
        M38wC0ove+2L4QhGe/vtZ6h+2fd8Ue8dEJek+ZnGJDjllL8BM9JQ/c/LXZKM/XTAb30uUI
        dvxpBGx5TWqU8EAEab9oOFkPCAuJU2PTESytTNuHjGx3sLJeBwK/az1M6c+E48YV/YrBTt
        qq+x1NW4lOnpw+43wb9F/RFEQBxZgGQRcNZv4Xku7+bbxRwGjEFEN9pb4sy2NZnU/NpTmw
        2Uu0njttXkDQpvx9oypTd1Bei+J4LThOtZ9U7GzglBVy3nvlMYGCQzBYKR/YOw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B40E0AE16;
        Fri, 18 Sep 2020 07:37:35 +0000 (UTC)
Date:   Fri, 18 Sep 2020 09:37:00 +0200
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
Subject: Re: [PATCH 02/13] mm: use page_off_lru()
Message-ID: <20200918073700.GE28827@dhcp22.suse.cz>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030051.650890-3-yuzhao@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-09-20 21:00:40, Yu Zhao wrote:
> This patch replaces the only open-coded __ClearPageActive() with
> page_off_lru(). There is no open-coded __ClearPageUnevictable()s.
> 
> Before this patch, we have:
> 	__ClearPageActive()
> 	add_page_to_lru_list()
> 
> After this patch, we have:
> 	page_off_lru()
> 		if PageUnevictable()
> 			__ClearPageUnevictable()
> 		else if PageActive()
> 			__ClearPageActive()
> 	add_page_to_lru_list()
> 
> Checking PageUnevictable() shouldn't be a problem because these two
> flags are mutually exclusive. Leaking either will trigger bad_page().

I am sorry but the changelog is really hard to grasp. What are you
trying to achieve, why and why it is safe. This should be a general
outline for any patch. I have already commented on the previous patch
and asked you for the explanation why removing __ClearPageActive from
this path is desirable and safe. I have specifically asked to clarify
the compound page situation as that is using its oen destructor in the
freeing path and that might result in page_off_lru to be not called.
 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 503fc5e1fe32..f257d2f61574 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1845,7 +1845,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> -	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
> @@ -1860,14 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
>  		SetPageLRU(page);
> -		lru = page_lru(page);
> -
>  		add_page_to_lru_list(page, lruvec, lru);
>  
>  		if (put_page_testzero(page)) {
>  			__ClearPageLRU(page);
> -			__ClearPageActive(page);
> -			del_page_from_lru_list(page, lruvec, lru);
> +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  
>  			if (unlikely(PageCompound(page))) {
>  				spin_unlock_irq(&pgdat->lru_lock);
> -- 
> 2.28.0.681.g6f77f65b4e-goog

-- 
Michal Hocko
SUSE Labs
