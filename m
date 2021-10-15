Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3855D42F05C
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 14:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhJOMVx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Oct 2021 08:21:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:45560 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238683AbhJOMVw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 Oct 2021 08:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=/B7rgErOfLKQi67WSz8dh86iJaZXVLLVfh6dylmYihY=; b=uQZtgjj3zwKn0UQxw
        vvEykiDYG1rKGw6qE4ASuZlmAf1mziuO8GIus+g93Bb4H5HoBqj/OAJCxtDgO8DX/ZOiRwwARBS7r
        PyekzQZxdKSlvWULU+Gmy9oY/p+SVNoxgtVY5ZB2Ur46JLWkenAMVjkPJvAAw+BWYrjYa+OJtIwho
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mbMBY-0067Xg-5z; Fri, 15 Oct 2021 15:19:40 +0300
Subject: Re: [PATCH v2] memcg: page_alloc: skip bulk allocator for
 __GFP_ACCOUNT
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211014151607.2171970-1-shakeelb@google.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <9c6ecab8-9227-48ac-22d5-c1d96b85883a@virtuozzo.com>
Date:   Fri, 15 Oct 2021 15:19:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014151607.2171970-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 14.10.2021 18:16, Shakeel Butt wrote:
> The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> __vmalloc_area_node()") switched to bulk page allocator for order 0
> allocation backing vmalloc. However bulk page allocator does not support
> __GFP_ACCOUNT allocations and there are several users of
> kvmalloc(__GFP_ACCOUNT).
> 
> For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> future if there is workload that can be significantly improved with the
> bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> decision.
> 
> Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Reported-and-tested-by: Vasily Averin <vvs@virtuozzo.com>

> ---
> Changes since v1:
> - do fallback allocation instead of failure, suggested by Michal Hocko.
> - Added memcg_kmem_enabled() check, corrected by Vasily Averin
> 
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb16446a..9ca871dc8602 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5230,6 +5230,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (unlikely(page_array && nr_pages - nr_populated == 0))
>  		goto out;
>  
> +	/* Bulk allocator does not support memcg accounting. */
> +	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT))
> +		goto failed;
> +
>  	/* Use the single page allocator for one page. */
>  	if (nr_pages - nr_populated == 1)
>  		goto failed;
> 

