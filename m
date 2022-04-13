Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C94FF56C
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiDMLHz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiDMLHs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 07:07:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A98D5883F;
        Wed, 13 Apr 2022 04:05:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1A517210FD;
        Wed, 13 Apr 2022 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649847926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuDXLs71XOBzrT2KJvxwCfIHfXPj0UmnTLYWZfHEDe0=;
        b=JC5qRv5Cuo0x3WTN1cxGKr1vYp7BboeDeJum9hm2H607castvJ6ruwuxfyk+nV+PDxTE49
        aP9BLfuxL6HzLSnWxOG0cjTxORuNZLCDCS5o5fy9Cii3HPQ+ecEkwf0M58ohuDUMDNAgBk
        Vv9DjYTz5J0+estjzScgqLVkX792HgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649847926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuDXLs71XOBzrT2KJvxwCfIHfXPj0UmnTLYWZfHEDe0=;
        b=vlys3+ra2hG6zozEb6xdmehkg362hPm1YLYRS7wG+WphtjzfIS+Qs/0fe/rcDQ7UEryH2j
        8myhqy33qrVNHDDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 00F6DA3B82;
        Wed, 13 Apr 2022 11:05:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A41F2A0615; Wed, 13 Apr 2022 13:05:25 +0200 (CEST)
Date:   Wed, 13 Apr 2022 13:05:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next 05/11] block, bfq: count root group into
 'num_groups_with_pending_reqs'
Message-ID: <20220413110525.u7wi2ttk5lag6r4b@quack3.lan>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305091205.4188398-6-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 05-03-22 17:11:59, Yu Kuai wrote:
> Root group is not counted into 'num_groups_with_pending_reqs' because
> 'entity->parent' is set to NULL for child entities, thus
> for_each_entity() can't access root group.
> 
> This patch set root_group's entity to 'entity->parent' for child
> entities, this way root_group will be counted because for_each_entity()
> can access root_group in bfq_activate_requeue_entity(),
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-cgroup.c  | 6 +++---
>  block/bfq-iosched.h | 3 ++-
>  block/bfq-wf2q.c    | 5 +++++
>  3 files changed, 10 insertions(+), 4 deletions(-)

I think you can remove bfqg->my_entity after this patch, can't you? Because
effectively it's only purpose was so that you don't have to special-case
children of root_group...

								Honza

> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 420eda2589c0..6cd65b5e790d 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -436,7 +436,7 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
>  		 */
>  		bfqg_and_blkg_get(bfqg);
>  	}
> -	entity->parent = bfqg->my_entity; /* NULL for root group */
> +	entity->parent = &bfqg->entity;
>  	entity->sched_data = &bfqg->sched_data;
>  }
>  
> @@ -581,7 +581,7 @@ static void bfq_group_set_parent(struct bfq_group *bfqg,
>  	struct bfq_entity *entity;
>  
>  	entity = &bfqg->entity;
> -	entity->parent = parent->my_entity;
> +	entity->parent = &parent->entity;
>  	entity->sched_data = &parent->sched_data;
>  }
>  
> @@ -688,7 +688,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  	else if (bfqd->last_bfqq_created == bfqq)
>  		bfqd->last_bfqq_created = NULL;
>  
> -	entity->parent = bfqg->my_entity;
> +	entity->parent = &bfqg->entity;
>  	entity->sched_data = &bfqg->sched_data;
>  	/* pin down bfqg and its associated blkg  */
>  	bfqg_and_blkg_get(bfqg);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index ddd8eff5c272..4530ab8b42ac 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -1024,13 +1024,14 @@ extern struct blkcg_policy blkcg_policy_bfq;
>  /* - interface of the internal hierarchical B-WF2Q+ scheduler - */
>  
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -/* stop at one of the child entities of the root group */
> +/* stop at root group */
>  #define for_each_entity(entity)	\
>  	for (; entity ; entity = entity->parent)
>  
>  #define is_root_entity(entity) \
>  	(entity->sched_data == NULL)
>  
> +/* stop at one of the child entities of the root group */
>  #define for_each_entity_not_root(entity) \
>  	for (; entity && !is_root_entity(entity); entity = entity->parent)
>  
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 17f1d2c5b8dc..138a2950b841 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1125,6 +1125,11 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
>  {
>  	for_each_entity(entity) {
>  		bfq_update_groups_with_pending_reqs(entity);
> +
> +		/* root group is not in service tree */
> +		if (is_root_entity(entity))
> +			break;
> +
>  		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
>  
>  		if (!bfq_update_next_in_service(entity->sched_data, entity,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
