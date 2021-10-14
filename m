Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB442DE2D
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhJNPe5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 11:34:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56892 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJNPe5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 11:34:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48F171FD39;
        Thu, 14 Oct 2021 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634225571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8NI5g+v3yznxinmmoFT7TMX1/0izl9PQ4EZKztZniWc=;
        b=jeXGfJreavv0Vk459TOje+YdBW0yWUXEzJlCcgd1R6KNcwJmHB97kYcO92BPxFHaXR0Ufw
        dDD6vxtsXrtGNcnsbb9Za0hOJ7x0rXnSZ012V27ZkFjbj90RB+myCkmR0Jy6SxZiM+cU/5
        LMQcrqnZw8fG8HOpl4dayFORdLAHKLo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15562A3B83;
        Thu, 14 Oct 2021 15:32:51 +0000 (UTC)
Date:   Thu, 14 Oct 2021 17:32:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memcg: page_alloc: skip bulk allocator for
 __GFP_ACCOUNT
Message-ID: <YWhNom2T+codyPea@dhcp22.suse.cz>
References: <20211014151607.2171970-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014151607.2171970-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 14-10-21 08:16:07, Shakeel Butt wrote:
> The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> __vmalloc_area_node()") switched to bulk page allocator for order 0
> allocation backing vmalloc. However bulk page allocator does not support
> __GFP_ACCOUNT allocations and there are several users of
> kvmalloc(__GFP_ACCOUNT).
> 
> For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In

I would go with
For now make __GFP_ACCOUNT allocations bypass the fast path of the bulk
allocator and make it fallback to the regular page allocator as if the
former failed.

> future if there is workload that can be significantly improved with the
> bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> decision.
> 
> Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

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
> -- 
> 2.33.0.882.g93a45727a2-goog

-- 
Michal Hocko
SUSE Labs
