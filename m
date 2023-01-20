Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB0675261
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 11:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjATK1P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjATK1M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 05:27:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF4B2791;
        Fri, 20 Jan 2023 02:26:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5945F823;
        Fri, 20 Jan 2023 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674210404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXGvC8AU6rzR9p24buQKd5veIiuz4P0cpby4EqTNZew=;
        b=bJTDad9i9zjI560FBrkRWxZinWdeEkKSEMxHq4F23lOloc0VVqX6ptSKXkRAAvALv8pR+T
        Y9C1uP4yW1HkpELJcLt6htYz+sE5kUumU+93asZaF/mxMWvUSPLFU5tM+QLgfPX1gCIof2
        NYAIyk7lISyJzBBFNE9pqmZSQbvKbUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674210404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXGvC8AU6rzR9p24buQKd5veIiuz4P0cpby4EqTNZew=;
        b=zpWEj4yyQJqqap3ZPq1Zkdh00GqCqQtsRnkU26jrgmtvvVT6RMx1CfllQmSWowfLlmZ8Yc
        47+kbd7qIDDR2ZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A68561390C;
        Fri, 20 Jan 2023 10:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I6Y+JmNsymNcUwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 10:26:43 +0000
Date:   Fri, 20 Jan 2023 11:26:41 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 12/15] blk-cgroup: pass a gendisk to
 blkcg_{de,}activate_policy
Message-ID: <Y8psYfB+fs3+X8EN@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-13-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:54AM +0100, Christoph Hellwig wrote:
> Prepare for storing the blkcg information in the gendisk instead of
> the request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bfq-cgroup.c    |  2 +-
>  block/bfq-iosched.c   |  2 +-
>  block/blk-cgroup.c    | 19 ++++++++++---------
>  block/blk-cgroup.h    |  9 ++++-----
>  block/blk-iocost.c    |  4 ++--
>  block/blk-iolatency.c |  4 ++--
>  block/blk-ioprio.c    |  4 ++--
>  block/blk-throttle.c  |  4 ++--
>  8 files changed, 24 insertions(+), 24 deletions(-)

