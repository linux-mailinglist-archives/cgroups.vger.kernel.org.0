Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B157767500B
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 09:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjATI6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 03:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjATI6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 03:58:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACE9AD02;
        Fri, 20 Jan 2023 00:58:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED2C75D9E4;
        Fri, 20 Jan 2023 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674205078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRW9dd3LFMDekG45u2+/qYN7fLWsxntmKIc8+MjBipE=;
        b=PSYRFllWTapx8V5bwVFvOAiTtsiZtsU0XnxWLvTU0rWYfApTA9v42fYoqik5q2WYF0csu6
        NkNMGTOdSClB6WcJtCFZQgu78ZKN3pOfjnu3m7OBlpQlnsXNgH7di/vqzlHAS3NNGCUkT5
        ADgSvnhhO5m2oFI1UjAM5y0OrlSQAFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674205078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRW9dd3LFMDekG45u2+/qYN7fLWsxntmKIc8+MjBipE=;
        b=CkI4sRSCkbki2wORIUKs3ZZiO9kOZSoxYobcGbGkPAicUfzpbJ0dcC0Qq3n5+v8Uxu9QXp
        ZcplOKy2HGzRLtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80EC713251;
        Fri, 20 Jan 2023 08:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xJ19E5ZXymMSIQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 08:57:58 +0000
Date:   Fri, 20 Jan 2023 09:57:56 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 04/15] blk-cgroup: pin the gendisk in struct blkcg_gq
Message-ID: <Y8pXlLl8u3sFYmWl@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-5-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:46AM +0100, Christoph Hellwig wrote:
> Currently each blkcg_gq holds a request_queue reference, which is what
> is used in the policies.  But a lot of these interface will move over to
                                               ^^^^^^^^^
					       interfaces
> use a gendisk, so store a disk in strut blkcg_gq and hold a reference to
                                    ^^^^^
				    struct
