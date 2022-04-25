Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70350DD20
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiDYJwP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbiDYJwE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 05:52:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C413EA9B;
        Mon, 25 Apr 2022 02:49:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C7AA221123;
        Mon, 25 Apr 2022 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650880138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n215KfJqkHmi9Mmq49cvfsGZ/OiTnyFPqnXnfcZ0qHY=;
        b=O/h/zQi9hrK066WJ3e/N9k1cERZXJmAywDnFMxEiP/8Ak03zf50M/34yUDFj/yA9dnVuBk
        nL7KAymiXMDyRs7i50snJXCrvxf+/6Tk/J1Xq/httxDAlHAA4cNdV1CANpR6A8yi9VgEvZ
        giGifkoxTEp0tgjkAc2mhyTZCLBW9d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650880138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n215KfJqkHmi9Mmq49cvfsGZ/OiTnyFPqnXnfcZ0qHY=;
        b=KMXPa11Mj9t2r011fFWDg6Gvp9XR7amRkx+PRp8NltpciOjYcX8dTBsaT6kfNYVav2Axfh
        4o0CKWG1qJ+KOaCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AAFA72C172;
        Mon, 25 Apr 2022 09:48:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 87D48A0620; Mon, 25 Apr 2022 11:48:56 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:48:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for
 weight-raised queue
Message-ID: <20220425094856.qgkhba2klguduxot@quack3.lan>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416093753.3054696-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 16-04-22 17:37:50, Yu Kuai wrote:
> Weight-raised queue is not inserted to weights_tree, which makes it
> impossible to track how many queues have pending requests through
> weights_tree insertion and removel. This patch add fake weight_counter
> for weight-raised queue to do that.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

This is a bit hacky. I was looking into a better place where to hook to
count entities in a bfq_group with requests and I think bfq_add_bfqq_busy()
and bfq_del_bfqq_busy() are ideal for this. It also makes better sense
conceptually than hooking into weights tree handling.

Other than this the rest of the series looks fine to me.

								Honza

> ---
>  block/bfq-iosched.c | 11 +++++++++++
>  block/bfq-wf2q.c    |  5 ++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 2deea2d07a1f..a2977c938c70 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -134,6 +134,8 @@
>  #include "bfq-iosched.h"
>  #include "blk-wbt.h"
>  
> +#define BFQ_FAKE_WEIGHT_COUNTER ((void *) POISON_INUSE)
> +
>  #define BFQ_BFQQ_FNS(name)						\
>  void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)			\
>  {									\
> @@ -884,6 +886,12 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  	if (bfqq->weight_counter)
>  		return;
>  
> +	if (bfqq->wr_coeff != 1) {
> +		bfqq->weight_counter = BFQ_FAKE_WEIGHT_COUNTER;
> +		bfqq->ref++;
> +		return;
> +	}
> +
>  	while (*new) {
>  		struct bfq_weight_counter *__counter = container_of(*new,
>  						struct bfq_weight_counter,
> @@ -943,6 +951,9 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  	if (!bfqq->weight_counter)
>  		return;
>  
> +	if (bfqq->weight_counter == BFQ_FAKE_WEIGHT_COUNTER)
> +		goto reset_entity_pointer;
> +
>  	root = &bfqd->queue_weights_tree;
>  	bfqq->weight_counter->num_active--;
>  	if (bfqq->weight_counter->num_active > 0)
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index a1296058c1ec..ae12c6b2c525 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -776,7 +776,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
>  		 * Add the entity, if it is not a weight-raised queue,
>  		 * to the counter associated with its new weight.
>  		 */
> -		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1)
> +		if (prev_weight != new_weight && bfqq)
>  			bfq_weights_tree_add(bfqd, bfqq);
>  
>  		new_st->wsum += entity->weight;
> @@ -1680,8 +1680,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
>  
>  	if (!bfqq->dispatched)
> -		if (bfqq->wr_coeff == 1)
> -			bfq_weights_tree_add(bfqd, bfqq);
> +		bfq_weights_tree_add(bfqd, bfqq);
>  
>  	if (bfqq->wr_coeff > 1)
>  		bfqd->wr_busy_queues++;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
