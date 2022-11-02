Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B346161E7
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 12:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKBLoM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBLoL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 07:44:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C3112A88;
        Wed,  2 Nov 2022 04:44:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so16019384pgb.6;
        Wed, 02 Nov 2022 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VSLHjqdkw/lLw+IqVBVeV4frjHysXQc6H/q1PnMBziA=;
        b=V8OgDZyvdcJnZupe2Ih2PUPQBXDrkTugSKD0mh8FYzx31VWzihmqZIx3wPnc4CtVya
         YUsipfsbEY7IFhg/BU25qKcIz/sHBf2srmJsPqI6kIGQbGdoqEQgI6d14Y93RX5okhmT
         Hw0MmHKjSyAx1BeDv72ENX/BL7kZ1wypFPpMjA1L7/lEG9bUIJ57KUICOwOX1RRGg7Nz
         st/LMiypd1okKkKVzvSSlt6yeSkq+xY/YuWhIs0jSK8eDBV6D8L8WSV8vE1QGHPoUVGa
         kcsLiYLmLbgWjZAQd2V+Sl7m6olQhCWEkgwEokDxMtYzWUrddHtkzmDXm5dSfVLD/HK2
         bnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSLHjqdkw/lLw+IqVBVeV4frjHysXQc6H/q1PnMBziA=;
        b=DHFxl9Hq8aEy8OkfU7pOdx8ww++92WqA6RR5sRMq7tRwaXqdibsqk6FUdfJD1ugKmz
         XOYsZ49vYxA2JxQXC+qto5tscQLaXvLeiCWON7pcAzhus33EZTCuQSOjuiEccx4EMxda
         DHfOtM9oYGH8GFJY3+/KhVpNw9qVaBs0wbG5NYNm9OZ2TBh+EDDBfGwU93pa+aKG58Sv
         npAgdksMmGfhgh2OHrpeiSek2N7yU06PoNb6h5h7YlPoi9d9jP8jGSIdgh7cAHX53zOc
         ft0YLTBX6CZq/VirhHPSg/uAv9ZhNgtMpo+ryjO6/9UITFnXfi+SF6b6+QtbS5YefCR6
         gSYQ==
X-Gm-Message-State: ACrzQf3cQYdt01NgAf76bdGFPzCqgJTlY4onTYugzWXSF8P74C6GmgLI
        u4f7Bp57/LbzD+JatL5U0xw=
X-Google-Smtp-Source: AMsMyM6bVyK8tWrlSEYT8I8W08FZ5gGHo4fIpXCL6QEZvyPcq7X8nnwkyV6iWPzrh7/DdQXz7cxlsA==
X-Received: by 2002:a05:6a00:1ac6:b0:56d:919b:f4a1 with SMTP id f6-20020a056a001ac600b0056d919bf4a1mr13203205pfv.50.1667389446189;
        Wed, 02 Nov 2022 04:44:06 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00172e19c5f8bsm8169978plh.168.2022.11.02.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:44:05 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 0/5] Some cleanup patches for block bfq
Date:   Wed,  2 Nov 2022 19:43:49 +0800
Message-Id: <20221102114354.162-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

This series contains some cleanup patches for block bfq.

Yuwei Guan (5):
  block, bfq: remove unnecessary meta_pending count
  block, bfq: remove unused bfq_log_bfqg
  block, bfq: remove redundant max_t() in bfq_bfqq_charge_time()
  block, bfq: change type for "prio_changed"
  block, bfq: change type for "bfq_large_burst_thresh"

 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 27 ++++++++++-----------------
 block/bfq-iosched.h | 12 ++----------
 block/bfq-wf2q.c    |  5 ++---
 4 files changed, 15 insertions(+), 31 deletions(-)

-- 
2.34.1

