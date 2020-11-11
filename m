Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496592AF174
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKKNEA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 08:04:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:36440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgKKND7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 08:03:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4860BABD6;
        Wed, 11 Nov 2020 13:03:58 +0000 (UTC)
Subject: Re: [PATCH v21 12/19] mm/mlock: remove lru_lock on
 TestClearPageMlocked
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
 <1604566549-62481-13-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0df624ca-a0d2-6a9f-f114-04f91bf35415@suse.cz>
Date:   Wed, 11 Nov 2020 14:03:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-13-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> In the func munlock_vma_page, comments mentained lru_lock needed for
> serialization with split_huge_pages. But the page must be PageLocked
> as well as pages in split_huge_page series funcs. Thus the PageLocked
> is enough to serialize both funcs.
> 
> Further more, Hugh Dickins pointed: before splitting in
> split_huge_page_to_list, the page was unmap_page() to remove pmd/ptes
> which protect the page from munlock. Thus, no needs to guard
> __split_huge_page_tail for mlock clean, just keep the lru_lock there for
> isolation purpose.
> 
> LKP found a preempt issue on __mod_zone_page_state which need change
> to mod_zone_page_state. Thanks!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>   mm/mlock.c | 26 +++++---------------------
>   1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 884b1216da6a..796c726a0407 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -187,40 +187,24 @@ static void __munlock_isolation_failed(struct page *page)
>   unsigned int munlock_vma_page(struct page *page)
>   {
>   	int nr_pages;
> -	pg_data_t *pgdat = page_pgdat(page);
>   
>   	/* For try_to_munlock() and to serialize with page migration */

Now the reasons for locking are expanded?

>   	BUG_ON(!PageLocked(page));
> -
>   	VM_BUG_ON_PAGE(PageTail(page), page);
>   
> -	/*
> -	 * Serialize with any parallel __split_huge_page_refcount() which
> -	 * might otherwise copy PageMlocked to part of the tail pages before
> -	 * we clear it in the head page. It also stabilizes thp_nr_pages().
> -	 */
> -	spin_lock_irq(&pgdat->lru_lock);
> -
>   	if (!TestClearPageMlocked(page)) {
>   		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
> -		nr_pages = 1;
> -		goto unlock_out;
> +		return 0;
>   	}
>   
>   	nr_pages = thp_nr_pages(page);
> -	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> +	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>   
> -	if (__munlock_isolate_lru_page(page, true)) {
> -		spin_unlock_irq(&pgdat->lru_lock);
> +	if (!isolate_lru_page(page))
>   		__munlock_isolated_page(page);
> -		goto out;
> -	}
> -	__munlock_isolation_failed(page);
> -
> -unlock_out:
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	else
> +		__munlock_isolation_failed(page);
>   
> -out:
>   	return nr_pages - 1;
>   }
>   
> 

