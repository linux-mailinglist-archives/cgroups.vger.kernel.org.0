Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5369065DFB8
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 23:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjADWQW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 17:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjADWQU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 17:16:20 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA46DF62;
        Wed,  4 Jan 2023 14:16:19 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q9so6282763pgq.5;
        Wed, 04 Jan 2023 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moYSPHE+ptO3fAO4T89FF5ZIPNcPkGMhods8Wk+acgw=;
        b=IAM5Dmd4MW6BIb12ZqVe6jaKnPSKH3m9/N6nt+o7KrcNeFFY6Q3yJyzPzuWxDK97kZ
         XLyKTKIjdetwusXLk3Ze7VgwckVk27NKnK0dCNdOhH4RTnVYZFKe8meBnb9VU8Jab/m8
         yvSp68B+IgePhe25pq3fOVkX7xHzpvlSu52i/rxuzmqL31MgslkP3YENdfKSFPFn5mOJ
         2dVI+8Her4rJWcBC3Rfw7qq3IVqZt8owEFH+NvVpw9QFgaEa9+n4tdx9gq1ir4ux1Afs
         z80kd+pIJLc5cJyq8Rhz2TlsoMXJp62UuEV6mbRwJRFMarvGYE5aMukxJZaEsclVnUm+
         OwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moYSPHE+ptO3fAO4T89FF5ZIPNcPkGMhods8Wk+acgw=;
        b=DgjfWRsG91MOgWGD46cxcbMh98efTPxD4pJ/L4vlDO2ItP+De7PuPy9NAP7rHfQOHs
         xp3VHRTrIamFRBUjEzX//sP7yusGnntiCPvj8KUo3qyPb4Z1fVBVUjGV7e4hb5WkaMJq
         YJInVayLqZKYrIH4wmJaaorAPS/jzNxtcLpPBKr1P3gTQH7W7xk+ytF3gA2C49OA08zg
         sFRIguXmmyXvOQDMt5CJygYPzcrXb2NtGfygruy4B78nn/8jhTm+mIPcoG3oaA72ANKE
         VKFK9PudFtJ5EvdCTuzc7NE+JsSqRbp4lolclr8OfE/yJtWyR848ODN3JYZLQtaUZmjZ
         T8gw==
X-Gm-Message-State: AFqh2koro5OcP+BBjR+3frXMpezppxGDQbI4gw3poTOak6yfbP+eY6lj
        DD4o4PaKchqufT91huCptw0=
X-Google-Smtp-Source: AMrXdXtVO+VMhEiqLE2ebwhlx0e/aBa+054Iu2BTtMtePlUuhiCzqlumjH9uhoP+9AalARe3Z01spg==
X-Received: by 2002:a05:6a00:1485:b0:575:b783:b6b3 with SMTP id v5-20020a056a00148500b00575b783b6b3mr66618306pfu.28.1672870578617;
        Wed, 04 Jan 2023 14:16:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b20-20020aa79514000000b00581c4b4c15bsm12746070pfp.142.2023.01.04.14.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:16:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 12:16:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: don't make all constants unsigned long long
Message-ID: <Y7X6sUDLe2CrPk8H@slm.duckdns.org>
References: <20221220201819.1497577-1-ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220201819.1497577-1-ydroneaud@opteya.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 20, 2022 at 09:18:19PM +0100, Yann Droneaud wrote:
> My shiny new compiler (GCC 13) is reporting the following
> warnings:
> 
>   ../block/blk-iocost.c: In function 'ioc_weight_prfill':
>   ../block/blk-iocost.c:3035:37: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
>    3035 |                 seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
>         |                                    ~^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                     |                             |
>         |                                     unsigned int                  long unsigned int
>         |                                    %lu
>   ../block/blk-iocost.c: In function 'ioc_weight_show':
>   ../block/blk-iocost.c:3045:34: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
>    3045 |         seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
>         |                                 ~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                  |                      |
>         |                                  unsigned int           long unsigned int
>         |                                 %lu
> 
> It appears WEIGHT_ONE enum is unnecessarly unsigned long
> (or unsigned long long on 32bit) because of VTIME_PER_SEC
> and/or AUTOP_CYCLE_NSEC need the enum to be that large.
> 
> Addressed by lazy splitting the "catch all" anonymous
> enum and placing the unsigned long long constants in
> their own anonymous enums.
> 
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>

There's a better patch doing this which groups the enums into two groups.
Let's do that instead.

Thanks.

-- 
tejun
