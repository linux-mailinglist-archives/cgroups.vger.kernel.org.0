Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AF2737A5
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 02:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgIVAmr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 20:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgIVAmq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 20:42:46 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E51C0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 17:42:46 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id m25so3748586oou.0
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=R2R7WH/B9uorM3A755wPvM+NF9B+5Y9TzKQCMLEQCzw=;
        b=nHYRBUybpof6BfO9qgW0DwAlj2Q8hrrwjsx+WrbRtnVElQvMV8mPnKlrB5f1vHCE6K
         f1YW6WLqfPCzHihvOiBU5+kQFm/N7Ql9wLsJdpI2XMtrKheCjme5CR3XsZhHIdYiiusr
         x3Hwt+vxQk9fH5cMXiaaGXe/qO7DPFWCCii4vIfjQr4CuVwlmLMYlPj45b+eug9QUGlw
         M2kzP+M5/BOTbtNMToaUteYtoRH1jXm+Z267vcqLLCVrC0SpkvzNrURe8sgWTJhg/g/9
         TpD4sFqfoJ0mdzJBoTT7KEW8YrbNqybsJlF+9F7vzTyMYrWUiuEX6SDNK8RYZqEXIBCw
         aqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=R2R7WH/B9uorM3A755wPvM+NF9B+5Y9TzKQCMLEQCzw=;
        b=DpZ/mIYjjEqiS3xN7XuCGyUUKfy78jS9mz/VB0yCqhRjZHeMVfHmjsuLlNw+0mpZf7
         F98MN1L551kaAX+uXC8jn2clH9jB0bXAMpW9I0gJtDtqJBVFMzwL0in2aMR8HLnVxa73
         /q+UPtK/vvxUwJVHvGE6tR16Ue8PEh8fPg1JUpCBe/8puXo2irrbaYfZQjyX6z10bUvh
         jUjG1gZRNFZNCWYt/91XXt8XhIi/9AzHIt7Cw4eYFTqfxAwuzw5tAB2NIipM46GHAbGk
         ih+ID7jf5oesu7873b1pPyWBOH9h3jg4jyhWftE3IV2i/nfU3wtXURdBWcMPOKfYhlap
         tshQ==
X-Gm-Message-State: AOAM531E3YzFoFh+hxckaOb5AuWfD4suEvCZWZ9XkAYx8PQDtZOgoNq0
        yXUSkr5T0NZ0mYadKBXdeaJ7iQ==
X-Google-Smtp-Source: ABdhPJw1u7dTAMqNjdfZpV1uZ7U6wjy6vAvFezS5ILPqoII1fWNCGnPgAYMBjfTuSe9KtTndRZ0zJQ==
X-Received: by 2002:a4a:bb05:: with SMTP id f5mr1334298oop.5.1600735366120;
        Mon, 21 Sep 2020 17:42:46 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b16sm6379801otq.31.2020.09.21.17.42.42
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 17:42:45 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:42:41 -0700 (PDT)
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
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 19/32] mm/swap.c: serialize memcg changes in
 pagevec_lru_move_fn
In-Reply-To: <1598273705-69124-20-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009211713440.5214@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-20-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

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
> So we need the ClearPageLRU to block isolate_lru_page(), that serializes

s/the ClearPageLRU/TestClearPageLRU/

> the memcg change. and then removing the PageLRU check in move_fn callee
> as the consequence.

Deserves another paragraph about __pagevec_lru_add():
"__pagevec_lru_add_fn() is different from the others, because the pages
it deals with are, by definition, not yet on the lru.  TestClearPageLRU
is not needed and would not work, so __pagevec_lru_add() goes its own way."

> 
> Reported-by: Hugh Dickins <hughd@google.com>

True.

> Signed-off-by: Hugh Dickins <hughd@google.com>

I did provide some lines, but I think it's just
Acked-by: Hugh Dickins <hughd@google.com>
to go below your Signed-off-by.

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/swap.c | 44 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)

In your lruv19 branch, this patch got renamed (s/moveing/moving/):
but I think it's better with the old name used here in v18, and without
those mm/vmscan.c mods to check_move_unevictable_pages() tacked on:
please move those back to 16/32, which already makes changes to vmscan.c.

> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 446ffe280809..2d9a86bf93a4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -221,8 +221,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  			spin_lock_irqsave(&pgdat->lru_lock, flags);
>  		}
>  
> +		/* block memcg migration during page moving between lru */
> +		if (!TestClearPageLRU(page))
> +			continue;
> +
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		(*move_fn)(page, lruvec);
> +
> +		SetPageLRU(page);
>  	}
>  	if (pgdat)
>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> @@ -232,7 +238,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  
>  static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
>  {
> -	if (PageLRU(page) && !PageUnevictable(page)) {
> +	if (!PageUnevictable(page)) {
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		ClearPageActive(page);
>  		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> @@ -306,7 +312,7 @@ void lru_note_cost_page(struct page *page)
>  
>  static void __activate_page(struct page *page, struct lruvec *lruvec)
>  {
> -	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
> +	if (!PageActive(page) && !PageUnevictable(page)) {
>  		int lru = page_lru_base_type(page);
>  		int nr_pages = thp_nr_pages(page);
>  
> @@ -362,7 +368,8 @@ void activate_page(struct page *page)
>  
>  	page = compound_head(page);
>  	spin_lock_irq(&pgdat->lru_lock);
> -	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
> +	if (PageLRU(page))
> +		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
>  	spin_unlock_irq(&pgdat->lru_lock);
>  }
>  #endif

Every time I look at this, I wonder if that's right, or an unnecessary
optimization strayed in, or whatever.  For the benefit of others looking
at this patch, yes it is right: this is the !CONFIG_SMP alternative
version of activate_page(), and needs that PageLRU check to compensate
for the check that has now been removed from __activate_page() itself.

> @@ -521,9 +528,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>  	bool active;
>  	int nr_pages = thp_nr_pages(page);
>  
> -	if (!PageLRU(page))
> -		return;
> -
>  	if (PageUnevictable(page))
>  		return;
>  
> @@ -564,7 +568,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>  
>  static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>  {
> -	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> +	if (PageActive(page) && !PageUnevictable(page)) {
>  		int lru = page_lru_base_type(page);
>  		int nr_pages = thp_nr_pages(page);
>  
> @@ -581,7 +585,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>  
>  static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
>  {
> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
> +	if (PageAnon(page) && PageSwapBacked(page) &&
>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>  		bool active = PageActive(page);
>  		int nr_pages = thp_nr_pages(page);
> @@ -979,7 +983,29 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>   */
>  void __pagevec_lru_add(struct pagevec *pvec)
>  {
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
>  }
>  
>  /**
> -- 
> 1.8.3.1
