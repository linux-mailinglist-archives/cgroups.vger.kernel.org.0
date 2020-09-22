Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA312739FD
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 07:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgIVFCh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 01:02:37 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43001 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728290AbgIVFCg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 01:02:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U9jveFZ_1600750949;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9jveFZ_1600750949)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 13:02:30 +0800
Subject: Re: [PATCH v18 19/32] mm/swap.c: serialize memcg changes in
 pagevec_lru_move_fn
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-20-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009211713440.5214@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <721fd79e-453c-4832-22e3-4e95d3c9b6b0@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 13:00:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009211713440.5214@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/22 ÉÏÎç8:42, Hugh Dickins Ð´µÀ:
> On Mon, 24 Aug 2020, Alex Shi wrote:
> 
>> Hugh Dickins' found a memcg change bug on original version:
>> If we want to change the pgdat->lru_lock to memcg's lruvec lock, we have
>> to serialize mem_cgroup_move_account during pagevec_lru_move_fn. The
>> possible bad scenario would like:
>>
>> 	cpu 0					cpu 1
>> lruvec = mem_cgroup_page_lruvec()
>> 					if (!isolate_lru_page())
>> 						mem_cgroup_move_account
>>
>> spin_lock_irqsave(&lruvec->lru_lock <== wrong lock.
>>
>> So we need the ClearPageLRU to block isolate_lru_page(), that serializes
> 
> s/the ClearPageLRU/TestClearPageLRU/

Thanks, will change it.

> 
>> the memcg change. and then removing the PageLRU check in move_fn callee
>> as the consequence.
> 
> Deserves another paragraph about __pagevec_lru_add():
> "__pagevec_lru_add_fn() is different from the others, because the pages
> it deals with are, by definition, not yet on the lru.  TestClearPageLRU
> is not needed and would not work, so __pagevec_lru_add() goes its own way."

Thanks for comments! will add it into new commit log.
> 
>>
>> Reported-by: Hugh Dickins <hughd@google.com>
> 
> True.
> 
>> Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> I did provide some lines, but I think it's just
> Acked-by: Hugh Dickins <hughd@google.com>
> to go below your Signed-off-by.

Thanks!
> 
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/swap.c | 44 +++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> In your lruv19 branch, this patch got renamed (s/moveing/moving/):
> but I think it's better with the old name used here in v18, and without
> those mm/vmscan.c mods to check_move_unevictable_pages() tacked on:
> please move those back to 16/32, which already makes changes to vmscan.c.
> 

Yes, will move that part there.
Thanks!
Alex

>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 446ffe280809..2d9a86bf93a4 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -221,8 +221,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>>  			spin_lock_irqsave(&pgdat->lru_lock, flags);
>>  		}
>>  
>> +		/* block memcg migration during page moving between lru */
>> +		if (!TestClearPageLRU(page))
>> +			continue;
>> +
>>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>  		(*move_fn)(page, lruvec);
>> +
>> +		SetPageLRU(page);
>>  	}
>>  	if (pgdat)
>>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>> @@ -232,7 +238,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>>  
>>  static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
>>  {
>> -	if (PageLRU(page) && !PageUnevictable(page)) {
>> +	if (!PageUnevictable(page)) {
>>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>>  		ClearPageActive(page);
>>  		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
>> @@ -306,7 +312,7 @@ void lru_note_cost_page(struct page *page)
>>  
>>  static void __activate_page(struct page *page, struct lruvec *lruvec)
>>  {
>> -	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
>> +	if (!PageActive(page) && !PageUnevictable(page)) {
>>  		int lru = page_lru_base_type(page);
>>  		int nr_pages = thp_nr_pages(page);
>>  
>> @@ -362,7 +368,8 @@ void activate_page(struct page *page)
>>  
>>  	page = compound_head(page);
>>  	spin_lock_irq(&pgdat->lru_lock);
>> -	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
>> +	if (PageLRU(page))
>> +		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
>>  	spin_unlock_irq(&pgdat->lru_lock);
>>  }
>>  #endif
> 
> Every time I look at this, I wonder if that's right, or an unnecessary
> optimization strayed in, or whatever.  For the benefit of others looking
> at this patch, yes it is right: this is the !CONFIG_SMP alternative
> version of activate_page(), and needs that PageLRU check to compensate
> for the check that has now been removed from __activate_page() itself.
> 
>> @@ -521,9 +528,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>>  	bool active;
>>  	int nr_pages = thp_nr_pages(page);
>>  
>> -	if (!PageLRU(page))
>> -		return;
>> -
>>  	if (PageUnevictable(page))
>>  		return;
>>  
>> @@ -564,7 +568,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>>  
>>  static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>>  {
>> -	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
>> +	if (PageActive(page) && !PageUnevictable(page)) {
>>  		int lru = page_lru_base_type(page);
>>  		int nr_pages = thp_nr_pages(page);
>>  
>> @@ -581,7 +585,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>>  
>>  static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
>>  {
>> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>> +	if (PageAnon(page) && PageSwapBacked(page) &&
>>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>>  		bool active = PageActive(page);
>>  		int nr_pages = thp_nr_pages(page);
>> @@ -979,7 +983,29 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>>   */
>>  void __pagevec_lru_add(struct pagevec *pvec)
>>  {
>> -	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
>> +	int i;
>> +	struct pglist_data *pgdat = NULL;
>> +	struct lruvec *lruvec;
>> +	unsigned long flags = 0;
>> +
>> +	for (i = 0; i < pagevec_count(pvec); i++) {
>> +		struct page *page = pvec->pages[i];
>> +		struct pglist_data *pagepgdat = page_pgdat(page);
>> +
>> +		if (pagepgdat != pgdat) {
>> +			if (pgdat)
>> +				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>> +			pgdat = pagepgdat;
>> +			spin_lock_irqsave(&pgdat->lru_lock, flags);
>> +		}
>> +
>> +		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +		__pagevec_lru_add_fn(page, lruvec);
>> +	}
>> +	if (pgdat)
>> +		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>> +	release_pages(pvec->pages, pvec->nr);
>> +	pagevec_reinit(pvec);
>>  }
>>  
>>  /**
>> -- 
>> 1.8.3.1
