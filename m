Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C868F7CC
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 20:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBHTGG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBHTGF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 14:06:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4004DBF4;
        Wed,  8 Feb 2023 11:06:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so3104227pjb.4;
        Wed, 08 Feb 2023 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRaVZ9/X0IStuyPV6O60UspWE6lsQv03L6mbYwCmPI4=;
        b=BKzuUbCjDPwgJnJ3Jej0RMuyANAxCWK3m/MfztEgheROrMlQXQbl+C0fQhEkSkQqWM
         c+HcZfCGMr21T2mRkK7wW4uDJnEQBxHIPFq0tSGFdthcOzh1UC8pBjM+Od5pI5gMRtVV
         aXY/rHgTTfG4hQRP3m7twkNWPu5U+H/a2z8fp4O/sIsbzWmnyl5E+JvlzmsYNheFsLvZ
         jRXzjQaAKD6mPamQd4kc0HJwzrQr2fbQYrwsKQPbfBu827q+sqPQcZ+64i3pa8BxTRTA
         xDDri/kpY/8FtEBfumEf24xMYUdguB9wz/Ut02XU0lmFnpost9Ebhe1m/+3Bz+zhmNlT
         9kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRaVZ9/X0IStuyPV6O60UspWE6lsQv03L6mbYwCmPI4=;
        b=mBfs0ifxiPRlgsTHQDNTR1GCS5WsPbW4zne9pbNd8SVki/2iGkLbbOUYM2fJyA/IA3
         zUHO1Qt6JeQk7jKwY2R7QKT0kSciQscNFTwV0U3BEw4IOENTxk9DWNMY46yzmVXxc/6P
         TRRcjhJi+vmmHbcle/R6Q+HH8/8DUfkmMeACcNowQqXx2gj6wEfa8V30zy94eRoGE2Cr
         RdsRuqHYpHsd7S369KQDhMEeBD88pO4bx5cmBbEbNtJj2E514lnXrz5sFPh/0jlcYXnX
         fRJAqS/c2JoMpDH01ypJPZXADpZ3b2ez6nYgHONBMiXRN8sPIHDFo7oA4vJW083bpfPv
         96Dg==
X-Gm-Message-State: AO0yUKU3OJVgWOdI8Wfw3jTbbcI4j0VDYSGVpIViXGxfwS8E4BxlPR5o
        A9u6LOrKdHNCt6sx4kapn3k=
X-Google-Smtp-Source: AK7set/6Uklb/nCkvatjdOjFUff61kTIGa4nGNF3u5sSoYa4fLj8enWqLcwUPSyR5xEjIS8gCc54vw==
X-Received: by 2002:a17:902:ced2:b0:199:fc6:9a9b with SMTP id d18-20020a170902ced200b001990fc69a9bmr10118044plg.17.1675883164447;
        Wed, 08 Feb 2023 11:06:04 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001898ee9f723sm6469456plb.2.2023.02.08.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:06:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Feb 2023 09:06:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] blk-iocost: fix sleeping in atomic warning for
 wbt_enable_default()
Message-ID: <Y+PymbdtPVONbQAq@slm.duckdns.org>
References: <20230208034803.2818155-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208034803.2818155-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 08, 2023 at 11:48:03AM +0800, Yu Kuai wrote:
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 7a2dc9dc8e3b..03bfe1dda07c 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3279,11 +3279,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  		blk_stat_enable_accounting(disk->queue);
>  		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
>  		ioc->enabled = true;
> -		wbt_disable_default(disk);
>  	} else {
>  		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
>  		ioc->enabled = false;
> -		wbt_enable_default(disk);
>  	}
>  
>  	if (user) {
> @@ -3296,6 +3294,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  	ioc_refresh_params(ioc, true);
>  	spin_unlock_irq(&ioc->lock);
>  
> +	if (enable)
> +		wbt_disable_default(disk);
> +	else
> +		wbt_enable_default(disk);

Wouldn't this allow two competiting config attempts to race each other and
leave wbt in an unexpected state?

	task1				task2

	ioc_qos_write()			ioc_qos_write()
	lock()
	enable
	unlock()
					lock()
					disable
					unlock()
					wbt_enable_default()
	wbt_disable_default()

Thanks.

-- 
tejun
