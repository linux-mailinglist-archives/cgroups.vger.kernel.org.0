Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C379A596DD5
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbiHQLyZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiHQLyY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 07:54:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D18501B4;
        Wed, 17 Aug 2022 04:54:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF479201B7;
        Wed, 17 Aug 2022 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660737261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rm8JEW/rIpBp4i/6Owi2Iji64ulIai4y9uLFGtCpOBA=;
        b=hKkVXPJiBiQFS8b7QVhOX4+28k2oSDhXJVTO47zQOtYJ0z/Ow1orIVYID0P6wXesFungW7
        fmTHzwFYkjsh7nRXpW9prkzkIf8eIp3/aeN/Er6LHxSwUcvLGWU8g9LsUlR5QscQCXHYxo
        DnIYtFdB+HwUtavwnESO5r9v415UkCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660737261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rm8JEW/rIpBp4i/6Owi2Iji64ulIai4y9uLFGtCpOBA=;
        b=vWyxR/SHYYfgDsRdknJ7ivO45nsMCiTE1l4jWdy6yKQO7PELmEH86Oh6PyozdI5oWhEbcy
        Dffwd97uuLPbCcBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DD432C197;
        Wed, 17 Aug 2022 11:54:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 900AFA066B; Wed, 17 Aug 2022 13:54:20 +0200 (CEST)
Date:   Wed, 17 Aug 2022 13:54:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/3] block, bfq: remove useless checking in
 bfq_put_queue()
Message-ID: <20220817115420.dmzldiybx5xs4wqf@quack3>
References: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
 <20220816015631.1323948-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816015631.1323948-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 16-08-22 09:56:30, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 'bfqq->bfqd' is ensured to set in bfq_init_queue(), and it will never
> change afterwards.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c740b41fe0a4..f39067389b2b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5255,9 +5255,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>  	struct hlist_node *n;
>  	struct bfq_group *bfqg = bfqq_group(bfqq);
>  
> -	if (bfqq->bfqd)
> -		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d",
> -			     bfqq, bfqq->ref);
> +	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
>  
>  	bfqq->ref--;
>  	if (bfqq->ref)
> @@ -5321,7 +5319,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>  		hlist_del_init(&item->woken_list_node);
>  	}
>  
> -	if (bfqq->bfqd && bfqq->bfqd->last_completed_rq_bfqq == bfqq)
> +	if (bfqq->bfqd->last_completed_rq_bfqq == bfqq)
>  		bfqq->bfqd->last_completed_rq_bfqq = NULL;
>  
>  	kmem_cache_free(bfq_pool, bfqq);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
