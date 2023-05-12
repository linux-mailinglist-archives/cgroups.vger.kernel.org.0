Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44557004A7
	for <lists+cgroups@lfdr.de>; Fri, 12 May 2023 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjELKFi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 May 2023 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbjELKFO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 May 2023 06:05:14 -0400
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [IPv6:2001:41d0:203:375::28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835C10A3B
        for <cgroups@vger.kernel.org>; Fri, 12 May 2023 03:04:54 -0700 (PDT)
Message-ID: <fecc63de-9477-cad4-79f3-bdb1f1e3ab5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683885592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0JL1nhvy2ngw84v1yQfJqMPUYFftdCNHh/mrNVJuFQ=;
        b=VDZwyA0YGJ/KFhQoo2GxCv9LWe6GedDa244Vnxy7pKf6QEG79Gt2/sr6tAxJrwxzZcNPWs
        QDt/mNnzz+oKFvV7NGkJ8SX0kjUYCzDYmspt8qaTPfv9nvEcUrNeuOJh2kbyKy7tt7dS3n
        RzyAvowXz/3bqX6dDj5/n2CPMr2Kpc4=
Date:   Fri, 12 May 2023 17:59:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH -next v2 1/6] blk-wbt: fix that wbt can't be disabled by
 default
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, lukas.bulwahn@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
 <20230512093554.911753-2-yukuai1@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230512093554.911753-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/5/12 17:35, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
> wbt_enable_default()") removes the checking of CONFIG_BLK_WBT_MQ by
> mistake, which is used to control enable or disable wbt by default.
> 
> Fix the problem by adding back the checking. This patch also do a litter
> cleanup to make related code more readable.
> 
> Fixes: b11d31ae01e6 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
> Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Link: https://lore.kernel.org/lkml/CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com/t/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-wbt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index e49a48684532..9ec2a2f1eda3 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -730,14 +730,16 @@ void wbt_enable_default(struct gendisk *disk)
>  {
>  	struct request_queue *q = disk->queue;
>  	struct rq_qos *rqos;
> -	bool disable_flag = q->elevator &&
> -		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
> +	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
> +
> +	if (q->elevator &&
> +	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
> +		enable = false;

Why not just early return, so "enable" is not needed at all?

I have another question that CONFIG_BLK_WBT_MQ is not much flexible, can we
just get rid of it? (I'm not sure when to disable it in the config)

Thanks.

>  
>  	/* Throttling already enabled? */
>  	rqos = wbt_rq_qos(q);
>  	if (rqos) {
> -		if (!disable_flag &&
> -		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
> +		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
>  			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
>  		return;
>  	}
> @@ -746,7 +748,7 @@ void wbt_enable_default(struct gendisk *disk)
>  	if (!blk_queue_registered(q))
>  		return;
>  
> -	if (queue_is_mq(q) && !disable_flag)
> +	if (queue_is_mq(q) && enable)
>  		wbt_init(disk);
>  }
>  EXPORT_SYMBOL_GPL(wbt_enable_default);
