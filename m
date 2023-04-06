Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF786D9B36
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 16:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbjDFOw3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjDFOwN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 10:52:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D196B76D
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 07:51:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so43074185pjb.4
        for <cgroups@vger.kernel.org>; Thu, 06 Apr 2023 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsN7tdxypihrla/GoL2oV2FbQRrK9CjsAVFPGAuvGMk=;
        b=hNPXzmSIy/mxvyggQ3ydVzZKSJmXyokWxnfuXMrXOwox3waYSO9HkrwG/OUveIPAvb
         0K5NAGLjHQD+lM5P1nRRJVprnOaQL4Yhfr7DAOL0LM57bac3qiLBE+nZ9nlINlUQfvAl
         nd+qBy402VJeQOrbVrqxNZsJkIAV84N4iRmTdQI9H5+1HvIx8HAxnCon4Ba7mIVD947S
         Echo6XtpjPCS2sx+NwqR0Mr5flBYxeMj9uAbB2Jig4vvOEz2N6OUEuHaEZxxtThXRWG5
         WYNKwgpvc4oRkks7blCcpPDF6gXXQes14x/fCEhLVsH8qMuEejRxJuVeDKB+LyGPZMj0
         x1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsN7tdxypihrla/GoL2oV2FbQRrK9CjsAVFPGAuvGMk=;
        b=ATVu7tPhILDih4XyrWacBTOpRgrNVl05ja7ZQ7SUuxcnyewzwoIYOTMmwDboaRnxlf
         QMBSUkfANX+Kpl9hN25iHyreRbV54sLMJeBinAxWgNvZe0rT0hwkOrFODirunXtdjJrB
         gm12b099FSYIxbfkzoxWtT4n9OIjfcBjlTgUkR3Lam7T9b7cOFgJ0GRM6eaxlZTOQ+Uu
         IhOLLwCnasHgPg/C8OtwWzSIEA9TbQlLUgATwTyLeftiqSl6QW7MWvzh26zCSfVL/fBH
         8RZ8E26vz6m6eWEu7UGLddCm0vJ3sbNd8MSzzzoc8ZXi/oF5E8hidI/w7mA21hXeqWfr
         aW9Q==
X-Gm-Message-State: AAQBX9cGe8LVZIrHAeefpB9pdayHV0Lhld3fXjBluVlbH8RAFhx/GuUf
        ZrPU7JflNjiuCBnFU0Q48M1eyA==
X-Google-Smtp-Source: AKy350bG80qA6UgZFZIQWG7FVa/XWqHC70y/fiV8BLBfS2SIDCo6c3bZAJd6N7wRrR8QcqITiwzauQ==
X-Received: by 2002:a17:902:ced0:b0:19e:7a2c:78a7 with SMTP id d16-20020a170902ced000b0019e7a2c78a7mr12747837plg.57.1680792662798;
        Thu, 06 Apr 2023 07:51:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 0/3] blk-cgroup: some cleanup
Date:   Thu,  6 Apr 2023 22:50:47 +0800
Message-Id: <20230406145050.49914-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are some cleanup patches of blk-cgroup. Thanks for review.

v2:
 - Add Acked tags from Tejun.

Chengming Zhou (3):
  block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
  blk-cgroup: delete cpd_bind_fn of blkcg_policy
  blk-cgroup: delete cpd_init_fn of blkcg_policy

 block/bfq-cgroup.c  | 12 ++----------
 block/bfq-iosched.h |  1 -
 block/blk-cgroup.c  | 25 -------------------------
 block/blk-cgroup.h  |  2 --
 4 files changed, 2 insertions(+), 38 deletions(-)

-- 
2.39.2

