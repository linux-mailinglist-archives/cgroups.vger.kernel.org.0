Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6261539F9A
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349467AbiFAIhM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiFAIhL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 04:37:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE323150;
        Wed,  1 Jun 2022 01:37:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DC28E21AF8;
        Wed,  1 Jun 2022 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654072626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsHgnzZUQPIXtk0+5x5Y0MiDzi5+zpU3dD5UO6P7azE=;
        b=tQE4kgyC8B3pZXt11XfuyK82X/5feUuBNHwL+8dg5HMNvmpXCGBpSPvteJU6hH/3GBBXJR
        UNCEg0DLkssqp6sxTNga2BJgUWjI1MOaVbMu+0KSxy0455Ghf1wXrviZi5wbx4D9MnmE3o
        gjV6lZtMZgdUtYNr70lnGWesSMScA4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654072626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsHgnzZUQPIXtk0+5x5Y0MiDzi5+zpU3dD5UO6P7azE=;
        b=QxveskwwdgtZYejPcdFPOgLJ5eL4XOPjQGiLcnY0lM3/m2Pw/YT9gRZgQ+TBqrqT5hGJGw
        bP/ijgYAgB/w43AA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C34F82C141;
        Wed,  1 Jun 2022 08:37:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8909FA0633; Wed,  1 Jun 2022 10:37:06 +0200 (CEST)
Date:   Wed, 1 Jun 2022 10:37:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     paolo.valente@linaro.org, jack@suse.cz, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v8 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
Message-ID: <20220601083706.mnpb2ue6o25fqrrl@quack3.lan>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
 <20220531140858.3324294-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531140858.3324294-4-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 31-05-22 22:08:57, Yu Kuai wrote:
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
>  2) Count if bfqg have pending requests.
>  3) Don't count if bfqg complete all the requests.
> 
> With this change, the occasion that only one group is activated can be
> detected, and next patch will support concurrent sync io in the
> occasion.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 42 ------------------------------------------
>  block/bfq-iosched.h | 18 +++++++++---------
>  block/bfq-wf2q.c    | 19 ++++---------------
>  3 files changed, 13 insertions(+), 66 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0ec21018daba..03b04892440c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
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
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index a5f7c0c1a3b3..ec8195900b3a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -496,27 +496,27 @@ struct bfq_data {
>  	struct rb_root_cached queue_weights_tree;
>  
>  	/*
> -	 * Number of groups with at least one descendant process that
> +	 * Number of groups with at least one process that
>  	 * has at least one request waiting for completion. Note that
>  	 * this accounts for also requests already dispatched, but not
>  	 * yet completed. Therefore this number of groups may differ
>  	 * (be larger) than the number of active groups, as a group is
>  	 * considered active only if its corresponding entity has
> -	 * descendant queues with at least one request queued. This
> +	 * queues with at least one request queued. This
>  	 * number is used to decide whether a scenario is symmetric.
>  	 * For a detailed explanation see comments on the computation
>  	 * of the variable asymmetric_scenario in the function
>  	 * bfq_better_to_idle().
>  	 *
>  	 * However, it is hard to compute this number exactly, for
> -	 * groups with multiple descendant processes. Consider a group
> -	 * that is inactive, i.e., that has no descendant process with
> +	 * groups with multiple processes. Consider a group
> +	 * that is inactive, i.e., that has no process with
>  	 * pending I/O inside BFQ queues. Then suppose that
>  	 * num_groups_with_pending_reqs is still accounting for this
> -	 * group, because the group has descendant processes with some
> +	 * group, because the group has processes with some
>  	 * I/O request still in flight. num_groups_with_pending_reqs
>  	 * should be decremented when the in-flight request of the
> -	 * last descendant process is finally completed (assuming that
> +	 * last process is finally completed (assuming that
>  	 * nothing else has changed for the group in the meantime, in
>  	 * terms of composition of the group and active/inactive state of child
>  	 * groups and processes). To accomplish this, an additional
> @@ -525,7 +525,7 @@ struct bfq_data {
>  	 * we resort to the following tradeoff between simplicity and
>  	 * accuracy: for an inactive group that is still counted in
>  	 * num_groups_with_pending_reqs, we decrement
> -	 * num_groups_with_pending_reqs when the first descendant
> +	 * num_groups_with_pending_reqs when the first
>  	 * process of the group remains with no request waiting for
>  	 * completion.
>  	 *
> @@ -533,12 +533,12 @@ struct bfq_data {
>  	 * carefulness: to avoid multiple decrements, we flag a group,
>  	 * more precisely an entity representing a group, as still
>  	 * counted in num_groups_with_pending_reqs when it becomes
> -	 * inactive. Then, when the first descendant queue of the
> +	 * inactive. Then, when the first queue of the
>  	 * entity remains with no request waiting for completion,
>  	 * num_groups_with_pending_reqs is decremented, and this flag
>  	 * is reset. After this flag is reset for the entity,
>  	 * num_groups_with_pending_reqs won't be decremented any
> -	 * longer in case a new descendant queue of the entity remains
> +	 * longer in case a new queue of the entity remains
>  	 * with no request waiting for completion.
>  	 */
>  	unsigned int num_groups_with_pending_reqs;
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index b533e17e9f0c..427af70f6760 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -984,19 +984,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
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
> @@ -1654,7 +1641,8 @@ static void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>  	if (!entity->in_groups_with_pending_reqs) {
>  		entity->in_groups_with_pending_reqs = true;
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
> +		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
> +			bfqq->bfqd->num_groups_with_pending_reqs++;
>  #endif
>  	}
>  }
> @@ -1666,7 +1654,8 @@ void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>  	if (entity->in_groups_with_pending_reqs) {
>  		entity->in_groups_with_pending_reqs = false;
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
> +		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
> +			bfqq->bfqd->num_groups_with_pending_reqs--;
>  #endif
>  	}
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
