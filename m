Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB175E87F6
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 05:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiIXDcU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 23:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiIXDcQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 23:32:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFA12AECA;
        Fri, 23 Sep 2022 20:32:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so1888630pgb.4;
        Fri, 23 Sep 2022 20:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=6ie65mmUX7k2h2mobWPlWsffXk7OzouDQ0Bfk3M0MI0=;
        b=YcQRQDG3wliRsfpTrJV9HWJOu75ovx7pV9imXwjWYU82Ib3R4WOEC6s1Xm9NvHfdmD
         1jaOX9sJo7ytEjcafhg8PmEvLfMYCTL1X3P/RNhnbHZsNmOsmfRfsUIkUIMo3DysC4LG
         KbppjXtOulf0E5s06vwtdd1SDx+0HVHG8zVgcfQBaBKtSr90lW7NVpiX2MVA5Tq/IpZC
         GZyBtBDB8M/qZGmPfKyAN3F5r+2gi/Cabq2aceYGQkU6rI8yROOnZ8aenzfPcJsDynCg
         ziHkgKYb1MvZabDayhfI0rqQFqM58/yCLRFJ8nW4gOmKgCuBFNfvdFjXj9lvhqgiUiYV
         9Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6ie65mmUX7k2h2mobWPlWsffXk7OzouDQ0Bfk3M0MI0=;
        b=eeJuHPTxBdR7QbbI1UYYjMBPJJ9cls4tCDSCTglU8Xn9uffCJuMMJozzH/aYzmx456
         I3eOdVPhQg71W7rUM8PmWFD+UmsSK8yc7mMmwzuIplzkwfXxwH2pYORXGNzLofISb70k
         Zyp7Y0zEa4Ina0lzbJazZvrBYdk5wnyzwq5zcc6VDZ4JxNaSHJ7TZr0ngRCq2l0r58xi
         9id/fzhIN1JqtPq126WTPZld3aZX8Aw6cObqyvYyVJdTIuGPS1CZEhZChjf1UHDeTCzK
         rApovp2+fGsJRWk3XscCI83Ln3/dY+V5yOSC+vvJq7XPPB+42KKv6/WuSWvzIN+ETPGn
         /kcw==
X-Gm-Message-State: ACrzQf2fVrmbPCd6foE2lwbWN+MltJ9cVelWthwjZbvF9QeZqFuJjJS4
        Hya1TxHGNHPSVGoRkfoKA9gontALuQ0muA==
X-Google-Smtp-Source: AMsMyM4nugCGsPdn7b+3+QFDV4uzseziMn4g4QRoenI4+mEWg20ib1j/xjImie9KvNBR8i+JMQWccQ==
X-Received: by 2002:a63:942:0:b0:43c:428d:16a9 with SMTP id 63-20020a630942000000b0043c428d16a9mr5963727pgj.423.1663990333192;
        Fri, 23 Sep 2022 20:32:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902c38a00b001750b31faabsm6646022plg.262.2022.09.23.20.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:32:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 17:32:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 2/2] blk-throttle: improve bypassing bios checkings
Message-ID: <Yy56O9NbiyBogSLD@slm.duckdns.org>
References: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
 <20220921095309.1481289-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921095309.1481289-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 21, 2022 at 05:53:09PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> "tg->has_rules" is extended to "tg->has_rules_iops/bps", thus bios that
> don't need to be throttled can be checked accurately.
> 
> With this patch, bio will be throttled if:
> 
> 1) Bio is read/write, and corresponding read/write iops limit exist.
> 2) If corresponding doesn't exist, corresponding bps limit exist and
> bio is not throttled before.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
