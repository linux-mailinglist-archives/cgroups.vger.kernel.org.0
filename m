Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8933252B6D4
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiERJv3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiERJvQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 05:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 574855FC4
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652867472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pupdpoaT7DKq0S5N7tQSpmk4iGUsYQRiyblwUNHccVQ=;
        b=LjuT9q5TL8XFVJIArbB/N1PIEjuQmhkW+TbYSa19ADULtIsDGq/cKl9E1nAlF4QBjCuMU7
        yPEbYzf6ecNbKXFp/nRiXWCdiOzlIktP6kpztX2vG/HfU6J+ZmpjqBEa5OKfXo/yZtJrjn
        fNdI3hIsQN+uW9uV/fF8RS3pVuaxOj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-LCdLCQR_MumfhsQ9UQEI-g-1; Wed, 18 May 2022 05:51:09 -0400
X-MC-Unique: LCdLCQR_MumfhsQ9UQEI-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 127FE185A7B2;
        Wed, 18 May 2022 09:51:09 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A47B2C15D58;
        Wed, 18 May 2022 09:51:02 +0000 (UTC)
Date:   Wed, 18 May 2022 17:50:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 1/2] blk-throttle: fix that io throttle can only
 work for single bio
Message-ID: <YoTBgJhhA14r61ZX@T590>
References: <20220518072751.1188163-1-yukuai3@huawei.com>
 <20220518072751.1188163-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518072751.1188163-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 18, 2022 at 03:27:50PM +0800, Yu Kuai wrote:
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
> this is due to tg_with_in_bps_limit() return 0 for this bio.
> 
> In order to fix the problem, don't skip flaged bio in
> tg_with_in_bps_limit(), and for the problem that split bio can be
> double accounted, compensate the over-accounting in __blk_throtl_bio().
> 
> Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 447e1b8722f7..6f69859eae23 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
>  	/* no need to throttle if this bio's bytes have been accounted */
> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
> +	if (bps_limit == U64_MAX) {
>  		if (wait)
>  			*wait = 0;
>  		return true;
> @@ -921,11 +921,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
>  	/* Charge the bio to the group */
> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
> -		tg->bytes_disp[rw] += bio_size;
> -		tg->last_bytes_disp[rw] += bio_size;
> -	}
> -
> +	tg->bytes_disp[rw] += bio_size;
> +	tg->last_bytes_disp[rw] += bio_size;
>  	tg->io_disp[rw]++;
>  	tg->last_io_disp[rw]++;
>  
> @@ -2121,6 +2118,21 @@ bool __blk_throtl_bio(struct bio *bio)
>  			tg->last_low_overflow_time[rw] = jiffies;
>  		throtl_downgrade_check(tg);
>  		throtl_upgrade_check(tg);
> +
> +		/*
> +		 * re-entered bio has accounted bytes already, so try to
> +		 * compensate previous over-accounting. However, if new
> +		 * slice is started, just forget it.
> +		 */
> +		if (bio_flagged(bio, BIO_THROTTLED)) {
> +			unsigned int bio_size = throtl_bio_data_size(bio);
> +
> +			if (tg->bytes_disp[rw] >= bio_size)
> +				tg->bytes_disp[rw] -= bio_size;
> +			if (tg->last_bytes_disp[rw] > bio_size)
> +				tg->last_bytes_disp[rw] -= bio_size;

The above check should be:
			if (tg->last_bytes_disp[rw] >= bio_size)

Otherwise, this patch looks fine for me.


Thanks,
Ming

