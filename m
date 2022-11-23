Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB9635002
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiKWGEO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiKWGEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:04:10 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29833DB86F;
        Tue, 22 Nov 2022 22:04:07 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH9Y15C6xzmW6g;
        Wed, 23 Nov 2022 14:03:33 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:04:04 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 01/11] blk-throttle: Limit whole system if root group is configured when on the default hierarchy
Date:   Wed, 23 Nov 2022 14:03:51 +0800
Message-ID: <20221123060401.20392-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221123060401.20392-1-shikemeng@huawei.com>
References: <20221123060401.20392-1-shikemeng@huawei.com>
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

Quoted from comment in throtl_pd_init: "If on the default hierarchy, we
switch to properly hierarchical behavior where limits on a given
throtl_grp are applied to the whole subtree rather than just the group
itself. e.g. If 16M read_bps limit is set on the root group, the whole
system can' exceed 16M for the device."
Commit b22c417c885ea9 ("blk-throttle: configure bps/iops limit for
cgroup in low limit") broke this rule and did not explain why.
Restore the ability to limit the whole system by root group.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..96aa53e30e28 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -150,9 +150,6 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 	struct throtl_data *td;
 	uint64_t ret;
 
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
-		return U64_MAX;
-
 	td = tg->td;
 	ret = tg->bps[rw][td->limit_index];
 	if (ret == 0 && td->limit_index == LIMIT_LOW) {
@@ -180,9 +177,6 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	struct throtl_data *td;
 	unsigned int ret;
 
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
-		return UINT_MAX;
-
 	td = tg->td;
 	ret = tg->iops[rw][td->limit_index];
 	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
-- 
2.30.0

