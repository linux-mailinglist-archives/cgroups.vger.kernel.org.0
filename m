Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38B3234EC0
	for <lists+cgroups@lfdr.de>; Sat,  1 Aug 2020 01:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGaXzE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 19:55:04 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40170 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgGaXzE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Jul 2020 19:55:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U4Ln6pe_1596239697;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4Ln6pe_1596239697)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 01 Aug 2020 07:54:59 +0800
Subject: Re: [PATCH RFC] mm: Add function for testing if the current lruvec
 lock is valid
To:     alexander.h.duyck@intel.com
Cc:     akpm@linux-foundation.org, alexander.duyck@gmail.com,
        aryabinin@virtuozzo.com, cgroups@vger.kernel.org,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        iamjoonsoo.kim@lge.com, khlebnikov@yandex-team.ru,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lkp@intel.com, mgorman@techsingularity.net,
        richard.weiyang@gmail.com, rong.a.chen@intel.com,
        shakeelb@google.com, tglx@linutronix.de, tj@kernel.org,
        willy@infradead.org, yang.shi@linux.alibaba.com
References: <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
 <159622999150.2576729.14455020813024958573.stgit@ahduyck-desk1.jf.intel.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0c0a415a-52a0-5c06-b4be-80cbd3cb49c2@linux.alibaba.com>
Date:   Sat, 1 Aug 2020 07:54:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159622999150.2576729.14455020813024958573.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It looks much better than mine. and could replace 'mm/lru: introduce the relock_page_lruvec function'
with your author signed. :)

BTW,
it's the rcu_read_lock cause the will-it-scale/page_fault3 regression which you mentained in another
letter?

Thanks
Alex

在 2020/8/1 上午5:14, alexander.h.duyck@intel.com 写道:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> When testing for relock we can avoid the need for RCU locking if we simply
> compare the page pgdat and memcg pointers versus those that the lruvec is
> holding. By doing this we can avoid the extra pointer walks and accesses of
> the memory cgroup.
> 
> In addition we can avoid the checks entirely if lruvec is currently NULL.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  include/linux/memcontrol.h |   52 +++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6e670f991b42..7a02f00bf3de 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -405,6 +405,22 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  
>  struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
>  
> +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> +					      struct lruvec *lruvec)
> +{
> +	pg_data_t *pgdat = page_pgdat(page);
> +	const struct mem_cgroup *memcg;
> +	struct mem_cgroup_per_node *mz;
> +
> +	if (mem_cgroup_disabled())
> +		return lruvec == &pgdat->__lruvec;
> +
> +	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> +	memcg = page->mem_cgroup ? : root_mem_cgroup;
> +
> +	return lruvec->pgdat == pgdat && mz->memcg == memcg;
> +}
> +
>  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>  
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> @@ -880,6 +896,14 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
>  	return &pgdat->__lruvec;
>  }
>  
> +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> +					      struct lruvec *lruvec)
> +{
> +		pg_data_t *pgdat = page_pgdat(page);
> +
> +		return lruvec == &pgdat->__lruvec;
> +}
> +
>  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
>  {
>  	return NULL;
> @@ -1317,18 +1341,12 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>  static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>  		struct lruvec *locked_lruvec)
>  {
> -	struct pglist_data *pgdat = page_pgdat(page);
> -	bool locked;
> +	if (locked_lruvec) {
> +		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> +			return locked_lruvec;
>  
> -	rcu_read_lock();
> -	locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
> -	rcu_read_unlock();
> -
> -	if (locked)
> -		return locked_lruvec;
> -
> -	if (locked_lruvec)
>  		unlock_page_lruvec_irq(locked_lruvec);
> +	}
>  
>  	return lock_page_lruvec_irq(page);
>  }
> @@ -1337,18 +1355,12 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>  static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
>  		struct lruvec *locked_lruvec, unsigned long *flags)
>  {
> -	struct pglist_data *pgdat = page_pgdat(page);
> -	bool locked;
> -
> -	rcu_read_lock();
> -	locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
> -	rcu_read_unlock();
> -
> -	if (locked)
> -		return locked_lruvec;
> +	if (locked_lruvec) {
> +		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> +			return locked_lruvec;
>  
> -	if (locked_lruvec)
>  		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
> +	}
>  
>  	return lock_page_lruvec_irqsave(page, flags);
>  }
> 
