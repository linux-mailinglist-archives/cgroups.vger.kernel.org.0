Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF83CBA5D
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGPQMJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhGPQMI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 12:12:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9BC061760;
        Fri, 16 Jul 2021 09:09:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 70so7046400pgh.2;
        Fri, 16 Jul 2021 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZ7+7XgWM6hQZ0UFtx/++E9LOP3fUxSddmlsFwD/FAU=;
        b=LcFKQKWZBfnq7ztPttKD1EbLu0EBOsYfhH+Xea8T15YwjWbDADhRGBr18+d6n61OVu
         z7n5JLWPOGWy5CNStdZkiMoKjYfnMG2YTd2JNbg2iWu4a2ZBc2YIsiIuGy6jdls+3s9W
         302dsxPjS2wQQXj29r8Jgv95+YcOpGD0QfErsc8+ssZlMky0D3o0sKhgWdYQB4xi9T04
         wJZs7qxVFBwT2kRkPtKJFfEMKyf7wnmeQbdmaDUEAY5bOUJ0qAvGf9vvFfxzT61EVjQ4
         6g/XIQGoDJ9V/v3YONni7BR71ImbpC4eEBzddwe3PxiP215sH627dkBSOAP/6V8ER7zz
         5xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DZ7+7XgWM6hQZ0UFtx/++E9LOP3fUxSddmlsFwD/FAU=;
        b=jw/lFpw940wdxKAo7Ly6iktKlYj53DJNg/5hQL+byyXZle0RkXpoCTGCuYTN6noxm1
         9ty+601F/bc6dgBfJusCkwxv40urIHq05/mmnnoGIOyBgnGv6kFRyQvcPE627gX9eQ1f
         +OZVdO5UTmnFaKcIQqjZ3wkESREjXuKGcFABtS6cGIZPy5D3489kVp9MGQWzoD4IFQGT
         4NtvYBDEFWJyMduSROhONsFWr4J8yufY6G5TlHIkGFLUh/spUXljrLEaojVKgPsk2WEa
         QzWnkQqVFmTQthC9h9hWedRrv8osc6aEBcXLc0rylzWWCJVjS5UwfqQ4VF2UNkqO50dl
         VNwQ==
X-Gm-Message-State: AOAM532qPAqhEWdk6PIQpNI+HKGKhh9Ecw+38tfBfyB5NR2LPuhqB575
        kbuAxa9ikJqdgtNGX1xDrqA=
X-Google-Smtp-Source: ABdhPJyUbgcvONO40UW44ifs4qnB+E15RG/K0Ok5QmVXbx9Mo0xGOBdXsBisFJj5+L0FDrUQesQeqg==
X-Received: by 2002:a65:6909:: with SMTP id s9mr4398634pgq.321.1626451752040;
        Fri, 16 Jul 2021 09:09:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:37b9])
        by smtp.gmail.com with ESMTPSA id u7sm11831012pgl.30.2021.07.16.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:09:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Jul 2021 06:09:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
Message-ID: <YPGvIzZUI+QxP1js@mtj.duckdns.org>
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jul 16, 2021 at 02:22:49PM +0800, brookxu wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index a11b3b5..86ff943 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -348,6 +348,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
>  		trace_block_split(split, (*bio)->bi_iter.bi_sector);
>  		submit_bio_noacct(*bio);
>  		*bio = split;
> +
> +		blk_throtl_recharge_bio(*bio);

I don't think we're holding the queue lock here.

>  	}
>  }
>  
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index b1b22d8..1967438 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2176,6 +2176,40 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>  }
>  #endif
>  
> +void blk_throtl_recharge_bio(struct bio *bio)
> +{
> +	bool rw = bio_data_dir(bio);
> +	struct blkcg_gq *blkg = bio->bi_blkg;
> +	struct throtl_grp *tg = blkg_to_tg(blkg);
> +	u32 iops_limit = tg_iops_limit(tg, rw);
> +
> +	if (iops_limit == UINT_MAX)
> +		return;
> +
> +	/*
> +	 * If previous slice expired, start a new one otherwise renew/extend
> +	 * existing slice to make sure it is at least throtl_slice interval
> +	 * long since now. New slice is started only for empty throttle group.
> +	 * If there is queued bio, that means there should be an active
> +	 * slice and it should be extended instead.
> +	 */
> +	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
> +		throtl_start_new_slice(tg, rw);
> +	else {
> +		if (time_before(tg->slice_end[rw],
> +		    jiffies + tg->td->throtl_slice))
> +			throtl_extend_slice(tg, rw,
> +				jiffies + tg->td->throtl_slice);
> +	}
> +
> +	/* Recharge the bio to the group, as some BIOs will be further split
> +	 * after passing through the throttle, causing the actual IOPS to
> +	 * be greater than the expected value.
> +	 */
> +	tg->last_io_disp[rw]++;
> +	tg->io_disp[rw]++;
> +}

But blk-throtl expects queue lock to be held.

How about doing something simpler? Just estimate how many bios a given bio
is gonna be and charge it outright? The calculation will be duplicated
between the split path but that seems like the path of least resistance
here.

Thanks.

-- 
tejun
