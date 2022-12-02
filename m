Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC763FD9D
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 02:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiLBBXA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 20:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiLBBW6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 20:22:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5A866C93
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 17:22:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6942163pjt.0
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 17:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfArFpI4a8R+b20KyasbiTdOtc7N2bQ1wdu7RJkkhko=;
        b=Cb8jMoLSfDnJGI9Pp33XdZXlJvDDfcMbz3oDrUJLziJarvhGWpFLrKZAAyoLNDVtvx
         jqO7+iWRdzqJYKLL+CyQgt6GEH8V/G2frXfIYxVeR+1FVT5B3jdhcvpTsUvVkUl0N3oD
         8TVFe40JPZgJ0fBFDt3dE7RRExTcSYjq2Qno38tbDtL2tX0VOwDTUgtoOE6hd8w0W9VZ
         n5ELhE8nZFhNtEkn0tPxZhAEjfHMWPsspeJVxt10lkJX4smRqMOpQRfgvF3CMr+YoMk6
         Ityq+JjMXg85AJcC/vWX5CPFwE/KMKTJPXVgvGeQGc1KyaArklIMAo8hRNPezrSGfNfk
         4j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfArFpI4a8R+b20KyasbiTdOtc7N2bQ1wdu7RJkkhko=;
        b=r+ARGLZ1KST1VGkAKbQ20j0HAbR+W5h23jhvO/3USX1BWoGalotrGUBbHuxVg2M/zS
         Soeu/tuGVidJA47tAIuThm3wDTg78VFSEwSOfEOTXjGno4FtsmybbyBthYwJBRKb51Fd
         0nv1YkMctRQlt30YUP9hlu9bCnUVcBEkcqjtYENRp2IxPcor9aKJGrdIa7pX2SKLFbys
         JFFgE9YD6Iihw0sSC72aehs2iPsXefkHbFXl+7iu6QO34d//KX7lKOr4xr4wGL1s19sU
         9hdKm2iBDwNASy/z1LDuQdWC8DGYw+7IxlF4COO6ceTumMTWt1S/u2dSXCzDwyiGu2MX
         1Yvg==
X-Gm-Message-State: ANoB5pl3Uc5mbbK5bjRRPmZzYaWOy+yolU/EYI66XkXdKkEZkaocsY7X
        8sAZ2zPshYyOU1D9RBX5jx2oFA==
X-Google-Smtp-Source: AA0mqf4SlVzbyxVzO55poMNBTlzJ3qqx67RwC/iohUq/55qYNicOtE463AWnygQojnZJv6xU4RxfoA==
X-Received: by 2002:a17:902:f7ca:b0:189:a884:1ea0 with SMTP id h10-20020a170902f7ca00b00189a8841ea0mr11088540plw.92.1669944175417;
        Thu, 01 Dec 2022 17:22:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b00189b2b8dbedsm2282448plh.228.2022.12.01.17.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:22:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
References: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] blk-cgroup: Fix some kernel-doc comments
Message-Id: <166994417436.875585.12360362062569377229.b4-ty@kernel.dk>
Date:   Thu, 01 Dec 2022 18:22:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Fri, 02 Dec 2022 09:17:13 +0800, Yang Li wrote:
> Make the description of @gendisk to @disk in blkcg_schedule_throttle()
> to clear the below warnings:
> 
> block/blk-cgroup.c:1850: warning: Function parameter or member 'disk' not described in 'blkcg_schedule_throttle'
> block/blk-cgroup.c:1850: warning: Excess function parameter 'gendisk' description in 'blkcg_schedule_throttle'
> 
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Fix some kernel-doc comments
      commit: 1d6df9d352bb2a3c2ddb32851dfcafb417c47762

Best regards,
-- 
Jens Axboe


