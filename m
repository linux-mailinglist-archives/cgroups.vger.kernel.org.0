Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF7513414
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiD1Msz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbiD1Msy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 08:48:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A33286E7;
        Thu, 28 Apr 2022 05:45:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50799210F3;
        Thu, 28 Apr 2022 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651149938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1tER3DtXbQSLD/j7/Uc6zPjmyydRTQWyAvK011v6WQ=;
        b=kyeLx/umgkcWp7Jye4+E/wli4Ow/64CCjDRg54IG697QSqk7Rw8tksQOhwQhuqMVZ0ZEBC
        VSjoH4OYH80t/nZOGas/0XnPYKfxbWIlvUVfN8sUs8oEm9EB51wT2qX4byVfwrDcr5GF/C
        XYXule2uzIGfdvJ7C1+bH4gQTI3B3/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651149938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1tER3DtXbQSLD/j7/Uc6zPjmyydRTQWyAvK011v6WQ=;
        b=8uOH1k5ym649fa0VViH9DHTNG9RA9bhvgedB1TQqxU/6MEHo4XHi+B6v9gnBQ0bQWP9czQ
        YCwB2rtjm8fOKfDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3B2FF2C141;
        Thu, 28 Apr 2022 12:45:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DBDE8A061A; Thu, 28 Apr 2022 14:45:37 +0200 (CEST)
Date:   Thu, 28 Apr 2022 14:45:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v5 1/3] block, bfq: record how many queues are busy
 in bfq_group
Message-ID: <20220428124537.c5ve4vs2jk5uzthy@quack3.lan>
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <20220428120837.3737765-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428120837.3737765-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 28-04-22 20:08:35, Yu Kuai wrote:
> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
> 
> Add a counter 'busy_queues' in bfq_group, and update it in
> bfq_add/del_bfqq_busy().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  |  1 +
>  block/bfq-iosched.h |  2 ++
>  block/bfq-wf2q.c    | 20 ++++++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 09574af83566..4d516879d9fa 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
>  				   */
>  	bfqg->bfqd = bfqd;
>  	bfqg->active_entities = 0;
> +	bfqg->busy_queues = 0;
>  	bfqg->online = true;
>  	bfqg->rq_pos_tree = RB_ROOT;
>  }
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 978ef5d6fe6a..3847f4ab77ac 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -906,6 +906,7 @@ struct bfq_group_data {
>   *                   are groups with more than one active @bfq_entity
>   *                   (see the comments to the function
>   *                   bfq_bfqq_may_idle()).
> + * @busy_queues: number of busy bfqqs.
>   * @rq_pos_tree: rbtree sorted by next_request position, used when
>   *               determining if two or more queues have interleaving
>   *               requests (see bfq_find_close_cooperator()).
> @@ -942,6 +943,7 @@ struct bfq_group {
>  	struct bfq_entity *my_entity;
>  
>  	int active_entities;
> +	int busy_queues;
>  
>  	struct rb_root rq_pos_tree;
>  
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..d9ff33e0be38 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -218,6 +218,16 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  	return false;
>  }
>  
> +static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues++;
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues--;
> +}
> +
>  #else /* CONFIG_BFQ_GROUP_IOSCHED */
>  
>  static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
> @@ -230,6 +240,14 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  	return true;
>  }
>  
> +static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
>  #endif /* CONFIG_BFQ_GROUP_IOSCHED */
>  
>  /*
> @@ -1660,6 +1678,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  	bfq_clear_bfqq_busy(bfqq);
>  
>  	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
> +	bfq_inc_busy_queues(bfqq);
>  
>  	if (bfqq->wr_coeff > 1)
>  		bfqd->wr_busy_queues--;
> @@ -1683,6 +1702,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  
>  	bfq_mark_bfqq_busy(bfqq);
>  	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
> +	bfq_dec_busy_queues(bfqq);
>  
>  	if (!bfqq->dispatched)
>  		if (bfqq->wr_coeff == 1)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
