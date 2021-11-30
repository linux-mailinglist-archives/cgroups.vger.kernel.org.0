Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50142462CF7
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 07:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhK3Gqf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 01:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhK3Gqf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Nov 2021 01:46:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC28C061574;
        Mon, 29 Nov 2021 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LbNjrOn/TR2DrlvunPAnXmZeUtVG1jTEm/amQL+7ym4=; b=uwQm3elvRY63sSd28fQaOo6GSO
        qwcqB7PI3Ee+ZNwfoKvARal12tj6fXqox/uqPWdZWzgjas0nWpkw2DPFGmLwha8f6qLIZbmiU5ykM
        SFCaAlohCL+RqZoejpKVHS64SiqmklbW5mzgofKxuzyCAoFPOOGi/OP6zJyvfCy8BaZ2kqRbnhFeP
        zc7DjA4qJa1Y1GmVqwL825mt9Tpok0yOWV1yqzj5ij4/yWqj0xlAtC6rqJqrJQBQBohzjZctdytMr
        iU2HwGIBPSGgPyisnozso/6UaFFR0sigr/lE9CFLBbBqFR3zHbYVv20DJCryAVAQO3YvclMdml6kr
        19EJViHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrwrB-003pTb-6C; Tue, 30 Nov 2021 06:43:13 +0000
Date:   Mon, 29 Nov 2021 22:43:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 1/2] blk-throtl: move WARN_ON_ONCE() from
 throtl_rb_first() to it's caller
Message-ID: <YaXIAaMRG7J0sHib@infradead.org>
References: <20211130011730.2584339-1-yukuai3@huawei.com>
 <20211130011730.2584339-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130011730.2584339-2-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 30, 2021 at 09:17:29AM +0800, Yu Kuai wrote:
> Prepare to reintroduce tg_drain_bios(), which will iterate until
> throtl_rb_first() return NULL.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 39bb6e68a9a2..f7244190cb2f 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -502,7 +502,6 @@ throtl_rb_first(struct throtl_service_queue *parent_sq)
>  	struct rb_node *n;
>  
>  	n = rb_first_cached(&parent_sq->pending_tree);
> -	WARN_ON_ONCE(!n);
>  	if (!n)
>  		return NULL;
>  	return rb_entry_tg(n);
> @@ -521,8 +520,10 @@ static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
>  	struct throtl_grp *tg;
>  
>  	tg = throtl_rb_first(parent_sq);
> -	if (!tg)
> +	if (!tg) {
> +		WARN_ON_ONCE(1);
>  		return;

	if (WARN_ON_ONCE(!tg))
		return;

>  		tg = throtl_rb_first(parent_sq);
> -		if (!tg)
> +		if (!tg) {
> +			WARN_ON_ONCE(1);
>  			break;
> +		}

Same here.