> it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bfq-cgroup.c        |  6 +++---
>  block/blk-cgroup-rwstat.c |  2 +-
>  block/blk-cgroup.c        | 29 +++++++++++++----------------
>  block/blk-cgroup.h        | 11 +++++------
>  block/blk-iocost.c        |  2 +-
>  block/blk-iolatency.c     |  4 ++--
>  block/blk-throttle.c      |  4 ++--
>  7 files changed, 27 insertions(+), 31 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index a6e8da5f5cfdc1..72a033776722c9 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -407,7 +407,7 @@ static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
>  
>  	parent = bfqg_parent(bfqg);
>  
> -	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->queue_lock);
> +	lockdep_assert_held(&bfqg_to_blkg(bfqg)->disk->queue->queue_lock);
>  
>  	if (unlikely(!parent))
>  		return;
> @@ -538,7 +538,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
>  {
>  	struct blkcg_gq *blkg = pd_to_blkg(pd);
>  	struct bfq_group *bfqg = blkg_to_bfqg(blkg);
> -	struct bfq_data *bfqd = blkg->q->elevator->elevator_data;
> +	struct bfq_data *bfqd = blkg->disk->queue->elevator->elevator_data;
>  	struct bfq_entity *entity = &bfqg->entity;
>  	struct bfq_group_data *d = blkcg_to_bfqgd(blkg->blkcg);
>  
> @@ -1203,7 +1203,7 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
>  	struct cgroup_subsys_state *pos_css;
>  	u64 sum = 0;
>  
> -	lockdep_assert_held(&blkg->q->queue_lock);
> +	lockdep_assert_held(&blkg->disk->queue->queue_lock);
>  
>  	rcu_read_lock();
>  	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
> diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
> index 3304e841df7ce9..b8b8c82e667a3b 100644
> --- a/block/blk-cgroup-rwstat.c
> +++ b/block/blk-cgroup-rwstat.c
> @@ -107,7 +107,7 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
>  	struct cgroup_subsys_state *pos_css;
>  	unsigned int i;
>  
> -	lockdep_assert_held(&blkg->q->queue_lock);
> +	lockdep_assert_held(&blkg->disk->queue->queue_lock);
>  
>  	memset(sum, 0, sizeof(*sum));
>  	rcu_read_lock();
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 30d493b43f9272..f5a634ed098db0 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -131,8 +131,8 @@ static void blkg_free(struct blkcg_gq *blkg)
>  		if (blkg->pd[i])
>  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>  
> -	if (blkg->q)
> -		blk_put_queue(blkg->q);
> +	if (blkg->disk)
> +		put_disk(blkg->disk);
>  	free_percpu(blkg->iostat_cpu);
>  	percpu_ref_exit(&blkg->refcnt);
>  	kfree(blkg);
> @@ -245,10 +245,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  	if (!blkg->iostat_cpu)
>  		goto err_free;
>  
> -	if (!blk_get_queue(disk->queue))
> -		goto err_free;
> +	get_device(disk_to_dev(disk));
>  
> -	blkg->q = disk->queue;
> +	blkg->disk = disk;
>  	INIT_LIST_HEAD(&blkg->q_node);
>  	spin_lock_init(&blkg->async_bio_lock);
>  	bio_list_init(&blkg->async_bios);
> @@ -443,7 +442,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>  	struct blkcg *blkcg = blkg->blkcg;
>  	int i;
>  
> -	lockdep_assert_held(&blkg->q->queue_lock);
> +	lockdep_assert_held(&blkg->disk->queue->queue_lock);
>  	lockdep_assert_held(&blkcg->lock);
>  
>  	/* Something wrong if we are trying to remove same group twice */
> @@ -459,7 +458,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>  
>  	blkg->online = false;
>  
> -	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
> +	radix_tree_delete(&blkcg->blkg_tree, blkg->disk->queue->id);
>  	list_del_init(&blkg->q_node);
>  	hlist_del_init_rcu(&blkg->blkcg_node);
>  
> @@ -547,9 +546,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>  
>  const char *blkg_dev_name(struct blkcg_gq *blkg)
>  {
> -	if (!blkg->q->disk || !blkg->q->disk->bdi->dev)
> -		return NULL;
> -	return bdi_dev_name(blkg->q->disk->bdi);
> +	return bdi_dev_name(blkg->disk->bdi);
>  }
>  
>  /**
> @@ -581,10 +578,10 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
>  
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> -		spin_lock_irq(&blkg->q->queue_lock);
> -		if (blkcg_policy_enabled(blkg->q, pol))
> +		spin_lock_irq(&blkg->disk->queue->queue_lock);
> +		if (blkcg_policy_enabled(blkg->disk->queue, pol))
>  			total += prfill(sf, blkg->pd[pol->plid], data);
> -		spin_unlock_irq(&blkg->q->queue_lock);
> +		spin_unlock_irq(&blkg->disk->queue->queue_lock);
>  	}
>  	rcu_read_unlock();
>  
> @@ -1008,9 +1005,9 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
>  
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> -		spin_lock_irq(&blkg->q->queue_lock);
> +		spin_lock_irq(&blkg->disk->queue->queue_lock);
>  		blkcg_print_one_stat(blkg, sf);
> -		spin_unlock_irq(&blkg->q->queue_lock);
> +		spin_unlock_irq(&blkg->disk->queue->queue_lock);
>  	}
>  	rcu_read_unlock();
>  	return 0;
> @@ -1080,7 +1077,7 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>  	while (!hlist_empty(&blkcg->blkg_list)) {
>  		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
>  						struct blkcg_gq, blkcg_node);
> -		struct request_queue *q = blkg->q;
> +		struct request_queue *q = blkg->disk->queue;
>  
>  		if (need_resched() || !spin_trylock(&q->queue_lock)) {
>  			/*
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index f126fe36001eb3..85b267234823ab 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -53,8 +53,7 @@ struct blkg_iostat_set {
>  
>  /* association between a blk cgroup and a request queue */
>  struct blkcg_gq {
> -	/* Pointer to the associated request_queue */
> -	struct request_queue		*q;
> +	struct gendisk			*disk;
>  	struct list_head		q_node;
>  	struct hlist_node		blkcg_node;
>  	struct blkcg			*blkcg;
> @@ -251,11 +250,11 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
>  		return q->root_blkg;
>  
>  	blkg = rcu_dereference(blkcg->blkg_hint);
> -	if (blkg && blkg->q == q)
> +	if (blkg && blkg->disk->queue == q)
>  		return blkg;
>  
>  	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
> -	if (blkg && blkg->q != q)
> +	if (blkg && blkg->disk->queue != q)
>  		blkg = NULL;
>  	return blkg;
>  }
> @@ -355,7 +354,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>  #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
>  	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
>  		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
> -					    (p_blkg)->q)))
> +					    (p_blkg)->disk->queue)))
>  
>  /**
>   * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
> @@ -370,7 +369,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>  #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
>  	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
>  		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
> -					    (p_blkg)->q)))
> +					    (p_blkg)->disk->queue)))
>  
>  bool __blkcg_punt_bio_submit(struct bio *bio);
>  
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 6955605629e4f8..3b965d6b037970 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2946,7 +2946,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
>  {
>  	struct ioc_gq *iocg = pd_to_iocg(pd);
>  	struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
> -	struct ioc *ioc = q_to_ioc(blkg->q);
> +	struct ioc *ioc = q_to_ioc(blkg->disk->queue);
>  	struct ioc_now now;
>  	struct blkcg_gq *tblkg;
>  	unsigned long flags;
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index ecdc1074183625..b55eac2cf91944 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -974,12 +974,12 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
>  {
>  	struct iolatency_grp *iolat = pd_to_lat(pd);
>  	struct blkcg_gq *blkg = lat_to_blkg(iolat);
> -	struct rq_qos *rqos = blkcg_rq_qos(blkg->q);
> +	struct rq_qos *rqos = blkcg_rq_qos(blkg->disk->queue);
>  	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
>  	u64 now = ktime_to_ns(ktime_get());
>  	int cpu;
>  
> -	if (blk_queue_nonrot(blkg->q))
> +	if (blk_queue_nonrot(blkg->disk->queue))
>  		iolat->ssd = true;
>  	else
>  		iolat->ssd = false;
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 6fb5a2f9e1eed5..f802d8f9099430 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -388,7 +388,7 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
>  {
>  	struct throtl_grp *tg = pd_to_tg(pd);
>  	struct blkcg_gq *blkg = tg_to_blkg(tg);
> -	struct throtl_data *td = blkg->q->td;
> +	struct throtl_data *td = blkg->disk->queue->td;
>  	struct throtl_service_queue *sq = &tg->service_queue;
>  
>  	/*
> @@ -1175,7 +1175,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
>  
>  	/* throtl_data may be gone, so figure out request queue by blkg */
>  	if (tg)
> -		q = tg->pd.blkg->q;
> +		q = tg->pd.blkg->disk->queue;
>  	else
>  		q = td->queue;
>  
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
