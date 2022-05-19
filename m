Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E452D11A
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiESLEo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiESLEn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:04:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B8B040A;
        Thu, 19 May 2022 04:04:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB84621B50;
        Thu, 19 May 2022 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652958280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orOM1dbtkEUuaA5nZ+QXtL7Q18/Bb1xuA+iH5TdUsIk=;
        b=O836gp5vNCwPOlnjIkNcY+Di/lZDq171YALBGRwwOI8h4WO0KlVUTQW5FxDviwOVGH0ZOx
        l4jor1zL30JM7LAjokos0V3DnxwPp77cZmB2Qm83FV6r8khXbPCowiAXPGTHtOWiNfNZEx
        /Appq/u4XBmaye4AB3CGkmTa4MXOmaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652958280;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orOM1dbtkEUuaA5nZ+QXtL7Q18/Bb1xuA+iH5TdUsIk=;
        b=gf2X2pbdh+QX8iLU3e4okdOQoPFgfRGmJeIZTWe/5GwWvg3YyO+Nc2XsgP7qcfjWjD4nP+
        3QgRkXVHIpBOzKDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D88652C141;
        Thu, 19 May 2022 11:04:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 84384A062F; Thu, 19 May 2022 13:04:40 +0200 (CEST)
Date:   Thu, 19 May 2022 13:04:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 3/8] block, bfq: factor out code to update
 'active_entities'
Message-ID: <20220519110440.hfvv4lvxqcwrpqtu@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-4-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:17, Yu Kuai wrote:
> Current code is a bit ugly and hard to read.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Yeah, looks a bit better. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-wf2q.c | 61 +++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 2f3fb45a32c3..c58568a4b009 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -230,6 +230,26 @@ static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
>  		bfqq->bfqd->num_groups_with_busy_queues--;
>  }
>  
> +static void bfq_inc_active_entities(struct bfq_entity *entity)
> +{
> +	struct bfq_sched_data *sd = entity->sched_data;
> +	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
> +	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
> +
> +	if (bfqg != bfqd->root_group)
> +		bfqg->active_entities++;
> +}
> +
> +static void bfq_dec_active_entities(struct bfq_entity *entity)
> +{
> +	struct bfq_sched_data *sd = entity->sched_data;
> +	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
> +	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
> +
> +	if (bfqg != bfqd->root_group)
> +		bfqg->active_entities--;
> +}
> +
>  #else /* CONFIG_BFQ_GROUP_IOSCHED */
>  
>  static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
> @@ -250,6 +270,14 @@ static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
>  {
>  }
>  
> +static void bfq_inc_active_entities(struct bfq_entity *entity)
> +{
> +}
> +
> +static void bfq_dec_active_entities(struct bfq_entity *entity)
> +{
> +}
> +
>  #endif /* CONFIG_BFQ_GROUP_IOSCHED */
>  
>  /*
> @@ -476,11 +504,6 @@ static void bfq_active_insert(struct bfq_service_tree *st,
>  {
>  	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
>  	struct rb_node *node = &entity->rb_node;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	struct bfq_sched_data *sd = NULL;
> -	struct bfq_group *bfqg = NULL;
> -	struct bfq_data *bfqd = NULL;
> -#endif
>  
>  	bfq_insert(&st->active, entity);
>  
> @@ -491,17 +514,10 @@ static void bfq_active_insert(struct bfq_service_tree *st,
>  
>  	bfq_update_active_tree(node);
>  
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	sd = entity->sched_data;
> -	bfqg = container_of(sd, struct bfq_group, sched_data);
> -	bfqd = (struct bfq_data *)bfqg->bfqd;
> -#endif
>  	if (bfqq)
>  		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (bfqg != bfqd->root_group)
> -		bfqg->active_entities++;
> -#endif
> +
> +	bfq_inc_active_entities(entity);
>  }
>  
>  /**
> @@ -578,29 +594,16 @@ static void bfq_active_extract(struct bfq_service_tree *st,
>  {
>  	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
>  	struct rb_node *node;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	struct bfq_sched_data *sd = NULL;
> -	struct bfq_group *bfqg = NULL;
> -	struct bfq_data *bfqd = NULL;
> -#endif
>  
>  	node = bfq_find_deepest(&entity->rb_node);
>  	bfq_extract(&st->active, entity);
>  
>  	if (node)
>  		bfq_update_active_tree(node);
> -
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	sd = entity->sched_data;
> -	bfqg = container_of(sd, struct bfq_group, sched_data);
> -	bfqd = (struct bfq_data *)bfqg->bfqd;
> -#endif
>  	if (bfqq)
>  		list_del(&bfqq->bfqq_list);
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (bfqg != bfqd->root_group)
> -		bfqg->active_entities--;
> -#endif
> +
> +	bfq_dec_active_entities(entity);
>  }
>  
>  /**
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
