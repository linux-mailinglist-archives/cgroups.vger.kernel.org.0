Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FCE52B11B
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 06:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiEREJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiEREIu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 00:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66D3E153502
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652846847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9yRM9cvhik+MrOqst9aIIa+hZTiZ1DUmhjVomIZNlk=;
        b=MZ/QXUl/05H1cwH12HOssyBN2WBhVyXbjPHCcG6GWsjuZtmuSMdrA30w0zMETt7ZrcPHBh
        A6LJdP3TeLBE0A+Sa+g8JDgpbq9+xjfENFSQU/OMNDOQnVbbxVQfvfrWFht5TLkmE/8pt7
        Pd/6bjPmAPsl1HR6qdG2eShAqFJEOLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-gpGBb33fP6OpfmsjGjyVOw-1; Wed, 18 May 2022 00:07:23 -0400
X-MC-Unique: gpGBb33fP6OpfmsjGjyVOw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E494185A7B2;
        Wed, 18 May 2022 04:07:23 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DF06492C14;
        Wed, 18 May 2022 04:07:17 +0000 (UTC)
Date:   Wed, 18 May 2022 12:07:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-throttle: delay the setting of 'BIO_THROTTLED'
 to when throttle is done
Message-ID: <YoRw8J1Y/bzxVsSR@T590>
References: <20220517134909.2910251-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517134909.2910251-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 17, 2022 at 09:49:09PM +0800, Yu Kuai wrote:
> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> introduce a new problem, for example:
> 
> [root@localhost ~]# echo "8:0 1024" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
> [root@localhost ~]# echo $$ > /sys/fs/cgroup/blkio/cgroup.procs
> [root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
> [1] 620
> [root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
> [2] 626
> [root@localhost ~]# 1+0 records in
> 1+0 records out
> 10240 bytes (10 kB, 10 KiB) copied, 10.0038 s, 1.0 kB/s1+0 records in
> 1+0 records out
> 
> 10240 bytes (10 kB, 10 KiB) copied, 9.23076 s, 1.1 kB/s
> -> the second bio is issued after 10s instead of 20s.
> 
> This is because if some bios are already queued, current bio is queued
> directly and the flag 'BIO_THROTTLED' is set. And later, when former
> bios are dispatched, this bio will be dispatched without waiting at all,
> this is due to tg_with_in_bps_limit() will return 0 if the flag is set.
> 
> Instead of setting the flag when bio starts throttle, delay to when
> throttle is done to fix the problem.
> 
> Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 447e1b8722f7..f952f2d942ff 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
>  	/* no need to throttle if this bio's bytes have been accounted */
> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
> +	if (bps_limit == U64_MAX) {

This way may double account bio size for re-entered split bio.


>  		if (wait)
>  			*wait = 0;
>  		return true;
> @@ -1226,8 +1226,10 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
>  
>  	spin_lock_irq(&q->queue_lock);
>  	for (rw = READ; rw <= WRITE; rw++)
> -		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
> +		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL))) {
> +			bio_set_flag(bio, BIO_THROTTLED);
>  			bio_list_add(&bio_list_on_stack, bio);
> +		}
>  	spin_unlock_irq(&q->queue_lock);
>  
>  	if (!bio_list_empty(&bio_list_on_stack)) {
> @@ -2134,7 +2136,8 @@ bool __blk_throtl_bio(struct bio *bio)
>  			}
>  			break;
>  		}
> -
> +		/* this bio will be issued directly */
> +		bio_set_flag(bio, BIO_THROTTLED);
>  		/* within limits, let's charge and dispatch directly */
>  		throtl_charge_bio(tg, bio);

Marking BIO_THROTTLED before throtle_charge_bio() causes the bio
bytes not be charged.

Another simple way is to compensate for previous extra bytes accounting,
something like the following patch:


diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 139b2d7a99e2..44773d2ba257 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -810,8 +810,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
-	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
+	if (bps_limit == U64_MAX) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -921,10 +920,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_THROTTLED)) {
-		tg->bytes_disp[rw] += bio_size;
-		tg->last_bytes_disp[rw] += bio_size;
-	}
+	tg->bytes_disp[rw] += bio_size;
+	tg->last_bytes_disp[rw] += bio_size;
 
 	tg->io_disp[rw]++;
 	tg->last_io_disp[rw]++;
@@ -2125,6 +2122,20 @@ bool __blk_throtl_bio(struct bio *bio)
 		if (sq->nr_queued[rw])
 			break;
 
+		/*
+		 * re-entered bio has accounted bytes already, so try to
+		 * compensate previous over-accounting. However, if new
+		 * slice is started, just forget it
+		 */
+		if (bio_flagged(bio, BIO_THROTTLED)) {
+			unsigned int bio_size = throtl_bio_data_size(bio);
+
+			if (tg->bytes_disp[rw] >= bio_size)
+				tg->bytes_disp[rw] -= bio_size;
+			if (tg->last_bytes_disp[rw] - bio_size)
+				tg->last_bytes_disp[rw] -= bio_size;
+		}
+
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
 			tg->last_low_overflow_time[rw] = jiffies;

Thanks,
Ming

