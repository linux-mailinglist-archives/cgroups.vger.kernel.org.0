Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A242C2AF7A5
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKSAQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 13:00:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:39386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKKSAN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 13:00:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46FD6ABD1;
        Wed, 11 Nov 2020 18:00:11 +0000 (UTC)
Subject: Re: [PATCH v21 16/19] mm/swap.c: serialize memcg changes in
 pagevec_lru_move_fn
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
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-17-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0af28702-8f75-6974-5b66-c0633eb83d7c@suse.cz>
Date:   Wed, 11 Nov 2020 19:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-17-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> Hugh Dickins' found a memcg change bug on original version:
> If we want to change the pgdat->lru_lock to memcg's lruvec lock, we have
> to serialize mem_cgroup_move_account during pagevec_lru_move_fn. The
> possible bad scenario would like:
> 
> 	cpu 0					cpu 1
> lruvec = mem_cgroup_page_lruvec()
> 					if (!isolate_lru_page())
> 						mem_cgroup_move_account
> 
> spin_lock_irqsave(&lruvec->lru_lock <== wrong lock.
> 
> So we need TestClearPageLRU to block isolate_lru_page(), that serializes
> the memcg change. and then removing the PageLRU check in move_fn callee
> as the consequence.
> 
> __pagevec_lru_add_fn() is different from the others, because the pages
> it deals with are, by definition, not yet on the lru.  TestClearPageLRU
> is not needed and would not work, so __pagevec_lru_add() goes its own
> way.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/swap.c | 44 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 2681d9023998..1838a9535703 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -222,8 +222,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>   			spin_lock_irqsave(&pgdat->lru_lock, flags);
>   		}
>   
> +		/* block memcg migration during page moving between lru */
> +		if (!TestClearPageLRU(page))
> +			continue;
> +
>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>   		(*move_fn)(page, lruvec);
> +
> +		SetPageLRU(page);
>   	}
>   	if (pgdat)
>   		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> @@ -233,7 +239,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>   
>   static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
>   {
> -	if (PageLRU(page) && !PageUnevictable(page)) {
> +	if (!PageUnevictable(page)) {
>   		del_page_from_lru_list(page, lruvec, page_lru(page));
>   		ClearPageActive(page);
>   		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> @@ -306,7 +312,7 @@ void lru_note_cost_page(struct page *page)
>   
>   static void __activate_page(struct page *page, struct lruvec *lruvec)
>   {
> -	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
> +	if (!PageActive(page) && !PageUnevictable(page)) {
>   		int lru = page_lru_base_type(page);
>   		int nr_pages = thp_nr_pages(page);
>   
> @@ -362,7 +368,8 @@ static void activate_page(struct page *page)
>   
>   	page = compound_head(page);
>   	spin_lock_irq(&pgdat->lru_lock);
> -	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
> +	if (PageLRU(page))
> +		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
>   	spin_unlock_irq(&pgdat->lru_lock);
>   }
>   #endif
> @@ -519,9 +526,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>   	bool active;
>   	int nr_pages = thp_nr_pages(page);
>   
> -	if (!PageLRU(page))
> -		return;
> -
>   	if (PageUnevictable(page))
>   		return;
>   
> @@ -562,7 +566,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>   
>   static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>   {
> -	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> +	if (PageActive(page) && !PageUnevictable(page)) {
>   		int lru = page_lru_base_type(page);
>   		int nr_pages = thp_nr_pages(page);
>   
> @@ -579,7 +583,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>   
>   static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
>   {
> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
> +	if (PageAnon(page) && PageSwapBacked(page) &&
>   	    !PageSwapCache(page) && !PageUnevictable(page)) {
>   		bool active = PageActive(page);
>   		int nr_pages = thp_nr_pages(page);
> @@ -1021,7 +1025,29 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>    */
>   void __pagevec_lru_add(struct pagevec *pvec)
>   {
> -	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
> +	int i;
> +	struct pglist_data *pgdat = NULL;
> +	struct lruvec *lruvec;
> +	unsigned long flags = 0;
> +
> +	for (i = 0; i < pagevec_count(pvec); i++) {
> +		struct page *page = pvec->pages[i];
> +		struct pglist_data *pagepgdat = page_pgdat(page);
> +
> +		if (pagepgdat != pgdat) {
> +			if (pgdat)
> +				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +			pgdat = pagepgdat;
> +			spin_lock_irqsave(&pgdat->lru_lock, flags);
> +		}
> +
> +		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		__pagevec_lru_add_fn(page, lruvec);
> +	}
> +	if (pgdat)
> +		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +	release_pages(pvec->pages, pvec->nr);
> +	pagevec_reinit(pvec);
>   }
>   
>   /**
> 

