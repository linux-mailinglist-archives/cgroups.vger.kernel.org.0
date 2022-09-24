Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835525E8DA3
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIXPAO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Sep 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIXPAN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 24 Sep 2022 11:00:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6832922BC5
        for <cgroups@vger.kernel.org>; Sat, 24 Sep 2022 08:00:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 78so2771046pgb.13
        for <cgroups@vger.kernel.org>; Sat, 24 Sep 2022 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=/ZxmoZGavmWNlrZnawkbXveh01Wn367vmE/VNkXmIdw=;
        b=s25ZCs1tSDwZADqqqf1Vm4xt2zv7eMrlkQYv4xQaqPF3mPJzzvhB2mzxAqxPkb32pK
         NHAqqy/qx4pNcfeO5zqFmmWF2ufBVP1cOVbbxVTdLQvPTSHxLDM+xweoWGa34eoy6rDG
         dyyruF1ntIIDA6CvCIvQDTZADmji0DJAHX5s0Vhfrhdfq4gt11Qo5ttrdt7FnYlOgmiM
         g8G3lY1JxPY4sBzH8MwvY9x6UDIuc8ekZ8AqGfJh5wk+r/EmtPVkEnjYkiP/kHjK9ETv
         OYDkJBXcuZFyiUKv4Aw+s8K/uMug7rbzVAcHajZOqT5eH86LKpfotHSrJsWWt7a+AOji
         zcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/ZxmoZGavmWNlrZnawkbXveh01Wn367vmE/VNkXmIdw=;
        b=K3pivkSe8eeichdhxTblPXtEad6oYQr0cUwzRSX7V2dP08hCMf5OG/mc5Kjq3NSOyq
         IAX98LnfRsKwHa/su+ruWtzlXUX4Gh+uNPVQvAfLMleFzcfM1zTI5/Bs7LQXi15/sNVi
         EE4fBnYeuIJrjmqsdeoaAN6UivJ3KwzfHyypdX0xajqszWyGLNR/Tdp6SBhsjlJ6BnIK
         fDxvTSkH75V0gK37NP6Tse3IZUdYTz4JGzls5/Bx3S8eqJcktFaui1s8T1w2fcPKqQsd
         AsGrRrQthLN1aqO9BbzbQmq9QgRbem8mI3bVCfHasz3iOkMx0Ix8Y/8kEZ134SNPcxmu
         JmWA==
X-Gm-Message-State: ACrzQf2Zigq5vCtkj63uZSq+OElvudN5ysF+04SFvDIOg867OTjVgfVT
        VHTHLVvydoc1CUgYW4BnZDakWQ==
X-Google-Smtp-Source: AMsMyM5+ef+aw0XcysL1aexhvPjDjgsey9VsVY7POoHb/1mlXyhvyLCmIyCeSI3bLtHy1j0OgNAhEA==
X-Received: by 2002:a63:5d48:0:b0:43a:390b:2183 with SMTP id o8-20020a635d48000000b0043a390b2183mr12204841pgm.29.1664031611841;
        Sat, 24 Sep 2022 08:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902760100b0017870f471f6sm7848200pll.226.2022.09.24.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:00:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
In-Reply-To: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
References: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH 0/2] blk-throttle: improve bypassing bios checkings
Message-Id: <166403161084.5171.274436515046613194.b4-ty@kernel.dk>
Date:   Sat, 24 Sep 2022 09:00:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 21 Sep 2022 17:53:07 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, "tg->has_rules" and "tg->flags & THROTL_TG_HAS_IOPS_LIMIT"
> both try to bypass bios that don't need to be throttled, however, they are
> a little redundant and both not perfect:
> 
> 1) "tg->has_rules" only distinguish read and write, but not iops and bps
>    limit.
> 2) "tg->flags & THROTL_TG_HAS_IOPS_LIMIT" only check if iops limit
>    exist, read and write is not distinguished, and bps limit is not
>    checked.
> 
> [...]

Applied, thanks!

[1/2] blk-throttle: remove THROTL_TG_HAS_IOPS_LIMIT
      commit: 85496749904016f36b69332f73a1cf3ecfee828f
[2/2] blk-throttle: improve bypassing bios checkings
      commit: 81c7a63abc7c0be572b4f853e913ce93a34f6e1b

Best regards,
-- 
Jens Axboe


