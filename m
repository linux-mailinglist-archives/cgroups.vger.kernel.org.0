Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB252D11E
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiESLGQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiESLGE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:06:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2824BE7;
        Thu, 19 May 2022 04:06:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A754A1F86B;
        Thu, 19 May 2022 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652958361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G691x8yrwjJK70XDCvEA+7NWlNJBNJSIMk+vjCwj6r4=;
        b=ffZsclxTGiPP66jx++30qK5ygHGXciw8DGTfMja+vtpK158/OzQ4uBR/+DPnSyLhif48hS
        azrAU86BygC16PEvrlGj7akvR2SzoqicB8rh36lOWcqB3IXCh9X1UIQMh+LySH1Rb4YaL4
        EDcnbTW+EcAg3mCIpkvWuRF8RHkRVpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652958361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G691x8yrwjJK70XDCvEA+7NWlNJBNJSIMk+vjCwj6r4=;
        b=SSG3nh7xh6zpmisj7ikCyh/AqNy4rdasR0c0EwwIHpxze4mbx6Jno9Lc+17/F1NSr4NemN
        lFfmThT4xUi1sYAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9502C2C141;
        Thu, 19 May 2022 11:06:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 50711A062F; Thu, 19 May 2022 13:06:01 +0200 (CEST)
Date:   Thu, 19 May 2022 13:06:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 5/8] block, bfq: cleanup
 bfq_activate_requeue_entity()
Message-ID: <20220519110601.vols2d4npm4pgvns@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-6-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:19, Yu Kuai wrote:
> Just make the code a litter cleaner by removing the unnecessary
> variable 'sd'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-wf2q.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 15b97687493a..da189c732376 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1085,12 +1085,12 @@ static void __bfq_requeue_entity(struct bfq_entity *entity)
>  }
>  
>  static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
> -					  struct bfq_sched_data *sd,
>  					  bool non_blocking_wait_rq)
>  {
>  	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
>  
> -	if (sd->in_service_entity == entity || entity->tree == &st->active)
> +	if (entity->sched_data->in_service_entity == entity ||
> +	    entity->tree == &st->active)
>  		 /*
>  		  * in service or already queued on the active tree,
>  		  * requeue or reposition
> @@ -1122,14 +1122,10 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
>  					bool non_blocking_wait_rq,
>  					bool requeue, bool expiration)
>  {
> -	struct bfq_sched_data *sd;
> -
>  	for_each_entity(entity) {
> -		sd = entity->sched_data;
> -		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
> -
> -		if (!bfq_update_next_in_service(sd, entity, expiration) &&
> -		    !requeue)
> +		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
> +		if (!bfq_update_next_in_service(entity->sched_data, entity,
> +						expiration) && !requeue)
>  			break;
>  	}
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
