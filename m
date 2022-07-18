Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDF578A9D
	for <lists+cgroups@lfdr.de>; Mon, 18 Jul 2022 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiGRTWy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Jul 2022 15:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGRTWw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Jul 2022 15:22:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AF2F67D;
        Mon, 18 Jul 2022 12:22:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so19138500pjr.4;
        Mon, 18 Jul 2022 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L49cEqnvIqcH6kuvpQrqn6Zje6ktkAbRLUeIUPxx/7E=;
        b=AOJiH+SXnVmQJ+bGNsZclRXLODxNSpRAvPfO/VxS7r8q2g5X+8Xlta47Sl1pGHzkV+
         FwVS6nFN35kueD5zFoeT2Vv3mlbHyBS2eLHAXHY+HA81SCyD7KP1t86n3llHw0BDRhTg
         7ch/aSQGS5uqNET+mWyGr9MIsDr6aTo1b+6izOguOwAcCZPuG46lc3d9yq3pl2ncn2vD
         Viw2Q0xjJXJVjT2AMQBZ1fIMD63Tief5fi+JCPArIrudaYNEp/+tca6nW5kzvPHK8EvX
         OrRROGhSWJzS0qyYOUQQX6nlYAPRZP8RFAaRlfraANgBC65PrFNL+zLE+OpIUFOPlbpB
         kS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L49cEqnvIqcH6kuvpQrqn6Zje6ktkAbRLUeIUPxx/7E=;
        b=hiZlLRGpZBgPitM7gSsX/2JZbHyPCZ/DtY93s4gPByhpAloBBUdCjAg/Go1iK3cF9r
         qeCaPDyRWEHIktgfxyNSlBKrkLU6f1mb7GNz35XbE3HrBppGAhkh3KJGimx4iEl+cW7E
         EkdUVyanO/4HhmNdkoGiLT6+ojicMPhVlagt0EomAmAq1+dQ5lqizTTVGhxr7VOx4zHx
         P+T9z+cEOUT2xx1N2XflOsNNgK2uMcJapg1rviOQiRtaafjJggg84aQthIevtUyOGRBc
         m2PKCQ92CRPPafLeORnRn50pIq86a9Uz2x/QrCeLwurG3txGYhUvNMuYsDc0tRgZp3a+
         VPlw==
X-Gm-Message-State: AJIora8CL1WilHca2HYj51N36fT09dMkairTf7krh9OY+F2fe1NvwvPP
        K8L94F9uc5kHYeuEgI0yISopTII1864=
X-Google-Smtp-Source: AGRyM1tq50m0ES0OTSxOpN5pOU2LngotNJr4NPiFELTsNZIQFAUcI3uyp1uiOJvpro1TX2XYoK7uXQ==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr28645338plo.113.1658172170867;
        Mon, 18 Jul 2022 12:22:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e15-20020a056a0000cf00b005255489187fsm9620296pfj.135.2022.07.18.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:22:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Jul 2022 09:22:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] block: don't allow the same type rq_qos add more than
 once
Message-ID: <YtWzB6T7GBb7fiNe@slm.duckdns.org>
References: <20220718083646.67601-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718083646.67601-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jul 18, 2022 at 04:36:46PM +0800, Jinke Han wrote:
> When the io.cost.qos file is written by two cpu concurrently, rq_qos may
> be added to one disk twice. In that case, there will be two iocs enabled
> and running on one disk. They own different iocgs on their active list.
> In the ioc_timer_fn function, because of the iocgs from two ioc have the
> same root iocg, the root iocg's walk_list may be overwritten by each
> other and this lead to list add/del corrutions in building or destorying
> the inner_walk list.
> 
> And so far, the blk-rq-qos framework works in case that one instance for
> one type rq_qos per queue by default. This patch make this explicit and
> also fix the crash above.

Ah, good catch. Looks great. Just a few nits below.

> Signed-off-by: hanjinke <hanjinke.666@bytedance.com>

Can you please use your full name in FIRST LAST form on the SOB line?

> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2886,7 +2886,12 @@ static int blk_iocost_init(struct request_queue *q)
>  	 * called before policy activation completion, can't assume that the
>  	 * target bio has an iocg associated and need to test for NULL iocg.
>  	 */
> -	rq_qos_add(q, rqos);
> +	ret = rq_qos_add(q, rqos);
> +	if (ret) {
> +		free_percpu(ioc->pcpu_stat);
> +		kfree(ioc);
> +		return ret;

Given that these get repeated for policy activation failure, it'd prolly be
better to factor them out at the end and use gotos and make all of the users
use the same pattern.

> +static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
>  {
>  	/*
>  	 * No IO can be in-flight when adding rqos, so freeze queue, which
> @@ -98,6 +98,8 @@ static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
>  	blk_mq_freeze_queue(q);
>  
>  	spin_lock_irq(&q->queue_lock);
> +	if (rq_qos_id(q, rqos->id))
> +		goto out;

Maybe rename the goto label to ebusy so that it's `goto ebusy`?

Other than the nits, please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
