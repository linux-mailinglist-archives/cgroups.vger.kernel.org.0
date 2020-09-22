Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0D273A29
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgIVF2O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 01:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgIVF2N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 01:28:13 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308CC0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:28:13 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id h8so3842791ooc.12
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CqOvVrpGj6f5XVWsB4f84cUoYxcg7xxLUooh0yyLvTM=;
        b=DN02zx0zZWPjDTe1cpUfOnE9tGPw+9E28N72cEIr+Gq4SwDh8znLmzH0jLXC0ai6ZP
         6urBcV48s0EL1gO95YdC/Veo26dHuaXe4UtWL4IKpqgSS5Id1TP6+FAE16aRuEsHVEvG
         7UPVFF7wESxwxgEhcklxYdlGJjLUOBmhFdMAyBbvN1rJY/T/0L3BnewQ0uFYEtXpT9iy
         Cpzrh5xtz6R1QxwMeB1c2AGmbRkKjt+nqg1n/+xL/J0l2mX7jILmh0w0fp6si8z21WmZ
         QSnvMQZx3M3wK6V7rO/DuxsR9DiJncMBIe8O4dRH9CHd8K93nXdUZDroWmHHXNqRk82R
         PmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CqOvVrpGj6f5XVWsB4f84cUoYxcg7xxLUooh0yyLvTM=;
        b=kN/9I9qFdr8Y9/hSkhIWmp8i+uL+19gS30pdvj1pxL3nmaSEDUsMbRJYR1eXmkxWFq
         WClVcRJcJom643/q4hRRR2feINe6yzEZU4mAkiNcve344rdWq8Aw3QGJCuz4bepUrlcm
         GA5IqVrKzYRTUbEVMf1g/GH3/bX0TkbLUflXDycTtg7VsE1iRZvSRzBNdx4rXkuy2C4U
         JmtKWPCVXshp7GGPAJLZXd9RMNAZmtZuu9T6fQ3eWuLdZmFmYTqCmnoqX7jCVCTZVf2w
         TOim4T6/S9a8nZn8D9fexE5iXRGWsvMDe0sSaA3eniRAKT2VjXNTSDAQpAV8mF4cfpR1
         JxuA==
X-Gm-Message-State: AOAM533Dsm0eYiXbE4XgJiK+TxZorEo0AAJ9KlbCwbXw7xGZ1d9S66tV
        X55a8YlwBsJOCvoWIIJ7PgPrOQ==
X-Google-Smtp-Source: ABdhPJy+my/2kkaY08IviFiDOP9i0rzAmAFMEShhXs/gIn2SVwFhg5BDGbd9tbU3n0/hrlUd5hqppg==
X-Received: by 2002:a4a:95f1:: with SMTP id p46mr1779987ooi.93.1600752492061;
        Mon, 21 Sep 2020 22:28:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p16sm6562029otl.17.2020.09.21.22.28.09
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 22:28:10 -0700 (PDT)
Date:   Mon, 21 Sep 2020 22:27:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH v18 20/32] mm/lru: replace pgdat lru_lock with lruvec
 lock
In-Reply-To: <1598273705-69124-21-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009211908080.6434@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-21-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
> each of memcg per node. So on a large machine, each of memcg don't
> have to suffer from per node pgdat->lru_lock competition. They could go
> fast with their self lru_lock.
> 
> After move memcg charge before lru inserting, page isolation could
> serialize page's memcg, then per memcg lruvec lock is stable and could
> replace per node lru lock.
> 
> In func isolate_migratepages_block, compact_unlock_should_abort is
> opend, and lock_page_lruvec logical is embedded for tight process.

Hard to understand: perhaps:

In func isolate_migratepages_block, compact_unlock_should_abort and
lock_page_lruvec_irqsave are open coded to work with compact_control.

> Also add a debug func in locking which may give some clues if there are
> sth out of hands.
> 
> According to Daniel Jordan's suggestion, I run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

s/modeified/modified/
lruv19 has an lkml.org link there, please substitute
https://lore.kernel.org/lkml/01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com/

> 
> With this and later patches, the readtwice performance increases
> about 80% within concurrent containers.
> 
> On a large machine with memcg enabled but not used, the page's lruvec
> seeking pass a few pointers, that may lead to lru_lock holding time
> increase and a bit regression.
> 
> Hugh Dickins helped on patch polish, thanks!
> 
> Reported-by: kernel test robot <lkp@intel.com>

Eh? It may have reported some locking bugs somewhere, but this
is the main patch of your per-memcg lru_lock: I don't think the
kernel test robot inspired your whole design, did it?  Delete that.


> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

I can't quite Ack this one yet, because there are several functions
(mainly __munlock_pagevec and check_move_unevictable_pages) which are
not right in this v18 version, and a bit tricky to correct: I already
suggested what to do in other mail, but this patch comes before
relock_page_lruvec, so must look different from the final result;
I need to look at a later version, perhaps already there in your
github tree, before I can Ack: but it's not far off.
Comments below.

> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> ---
>  include/linux/memcontrol.h |  58 +++++++++++++++++++++++++
>  include/linux/mmzone.h     |   2 +
>  mm/compaction.c            |  56 +++++++++++++++---------
>  mm/huge_memory.c           |  11 ++---
>  mm/memcontrol.c            |  60 +++++++++++++++++++++++++-
>  mm/mlock.c                 |  47 +++++++++++++-------
>  mm/mmzone.c                |   1 +
>  mm/swap.c                  | 105 +++++++++++++++++++++------------------------
>  mm/vmscan.c                |  70 +++++++++++++++++-------------
>  9 files changed, 279 insertions(+), 131 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d0b036123c6a..7b170e9028b5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -494,6 +494,19 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  
>  struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
>  
> +struct lruvec *lock_page_lruvec(struct page *page);
> +struct lruvec *lock_page_lruvec_irq(struct page *page);
> +struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> +						unsigned long *flags);
> +
> +#ifdef CONFIG_DEBUG_VM
> +void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
> +#else
> +static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +{
> +}
> +#endif
> +
>  static inline
>  struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>  	return css ? container_of(css, struct mem_cgroup, css) : NULL;
> @@ -1035,6 +1048,31 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
>  
> +static inline struct lruvec *lock_page_lruvec(struct page *page)
> +{
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	spin_lock(&pgdat->__lruvec.lru_lock);
> +	return &pgdat->__lruvec;
> +}
> +
> +static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
> +{
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	spin_lock_irq(&pgdat->__lruvec.lru_lock);
> +	return &pgdat->__lruvec;
> +}
> +
> +static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> +		unsigned long *flagsp)
> +{
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
> +	return &pgdat->__lruvec;
> +}
> +
>  static inline struct mem_cgroup *
>  mem_cgroup_iter(struct mem_cgroup *root,
>  		struct mem_cgroup *prev,
> @@ -1282,6 +1320,10 @@ static inline void count_memcg_page_event(struct page *page,
>  void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  {
>  }
> +
> +static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +{
> +}
>  #endif /* CONFIG_MEMCG */
>  
>  /* idx can be of type enum memcg_stat_item or node_stat_item */
> @@ -1411,6 +1453,22 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
>  	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
>  }
>  
> +static inline void unlock_page_lruvec(struct lruvec *lruvec)
> +{
> +	spin_unlock(&lruvec->lru_lock);
> +}
> +
> +static inline void unlock_page_lruvec_irq(struct lruvec *lruvec)
> +{
> +	spin_unlock_irq(&lruvec->lru_lock);
> +}
> +
> +static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
> +		unsigned long flags)
> +{
> +	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> +}
> +

I may have trouble deciding when to use the unlock_page_lruvec
wrapper and when to use the direct spin_unlock: but your choices
throughout looked sensible to me.

