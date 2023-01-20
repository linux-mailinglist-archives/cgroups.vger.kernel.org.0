Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF95C67523C
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 11:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjATKTt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 05:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjATKTq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 05:19:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736614617D;
        Fri, 20 Jan 2023 02:19:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FA1C22713;
        Fri, 20 Jan 2023 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674209983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zu+29UGuomnbFzqKXK+NRBeIRnXrQzi06YW/hO6Mgb0=;
        b=JG+jKHebEhBESnc89FjkgKXRpVjBAl2tUPpJMoqKEgFaKoLVo9LZ8KuL+ZXj1g1ELEL5Mo
        29gV5BWdYbRgzBD+P/U1R9Y1mJ2yPzrBkiI6JvD0iwDOSDtCFq4cKQaf9iHAOFLnTh/9Tr
        FSKCmhmKSJMZJBiO6nzG76fHclxO21k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674209983;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zu+29UGuomnbFzqKXK+NRBeIRnXrQzi06YW/hO6Mgb0=;
        b=UsntPzeCu+oxVd3Vz7BijfheGXM3ULQyVYqgIOf3r3dYW3NXXsxaBGNM/YQO9XACXqVevW
        LHd/nbqROLrq3KBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA5561390C;
        Fri, 20 Jan 2023 10:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l40pKr5qymN7TwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 10:19:42 +0000
Date:   Fri, 20 Jan 2023 11:19:40 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 11/15] blk-rq-qos: store a gendisk instead of
 request_queue in struct rq_qos
