Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4163687D
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiKWSQJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbiKWSPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:15:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CAC47;
        Wed, 23 Nov 2022 10:14:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ci10so10339918pjb.1;
        Wed, 23 Nov 2022 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMUk2UqA8txZdZbMsTiuPaMt9b7Ay82RXjXskAbuDPs=;
        b=QAlAxOsEx24Cwf9tScvp0rAk8jnc3b8EhqyZVyTEUzMY+iffJxG+UTg2oo5xYUNszd
         672R0ISbxm5hWjLG31Lvt+uIB/W6X45fhUb3yktwB1ioI6w3ZAUq+xsbihEMtpGCk/tk
         rbTh1RYNawjVNsF66tpno4HWYq3IhBgEWzKwAesID2AUcPFOnKK/pOsZqXVE5e69/NVT
         WU2woTi4IZ91+E0sVX5QTpJmDgsRoZs6ar4Tw1Dd8m26mXphAzH0X9gs5238Ljbs6AtY
         ETcT2DHqHoHvEHW4pMIxk0CqJKz7GBBPXP5Ik/3uXCOLOADa0CxV9jX0HX9QNXg9XGAJ
         Jq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMUk2UqA8txZdZbMsTiuPaMt9b7Ay82RXjXskAbuDPs=;
        b=x3OYwQh7M9ZPV1kxW2xtEOEter6iGtlP7YBRNGVIPLrdBMlG18NfAxMXTA/hwRGZIA
         RJs0Veb5sM7h/9g2X0PiqH8b6lBYV4U69K5YjivPLML+7VvVFVyVfxqBECf1AYUBSrnI
         IUN8hw7gvjEq5gZilkRDlTJ14Ww+owIG9p8oEx1nN9/UDokiiGUn4BuKN7t/RWneXJfn
         gqzGmOLjK9Muo8orNwfDFxUTrO2qmWnIuBJVD3F0raT9xTdTVMXe4BRnPqf2sYZomqNT
         v7vqfXFjJIqbQuznOrFBfO4UqEZYPCsvnays0KxRQqOjWuxtFaG4LL21ESrzckKVD1KB
         IRzA==
X-Gm-Message-State: ANoB5pmGf8fZxfNT4OiK+CrrOa9qvrOHn5mwMBwc43kSUGWZ9jVVcD9w
        /JRf7Ds/9a8rVSxjWGz7WMM=
X-Google-Smtp-Source: AA0mqf6YZDuqBxTaT3yKbcyzATU8IJutlMvueeC+Mhr/ThkaBo1xhdJuHo5fUG353UMJ3B5H+fxWWg==
X-Received: by 2002:a17:903:22c4:b0:171:5092:4d12 with SMTP id y4-20020a17090322c400b0017150924d12mr10383844plg.107.1669227241568;
        Wed, 23 Nov 2022 10:14:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s12-20020a63f04c000000b0047681fa88d1sm11161364pgj.53.2022.11.23.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:14:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:13:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] blk-throttle: ignore cgroup without io queued in
 blk_throtl_cancel_bios
Message-ID: <Y35i54BnLjKce3Kc@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-4-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-4-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:53PM +0800, Kemeng Shi wrote:
> Ignore cgroup without io queued in blk_throtl_cancel_bios for two
> reasons:
> 1. Save cpu cycle for trying to dispatch cgroup which is no io queued.
> 2. Avoid non-consistent state that cgroup is inserted to service queue
> without THROTL_TG_PENDING set as tg_update_disptime will unconditional
> re-insert cgroup to service queue. If we are on the default hierarchy,
> IO dispatched from child in tg_dispatch_one_bio will trigger inserting
> cgroup to service queue without erase first and ruin the tree.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> ---
>  block/blk-throttle.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index b33bcf53b36e..acfac916ed99 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1728,7 +1728,12 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>  		 * Set the flag to make sure throtl_pending_timer_fn() won't
>  		 * stop until all throttled bios are dispatched.
>  		 */
> -		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
> +		tg->flags |= THROTL_TG_CANCELING;
> +
> +		/* No need to dispatch cgroup without io queued */

It's probably more important to mention that putting this in without PENDING
set can corrupt the tree in the future through double insertion.

> +		if (!(tg->flags & THROTL_TG_PENDING))
> +			continue;
> +

Other than than the above comment,

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
