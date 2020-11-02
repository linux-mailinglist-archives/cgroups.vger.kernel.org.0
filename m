Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875AD2A3567
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgKBUvz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 15:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgKBUnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 15:43:23 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE58C061A04
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 12:43:23 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id e5so3135205qvr.2
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 12:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AbDs2dN7Jt+QRKOoiLVySZllhw2KT6caTbaTcp411x0=;
        b=wu4XRdNeKLEAXc9VQrMkvhLH9oxsd2GWT4gnPF+3zM+YhzTFgFAxZutNDHrRF3XSGr
         GN1q5got/QTqcYfUDDnTQUYnVMp8TzeVmGr2IVq5BelimKn7vMynjggyMCrl5U75xc7Z
         6zWmec8kkvuPH3RdMBlHIMSAKwMfH90paC4+FCWOFR9R0aMs8sym9UEnntpxi2kyIOzY
         WwagFQ6+Q3q0L2NCwsF31Vbe3m8zHux7mrRC/uIg/rhSIH62mCj6inPWVhBRaftxcjKA
         DywmbMlLj6b73xK1/9/ZAR8a0hbuQa/QhoKW9teHTa1kLgRUA9vMQyZF5M+mMQHswx1u
         NtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AbDs2dN7Jt+QRKOoiLVySZllhw2KT6caTbaTcp411x0=;
        b=d4PbtdM0ZOekMAR/+iDqpxwHtqVqblGlTOI/fDv/jYNrUdoV+a532QsAKwJwMcocfr
         fnVThCWG6QsdSy4Sbrmwu2c0Z8fbmozFskrPYnWYliO+qorMUYYDvhA+ISX/lB+nfs4Z
         +IHLz20R2sqFseUo7dGectNRvG42i2cvtLi0xkzyQcp5/xTa1NqIR2oq7hJSH04gULrm
         vFF0+se9T/PsqypospWsxr7/AkFKkF+SHS2hTqISElCELnc7diLcD3VspHri6pQEEW/4
         CK8FlSMJSPUiwj+zVWx46To4t0d+u9vpJRNbi2DqSvtfM0FyHzo0FuBXvoyXQPXfPITp
         F0zw==
X-Gm-Message-State: AOAM533lIHhOP9xQCQYCVccTRTVRIp+ivbHiY9QBNOkMCQu9rQT938s1
        fxXSFOkVeXcCIHmC2+uqHGcpRQ==
X-Google-Smtp-Source: ABdhPJxZ0/4PDGxqrlvdw+buMsc4rlvHucnM8pqZGHeil05NxW2oOxP7mYZrhOyS4awq7QGIgUvMfA==
X-Received: by 2002:ad4:44b3:: with SMTP id n19mr24015626qvt.39.1604349802186;
        Mon, 02 Nov 2020 12:43:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id j10sm8562102qtn.46.2020.11.02.12.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:21 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:41:36 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
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
Subject: Re: [PATCH v20 18/20] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20201102204136.GB740958@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-19-git-send-email-alex.shi@linux.alibaba.com>
 <ef279dfe-afa5-45cb-4013-6c34169ff55e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef279dfe-afa5-45cb-4013-6c34169ff55e@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 30, 2020 at 10:49:41AM +0800, Alex Shi wrote:
> 
> 
> patch changed since variable renaming in 04th patch:
> 
> From e892e74a35c27e69bebb73d2e4cff54e438f8d7d Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Tue, 18 Aug 2020 16:44:21 +0800
> Subject: [PATCH v21 18/20] mm/lru: replace pgdat lru_lock with lruvec lock
> 
> This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
> each of memcg per node. So on a large machine, each of memcg don't
> have to suffer from per node pgdat->lru_lock competition. They could go
> fast with their self lru_lock.
> 
> After move memcg charge before lru inserting, page isolation could
> serialize page's memcg, then per memcg lruvec lock is stable and could
> replace per node lru lock.
> 
> In func isolate_migratepages_block, compact_unlock_should_abort and
> lock_page_lruvec_irqsave are open coded to work with compact_control.
> Also add a debug func in locking which may give some clues if there are
> sth out of hands.
> 
> Daniel Jordan's testing show 62% improvement on modified readtwice case
> on his 2P * 10 core * 2 HT broadwell box.
> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
> 
> On a large machine with memcg enabled but not used, the page's lruvec
> seeking pass a few pointers, that may lead to lru_lock holding time
> increase and a bit regression.
> 
> Hugh Dickins helped on the patch polish, thanks!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Rong Chen <rong.a.chen@intel.com>
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
>  include/linux/mmzone.h     |   3 +-
>  mm/compaction.c            |  56 +++++++++++++++---------
>  mm/huge_memory.c           |  11 ++---
>  mm/memcontrol.c            |  62 ++++++++++++++++++++++++--
>  mm/mlock.c                 |  22 +++++++---
>  mm/mmzone.c                |   1 +
>  mm/page_alloc.c            |   1 -
>  mm/swap.c                  | 105 +++++++++++++++++++++------------------------
>  mm/vmscan.c                |  55 +++++++++++-------------
>  10 files changed, 249 insertions(+), 125 deletions(-)

