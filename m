Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F245A4615BD
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 14:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbhK2NHH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 08:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhK2NFG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 08:05:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B4AC08EB48;
        Mon, 29 Nov 2021 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FkF4T6LyDRZD+GT3vXQ9zF5ShtYF3Ys/OCkZGkfK2+Y=; b=05kuobI0TGEk0Qbh2JIN2BdBtk
        CqhqbxF/F4RxxjZmgIxQ17t05TFxBI2DIYlsZo+x2ZJBZ6oYxPf3BjASshWrwLLKP+L0Guy+RQX7P
        Iyj5dx5ilKdakTfO2dDgqmfzdDxXjBLlsUwQe5XC/ANV43WhIdFt5S+Bng0EhR37RcHIFJMWPUDu6
        +8bMZJe56139yfO0kXStJsbxFaCJ2ptvcc0hmjeMHboMOEGNVeXgXmULYCnmLbP64IROmon3Mg3aX
        CDd2NY0oDsu0UfseR0I4SmQ1JMH7BJzs/S9yyVe4uLoLtBmqoA0SXbbVFJn92CjE7cpV+6Eizj5Ii
        T6OCnfGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrf7N-000ZFW-Dh; Mon, 29 Nov 2021 11:46:45 +0000
Date:   Mon, 29 Nov 2021 03:46:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/4] blk-throtl: don't warn in tg_drain_bios()
Message-ID: <YaS9pfngMscOM3XA@infradead.org>
References: <20211127101059.477405-1-yukuai3@huawei.com>
 <20211127101059.477405-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127101059.477405-3-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 27, 2021 at 06:10:57PM +0800, Yu Kuai wrote:
> tg_drain_bios() will iterate until throtl_rb_first() return NULL,
> don't warn in such situation.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 230e300c5856..25822c88bea1 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -497,12 +497,13 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
>  }
>  
>  static struct throtl_grp *
> -throtl_rb_first(struct throtl_service_queue *parent_sq)
> +throtl_rb_first(struct throtl_service_queue *parent_sq, bool warn)
>  {
>  	struct rb_node *n;
>  
>  	n = rb_first_cached(&parent_sq->pending_tree);
> -	WARN_ON_ONCE(!n);
> +	if (warn)
> +		WARN_ON_ONCE(!n);
>  	if (!n)
>  		return NULL;

Just shift then WARN_ON_ONCE into the callers that care.
