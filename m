Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0B675305
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjATLHb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 06:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjATLHX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 06:07:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1A9B4E1F;
        Fri, 20 Jan 2023 03:07:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B2EF5F87B;
        Fri, 20 Jan 2023 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674212839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvZ0mFZBcYklFj+YczxypbOCFd0ux28n2ufdTKkBrws=;
        b=QiCbZV0t6/eNQRXJS9CYOEqbFmjsVNnr5ndrJ/aY3IqzC5O+VhKeukWo+b/4/1munUQ3zr
        n2Imhl1YQhA9Zc+i607zKTSSXcalZrdvDswfOtlf7kMcyVxoDWzI9CjTkHFtkbkPv4At3x
        NOjGgXIZEwBTzf4DZ2ZU5lq7eDBTx38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674212839;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvZ0mFZBcYklFj+YczxypbOCFd0ux28n2ufdTKkBrws=;
        b=Ino5oYfxpGTO0Bwmyg24QHfT7rTpmrOOt0FAsEqWZwkVa58cgZCP6aQEVOgJXnX0yYZwkN
        1smrugADSHN5oLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27C3913251;
        Fri, 20 Jan 2023 11:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uH2tBud1ymNUagAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 11:07:19 +0000
Date:   Fri, 20 Jan 2023 12:07:17 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 14/15] blk-cgroup: pass a gendisk to blkg_lookup
Message-ID: <Y8p15fQrizOumbaU@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-15-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:56AM +0100, Christoph Hellwig wrote:
> Pass a gendisk to blkg_lookup and use that to find the match as part
> of phasing out usage of the request_queue in the blk-cgroup code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 16 ++++++++--------
>  block/blk-cgroup.h | 20 ++++++++++----------
>  2 files changed, 18 insertions(+), 18 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 601b156897dea4..a041b3ddab6e33 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -320,7 +320,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  
>  	/* link parent */
>  	if (blkcg_parent(blkcg)) {
> -		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
> +		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk);
>  		if (WARN_ON_ONCE(!blkg->parent)) {
>  			ret = -ENODEV;
>  			goto err_put_css;
> @@ -389,12 +389,12 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
> -	blkg = blkg_lookup(blkcg, q);
> +	blkg = blkg_lookup(blkcg, disk);
>  	if (blkg)
>  		return blkg;
>  
>  	spin_lock_irqsave(&q->queue_lock, flags);
> -	blkg = blkg_lookup(blkcg, q);
> +	blkg = blkg_lookup(blkcg, disk);
>  	if (blkg) {
>  		if (blkcg != &blkcg_root &&
>  		    blkg != rcu_dereference(blkcg->blkg_hint))
> @@ -413,7 +413,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  		struct blkcg_gq *ret_blkg = q->root_blkg;
>  
>  		while (parent) {
> -			blkg = blkg_lookup(parent, q);
> +			blkg = blkg_lookup(parent, disk);
>  			if (blkg) {
>  				/* remember closest blkg */
>  				ret_blkg = blkg;
> @@ -692,7 +692,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		goto fail_unlock;
>  	}
>  
> -	blkg = blkg_lookup(blkcg, q);
> +	blkg = blkg_lookup(blkcg, disk);
>  	if (blkg)
>  		goto success;
>  
> @@ -706,7 +706,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		struct blkcg_gq *new_blkg;
>  
>  		parent = blkcg_parent(blkcg);
> -		while (parent && !blkg_lookup(parent, q)) {
> +		while (parent && !blkg_lookup(parent, disk)) {
>  			pos = parent;
>  			parent = blkcg_parent(parent);
>  		}
> @@ -736,7 +736,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  			goto fail_preloaded;
>  		}
>  
> -		blkg = blkg_lookup(pos, q);
> +		blkg = blkg_lookup(pos, disk);
>  		if (blkg) {
>  			blkg_free(new_blkg);
>  		} else {
> @@ -1804,7 +1804,7 @@ void blkcg_maybe_throttle_current(void)
>  	blkcg = css_to_blkcg(blkcg_css());
>  	if (!blkcg)
>  		goto out;
> -	blkg = blkg_lookup(blkcg, disk->queue);
> +	blkg = blkg_lookup(blkcg, disk);
>  	if (!blkg)
>  		goto out;
>  	if (!blkg_tryget(blkg))
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 9a2cd3c71a94a2..3e7508907f33d8 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -230,30 +230,30 @@ static inline bool bio_issue_as_root_blkg(struct bio *bio)
>  }
>  
>  /**
> - * blkg_lookup - lookup blkg for the specified blkcg - q pair
> + * blkg_lookup - lookup blkg for the specified blkcg - disk pair
>   * @blkcg: blkcg of interest
> - * @q: request_queue of interest
> + * @disk: gendisk of interest
>   *
> - * Lookup blkg for the @blkcg - @q pair.
> + * Lookup blkg for the @blkcg - @disk pair.
>  
>   * Must be called in a RCU critical section.
>   */
>  static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
> -					   struct request_queue *q)
> +					   struct gendisk *disk)
>  {
>  	struct blkcg_gq *blkg;
>  
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
>  	if (blkcg == &blkcg_root)
> -		return q->root_blkg;
> +		return disk->queue->root_blkg;
>  
>  	blkg = rcu_dereference(blkcg->blkg_hint);
> -	if (blkg && blkg->disk->queue == q)
> +	if (blkg && blkg->disk == disk)
>  		return blkg;
>  
> -	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
> -	if (blkg && blkg->disk->queue != q)
> +	blkg = radix_tree_lookup(&blkcg->blkg_tree, disk->queue->id);
> +	if (blkg && blkg->disk != disk)
>  		blkg = NULL;
>  	return blkg;
>  }
> @@ -353,7 +353,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>  #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
>  	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
>  		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
> -					    (p_blkg)->disk->queue)))
> +					    (p_blkg)->disk)))
>  
>  /**
>   * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
> @@ -368,7 +368,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>  #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
>  	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
>  		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
> -					    (p_blkg)->disk->queue)))
> +					    (p_blkg)->disk)))
>  
>  bool __blkcg_punt_bio_submit(struct bio *bio);
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
