Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72556A2E00
	for <lists+cgroups@lfdr.de>; Sun, 26 Feb 2023 04:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBZDz7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Feb 2023 22:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBZDzl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Feb 2023 22:55:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B71714E;
        Sat, 25 Feb 2023 19:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE416B80956;
        Sun, 26 Feb 2023 03:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7FDC433D2;
        Sun, 26 Feb 2023 03:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677383053;
        bh=LE6Cuxh0N4Eej+KJKmepjRL+51JfrcQnW1JJGA9cAOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PM0CfhWT1wXNddcyFftkUKX74V3kaxax7cb5ZeGtCyCxwAZo27ZmSia3L6Ogj3SEV
         bPv31BxBvVRzwlIGuvs7+/oBLsogrVJIDm43gnFM+qwiZBKMg8/YZCLEWfVGvmdJoN
         95yYXAZRQDhv3mL82x5U6V0BTwYVGlf2uf4fSwo5X7RiRNsDigN17Dgh2Qk97miLLl
         WwwHa5CU7qjymp7BpCuPvJLUAoq7Elf3Gdw//WA6rgNz1FpPEsovoREwk25mPXbELX
         nZWy32sDIYfKlHvZr8y/X7OvxFiYA8xLu0Bzi2A3Ctqy8akLj4ky66SURfEyUo5SLZ
         2XX6FnTq1qz9Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Nan <linan122@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/5] blk-iocost: fix divide by 0 error in calc_lcoefs()
Date:   Sat, 25 Feb 2023 22:44:06 -0500
Message-Id: <20230226034408.774670-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230226034408.774670-1-sashal@kernel.org>
References: <20230226034408.774670-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit 984af1e66b4126cf145153661cc24c213e2ec231 ]

echo max of u64 to cost.model can cause divide by 0 error.

  # echo 8:0 rbps=18446744073709551615 > /sys/fs/cgroup/io.cost.model

  divide error: 0000 [#1] PREEMPT SMP
  RIP: 0010:calc_lcoefs+0x4c/0xc0
  Call Trace:
   <TASK>
   ioc_refresh_params+0x2b3/0x4f0
   ioc_cost_model_write+0x3cb/0x4c0
   ? _copy_from_iter+0x6d/0x6c0
   ? kernfs_fop_write_iter+0xfc/0x270
   cgroup_file_write+0xa0/0x200
   kernfs_fop_write_iter+0x17d/0x270
   vfs_write+0x414/0x620
   ksys_write+0x73/0x160
   __x64_sys_write+0x1e/0x30
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

calc_lcoefs() uses the input value of cost.model in DIV_ROUND_UP_ULL,
overflow would happen if bps plus IOC_PAGE_SIZE is greater than
ULLONG_MAX, it can cause divide by 0 error.

Fix the problem by setting basecost

Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230117070806.3857142-5-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fb8f959a7f327..9255b642d6adb 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -872,9 +872,14 @@ static void calc_lcoefs(u64 bps, u64 seqiops, u64 randiops,
 
 	*page = *seqio = *randio = 0;
 
-	if (bps)
-		*page = DIV64_U64_ROUND_UP(VTIME_PER_SEC,
-					   DIV_ROUND_UP_ULL(bps, IOC_PAGE_SIZE));
+	if (bps) {
+		u64 bps_pages = DIV_ROUND_UP_ULL(bps, IOC_PAGE_SIZE);
+
+		if (bps_pages)
+			*page = DIV64_U64_ROUND_UP(VTIME_PER_SEC, bps_pages);
+		else
+			*page = 1;
+	}
 
 	if (seqiops) {
 		v = DIV64_U64_ROUND_UP(VTIME_PER_SEC, seqiops);
-- 
2.39.0

