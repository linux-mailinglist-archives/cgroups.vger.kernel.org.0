Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486F4AB6C8
	for <lists+cgroups@lfdr.de>; Mon,  7 Feb 2022 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiBGI0G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 03:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244064AbiBGIPv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 03:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08DFCC043181
        for <cgroups@vger.kernel.org>; Mon,  7 Feb 2022 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644221750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZCtKdGV/PdaGul2Xel2hTCDnJYx95E5j/0H+d54vhM=;
        b=cYdCKnvXBL9hcdC9e+tOr2P3CvH5Wpdbtu8hne1S5HsOKlVVpe3to3DMMeJhhTp0FoY2Am
        Uo9qW5metTSSb1yVDkvMiO08oFio5lqIDMLslgPLAn3xt/xNNd5fwkIyOFo+A8OmI3NLif
        oyWQ0nOC3sTeYwquzV/hFfcIJN8WQoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-UW0UGwDRPQ-RJVmE6brk5w-1; Mon, 07 Feb 2022 03:15:47 -0500
X-MC-Unique: UW0UGwDRPQ-RJVmE6brk5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FE2F801B0E;
        Mon,  7 Feb 2022 08:15:45 +0000 (UTC)
Received: from T590 (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B56D127CD2;
        Mon,  7 Feb 2022 08:15:11 +0000 (UTC)
Date:   Mon, 7 Feb 2022 16:15:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 1/2] blk-throtl: introduce a new flag
 THROTL_TG_CANCELING
Message-ID: <YgDVCjkjJe1CSVxv@T590>
References: <20220128084522.3169961-1-yukuai3@huawei.com>
 <20220128084522.3169961-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128084522.3169961-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 28, 2022 at 04:45:21PM +0800, Yu Kuai wrote:
> If the new flag is set, then the throtl_grp will stop throttling bios.
> Prepare to canceling all throttled bios if the disk is gone.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7c462c006b26..abc5e506c72d 100644
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

The above change and the following one in tg_update_disptime() isn't
needed actually.

Also I'd suggest to fold the two into one patch.


Thanks,
Ming

