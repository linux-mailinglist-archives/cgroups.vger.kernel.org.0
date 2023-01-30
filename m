Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4956803FF
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 04:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjA3DET (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Jan 2023 22:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjA3DES (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Jan 2023 22:04:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B31BAE1
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 19:04:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h9so1604671plf.9
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ6yrQ8QtaF+R4KmbpHk9smJ4moMIfGYvuFm4fbV6sc=;
        b=UdmzHx0zsT7cWmAEfDg3Pvx9yJhOEKanG2EXeWgIdwce6Me6hEj2X4Fd/tukd5ugfa
         FP8S2r8lRPk1z5J5+VNGZxevrDVZ8hQQdBJkU1iCQOR4utbSuqvR6HoRSZI2huRh4iam
         erL4WKX3HEIiS/TnXDYPpDECgAmeFH8NxvxllsjTRNjSmpTW+v9LwOv3TC8bUrjszDAJ
         u+Trn4UyXbDfGqreWnCbe1E+3d0xrMh65MNPOHIyxeeMlf0khBlc4yST/M43zxSEAthC
         Nj5R1sg3OZQHWW5i49QdXUrRAQvkNATID2IOHf0C+hEQ7/EIW7AcbqIX0pmP0yWArtJz
         xh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ6yrQ8QtaF+R4KmbpHk9smJ4moMIfGYvuFm4fbV6sc=;
        b=wGk3v9uIEZKYbwUAGMMNZn4f+5uDwM3rl6tbn5Vji8+r/80FyVmMi8g5ftNZRwCEA+
         zMM3tx0ihKtXHtLNKk0CReiLzEYHL+A4i7bnaJoocWnEoU8ZfK8zbcJ1TqfmYOfdb6iI
         CgdfLQovxh3Zb37DuV2+WIgKeU+mCV0/zEw1/gsFxtlloOfU3sWZopYwvEAmFT4w2K76
         Z34a0xyY8UoXzg76dxFm9/ZLCoZAQnk/D8Dyiir6j/lFIzSaXpPk7WBfrSPKmflWGsPl
         e/fmmTUKu17qHWmDaJo6Kd8MlFCaKT/frvwA06Q8LT1s92cjQnve2Ea0VPfElf5YF/By
         ASig==
X-Gm-Message-State: AFqh2kpmOibq8onQqeopbdkmq0UPlWDQJzOVyaZO5DEBYpMP3uV62LRZ
        aVRnq97268M1C5OM8ypqvDSmIc1Ns4xFYIpK
X-Google-Smtp-Source: AMrXdXtNC0YC4yCuWmeGwlvLEC/vsMCLN4G3Xe7itukdLDlq37sr1l45AqKpaL+PAvHwwcRna1KmGg==
X-Received: by 2002:a17:90a:af91:b0:226:df9a:969c with SMTP id w17-20020a17090aaf9100b00226df9a969cmr11145645pjq.0.1675047857186;
        Sun, 29 Jan 2023 19:04:17 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b004d3f518eea7sm5667103pgd.94.2023.01.29.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:04:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, paolo.valente@linaro.org,
        yukuai3@huawei.com, jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20230130014136.591038-1-yukuai1@huaweicloud.com>
References: <20230130014136.591038-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 block-6.2] block, bfq: fix uaf for bfqq in
 bic_set_bfqq()
Message-Id: <167504785585.199828.6199773692964530920.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 20:04:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Mon, 30 Jan 2023 09:41:36 +0800, Yu Kuai wrote:
> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
> bic->bfqq will be freed, and bic_set_bfqq() is called with the freed
> bic->bfqq.
> 
> Fix the problem by always freeing bfqq after bic_set_bfqq().
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix uaf for bfqq in bic_set_bfqq()
      (no commit info)

Best regards,
-- 
Jens Axboe



