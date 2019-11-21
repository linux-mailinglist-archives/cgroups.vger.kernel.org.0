Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F591048D9
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2019 04:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKUDPp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 22:15:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45363 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUDPp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 22:15:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id w7so844284plz.12
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2019 19:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Qnht2shM2MOiZ4qxbMYfoGx4QUY80uCQHx76GTp8h50=;
        b=WdZkxAugtSTkcAAghiVszxg3soV9gfbHLCGNOuj7qFiqNPlrnJuRyLg9Pq8goQGwht
         4U0p8//TlOV0H7/Q5hAV2RQiyotnpjik5S0UM0k0z7Nx0KMjswUTNrDPxJ1U/nISZTl/
         QOZc4aklGn34lRsTk/sNpSr8DOrxhmy258H4cywxKTa4l2Z++nIFgmkhNo84dltCHcyR
         DxR5fPVjSk4qfLDJikFehsHVuNjJQ+aUvRx25Bl2hmozMUns/nTpJytfdfQlY6YA+osZ
         m78U3D7jCvgzGpc2bq2OA0ZLdPzMcDTy5cHvBPQ3w6SuV8xpWdNKhWxh6CY77s57J7i1
         kRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Qnht2shM2MOiZ4qxbMYfoGx4QUY80uCQHx76GTp8h50=;
        b=G8z6T9vv9XDUlqxawf8nTR44jvWZqRxVn7LlXNRqoFKYOLcHKKoeV40bnXOLrEp4Cb
         2WshdONn2a+SspRqaIXbNLh53Sn4oko2Auyq0nXG1CfUg0hPpxv0FqSbvfO8TE4Va8dM
         B1YTIusEJSg9Bv5ky/85NqUVwPNjyXQtd4MgXNwg8e4nwXWnuJylf7Sogh4FjFup/Pz3
         2V1xS7L8D5IILYGAW1vpZRizXG7Nwb1VVpLK7IeMaLsqBsLvs1oLXdlyrZxocNEJgMSK
         9B5N3mqGx0TmfftWzTYv35AgO+o9/m/4YuBQEbapQSH8jmz6vH3jrUf9IPr5PI4mYOwC
         0C3Q==
X-Gm-Message-State: APjAAAW0DHP5Z1lhsBhL0F9TUwpJWJE5Q3U97Fy98fA4CAoTS2KkHAC4
        D7uPNRGew65TvFZfunZLwlbKWw==
X-Google-Smtp-Source: APXvYqz9D9bgV1lMd0JB2f9uP7pGnQ/BlLLIFH1vadxvPNHlxybArK1TFPGMIxO/j6mYAWepfTkRXQ==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr6385546pls.104.1574306142865;
        Wed, 20 Nov 2019 19:15:42 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id 83sm25557pfv.157.2019.11.20.19.15.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 19:15:41 -0800 (PST)
Date:   Wed, 20 Nov 2019 19:15:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge
 migration
In-Reply-To: <20191120165847.423540-1-hannes@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
References: <20191120165847.423540-1-hannes@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 Nov 2019, Johannes Weiner wrote:

> While reviewing the "per lruvec lru_lock for memcg" series, Hugh and I
> noticed two places in the existing code where the page -> memcg ->
> lruvec lookup can result in a use-after-free bug. This affects cgroup1
> setups that have charge migration enabled.

I don't see how it can result in a use-after-free, or other bug.

> 
> To pin page->mem_cgroup, callers need to either have the page locked,
> an exclusive refcount (0), or hold the lru_lock and "own" PageLRU

"exclusive refcount (0)", okay, that's quite a good term for it -
though "frozen refcount (0)" is what we would usually say.

You don't suggest holding move_lock, but I guess move_lock is never
used in that way (nor should be).

Okay.

