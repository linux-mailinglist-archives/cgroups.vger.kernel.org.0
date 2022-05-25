Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B6533BE7
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbiEYLnY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiEYLnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 07:43:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147C6A204F
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:43:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h186so18683165pgc.3
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P5Wb2ffVHqC6iCrfliBILNM6nfMo0Dy7zA6WZidhWjM=;
        b=xT6MvecVMKRRz8av3Sya8O1ZJeuGiGA+WjQE/5q5ewBNlvJIXz/uVo+wHgha/jtAKa
         gqsEmdYLyjjk9AKvVZ8UKVjp/DRxcy/QCFR3Jtp2MQO3AS91ccBWQjQ9CjpVZ1zCfVDl
         S1lzanJDy15I383ezha5GJFz/jA8fj5QKUYQpsHS1+mGd2S30XrJHeifzF1KgUFTwU6K
         QZCRd3eB6OKvKba0StLacOehhYzwPpfpPUGVUL0WxP3yJg+m5WS6DhOGgcHze9lY4zCL
         SBuR9XBGgDvVdrGAPGtK6EBdr1UxZCYRiptOKfbKp2HAIN7SbcgiC7qzH5VvAH4e6KW9
         Bpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5Wb2ffVHqC6iCrfliBILNM6nfMo0Dy7zA6WZidhWjM=;
        b=sn8i+0e7z4oKCjR+d9YgivC15tV6Y/mWMkJibnya3048TsJexToBHKDK3rSzsMBn3d
         FOX2NCrGZDCas4F67tS1vKKjp4D2Y6L+aN+pJmPAhUMyZYOwbwJ1YjXqwewOcIwLv3SB
         KEF8+gzkd6pLEbAILoigG7j4V7XtvaY1zj33G0Ees2r+xNQsD9zbEuUfchXNY5pKIJkR
         ydJwePVqehVzyu7tHNFgE/uvFpZU1mQwSEFy3TLhvQFs3Lk1ma6eAqyIzZOAXKo0LqE+
         hqv/P0PmXQNMT+Z03x4SEkBv9bKghz/XKzextxwuSactqp8m4n4dwVB4dbVlrQosCnOL
         8Y3Q==
X-Gm-Message-State: AOAM531Jn0WTpYITczhI0mvKFoAK0t5kLrsQkenuYHh1A7Z+AXdXlFRX
        poGJzd32+T6u5QR6KHW+mqtUBA==
X-Google-Smtp-Source: ABdhPJxV4+IcBCGDJnQJuk84cQ/DrWzi7EU8GdYzBd6tAxnMdBv7RLpDeO1pGM5IAR0RwsJh/yezag==
X-Received: by 2002:a05:6a00:21c6:b0:4fa:914c:2c2b with SMTP id t6-20020a056a0021c600b004fa914c2c2bmr33195929pfj.56.1653479001571;
        Wed, 25 May 2022 04:43:21 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0015e8d4eb283sm9087052pll.205.2022.05.25.04.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:43:21 -0700 (PDT)
Date:   Wed, 25 May 2022 19:43:15 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Waiman Long <longman@redhat.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Message-ID: <Yo4WU8uzHDiEmaLI@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-5-songmuchun@bytedance.com>
 <78de6197-7de6-9fe7-9567-1321c06c6e9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78de6197-7de6-9fe7-9567-1321c06c6e9b@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:52:22PM -0400, Waiman Long wrote:
