Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F274AE6C5
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 03:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbiBICkk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 21:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbiBIBk6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 20:40:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99C9C0613CA
        for <cgroups@vger.kernel.org>; Tue,  8 Feb 2022 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644370854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWZpiBwFvHriiqLF7YJSsOzfEesJqlN4uBW9D+dn/Yg=;
        b=OIj+7lsUZ16ilN4+cfV7IslQGPfeTMdhTHAhOA2CefcSgdS15PImJPf6xgEJ0IA2+w1ORN
        x3gvDjbSVJIsgDLb6Kk5/IlAzbatD79pSwc4U+nuJPaBMzvAj4E0T+gBOTdsYkRz8Mxk1x
        0peFGab5yzcYfMrFRHzcnG1eFJKQIF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-7tG8_LF7PVegFWNz7TEElA-1; Tue, 08 Feb 2022 20:40:49 -0500
X-MC-Unique: 7tG8_LF7PVegFWNz7TEElA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8422D1091DA0;
        Wed,  9 Feb 2022 01:40:47 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE0956107E;
        Wed,  9 Feb 2022 01:39:59 +0000 (UTC)
Date:   Wed, 9 Feb 2022 09:39:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v8] block: cancel all throttled bios in del_gendisk()
Message-ID: <YgMbaqTD+ycFPAtM@T590>
References: <20220208113808.1401601-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208113808.1401601-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 08, 2022 at 07:38:08PM +0800, Yu Kuai wrote:
> Throttled bios can't be issued after del_gendisk() is done, thus
> it's better to cancel them immediately rather than waiting for
> throttle is done.
> 
> For example, if user thread is throttled with low bps while it's
> issuing large io, and the device is deleted. The user thread will
> wait for a long time for io to return.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v8:
>  - fold two patches into one
> Changes in v7:
>  - use the new solution as suggested by Ming.
> 
>  block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++++++++++++----
>  block/blk-throttle.h |  2 ++
>  block/genhd.c        |  2 ++
>  3 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7c462c006b26..557d20796157 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -43,8 +43,12 @@
>  static struct workqueue_struct *kthrotld_workqueue;
>  
>  enum tg_state_flags {
> -	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
> -	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
> +	/* on parent's pending tree */
> +	THROTL_TG_PENDING	= 1 << 0,
> +	/* bio_lists[] became non-empty */
> +	THROTL_TG_WAS_EMPTY	= 1 << 1,
> +	/* starts to cancel all bios, will be set if the disk is deleted */
> +	THROTL_TG_CANCELING	= 1 << 2,
>  };
>  
>  #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
> @@ -871,7 +875,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>  
>  	/* If tg->bps = -1, then BW is unlimited */
> -	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
> +	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
> +	    tg->flags & THROTL_TG_CANCELING) {
>  		if (wait)
>  			*wait = 0;
>  		return true;
> @@ -974,6 +979,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
>  	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
>  	struct bio *bio;
>  
> +	if (tg->flags & THROTL_TG_CANCELING)
> +		goto update;
> +
>  	bio = throtl_peek_queued(&sq->queued[READ]);
>  	if (bio)
>  		tg_may_dispatch(tg, bio, &read_wait);
> @@ -983,9 +991,10 @@ static void tg_update_disptime(struct throtl_grp *tg)
>  		tg_may_dispatch(tg, bio, &write_wait);
>  
>  	min_wait = min(read_wait, write_wait);
> -	disptime = jiffies + min_wait;
>  
> +update:
>  	/* Update dispatch time */
> +	disptime = jiffies + min_wait;

As I mentioned on V7, the change in tg_update_disptime() isn't needed, please
drop it.

>  	throtl_dequeue_tg(tg);
>  	tg->disptime = disptime;
>  	throtl_enqueue_tg(tg);
> @@ -1763,6 +1772,38 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
>  	return false;
>  }
>  
> +void blk_throtl_cancel_bios(struct request_queue *q)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct blkcg_gq *blkg;
> +
> +	spin_lock_irq(&q->queue_lock);
> +	/*
> +	 * queue_lock is held, rcu lock is not needed here technically.
> +	 * However, rcu lock is still held to emphasize that following
> +	 * path need RCU protection and to prevent warning from lockdep.
> +	 */
> +	rcu_read_lock();
> +	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
> +		struct throtl_grp *tg = blkg_to_tg(blkg);
> +		struct throtl_service_queue *sq = &tg->service_queue;
> +
> +		/*
> +		 * Set disptime in the past to make sure
> +		 * throtl_select_dispatch() won't exit without dispatching.
> +		 */
> +		tg->disptime = jiffies - 1;

It might be better to replace the above line with tg_update_disptime().

Otherwise, the patch looks good.

Thanks,
Ming

