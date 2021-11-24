Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE68845CA18
	for <lists+cgroups@lfdr.de>; Wed, 24 Nov 2021 17:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348974AbhKXQfK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Nov 2021 11:35:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348973AbhKXQfI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Nov 2021 11:35:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3367B21954;
        Wed, 24 Nov 2021 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637771518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Zlxw+Rp7HNPM08yf9RQ2otAy6kMKKm82h1DuizBhVs=;
        b=kvlaZyAZtdO4xGJaVhlIbgldeZDe8dWDxYpweto04dNhK1HokcngfkMFYHnNhQ1FIoqcKY
        czfjxXpIhR8yBj9ho9sTua3vCySoFNJoVI4oj93jjj75cASczmfdA3axwSPaU9Hnz5d/Ed
        nRrVTk/DxaqY6WuhTRi4RMh5BmMNbTY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 007D4A3B8A;
        Wed, 24 Nov 2021 16:31:57 +0000 (UTC)
Date:   Wed, 24 Nov 2021 17:31:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-mm@kvack.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YZ5o/VmU59evp65J@dhcp22.suse.cz>
References: <20211124151915.GA6163@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124151915.GA6163@haolee.io>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 24-11-21 15:19:15, Hao Lee wrote:
> When several tasks are terminated simultaneously, lots of pages will be
> released, which can cause severe spinlock contention. Other tasks which
> are running on the same core will be seriously affected. We can yield
> cpu to fix this problem.

How does this actually address the problem? You are effectivelly losing
fairness completely. We do batch currently so no single task should be
able to monopolize the cpu for too long. Why this is not sufficient?

> diff --git a/mm/swap.c b/mm/swap.c
> index e8c9dc6d0377..91850d51a5a5 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -960,8 +960,14 @@ void release_pages(struct page **pages, int nr)
>  		if (PageLRU(page)) {
>  			struct lruvec *prev_lruvec = lruvec;
>  
> -			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
> +retry:
> +			lruvec = folio_lruvec_tryrelock_irqsave(folio, lruvec,
>  									&flags);
> +			if (!lruvec) {
> +				cond_resched();
> +				goto retry;
> +			}
> +
>  			if (prev_lruvec != lruvec)
>  				lock_batch = 0;
>  
> -- 
> 2.31.1

-- 
Michal Hocko
SUSE Labs