> On 5/24/22 02:05, Muchun Song wrote:
> > In the later patch, we will reparent the LRU pages. The pages moved to
> > appropriate LRU list can be reparented during the process of the
> > move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
> > should use the more general interface of folio_lruvec_relock_irq() to
> > acquire the correct lruvec lock.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >   mm/vmscan.c | 49 +++++++++++++++++++++++++------------------------
> >   1 file changed, 25 insertions(+), 24 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 1678802e03e7..761d5e0dd78d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2230,23 +2230,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
> >    * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
> >    * On return, @list is reused as a list of pages to be freed by the caller.
> >    *
> > - * Returns the number of pages moved to the given lruvec.
> > + * Returns the number of pages moved to the appropriate LRU list.
> > + *
> > + * Note: The caller must not hold any lruvec lock.
> >    */
> > -static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> > -				      struct list_head *list)
> > +static unsigned int move_pages_to_lru(struct list_head *list)
> >   {
> > -	int nr_pages, nr_moved = 0;
> > +	int nr_moved = 0;
> > +	struct lruvec *lruvec = NULL;
> >   	LIST_HEAD(pages_to_free);
> > -	struct page *page;
> >   	while (!list_empty(list)) {
> > -		page = lru_to_page(list);
> > +		int nr_pages;
> > +		struct folio *folio = lru_to_folio(list);
> > +		struct page *page = &folio->page;
> > +
> > +		lruvec = folio_lruvec_relock_irq(folio, lruvec);
> >   		VM_BUG_ON_PAGE(PageLRU(page), page);
> >   		list_del(&page->lru);
> >   		if (unlikely(!page_evictable(page))) {
> > -			spin_unlock_irq(&lruvec->lru_lock);
> > +			unlock_page_lruvec_irq(lruvec);
> >   			putback_lru_page(page);
> > -			spin_lock_irq(&lruvec->lru_lock);
> > +			lruvec = NULL;
> >   			continue;
> >   		}
> > @@ -2267,20 +2272,16 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> >   			__clear_page_lru_flags(page);
> >   			if (unlikely(PageCompound(page))) {
> > -				spin_unlock_irq(&lruvec->lru_lock);
> > +				unlock_page_lruvec_irq(lruvec);
> >   				destroy_compound_page(page);
> > -				spin_lock_irq(&lruvec->lru_lock);
> > +				lruvec = NULL;
> >   			} else
> >   				list_add(&page->lru, &pages_to_free);
> >   			continue;
> >   		}
> > -		/*
> > -		 * All pages were isolated from the same lruvec (and isolation
> > -		 * inhibits memcg migration).
> > -		 */
> > -		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
> > +		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
> >   		add_page_to_lru_list(page, lruvec);
> >   		nr_pages = thp_nr_pages(page);
> >   		nr_moved += nr_pages;
> > @@ -2288,6 +2289,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> >   			workingset_age_nonresident(lruvec, nr_pages);
> >   	}
> > +	if (lruvec)
> > +		unlock_page_lruvec_irq(lruvec);
> >   	/*
> >   	 * To save our caller's stack, now use input list for pages to free.
> >   	 */
> > @@ -2359,16 +2362,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> >   	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
> > -	spin_lock_irq(&lruvec->lru_lock);
> > -	move_pages_to_lru(lruvec, &page_list);
> > +	move_pages_to_lru(&page_list);
> > +	local_irq_disable();
> >   	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> >   	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> >   	if (!cgroup_reclaim(sc))
> >   		__count_vm_events(item, nr_reclaimed);
> >   	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> >   	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> > -	spin_unlock_irq(&lruvec->lru_lock);
> > +	local_irq_enable();
> >   	lru_note_cost(lruvec, file, stat.nr_pageout);
> >   	mem_cgroup_uncharge_list(&page_list);
> > @@ -2498,18 +2501,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
> >   	/*
> >   	 * Move pages back to the lru list.
> >   	 */
> > -	spin_lock_irq(&lruvec->lru_lock);
> > -
> > -	nr_activate = move_pages_to_lru(lruvec, &l_active);
> > -	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
> > +	nr_activate = move_pages_to_lru(&l_active);
> > +	nr_deactivate = move_pages_to_lru(&l_inactive);
> >   	/* Keep all free pages in l_active list */
> >   	list_splice(&l_inactive, &l_active);
> > +	local_irq_disable();
> >   	__count_vm_events(PGDEACTIVATE, nr_deactivate);
> >   	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
> > -
> >   	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> > -	spin_unlock_irq(&lruvec->lru_lock);
> > +	local_irq_enable();
> >   	mem_cgroup_uncharge_list(&l_active);
> >   	free_unref_page_list(&l_active);
> 
> Note that the RT engineers will likely change the
> local_irq_disable()/local_irq_enable() to
> local_lock_irq()/local_unlock_irq().
>

Thanks. I'll replace them with local_lock/unlock_irq().
 
