Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA66511A8A
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiD0MwX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiD0MwW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 08:52:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E512BFB49;
        Wed, 27 Apr 2022 05:49:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 221151F74D;
        Wed, 27 Apr 2022 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651063749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4co1EChZ3VKRbVcj8WYFyYIeCQ5D6yTT0cJjXeHROA=;
        b=LJccPdXF658BDssnRisESiaM9UVqcSE7789tZGgvL05GRdQE1jwFKXikLw5Fl0JzFtZJUl
        EaAvtwatVOlLtjSWwjBQo80zrqxjgHNzIB4av8caJK/gVs20jGlCK/X/XaTaF+wqKnhbZw
        NSpb9vEXTYF4BHcs+/maiT++d3tn4Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651063749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4co1EChZ3VKRbVcj8WYFyYIeCQ5D6yTT0cJjXeHROA=;
        b=YQcCZSSR7CGNaPYciECmKPxHsVfMgVVmHgl6evwWOWWsYEHDC8z5BiGM3sYsyDH6LP6pyz
        0T+9mIFuhruXAdCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 04AF62C196;
        Wed, 27 Apr 2022 12:49:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AFE37A0620; Wed, 27 Apr 2022 14:49:08 +0200 (CEST)
Date:   Wed, 27 Apr 2022 14:49:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
Message-ID: <20220427124908.o3cl72h2uflmufso@quack3.lan>
References: <20220427124722.48465-1-yukuai3@huawei.com>
 <20220427124722.48465-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427124722.48465-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 27-04-22 20:47:21, Yu Kuai wrote:
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
> 
> The way that bfqg is counted into 'num_groups_with_pending_reqs':
> 
> Before this patch:
>  1) root group will never be counted.
>  2) Count if bfqg or it's child bfqgs have pending requests.
>  3) Don't count if bfqg and it's child bfqgs complete all the requests.
> 
> After this patch:
>  1) root group is counted.
>  2) Count if bfqg have at least one bfqq that is marked busy.
>  3) Don't count if bfqg doesn't have any busy bfqqs.
> 
> With this change, the occasion that only one group is activated can be
> detected, and next patch will support concurrent sync io in the
> occasion.
> 
> This patch also rename 'num_groups_with_pending_reqs' to
> 'num_groups_with_busy_queues'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Just I think you forgot to remove in_groups_with_pending_reqs,
which is now unused, from bfq_entity.

								Honza

