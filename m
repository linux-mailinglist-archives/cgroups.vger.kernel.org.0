Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EBF4FF423
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiDMJxL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiDMJxH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 05:53:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0359446152;
        Wed, 13 Apr 2022 02:50:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B5A251F856;
        Wed, 13 Apr 2022 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649843444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9sUMbXWYwe92wKsFm671vYxFMhofHKxVsokA7MWvxI=;
        b=bTcP6RKTnl17n4CZJtBbVYJAuXrT0mU2E9IlMAvJn6Iwmg+KGRUJSfjEj0xxvMQ8mUZPH7
        Ig9KDYUnNqAyvcyQuzWLIajOqTTVW/RfvkaTCUXXIwewln8obB8X4qnMmxPnRoI3r7Btsz
        OrqeG4WbhdwWL5sUiAXsufft/t80ZOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649843444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9sUMbXWYwe92wKsFm671vYxFMhofHKxVsokA7MWvxI=;
        b=EfUHcSGf4VbiiRKfNtY4mZiMrQjXfNc+7EzF8GykI5/0/tNxB/uS8fg0qWxJ4Vx/nYffpP
        01J2diM08p/fNHDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9DAFBA3B83;
        Wed, 13 Apr 2022 09:50:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2727BA0615; Wed, 13 Apr 2022 11:50:44 +0200 (CEST)
Date:   Wed, 13 Apr 2022 11:50:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next 02/11] block, bfq: apply news apis where root group
 is not expected
Message-ID: <20220413095044.uwxeqli2ytcdanem@quack3.lan>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305091205.4188398-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 05-03-22 17:11:56, Yu Kuai wrote:
> 'entity->sched_data' is set to parent group's sched_data, thus it's NULL
> for root group. And for_each_entity() is used widely to access
> 'entity->sched_data', thus aplly news apis if root group is not
                             ^^ apply

> expected. Prepare to count root group into 'num_groups_with_pending_reqs'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c |  2 +-
>  block/bfq-iosched.h | 22 ++++++++--------------
>  block/bfq-wf2q.c    | 10 +++++-----
>  3 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 69ddf6b0f01d..3bc7a7686aad 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4393,7 +4393,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
>  	 * service with the same budget.
>  	 */
>  	entity = entity->parent;
> -	for_each_entity(entity)
> +	for_each_entity_not_root(entity)
>  		entity->service = 0;
>  }

So why is it a problem to clear the service for root cgroup here?

> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..c4cb935a615a 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -815,7 +815,7 @@ void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
>  		bfqq->service_from_wr += served;
>  
>  	bfqq->service_from_backlogged += served;
> -	for_each_entity(entity) {
> +	for_each_entity_not_root(entity) {
>  		st = bfq_entity_service_tree(entity);

Hum, right so how come this was not crashing? Because entity->sched_data is
indeed NULL for bfqd->root_group->entity and so bfq_entity_service_tree()
returned some bogus pointer? Similarly for the cases you are changing
below?

								Honza

> 
>  		entity->service += served;
> @@ -1201,7 +1201,7 @@ static void bfq_deactivate_entity(struct bfq_entity *entity,
>  	struct bfq_sched_data *sd;
>  	struct bfq_entity *parent = NULL;
>  
> -	for_each_entity_safe(entity, parent) {
> +	for_each_entity_not_root_safe(entity, parent) {
>  		sd = entity->sched_data;
>  
>  		if (!__bfq_deactivate_entity(entity, ins_into_idle_tree)) {
> @@ -1270,7 +1270,7 @@ static void bfq_deactivate_entity(struct bfq_entity *entity,
>  	 * is not the case.
>  	 */
>  	entity = parent;
> -	for_each_entity(entity) {
> +	for_each_entity_not_root(entity) {
>  		/*
>  		 * Invoke __bfq_requeue_entity on entity, even if
>  		 * already active, to requeue/reposition it in the
> @@ -1570,7 +1570,7 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
>  	 * We can finally update all next-to-serve entities along the
>  	 * path from the leaf entity just set in service to the root.
>  	 */
> -	for_each_entity(entity) {
> +	for_each_entity_not_root(entity) {
>  		struct bfq_sched_data *sd = entity->sched_data;
>  
>  		if (!bfq_update_next_in_service(sd, NULL, false))
> @@ -1597,7 +1597,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
>  	 * execute the final step: reset in_service_entity along the
>  	 * path from entity to the root.
>  	 */
> -	for_each_entity(entity)
> +	for_each_entity_not_root(entity)
>  		entity->sched_data->in_service_entity = NULL;
>  
>  	/*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
