Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A26752A3
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 11:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjATKhm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 05:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjATKhl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 05:37:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620243906;
        Fri, 20 Jan 2023 02:37:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21BAF22AB7;
        Fri, 20 Jan 2023 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674211059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3mMbDed4lIYSOjUOIUjf25WtGw4D7/Xu7CV/nlUFww=;
        b=NiRWCK8uURnjXIWzPxDMvDvcNP9IfDtKuf9VOHNcHIGWYyNMH4nsFeor6PR2FOtkVpYqKL
        np7dQmcZhFI3LcFin/8BTgvQXd8NMBzQJBXh7tx5n5GINPrw7tFlYfRTGk2rs7b2WWkQ3i
        7kyKoXIdJRNof1t3ZnZT98tn9E6uOp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674211059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3mMbDed4lIYSOjUOIUjf25WtGw4D7/Xu7CV/nlUFww=;
        b=kgbarZfaftzBiCY4lHlYJ3RhCa6XbQpV1XJnAyYSuyUwbIcWA/rehk7zznL7DToyvVRGsi
        9QcGaTn7CvrOP6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3C8F13251;
        Fri, 20 Jan 2023 10:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wRL1KPJuymOsWQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 10:37:38 +0000
Date:   Fri, 20 Jan 2023 11:37:36 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 13/15] blk-cgroup: pass a gendisk to pd_alloc_fn
Message-ID: <Y8pu8KrfGtN61ymo@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-14-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:55AM +0100, Christoph Hellwig wrote:
> No need to the request_queue here, pass a gendisk and extract the
> node ids from that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bfq-cgroup.c    |  6 +++---
>  block/blk-cgroup.c    | 10 +++++-----
>  block/blk-cgroup.h    |  4 ++--
>  block/blk-iocost.c    |  7 ++++---
>  block/blk-iolatency.c |  7 +++----
>  block/blk-ioprio.c    |  2 +-
>  block/blk-throttle.c  |  7 +++----
>  7 files changed, 21 insertions(+), 22 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index b1b8eca99d988f..055f9684c1c502 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -515,12 +515,12 @@ static void bfq_cpd_free(struct blkcg_policy_data *cpd)
>  	kfree(cpd_to_bfqgd(cpd));
>  }
>  
> -static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, struct request_queue *q,
> -					     struct blkcg *blkcg)
> +static struct blkg_policy_data *bfq_pd_alloc(struct gendisk *disk,
> +		struct blkcg *blkcg, gfp_t gfp)
>  {
>  	struct bfq_group *bfqg;
>  
> -	bfqg = kzalloc_node(sizeof(*bfqg), gfp, q->node);
> +	bfqg = kzalloc_node(sizeof(*bfqg), gfp, disk->node_id);
>  	if (!bfqg)
>  		return NULL;
>  
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 353421afe1d70d..601b156897dea4 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -268,7 +268,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  			continue;
>  
>  		/* alloc per-policy data and attach it to blkg */
> -		pd = pol->pd_alloc_fn(gfp_mask, disk->queue, blkcg);
> +		pd = pol->pd_alloc_fn(disk, blkcg, gfp_mask);
>  		if (!pd)
>  			goto err_free;
>  
> @@ -1404,8 +1404,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>  			pd = pd_prealloc;
>  			pd_prealloc = NULL;
>  		} else {
> -			pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q,
> -					      blkg->blkcg);
> +			pd = pol->pd_alloc_fn(disk, blkg->blkcg,
> +					      GFP_NOWAIT | __GFP_NOWARN);
>  		}
>  
>  		if (!pd) {
> @@ -1422,8 +1422,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>  
>  			if (pd_prealloc)
>  				pol->pd_free_fn(pd_prealloc);
> -			pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q,
> -						       blkg->blkcg);
> +			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
> +						       GFP_KERNEL);
>  			if (pd_prealloc)
>  				goto retry;
>  			else
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index e9e0c00d13d64d..9a2cd3c71a94a2 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -150,8 +150,8 @@ typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
>  typedef void (blkcg_pol_init_cpd_fn)(struct blkcg_policy_data *cpd);
>  typedef void (blkcg_pol_free_cpd_fn)(struct blkcg_policy_data *cpd);
>  typedef void (blkcg_pol_bind_cpd_fn)(struct blkcg_policy_data *cpd);
> -typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(gfp_t gfp,
> -				struct request_queue *q, struct blkcg *blkcg);
> +typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(struct gendisk *disk,
> +		struct blkcg *blkcg, gfp_t gfp);
>  typedef void (blkcg_pol_init_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 6557bbd409b57e..3f41d83b4c4ecf 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2916,13 +2916,14 @@ static void ioc_cpd_free(struct blkcg_policy_data *cpd)
>  	kfree(container_of(cpd, struct ioc_cgrp, cpd));
>  }
>  
> -static struct blkg_policy_data *ioc_pd_alloc(gfp_t gfp, struct request_queue *q,
> -					     struct blkcg *blkcg)
> +static struct blkg_policy_data *ioc_pd_alloc(struct gendisk *disk,
> +		struct blkcg *blkcg, gfp_t gfp)
>  {
>  	int levels = blkcg->css.cgroup->level + 1;
>  	struct ioc_gq *iocg;
>  
> -	iocg = kzalloc_node(struct_size(iocg, ancestors, levels), gfp, q->node);
> +	iocg = kzalloc_node(struct_size(iocg, ancestors, levels), gfp,
> +			    disk->node_id);
>  	if (!iocg)
>  		return NULL;
>  
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 39853fc5c2b02f..bc0d217f5c1723 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -946,13 +946,12 @@ static void iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  			iolat->max_depth, avg_lat, cur_win);
>  }
>  
> -static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp,
> -						   struct request_queue *q,
> -						   struct blkcg *blkcg)
> +static struct blkg_policy_data *iolatency_pd_alloc(struct gendisk *disk,
> +		struct blkcg *blkcg, gfp_t gfp)
>  {
>  	struct iolatency_grp *iolat;
>  
> -	iolat = kzalloc_node(sizeof(*iolat), gfp, q->node);
> +	iolat = kzalloc_node(sizeof(*iolat), gfp, disk->node_id);
>  	if (!iolat)
>  		return NULL;
>  	iolat->stats = __alloc_percpu_gfp(sizeof(struct latency_stat),
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 8194826cc824bc..055529b9b92bab 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -116,7 +116,7 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
>  }
>  
>  static struct blkg_policy_data *
> -ioprio_alloc_pd(gfp_t gfp, struct request_queue *q, struct blkcg *blkcg)
> +ioprio_alloc_pd(struct gendisk *disk, struct blkcg *blkcg, gfp_t gfp)
>  {
>  	struct ioprio_blkg *ioprio_blkg;
>  
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index efc0a9092c6942..74bb1e753ea09d 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -335,14 +335,13 @@ static void throtl_service_queue_init(struct throtl_service_queue *sq)
>  	timer_setup(&sq->pending_timer, throtl_pending_timer_fn, 0);
>  }
>  
> -static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
> -						struct request_queue *q,
> -						struct blkcg *blkcg)
> +static struct blkg_policy_data *throtl_pd_alloc(struct gendisk *disk,
> +		struct blkcg *blkcg, gfp_t gfp)
>  {
>  	struct throtl_grp *tg;
>  	int rw;
>  
> -	tg = kzalloc_node(sizeof(*tg), gfp, q->node);
> +	tg = kzalloc_node(sizeof(*tg), gfp, disk->node_id);
>  	if (!tg)
>  		return NULL;
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
