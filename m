Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE852D10E
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiESLBv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiESLBg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:01:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0157C14D1C;
        Thu, 19 May 2022 04:01:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B43AF219AD;
        Thu, 19 May 2022 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652958092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2LJTHb7bIL86JRNxFoPv0Vzh38Dtv/r3lFZcMZIkjA=;
        b=mi5Ln/NvtJgbrqgbuHpDqWsAGcT/ERt1PK5gyJc4Ao31t1MabjZ6YdvkSXA3X8aK4uaq6b
        Mn7IJ9dnrJTykEm5foEY+fXFin+P/SGrPqSo3VnuK0A3zzUcpSfFbaWswU1SwP0a6ehy5f
        XFczdxyoJYcQq18kSGohsLvsR37deUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652958092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2LJTHb7bIL86JRNxFoPv0Vzh38Dtv/r3lFZcMZIkjA=;
        b=XCHwI9V7L9qFZa1vtjV1bfZs/BBA1lOkhFJV64b5O9a/FiJlpfsg1XeyjbCaORk9nBra+N
        zYHuKYeOf2fMktCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A32822C141;
        Thu, 19 May 2022 11:01:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D5F1A062F; Thu, 19 May 2022 13:01:32 +0200 (CEST)
Date:   Thu, 19 May 2022 13:01:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 4/8] block, bfq: don't declare 'bfqd' as type 'void
 *' in bfq_group
Message-ID: <20220519110132.g2hpugtzbfhxpfiv@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-5-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:18, Yu Kuai wrote:
> Prevent unnecessary format conversion for bfqg->bfqd in multiple
> places.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Yeah, this was annoying me as well :) Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  | 2 +-
>  block/bfq-iosched.h | 2 +-
>  block/bfq-wf2q.c    | 8 +++-----
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 4d516879d9fa..b4e39ab4ad17 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -224,7 +224,7 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
>  {
>  	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
>  	bfqg_stats_end_empty_time(&bfqg->stats);
> -	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
> +	if (!(bfqq == bfqg->bfqd->in_service_queue))
>  		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
>  }
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index bc54b9824b1e..d57e4848f57f 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -894,7 +894,7 @@ struct bfq_group {
>  	struct bfq_entity entity;
>  	struct bfq_sched_data sched_data;
>  
> -	void *bfqd;
> +	struct bfq_data *bfqd;
>  
>  	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
>  	struct bfq_queue *async_idle_bfqq;
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index c58568a4b009..15b97687493a 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -234,9 +234,8 @@ static void bfq_inc_active_entities(struct bfq_entity *entity)
>  {
>  	struct bfq_sched_data *sd = entity->sched_data;
>  	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
> -	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
>  
> -	if (bfqg != bfqd->root_group)
> +	if (bfqg != bfqg->bfqd->root_group)
>  		bfqg->active_entities++;
>  }
>  
> @@ -244,9 +243,8 @@ static void bfq_dec_active_entities(struct bfq_entity *entity)
>  {
>  	struct bfq_sched_data *sd = entity->sched_data;
>  	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
> -	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
>  
> -	if (bfqg != bfqd->root_group)
> +	if (bfqg != bfqg->bfqd->root_group)
>  		bfqg->active_entities--;
>  }
>  
> @@ -741,7 +739,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
>  		else {
>  			sd = entity->my_sched_data;
>  			bfqg = container_of(sd, struct bfq_group, sched_data);
> -			bfqd = (struct bfq_data *)bfqg->bfqd;
> +			bfqd = bfqg->bfqd;
>  		}
>  #endif
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
