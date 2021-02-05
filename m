Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D1311508
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhBEWWt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:22:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232616AbhBEOZr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 09:25:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612538880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6nLt32hHSRYEP44w6Q8jO52HR65E6F1MxMn+PffeCo=;
        b=eoMxcZO9AYC0lNv6Jl0zdS7Nnkz6VqMQWDpWPY1xlgnXmYy4t0pxybOM8SrwuOlrWKhsGW
        mGT+lqDRFr5ltdHWe2tkSYEMqhoSMUxGiAfYj2LFel3EN6KchlZISW+tyKV/+g7pR4ZPAI
        +kYu7WQjtB1eS0Vft4tcfEeYs8r9FL8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC35AB048;
        Fri,  5 Feb 2021 15:27:59 +0000 (UTC)
Date:   Fri, 5 Feb 2021 16:27:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: replace the loop with a
 list_for_each_entry()
Message-ID: <YB1j/DuQIUyCn56f@dhcp22.suse.cz>
References: <20210204163055.56080-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204163055.56080-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 00:30:55, Muchun Song wrote:
> The rule of list walk has gone since:
> 
>  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> 
> So remove the strange comment and replace the loop with a
> list_for_each_entry().
> 
> There is only one caller of the uncharge_list(). So just fold it into
> mem_cgroup_uncharge_list() and remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> v2:
>  - Fold uncharge_list() to mem_cgroup_uncharge_list().
> 
>  mm/memcontrol.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ed5cc78a8dbf..8c035846c7a4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6862,31 +6862,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	css_put(&ug->memcg->css);
>  }
>  
> -static void uncharge_list(struct list_head *page_list)
> -{
> -	struct uncharge_gather ug;
> -	struct list_head *next;
> -
> -	uncharge_gather_clear(&ug);
> -
> -	/*
> -	 * Note that the list can be a single page->lru; hence the
> -	 * do-while loop instead of a simple list_for_each_entry().
> -	 */
> -	next = page_list->next;
> -	do {
> -		struct page *page;
> -
> -		page = list_entry(next, struct page, lru);
> -		next = page->lru.next;
> -
> -		uncharge_page(page, &ug);
> -	} while (next != page_list);
> -
> -	if (ug.memcg)
> -		uncharge_batch(&ug);
> -}
> -
>  /**
>   * mem_cgroup_uncharge - uncharge a page
>   * @page: page to uncharge
> @@ -6918,11 +6893,17 @@ void mem_cgroup_uncharge(struct page *page)
>   */
>  void mem_cgroup_uncharge_list(struct list_head *page_list)
>  {
> +	struct uncharge_gather ug;
> +	struct page *page;
> +
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (!list_empty(page_list))
> -		uncharge_list(page_list);
> +	uncharge_gather_clear(&ug);
> +	list_for_each_entry(page, page_list, lru)
> +		uncharge_page(page, &ug);
> +	if (ug.memcg)
> +		uncharge_batch(&ug);
>  }
>  
>  /**
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
