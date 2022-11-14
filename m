Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A76628BC6
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiKNWHt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNWHs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:07:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB4210573;
        Mon, 14 Nov 2022 14:07:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so15126690pjk.2;
        Mon, 14 Nov 2022 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWARFSddCBGf3aDJ1ajp1vvhpqhBLlESZgXSjfkXOvE=;
        b=Rj3+QSD9G8LsBjjcl+TZ+GbTq/H+NRXDvqWs514daNHR6TDjwFkYDPf1p7/YOF7hO6
         Tb+lHshVBcpxKv2DQ1iH59S8BS+QoFNTkf1gRW2LnSsr8EkGAL351/5lMZioGE7gAVT+
         Uv9bbkWdcUahORFNMt6ilxcyZ+7jjA0wayeIGf9nKRcJjikKX7tI6XB2R/4AJhHWaumP
         Blb+W0FP+SPDMTFOyNx335xcG/5z/pQcPEBZ80MC0OyrPSAltOXYzi6RRjUOfGYqpwAN
         5ZRxTO930TiFg4XjmFKFIujDHdHsJ4gFbylwG7bIzdOJvbwo4FXiC2D46TLjfpQTVEdl
         1ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWARFSddCBGf3aDJ1ajp1vvhpqhBLlESZgXSjfkXOvE=;
        b=kL3sPANvix+rzH0MvFtgiRJlO9JYfTBKzWnOv396ULm27L9K7zY/hXiBwbPsDTriWt
         o6JYSJqIKrmeG94sCkkftWVjYwu24xfkwoRyi3HtJWBV3dQi69t0+wo3DbonPwXRCGKB
         +UysruK3S1yGNVCgC6j5YOwHlYyeS3JdOQuIxi5UltoT3gqsWm+ROQtF8GbpfL63O95q
         ed6ZUau1/my8e1dv+pu/dm3RsIhh/ZKd3h06D7rO55CtmCajf5Y7I5TWXOdGXPQSEs+i
         50im1YRtQvUU5p+lfPTwhjXLxmyKIRGyaWUH/sHnJgTxdeKnUNWUcKHPPcNEBYesiDhb
         Jw5g==
X-Gm-Message-State: ANoB5plY9l+Q4hYXCWPNWALUbeJdl7dUFD4lexRDVPKfcVTCPkZjq3uF
        VxYvdA+jWNliSrUV7JobfAQ=
X-Google-Smtp-Source: AA0mqf7z3tfsEDF0z9zOgjV8fKWd3eM5PIm06JgkDK57etMWkwtmG4gq68q+UzssaSIpVTh5IayIRQ==
X-Received: by 2002:a17:903:2790:b0:188:62b7:1d6b with SMTP id jw16-20020a170903279000b0018862b71d6bmr1106996plb.106.1668463666833;
        Mon, 14 Nov 2022 14:07:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186e2123506sm8101483plg.300.2022.11.14.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:07:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:07:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Message-ID: <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104023938.2346986-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 04, 2022 at 10:39:37AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> match_u64() is called inside ioc->lock, which causes smatch static
> checker warnings:
> 
> block/blk-iocost.c:3211 ioc_qos_write() warn: sleeping in atomic context
> block/blk-iocost.c:3240 ioc_qos_write() warn: sleeping in atomic context
> block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic
> context
> 
> Fix the problem by introducing a mutex and using it while prasing input
> params.

It bothers me that parsing an u64 string requires a GFP_KERNEL memory
allocation.

> @@ -2801,9 +2806,11 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
>  {
>  	struct ioc *ioc = rqos_to_ioc(rqos);
>  
> +	mutex_lock(&ioc->params_mutex);
>  	spin_lock_irq(&ioc->lock);
>  	ioc_refresh_params(ioc, false);
>  	spin_unlock_irq(&ioc->lock);
> +	mutex_unlock(&ioc->params_mutex);
>  }

Aren't the params still protected by ioc->lock? Why do we need to grab both?

Any chance I can persuade you into updating match_NUMBER() helpers to not
use match_strdup()? They can easily disable irq/preemption and use percpu
buffers and we won't need most of this patchset.

Thanks.

-- 
tejun
