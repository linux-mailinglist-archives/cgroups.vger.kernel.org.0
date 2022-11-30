Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E163E2D1
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 22:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiK3VfE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 16:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3VfC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 16:35:02 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1E6900F4;
        Wed, 30 Nov 2022 13:35:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so5863pjd.5;
        Wed, 30 Nov 2022 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXkUDMcMs9WgGhgTQ1dg9rnTqsob6sBXrwZraJBx4kE=;
        b=nWCah6XMtnPWKJh6vnssFI5N/d9FQPdB7jV8COmfDte+xB72bpw8YGjxueh9go/+G/
         0ZvDJSh6pXGklPLGyb0MTiquttx+tLL5zhtb7mB4UMKuRA0LfDsaftGMmGD+ZpW5PJb/
         xXRY/EOFmjzjgw4kZlueQSvs71oZrem4XKD1bspbiugsDherySnobRVkOHdTFMGJnjVT
         GtqfIvq/dIWRXzZdN+argCD1CLF+29dpyp9+Oy9nnf2Q427psbpiQ09Cn3bXrz1xzK2I
         qomSU9j6YdH2Yx+l7cXqkPoxlytpnPZCRGQJoI0rp84YFDzMFwOzdpfa2Qg7itviowav
         Ayig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXkUDMcMs9WgGhgTQ1dg9rnTqsob6sBXrwZraJBx4kE=;
        b=xGwVY3LYtaQejH4Vii6LuWzkcIa0mtln88pBSoBFR07XBl4XYm88agdWZZhsKM5L16
         4eKUX6KLxIFYrUJSz8A5yZ7ck1Q1QveICBKHzZShORuUYBeNp9vIisHRFf/mGEJeVRrB
         Ql3Qw7KYjyzZMfuS9TtrkOkNHxyA0HH0CcMEg6PZvJ9KaCXhoUhYu2dI9kQD2wQAd8eX
         6/l79NX34av8ywWzSpaEYCemzQhSLs01C6S/cD1mzdPcjd+jUyOAJvpkeI0LrVDzhWxY
         5y439PBXlWEDX5MnsYBkPfUthGxmGFkdxD1bZEzH2x1lgF4Dyg2JnqWE6WtebDy3WTxS
         o7SA==
X-Gm-Message-State: ANoB5pmsknte+9vKeSe8xu90CRRNrlEnHvbx3Z82yNeHuFMKIuIazOxK
        Lin2kyT0c6DCfT2+eIPLMmE4bML2qqC+zQ==
X-Google-Smtp-Source: AA0mqf78HtQ4VMDZvcYlKdTCjpdamB2yIxbtIGkQDsonE3Lt0CmQbHNW5cijhbUA+y4FLAUvkGrbNg==
X-Received: by 2002:a17:90a:f30d:b0:219:536b:41ef with SMTP id ca13-20020a17090af30d00b00219536b41efmr9626643pjb.71.1669844101233;
        Wed, 30 Nov 2022 13:35:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b00189988a1a9esm1969681plf.135.2022.11.30.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:35:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:34:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] blk-throttle: Use more siutable time_after
 check for update of slice_start
Message-ID: <Y4fMg4Hnu3dDTjId@slm.duckdns.org>
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-10-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129030147.27400-10-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:01:46AM +0800, Kemeng Shi wrote:
> There is no need to update tg->slice_start[rw] to start when they are
> equal already. So remove "eq" part of check before update slice_start.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
