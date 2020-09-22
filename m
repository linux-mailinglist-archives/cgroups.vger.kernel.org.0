Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B160B273A52
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 07:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgIVFkQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 01:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgIVFkP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 01:40:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC45C061755
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:40:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so14547067ota.8
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6LZJbo2wShWpm8ovGLzdTSaw70v+wjIXX2UN2lui5KE=;
        b=Tdwv7P0gQGa7UVTHfNJwLlNsLU/GP+aKq88wZ8ejQgYw/uyivNES8YKU7x42iIbiRb
         0BfBgo4om6rzyK0w1tBnPsR/RJ5sn4At3bjR/3SJUzewnTwT+C8Rpf6ikrzPDJrlpwA/
         FLpYO9QCCWEFNBFK8FJiKS80H0ONIqZKl2gMxw01WHWdmqNWd8Xeae2kbjJNdWqL+MOv
         OkMQRMA2/RX+s0m3blLkUBBDAXlMUoU2F/o09GsMfybWflDu3PPxjFggZQ7NrUzdgYgo
         q2XqJWH0IGp6jwYoXottUuBFTgKBAHy6p1booeRcvVxxJLZCLUzsZuYez0C5q/s6TMyf
         ju6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6LZJbo2wShWpm8ovGLzdTSaw70v+wjIXX2UN2lui5KE=;
        b=Y8IZxXY5ZkE2Sejd+Xts9hO4sQDYzIqLFGmjh/Vl7121eEKSyE7ej8NKeC+x6CswTq
         18RhaAZ3IpvDI4MlZmQyVEUguqjWg9zhhJvq1K/vl3NwgB547r+eSBfzMZ4BBo0/inSW
         gT5z6vS0WeahBIp1W8hO8NOSI2LC/c2W3J7MFpclZWIQtO8kyIEezeezbOLvhBwA6Brh
         JCsCmILj5QzVqjh3vNXfGhc1Yc4CKjRSEv1AzFdNk8G3sgFK5PbcThL8Qq5aK0eC6u0S
         gnCP8Jz7G1DmPbPZneDpiGJoccxXCD5QqQotGeHGzZrT/TzKICN7s4J35kZ+KCiIPAth
         2rug==
X-Gm-Message-State: AOAM533EBVse7KvOlZClic0DYai7EFKB3rj0E7k0QAPn6jv3r5D7hx1r
        86BwM7WZqMJc3s0bw2HETw7t/g==
X-Google-Smtp-Source: ABdhPJyppoDTNFnnTmmDfJ517/hOW+ghysAzrB5l+YITf50aq9xeXbAs1EFvye0jFwD4y1i3JsTc6Q==
X-Received: by 2002:a9d:7448:: with SMTP id p8mr1777819otk.306.1600753214934;
        Mon, 21 Sep 2020 22:40:14 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p20sm8501616ook.27.2020.09.21.22.40.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 22:40:13 -0700 (PDT)
Date:   Mon, 21 Sep 2020 22:40:10 -0700 (PDT)
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v18 21/32] mm/lru: introduce the relock_page_lruvec
 function
In-Reply-To: <1598273705-69124-22-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009212229270.6434@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-22-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Use this new function to replace repeated same code, no func change.
> 
> When testing for relock we can avoid the need for RCU locking if we simply
> compare the page pgdat and memcg pointers versus those that the lruvec is
> holding. By doing this we can avoid the extra pointer walks and accesses of
> the memory cgroup.
> 
> In addition we can avoid the checks entirely if lruvec is currently NULL.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Again, I'll wait to see __munlock_pagevec() fixed before Acking this
one, but that's the only issue.  And I've suggested that you use
lruvec_holds_page_lru_lock() in mm/vmscan.c move_pages_to_lru(),
to replace the uglier and less efficient VM_BUG_ON_PAGE there.

