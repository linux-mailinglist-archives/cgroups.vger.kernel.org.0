Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395BD602B8B
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJRMTl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Oct 2022 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJRMTi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Oct 2022 08:19:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367962E6;
        Tue, 18 Oct 2022 05:19:36 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsCWj2dWHzpVhF;
        Tue, 18 Oct 2022 20:16:17 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:19:34 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
Date:   Tue, 18 Oct 2022 20:19:27 +0800
Message-ID: <20221018121932.10792-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series contain a few patch to correct comment, correct trace of
vtime_rate and so on. More detail can be found in the respective
changelogs.

---
v2:
 Thanks Tejun for review and comment!
 Add Acked-by tag from Tejun.
 Correct description in patch 3/5 and 4/5.
 Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
== iocg->active"
 Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
 Drop "blk-iocost: Get ioc_now inside weight_updated"
---

Kemeng Shi (5):
  blk-iocost: Fix typo in comment
  blk-iocost: Reset vtime_base_rate in ioc_refresh_params
  blk-iocost: Trace vtime_base_rate instead of vtime_rate
  blk-iocost: Remove vrate member in struct ioc_now
  blk-iocost: Correct comment in blk_iocost_init

 block/blk-iocost.c            | 16 +++++++++-------
 include/trace/events/iocost.h |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.30.0

