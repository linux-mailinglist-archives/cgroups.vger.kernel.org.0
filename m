Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF68963E1C1
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiK3UUf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiK3UUO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:20:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11CEB75;
        Wed, 30 Nov 2022 12:16:26 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3426473pjd.5;
        Wed, 30 Nov 2022 12:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPepsFkzzAlPERh82aZt4pkV/bnS504IWTOqRm6eglI=;
        b=YYkKiuPumm27s0EmcWsUUHG5e9ytXuN0TIr3LbH2yjsTP3/CYiHOdAUaC7tpxgzbYw
         ham/qqRP9Rf8oGtfxozA3Od1Yr1xxcSp6EFq1Vb5gvMEiTeO8WSRy2WGpvYYDdestnar
         zqAR+LFnsmNAHWmK04ikJBKx0eHFGgBoJAojHQWoJHwuQpi4YBGbDY3Igq7+lyuiQpMk
         FSyoFlMJ30RdpTQ7KPLH6Fd35hZ8zk0efiBZjtF0bLCH4djtWO4D4xSglwKTsOVmj90O
         lEofmsroronNsvdpunT05r8iya9bqU0VlxNYXkmzTzhYAN1wC1XCn9nioQbbmhqmMn9v
         1Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPepsFkzzAlPERh82aZt4pkV/bnS504IWTOqRm6eglI=;
        b=4wZPeUg6YWWZvvH5O7rEFytj4k3O4S4FPjWYNIUaDptBnYa5u4o6DiMY41oBpsRMtB
         yLpBztxNFhk0CcxOMEQ21sMecKccBqvTG6uXKqcsNPbZsoUM416m5tTS/vjDyRvH9icL
         HoQ6R9KcMhsfBwRoVm+iWaazWEGQrPnpBnzv6xupwTp9hNIFRyekt/RKtg+KgYyHWh0N
         GRV0k6plGTZ2FHWWG/8zMM8E1IVuYMRgPNvEC+u6Q5kZIiV0mhYJvXL8BxGil+b1IxuU
         G7bV47amVoJ8lROXqoV4otT/o6HDi5elj7MpIKh9/sV/zVxvFAXznDbv0RFY8sNq1j6q
         2LAw==
X-Gm-Message-State: ANoB5pl5/JRjkmzb1qSGTDSiROLmAe3dRlHK/hwTgpXOiiyHSM/COyPa
        Ecbr8ijIg7fyoEUyTlHv2pA=
X-Google-Smtp-Source: AA0mqf5NbPLuyWcH0HI7O6KmT5hy0xWguhq1Cj2mYZRZjvB2LwtUzXgRjIjXFGiRQpdtfueTVL3QqQ==
X-Received: by 2002:a17:902:da83:b0:189:2809:2f11 with SMTP id j3-20020a170902da8300b0018928092f11mr47860081plx.105.1669839386014;
        Wed, 30 Nov 2022 12:16:26 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090a5d0500b002191e769546sm1637906pji.4.2022.11.30.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:16:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:16:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 4/9] blk-iocost: read params inside lock in
 sysfs apis
Message-ID: <Y4e6GANZCJbz7jNk@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-5-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-5-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:51PM +0800, Li Nan wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Otherwise, user might get abnormal values if params is updated
> concurrently.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
