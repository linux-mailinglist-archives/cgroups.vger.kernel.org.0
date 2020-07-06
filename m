Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D479F21567A
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2020 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgGFLfk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jul 2020 07:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgGFLfj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jul 2020 07:35:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962FDC061794;
        Mon,  6 Jul 2020 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OEy4U14lLKI068FHS0JNccIDytAin8DP0F/8fksYMHM=; b=KYXVtEnDEU3QfsHNKDl8JD6cEA
        IdtyW0WG0Z/5mgR9zDgpmcd2IGC5N6d50cIM/Q3NuAxlEzPib6+8TwZ8YuBaOn/pi2sEhzNmR5hkh
        k5U2rRABYmgA/UOuXfSnde6iXrCiOgypj593SKiGNG1o73ZDYlrCYEDhvQL4K+FN08k+QOz9LIKEx
        +CHnrREONgkl9Ff10suBnwJn49Kb+Bp87ssbB+0smB+PwOaVVWwzHql4tVCNYUV7pG7Ha4pBv0xKN
        QslQOwWxYu8tcBZ+GfPPW/YqSwHaROA7+J57WrQ9xQR1mOtL8v1hBZlx+MKCGOrHOQ55gBh4dwUyZ
        4/1VaErA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsPOz-00057v-Bn; Mon, 06 Jul 2020 11:35:13 +0000
Date:   Mon, 6 Jul 2020 12:35:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
Message-ID: <20200706113513.GY25523@casper.infradead.org>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
 <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 06, 2020 at 05:15:09PM +0800, Alex Shi wrote:
> Hi Kirill & Johannes & Matthew,
> 
> Would you like to give some comments or share your concern of this patchset,
> specialy for THP part? 

I don't have the brain space to understand this patch set fully at
the moment.  I'll note that the realtime folks are doing their best to
stamp out users of local_irq_disable(), so they won't be pleased to see
you adding a new one.  Also, you removed the comment explaining why the
lock needed to be taken.

> Many Thanks
> Alex
> 
> 在 2020/7/3 下午1:07, Alex Shi 写道:
> > lru_lock and page cache xa_lock have no reason with current sequence,
> > put them together isn't necessary. let's narrow the lru locking, but
> > left the local_irq_disable to block interrupt re-entry and statistic update.
> > 
> > Hugh Dickins point: split_huge_page_to_list() was already silly,to be
> > using the _irqsave variant: it's just been taking sleeping locks, so
> > would already be broken if entered with interrupts enabled.
> > so we can save passing flags argument down to __split_huge_page().
> > 
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/huge_memory.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b18f21da4dac..607869330329 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2433,7 +2433,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
> >  }
> >  
> >  static void __split_huge_page(struct page *page, struct list_head *list,
> > -		pgoff_t end, unsigned long flags)
> > +			      pgoff_t end)
> >  {
> >  	struct page *head = compound_head(page);
> >  	pg_data_t *pgdat = page_pgdat(head);
> > @@ -2442,8 +2442,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >  	unsigned long offset = 0;
> >  	int i;
> >  
> > -	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> > -
> >  	/* complete memcg works before add pages to LRU */
> >  	mem_cgroup_split_huge_fixup(head);
> >  
> > @@ -2455,6 +2453,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >  		xa_lock(&swap_cache->i_pages);
> >  	}
> >  
> > +	/* lock lru list/PageCompound, ref freezed by page_ref_freeze */
> > +	spin_lock(&pgdat->lru_lock);
> > +
> > +	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> > +
> >  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
> >  		__split_huge_page_tail(head, i, lruvec, list);
> >  		/* Some pages can be beyond i_size: drop them from page cache */
> > @@ -2474,6 +2477,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >  	}
> >  
> >  	ClearPageCompound(head);
> > +	spin_unlock(&pgdat->lru_lock);
> > +	/* Caller disabled irqs, so they are still disabled here */
> >  
> >  	split_page_owner(head, HPAGE_PMD_ORDER);
> >  
> > @@ -2491,8 +2496,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >  		page_ref_add(head, 2);
> >  		xa_unlock(&head->mapping->i_pages);
> >  	}
> > -
> > -	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> > +	local_irq_enable();
> >  
> >  	remap_page(head);
> >  
> > @@ -2631,12 +2635,10 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
> >  int split_huge_page_to_list(struct page *page, struct list_head *list)
> >  {
> >  	struct page *head = compound_head(page);
> > -	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
> >  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
> >  	struct anon_vma *anon_vma = NULL;
> >  	struct address_space *mapping = NULL;
> >  	int count, mapcount, extra_pins, ret;
> > -	unsigned long flags;
> >  	pgoff_t end;
> >  
> >  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> > @@ -2697,9 +2699,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >  	unmap_page(head);
> >  	VM_BUG_ON_PAGE(compound_mapcount(head), head);
> >  
> > -	/* prevent PageLRU to go away from under us, and freeze lru stats */
> > -	spin_lock_irqsave(&pgdata->lru_lock, flags);
> > -
> > +	local_irq_disable();
> >  	if (mapping) {
> >  		XA_STATE(xas, &mapping->i_pages, page_index(head));
> >  
> > @@ -2729,7 +2729,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >  				__dec_node_page_state(head, NR_FILE_THPS);
> >  		}
> >  
> > -		__split_huge_page(page, list, end, flags);
> > +		__split_huge_page(page, list, end);
> >  		if (PageSwapCache(head)) {
> >  			swp_entry_t entry = { .val = page_private(head) };
> >  
> > @@ -2748,7 +2748,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >  		spin_unlock(&ds_queue->split_queue_lock);
> >  fail:		if (mapping)
> >  			xa_unlock(&mapping->i_pages);
> > -		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> > +		local_irq_enable();
> >  		remap_page(head);
> >  		ret = -EBUSY;
> >  	}
> > 
