Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A763E1D3
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiK3UXm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiK3UXQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:23:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A3EF75;
        Wed, 30 Nov 2022 12:22:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so3456908pjg.1;
        Wed, 30 Nov 2022 12:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXdxFhxTXJMZHC2K4jUkxh/OKutSS9K9Oo99ntvx5PA=;
        b=fwyygy/fIcGISnxM7SLd6HwKX/itaYN7ne1sCrDpxfbyLvA/cYTRPkVgulkb4I5K1h
         1ubPvLIZte+QIp4MCfHDL3whCyHeHroidEc7paAJ2LlFvK5lP17RnutOxvtk3AKlMYJR
         tzfQ56dgLwAYEw8BEVndHTMEIlj3V4iFc6cTpaGKvgw3/pQS6tjnLOQ9ap6SPdS/xjwD
         ho9jq2NS9Yfxyt20H3vwHJqav1tRRKrHuEvj8vuJPuyDB4o8htsopWsUszs2VaYuPqFb
         O01oWFIDJjIUhYyH99AoZmGQDceqxvisTkY1V37hhitb88QrslKdeXpoO4wwgoPbnohC
         LG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXdxFhxTXJMZHC2K4jUkxh/OKutSS9K9Oo99ntvx5PA=;
        b=IThz3mSC2S5XKMic5xJ7W2CkBmeESHvf82IGxcMQumztCAG1T39/DZi2DsaJ5HvFCt
         V79JVnjSORXJOgvaIzgek3ofXmYnEQb4UD6nexKt7vt6GXHkCXgV+XMFJW/LMCb/0TRJ
         Ho8jZt862Ll5yJVjl983osF4oDxQhLPyem4kyHM7Xlppbh03sqIK+SRasELsnkxnlnJu
         VyaNlnBV2pl5t9TEicpScOd+aTfJrnSzcNE2mFuSCF5QbLivPoi5pRsfvr5awA9qao7I
         y2t2VN5wWMfZ4LqxD7cNxGxFhjmnjOvKIktLhFCcS7sHY8lgx1Q0XC1ojzZPBfJlzd1l
         LgnQ==
X-Gm-Message-State: ANoB5pmAqzjiaRHrn88cANBhcIpKt4C/te61q+UQ+pJ2Rp0Nq5tbXYil
        erwiZfTHOcGWC61m14XF1E4=
X-Google-Smtp-Source: AA0mqf5iFU9bZQDFBqqdrpIVGNTYf2Znccn2uj/KxfyIKuIsWGP8I9Pw6CPIYJj1XVOz6CDFBtq57w==
X-Received: by 2002:a17:90a:a616:b0:219:6afd:24be with SMTP id c22-20020a17090aa61600b002196afd24bemr3258885pjq.0.1669839754973;
        Wed, 30 Nov 2022 12:22:34 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709029a4c00b00186a2dd3ffdsm1914862plv.15.2022.11.30.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:22:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:22:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 6/9] blk-iocost: change div64_u64 to
 DIV64_U64_ROUND_UP in ioc_refresh_params()
Message-ID: <Y4e7ibMMu4quJMO5@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-7-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-7-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:53PM +0800, Li Nan wrote:
> vrate_min is calculated by DIV64_U64_ROUND_UP, but vrate_max is calculated
> by div64_u64. Vrate_min may be 1 greater than vrate_max if the input
> values min and max of cost.qos are equal.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-iocost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index f4a754b9d10f..2316ba93e7d6 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -926,7 +926,7 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
>  
>  	ioc->vrate_min = DIV64_U64_ROUND_UP((u64)ioc->params.qos[QOS_MIN] *
>  					    VTIME_PER_USEC, MILLION);
> -	ioc->vrate_max = div64_u64((u64)ioc->params.qos[QOS_MAX] *
> +	ioc->vrate_max = DIV64_U64_ROUND_UP((u64)ioc->params.qos[QOS_MAX] *
>  				   VTIME_PER_USEC, MILLION);

Can you please align the parameters line? Other than that

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