>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8379432f4f2f..27a1513a43fc 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -273,6 +273,8 @@ enum lruvec_flags {
>  };
>  
>  struct lruvec {
> +	/* per lruvec lru_lock for memcg */
> +	spinlock_t			lru_lock;
>  	struct list_head		lists[NR_LRU_LISTS];
>  	/*
>  	 * These track the cost of reclaiming one LRU - file or anon -
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 253382d99969..b724eacf6421 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -805,7 +805,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	unsigned long nr_scanned = 0, nr_isolated = 0;
>  	struct lruvec *lruvec;
>  	unsigned long flags = 0;
> -	bool locked = false;
> +	struct lruvec *locked = NULL;
>  	struct page *page = NULL, *valid_page = NULL;
>  	unsigned long start_pfn = low_pfn;
>  	bool skip_on_failure = false;
> @@ -865,11 +865,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		 * contention, to give chance to IRQs. Abort completely if
>  		 * a fatal signal is pending.
>  		 */
> -		if (!(low_pfn % SWAP_CLUSTER_MAX)
> -		    && compact_unlock_should_abort(&pgdat->lru_lock,
> -					    flags, &locked, cc)) {
> -			low_pfn = 0;
> -			goto fatal_pending;
> +		if (!(low_pfn % SWAP_CLUSTER_MAX)) {
> +			if (locked) {
> +				unlock_page_lruvec_irqrestore(locked, flags);
> +				locked = NULL;
> +			}
> +
> +			if (fatal_signal_pending(current)) {
> +				cc->contended = true;
> +
> +				low_pfn = 0;
> +				goto fatal_pending;
> +			}
> +
> +			cond_resched();
>  		}
>  
>  		if (!pfn_valid_within(low_pfn))
> @@ -941,9 +950,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  			if (unlikely(__PageMovable(page)) &&
>  					!PageIsolated(page)) {
>  				if (locked) {
> -					spin_unlock_irqrestore(&pgdat->lru_lock,
> -									flags);
> -					locked = false;
> +					unlock_page_lruvec_irqrestore(locked, flags);
> +					locked = NULL;
>  				}
>  
>  				if (!isolate_movable_page(page, isolate_mode))
> @@ -984,10 +992,19 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!TestClearPageLRU(page))
>  			goto isolate_fail_put;
>  
> +		rcu_read_lock();
> +		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +
>  		/* If we already hold the lock, we can skip some rechecking */
> -		if (!locked) {
> -			locked = compact_lock_irqsave(&pgdat->lru_lock,
> -								&flags, cc);
> +		if (lruvec != locked) {
> +			if (locked)
> +				unlock_page_lruvec_irqrestore(locked, flags);
> +
> +			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> +			locked = lruvec;
> +			rcu_read_unlock();
> +
> +			lruvec_memcg_debug(lruvec, page);
>  
>  			/* Try get exclusive access under lock */
>  			if (!skip_updated) {
> @@ -1006,9 +1023,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  				SetPageLRU(page);
>  				goto isolate_fail_put;
>  			}
> -		}
> -
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		} else
> +			rcu_read_unlock();
>  
>  		/* The whole page is taken off the LRU; skip the tail pages. */
>  		if (PageCompound(page))
> @@ -1042,8 +1058,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  isolate_fail_put:
>  		/* Avoid potential deadlock in freeing page under lru_lock */
>  		if (locked) {
> -			spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> -			locked = false;
> +			unlock_page_lruvec_irqrestore(locked, flags);
> +			locked = NULL;
>  		}
>  		put_page(page);
>  
> @@ -1058,8 +1074,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		 */
>  		if (nr_isolated) {
>  			if (locked) {
> -				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> -				locked = false;
> +				unlock_page_lruvec_irqrestore(locked, flags);
> +				locked = NULL;
>  			}
>  			putback_movable_pages(&cc->migratepages);
>  			cc->nr_migratepages = 0;
> @@ -1087,7 +1103,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  
>  isolate_abort:
>  	if (locked)
> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +		unlock_page_lruvec_irqrestore(locked, flags);
>  	if (page) {
>  		SetPageLRU(page);
>  		put_page(page);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6380c925e904..c9e08fdc08e9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2319,7 +2319,7 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>  	VM_BUG_ON_PAGE(PageCompound(page_tail), head);
>  	VM_BUG_ON_PAGE(PageLRU(page_tail), head);
> -	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> +	lockdep_assert_held(&lruvec->lru_lock);
>  
>  	if (list) {
>  		/* page reclaim is reclaiming a huge page */
> @@ -2403,7 +2403,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  			      pgoff_t end)
>  {
>  	struct page *head = compound_head(page);
> -	pg_data_t *pgdat = page_pgdat(head);
>  	struct lruvec *lruvec;
>  	struct address_space *swap_cache = NULL;
>  	unsigned long offset = 0;
> @@ -2420,10 +2419,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		xa_lock(&swap_cache->i_pages);
>  	}
>  
> -	/* prevent PageLRU to go away from under us, and freeze lru stats */
> -	spin_lock(&pgdat->lru_lock);
> -
> -	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> +	/* lock lru list/PageCompound, ref freezed by page_ref_freeze */
> +	lruvec = lock_page_lruvec(head);
>  
>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>  		__split_huge_page_tail(head, i, lruvec, list);
> @@ -2444,7 +2441,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	}
>  
>  	ClearPageCompound(head);
> -	spin_unlock(&pgdat->lru_lock);
> +	unlock_page_lruvec(lruvec);
>  	/* Caller disabled irqs, so they are still disabled here */
>  
>  	split_page_owner(head, HPAGE_PMD_ORDER);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 65c1e873153e..5b95529e64a4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1302,6 +1302,19 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_DEBUG_VM
> +void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	if (!page->mem_cgroup)
> +		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
> +	else
> +		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
> +}
> +#endif

That function is not very effective, but I don't see how to improve it
either: the trouble is, it gets called to confirm what has just been
decided a moment before, when it would be much more powerful if it were
called later, at the time of unlocking - but we generally don't know the
page by then. I'll be tempted just to delete it later on (historically,
bugs have tended to show up as list_debug or update_lru_size warnings);
but we should certainly leave it in for now.

> +
>  /**
>   * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
>   * @page: the page
> @@ -1341,6 +1354,51 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	return lruvec;
>  }
>  
> +struct lruvec *lock_page_lruvec(struct page *page)
> +{
> +	struct lruvec *lruvec;
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	rcu_read_lock();
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	spin_lock(&lruvec->lru_lock);
> +	rcu_read_unlock();
> +
> +	lruvec_memcg_debug(lruvec, page);
> +
> +	return lruvec;
> +}
> +
> +struct lruvec *lock_page_lruvec_irq(struct page *page)
> +{
> +	struct lruvec *lruvec;
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	rcu_read_lock();
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	spin_lock_irq(&lruvec->lru_lock);
> +	rcu_read_unlock();
> +
> +	lruvec_memcg_debug(lruvec, page);
> +
> +	return lruvec;
> +}
> +
> +struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
> +{
> +	struct lruvec *lruvec;
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	rcu_read_lock();
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> +	rcu_read_unlock();
> +
> +	lruvec_memcg_debug(lruvec, page);
> +
> +	return lruvec;
> +}
> +
>  /**
>   * mem_cgroup_update_lru_size - account for adding or removing an lru page
>   * @lruvec: mem_cgroup per zone lru vector
> @@ -3222,7 +3280,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  
>  /*
>   * Because tail pages are not marked as "used", set it. We're under
> - * pgdat->lru_lock and migration entries setup in all page mappings.
> + * lruvec->lru_lock and migration entries setup in all page mappings.
>   */
>  void mem_cgroup_split_huge_fixup(struct page *head)
>  {

Don't you come back to that comment in 23/32, correctly changing
"We're under" to "Don't need". Might as well get the comment right
in one place or the other, I don't mind which (get it right in this
one and 23/32 need not touch mm/memcontrol.c).  The reference to
"used" goes back several years, to when there was a special flag to
mark a page as charged: now it's just done by setting mem_cgroup,
so I think the comment should just say:

* Because page->mem_cgroup is not set on compound tails, set it now.

I tried to make sense of "and migration entries setup in all page
mappings" but couldn't: oh, it means that the page is unmapped from
userspace at this point; well, that's true, but irrelevant here.
No need to mention that or the lru_lock here at all.

> diff --git a/mm/mlock.c b/mm/mlock.c
> index 3762d9dd5b31..177d2588e863 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -105,12 +105,10 @@ void mlock_vma_page(struct page *page)
>   * Isolate a page from LRU with optional get_page() pin.
>   * Assumes lru_lock already held and page already pinned.
>   */
> -static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
> +static bool __munlock_isolate_lru_page(struct page *page,
> +				struct lruvec *lruvec, bool getpage)
>  {
>  	if (TestClearPageLRU(page)) {
> -		struct lruvec *lruvec;
> -
> -		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>  		if (getpage)
>  			get_page(page);
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
> @@ -180,7 +178,7 @@ static void __munlock_isolation_failed(struct page *page)
>  unsigned int munlock_vma_page(struct page *page)
>  {
>  	int nr_pages;
> -	pg_data_t *pgdat = page_pgdat(page);
> +	struct lruvec *lruvec;
>  
>  	/* For try_to_munlock() and to serialize with page migration */
>  	BUG_ON(!PageLocked(page));
> @@ -188,11 +186,16 @@ unsigned int munlock_vma_page(struct page *page)
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
>  	/*
> -	 * Serialize with any parallel __split_huge_page_refcount() which
> +	 * Serialize split tail pages in __split_huge_page_tail() which
>  	 * might otherwise copy PageMlocked to part of the tail pages before
>  	 * we clear it in the head page. It also stabilizes thp_nr_pages().
> +	 * TestClearPageLRU can't be used here to block page isolation, since
> +	 * out of lock clear_page_mlock may interfer PageLRU/PageMlocked
> +	 * sequence, same as __pagevec_lru_add_fn, and lead the page place to
> +	 * wrong lru list here. So relay on PageLocked to stop lruvec change
> +	 * in mem_cgroup_move_account().
>  	 */

I have elsewhere recommended just deleting all of that comment, typos
(interfere, rely) and misunderstandings and all. But you are right that
PageLocked keeps mem_cgroup_move_account() out there.

> -	spin_lock_irq(&pgdat->lru_lock);
> +	lruvec = lock_page_lruvec_irq(page);
>  
>  	if (!TestClearPageMlocked(page)) {
>  		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
> @@ -203,15 +206,15 @@ unsigned int munlock_vma_page(struct page *page)
>  	nr_pages = thp_nr_pages(page);
>  	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>  
> -	if (__munlock_isolate_lru_page(page, true)) {
> -		spin_unlock_irq(&pgdat->lru_lock);
> +	if (__munlock_isolate_lru_page(page, lruvec, true)) {
> +		unlock_page_lruvec_irq(lruvec);
>  		__munlock_isolated_page(page);
>  		goto out;
>  	}
>  	__munlock_isolation_failed(page);
>  
>  unlock_out:
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	unlock_page_lruvec_irq(lruvec);
>  
>  out:
>  	return nr_pages - 1;
> @@ -291,23 +294,34 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>  	int nr = pagevec_count(pvec);
>  	int delta_munlocked = -nr;
>  	struct pagevec pvec_putback;
> +	struct lruvec *lruvec = NULL;
>  	int pgrescued = 0;
>  
>  	pagevec_init(&pvec_putback);
>  
>  	/* Phase 1: page isolation */
> -	spin_lock_irq(&zone->zone_pgdat->lru_lock);
>  	for (i = 0; i < nr; i++) {
>  		struct page *page = pvec->pages[i];
> +		struct lruvec *new_lruvec;
> +
> +		/* block memcg change in mem_cgroup_move_account */
> +		lock_page_memcg(page);

And elsewhere I've explained that lock_page_memcg() before
lock_page_lruvec() is good there the first time round the loop,
but the second time it is trying to lock_page_memcg() while
still holding lruvec lock: possibility of deadlock, not good.
I'll need to check your next version of this patch before Acking.

> +		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +		if (new_lruvec != lruvec) {
> +			if (lruvec)
> +				unlock_page_lruvec_irq(lruvec);
> +			lruvec = lock_page_lruvec_irq(page);
> +		}
>  
>  		if (TestClearPageMlocked(page)) {
>  			/*
>  			 * We already have pin from follow_page_mask()
>  			 * so we can spare the get_page() here.
>  			 */
> -			if (__munlock_isolate_lru_page(page, false))
> +			if (__munlock_isolate_lru_page(page, lruvec, false)) {
> +				unlock_page_memcg(page);
>  				continue;
> -			else
> +			} else
>  				__munlock_isolation_failed(page);
>  		} else {
>  			delta_munlocked++;
> @@ -319,11 +333,14 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>  		 * pin. We cannot do it under lru_lock however. If it's
>  		 * the last pin, __page_cache_release() would deadlock.
>  		 */
> +		unlock_page_memcg(page);
>  		pagevec_add(&pvec_putback, pvec->pages[i]);
>  		pvec->pages[i] = NULL;
>  	}
> -	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> -	spin_unlock_irq(&zone->zone_pgdat->lru_lock);
> +	if (lruvec) {
> +		__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> +		unlock_page_lruvec_irq(lruvec);
> +	}
>  
>  	/* Now we can release pins of pages that we are not munlocking */
>  	pagevec_release(&pvec_putback);
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index 4686fdc23bb9..3750a90ed4a0 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -91,6 +91,7 @@ void lruvec_init(struct lruvec *lruvec)
>  	enum lru_list lru;
>  
>  	memset(lruvec, 0, sizeof(struct lruvec));
> +	spin_lock_init(&lruvec->lru_lock);
>  
>  	for_each_lru(lru)
>  		INIT_LIST_HEAD(&lruvec->lists[lru]);
> diff --git a/mm/swap.c b/mm/swap.c
> index 2d9a86bf93a4..b67959b701c0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -79,15 +79,13 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
>  static void __page_cache_release(struct page *page)
>  {
>  	if (PageLRU(page)) {
> -		pg_data_t *pgdat = page_pgdat(page);
>  		struct lruvec *lruvec;
>  		unsigned long flags;
>  
>  		__ClearPageLRU(page);
> -		spin_lock_irqsave(&pgdat->lru_lock, flags);
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		lruvec = lock_page_lruvec_irqsave(page, &flags);
>  		del_page_from_lru_list(page, lruvec, page_off_lru(page));
> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +		unlock_page_lruvec_irqrestore(lruvec, flags);

This is where I asked you to drop a hunk from the TestClearPageLRU
patch; and a VM_BUG_ON_PAGE(!PageLRU) went missing. I agree it looks
very weird immediately after checking PageLRU, but IIRC years ago it
did actually catch some racy bugs, so I guess better to retain it.

I suppose it's then best to keep to the original ordering,
lock, BUG, __Clear, del, unlock - to widen the gap between the PageLRU
checks - though usually we would prefer to BUG outside of holding a lock.

>  	}
>  	__ClearPageWaiters(page);
>  }
> @@ -206,32 +204,30 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  	void (*move_fn)(struct page *page, struct lruvec *lruvec))
>  {
>  	int i;
> -	struct pglist_data *pgdat = NULL;
> -	struct lruvec *lruvec;
> +	struct lruvec *lruvec = NULL;
>  	unsigned long flags = 0;
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
> -		struct pglist_data *pagepgdat = page_pgdat(page);
> -
> -		if (pagepgdat != pgdat) {
> -			if (pgdat)
> -				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> -			pgdat = pagepgdat;
> -			spin_lock_irqsave(&pgdat->lru_lock, flags);
> -		}
> +		struct lruvec *new_lruvec;
>  
>  		/* block memcg migration during page moving between lru */
>  		if (!TestClearPageLRU(page))
>  			continue;
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +		if (lruvec != new_lruvec) {
> +			if (lruvec)
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +			lruvec = lock_page_lruvec_irqsave(page, &flags);
> +		}
> +
>  		(*move_fn)(page, lruvec);
>  
>  		SetPageLRU(page);
>  	}
> -	if (pgdat)
> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +	if (lruvec)
> +		unlock_page_lruvec_irqrestore(lruvec, flags);
>  	release_pages(pvec->pages, pvec->nr);
>  	pagevec_reinit(pvec);
>  }
> @@ -274,9 +270,8 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>  {
>  	do {
>  		unsigned long lrusize;
> -		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  
> -		spin_lock_irq(&pgdat->lru_lock);
> +		spin_lock_irq(&lruvec->lru_lock);
>  		/* Record cost event */
>  		if (file)
>  			lruvec->file_cost += nr_pages;
> @@ -300,7 +295,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>  			lruvec->file_cost /= 2;
>  			lruvec->anon_cost /= 2;
>  		}
> -		spin_unlock_irq(&pgdat->lru_lock);
> +		spin_unlock_irq(&lruvec->lru_lock);
>  	} while ((lruvec = parent_lruvec(lruvec)));
>  }
>  
> @@ -364,13 +359,13 @@ static inline void activate_page_drain(int cpu)
>  
>  void activate_page(struct page *page)
>  {
> -	pg_data_t *pgdat = page_pgdat(page);
> +	struct lruvec *lruvec;
>  
>  	page = compound_head(page);
> -	spin_lock_irq(&pgdat->lru_lock);
> +	lruvec = lock_page_lruvec_irq(page);
>  	if (PageLRU(page))
> -		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
> -	spin_unlock_irq(&pgdat->lru_lock);
> +		__activate_page(page, lruvec);
> +	unlock_page_lruvec_irq(lruvec);
>  }
>  #endif
>  
> @@ -819,8 +814,7 @@ void release_pages(struct page **pages, int nr)
>  {
>  	int i;
>  	LIST_HEAD(pages_to_free);
> -	struct pglist_data *locked_pgdat = NULL;
> -	struct lruvec *lruvec;
> +	struct lruvec *lruvec = NULL;
>  	unsigned long flags;
>  	unsigned int lock_batch;
>  
> @@ -830,21 +824,20 @@ void release_pages(struct page **pages, int nr)
>  		/*
>  		 * Make sure the IRQ-safe lock-holding time does not get
>  		 * excessive with a continuous string of pages from the
> -		 * same pgdat. The lock is held only if pgdat != NULL.
> +		 * same lruvec. The lock is held only if lruvec != NULL.
>  		 */
> -		if (locked_pgdat && ++lock_batch == SWAP_CLUSTER_MAX) {
> -			spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
> -			locked_pgdat = NULL;
> +		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
> +			unlock_page_lruvec_irqrestore(lruvec, flags);
> +			lruvec = NULL;
>  		}
>  
>  		if (is_huge_zero_page(page))
>  			continue;
>  
>  		if (is_zone_device_page(page)) {
> -			if (locked_pgdat) {
> -				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> -						       flags);
> -				locked_pgdat = NULL;
> +			if (lruvec) {
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +				lruvec = NULL;
>  			}
>  			/*
>  			 * ZONE_DEVICE pages that return 'false' from
> @@ -863,29 +856,29 @@ void release_pages(struct page **pages, int nr)
>  			continue;
>  
>  		if (PageCompound(page)) {
> -			if (locked_pgdat) {
> -				spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
> -				locked_pgdat = NULL;
> +			if (lruvec) {
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +				lruvec = NULL;
>  			}
>  			__put_compound_page(page);
>  			continue;
>  		}
>  
>  		if (PageLRU(page)) {
> -			struct pglist_data *pgdat = page_pgdat(page);
> +			struct lruvec *new_lruvec;
>  
> -			if (pgdat != locked_pgdat) {
> -				if (locked_pgdat)
> -					spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> +			new_lruvec = mem_cgroup_page_lruvec(page,
> +							page_pgdat(page));
> +			if (new_lruvec != lruvec) {
> +				if (lruvec)
> +					unlock_page_lruvec_irqrestore(lruvec,
>  									flags);
>  				lock_batch = 0;
> -				locked_pgdat = pgdat;
> -				spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
> +				lruvec = lock_page_lruvec_irqsave(page, &flags);
>  			}
>  
>  			VM_BUG_ON_PAGE(!PageLRU(page), page);
>  			__ClearPageLRU(page);
> -			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>  			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  		}
>  
> @@ -895,8 +888,8 @@ void release_pages(struct page **pages, int nr)
>  
>  		list_add(&page->lru, &pages_to_free);
>  	}
> -	if (locked_pgdat)
> -		spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
> +	if (lruvec)
> +		unlock_page_lruvec_irqrestore(lruvec, flags);
>  
>  	mem_cgroup_uncharge_list(&pages_to_free);
>  	free_unref_page_list(&pages_to_free);
> @@ -984,26 +977,24 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>  void __pagevec_lru_add(struct pagevec *pvec)
>  {
>  	int i;
> -	struct pglist_data *pgdat = NULL;
> -	struct lruvec *lruvec;
> +	struct lruvec *lruvec = NULL;
>  	unsigned long flags = 0;
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
> -		struct pglist_data *pagepgdat = page_pgdat(page);
> +		struct lruvec *new_lruvec;
>  
> -		if (pagepgdat != pgdat) {
> -			if (pgdat)
> -				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> -			pgdat = pagepgdat;
> -			spin_lock_irqsave(&pgdat->lru_lock, flags);
> +		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +		if (lruvec != new_lruvec) {
> +			if (lruvec)
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +			lruvec = lock_page_lruvec_irqsave(page, &flags);
>  		}
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		__pagevec_lru_add_fn(page, lruvec);
>  	}
> -	if (pgdat)
> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +	if (lruvec)
> +		unlock_page_lruvec_irqrestore(lruvec, flags);
>  	release_pages(pvec->pages, pvec->nr);
>  	pagevec_reinit(pvec);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 48b50695f883..789444ae4c88 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1768,15 +1768,13 @@ int isolate_lru_page(struct page *page)
>  	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
>  
>  	if (TestClearPageLRU(page)) {
> -		pg_data_t *pgdat = page_pgdat(page);
>  		struct lruvec *lruvec;
>  		int lru = page_lru(page);
>  
>  		get_page(page);
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -		spin_lock_irq(&pgdat->lru_lock);
> +		lruvec = lock_page_lruvec_irq(page);
>  		del_page_from_lru_list(page, lruvec, lru);
> -		spin_unlock_irq(&pgdat->lru_lock);
> +		unlock_page_lruvec_irq(lruvec);
>  		ret = 0;
>  	}
>  
> @@ -1843,20 +1841,22 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>  static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  						     struct list_head *list)
>  {
> -	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> +	struct lruvec *orig_lruvec = lruvec;
>  	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
> +		struct lruvec *new_lruvec = NULL;
> +
>  		page = lru_to_page(list);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
>  		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			spin_unlock_irq(&pgdat->lru_lock);
> +			spin_unlock_irq(&lruvec->lru_lock);
>  			putback_lru_page(page);
> -			spin_lock_irq(&pgdat->lru_lock);
> +			spin_lock_irq(&lruvec->lru_lock);
>  			continue;
>  		}
>  
> @@ -1871,6 +1871,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 *     list_add(&page->lru,)
>  		 *                                        list_add(&page->lru,)
>  		 */
> +		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +		if (new_lruvec != lruvec) {
> +			if (lruvec)
> +				spin_unlock_irq(&lruvec->lru_lock);
> +			lruvec = lock_page_lruvec_irq(page);
> +		}
>  		SetPageLRU(page);
>  
>  		if (unlikely(put_page_testzero(page))) {
> @@ -1878,16 +1884,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  			__ClearPageActive(page);
>  
>  			if (unlikely(PageCompound(page))) {
> -				spin_unlock_irq(&pgdat->lru_lock);
> +				spin_unlock_irq(&lruvec->lru_lock);
>  				destroy_compound_page(page);
> -				spin_lock_irq(&pgdat->lru_lock);
> +				spin_lock_irq(&lruvec->lru_lock);
>  			} else
>  				list_add(&page->lru, &pages_to_free);
>  
>  			continue;
>  		}
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		lru = page_lru(page);
>  		nr_pages = thp_nr_pages(page);
>  
> @@ -1897,6 +1902,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		if (PageActive(page))
>  			workingset_age_nonresident(lruvec, nr_pages);
>  	}
> +	if (orig_lruvec != lruvec) {
> +		if (lruvec)
> +			spin_unlock_irq(&lruvec->lru_lock);
> +		spin_lock_irq(&orig_lruvec->lru_lock);
> +	}
>  
>  	/*
>  	 * To save our caller's stack, now use input list for pages to free.

No, AlexD was right, most of these changes in move_pages_to_lru(),
saving orig_lruvec, and allowing for change of lruvec from one page
to the next, are not necessary, and the patch much nicer without them.

All you need here is the change from pgdat to lruvec,
and add a check that that lruvec really is not changing:
		VM_BUG_ON_PAGE(mem_cgroup_page_lruvec(page, page_pgdat(page))
							!= lruvec, page);
after the VM_BUG_ON_PAGE(PageLRU) at the head of the loop in this patch,
which can be updated to the nicer
		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec),
								page);
in the next patch, where that function becomes available.

It certainly used to be true that move_pages_to_lru() had to allow
for lruvec to change; and that was still true at the time of my v5.3
tarball; but down the years the various reasons for it have gone away,
most recently with Johannes's swapcache charging simplifications.

I did see your mail to AlexD, where you showed a NULL deref you had
hit in move_pages_to_lru() two months ago.  I spent quite a while
puzzling over that last night, but don't have an explanation, and
don't know exactly what source you were built from when you hit it.
I had hoped to explain it by that bug I've fixed in v5.9-rc6:
62fdb1632bcb ("ksm: reinstate memcg charge on copied pages")
but did not quite succeed in explaining it that way.

And you said that you haven't hit it again recently.  Whatever,
I don't see it as any reason for keeping the more complicated and
unnecessary code in move_pages_to_lru(): if we hit such a bug again,
then we investigate it.

> @@ -1952,7 +1962,7 @@ static int current_may_throttle(void)
>  
>  	lru_add_drain();
>  
> -	spin_lock_irq(&pgdat->lru_lock);
> +	spin_lock_irq(&lruvec->lru_lock);
>  
>  	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
>  				     &nr_scanned, sc, lru);
> @@ -1964,7 +1974,7 @@ static int current_may_throttle(void)
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>  	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
>  
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	spin_unlock_irq(&lruvec->lru_lock);
>  
>  	if (nr_taken == 0)
>  		return 0;
> @@ -1972,7 +1982,7 @@ static int current_may_throttle(void)
>  	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
>  				&stat, false);
>  
> -	spin_lock_irq(&pgdat->lru_lock);
> +	spin_lock_irq(&lruvec->lru_lock);
>  	move_pages_to_lru(lruvec, &page_list);
>  
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> @@ -1981,7 +1991,7 @@ static int current_may_throttle(void)
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>  	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	spin_unlock_irq(&lruvec->lru_lock);
>  
>  	lru_note_cost(lruvec, file, stat.nr_pageout);
>  	mem_cgroup_uncharge_list(&page_list);
> @@ -2034,7 +2044,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  
>  	lru_add_drain();
>  
> -	spin_lock_irq(&pgdat->lru_lock);
> +	spin_lock_irq(&lruvec->lru_lock);
>  
>  	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
>  				     &nr_scanned, sc, lru);
> @@ -2045,7 +2055,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  		__count_vm_events(PGREFILL, nr_scanned);
>  	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
>  
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	spin_unlock_irq(&lruvec->lru_lock);
>  
>  	while (!list_empty(&l_hold)) {
>  		cond_resched();
> @@ -2091,7 +2101,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	/*
>  	 * Move pages back to the lru list.
>  	 */
> -	spin_lock_irq(&pgdat->lru_lock);
> +	spin_lock_irq(&lruvec->lru_lock);
>  
>  	nr_activate = move_pages_to_lru(lruvec, &l_active);
>  	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
> @@ -2102,7 +2112,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
>  
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	spin_unlock_irq(&lruvec->lru_lock);
>  
>  	mem_cgroup_uncharge_list(&l_active);
>  	free_unref_page_list(&l_active);
> @@ -2684,10 +2694,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	/*
>  	 * Determine the scan balance between anon and file LRUs.
>  	 */
> -	spin_lock_irq(&pgdat->lru_lock);
> +	spin_lock_irq(&target_lruvec->lru_lock);
>  	sc->anon_cost = target_lruvec->anon_cost;
>  	sc->file_cost = target_lruvec->file_cost;
> -	spin_unlock_irq(&pgdat->lru_lock);
> +	spin_unlock_irq(&target_lruvec->lru_lock);
>  
>  	/*
>  	 * Target desirable inactive:active list ratios for the anon
> @@ -4263,24 +4273,22 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>   */
>  void check_move_unevictable_pages(struct pagevec *pvec)

And as I've described elsewhere, some changes needed here,
that I'll have to check in later versions before Acking this patch.

>  {
> -	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = NULL;
> +	struct lruvec *lruvec = NULL;
>  	int pgscanned = 0;
>  	int pgrescued = 0;
>  	int i;
>  
>  	for (i = 0; i < pvec->nr; i++) {
>  		struct page *page = pvec->pages[i];
> -		struct pglist_data *pagepgdat = page_pgdat(page);
> +		struct lruvec *new_lruvec;
>  
>  		pgscanned++;
> -		if (pagepgdat != pgdat) {
> -			if (pgdat)
> -				spin_unlock_irq(&pgdat->lru_lock);
> -			pgdat = pagepgdat;
> -			spin_lock_irq(&pgdat->lru_lock);
> +		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +		if (lruvec != new_lruvec) {
> +			if (lruvec)
> +				unlock_page_lruvec_irq(lruvec);
> +			lruvec = lock_page_lruvec_irq(page);
>  		}
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
>  		if (!PageLRU(page) || !PageUnevictable(page))
>  			continue;
> @@ -4296,10 +4304,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>  		}
>  	}
>  
> -	if (pgdat) {
> +	if (lruvec) {
>  		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
>  		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> -		spin_unlock_irq(&pgdat->lru_lock);
> +		unlock_page_lruvec_irq(lruvec);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
> -- 
> 1.8.3.1
