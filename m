Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0809F696C38
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBNSDa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjBNSD3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 13:03:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD24487;
        Tue, 14 Feb 2023 10:03:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D9261804;
        Tue, 14 Feb 2023 18:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A6FC433D2;
        Tue, 14 Feb 2023 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397807;
        bh=HsyqUMxIxQXj1PLmxzGeFDR4eQQW91VJZBvBGKYXQJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=defotCk8mmKkO/KNguwzRQs+pD2/yTXEjMh6O0fwB+dvVRn4Yfq0SSHyIsq1Ud+1D
         ZlKZwbZBVMCZc4b8EpIdkvuJHMCp9gKW5CKDvJaZU4givAapiJmJA288Jg8edjEUMz
         R3TLX32KqHElbq9SRssdBlhg+TM7PVqXvoHjG0A5AG/BXNuzXhoENx98Up5X7rkQgT
         H20U14TwlrJ0wNg3yaGr31wRcLcR9XdGob9UGQIce/HVtOA8t8h5/hQM714gD+ye+c
         v/OPPQ0kCzKb5eB0hiNYeAMGQ63RiNmT+6Mh1mg2WzhZM674nnxhHEYHtZB6Nv/Nu0
         woyJI++okJJ6g==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: hugetlb: change to return bool for isolate_hugetlb()
Date:   Tue, 14 Feb 2023 18:03:24 +0000
Message-Id: <20230214180324.71585-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <eee98c9955b50cbeacb50d900f8be4a571044b1e.1676382188.git.baolin.wang@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Feb 2023 21:59:31 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> care about the negative value, thus we can convert the isolate_hugetlb()
> to return a boolean value to make code more clear when checking the
> hugetlb isolation state. Moreover converts 2 users which will consider
> the negative value returned by isolate_hugetlb().
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/hugetlb.h |  6 +++---
>  mm/hugetlb.c            | 12 ++++++++----
>  mm/memory-failure.c     |  2 +-
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  2 +-
>  5 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index df6dd624ccfe..5f5e4177b2e0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -171,7 +171,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						vm_flags_t vm_flags);
>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  						long freed);
> -int isolate_hugetlb(struct folio *folio, struct list_head *list);
> +bool isolate_hugetlb(struct folio *folio, struct list_head *list);
>  int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
>  int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  				bool *migratable_cleared);
> @@ -413,9 +413,9 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
>  	return NULL;
>  }
>  
> -static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
> +static inline bool isolate_hugetlb(struct folio *folio, struct list_head *list)
>  {
> -	return -EBUSY;
> +	return false;
>  }
>  
>  static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3a01a9dbf445..75097e3abc18 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2932,6 +2932,10 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  		spin_unlock_irq(&hugetlb_lock);
>  		ret = isolate_hugetlb(old_folio, list);
>  		spin_lock_irq(&hugetlb_lock);
> +		if (!ret)
> +			ret = -EBUSY;
> +		else
> +			ret = 0;

This would work, but 'ret' is not 'bool' but 'int'.  How about below?

  		ret = isolate_hugetlb(old_folio, list) ? 0 : -EBUSY;

>  		goto free_new;
>  	} else if (!folio_test_hugetlb_freed(old_folio)) {
>  		/*
> @@ -3005,7 +3009,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>  	if (hstate_is_gigantic(h))
>  		return -ENOMEM;
>  
> -	if (folio_ref_count(folio) && !isolate_hugetlb(folio, list))
> +	if (folio_ref_count(folio) && isolate_hugetlb(folio, list))
>  		ret = 0;
>  	else if (!folio_ref_count(folio))
>  		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
> @@ -7251,15 +7255,15 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
>   */
> -int isolate_hugetlb(struct folio *folio, struct list_head *list)
> +bool isolate_hugetlb(struct folio *folio, struct list_head *list)
>  {
> -	int ret = 0;
> +	bool ret = true;
>  
>  	spin_lock_irq(&hugetlb_lock);
>  	if (!folio_test_hugetlb(folio) ||
>  	    !folio_test_hugetlb_migratable(folio) ||
>  	    !folio_try_get(folio)) {
> -		ret = -EBUSY;
> +		ret = false;
>  		goto unlock;
>  	}
>  	folio_clear_hugetlb_migratable(folio);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e504362fdb23..8604753bc644 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2508,7 +2508,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
>  	bool isolated = false;
>  
>  	if (PageHuge(page)) {
> -		isolated = !isolate_hugetlb(page_folio(page), pagelist);
> +		isolated = isolate_hugetlb(page_folio(page), pagelist);
>  	} else {
>  		bool lru = !__PageMovable(page);
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 2751bc3310fd..a256a241fd1d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -609,7 +609,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
>  	if (flags & (MPOL_MF_MOVE_ALL) ||
>  	    (flags & MPOL_MF_MOVE && folio_estimated_sharers(folio) == 1 &&
>  	     !hugetlb_pmd_shared(pte))) {
> -		if (isolate_hugetlb(folio, qp->pagelist) &&
> +		if (!isolate_hugetlb(folio, qp->pagelist) &&
>  			(flags & MPOL_MF_STRICT))
>  			/*
>  			 * Failed to isolate folio but allow migrating pages
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 53010a142e7f..c5136fa48638 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2128,7 +2128,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		if (PageHead(page)) {
>  			err = isolate_hugetlb(page_folio(page), pagelist);
>  			if (!err)
> -				err = 1;
> +				err = -EBUSY;

Again, I think this is confusing.  'err' is 'bool', not 'int'.


Thanks,
SJ

>  		}
>  	} else {
>  		struct page *head;
> -- 
> 2.27.0
> 
