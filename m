Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7D63B85F
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiK2DB4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiK2DBx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C3303F3;
        Mon, 28 Nov 2022 19:01:52 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCq75GNzRpVS;
        Tue, 29 Nov 2022 11:01:11 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:49 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 00/10] A few bugfix and cleanup patches for blk-throttle
Date:   Tue, 29 Nov 2022 11:01:37 +0800
Message-ID: <20221129030147.27400-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, this series contain a few patches to fix problem when on the default
hierarchy, corrent comment and so on. More detail can be found in
respective changelogs. Thanks.

---
V1->V2:
 -Thanks for the review and advice from Tejun. The corrected comment of
  "blk-throttle: correct stale comment in throtl_pd_init" and the
  solution of "blk-throttle: Fix that bps of child could exceed bps
  limited in parent" are from reply of Tejun.
 -Collect Ack from Tejun.
 -Fix the compile problem when CONFIG_BLK_DEV_THROTTLING_LOW is set.
 -Drop "blk-throttle: Limit whole system if root group is configured
  when on the default hierarchy", "blk-throttle: remove unnecessary check
  for validation of limit index" and "blk-throttle: remove unused variable
  td in tg_update_has_rules"
 -Add "blk-throttle: correct stale comment in throtl_pd_init" and
  "blk-throttle: avoid dead code in throtl_hierarchy_can_upgrade"
 -Use solution that set the BIO_BPS_THROTTLED flag only when the bio
  traversed the entire tree to fix that bps of child could exceed bps
  limited in parent in patch 2/10.
 -Improve the description and comment of most commits.
---

Kemeng Shi (10):
  blk-throttle: correct stale comment in throtl_pd_init
  blk-throttle: Fix that bps of child could exceed bps limited in parent
  blk-throttle: ignore cgroup without io queued in
    blk_throtl_cancel_bios
  blk-throttle: correct calculation of wait time in tg_may_dispatch
  blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
  blk-throttle: fix typo in comment of throtl_adjusted_limit
  blk-throttle: remove incorrect comment for tg_last_low_overflow_time
  blk-throttle: remove repeat check of elapsed time from last upgrade in
    throtl_hierarchy_can_downgrade
  blk-throttle: Use more siutable time_after check for update of
    slice_start
  blk-throttle: avoid dead code in throtl_hierarchy_can_upgrade

 block/blk-throttle.c | 104 +++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

-- 
2.30.0

