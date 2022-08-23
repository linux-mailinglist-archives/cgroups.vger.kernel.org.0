Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52C59EC7B
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiHWTfi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiHWTfS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:35:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F525D11C0;
        Tue, 23 Aug 2022 11:29:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g18so14791801pju.0;
        Tue, 23 Aug 2022 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=M2hrrnjzGGDhp1wkMOokst/GRD85/gv0Qg6iilAzV1k=;
        b=OjUPGn/imFgBiDsB0U79V5mA/4F1MBgRH/FFpHAH17+hJjJ9TU77qiyIqRVdvYoWEs
         d5YvATv2F4Gau8mbSWpVGGTnT2B7um/7W8T1oy1/jGX5eeZuWP/+DoZvBBvHgjp9BFf4
         +mALYB5AniEaU/VKxwQTokaQ53CRRjVBzF3fgZrnHd61mlTngp77CF5APCB2Dk4mBOXQ
         TXMVGfenVSXmsecWVzJadWfzXedN4zCGOf1mW4D2jBh2rQDmxnnaZ1uV9AlGuzUDa2UX
         mNBjF0dBUhYpv7QyWYm5sACexkkec0CoP8EEWNoKyW6M+0Bbox0mwhXHWhpFCcF+yi9F
         p1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=M2hrrnjzGGDhp1wkMOokst/GRD85/gv0Qg6iilAzV1k=;
        b=h7aufdsVjrc9LIrrciHx2L6tDfjLVWfIOHREwfFiat2kw7aSZ4Jr9YYeP63XWl2Fpl
         yN0gmO4ss7+IJWTFCTlLn7DrYMUt9waZtzxFEDPl4HLram3jc/ptgCoVAjjWYK+ccmWl
         lBvQmX1Le12uuYtNbCgLEHBmQXlZZ5zdDPc9zJP8BWQbGX8SQM4p/9tHYzKk/hQNZ9d8
         aNregQkIIjz7y/D2vLIx2XBSBPQjKdzMpfgqrE9O/USVoL2N4dbws4otK13udRA2RGVF
         IIBJ3LPokpmus2A5lg0KXFNBWxyrHO+uHnjkw7ubmMyHN3APg2ORoBGpBNIeObiPpSem
         ZOJA==
X-Gm-Message-State: ACgBeo1INrzOq27CDmy/UOP0AlFoy9PMibBLKZlVaq1DPGy9nb8fDXGv
        X76tafgRvUAggUu7sVuN68c=
X-Google-Smtp-Source: AA6agR6JMAJOCfdI4pbVFUnHmJY1KLz1de8eJEeikNZ7laSIZGbfiw7LZErylHwPVRRgkEAyhhHGxA==
X-Received: by 2002:a17:902:e890:b0:172:d3d6:16ec with SMTP id w16-20020a170902e89000b00172d3d616ecmr15499440plg.8.1661279390020;
        Tue, 23 Aug 2022 11:29:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id f14-20020a65590e000000b00422c003cf78sm9615163pgu.82.2022.08.23.11.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:29:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 08:29:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 3/4] blk-throttle: cleanup tg_update_disptime()
Message-ID: <YwUcm4CimyyOFlP9@slm.duckdns.org>
References: <20220823013810.406075-1-yukuai1@huaweicloud.com>
 <20220823013810.406075-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823013810.406075-4-yukuai1@huaweicloud.com>
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

On Tue, Aug 23, 2022 at 09:38:09AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> tg_update_disptime() only need to adjust postion for 'tg' in
> 'parent_sq', there is no need to call throtl_enqueue/dequeue_tg(),
> since they will set/clear flag THROTL_TG_PENDING and increase/decrease
> nr_pending, which is useless. By the way, clear the flag/decrease
> nr_pending while there are still throttled bios is not good for debugging.
> 
> There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
