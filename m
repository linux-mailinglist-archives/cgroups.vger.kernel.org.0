Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B56368C4
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiKWS1u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiKWS1X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:27:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C365875;
        Wed, 23 Nov 2022 10:27:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2862422pjc.3;
        Wed, 23 Nov 2022 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkuJbkh43Co2UTSXb2C1Aswe4Vf/cx6MZjOFratu/Lw=;
        b=hfWyPvgKFj2qty6cIV8tWczPoJ4XrP/IZZ1+V4y5pp8rSQGcIDdvFreSqpWEBv5CQ4
         vWL2hd6JPKq9sP+uI8BDjxBqMtSWlW0weiK/inhIiTSc0tjRWRCRKtsOCyDpLpqNu+1W
         vxmUZBu/1+E/CjQ3sJrA4efID7j/03XQmq9HFXGB+7Y8gQlnL+16spK6JaC8j/kg0FYk
         kWElj4INXjenT6DPZTE+883OchrAYlz+xRgEqrf1f91aT01XjsgWZjr60bKHngT7eeWv
         yMeJGF9Hy0Yyx/ylZjuUEQrWrJ0UJPf0sgGmz8071zpKHfRHDq6PtyTipIjwsrGi9J8X
         Ddug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkuJbkh43Co2UTSXb2C1Aswe4Vf/cx6MZjOFratu/Lw=;
        b=b59xRy1NNB02u4ukNq3p+CaSJESfwA2SfovQeYsVF+ojRJlgAPUmcYsxOnEHBECvjl
         wJ9MW8aS0VeSYqwPQgnuErr4WZYNTa5oNT7YPMo1Lt4QUrXTYrrJ0+0v2DTd/sMYn5xn
         wj1SZmE417GF8PkRcvMzZbyMpH9X94OH/PjpU+Q7zSSA3IXu7ncRRD30IomKTxYw5bbd
         8CLC+eKNuoyu4Q4n5prNaw0ICqzwXZOIxAWdPvXmSWgUJpzHyCvFdWvcgqXSBedZtQyg
         jf2D/TUH+Iuoeb1MBdDcJXVTnHWfP8d6ve/uOa+Xl7E83mukw8ABFWyqeIE/cxg3N/kg
         NqqA==
X-Gm-Message-State: ANoB5pl83VMK3ctyqk+zlrges6f0qTiTEyxaJaxZtKzYe/WvV2kM2y0p
        0FA4MGl8FVhnfTmvlxMsSZw=
X-Google-Smtp-Source: AA0mqf4JvA39a5eyrkrpImOfz4Ug99pzEsgXnReWgKWgV0Hqb9t0vFzY9cOEePFnqyfeofmswt+VEw==
X-Received: by 2002:a17:902:f391:b0:188:537d:78d9 with SMTP id f17-20020a170902f39100b00188537d78d9mr19000064ple.48.1669228038902;
        Wed, 23 Nov 2022 10:27:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r12-20020a63e50c000000b00476dc914262sm11139869pgh.1.2022.11.23.10.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:27:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:27:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] blk-throttle: remove incorrect comment for
 tg_last_low_overflow_time
Message-ID: <Y35mBVQgYgCvmZhz@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-8-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-8-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:57PM +0800, Kemeng Shi wrote:
> Function tg_last_low_overflow_time is called with intermediate node as
> following:
> throtl_hierarchy_can_downgrade
>   throtl_tg_can_downgrade
>     tg_last_low_overflow_time
> 
> throtl_hierarchy_can_upgrade
>   throtl_tg_can_upgrade
>     tg_last_low_overflow_time
> 
> throtl_hierarchy_can_downgrade/throtl_hierarchy_can_upgrade will traverse
> from leaf node to sub-root node and pass traversed intermediate node
> to tg_last_low_overflow_time.
> 
> No such limit could be found from context and implementation of
> tg_last_low_overflow_time, so remove this limit in comment.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
