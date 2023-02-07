Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BA68D397
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 11:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjBGKH0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 05:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjBGKHV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 05:07:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD69DD51C;
        Tue,  7 Feb 2023 02:07:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5793B37A0F;
        Tue,  7 Feb 2023 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675764435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Te9Juz5JzX/nOCXQ+EoNePBpi22PvKhzdWL3Av9Y1p0=;
        b=UCRF4IFGTr7DLgr/rL6w6A65hmf/9vLYCyaPOVdGLB1qZ7dYPzsg6ODe9uiH+MGNICKgZ2
        T5c2ZvBtxaUZ2t+ql6ebKBafNqzGUsAYHMxuTaQpieph11q/xM8RDbwf7QZt0OgHEbCv/w
        D27iFFr8Hxj8m/Egwiauxzi0zUWULo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675764435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Te9Juz5JzX/nOCXQ+EoNePBpi22PvKhzdWL3Av9Y1p0=;
        b=bsD7xkqHQ3TvgFdVTSmp1oviZ73d9hcV903gE6fA2Ri1IInhW712mNezHriVVaCi48zY4S
        En+xOuxi/CUUzsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45BE413467;
        Tue,  7 Feb 2023 10:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uG75ENMi4mOHGgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 10:07:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA320A06D5; Tue,  7 Feb 2023 11:07:14 +0100 (CET)
Date:   Tue, 7 Feb 2023 11:07:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, josef@toxicpanda.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v3] block, bfq: cleanup 'bfqg->online'
Message-ID: <20230207100714.fv4pfvkt56gb2iqm@quack3>
References: <20230202134913.2364549-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202134913.2364549-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 02-02-23 21:49:13, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After commit dfd6200a0954 ("blk-cgroup: support to track if policy is
> online"), there is no need to do this again in bfq.
> 
> However, 'pd->online' is not protected by 'bfqd->lock', in order to make
> sure bfq won't see that 'pd->online' is still set after bfq_pd_offline(),
> clear it before bfq_pd_offline() is called. This is fine because other
> polices doesn't use 'pd->online' and bfq_pd_offline() will move active
> bfqq to root cgroup anyway.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

The patch looks good to me now. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v3:
>  - in commit message: protected -> not protected, bfq_pd_offline_() ->
>  bfq_pd_offline().
> Changes in v2:
>  - clear 'pd->online' before calling bfq_pd_offline()
> 
>  block/bfq-cgroup.c  | 4 +---
>  block/bfq-iosched.h | 2 --
>  block/blk-cgroup.c  | 2 +-
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index b42956ab5550..a35136dae713 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -551,7 +551,6 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
>  	bfqg->bfqd = bfqd;
>  	bfqg->active_entities = 0;
>  	bfqg->num_queues_with_pending_reqs = 0;
> -	bfqg->online = true;
>  	bfqg->rq_pos_tree = RB_ROOT;
>  }
>  
> @@ -614,7 +613,7 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
>  			continue;
>  		}
>  		bfqg = blkg_to_bfqg(blkg);
> -		if (bfqg->online) {
> +		if (bfqg->pd.online) {
>  			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
>  			return bfqg;
>  		}
> @@ -985,7 +984,6 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
>  
>  put_async_queues:
>  	bfq_put_async_queues(bfqd, bfqg);
> -	bfqg->online = false;
>  
>  	spin_unlock_irqrestore(&bfqd->lock, flags);
>  	/*
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 75cc6a324267..69aaee52285a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -1009,8 +1009,6 @@ struct bfq_group {
>  
>  	/* reference counter (see comments in bfq_bic_update_cgroup) */
>  	refcount_t ref;
> -	/* Is bfq_group still online? */
> -	bool online;
>  
>  	struct bfq_entity entity;
>  	struct bfq_sched_data sched_data;
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index cb110fc51940..a228dfe65253 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -491,9 +491,9 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>  		struct blkcg_policy *pol = blkcg_policy[i];
>  
>  		if (blkg->pd[i] && blkg->pd[i]->online) {
> +			blkg->pd[i]->online = false;
>  			if (pol->pd_offline_fn)
>  				pol->pd_offline_fn(blkg->pd[i]);
> -			blkg->pd[i]->online = false;
>  		}
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
