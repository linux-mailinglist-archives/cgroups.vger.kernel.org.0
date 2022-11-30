Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC08D63E1BD
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiK3UUA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiK3UTl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:19:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE889AE0A;
        Wed, 30 Nov 2022 12:15:05 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so9911127plp.3;
        Wed, 30 Nov 2022 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3g9mSSTzBVgbdJrFv6g4zSJhT5rvOWrA1mwwXQAvko=;
        b=NnQ1jmB4WIykg8PlJ1nvAeT8NodTppKpNNw5V8wAg7twFnjXER3jxgeXtinbAZOipL
         Iqdoqym1NEW5yg+yI0NB++i7g+Ou5mxRqZTTx5p240lN0z8rX8wBQvxQDyqvpxPTDeuw
         Ene8U600qy0MCvtjXul4oa6mbz9hf6l8preNi0VRD89TBvgVjTw++amZqBpCErV9IjyV
         BDepgmdUBmzgZ5/aXjRpn0G6Dm91zxoZM905O13+vTAQRIeKoB1SotMtiijyP+0Pyf4J
         XZLhtjtxiaMVzNzu9kONvMLvjaMfr1x1+S3DoJQGLBW6ObOPOo4wToh+mJ5tsGwsiEFN
         KNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3g9mSSTzBVgbdJrFv6g4zSJhT5rvOWrA1mwwXQAvko=;
        b=XL8ekpE+vZwMi0xRFb2QUngXVq9stYogTAk331Z84ANSY4/LNjlcznnxylsekwxfUN
         xJNC2PoF+7mbBp4nCVAej6OiLZNsBEXNbxr5dBAPyG7P/2qYjnG0xkKV2RlPocFNzKEv
         k85aaEX8edeFvtG9hyNGEmo0gSKzibtkvSBChZWjRaTlo2Dd7PqrMrzdEGq23lW9PrrY
         p4KEzbXUrQWlU9VJczuxHBJtp5MjIQdo2kQQkmPccll06+RJU5iWVMjfwBFCeC2kjvnJ
         I1J7Us8mwIhuAdx7jEUEqoApmCdys176UaQXSar3k33EaQRJP/u08+YqFOJfwDNFK0QF
         AxNA==
X-Gm-Message-State: ANoB5pkb4NNuTZ7ZdpnBO7VoFlhi6kGrRtzCStgNn9R8mDcdhdFVH9AL
        taOiTNrY8veVVifh0pns4sM=
X-Google-Smtp-Source: AA0mqf5ILLiP9R2J70Q4DdVVynBfjsnp+zqUAZTOymIlj/n2V4miUJjCeHPvOoVyi9n/fusmR6vcgg==
X-Received: by 2002:a17:902:c946:b0:186:99e3:c079 with SMTP id i6-20020a170902c94600b0018699e3c079mr43689857pla.149.1669839305049;
        Wed, 30 Nov 2022 12:15:05 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b00186ac812ab0sm1931331plh.83.2022.11.30.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:15:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:15:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 3/9] blk-iocost: don't allow to configure bio
 based device
Message-ID: <Y4e5x37B2Mh+Bfko@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-4-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-4-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:50PM +0800, Li Nan wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> iocost is based on rq_qos, which can only work for request based device,
> thus it doesn't make sense to configure iocost for bio based device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Li Nan <linan122@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
