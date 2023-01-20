Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26B6751CF
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjATJ5s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 04:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjATJ5r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 04:57:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC18A2968;
        Fri, 20 Jan 2023 01:57:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5B58229FB;
        Fri, 20 Jan 2023 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674208645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+2SLGS+RiuQg7uymh7FDC/11pmomuG5XPrmdOkq2BM=;
        b=PFtwtDP9YTc1oC5pEUGgtTP85WF8fwZGmiWGA0YJ52zWPjMUijNwBCCos58RikbRmolSHH
        GqGIurMHMIgyt+3nPR3x7ssyLkq7KjqAVvuQuLoMHSMYBHbkywtc5ipTrthKbXP4yaVcj0
        6KYa1vZXm86wQ2Lv4wp3t+eXhX6o1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674208645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+2SLGS+RiuQg7uymh7FDC/11pmomuG5XPrmdOkq2BM=;
        b=etzU59yFSkB8hEB4y+ZJjp+eOBb56KtQsDY3aTrPs5FZCVy+b3BBC1XNpB1hx10YEaK5N4
        ckWwWHyghU4QJ9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C61A1390C;
        Fri, 20 Jan 2023 09:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id stUDDIVlymPZQgAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 09:57:25 +0000
Date:   Fri, 20 Jan 2023 10:57:23 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 09/15] blk-rq-qos: make rq_qos_add and rq_qos_del more
 useful
