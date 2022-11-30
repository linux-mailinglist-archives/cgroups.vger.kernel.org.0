Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6763E2CB
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 22:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK3VeV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 16:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiK3VeV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 16:34:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB482900D3;
        Wed, 30 Nov 2022 13:34:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so18003629plb.2;
        Wed, 30 Nov 2022 13:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQaaCYRaH7FJdGcFxn1nAT6sve1WgBKeRZDBUjitAtQ=;
        b=ICKSZlXzxHqwLEwTb9STGr6dg5avLp4EIUiAtituFWz/GyAFIn0+Qxc2/p8Yn8Ti0w
         qs/34+Z6bPZG0earjXXvVoArsdkTrneZawYVPCK4ojZNhgZ0y3yoHXs63HZWl2r3RxSH
         nHWRT8dXAyaq373nWvTQD11RbltKqYaa2oRi1sWIErvMVX1Cen6SgXpST7DSvqHdW8nr
         k/7RUgeZJg0I/xx1pudIDUibzZxggIZ/vtcuCJCKdui658FAFlCLQ3Pqdy5t9MsQ/e+c
         LCcREScegfNOrfO3UMD3+lCJzKXLXcyE3LMJTK0pDDsTKP0WkaPIdRy3PJ7fVun9Mfv1
         hd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQaaCYRaH7FJdGcFxn1nAT6sve1WgBKeRZDBUjitAtQ=;
        b=SF1dCeTCSNiMBmC6v493hV7iUC96U2raCixHdVC+FcZwggTSpJ5bVLLPQEodMgGN1Y
         Txc3jWYJ07FpMYc7gCzZbIv5favHNEsd1Dzimrs+vBb7TjB+lUg4hdybxgOLtVlbmfdu
         IpmMjadOdFZyyFtQeDGK6jKdPj56dsb4uYF0OBsWT03TICKIO7kmKWufhxVzbTvJ0rr3
         xEpzIi6xWAR8xOOV98AFdv1o/ftfOjlIogruxqUYiIdmAK7hYgaywTFq8ydj3cGcPeoh
         QYJOoBWcX300m0f6VrUUFZQ5GQGV4ocVJNe3H7KB/nmxjGOlQQbpjdt79LF2b6hwvEVr
         dN3Q==
X-Gm-Message-State: ANoB5pnrcKxvm/Q2alDaOTSV+rXJo70FX1LC9AI+YV/oSKc6jqTWq/+H
        BTls/W2tHVK/3nQNwXog/n0=
X-Google-Smtp-Source: AA0mqf5oy7mBexIiWXuF3FYScra3qRf0FTmGsZnTTXKLX/NrnjE7Dal3KdoNkieEhu4ksjiONrFpbA==
X-Received: by 2002:a17:902:c652:b0:177:e4c7:e8b7 with SMTP id s18-20020a170902c65200b00177e4c7e8b7mr45522477pls.118.1669844060078;
        Wed, 30 Nov 2022 13:34:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m5-20020a63ed45000000b0047829d1b8eesm1376647pgk.31.2022.11.30.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:34:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:34:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] blk-throttle: remove repeat check of elapsed
 time from last upgrade in throtl_hierarchy_can_downgrade
Message-ID: <Y4fMWvr0PQXhJNNz@slm.duckdns.org>
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-9-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129030147.27400-9-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:01:45AM +0800, Kemeng Shi wrote:
> There is no need to check elapsed time from last upgrade for each node in
> hierarchy. Move this check before traversing as throtl_can_upgrade do
> to remove repeat check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
