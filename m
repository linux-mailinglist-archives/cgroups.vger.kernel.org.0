Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A221546A
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2020 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGFJPn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jul 2020 05:15:43 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53869 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728024AbgGFJPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jul 2020 05:15:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U1sNi0q_1594026936;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U1sNi0q_1594026936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Jul 2020 17:15:36 +0800
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
Date:   Mon, 6 Jul 2020 17:15:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Kirill & Johannes & Matthew,

Would you like to give some comments or share your concern of this patchset,
specialy for THP part? 

Many Thanks
Alex

ÔÚ 2020/7/3 ÏÂÎç1:07, Alex Shi Ð´µÀ:
> lru_lock and page cache xa_lock have no reason with current sequence,
> put them together isn't necessary. let's narrow the lru locking, but
> left the local_irq_disable to block interrupt re-entry and statistic update.
> 
> Hugh Dickins point: split_huge_page_to_list() was already silly,to be
> using the _irqsave variant: it's just been taking sleeping locks, so
> would already be broken if entered with interrupts enabled.
> so we can save passing flags argument down to __split_huge_page().
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/huge_memory.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b18f21da4dac..607869330329 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2433,7 +2433,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  }
>  
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end, unsigned long flags)
> +			      pgoff_t end)
>  {
>  	struct page *head = compound_head(page);
>  	pg_data_t *pgdat = page_pgdat(head);
> @@ -2442,8 +2442,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	unsigned long offset = 0;
>  	int i;
>  
> -	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> -
>  	/* complete memcg works before add pages to LRU */
>  	mem_cgroup_split_huge_fixup(head);
>  
> @@ -2455,6 +2453,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		xa_lock(&swap_cache->i_pages);
>  	}
>  
> +	/* lock lru list/PageCompound, ref freezed by page_ref_freeze */
> +	spin_lock(&pgdat->lru_lock);
> +
> +	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> +
>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond i_size: drop them from page cache */
> @@ -2474,6 +2477,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	}
>  
>  	ClearPageCompound(head);
> +	spin_unlock(&pgdat->lru_lock);
> +	/* Caller disabled irqs, so they are still disabled here */
>  
>  	split_page_owner(head, HPAGE_PMD_ORDER);
>  
> @@ -2491,8 +2496,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		page_ref_add(head, 2);
>  		xa_unlock(&head->mapping->i_pages);
>  	}
> -
> -	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +	local_irq_enable();
>  
>  	remap_page(head);
>  
> @@ -2631,12 +2635,10 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
>  int split_huge_page_to_list(struct page *page, struct list_head *list)
>  {
>  	struct page *head = compound_head(page);
> -	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
>  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
>  	int count, mapcount, extra_pins, ret;
> -	unsigned long flags;
>  	pgoff_t end;
>  
>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> @@ -2697,9 +2699,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	unmap_page(head);
>  	VM_BUG_ON_PAGE(compound_mapcount(head), head);
>  
> -	/* prevent PageLRU to go away from under us, and freeze lru stats */
> -	spin_lock_irqsave(&pgdata->lru_lock, flags);
> -
> +	local_irq_disable();
>  	if (mapping) {
>  		XA_STATE(xas, &mapping->i_pages, page_index(head));
>  
> @@ -2729,7 +2729,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  				__dec_node_page_state(head, NR_FILE_THPS);
>  		}
>  
> -		__split_huge_page(page, list, end, flags);
> +		__split_huge_page(page, list, end);
>  		if (PageSwapCache(head)) {
>  			swp_entry_t entry = { .val = page_private(head) };
>  
> @@ -2748,7 +2748,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  		spin_unlock(&ds_queue->split_queue_lock);
>  fail:		if (mapping)
>  			xa_unlock(&mapping->i_pages);
> -		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> +		local_irq_enable();
>  		remap_page(head);
>  		ret = -EBUSY;
>  	}
> 