This came out really well. Thanks for persisting!

A few inline comments:

> @@ -1367,6 +1380,51 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
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

As these are used quite widely throughout the VM code now, it would be
good to give them kerneldoc comments that explain the interface.

In particular, I think it's necessary to explain the contexts from
which this is safe to use (in particular wrt pages moving between
memcgs - see the comment in commit_charge()).

I'm going to go through the callsites that follow and try to identify
what makes them safe. It's mostly an exercise to double check our
thinking here.

Most of them are straight-forward, and I don't think they warrant
individual comments. But some do, IMO. And it appears at least one
actually isn't safe yet:

> @@ -277,10 +277,16 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>  			 * so we can spare the get_page() here.
>  			 */
>  			if (TestClearPageLRU(page)) {
> -				struct lruvec *lruvec;
> +				struct lruvec *new_lruvec;
> +
> +				new_lruvec = mem_cgroup_page_lruvec(page,
> +						page_pgdat(page));
> +				if (new_lruvec != lruvec) {
> +					if (lruvec)
> +						unlock_page_lruvec_irq(lruvec);
> +					lruvec = lock_page_lruvec_irq(page);

This is safe because PageLRU has been cleared.

> @@ -79,16 +79,14 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
>  static void __page_cache_release(struct page *page)
>  {
>  	if (PageLRU(page)) {
> -		pg_data_t *pgdat = page_pgdat(page);
>  		struct lruvec *lruvec;
>  		unsigned long flags;
>  
> -		spin_lock_irqsave(&pgdat->lru_lock, flags);
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		lruvec = lock_page_lruvec_irqsave(page, &flags);
>  		VM_BUG_ON_PAGE(!PageLRU(page), page);
>  		__ClearPageLRU(page);
>  		del_page_from_lru_list(page, lruvec, page_off_lru(page));
> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +		unlock_page_lruvec_irqrestore(lruvec, flags);

This is safe because the page refcount is 0.

> @@ -207,32 +205,30 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
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

This is safe because PageLRU has been cleared.

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

This is safe because it either comes from

	1) the pinned lruvec in reclaim, or

	2) from a pre-LRU page during refault (which also holds the
	   rcu lock, so would be safe even if the page was on the LRU
	   and could move simultaneously to a new lruvec).

The second one seems a bit tricky. It could be good to add a comment
to lru_note_cost_page() that explains why its mem_cgroup_page_lruvec()
is safe.

> @@ -364,13 +359,13 @@ static inline void activate_page_drain(int cpu)
>  
>  static void activate_page(struct page *page)
>  {
> -	pg_data_t *pgdat = page_pgdat(page);
> +	struct lruvec *lruvec;
>  
>  	page = compound_head(page);
> -	spin_lock_irq(&pgdat->lru_lock);
> +	lruvec = lock_page_lruvec_irq(page);

I don't see what makes this safe. There is nothing that appears to
lock out a concurrent page move between memcgs/lruvecs, which means
the following could manipulate an unlocked lru list:

>  	if (PageLRU(page))
> -		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
> -	spin_unlock_irq(&pgdat->lru_lock);
> +		__activate_page(page, lruvec);
> +	unlock_page_lruvec_irq(lruvec);
>  }
>  #endif

Shouldn't this be something like this?

	if (TestClearPageLRU()) {
		lruvec = lock_page_lruvec_irq(page);
		__activate_page(page, lruvec);
		unlock_page_lruvec_irq(lruvec);
		SetPageLRU(page);
	}

> @@ -904,27 +897,27 @@ void release_pages(struct page **pages, int nr)
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

Safe because page refcount=0.

> @@ -1023,26 +1016,24 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
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

Safe because PageLRU hasn't been set yet.

> @@ -1765,14 +1765,12 @@ int isolate_lru_page(struct page *page)
>  	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
>  
>  	if (TestClearPageLRU(page)) {
> -		pg_data_t *pgdat = page_pgdat(page);
>  		struct lruvec *lruvec;
>  
>  		get_page(page);
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -		spin_lock_irq(&pgdat->lru_lock);
> +		lruvec = lock_page_lruvec_irq(page);

Safe because PageLRU is cleared.

> @@ -1839,7 +1837,6 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>  static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  						     struct list_head *list)
>  {
> -	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> @@ -1850,9 +1847,9 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
>  		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			spin_unlock_irq(&pgdat->lru_lock);
> +			spin_unlock_irq(&lruvec->lru_lock);

[snipped all the reclaim lock sites as they start with lruvec]

> @@ -4289,13 +4285,12 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>  		if (!TestClearPageLRU(page))
>  			continue;
>  
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

Safe because PageLRU is clear.
