Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F422AF19D
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgKKNHT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 08:07:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgKKNHS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 08:07:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2A61AE65;
        Wed, 11 Nov 2020 13:07:16 +0000 (UTC)
Subject: Re: [PATCH v21 13/19] mm/mlock: remove __munlock_isolate_lru_page
To:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-14-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2f501777-1fdd-73ba-b693-a0ebcb9ad8a4@suse.cz>
Date:   Wed, 11 Nov 2020 14:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-14-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> The func only has one caller, remove it to clean up code and simplify
> code.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>   mm/mlock.c | 31 +++++++++----------------------
>   1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 796c726a0407..d487aa864e86 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -106,26 +106,6 @@ void mlock_vma_page(struct page *page)
>   }
>   
>   /*
> - * Isolate a page from LRU with optional get_page() pin.
> - * Assumes lru_lock already held and page already pinned.
> - */
> -static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
> -{
> -	if (PageLRU(page)) {
> -		struct lruvec *lruvec;
> -
> -		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -		if (getpage)
> -			get_page(page);
> -		ClearPageLRU(page);
> -		del_page_from_lru_list(page, lruvec, page_lru(page));
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -/*
>    * Finish munlock after successful page isolation
>    *
>    * Page must be locked. This is a wrapper for try_to_munlock()
> @@ -296,9 +276,16 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>   			 * We already have pin from follow_page_mask()
>   			 * so we can spare the get_page() here.
>   			 */
> -			if (__munlock_isolate_lru_page(page, false))
> +			if (PageLRU(page)) {
> +				struct lruvec *lruvec;
> +
> +				ClearPageLRU(page);
> +				lruvec = mem_cgroup_page_lruvec(page,
> +							page_pgdat(page));
> +				del_page_from_lru_list(page, lruvec,
> +							page_lru(page));
>   				continue;
> -			else
> +			} else
>   				__munlock_isolation_failed(page);

IIRC coding styles says that once the if () part uses brackets, the else part 
should too, even if it's single line.

>   		} else {
>   			delta_munlocked++;
> 

