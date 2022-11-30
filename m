Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8F63E264
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiK3U7Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3U7Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:59:24 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451B8324A;
        Wed, 30 Nov 2022 12:59:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o1so13419402pfp.12;
        Wed, 30 Nov 2022 12:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIYpJVsaC2x+XnAlDSlXu4uym9M5TWj5fDbLd+7AM/E=;
        b=L3xnIn1wpdKuckgw3HI3r9z5iKC3uwdevPZfrmuw/b1jbfj8jdJZOVswk68vmHn21o
         GQIMOdSuBk3OSFNfE5YkGrKQYmOAJXxjZ/OOmypnCTW2dKtMhIwfS6REwkk1yvNj/S44
         J4LLD7cKy1OuyHR0nUgcwYERHY3LZ2sylZS9yV13BTl52i043eQ5AlmWFMaOVx5tO2kv
         BNcNqw1cIrppabgEjw6zABGeSWTQrfcTf82haH3t3cfS3MRe2qXlDHgp5Unhd3YgnDhR
         NtaZm7+cfOR/kyaayPzmtzqAGGYUauQcJxb2ozki3p6nIkj0vzpTRSq4i2r6NgotGDR3
         5oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIYpJVsaC2x+XnAlDSlXu4uym9M5TWj5fDbLd+7AM/E=;
        b=7dAGkNExRstk9kxSWkyCjhwPpxTJpeUaNgCxfhWkbtQnD3DK1QhR9ZCxvfOHs18R4Q
         wLQgISfoYRDt9QYJ/qrWotvyIL6AjwkOGJ6b1Qgw7mARvu7bWLevwX5gQHhQEN+IpJjn
         czZ1TUzEjyPYLJI4Yb+MuvDHcFcw6h6gAI562R01MKjpncSDRaRIaJnMfQKfUmQLM1eQ
         np9lL+rGyaL6UoiZnOB0TauqbmFi3eSHnrBY0u9+p8Lf2v5Gr5Tf4xw/9iijoOFIblqA
         +r1BB257sMTQh/K8m+Rg6/+ZTK27xeT0Q5gOAiD4EJtoz8iuMSpbQls5UjJbX8F5V+LS
         Nvnw==
X-Gm-Message-State: ANoB5pmfCZ6uUoHzRRhV+WA9aJNQK/n3n10hhWFwD05cZnY8sB2oaxO6
        8A7RvaI9ya+JAN4o9klih4s=
X-Google-Smtp-Source: AA0mqf5+J4DKBqBObKdexlPW8CExyoc0kHyqKk012PaCUZhFrzwVOtdFTWaRHwPNBinKeaYoXXiLAA==
X-Received: by 2002:a63:134e:0:b0:46e:f011:9563 with SMTP id 14-20020a63134e000000b0046ef0119563mr57561779pgt.451.1669841962972;
        Wed, 30 Nov 2022 12:59:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b00188c9c11559sm1985774plg.1.2022.11.30.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:59:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:59:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 9/9] blk-iocost: fix walk_list corruption
Message-ID: <Y4fEKZy4rTE5rG/5@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-10-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-10-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:56PM +0800, Li Nan wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test report a problem:
> 
> ------------[ cut here ]------------
> list_del corruption. next->prev should be ffff888127e0c4b0, but was ffff888127e090b0
> WARNING: CPU: 2 PID: 3117789 at lib/list_debug.c:62 __list_del_entry_valid+0x119/0x130
> RIP: 0010:__list_del_entry_valid+0x119/0x130
> RIP: 0010:__list_del_entry_valid+0x119/0x130
> Call Trace:
>  <IRQ>
>  iocg_flush_stat.isra.0+0x11e/0x230
>  ? ioc_rqos_done+0x230/0x230
>  ? ioc_now+0x14f/0x180
>  ioc_timer_fn+0x569/0x1640
> 
> We haven't reporduced it yet, but we think this is due to parent iocg is
> freed before child iocg, and then in ioc_timer_fn, walk_list is
> corrupted.
> 
> 1) Remove child cgroup can concurrent with remove parent cgroup, and
> ioc_pd_free for parent iocg can be called before child iocg. This can be
> fixed by moving the handle of walk_list to ioc_pd_offline, since that
> offline from child is ensured to be called before parent.

Which you already did in a previous patch, right?

> 2) ioc_pd_free can be triggered from both removing device and removing
> cgroup, this patch fix the problem by deleting timer before deactivating
> policy, so that free parent iocg first in this case won't matter.

Okay, so, yeah, css's pin parents but blkg's don't. I think the right thing
to do here is making sure that a child blkg pins its parent (and eventually
ioc).

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-iocost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 710cf63a1643..d2b873908f88 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2813,13 +2813,14 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
>  {
>  	struct ioc *ioc = rqos_to_ioc(rqos);
>  
> +	del_timer_sync(&ioc->timer);
> +
>  	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
>  
>  	spin_lock_irq(&ioc->lock);
>  	ioc->running = IOC_STOP;
>  	spin_unlock_irq(&ioc->lock);
>  
> -	del_timer_sync(&ioc->timer);

I don't about this workaround. Let's fix properly?

-- 
tejun
