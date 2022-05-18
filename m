Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67052AFEC
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 03:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiERBcT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiERBcS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 21:32:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABFB33363
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 18:32:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 137so798874pgb.5
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xNnxAHcC3RUWM23wBpMAK8Y3L4EOTebAASEZluO85cE=;
        b=k2hnY/uiyT6WSSX6lxbaW0qn5bcT12bgoL8VXXked6tMGBGzLgQJs7Oe7Ys2h5K7Xf
         YEszS+nJLBhHDEwuXYcLnFJzch8DPZjWPY9KpBzu6Koq7N/fI8jXZQ79Qn8byopnFSmF
         1n2nhjhBwPqGgZjKgZYdpYRz1zPMlZwSvDmrXFXrhnDDPUQKtieYV2cOV7bGifIpJEez
         +pENNh/hdzYuWIFMlS/432DXZoE+hoqz+NKM2fEFmmAvZ6e98hrtoQYalbDp5llI91p1
         aOt8wgtCo/kWgg6DOOSx6Yw7WdvNHHC9bPkFPK9qa4B6H4POMyPPmkgIEuNtxlrisPLQ
         fAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xNnxAHcC3RUWM23wBpMAK8Y3L4EOTebAASEZluO85cE=;
        b=iracbJ6KJqdmZ7Ce5ds1dTWQWN2BtBHdxinqbnNa4K9KMcRKgM24bw0Qd3oGrN/PaI
         MzFrF9uev4X/37wlqNy5gSo7aBmxxSjtXUjNqFeb1rzFpQo4GbVNeVZEFQj/lvH13QQo
         qvHo9JP9fvI74+FrzilQEZ/XMblxozkA01usdfQpzPX7qEwICZicjRJvlZ8IsJx6/a5t
         NBOR/nOCRxvoVHyb1afVwR9R6Q1krr9o7xwc15M1A2NKHHmmbcqmdt4tP3FWupw/rg5R
         w9a4Auim6AfauYu7xhW2wMiu+jEbBmeJ1VE5JEQQ3WQYMdl8pB4eJZ5IC81+2oo9237G
         GUlg==
X-Gm-Message-State: AOAM5328U12VjrHVX71DXiIeKxkjK5NF5ATAfWbKoWqVecUglhbfOChq
        Q1etXBa12LBXkzprml9JjsblFhtE19obWA==
X-Google-Smtp-Source: ABdhPJyyDuelEUIgMnKTcepZxWuBNvDevo2UbPMfYVCqGTACvkXJz5NUXazb0suHLh1CYjIKrN/Iqw==
X-Received: by 2002:a63:dd14:0:b0:3d8:204c:2f29 with SMTP id t20-20020a63dd14000000b003d8204c2f29mr21542866pgg.512.1652837536250;
        Tue, 17 May 2022 18:32:16 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b00161946a7104sm253558plo.86.2022.05.17.18.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:32:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, qiulaibin@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220301123919.2381579-1-qiulaibin@huawei.com>
References: <20220301123919.2381579-1-qiulaibin@huawei.com>
Subject: Re: [PATCH -next v2] blk-throttle: Set BIO_THROTTLED when bio has been throttled
Message-Id: <165283753506.124778.6326413719734024023.b4-ty@kernel.dk>
Date:   Tue, 17 May 2022 19:32:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 1 Mar 2022 20:39:19 +0800, Laibin Qiu wrote:
> 1.In current process, all bio will set the BIO_THROTTLED flag
> after __blk_throtl_bio().
> 
> 2.If bio needs to be throttled, it will start the timer and
> stop submit bio directly. Bio will submit in
> blk_throtl_dispatch_work_fn() when the timer expires.But in
> the current process, if bio is throttled. The BIO_THROTTLED
> will be set to bio after timer start. If the bio has been
> completed, it may cause use-after-free blow.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Set BIO_THROTTLED when bio has been throttled
      commit: 5a011f889b4832aa80c2a872a5aade5c48d2756f

Best regards,
-- 
Jens Axboe


