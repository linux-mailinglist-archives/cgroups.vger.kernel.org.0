Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C084BB9E9
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiBRNN7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 08:13:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiBRNN6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 08:13:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD941CAF7E
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 05:13:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so12333762pja.3
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GK4rz9+seFn4xdxHvPLjlObHSp4PzOJAfGpbgOOGnDc=;
        b=X0yxpy0FpsFY7ZLcYL/hyLZTcm0tOjEZLx7X2m/1SjWaDiXAxsGjQ3/RVtMsybX1vD
         eUM4FKRSXHyTu2bsmY9dXOfKtxk6g8ka27l8MYEVjuweCvpCSeUW4UzRXSCnZQQ+pfIU
         JtbpenlRpDiplHlpX+TUFxxs2aOg+dZC2RxDFoAFK3kmkY9FunGo9ockke4UU8MM+gJZ
         2I2LNOuslQVGnctx/w+Zpz3/8yTUFqzfahTN9FFImDypH63XrQHgLszBX8NNBFm0tnew
         Xymx+whVxA8NHk7ooSDbJrHQRFalkm53OPCNNXS8CLisZbMRgXl4JQ5lnZqqPzngJpJK
         S9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GK4rz9+seFn4xdxHvPLjlObHSp4PzOJAfGpbgOOGnDc=;
        b=o8KTTshsWKVsJPTl2/7RjKnN33Z6TZSiOYwO83GyMyGO3tsy0GvWA+jPyAqmu1EhaB
         hprYFKUmZLIwq8coA7ok3Sj4qXatWacGmDz2KAK/cFCl8xBlW5WkpljE6YG7OS7NDX3o
         MiVcNeg0JsezlvAh7UCZi8+6Btu94Cw0y823Q0y6QBv18O0CMw1B9JK8cEKEyRkdObeN
         GWMLLfXMKGusLSg5lxP9ClCU1PR7MPZMqhJAmSjq1d5npabPpzorF2bL9wpv2Md+d82b
         rznmRYzPjPjYM24CpThrCQ6cyQzGLtYbJuYhvLKANqon/O6OSQ+KtRKwuvWCismHe9o7
         ZMVA==
X-Gm-Message-State: AOAM530xBXZtFSuzP7ckTN3nVwgk+eiWamrvtRBEbmp0zktsrocgO5lw
        XPVjXbDgYf6PZW7l32a9ElrYSA==
X-Google-Smtp-Source: ABdhPJxVEuInQM8ER6sR1lK2pIrJ6V0BG+s8JKZCjXNLjuXxYDSIzxEnjHU8F7msAcnMf1oHw8AiAg==
X-Received: by 2002:a17:902:b116:b0:14f:460d:bf42 with SMTP id q22-20020a170902b11600b0014f460dbf42mr7500903plr.108.1645190021985;
        Fri, 18 Feb 2022 05:13:41 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8sm3179025pfu.55.2022.02.18.05.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:13:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, Yu Kuai <yukuai3@huawei.com>,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20220129015924.3958918-1-yukuai3@huawei.com>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
Subject: Re: [PATCH v3 0/3] block, bfq: minor cleanup and fix
Message-Id: <164519002068.11187.11125581863819344403.b4-ty@kernel.dk>
Date:   Fri, 18 Feb 2022 06:13:40 -0700
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

On Sat, 29 Jan 2022 09:59:21 +0800, Yu Kuai wrote:
> Changes in v3:
>  - fix a clerical error in patch 2
> 
> Chagnes in v2:
>  - add comment in patch 2
>  - remove patch 4, since the problem do not exist.
> 
> [...]

Applied, thanks!

[1/3] block, bfq: cleanup bfq_bfqq_to_bfqg()
      commit: 43a4b1fee098bd38eed9c334d0e0df221ecdf719
[2/3] block, bfq: avoid moving bfqq to it's parent bfqg
      commit: c5e4cb0fcbbaa5ad853818c4a2383e9bd147fad6
[3/3] block, bfq: don't move oom_bfqq
      commit: 8410f70977734f21b8ed45c37e925d311dfda2e7

Best regards,
-- 
Jens Axboe