Message-ID: <Y8pqvO7S4qPnYXLL@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-12-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:53AM +0100, Christoph Hellwig wrote:
> This is what about half of the users already want, and it's only going to
> grow more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-iocost.c     | 12 ++++++------
>  block/blk-iolatency.c  | 14 +++++++-------
>  block/blk-mq-debugfs.c | 10 ++++------
>  block/blk-rq-qos.c     |  4 ++--
>  block/blk-rq-qos.h     |  2 +-
>  block/blk-wbt.c        | 16 +++++++---------
>  6 files changed, 27 insertions(+), 31 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 73f09e3556d7e4..54e42b22b3599f 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -667,7 +667,7 @@ static struct ioc *q_to_ioc(struct request_queue *q)
>  
>  static const char __maybe_unused *ioc_name(struct ioc *ioc)
>  {
> -	struct gendisk *disk = ioc->rqos.q->disk;
> +	struct gendisk *disk = ioc->rqos.disk;
>  
>  	if (!disk)
>  		return "<unknown>";
> @@ -806,11 +806,11 @@ static int ioc_autop_idx(struct ioc *ioc)
>  	u64 now_ns;
>  
>  	/* rotational? */
> -	if (!blk_queue_nonrot(ioc->rqos.q))
> +	if (!blk_queue_nonrot(ioc->rqos.disk->queue))
>  		return AUTOP_HDD;
>  
>  	/* handle SATA SSDs w/ broken NCQ */
> -	if (blk_queue_depth(ioc->rqos.q) == 1)
> +	if (blk_queue_depth(ioc->rqos.disk->queue) == 1)
>  		return AUTOP_SSD_QD1;
>  
>  	/* use one of the normal ssd sets */
> @@ -2642,7 +2642,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
>  	if (use_debt) {
>  		iocg_incur_debt(iocg, abs_cost, &now);
>  		if (iocg_kick_delay(iocg, &now))
> -			blkcg_schedule_throttle(rqos->q->disk,
> +			blkcg_schedule_throttle(rqos->disk,
>  					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
>  		iocg_unlock(iocg, ioc_locked, &flags);
>  		return;
> @@ -2743,7 +2743,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
>  	if (likely(!list_empty(&iocg->active_list))) {
>  		iocg_incur_debt(iocg, abs_cost, &now);
>  		if (iocg_kick_delay(iocg, &now))
> -			blkcg_schedule_throttle(rqos->q->disk,
> +			blkcg_schedule_throttle(rqos->disk,
>  					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
>  	} else {
>  		iocg_commit_bio(iocg, bio, abs_cost, cost);
> @@ -2814,7 +2814,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
>  {
>  	struct ioc *ioc = rqos_to_ioc(rqos);
>  
> -	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
> +	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iocost);
>  
>  	spin_lock_irq(&ioc->lock);
>  	ioc->running = IOC_STOP;
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index f6aeb3d3fdae59..8e1e43bbde6f0b 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -292,7 +292,7 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
>  	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
>  
>  	if (use_delay)
> -		blkcg_schedule_throttle(rqos->q->disk, use_memdelay);
> +		blkcg_schedule_throttle(rqos->disk, use_memdelay);
>  
>  	/*
>  	 * To avoid priority inversions we want to just take a slot if we are
> @@ -330,7 +330,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
>  				struct child_latency_info *lat_info,
>  				bool up)
>  {
> -	unsigned long qd = blkiolat->rqos.q->nr_requests;
> +	unsigned long qd = blkiolat->rqos.disk->queue->nr_requests;
>  	unsigned long scale = scale_amount(qd, up);
>  	unsigned long old = atomic_read(&lat_info->scale_cookie);
>  	unsigned long max_scale = qd << 1;
> @@ -372,7 +372,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
>   */
>  static void scale_change(struct iolatency_grp *iolat, bool up)
>  {
> -	unsigned long qd = iolat->blkiolat->rqos.q->nr_requests;
> +	unsigned long qd = iolat->blkiolat->rqos.disk->queue->nr_requests;
>  	unsigned long scale = scale_amount(qd, up);
>  	unsigned long old = iolat->max_depth;
>  
> @@ -646,7 +646,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
>  
>  	timer_shutdown_sync(&blkiolat->timer);
>  	flush_work(&blkiolat->enable_work);
> -	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
> +	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iolatency);
>  	kfree(blkiolat);
>  }
>  
> @@ -665,7 +665,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
>  
>  	rcu_read_lock();
>  	blkg_for_each_descendant_pre(blkg, pos_css,
> -				     blkiolat->rqos.q->root_blkg) {
> +				     blkiolat->rqos.disk->queue->root_blkg) {
>  		struct iolatency_grp *iolat;
>  		struct child_latency_info *lat_info;
>  		unsigned long flags;
> @@ -749,9 +749,9 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
>  	 */
>  	enabled = atomic_read(&blkiolat->enable_cnt);
>  	if (enabled != blkiolat->enabled) {
> -		blk_mq_freeze_queue(blkiolat->rqos.q);
> +		blk_mq_freeze_queue(blkiolat->rqos.disk->queue);
>  		blkiolat->enabled = enabled;
> -		blk_mq_unfreeze_queue(blkiolat->rqos.q);
> +		blk_mq_unfreeze_queue(blkiolat->rqos.disk->queue);
>  	}
>  }
>  
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index bd942341b6382f..b01818f8e216e3 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -813,9 +813,9 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
>  
>  void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>  {
> -	lockdep_assert_held(&rqos->q->debugfs_mutex);
> +	lockdep_assert_held(&rqos->disk->queue->debugfs_mutex);
>  
> -	if (!rqos->q->debugfs_dir)
> +	if (!rqos->disk->queue->debugfs_dir)
>  		return;
>  	debugfs_remove_recursive(rqos->debugfs_dir);
>  	rqos->debugfs_dir = NULL;
> @@ -823,7 +823,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>  
>  void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>  {
> -	struct request_queue *q = rqos->q;
> +	struct request_queue *q = rqos->disk->queue;
>  	const char *dir_name = rq_qos_id_to_name(rqos->id);
>  
>  	lockdep_assert_held(&q->debugfs_mutex);
> @@ -835,9 +835,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>  		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
>  							 q->debugfs_dir);
>  
> -	rqos->debugfs_dir = debugfs_create_dir(dir_name,
> -					       rqos->q->rqos_debugfs_dir);
> -
> +	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
>  	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
>  }
>  
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 8e83734cfe8dbc..d8cc820a365e3a 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -300,7 +300,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>  {
>  	struct request_queue *q = disk->queue;
>  
> -	rqos->q = q;
> +	rqos->disk = disk;
>  	rqos->id = id;
>  	rqos->ops = ops;
>  
> @@ -337,7 +337,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>  
>  void rq_qos_del(struct rq_qos *rqos)
>  {
> -	struct request_queue *q = rqos->q;
> +	struct request_queue *q = rqos->disk->queue;
>  	struct rq_qos **cur;
>  
>  	/*
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 2b7b668479f71a..b02a1a3d33a89e 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -26,7 +26,7 @@ struct rq_wait {
>  
>  struct rq_qos {
>  	const struct rq_qos_ops *ops;
> -	struct request_queue *q;
> +	struct gendisk *disk;
>  	enum rq_qos_id id;
>  	struct rq_qos *next;
>  #ifdef CONFIG_BLK_DEBUG_FS
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 1c4469f9962de8..73822260be537c 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -98,7 +98,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
>   */
>  static bool wb_recent_wait(struct rq_wb *rwb)
>  {
> -	struct bdi_writeback *wb = &rwb->rqos.q->disk->bdi->wb;
> +	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
>  
>  	return time_before(jiffies, wb->dirty_sleep + HZ);
>  }
> @@ -235,7 +235,7 @@ enum {
>  
>  static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  {
> -	struct backing_dev_info *bdi = rwb->rqos.q->disk->bdi;
> +	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
>  	struct rq_depth *rqd = &rwb->rq_depth;
>  	u64 thislat;
>  
> @@ -288,7 +288,7 @@ static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  
>  static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
>  {
> -	struct backing_dev_info *bdi = rwb->rqos.q->disk->bdi;
> +	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
>  	struct rq_depth *rqd = &rwb->rq_depth;
>  
>  	trace_wbt_step(bdi, msg, rqd->scale_step, rwb->cur_win_nsec,
> @@ -358,13 +358,12 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
>  	unsigned int inflight = wbt_inflight(rwb);
>  	int status;
>  
> -	if (!rwb->rqos.q->disk)
> +	if (!rwb->rqos.disk)
>  		return;
>  
>  	status = latency_exceeded(rwb, cb->stat);
>  
> -	trace_wbt_timer(rwb->rqos.q->disk->bdi, status, rqd->scale_step,
> -			inflight);
> +	trace_wbt_timer(rwb->rqos.disk->bdi, status, rqd->scale_step, inflight);
>  
>  	/*
>  	 * If we exceeded the latency target, step down. If we did not,
> @@ -702,16 +701,15 @@ static int wbt_data_dir(const struct request *rq)
>  
>  static void wbt_queue_depth_changed(struct rq_qos *rqos)
>  {
> -	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
> +	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
>  	wbt_update_limits(RQWB(rqos));
>  }
>  
>  static void wbt_exit(struct rq_qos *rqos)
>  {
>  	struct rq_wb *rwb = RQWB(rqos);
> -	struct request_queue *q = rqos->q;
>  
> -	blk_stat_remove_callback(q, rwb->cb);
> +	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
>  	blk_stat_free_callback(rwb->cb);
>  	kfree(rwb);
>  }
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