> (either ensure it's set, or be the one to hold the page in isolation)
> to make cgroup migration fail the isolation step. Failure to follow
> this can result in the page moving out of the memcg and freeing it,
> along with its lruvecs, while the observer is dereferencing them.
> 
> 1. isolate_lru_page() calls mem_cgroup_page_lruvec() with the lru_lock
> held but before testing PageLRU. It doesn't dereference the returned
> lruvec before testing PageLRU, giving the impression that it might
> just be safe ordering after all - but mem_cgroup_page_lruvec() itself
> touches the lruvec to lazily initialize the pgdat back pointer. This
> one is easy to fix, just move the lookup into the PageLRU branch.
> 
> 2. pagevec_lru_move_fn() conveniently looks up the lruvec for all the
> callbacks it might get invoked on. Unfortunately, it's the callbacks
> that first check PageLRU under the lru_lock, which makes this order
> equally unsafe as isolate_lru_page(). Remove the lruvec argument from
> the move callbacks and let them do it inside their PageLRU branches.
> 
> Reported-by: Hugh Dickins <hughd@google.com>

You are overly generous to name me there! I have to demur, it's true
that yesterday I said "even isolate_lru_page() looks unsafe to me now",
but I was talking (in private mail) about my own mods, not current
upstream.  And you have then gone on to observe something suspicious
in the current code, but I don't think it amounts to a bug at all.
Appreciated, but please delete me!

Further explanation below, at the smaller isolate_lru_page() hunk,
where it's easier to see what goes on without the indirections of
mm/swap.c.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/swap.c   | 48 +++++++++++++++++++++++++++++-------------------
>  mm/vmscan.c |  8 ++++----
>  2 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 5341ae93861f..6b015e9532fb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -188,12 +188,11 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
>  EXPORT_SYMBOL_GPL(get_kernel_page);
>  
>  static void pagevec_lru_move_fn(struct pagevec *pvec,
> -	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
> +	void (*move_fn)(struct page *page, void *arg),
>  	void *arg)
>  {
>  	int i;
>  	struct pglist_data *pgdat = NULL;
> -	struct lruvec *lruvec;
>  	unsigned long flags = 0;
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
> @@ -207,8 +206,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  			spin_lock_irqsave(&pgdat->lru_lock, flags);
>  		}
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -		(*move_fn)(page, lruvec, arg);
> +		(*move_fn)(page, arg);
>  	}
>  	if (pgdat)
>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> @@ -216,12 +214,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  	pagevec_reinit(pvec);
>  }
>  
> -static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
> -				 void *arg)
> +static void pagevec_move_tail_fn(struct page *page, void *arg)
>  {
>  	int *pgmoved = arg;
>  
>  	if (PageLRU(page) && !PageUnevictable(page)) {
> +		struct lruvec *lruvec;
> +
> +		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		ClearPageActive(page);
>  		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> @@ -272,12 +272,14 @@ static void update_page_reclaim_stat(struct lruvec *lruvec,
>  		reclaim_stat->recent_rotated[file]++;
>  }
>  
> -static void __activate_page(struct page *page, struct lruvec *lruvec,
> -			    void *arg)
> +static void __activate_page(struct page *page, void *arg)
>  {
>  	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
>  		int file = page_is_file_cache(page);
>  		int lru = page_lru_base_type(page);
> +		struct lruvec *lruvec;
> +
> +		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>  
>  		del_page_from_lru_list(page, lruvec, lru);
>  		SetPageActive(page);
> @@ -328,7 +330,7 @@ void activate_page(struct page *page)
>  
>  	page = compound_head(page);
>  	spin_lock_irq(&pgdat->lru_lock);
> -	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
> +	__activate_page(page, NULL);
>  	spin_unlock_irq(&pgdat->lru_lock);
>  }
>  #endif
> @@ -498,9 +500,9 @@ void lru_cache_add_active_or_unevictable(struct page *page,
>   * be write it out by flusher threads as this is much more effective
>   * than the single-page writeout from reclaim.
>   */
> -static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> -			      void *arg)
> +static void lru_deactivate_file_fn(struct page *page, void *arg)
>  {
> +	struct lruvec *lruvec;
>  	int lru, file;
>  	bool active;
>  
> @@ -518,6 +520,8 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  	file = page_is_file_cache(page);
>  	lru = page_lru_base_type(page);
>  
> +	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +
>  	del_page_from_lru_list(page, lruvec, lru + active);
>  	ClearPageActive(page);
>  	ClearPageReferenced(page);
> @@ -544,12 +548,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  	update_page_reclaim_stat(lruvec, file, 0);
>  }
>  
> -static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
> -			    void *arg)
> +static void lru_deactivate_fn(struct page *page, void *arg)
>  {
>  	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
>  		int file = page_is_file_cache(page);
>  		int lru = page_lru_base_type(page);
> +		struct lruvec *lruvec;
> +
> +		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>  
>  		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
>  		ClearPageActive(page);
> @@ -561,12 +567,14 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
>  	}
>  }
>  
> -static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
> -			    void *arg)
> +static void lru_lazyfree_fn(struct page *page, void *arg)
>  {
>  	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>  		bool active = PageActive(page);
> +		struct lruvec *lruvec;
> +
> +		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>  
>  		del_page_from_lru_list(page, lruvec,
>  				       LRU_INACTIVE_ANON + active);
> @@ -921,15 +929,17 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
> -				 void *arg)
> +static void __pagevec_lru_add_fn(struct page *page, void *arg)
>  {
> -	enum lru_list lru;
>  	int was_unevictable = TestClearPageUnevictable(page);
> +	struct lruvec *lruvec;
> +	enum lru_list lru;
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
> -
>  	SetPageLRU(page);
> +
> +	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +
>  	/*
>  	 * Page becomes evictable in two ways:
>  	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index df859b1d583c..3c8b81990146 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1767,15 +1767,15 @@ int isolate_lru_page(struct page *page)
>  
>  	if (PageLRU(page)) {
>  		pg_data_t *pgdat = page_pgdat(page);
> -		struct lruvec *lruvec;
>  
>  		spin_lock_irq(&pgdat->lru_lock);
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		if (PageLRU(page)) {
> -			int lru = page_lru(page);
> +			struct lruvec *lruvec;
> +
> +			lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  			get_page(page);
>  			ClearPageLRU(page);
> -			del_page_from_lru_list(page, lruvec, lru);
> +			del_page_from_lru_list(page, lruvec, page_lru(page));
>  			ret = 0;
>  		}
>  		spin_unlock_irq(&pgdat->lru_lock);
> -- 
> 2.24.0

It like the way you've rearranged isolate_lru_page() there, but I
don't think it amounts to more than a cleanup.  Very good thinking
about the odd "lruvec->pgdat = pgdat" case tucked away inside
mem_cgroup_page_lruvec(), but actually, what harm does it do, if
mem_cgroup_move_account() changes page->mem_cgroup concurrently?

You say use-after-free, but we have spin_lock_irq here, and the
struct mem_cgroup (and its lruvecs) cannot be freed until an RCU
grace period expires, which we rely upon in many places, and which
cannot happen until after the spin_unlock_irq.

And the same applies in the pagevec_lru_move functions, doesn't it?

I think now is not the time for such cleanups. If this fits well
with Alex's per-lruvec locking (or represents an initial direction
that you think he should follow), fine, but better to let him take it
into his patchset in that case, than change the base unnecessarily
underneath him.

(It happens to go against my own direction, since it separates the
locking from the determination of lruvec, which I insist must be
kept together; but perhaps that won't be quite the same for Alex.)

Hugh
