Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D85331EE
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 21:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiEXTwb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbiEXTwa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 15:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39A9C5B3D4
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653421947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsoL5BUtwGtn8srjaBAKLRmvlrQ5HvOClw2yb5AYOdQ=;
        b=UBrCsITgFApKa9lSS0hQz0i47swfTVDu5GcxRNYGStigCl6ZTpnmSx1OfqlQFsUD0GDdQi
        Vg1k0jFsrpZBUYRSWE89o55M8lWYacdCnj9cM0IQ8yeZIexOEjsh/CAFwQsYLtUvtTN26n
        9z5WiC38cZ3lPr8v2pjiFzyL6pvyrAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416--36m1xhvMhaLbWszLzkDTg-1; Tue, 24 May 2022 15:52:23 -0400
X-MC-Unique: -36m1xhvMhaLbWszLzkDTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11160185A7B2;
        Tue, 24 May 2022 19:52:23 +0000 (UTC)
Received: from [10.22.8.146] (unknown [10.22.8.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 876CE401E4C;
        Tue, 24 May 2022 19:52:22 +0000 (UTC)
Message-ID: <78de6197-7de6-9fe7-9567-1321c06c6e9b@redhat.com>
Date:   Tue, 24 May 2022 15:52:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-5-songmuchun@bytedance.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220524060551.80037-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/24/22 02:05, Muchun Song wrote:
> In the later patch, we will reparent the LRU pages. The pages moved to
> appropriate LRU list can be reparented during the process of the
> move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
> should use the more general interface of folio_lruvec_relock_irq() to
> acquire the correct lruvec lock.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/vmscan.c | 49 +++++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..761d5e0dd78d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2230,23 +2230,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>    * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
>    * On return, @list is reused as a list of pages to be freed by the caller.
>    *
> - * Returns the number of pages moved to the given lruvec.
> + * Returns the number of pages moved to the appropriate LRU list.
> + *
> + * Note: The caller must not hold any lruvec lock.
>    */
> -static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> -				      struct list_head *list)
> +static unsigned int move_pages_to_lru(struct list_head *list)
>   {
> -	int nr_pages, nr_moved = 0;
> +	int nr_moved = 0;
> +	struct lruvec *lruvec = NULL;
>   	LIST_HEAD(pages_to_free);
> -	struct page *page;
>   
>   	while (!list_empty(list)) {
> -		page = lru_to_page(list);
> +		int nr_pages;
> +		struct folio *folio = lru_to_folio(list);
> +		struct page *page = &folio->page;
> +
> +		lruvec = folio_lruvec_relock_irq(folio, lruvec);
>   		VM_BUG_ON_PAGE(PageLRU(page), page);
>   		list_del(&page->lru);
>   		if (unlikely(!page_evictable(page))) {
> -			spin_unlock_irq(&lruvec->lru_lock);
> +			unlock_page_lruvec_irq(lruvec);
>   			putback_lru_page(page);
> -			spin_lock_irq(&lruvec->lru_lock);
> +			lruvec = NULL;
>   			continue;
>   		}
>   
> @@ -2267,20 +2272,16 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
>   			__clear_page_lru_flags(page);
>   
>   			if (unlikely(PageCompound(page))) {
> -				spin_unlock_irq(&lruvec->lru_lock);
> +				unlock_page_lruvec_irq(lruvec);
>   				destroy_compound_page(page);
> -				spin_lock_irq(&lruvec->lru_lock);
> +				lruvec = NULL;
>   			} else
>   				list_add(&page->lru, &pages_to_free);
>   
>   			continue;
>   		}
>   
> -		/*
> -		 * All pages were isolated from the same lruvec (and isolation
> -		 * inhibits memcg migration).
> -		 */
> -		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
> +		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
>   		add_page_to_lru_list(page, lruvec);
>   		nr_pages = thp_nr_pages(page);
>   		nr_moved += nr_pages;
> @@ -2288,6 +2289,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
>   			workingset_age_nonresident(lruvec, nr_pages);
>   	}
>   
> +	if (lruvec)
> +		unlock_page_lruvec_irq(lruvec);
>   	/*
>   	 * To save our caller's stack, now use input list for pages to free.
>   	 */
> @@ -2359,16 +2362,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>   
>   	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
>   
> -	spin_lock_irq(&lruvec->lru_lock);
> -	move_pages_to_lru(lruvec, &page_list);
> +	move_pages_to_lru(&page_list);
>   
> +	local_irq_disable();
>   	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>   	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
>   	if (!cgroup_reclaim(sc))
>   		__count_vm_events(item, nr_reclaimed);
>   	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>   	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> -	spin_unlock_irq(&lruvec->lru_lock);
> +	local_irq_enable();
>   
>   	lru_note_cost(lruvec, file, stat.nr_pageout);
>   	mem_cgroup_uncharge_list(&page_list);
> @@ -2498,18 +2501,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
>   	/*
>   	 * Move pages back to the lru list.
>   	 */
> -	spin_lock_irq(&lruvec->lru_lock);
> -
> -	nr_activate = move_pages_to_lru(lruvec, &l_active);
> -	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
> +	nr_activate = move_pages_to_lru(&l_active);
> +	nr_deactivate = move_pages_to_lru(&l_inactive);
>   	/* Keep all free pages in l_active list */
>   	list_splice(&l_inactive, &l_active);
>   
> +	local_irq_disable();
>   	__count_vm_events(PGDEACTIVATE, nr_deactivate);
>   	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
> -
>   	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> -	spin_unlock_irq(&lruvec->lru_lock);
> +	local_irq_enable();
>   
>   	mem_cgroup_uncharge_list(&l_active);
>   	free_unref_page_list(&l_active);

Note that the RT engineers will likely change the 
local_irq_disable()/local_irq_enable() to 
local_lock_irq()/local_unlock_irq().

Cheers,
Longman

