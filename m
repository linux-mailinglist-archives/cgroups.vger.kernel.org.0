Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A750B5331D2
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiEXTiy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiEXTix (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 15:38:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608875205
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:38:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l82so11134735qke.3
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnMNwdiDuKNvcNvHgJhe6ilL5BSVkcDVAFFW/UQvNfs=;
        b=pSUp9QP4W736sqLANtAdsbjcRxz7NxrgIsEjTxS91pMbK6MTlMhrm614GZKG+ZIZbh
         iy9WT5WKW0//Z4XyhuoEObIzJK7/VSRFbhHydJajpTdSneWWzCXiZ+Qd92OzgcqAjq/B
         DgRjbCbFqtxfsgTgZLqSu5BOxuSvCQVg1SrGaDKURpJhCRAhkJm+k7oixIVzT3lJdFlx
         oTz3WPP00s/i7i+MIM5I+ZU01FbelOHQX9riGe2P9gCaRTQ0imjJ4ZWrUAmXI6xOYg56
         w43gFLQ9qfZxe34KG9XEHzI7kFN5BbtFfjsEea8+I/OaP6R5fmeQM7sMVnflF1nol3iw
         cwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnMNwdiDuKNvcNvHgJhe6ilL5BSVkcDVAFFW/UQvNfs=;
        b=cavXs/WfitjtHvvb+o2mCW98LWX7uhEl6nRIjpkFcp3ZSi8PPDXV1t0kkZA98aav3D
         97UAt459CyeUIZRBSp35gjrfUqna4qvvMHYoU+AF5PXgqrFB07bPKXdDCmKlAIUotZGS
         exoM75fZxvk3g9YqtqJ8sXZxgKCFLGi9kbxok8mCmmv3YxLUQeKCtQF/8C44ghOihYlq
         I5TsQgbS4mxJ7JGtBlzt5QDUufY5x3Z4hNduMvkUDxNmyRlhd3Prp3RKj43mIN8VHQod
         2Rr21fdy8RdiqUUTo9cmTINBYsX2OOXDSNga3zFQUBnKPtMUwx9/Oj6Y2IWlrbuTcIYN
         oF7w==
X-Gm-Message-State: AOAM530UmCWhRZyqfEo3RSodNVrYELK86pRVQTs9FEIG2XVn7/vhllst
        +G+rFdQnxozsM+T4gpEv9HSFzg==
X-Google-Smtp-Source: ABdhPJzpIEt5iXGru2w27WyHG1PnabM7gE/0alg9o2icl4RBIq96dAtM8gIayTZ3UyzOh6zuMEmngg==
X-Received: by 2002:a05:620a:2412:b0:6a0:5f8e:c050 with SMTP id d18-20020a05620a241200b006a05f8ec050mr18145974qkn.462.1653421131663;
        Tue, 24 May 2022 12:38:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a0d5000b006a33c895d25sm75913qkl.21.2022.05.24.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:38:51 -0700 (PDT)
Date:   Tue, 24 May 2022 15:38:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Message-ID: <Yo00Svsy/N8cJVmf@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-5-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 02:05:44PM +0800, Muchun Song wrote:
> In the later patch, we will reparent the LRU pages. The pages moved to
> appropriate LRU list can be reparented during the process of the
> move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
> should use the more general interface of folio_lruvec_relock_irq() to
> acquire the correct lruvec lock.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/vmscan.c | 49 +++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..761d5e0dd78d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2230,23 +2230,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>   * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
>   * On return, @list is reused as a list of pages to be freed by the caller.
>   *
> - * Returns the number of pages moved to the given lruvec.
> + * Returns the number of pages moved to the appropriate LRU list.
> + *
> + * Note: The caller must not hold any lruvec lock.
>   */
> -static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> -				      struct list_head *list)
> +static unsigned int move_pages_to_lru(struct list_head *list)
>  {
> -	int nr_pages, nr_moved = 0;
> +	int nr_moved = 0;
> +	struct lruvec *lruvec = NULL;
>  	LIST_HEAD(pages_to_free);
> -	struct page *page;
>  
>  	while (!list_empty(list)) {
> -		page = lru_to_page(list);
> +		int nr_pages;
> +		struct folio *folio = lru_to_folio(list);
> +		struct page *page = &folio->page;
> +
> +		lruvec = folio_lruvec_relock_irq(folio, lruvec);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
>  		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			spin_unlock_irq(&lruvec->lru_lock);
> +			unlock_page_lruvec_irq(lruvec);

Better to stick with the opencoded unlock. It matches a bit better
with the locking function, compared to locking folio and unlocking
page...

Aside from that, this looks good:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
