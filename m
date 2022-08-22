Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8759BA36
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 09:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiHVH0G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 03:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiHVHZ4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 03:25:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F1929CA3;
        Mon, 22 Aug 2022 00:25:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so9504782pfb.7;
        Mon, 22 Aug 2022 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=msDkfbAvjPj8tG1+VbcyJyurZyD89z+69jjtCZT96Cw=;
        b=Wm8Ji1NHluqt74CopL6xSV0sx0lEWK55ZRr+ompfbpqjBuTbFHU8kiCO46OANmUSMP
         +I4sNY9RvnDKp3fB0C6rXVUNkiWkILHs2+xC1t+U2NHmbvSspDBomtr/f3aHzGVznzv/
         SaNQChOeWNEV1BOjEp3byhGvdsTZalvTGy9HQ9UcsA/bDVY4mIxl20ARf35ceYjgT4LI
         wKabvHKz4Bb3n66vzbfYgHaHWzE2gLVwbNq9SJrIAPwZNnA1+urGvpvqHxuFakHMQlBb
         t3P8IVcve2cLPI12k+dFsMDNBYWncQ+t0xzVus9MqggqoXYR/JadregHgH8nkRjEBUV+
         3AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=msDkfbAvjPj8tG1+VbcyJyurZyD89z+69jjtCZT96Cw=;
        b=wFvLJPDLHxO5s6CAgjlIlBR0b4JH+dCaRJTx52pizjcYu+zCSmIuQsxQlqO4jsmK+3
         e2B6SB7Z6hqRvUeq8nHBbAXOwSsr7H/qnBG/+pTnueupK4PJIgEZlNwb3Gby3xKtDMCc
         rI/3EHS52V7AF42EWd18eUAnlIVytLURDoEBR81HFol47QA5IMonkRxVHtQPCk10/1Sj
         v6g5bWd9u9Rx6+XByqdHm8s5GNm5EuDkUQjdJHjerAmkUTBBdN8Yn8L3OKmznAWkzk44
         GDeieQeJGEtTm+DR0yX4r+q/Z5l60UWRzxQHaDWk31s+z1BUd7p0X0A71pGDteTR1gj/
         7bHQ==
X-Gm-Message-State: ACgBeo0bJ1VmCBZ8JxVNXwGjABWHvMMry/BmoFgOqxCftKUObXkqI5Fk
        XZNIgybRsBnnAp2Yhc0ncoU=
X-Google-Smtp-Source: AA6agR6rUdzkK82sm1UBcvd5xL8mxZXyJiI+lw59UgR63AlGd2zrshfJy4MVXbMQxPnnTsDxddlEGQ==
X-Received: by 2002:a63:d0:0:b0:41b:c075:acb5 with SMTP id 199-20020a6300d0000000b0041bc075acb5mr15768848pga.480.1661153154100;
        Mon, 22 Aug 2022 00:25:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i5-20020a635405000000b004298d7b6e70sm6717648pgb.54.2022.08.22.00.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 00:25:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 21 Aug 2022 21:25:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v7 1/9] blk-throttle: fix that io throttle can only work
 for single bio
Message-ID: <YwMvgN0YxNvkC1gm@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-2-yukuai1@huaweicloud.com>
 <Yvvx+/d2+OMROUOe@slm.duckdns.org>
 <712e0f29-94ba-d3d3-ce21-cba4d6092008@huaweicloud.com>
 <Yv0qbDR+cxKeZ3nD@slm.duckdns.org>
 <83c8b253-2ebb-5af6-8ce1-6dc3b84cf182@huaweicloud.com>
 <b1791e41-4945-a0d8-8067-3841ce10fddd@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1791e41-4945-a0d8-8067-3841ce10fddd@huaweicloud.com>
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

Hello,

On Mon, Aug 22, 2022 at 11:06:44AM +0800, Yu Kuai wrote:
> While implementing the new method, I found that there seems to be a
> misunderstanding here, the code seems to try to add flag to split bio
> so that it won't be throttled again for bps limit, however:
> 
> 1) for blk throttle, split bio is issued directly and will never be
> throttled again, while orignal bio will go through throttle path again.
> 2) if cloned bio is directed to a new disk, the flag is cleared anyway.

Doesn't that make the current code correct then? But you were seeing
incorrect behaviors, right?

Thanks.

-- 
tejun
