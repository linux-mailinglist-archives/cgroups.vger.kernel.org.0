Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20042D337
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNHHw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 03:07:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:33926 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhJNHHv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Oct 2021 03:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=S7LE65uhsCV8C643BVPxhF0qRh9OLtZ/h5F5Sin60rk=; b=CnQs1S9wNOJcAGp2Y
        W9sNTKLUwcBl2VL7C98WHGBYNOPMmAhU6ns/gVLdD8bUMuM9OsfGEExgbsTkZhUmSfJ9ToCBCEUYN
        w45ppZ3aM3ifjVT8c2lpQtXdbKIMq8rzMfUdz8BNNZU3PCaO5U1dAEn9J2J8zaVi/TFCLcrcYItGA
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mauoA-005ylV-Im; Thu, 14 Oct 2021 10:05:42 +0300
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211013194338.1804247-1-shakeelb@google.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <4c92e227-2abc-c3cb-93eb-f5c45bef7fc6@virtuozzo.com>
Date:   Thu, 14 Oct 2021 10:05:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013194338.1804247-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 13.10.2021 22:43, Shakeel Butt wrote:
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
> ---
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb16446a..b3acad4615d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	int nr_populated = 0, nr_account = 0;
>  
> +	/* Bulk allocator does not support memcg accounting. */
> +	if (unlikely(gfp & __GFP_ACCOUNT))
> +		goto out;
> +

May be (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) check is better here?

>  	/*
>  	 * Skip populated array elements to determine if any pages need
>  	 * to be allocated before disabling IRQs.
> 

