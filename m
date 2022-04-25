Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26350DCE5
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiDYJmA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbiDYJlY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 05:41:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD017051;
        Mon, 25 Apr 2022 02:37:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BCF1D210E5;
        Mon, 25 Apr 2022 09:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650879438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKzPZSZjl/CuIwENsnn/SueNKmgq+oSUkjLiGdxjrMA=;
        b=RjxNMVpIYiZeOVcck2OTzhAgsn/etT3h6srkKhwtsjKo6HtUVxvjbuDwIT/0mg/Ua7fJhw
        pwGeeIon9y/cWp9fs9hZEVH0l18cIBdAxdS8K9797rxvkDQQ2isqTAxrS2x0hpNK/UFOUP
        RGgmMyPduVR6UIsFmKaxYgqsTkQgI9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650879438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKzPZSZjl/CuIwENsnn/SueNKmgq+oSUkjLiGdxjrMA=;
        b=BhZGwetAzIrrfnZsS/+C5b2Y8bNuVhmDcP2dSQuLjyce8OsHoOrcFx6hWf9hmrOcKEF5Is
        bxCyxSbQic/PapAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9AC792C142;
        Mon, 25 Apr 2022 09:37:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35574A0620; Mon, 25 Apr 2022 11:37:15 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:37:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 1/5] block, bfq: cleanup bfq_weights_tree
 add/remove apis
Message-ID: <20220425093715.5ufwrgqrtyoqzjp3@quack3.lan>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416093753.3054696-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 16-04-22 17:37:49, Yu Kuai wrote:
> They already pass 'bfqd' as the first parameter, there is no need to
> pass 'bfqd->queue_weights_tree' as another parameter.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Nice cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 14 +++++++-------
>  block/bfq-iosched.h |  7 ++-----
>  block/bfq-wf2q.c    | 16 +++++-----------
>  3 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 2e0dd68a3cbe..2deea2d07a1f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -862,9 +862,9 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
>   * In most scenarios, the rate at which nodes are created/destroyed
>   * should be low too.
>   */
> -void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> -			  struct rb_root_cached *root)
> +void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  {
> +	struct rb_root_cached *root = &bfqd->queue_weights_tree;
>  	struct bfq_entity *entity = &bfqq->entity;
>  	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
>  	bool leftmost = true;
> @@ -936,13 +936,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   * See the comments to the function bfq_weights_tree_add() for considerations
>   * about overhead.
>   */
> -void __bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			       struct bfq_queue *bfqq,
> -			       struct rb_root_cached *root)
> +void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  {
> +	struct rb_root_cached *root;
> +
>  	if (!bfqq->weight_counter)
>  		return;
>  
> +	root = &bfqd->queue_weights_tree;
>  	bfqq->weight_counter->num_active--;
>  	if (bfqq->weight_counter->num_active > 0)
>  		goto reset_entity_pointer;
> @@ -1004,8 +1005,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>  	 * has no dispatched request. DO NOT use bfqq after the next
>  	 * function invocation.
>  	 */
> -	__bfq_weights_tree_remove(bfqd, bfqq,
> -				  &bfqd->queue_weights_tree);
> +	__bfq_weights_tree_remove(bfqd, bfqq);
>  }
>  
>  /*
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 3b83e3d1c2e5..072099b0c11a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -969,11 +969,8 @@ struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
>  void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
>  struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
>  void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
> -void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> -			  struct rb_root_cached *root);
> -void __bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			       struct bfq_queue *bfqq,
> -			       struct rb_root_cached *root);
> +void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq);
> +void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
>  void bfq_weights_tree_remove(struct bfq_data *bfqd,
>  			     struct bfq_queue *bfqq);
>  void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..a1296058c1ec 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -707,7 +707,6 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
>  		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
>  		unsigned int prev_weight, new_weight;
>  		struct bfq_data *bfqd = NULL;
> -		struct rb_root_cached *root;
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>  		struct bfq_sched_data *sd;
>  		struct bfq_group *bfqg;
> @@ -770,19 +769,15 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
>  		 * queue, remove the entity from its old weight counter (if
>  		 * there is a counter associated with the entity).
>  		 */
> -		if (prev_weight != new_weight && bfqq) {
> -			root = &bfqd->queue_weights_tree;
> -			__bfq_weights_tree_remove(bfqd, bfqq, root);
> -		}
> +		if (prev_weight != new_weight && bfqq)
> +			__bfq_weights_tree_remove(bfqd, bfqq);
>  		entity->weight = new_weight;
>  		/*
>  		 * Add the entity, if it is not a weight-raised queue,
>  		 * to the counter associated with its new weight.
>  		 */
> -		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1) {
> -			/* If we get here, root has been initialized. */
> -			bfq_weights_tree_add(bfqd, bfqq, root);
> -		}
> +		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1)
> +			bfq_weights_tree_add(bfqd, bfqq);
>  
>  		new_st->wsum += entity->weight;
>  
> @@ -1686,8 +1681,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  
>  	if (!bfqq->dispatched)
>  		if (bfqq->wr_coeff == 1)
> -			bfq_weights_tree_add(bfqd, bfqq,
> -					     &bfqd->queue_weights_tree);
> +			bfq_weights_tree_add(bfqd, bfqq);
>  
>  	if (bfqq->wr_coeff > 1)
>  		bfqd->wr_busy_queues++;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
