Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404C63ED41
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 11:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLAKJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 05:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLAKIx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 05:08:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CC617E12;
        Thu,  1 Dec 2022 02:08:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a9so1176769pld.7;
        Thu, 01 Dec 2022 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7QUbC62dh1yGOD50m45VAuI8cYxtojjn7C+uZOwpQw=;
        b=CeZFgZoW2rpZ3wb4OIITdw6PZfPwrOWAdcEismfeizU78ewLtv3ymPltZr32jLCUE4
         G3sZ5/Hz2BCeIfKATdzFLu2C/uzX3DvEqhCNJ3bQ2k3/xeQyiyYJfA8FRaKw6qdCl+/A
         SaDslbrhDpffqAN0sXHDsHmqGbZEGPggDA5MQ+MBicHBGZsPy3z2DSzoO0MAAi0ba1pA
         /EWtJpwtCigHCFk+0PnK3X8phb4SLCB8pAeaWdh5QBI3Iu2W+o7uvYw6/rxISN2S8W2K
         wKddXVMfWWgCJRirTX5a6WC2gWayBiK5I4a0vGcrLbdtr7NUVl5TUbh10nERAJViKXg1
         rj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7QUbC62dh1yGOD50m45VAuI8cYxtojjn7C+uZOwpQw=;
        b=71UN3A//kYko8TcKaA2qqZsexux6lto5hd/9thkTC0f056bt9ZuGfdYTq+qJV6gdvh
         sY2Tt1MzW5uWU5H8qnj40jREn86Gwj+nqKxGkjPUejVcRxS7kigIO9Ka1F8ltkmT5Unf
         Hg78s4HfgU/ZviIx0givckgzr6LBIe9ogNH8gAlItwGXWI/VilCF2aoYTbOQwBnHyrPs
         ENiOotLIOaSUmsv46NvcoY2DOmJiR54ELuZ9a8a/Clv0BPxtriJbir8sFS39Lg03qnkN
         LVTokYW0yEelcGaU6PA9JgcUj8++TFjDSli2BD4+A+JysbGr54T0DTcet7dv7p/sH1o9
         nLbg==
X-Gm-Message-State: ANoB5plhZeYi+hYl5dxjiQ/yeZUvhtIX1lNmsiW6XOojjFIvhuPX6K7z
        FWN1EgwO7eIrDvXH37vkdX8=
X-Google-Smtp-Source: AA0mqf63jd6HKCrAG0KiF7+IodPzxIFT7yEP1UMmnRxHcu4YQAzIGKbrCo1UcS5ILhUjD3DmyoS83g==
X-Received: by 2002:a17:90a:7e0d:b0:213:d630:f4af with SMTP id i13-20020a17090a7e0d00b00213d630f4afmr70374100pjl.77.1669889330257;
        Thu, 01 Dec 2022 02:08:50 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 63-20020a630642000000b0047702d44861sm2220928pgg.18.2022.12.01.02.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:08:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Dec 2022 00:08:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 2/9] blk-iocost: improve hanlder of match_u64()
Message-ID: <Y4h9MEd3q4LXDGQq@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-3-linan122@huawei.com>
 <Y4e90zFnhhq764lP@slm.duckdns.org>
 <7e4f1cea-2691-9b81-35f6-0dd236149f56@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e4f1cea-2691-9b81-35f6-0dd236149f56@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 01, 2022 at 10:15:53AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/12/01 4:32, Tejun Heo 写道:
> > On Wed, Nov 30, 2022 at 09:21:49PM +0800, Li Nan wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > 1) There are one place that return value of match_u64() is not checked.
> > > 2) If match_u64() failed, return value is set to -EINVAL despite that
> > >     there are other possible errnos.
> > 
> > Ditto. Does this matter?
> > 
> 
> It's not a big deal, but I think at least return value of match_u64()
> should be checked, we don't want to continue with invalid input, right?

Yeah, sure.

> By the way, match_u64() can return -ERANGE, which can provide more
> specific error messge to user.

I'm really not convinced going over 64bit range would be all that difficult
to spot whether the error code is -EINVAL or -ERANGE. There isn't anything
wrong with returning -ERANGE but the fact that that particular function
returns an error code doesn't necessarily mean that it *must* be forwarded.

Imagine that we used sscanf(buf, "%llu", &value) to parse the number
instead. We'd only know whether the parsing would have succeeded or not and
would probably return -EINVAL on failure and the behavior would be just
fine. This does not matter *at all*.

So, idk, I'm not necessarily against it but changing -EINVAL to -ERANGE is
pure churn. Nothing material is being improved by that change.

Thanks.

-- 
tejun