(One nitpick below.)
Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 72a033776722c9..b1b8eca99d988f 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -1293,7 +1293,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
>  {
>  	int ret;
>  
> -	ret = blkcg_activate_policy(bfqd->queue, &blkcg_policy_bfq);
> +	ret = blkcg_activate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
>  	if (ret)
>  		return NULL;
>  
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 68062243f2c142..eda3a838f3c3fd 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7155,7 +7155,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>  	bfqg_and_blkg_put(bfqd->root_group);
>  
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
> +	blkcg_deactivate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
>  #else
>  	spin_lock_irq(&bfqd->lock);
>  	bfq_put_async_queues(bfqd, bfqd->root_group);
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 603e911d1350db..353421afe1d70d 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1363,13 +1363,13 @@ EXPORT_SYMBOL_GPL(io_cgrp_subsys);
>  
>  /**
>   * blkcg_activate_policy - activate a blkcg policy on a request_queue
                                                           ^^^^^^^^^^^^^
							   gendisk
> - * @q: request_queue of interest
> + * @disk: gendisk of interest
>   * @pol: blkcg policy to activate
>   *
> - * Activate @pol on @q.  Requires %GFP_KERNEL context.  @q goes through
> + * Activate @pol on @disk.  Requires %GFP_KERNEL context.  @disk goes through
>   * bypass mode to populate its blkgs with policy_data for @pol.
>   *
> - * Activation happens with @q bypassed, so nobody would be accessing blkgs
> + * Activation happens with @disk bypassed, so nobody would be accessing blkgs
>   * from IO path.  Update of each blkg is protected by both queue and blkcg
>   * locks so that holding either lock and testing blkcg_policy_enabled() is
>   * always enough for dereferencing policy data.
> @@ -1377,9 +1377,9 @@ EXPORT_SYMBOL_GPL(io_cgrp_subsys);
>   * The caller is responsible for synchronizing [de]activations and policy
>   * [un]registerations.  Returns 0 on success, -errno on failure.
>   */
> -int blkcg_activate_policy(struct request_queue *q,
> -			  const struct blkcg_policy *pol)
> +int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct blkg_policy_data *pd_prealloc = NULL;
>  	struct blkcg_gq *blkg, *pinned_blkg = NULL;
>  	int ret;
> @@ -1473,16 +1473,17 @@ int blkcg_activate_policy(struct request_queue *q,
>  EXPORT_SYMBOL_GPL(blkcg_activate_policy);
>  
>  /**
> - * blkcg_deactivate_policy - deactivate a blkcg policy on a request_queue
> - * @q: request_queue of interest
> + * blkcg_deactivate_policy - deactivate a blkcg policy on a gendisk
> + * @disk: gendisk of interest
>   * @pol: blkcg policy to deactivate
>   *
> - * Deactivate @pol on @q.  Follows the same synchronization rules as
> + * Deactivate @pol on @disk.  Follows the same synchronization rules as
>   * blkcg_activate_policy().
>   */
> -void blkcg_deactivate_policy(struct request_queue *q,
> +void blkcg_deactivate_policy(struct gendisk *disk,
>  			     const struct blkcg_policy *pol)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct blkcg_gq *blkg;
>  
>  	if (!blkcg_policy_enabled(q, pol))
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 85b267234823ab..e9e0c00d13d64d 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -190,9 +190,8 @@ void blkcg_exit_disk(struct gendisk *disk);
>  /* Blkio controller policy registration */
>  int blkcg_policy_register(struct blkcg_policy *pol);
>  void blkcg_policy_unregister(struct blkcg_policy *pol);
> -int blkcg_activate_policy(struct request_queue *q,
> -			  const struct blkcg_policy *pol);
> -void blkcg_deactivate_policy(struct request_queue *q,
> +int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol);
> +void blkcg_deactivate_policy(struct gendisk *disk,
>  			     const struct blkcg_policy *pol);
>  
>  const char *blkg_dev_name(struct blkcg_gq *blkg);
> @@ -491,9 +490,9 @@ static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
>  static inline void blkcg_exit_disk(struct gendisk *disk) { }
>  static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
>  static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
> -static inline int blkcg_activate_policy(struct request_queue *q,
> +static inline int blkcg_activate_policy(struct gendisk *disk,
>  					const struct blkcg_policy *pol) { return 0; }
> -static inline void blkcg_deactivate_policy(struct request_queue *q,
> +static inline void blkcg_deactivate_policy(struct gendisk *disk,
>  					   const struct blkcg_policy *pol) { }
>  
>  static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 54e42b22b3599f..6557bbd409b57e 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2814,7 +2814,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
>  {
>  	struct ioc *ioc = rqos_to_ioc(rqos);
>  
> -	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iocost);
> +	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iocost);
>  
>  	spin_lock_irq(&ioc->lock);
>  	ioc->running = IOC_STOP;
> @@ -2886,7 +2886,7 @@ static int blk_iocost_init(struct gendisk *disk)
>  	if (ret)
>  		goto err_free_ioc;
>  
> -	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
> +	ret = blkcg_activate_policy(disk, &blkcg_policy_iocost);
>  	if (ret)
>  		goto err_del_qos;
>  	return 0;
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 8e1e43bbde6f0b..39853fc5c2b02f 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -646,7 +646,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
>  
>  	timer_shutdown_sync(&blkiolat->timer);
>  	flush_work(&blkiolat->enable_work);
> -	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iolatency);
> +	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
>  	kfree(blkiolat);
>  }
>  
> @@ -768,7 +768,7 @@ int blk_iolatency_init(struct gendisk *disk)
>  			 &blkcg_iolatency_ops);
>  	if (ret)
>  		goto err_free;
> -	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
> +	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
>  	if (ret)
>  		goto err_qos_del;
>  
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 8bb6b8eba4cee8..8194826cc824bc 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -204,12 +204,12 @@ void blkcg_set_ioprio(struct bio *bio)
>  
>  void blk_ioprio_exit(struct gendisk *disk)
>  {
> -	blkcg_deactivate_policy(disk->queue, &ioprio_policy);
> +	blkcg_deactivate_policy(disk, &ioprio_policy);
>  }
>  
>  int blk_ioprio_init(struct gendisk *disk)
>  {
> -	return blkcg_activate_policy(disk->queue, &ioprio_policy);
> +	return blkcg_activate_policy(disk, &ioprio_policy);
>  }
>  
>  static int __init ioprio_init(void)
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index f802d8f9099430..efc0a9092c6942 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2395,7 +2395,7 @@ int blk_throtl_init(struct gendisk *disk)
>  	td->low_downgrade_time = jiffies;
>  
>  	/* activate policy */
> -	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
> +	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
>  	if (ret) {
>  		free_percpu(td->latency_buckets[READ]);
>  		free_percpu(td->latency_buckets[WRITE]);
> @@ -2411,7 +2411,7 @@ void blk_throtl_exit(struct gendisk *disk)
>  	BUG_ON(!q->td);
>  	del_timer_sync(&q->td->service_queue.pending_timer);
>  	throtl_shutdown_wq(q);
> -	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
> +	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
>  	free_percpu(q->td->latency_buckets[READ]);
>  	free_percpu(q->td->latency_buckets[WRITE]);
>  	kfree(q->td);
> -- 
> 2.39.0
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
