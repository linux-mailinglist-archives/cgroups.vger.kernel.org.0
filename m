Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F220663B2AA
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiK1T6f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 14:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiK1T61 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 14:58:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63302DABA;
        Mon, 28 Nov 2022 11:58:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 6so10902435pgm.6;
        Mon, 28 Nov 2022 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fW5pu/oGfiEsFMKGLZAHU+S02fDyBuhcJUqWHINL2qU=;
        b=mx86HuOzrzmHVFcBmkCrHteGNzM0udqe/N2eUm6fMH2MBbX1t4PmdhNn+tBat/L0ad
         cBZ+zD49RA1+ZK+Cc9Uph5opYzkQ0i4yGNCB/ET7oI9hRX3+qg2Zf7XLlemLJvGlt01z
         FAjBLe2U/tvLvC4pYTUMQSJf577RdcisPSatY6/7pfOuoVkQDFlwGvZcQEYeI+3Ex+Lv
         4qfGpvfTGHFCwuxsHQnbIm59Vq4YUuqQk/qWfk/C4OGA2oBCvAXFioZGj+sHUIHAOQRE
         sjslj73JFVvORreDotKaFGVo1vdffNYJEChWtP+VpUyKv5z4aG0vVzeuUQMrY9qZHaVQ
         lW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW5pu/oGfiEsFMKGLZAHU+S02fDyBuhcJUqWHINL2qU=;
        b=l0OyAo2Liy58Ipl9LL+3vih9mM0AqME2fLZMd50NfB+RdBP4z1Hg53DRqSt0kmLHtR
         8EJAe3LBMAiwIIEw47VFvFxvN2cZ7PS2y7RwZ6omIXn4i8aufPEcn+2fD7EK41jIJTYF
         uGEKE1AihP5UTCY4VAUrEZfF7CtTxH8vHsWKo/TMVfTCG0W7DHd01iZ5g9G9qB5Ba7Ui
         OT+TQj5z2TMCQivzlfIk8/14UwrZE7Wn7krQ+ot7uEOL25ZsF0tfBkNSNbGBlUl76yGC
         gcg7rv1uzC5ct1sNFDzgmxOzI38iH23g11umJEjZ0nmBqiiCuxWgwNlOC4lpSU98K69N
         OvIQ==
X-Gm-Message-State: ANoB5pljcWSvyAs0nv8SS0eV2P3ww0HxGwbsCOPpWmFmkvhpfFZcHSU4
        GinJl79YwyJeTMi8RXdGqZQ=
X-Google-Smtp-Source: AA0mqf4+3eTeelHiOphx4mGFDAToBKPFZ+PiffRH9fKb3FklhereSaV0NjfaAn5L56A5Bxv4pP/Bjw==
X-Received: by 2002:a05:6a00:410b:b0:56d:91d1:a903 with SMTP id bu11-20020a056a00410b00b0056d91d1a903mr34175954pfb.61.1669665500411;
        Mon, 28 Nov 2022 11:58:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902bf4b00b0017f7c4e260fsm9278717pls.150.2022.11.28.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:58:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Nov 2022 09:58:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] blk-iocost: fix shift-out-of-bounds in
 iocg_hick_delay()
Message-ID: <Y4US2vFmR4pnw08Z@slm.duckdns.org>
References: <20221128030413.882998-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128030413.882998-1-lijinlin3@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 28, 2022 at 11:04:13AM +0800, Li Jinlin wrote:
>  	/* calculate the current delay in effect - 1/2 every second */
>  	tdelta = now->now - iocg->delay_at;
>  	if (iocg->delay)
> -		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
> +		delay = iocg->delay >>
> +			min_t(u64, div64_u64(tdelta, USEC_PER_SEC), 63);

I replied earlier but the right thing to do here is setting delay to 0 if
the shift is >= 64.

Thanks.

-- 
tejun
