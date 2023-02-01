Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAC686668
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 14:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBANKw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 08:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBANKw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 08:10:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A66385D;
        Wed,  1 Feb 2023 05:10:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBEE933D47;
        Wed,  1 Feb 2023 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675257038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzbdF6heQ5asZimrlSzjKZo88jnGGEYXcxUXe4U6tuA=;
        b=OLfOB/26/HWZepeWF+ilZLQxTv+AD9XtkXb+2fdv+zfJVfH233aj9w9lU9sEe9tw3cQtOP
        +a/fjIr6RDPgonnP8VGhXqYqf3V9vp9kx7/7/HeGuZ+NXuRt8xYr8pP8xwShMgQRB4bXpy
        aDakemW5PIfXdqMdccM7CWU5YdFSvro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675257038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzbdF6heQ5asZimrlSzjKZo88jnGGEYXcxUXe4U6tuA=;
        b=5EHP9kSrF6DRKqWvNURrkd/cSjoqxbjdL+iDIpDwkQ9M7YrJms3/yGmLtab5gFZsDdaAfm
        pmt/bPP8nuv4yDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACAC913A10;
        Wed,  1 Feb 2023 13:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /GAbKs5k2mM9TwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Feb 2023 13:10:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3C04A06D4; Wed,  1 Feb 2023 14:10:37 +0100 (CET)
Date:   Wed, 1 Feb 2023 14:10:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] block, bfq: cleanup 'bfqg->online'
Message-ID: <20230201131037.6frw2kpc54k4sx7a@quack3>
References: <20230201120609.4151432-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201120609.4151432-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 01-02-23 20:06:09, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After commit dfd6200a0954 ("blk-cgroup: support to track if policy is
> online"), there is no need to do this again in bfq.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

So I agree this is nice to do but it isn't so simple. BFQ relies on the
fact that 'online' is cleared under bfqd->lock so we cannot associate bio
in bfq_bio_bfqg() with a bfqg that has already its bfq_pd_offline()
function run.

Maybe if you set 'online' to false before calling ->pd_offline() things
would work fine for BFQ.

								Honza
> ---
>  block/bfq-cgroup.c  | 4 +---
>  block/bfq-iosched.h | 2 --
>  2 files changed, 1 insertion(+), 5 deletions(-)
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
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
