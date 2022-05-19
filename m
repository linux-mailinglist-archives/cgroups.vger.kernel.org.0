Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E652D10D
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiESLCP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiESLCM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:02:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EBD6830D;
        Thu, 19 May 2022 04:02:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31578219AD;
        Thu, 19 May 2022 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652958125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tCaNooOkaDcvcv6PCUEW0LqLLKKJTw0gD9Hod1PSGA=;
        b=1AiKxwZkumz5PQU0f03qy83y6g+kaSp+rGayk8zPMusm3N8Wdr/Q5KAlIayTsDOHtQJPH8
        b5Mb+PVSU43rt0QjCZH64AALhnVKpruOI/vz502lYVcgXJbK7vy3ljTXl9+7hviIGhymnY
        cS7rxy71rZRO+ulqb/iKevjdCJiLGtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652958125;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tCaNooOkaDcvcv6PCUEW0LqLLKKJTw0gD9Hod1PSGA=;
        b=ROQdBvocG9Mar1VWAg+leJDJ6t6pHEeG84adMFhXpkyUIVsCK7E/LIDZnFXI2HL6hoxVCF
        oy43O/3EKigTscDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2108A2C141;
        Thu, 19 May 2022 11:02:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D17A2A062F; Thu, 19 May 2022 13:02:04 +0200 (CEST)
Date:   Thu, 19 May 2022 13:02:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/8] block, bfq: cleanup __bfq_weights_tree_remove()
Message-ID: <20220519110204.yf7j65ko5wnmsojr@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:16, Yu Kuai wrote:
> It's the same with bfq_weights_tree_remove() now.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 13 +------------
>  block/bfq-iosched.h |  1 -
>  block/bfq-wf2q.c    |  2 +-
>  3 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index bcbe78d71143..1d0141c450c0 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -944,8 +944,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>   * See the comments to the function bfq_weights_tree_add() for considerations
>   * about overhead.
>   */
> -void __bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			       struct bfq_queue *bfqq)
> +void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  {
>  	struct rb_root_cached *root;
>  	if (!bfqq->weight_counter)
> @@ -964,16 +963,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
>  	bfq_put_queue(bfqq);
>  }
>  
> -/*
> - * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
> - * of active groups for each queue's inactive parent entity.
> - */
> -void bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			     struct bfq_queue *bfqq)
> -{
> -	__bfq_weights_tree_remove(bfqd, bfqq);
> -}
> -
>  /*
>   * Return expired entry, or NULL to just start from scratch in rbtree.
>   */
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 0a3415abb994..bc54b9824b1e 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -933,7 +933,6 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
>  struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
>  void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
>  void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq);
> -void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
>  void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
>  void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		     bool compensate, enum bfqq_expiration reason);
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index ccd227fed1c3..2f3fb45a32c3 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -790,7 +790,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
>  		 * there is a counter associated with the entity).
>  		 */
>  		if (prev_weight != new_weight && bfqq)
> -			__bfq_weights_tree_remove(bfqd, bfqq);
> +			bfq_weights_tree_remove(bfqd, bfqq);
>  		entity->weight = new_weight;
>  		/*
>  		 * Add the entity, if it is not a weight-raised queue,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
