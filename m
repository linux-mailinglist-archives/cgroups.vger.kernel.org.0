Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ACA539F8C
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350808AbiFAIcC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245286AbiFAIcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 04:32:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE425C59;
        Wed,  1 Jun 2022 01:31:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 71B411F8C2;
        Wed,  1 Jun 2022 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654072318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+sBqa5KqKk9l80H2r4a0EQswvDm6hf4uMYYGP+soqU=;
        b=UxNmGl10x6Mtb4IZHTscIz8gWRW6HgF7JeSkIFA3/SMZ5MwO0itfPzFfdXeKigeq6uDjFv
        4bN0nY9B+vKQGrWWuPqxBwF5Z497j6B5lQghIy91xnE+J+DE61r32CWreN75yDmIIi/rxx
        YqGgm/bp0Nehl08MPwXkSt/rXYKsbtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654072318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+sBqa5KqKk9l80H2r4a0EQswvDm6hf4uMYYGP+soqU=;
        b=Vs/bVFe2dUMiW8BMd3aoA58GmzvJhI2Br3qV3wc/S6BZRK+F80A/62NZGf4xz6rrZK0LnZ
        x5Ym+gWftWBAPUBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5C3822C141;
        Wed,  1 Jun 2022 08:31:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CF690A0633; Wed,  1 Jun 2022 10:31:54 +0200 (CEST)
Date:   Wed, 1 Jun 2022 10:31:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     paolo.valente@linaro.org, jack@suse.cz, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v8 1/4] block, bfq: support to track if bfqq has
 pending requests
Message-ID: <20220601083154.5ip7r6w7kjb3bof2@quack3.lan>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
 <20220531140858.3324294-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531140858.3324294-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 31-05-22 22:08:55, Yu Kuai wrote:
> If entity belongs to bfqq, then entity->in_groups_with_pending_reqs
> is not used currently. This patch use it to track if bfqq has pending
> requests through callers of weights_tree insertion and removal.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c |  1 +
>  block/bfq-iosched.h |  1 +
>  block/bfq-wf2q.c    | 24 ++++++++++++++++++++++--
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0d46cb728bbf..0ec21018daba 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6263,6 +6263,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>  		 */
>  		bfqq->budget_timeout = jiffies;
>  
> +		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>  		bfq_weights_tree_remove(bfqd, bfqq);
>  	}
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index ca8177d7bf7c..3b9b1a0e7c1c 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -1080,6 +1080,7 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		       bool expiration);
>  void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
> +void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
>  
>  /* --------------- end of interface of B-WF2Q+ ---------------- */
>  
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..12d20f26ad69 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1647,6 +1647,22 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  				    bfqq == bfqd->in_service_queue, expiration);
>  }
>  
> +static void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> +{
> +	struct bfq_entity *entity = &bfqq->entity;
> +
> +	if (!entity->in_groups_with_pending_reqs)
> +		entity->in_groups_with_pending_reqs = true;
> +}
> +
> +void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> +{
> +	struct bfq_entity *entity = &bfqq->entity;
> +
> +	if (entity->in_groups_with_pending_reqs)
> +		entity->in_groups_with_pending_reqs = false;
> +}
> +
>  /*
>   * Called when the bfqq no longer has requests pending, remove it from
>   * the service tree. As a special case, it can be invoked during an
> @@ -1668,8 +1684,10 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  
>  	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
>  
> -	if (!bfqq->dispatched)
> +	if (!bfqq->dispatched) {
> +		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>  		bfq_weights_tree_remove(bfqd, bfqq);
> +	}
>  }
>  
>  /*
> @@ -1684,10 +1702,12 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  	bfq_mark_bfqq_busy(bfqq);
>  	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
>  
> -	if (!bfqq->dispatched)
> +	if (!bfqq->dispatched) {
> +		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
>  		if (bfqq->wr_coeff == 1)
>  			bfq_weights_tree_add(bfqd, bfqq,
>  					     &bfqd->queue_weights_tree);
> +	}
>  
>  	if (bfqq->wr_coeff > 1)
>  		bfqd->wr_busy_queues++;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
