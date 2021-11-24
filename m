Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0E45C950
	for <lists+cgroups@lfdr.de>; Wed, 24 Nov 2021 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhKXQBR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Nov 2021 11:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhKXQBQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Nov 2021 11:01:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E0C061574;
        Wed, 24 Nov 2021 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MhRaQX30y19nymtN7XiLLZlWbPS4SbobGvSOfL7Qrks=; b=VWcQqruxbm2TEfSiEDvRf8EWp9
        i4YG+LkmraO3TfeifQvSRMDp6DVtjo6NuwHNNm7w9mmMhrdT3SoBe/tWe9brqTvQCZ7jZUs6T0ucc
        vX+aljEB/gNCEfxEjmrvv1+l395R0ThnB3iMrTAWrRMm3oTJnw94MzsSCTYF9QVeUI0p6A/2fLGBO
        61/8h4OIX0YlAYL8ybhL7MGaTNJuJM7ANRwGzp6TSshTFLDK40NOPz8IxvN54L3X/2lH89qqxL/rZ
        30wTPCtMr9Af5wOwli4O35Aca/Kgj0bE4wh2bXS9hHoU4/Dprs+kxcoVXS5U3v6/S6uE50Fiff0EE
        TAzAkjEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpuek-002Pnu-QR; Wed, 24 Nov 2021 15:57:58 +0000
Date:   Wed, 24 Nov 2021 15:57:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-mm@kvack.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YZ5hBtWPBpHDWzE4@casper.infradead.org>
References: <20211124151915.GA6163@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124151915.GA6163@haolee.io>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 24, 2021 at 03:19:15PM +0000, Hao Lee wrote:
> When several tasks are terminated simultaneously, lots of pages will be
> released, which can cause severe spinlock contention. Other tasks which
> are running on the same core will be seriously affected. We can yield
> cpu to fix this problem.

The realtime people will eat you alive for this suggestion.

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