Message-ID: <Y8plg6OAa4lrnyZZ@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-10-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:51AM +0100, Christoph Hellwig wrote:
> Switch to passing a gendisk, and make rq_qos_add initialize all required
> fields and drop the not required q argument from rq_qos_del.  Also move
> the code out of line given how large it is.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-iocost.c    | 13 ++-------
>  block/blk-iolatency.c | 14 +++------
>  block/blk-rq-qos.c    | 67 +++++++++++++++++++++++++++++++++++++++++++
>  block/blk-rq-qos.h    | 62 ++-------------------------------------
>  block/blk-wbt.c       |  5 +---
>  5 files changed, 78 insertions(+), 83 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 6f39ca99e9d76f..9b5c0d23c9ce8b 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2836,9 +2836,7 @@ static struct rq_qos_ops ioc_rqos_ops = {
>  
>  static int blk_iocost_init(struct gendisk *disk)
>  {
> -	struct request_queue *q = disk->queue;
>  	struct ioc *ioc;
> -	struct rq_qos *rqos;
>  	int i, cpu, ret;
>  
>  	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
> @@ -2861,11 +2859,6 @@ static int blk_iocost_init(struct gendisk *disk)
>  		local64_set(&ccs->rq_wait_ns, 0);
>  	}
>  
> -	rqos = &ioc->rqos;
> -	rqos->id = RQ_QOS_COST;
> -	rqos->ops = &ioc_rqos_ops;
> -	rqos->q = q;
> -
>  	spin_lock_init(&ioc->lock);
>  	timer_setup(&ioc->timer, ioc_timer_fn, 0);
>  	INIT_LIST_HEAD(&ioc->active_iocgs);
> @@ -2889,17 +2882,17 @@ static int blk_iocost_init(struct gendisk *disk)
>  	 * called before policy activation completion, can't assume that the
>  	 * target bio has an iocg associated and need to test for NULL iocg.
>  	 */
> -	ret = rq_qos_add(q, rqos);
> +	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
>  	if (ret)
>  		goto err_free_ioc;
>  
> -	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
> +	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
>  	if (ret)
>  		goto err_del_qos;
>  	return 0;
>  
>  err_del_qos:
> -	rq_qos_del(q, rqos);
> +	rq_qos_del(&ioc->rqos);
>  err_free_ioc:
>  	free_percpu(ioc->pcpu_stat);
>  	kfree(ioc);
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index b55eac2cf91944..1c394bd77aa0b4 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -757,24 +757,18 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
>  
>  int blk_iolatency_init(struct gendisk *disk)
>  {
> -	struct request_queue *q = disk->queue;
>  	struct blk_iolatency *blkiolat;
> -	struct rq_qos *rqos;
>  	int ret;
>  
>  	blkiolat = kzalloc(sizeof(*blkiolat), GFP_KERNEL);
>  	if (!blkiolat)
>  		return -ENOMEM;
>  
> -	rqos = &blkiolat->rqos;
> -	rqos->id = RQ_QOS_LATENCY;
> -	rqos->ops = &blkcg_iolatency_ops;
> -	rqos->q = q;
> -
> -	ret = rq_qos_add(q, rqos);
> +	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
> +			 &blkcg_iolatency_ops);
>  	if (ret)
>  		goto err_free;
> -	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
> +	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
>  	if (ret)
>  		goto err_qos_del;
>  
> @@ -784,7 +778,7 @@ int blk_iolatency_init(struct gendisk *disk)
>  	return 0;
>  
>  err_qos_del:
> -	rq_qos_del(q, rqos);
> +	rq_qos_del(&blkiolat->rqos);
>  err_free:
>  	kfree(blkiolat);
>  	return ret;
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 88f0fe7dcf5451..14bee1bd761362 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -294,3 +294,70 @@ void rq_qos_exit(struct request_queue *q)
>  		rqos->ops->exit(rqos);
>  	}
>  }
> +
> +int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> +		struct rq_qos_ops *ops)
> +{
> +	struct request_queue *q = disk->queue;
> +
> +	rqos->q = q;
> +	rqos->id = id;
> +	rqos->ops = ops;
> +
> +	/*
> +	 * No IO can be in-flight when adding rqos, so freeze queue, which
> +	 * is fine since we only support rq_qos for blk-mq queue.
> +	 *
> +	 * Reuse ->queue_lock for protecting against other concurrent
> +	 * rq_qos adding/deleting
> +	 */
> +	blk_mq_freeze_queue(q);
> +
> +	spin_lock_irq(&q->queue_lock);
> +	if (rq_qos_id(q, rqos->id))
> +		goto ebusy;
> +	rqos->next = q->rq_qos;
> +	q->rq_qos = rqos;
> +	spin_unlock_irq(&q->queue_lock);
> +
> +	blk_mq_unfreeze_queue(q);
> +
> +	if (rqos->ops->debugfs_attrs) {
> +		mutex_lock(&q->debugfs_mutex);
> +		blk_mq_debugfs_register_rqos(rqos);
> +		mutex_unlock(&q->debugfs_mutex);
> +	}
> +
> +	return 0;
> +ebusy:
> +	spin_unlock_irq(&q->queue_lock);
> +	blk_mq_unfreeze_queue(q);
> +	return -EBUSY;
> +}
> +
> +void rq_qos_del(struct rq_qos *rqos)
> +{
> +	struct request_queue *q = rqos->q;
> +	struct rq_qos **cur;
> +
> +	/*
> +	 * See comment in rq_qos_add() about freezing queue & using
> +	 * ->queue_lock.
> +	 */
> +	blk_mq_freeze_queue(q);
> +
> +	spin_lock_irq(&q->queue_lock);
> +	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
> +		if (*cur == rqos) {
> +			*cur = rqos->next;
> +			break;
> +		}
> +	}
> +	spin_unlock_irq(&q->queue_lock);
> +
> +	blk_mq_unfreeze_queue(q);
> +
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_mq_debugfs_unregister_rqos(rqos);
> +	mutex_unlock(&q->debugfs_mutex);
> +}
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 1ef1f7d4bc3cbc..22552785aa31ed 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -85,65 +85,9 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
>  	init_waitqueue_head(&rq_wait->wait);
>  }
>  
> -static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
> -{
> -	/*
> -	 * No IO can be in-flight when adding rqos, so freeze queue, which
> -	 * is fine since we only support rq_qos for blk-mq queue.
> -	 *
> -	 * Reuse ->queue_lock for protecting against other concurrent
> -	 * rq_qos adding/deleting
> -	 */
> -	blk_mq_freeze_queue(q);
> -
> -	spin_lock_irq(&q->queue_lock);
> -	if (rq_qos_id(q, rqos->id))
> -		goto ebusy;
> -	rqos->next = q->rq_qos;
> -	q->rq_qos = rqos;
> -	spin_unlock_irq(&q->queue_lock);
> -
> -	blk_mq_unfreeze_queue(q);
> -
> -	if (rqos->ops->debugfs_attrs) {
> -		mutex_lock(&q->debugfs_mutex);
> -		blk_mq_debugfs_register_rqos(rqos);
> -		mutex_unlock(&q->debugfs_mutex);
> -	}
> -
> -	return 0;
> -ebusy:
> -	spin_unlock_irq(&q->queue_lock);
> -	blk_mq_unfreeze_queue(q);
> -	return -EBUSY;
> -
> -}
> -
> -static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
> -{
> -	struct rq_qos **cur;
> -
> -	/*
> -	 * See comment in rq_qos_add() about freezing queue & using
> -	 * ->queue_lock.
> -	 */
> -	blk_mq_freeze_queue(q);
> -
> -	spin_lock_irq(&q->queue_lock);
> -	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
> -		if (*cur == rqos) {
> -			*cur = rqos->next;
> -			break;
> -		}
> -	}
> -	spin_unlock_irq(&q->queue_lock);
> -
> -	blk_mq_unfreeze_queue(q);
> -
> -	mutex_lock(&q->debugfs_mutex);
> -	blk_mq_debugfs_unregister_rqos(rqos);
> -	mutex_unlock(&q->debugfs_mutex);
> -}
> +int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> +		struct rq_qos_ops *ops);
> +void rq_qos_del(struct rq_qos *rqos);
>  
>  typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
>  typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 473ae72befaf1a..97149a4f10e600 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -855,9 +855,6 @@ int wbt_init(struct gendisk *disk)
>  	for (i = 0; i < WBT_NUM_RWQ; i++)
>  		rq_wait_init(&rwb->rq_wait[i]);
>  
> -	rwb->rqos.id = RQ_QOS_WBT;
> -	rwb->rqos.ops = &wbt_rqos_ops;
> -	rwb->rqos.q = q;
>  	rwb->last_comp = rwb->last_issue = jiffies;
>  	rwb->win_nsec = RWB_WINDOW_NSEC;
>  	rwb->enable_state = WBT_STATE_ON_DEFAULT;
> @@ -870,7 +867,7 @@ int wbt_init(struct gendisk *disk)
>  	/*
>  	 * Assign rwb and add the stats callback.
>  	 */
> -	ret = rq_qos_add(q, &rwb->rqos);
> +	ret = rq_qos_add(&rwb->rqos, q->disk, RQ_QOS_WBT, &wbt_rqos_ops);
                                     ^^^^^^^
				     disk (no?)
>  	if (ret)
>  		goto err_free;
>  
> -- 
> 2.39.0
> 

Otherwise looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
