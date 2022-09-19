Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E95BC497
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiISIqi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiISIqh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 04:46:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F40DEC7;
        Mon, 19 Sep 2022 01:46:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D33EE224BA;
        Mon, 19 Sep 2022 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663577194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MX4uu+xV6DLjOCDILEIy5h7UKehnk580AmudT0PwRB8=;
        b=USmhped1YHzxlWo96BPqhJbJTFtcnwTr58J6Fpr40ZzJ1IdafHl63rqXOzNQ5bmyKFQzCu
        mq1D/W2BUC6ta11Tg6sakJlxxlitpIV+qacLelKIA42ErJW1Iz7p8tDuaxeQzI6EtoAjBZ
        riA4lTSKNQO8McJR08NOSU2txHhCEsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663577194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MX4uu+xV6DLjOCDILEIy5h7UKehnk580AmudT0PwRB8=;
        b=qIm6o08ANkq1myxnyaVyQr6nYEdLIScM8eQG7ZDNHzrD0BXMiTyqwXV6yMBimN78OvvMWK
        3RvNkrL/gt5vplCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD0A713A96;
        Mon, 19 Sep 2022 08:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id alMWLmosKGOXQgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 08:46:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E23DEA0682; Mon, 19 Sep 2022 10:46:33 +0200 (CEST)
Date:   Mon, 19 Sep 2022 10:46:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [patch v11 5/6] block, bfq: cleanup bfq_weights_tree add/remove
 apis
Message-ID: <20220919084633.nmzastqkjool5jnc@quack3>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <20220916071942.214222-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916071942.214222-6-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 16-09-22 15:19:41, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The 'bfq_data' and 'rb_root_cached' can both be accessed through
> 'bfq_queue', thus only pass 'bfq_queue' as parameter.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  block/bfq-iosched.c | 19 +++++++++----------
>  block/bfq-iosched.h | 10 +++-------
>  block/bfq-wf2q.c    | 18 ++++++------------
>  3 files changed, 18 insertions(+), 29 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 6d95b0e488a8..4ad4fa0dad4a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -870,9 +870,9 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
>   * In most scenarios, the rate at which nodes are created/destroyed
>   * should be low too.
>   */
> -void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> -			  struct rb_root_cached *root)
> +void bfq_weights_tree_add(struct bfq_queue *bfqq)
>  {
> +	struct rb_root_cached *root = &bfqq->bfqd->queue_weights_tree;
>  	struct bfq_entity *entity = &bfqq->entity;
>  	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
>  	bool leftmost = true;
> @@ -944,13 +944,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   * See the comments to the function bfq_weights_tree_add() for considerations
>   * about overhead.
>   */
> -void __bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			       struct bfq_queue *bfqq,
> -			       struct rb_root_cached *root)
> +void __bfq_weights_tree_remove(struct bfq_queue *bfqq)
>  {
> +	struct rb_root_cached *root;
> +
>  	if (!bfqq->weight_counter)
>  		return;
>  
> +	root = &bfqq->bfqd->queue_weights_tree;
>  	bfqq->weight_counter->num_active--;
>  	if (bfqq->weight_counter->num_active > 0)
>  		goto reset_entity_pointer;
> @@ -967,11 +968,9 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
>   * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
>   * of active groups for each queue's inactive parent entity.
>   */
> -void bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			     struct bfq_queue *bfqq)
> +void bfq_weights_tree_remove(struct bfq_queue *bfqq)
>  {
> -	__bfq_weights_tree_remove(bfqd, bfqq,
> -				  &bfqd->queue_weights_tree);
> +	__bfq_weights_tree_remove(bfqq);
>  }
>  
>  /*
> @@ -6220,7 +6219,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>  		bfqq->budget_timeout = jiffies;
>  
>  		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
> -		bfq_weights_tree_remove(bfqd, bfqq);
> +		bfq_weights_tree_remove(bfqq);
>  	}
>  
>  	now_ns = ktime_get_ns();
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 257acb54c6dc..4bb58ab0c90a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -973,13 +973,9 @@ struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
>  void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
>  struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
>  void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
> -void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> -			  struct rb_root_cached *root);
> -void __bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			       struct bfq_queue *bfqq,
> -			       struct rb_root_cached *root);
> -void bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			     struct bfq_queue *bfqq);
> +void bfq_weights_tree_add(struct bfq_queue *bfqq);
> +void __bfq_weights_tree_remove(struct bfq_queue *bfqq);
> +void bfq_weights_tree_remove(struct bfq_queue *bfqq);
>  void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		     bool compensate, enum bfqq_expiration reason);
>  void bfq_put_queue(struct bfq_queue *bfqq);
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 5e8224c96921..124aaea6196e 100644
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
> +			__bfq_weights_tree_remove(bfqq);
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
> +			bfq_weights_tree_add(bfqq);
>  
>  		new_st->wsum += entity->weight;
>  
> @@ -1687,7 +1682,7 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration)
>  		 * Next function is invoked last, because it causes bfqq to be
>  		 * freed. DO NOT use bfqq after the next function invocation.
>  		 */
> -		bfq_weights_tree_remove(bfqd, bfqq);
> +		bfq_weights_tree_remove(bfqq);
>  	}
>  }
>  
> @@ -1708,8 +1703,7 @@ void bfq_add_bfqq_busy(struct bfq_queue *bfqq)
>  	if (!bfqq->dispatched) {
>  		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
>  		if (bfqq->wr_coeff == 1)
> -			bfq_weights_tree_add(bfqd, bfqq,
> -					     &bfqd->queue_weights_tree);
> +			bfq_weights_tree_add(bfqq);
>  	}
>  
>  	if (bfqq->wr_coeff > 1)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