Oh, there is one other issue: 0day robot did report (2020-06-19)
that sparse doesn't understand relock_page_lruvec*(): I've never
got around to working out how to write what it needs, conditional
__release plus __acquire in some form, I imagine. I've never got
into sparse annotations before, I'll give it a try, but if anyone
beats me that will be welcome: and there are higher priorities -
I do not think you should wait for the sparse warning to be fixed
before reposting.

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/memcontrol.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/mlock.c                 |  9 +-------
>  mm/swap.c                  | 33 +++++++----------------------
>  mm/vmscan.c                |  8 +------
>  4 files changed, 61 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7b170e9028b5..ee6ef2d8ad52 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -488,6 +488,22 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
> @@ -1023,6 +1039,14 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
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
> @@ -1469,6 +1493,34 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>  	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
>  }
>  
> +/* Don't lock again iff page's lruvec locked */
> +static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
> +		struct lruvec *locked_lruvec)
> +{
> +	if (locked_lruvec) {
> +		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> +			return locked_lruvec;
> +
> +		unlock_page_lruvec_irq(locked_lruvec);
> +	}
> +
> +	return lock_page_lruvec_irq(page);
> +}
> +
> +/* Don't lock again iff page's lruvec locked */
> +static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
> +		struct lruvec *locked_lruvec, unsigned long *flags)
> +{
> +	if (locked_lruvec) {
> +		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
> +			return locked_lruvec;
> +
> +		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
> +	}
> +
> +	return lock_page_lruvec_irqsave(page, flags);
> +}
> +
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 177d2588e863..0448409184e3 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -302,17 +302,10 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>  	/* Phase 1: page isolation */
>  	for (i = 0; i < nr; i++) {
>  		struct page *page = pvec->pages[i];
> -		struct lruvec *new_lruvec;
>  
>  		/* block memcg change in mem_cgroup_move_account */
>  		lock_page_memcg(page);
> -		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -		if (new_lruvec != lruvec) {
> -			if (lruvec)
> -				unlock_page_lruvec_irq(lruvec);
> -			lruvec = lock_page_lruvec_irq(page);
> -		}
> -
> +		lruvec = relock_page_lruvec_irq(page, lruvec);
>  		if (TestClearPageMlocked(page)) {
>  			/*
>  			 * We already have pin from follow_page_mask()
> diff --git a/mm/swap.c b/mm/swap.c
> index b67959b701c0..2ac78e8fab71 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -209,19 +209,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
> -		struct lruvec *new_lruvec;
>  
>  		/* block memcg migration during page moving between lru */
>  		if (!TestClearPageLRU(page))
>  			continue;
>  
> -		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -		if (lruvec != new_lruvec) {
> -			if (lruvec)
> -				unlock_page_lruvec_irqrestore(lruvec, flags);
> -			lruvec = lock_page_lruvec_irqsave(page, &flags);
> -		}
> -
> +		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>  		(*move_fn)(page, lruvec);
>  
>  		SetPageLRU(page);
> @@ -865,17 +858,12 @@ void release_pages(struct page **pages, int nr)
>  		}
>  
>  		if (PageLRU(page)) {
> -			struct lruvec *new_lruvec;
> -
> -			new_lruvec = mem_cgroup_page_lruvec(page,
> -							page_pgdat(page));
> -			if (new_lruvec != lruvec) {
> -				if (lruvec)
> -					unlock_page_lruvec_irqrestore(lruvec,
> -									flags);
> +			struct lruvec *prev_lruvec = lruvec;
> +
> +			lruvec = relock_page_lruvec_irqsave(page, lruvec,
> +									&flags);
> +			if (prev_lruvec != lruvec)
>  				lock_batch = 0;
> -				lruvec = lock_page_lruvec_irqsave(page, &flags);
> -			}
>  
>  			VM_BUG_ON_PAGE(!PageLRU(page), page);
>  			__ClearPageLRU(page);
> @@ -982,15 +970,8 @@ void __pagevec_lru_add(struct pagevec *pvec)
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
> -		struct lruvec *new_lruvec;
> -
> -		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -		if (lruvec != new_lruvec) {
> -			if (lruvec)
> -				unlock_page_lruvec_irqrestore(lruvec, flags);
> -			lruvec = lock_page_lruvec_irqsave(page, &flags);
> -		}
>  
> +		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>  		__pagevec_lru_add_fn(page, lruvec);
>  	}
>  	if (lruvec)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 789444ae4c88..2c94790d4cb1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4280,15 +4280,9 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>  
>  	for (i = 0; i < pvec->nr; i++) {
>  		struct page *page = pvec->pages[i];
> -		struct lruvec *new_lruvec;
>  
>  		pgscanned++;
> -		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -		if (lruvec != new_lruvec) {
> -			if (lruvec)
> -				unlock_page_lruvec_irq(lruvec);
> -			lruvec = lock_page_lruvec_irq(page);
> -		}
> +		lruvec = relock_page_lruvec_irq(page, lruvec);
>  
>  		if (!PageLRU(page) || !PageUnevictable(page))
>  			continue;
> -- 
> 1.8.3.1
