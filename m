Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE96A5971
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjB1Mv7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Feb 2023 07:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjB1Mv5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Feb 2023 07:51:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709E2CC53
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 04:51:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l1so9704477pjt.2
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677588715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6bVcZFE0HqAVo8qfWn/M3ByKpGU6+Lc1KXSuspx5lo=;
        b=uBP8y0KEudDm9buTiNU2aHEUByfTEd7uJJX36ri4HmxFFsoYkiHFJzReJ3mx75gVYV
         WTPbKyBnhRr2eJ8Rt0vUlSvHSnJ+Di21agCQTonnedhxrLQGKyMLs9xl7sNWrQKwhW8F
         147/0/iHd9r1v6l5igLC90stz9n9ezHoTzvRO5fGOnF/OyfR0EsRFFWbhvbH5HtzyREf
         WU9x2yz4/qD86Mxh1f29lyE6PMayDvH9RaIkuWfMilM6pr/VMfYWKQ6dOSLtK3k4Ghzz
         gxnFm8gFw2dm1rsgeMyd3C5HpfmZ2JmWheE3g8p34giU36F/QsznGLcYKIkjj5Q1JlAn
         CKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677588715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6bVcZFE0HqAVo8qfWn/M3ByKpGU6+Lc1KXSuspx5lo=;
        b=MFjSoTk1mSqCPxCfXs5vbN27I13Zh2DAAj3PI6bCC/fXqQkfa6MfPAuEv1gkZ8dfMh
         Mt4O5Ll5pfJRp2ZMeX2Coo3weUhy4Wf9/RlDLPOKBb0+bJuiQRLAffkldtTVPCbOnfjt
         +MIwtoAvUWd04B8ngFkhSN8QNZE3IaIX0MYGIwfBq+bjgNlt6CHeMyLm1sdkrfXmII1G
         3DiV+FbOawoFUkc/VeeXrZZE+fwoURiaEsX/huga90BzM3clodRTXjUVNRROUPNB9KG0
         ZU6Yt7L5UlbXAG8MpLAp+d5OpJ7LoiQI75Ddqk0elFYV3Xyw+xX273iLUa9/gqxZzCuQ
         AW5A==
X-Gm-Message-State: AO0yUKWMuCcdTnVp7hab2auqQgz2Bg3gdFAuM1oxVFSRKQTKwlb0A602
        qeJr2Q1dPcAwfhAXku4KRk68frcqkjreb8nz
X-Google-Smtp-Source: AK7set/xsX6KTOkXV5tn/4bDglX2Xm+IGdT2/LnSExXMtV/Q2AL5gxeZWwAyHV0xvvCRT8fmWCOUsQ==
X-Received: by 2002:a17:902:e74e:b0:19a:a815:2864 with SMTP id p14-20020a170902e74e00b0019aa8152864mr2879368plf.4.1677588714985;
        Tue, 28 Feb 2023 04:51:54 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b00198e397994bsm6486540pls.136.2023.02.28.04.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 04:51:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, Breno Leitao <leitao@debian.org>
Cc:     aherrmann@suse.de, linux-kernel@vger.kernel.org, hch@lst.de,
        leit@fb.com
In-Reply-To: <20230228111654.1778120-1-leitao@debian.org>
References: <20230228111654.1778120-1-leitao@debian.org>
Subject: Re: [PATCH v4] blk-iocost: Pass gendisk to ioc_refresh_params
Message-Id: <167758871388.8785.9077411400332712392.b4-ty@kernel.dk>
Date:   Tue, 28 Feb 2023 05:51:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Tue, 28 Feb 2023 03:16:54 -0800, Breno Leitao wrote:
> Current kernel (d2980d8d826554fa6981d621e569a453787472f8) crashes
> when blk_iocost_init for `nvme1` disk.
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000050
> 	#PF: supervisor read access in kernel mode
> 	#PF: error_code(0x0000) - not-present page
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Pass gendisk to ioc_refresh_params
      commit: e33b93650fc5364f773985a3e961e24349330d97

Best regards,
-- 
Jens Axboe



