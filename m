Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1C59EC81
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiHWTiG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiHWThd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:37:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEADA262F;
        Tue, 23 Aug 2022 11:34:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pm13so5850080pjb.5;
        Tue, 23 Aug 2022 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=JfIVW5EAwcziVt6ePzGMkVRPbB2bi7yV+a8QRJJ7RgI=;
        b=q2ExPiLlmr3rFwyGKyFXlMV0seXxl2bOW/vbx0cJKPMa41O8h0U5Zh4IcGSH/ZVlfA
         tGxkmod7yD4lDznK3zTaxdLioXjnbXJuP5pTi8fvgtB4XP0Zw1RAjUNS19hYVgSqLprg
         Iu5kjJ4wOVLnNfmSZ0WYps4ZaILOqbrjOz6ENcqZ7z4BF23tEAPFkIJJGqJJsb65I4jL
         dWoWCcSPW5Xk+5pn15qtd/aOLzGUSPf4kzTDKOvcbryapOxCZResD/Jw7kbtaancyk97
         7zU6ZDOeKvDffRu3TqYryVn6skyhNVDmt5NIj8EC1ejkiew4bYHycaz+J/mb1mEpmwzf
         oVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=JfIVW5EAwcziVt6ePzGMkVRPbB2bi7yV+a8QRJJ7RgI=;
        b=4VFXlO7ok755vA880UDygPrPPp0tUIZnBtTposDz5dRTHzmYwGBVrRH07RUMDFgQEQ
         Mn4R54u5BEFfpjHQ+OvcKb7PxA6RKOckk+D43yfeBLA6O77YYu6lRyv6+OFnqm+dpYe5
         eVBV/KnfG7VAoIJxd5g+YC3H6AgRCqmq03iGNOQ0nagjqY5vQ4OCIxCyVNBflKNIh/XG
         OHAGlEOwGMXy8JlDzJLmKpNT9KBFdoaXhE/5uyMpOBqf6OfSfeEgDMCi+Wgk+UR0B0Z+
         jWjh5CIYAeXxElSUVwCYu4uu8TF/f3EvBD7p8uC2qNRS2UJ36Ij+dSrmOkwfTTls1x2D
         u8DQ==
X-Gm-Message-State: ACgBeo2rKeYRX4ccLgZ3YeBeNqUP7kkPNDGANel6MjTngLJTFJuzZGar
        oUTWSiqDAIKLLHAa15jjvgQ=
X-Google-Smtp-Source: AA6agR4k77gYNs28ebZLcJfF5hB6Kw5jzDg+UqpjOg+Arvubt7GuKXOlWpjHjwYiz7G1YBG3pgwA+g==
X-Received: by 2002:a17:902:6bc9:b0:173:f3f:4a8c with SMTP id m9-20020a1709026bc900b001730f3f4a8cmr1401690plt.96.1661279652870;
        Tue, 23 Aug 2022 11:34:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id d131-20020a621d89000000b0050dc76281e0sm11011205pfd.186.2022.08.23.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:34:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 08:34:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 4/4] blk-throttle: cleanup throtl_dequeue_tg()
Message-ID: <YwUdouGld9Z7K8r1@slm.duckdns.org>
References: <20220823013810.406075-1-yukuai1@huaweicloud.com>
 <20220823013810.406075-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823013810.406075-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 23, 2022 at 09:38:10AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that throtl_dequeue_tg() is called when the last bio is dispatched,
> there is no need to check the flag THROTL_TG_PENDING, since it's ensured
> to be set when bio is throttled.
> 
> There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 47142a1dd102..e47506a8ef47 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -570,14 +570,11 @@ static void throtl_enqueue_tg(struct throtl_grp *tg)
>  
>  static void throtl_dequeue_tg(struct throtl_grp *tg)
>  {
> -	if (tg->flags & THROTL_TG_PENDING) {
> -		struct throtl_service_queue *parent_sq =
> -			tg->service_queue.parent_sq;
> +	struct throtl_service_queue *parent_sq = tg->service_queue.parent_sq;
>  
> -		throtl_rb_erase(&tg->rb_node, parent_sq);
> -		--parent_sq->nr_pending;
> -		tg->flags &= ~THROTL_TG_PENDING;
> -	}
> +	throtl_rb_erase(&tg->rb_node, parent_sq);
> +	--parent_sq->nr_pending;
> +	tg->flags &= ~THROTL_TG_PENDING;

Yeah, I don't know about this one. This breaks the symmetry with
throtl_enqueue_tg() and it's a bit odd that we aren't at least
WARN_ON_ONCE() on the flag given what the flag tracks. If you want to do
this, I think the prev approach of just removing the flag is better as that
was symmetric at least.

Thanks.

-- 
tejun
