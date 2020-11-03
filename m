Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF02A3B98
	for <lists+cgroups@lfdr.de>; Tue,  3 Nov 2020 06:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCFBM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Nov 2020 00:01:12 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42997 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgKCFBM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Nov 2020 00:01:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UE3fJvY_1604379663;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UE3fJvY_1604379663)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Nov 2020 13:01:04 +0800
Subject: Re: [PATCH v20 18/20] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-19-git-send-email-alex.shi@linux.alibaba.com>
 <ef279dfe-afa5-45cb-4013-6c34169ff55e@linux.alibaba.com>
 <20201102204136.GB740958@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <eb099842-ed15-2d86-2a65-67f1f41999fb@linux.alibaba.com>
Date:   Tue, 3 Nov 2020 12:58:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102204136.GB740958@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/3 ÉÏÎç4:41, Johannes Weiner Ð´µÀ:
> On Fri, Oct 30, 2020 at 10:49:41AM +0800, Alex Shi wrote:
>>
>>
>> @@ -1367,6 +1380,51 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>>  	return lruvec;
>>  }
>>  
>> +struct lruvec *lock_page_lruvec(struct page *page)
>> +{
>> +	struct lruvec *lruvec;
>> +	struct pglist_data *pgdat = page_pgdat(page);
>> +
>> +	rcu_read_lock();
>> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +	spin_lock(&lruvec->lru_lock);
>> +	rcu_read_unlock();
>> +
>> +	lruvec_memcg_debug(lruvec, page);
>> +
>> +	return lruvec;
>> +}
>> +
>> +struct lruvec *lock_page_lruvec_irq(struct page *page)
>> +{
>> +	struct lruvec *lruvec;
>> +	struct pglist_data *pgdat = page_pgdat(page);
>> +
>> +	rcu_read_lock();
>> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +	spin_lock_irq(&lruvec->lru_lock);
>> +	rcu_read_unlock();
>> +
>> +	lruvec_memcg_debug(lruvec, page);
>> +
>> +	return lruvec;
>> +}
>> +
>> +struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>> +{
>> +	struct lruvec *lruvec;
>> +	struct pglist_data *pgdat = page_pgdat(page);
>> +
>> +	rcu_read_lock();
>> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
>> +	rcu_read_unlock();
>> +
>> +	lruvec_memcg_debug(lruvec, page);
>> +
>> +	return lruvec;
>> +}
> 
> As these are used quite widely throughout the VM code now, it would be
> good to give them kerneldoc comments that explain the interface.
> 
> In particular, I think it's necessary to explain the contexts from
> which this is safe to use (in particular wrt pages moving between
> memcgs - see the comment in commit_charge()).
> 
> I'm going to go through the callsites that follow and try to identify
> what makes them safe. It's mostly an exercise to double check our
> thinking here.
> 
> Most of them are straight-forward, and I don't think they warrant
> individual comments. But some do, IMO. And it appears at least one
> actually isn't safe yet:

Thanks a lot reminder. is the following comments fine?

/**
 * lock_page_lruvec - return lruvec for the locked page.
 * @page: the page
 *
 * This series functions should be used in either conditions:
 * PageLRU is cleared or unset
 * or, page->_refcount is zero
 */
struct lruvec *lock_page_lruvec(struct page *page)
{

....

>> @@ -274,9 +270,8 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>>  {
>>  	do {
>>  		unsigned long lrusize;
>> -		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>  
>> -		spin_lock_irq(&pgdat->lru_lock);
>> +		spin_lock_irq(&lruvec->lru_lock);
>>  		/* Record cost event */
>>  		if (file)
>>  			lruvec->file_cost += nr_pages;
>> @@ -300,7 +295,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>>  			lruvec->file_cost /= 2;
>>  			lruvec->anon_cost /= 2;
>>  		}
>> -		spin_unlock_irq(&pgdat->lru_lock);
>> +		spin_unlock_irq(&lruvec->lru_lock);
>>  	} while ((lruvec = parent_lruvec(lruvec)));
>>  }
> 
> This is safe because it either comes from
> 
> 	1) the pinned lruvec in reclaim, or
> 
> 	2) from a pre-LRU page during refault (which also holds the
> 	   rcu lock, so would be safe even if the page was on the LRU
> 	   and could move simultaneously to a new lruvec).
> 
> The second one seems a bit tricky. It could be good to add a comment
> to lru_note_cost_page() that explains why its mem_cgroup_page_lruvec()
> is safe.

Thanks for pointed, is the following comments fine?
diff --git a/mm/swap.c b/mm/swap.c
index 9fe5ff9a8111..55ccc93ffb49 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -264,6 +264,13 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
        do {
                unsigned long lrusize;

+               /*
+                * Hold lruvec->lru_lock is safe here, since
+                * 1) The pinned lruvec in reclaim, or
+                * 2) From a pre-LRU page during refault (which also holds the
+                *    rcu lock, so would be safe even if the page was on the LRU
+                *    and could move simultaneously to a new lruvec).
+                */
                spin_lock_irq(&lruvec->lru_lock);
                /* Record cost event */
> 
>> @@ -364,13 +359,13 @@ static inline void activate_page_drain(int cpu)
>>  
>>  static void activate_page(struct page *page)
>>  {
>> -	pg_data_t *pgdat = page_pgdat(page);
>> +	struct lruvec *lruvec;
>>  
>>  	page = compound_head(page);
>> -	spin_lock_irq(&pgdat->lru_lock);
>> +	lruvec = lock_page_lruvec_irq(page);
> 
> I don't see what makes this safe. There is nothing that appears to
> lock out a concurrent page move between memcgs/lruvecs, which means
> the following could manipulate an unlocked lru list:
> 

This funtion is for !CONFIG_SMP, could the cpu be preempt with RT kernel?

>>  	if (PageLRU(page))
>> -		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
>> -	spin_unlock_irq(&pgdat->lru_lock);
>> +		__activate_page(page, lruvec);
>> +	unlock_page_lruvec_irq(lruvec);
>>  }
>>  #endif
> 
> Shouldn't this be something like this?
> 
> 	if (TestClearPageLRU()) {
> 		lruvec = lock_page_lruvec_irq(page);
> 		__activate_page(page, lruvec);
> 		unlock_page_lruvec_irq(lruvec);
> 		SetPageLRU(page);
> 	}

But anyway, your new changes are more beautiful and logcially. I will change
to this.

Thanks a lot!
Alex
