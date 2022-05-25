Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4407C533568
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiEYCkP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 22:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiEYCkN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 22:40:13 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F066F4AF;
        Tue, 24 May 2022 19:40:12 -0700 (PDT)
Date:   Tue, 24 May 2022 19:40:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653446411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KAxO13FUFJl5HNca6Xvp5Gx3Mgidd0SxL8fHIYPeSTs=;
        b=mSuHENlGfnxO3FTaUSRUpf/IIEViYyJ4mGmgEBelAUTW+xU6c6mZ7AXfEM6XNqh69TPTWG
        OpBdtK4UK8Q7NF6A7JieL458LvOR+8Mu97azYnXm3cv3lmn3v2aWVElLkktoeZiWBWjYvv
        D5D98KSYGsIN2RS4Ak1JcE6tlSKmSgM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance
 function
Message-ID: <Yo2XBdLxcJ/J6KJp@carbon>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-11-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 02:05:50PM +0800, Muchun Song wrote:
> We need to make sure that the page is deleted from or added to the
> correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
> users.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm_inline.h | 6 ++++++
>  mm/vmscan.c               | 1 -
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index ac32125745ab..30d2393da613 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -97,6 +97,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
>  {
>  	enum lru_list lru = folio_lru_list(folio);
>  
> +	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
> +
>  	update_lru_size(lruvec, lru, folio_zonenum(folio),
>  			folio_nr_pages(folio));
>  	if (lru != LRU_UNEVICTABLE)
> @@ -114,6 +116,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
>  {
>  	enum lru_list lru = folio_lru_list(folio);
>  
> +	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
> +
>  	update_lru_size(lruvec, lru, folio_zonenum(folio),
>  			folio_nr_pages(folio));
>  	/* This is not expected to be used on LRU_UNEVICTABLE */
> @@ -131,6 +135,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
>  {
>  	enum lru_list lru = folio_lru_list(folio);
>  
> +	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
> +
>  	if (lru != LRU_UNEVICTABLE)
>  		list_del(&folio->lru);
>  	update_lru_size(lruvec, lru, folio_zonenum(folio),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 761d5e0dd78d..6c9e2eafc8f9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2281,7 +2281,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
>  			continue;
>  		}
>  
> -		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);

The commit log describes well why we need to add new BUG_ON's. Please, add
something on why this is removed.


Thanks!