> ---
>  block/bfq-iosched.c | 46 ++-------------------------------------
>  block/bfq-iosched.h | 52 ++++++---------------------------------------
>  block/bfq-wf2q.c    | 23 ++++++--------------
>  3 files changed, 15 insertions(+), 106 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index e47c75f1fa0f..609b4e894684 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -844,7 +844,7 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
>  
>  	return varied_queue_weights || multiple_classes_busy
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	       || bfqd->num_groups_with_pending_reqs > 0
> +	       || bfqd->num_groups_with_busy_queues > 0
>  #endif
>  		;
>  }
> @@ -962,48 +962,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
>  void bfq_weights_tree_remove(struct bfq_data *bfqd,
>  			     struct bfq_queue *bfqq)
>  {
> -	struct bfq_entity *entity = bfqq->entity.parent;
> -
> -	for_each_entity(entity) {
> -		struct bfq_sched_data *sd = entity->my_sched_data;
> -
> -		if (sd->next_in_service || sd->in_service_entity) {
> -			/*
> -			 * entity is still active, because either
> -			 * next_in_service or in_service_entity is not
> -			 * NULL (see the comments on the definition of
> -			 * next_in_service for details on why
> -			 * in_service_entity must be checked too).
> -			 *
> -			 * As a consequence, its parent entities are
> -			 * active as well, and thus this loop must
> -			 * stop here.
> -			 */
> -			break;
> -		}
> -
> -		/*
> -		 * The decrement of num_groups_with_pending_reqs is
> -		 * not performed immediately upon the deactivation of
> -		 * entity, but it is delayed to when it also happens
> -		 * that the first leaf descendant bfqq of entity gets
> -		 * all its pending requests completed. The following
> -		 * instructions perform this delayed decrement, if
> -		 * needed. See the comments on
> -		 * num_groups_with_pending_reqs for details.
> -		 */
> -		if (entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs = false;
> -			bfqd->num_groups_with_pending_reqs--;
> -		}
> -	}
> -
> -	/*
> -	 * Next function is invoked last, because it causes bfqq to be
> -	 * freed if the following holds: bfqq is not in service and
> -	 * has no dispatched request. DO NOT use bfqq after the next
> -	 * function invocation.
> -	 */
>  	__bfq_weights_tree_remove(bfqd, bfqq,
>  				  &bfqd->queue_weights_tree);
>  }
> @@ -7107,7 +7065,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
>  
>  	bfqd->queue_weights_tree = RB_ROOT_CACHED;
> -	bfqd->num_groups_with_pending_reqs = 0;
> +	bfqd->num_groups_with_busy_queues = 0;
>  
>  	INIT_LIST_HEAD(&bfqd->active_list);
>  	INIT_LIST_HEAD(&bfqd->idle_list);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 3847f4ab77ac..5889883ef68a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -495,52 +495,14 @@ struct bfq_data {
>  	struct rb_root_cached queue_weights_tree;
>  
>  	/*
> -	 * Number of groups with at least one descendant process that
> -	 * has at least one request waiting for completion. Note that
> -	 * this accounts for also requests already dispatched, but not
> -	 * yet completed. Therefore this number of groups may differ
> -	 * (be larger) than the number of active groups, as a group is
> -	 * considered active only if its corresponding entity has
> -	 * descendant queues with at least one request queued. This
> -	 * number is used to decide whether a scenario is symmetric.
> -	 * For a detailed explanation see comments on the computation
> -	 * of the variable asymmetric_scenario in the function
> -	 * bfq_better_to_idle().
> -	 *
> -	 * However, it is hard to compute this number exactly, for
> -	 * groups with multiple descendant processes. Consider a group
> -	 * that is inactive, i.e., that has no descendant process with
> -	 * pending I/O inside BFQ queues. Then suppose that
> -	 * num_groups_with_pending_reqs is still accounting for this
> -	 * group, because the group has descendant processes with some
> -	 * I/O request still in flight. num_groups_with_pending_reqs
> -	 * should be decremented when the in-flight request of the
> -	 * last descendant process is finally completed (assuming that
> -	 * nothing else has changed for the group in the meantime, in
> -	 * terms of composition of the group and active/inactive state of child
> -	 * groups and processes). To accomplish this, an additional
> -	 * pending-request counter must be added to entities, and must
> -	 * be updated correctly. To avoid this additional field and operations,
> -	 * we resort to the following tradeoff between simplicity and
> -	 * accuracy: for an inactive group that is still counted in
> -	 * num_groups_with_pending_reqs, we decrement
> -	 * num_groups_with_pending_reqs when the first descendant
> -	 * process of the group remains with no request waiting for
> -	 * completion.
> -	 *
> -	 * Even this simpler decrement strategy requires a little
> -	 * carefulness: to avoid multiple decrements, we flag a group,
> -	 * more precisely an entity representing a group, as still
> -	 * counted in num_groups_with_pending_reqs when it becomes
> -	 * inactive. Then, when the first descendant queue of the
> -	 * entity remains with no request waiting for completion,
> -	 * num_groups_with_pending_reqs is decremented, and this flag
> -	 * is reset. After this flag is reset for the entity,
> -	 * num_groups_with_pending_reqs won't be decremented any
> -	 * longer in case a new descendant queue of the entity remains
> -	 * with no request waiting for completion.
> +	 * Number of groups with at leaset one bfqq that is marked busy,
> +	 * and this number is used to decide whether a scenario is symmetric.
> +	 * Note that bfqq is busy doesn't mean that the bfqq contains requests.
> +	 * If idling is needed for service guarantees, bfqq will stay busy
> +	 * after dispatching the last request, see details in
> +	 * __bfq_bfqq_expire().
>  	 */
> -	unsigned int num_groups_with_pending_reqs;
> +	unsigned int num_groups_with_busy_queues;
>  
>  	/*
>  	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 53826797430f..24c90378f1d4 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -220,10 +220,12 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  
>  static void bfq_update_busy_queues(struct bfq_queue *bfqq, bool is_add)
>  {
> -	if (is_add)
> -		bfqq_group(bfqq)->busy_queues++;
> -	else
> -		bfqq_group(bfqq)->busy_queues--;
> +	if (is_add) {
> +		if (!(bfqq_group(bfqq)->busy_queues++))
> +			bfqq->bfqd->num_groups_with_busy_queues++;
> +	} else if (!(--bfqq_group(bfqq)->busy_queues)) {
> +		bfqq->bfqd->num_groups_with_busy_queues--;
> +	}
>  }
>  
>  #else /* CONFIG_BFQ_GROUP_IOSCHED */
> @@ -996,19 +998,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>  		entity->on_st_or_in_serv = true;
>  	}
>  
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> -		struct bfq_group *bfqg =
> -			container_of(entity, struct bfq_group, entity);
> -		struct bfq_data *bfqd = bfqg->bfqd;
> -
> -		if (!entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs = true;
> -			bfqd->num_groups_with_pending_reqs++;
> -		}
> -	}
> -#endif
> -
>  	bfq_update_fin_time_enqueue(entity, st, backshifted);
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
