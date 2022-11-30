Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31063E22C
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiK3Udm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiK3Ud0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:33:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F88E5B7;
        Wed, 30 Nov 2022 12:32:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so2728489pjt.0;
        Wed, 30 Nov 2022 12:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+f73qQSWaZWQn5PMXIm5ddroitzO0fXj2VGSW5dgd4=;
        b=BGROMH3G14bf8t+5QZBF8EIw7DJlp2M69BITlayk5RGIWu5mNUNjLIwEntSuAXgoGO
         P87aZf2H9okTAtAvyUGhhYTXP1R1c0HvcGtF6oOmpH/AsjC2ZnLAUM+ZDFG50EtBaeM5
         KGLxpgoe1IdmVLAWtMdASGG8Y3NNnio4jdbNm5Jbz8nofwg0orveW/0yTrYkaCQgsF+J
         kmWIYEdlCmYOvqZCmsZDw8NVEZcFR7/wa0FmfXM7HlJWFPXVTu95gDNR/uE6f8xdr5YO
         d7vb4ikzLzG+TKHr2tWloyVj9jbP7mTm2qutSQ17RdzICHvycDY59fIM+h5QlDG8du51
         19ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+f73qQSWaZWQn5PMXIm5ddroitzO0fXj2VGSW5dgd4=;
        b=1cHyU0YoaHmzn97ZUIiHaackhSkGGGTfmPyUtglhkahfA+Ma8q/Ba3Jy8Ynyqsr5oq
         os4ONU6wqSZyN9wsyaxOby9crbbAtjmtUo8sW4Y97WPBKHaodPrBCl8MgFQfceXU1hN1
         ct/RW+4SfBCxZyg+3TOiR+y86uwkr2C047ViVD9868bEw+OWMHjc9/6LwtGN4RTYImGD
         ZdGqU233a1JsmmyCt562wql0bI67A+9Bit7gRug2l8uRP33jA+22zRJEXr7H9ovaSj3Y
         vvzX54oqAFyDEpifyh5lT85Ap6GxXMnV7iMANUz1kuGxKM1FuD6QA2FwQe+f4HKo6agf
         +lDQ==
X-Gm-Message-State: ANoB5pnFVxxpE8szki+n8rqqbH6pxXyQGkBknbpOvlyQcQUizUpO/CYO
        4BIskiEHnsK/EXZdD3LAaMk=
X-Google-Smtp-Source: AA0mqf6t98y2Qu97avdGRXp5f3d9HhWZq4w7sVVholxd7NKSPPSSvUxYIn/oHka1yFAhSMYpzlHFpw==
X-Received: by 2002:a17:902:ef4c:b0:189:8b14:55bd with SMTP id e12-20020a170902ef4c00b001898b1455bdmr17163554plx.25.1669840340739;
        Wed, 30 Nov 2022 12:32:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c30-20020a056a00009e00b0056be1581126sm1849972pfj.143.2022.11.30.12.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:32:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:32:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/9] blk-iocost: improve hanlder of match_u64()
Message-ID: <Y4e90zFnhhq764lP@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-3-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-3-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:49PM +0800, Li Nan wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 1) There are one place that return value of match_u64() is not checked.
> 2) If match_u64() failed, return value is set to -EINVAL despite that
>    there are other possible errnos.

Ditto. Does this matter?

-- 
tejun
