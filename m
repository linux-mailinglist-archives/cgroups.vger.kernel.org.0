Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC1430DDA
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhJRCgS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Oct 2021 22:36:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14385 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhJRCgO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Oct 2021 22:36:14 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HXgmh2M9qz906X;
        Mon, 18 Oct 2021 10:29:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Mon, 18
 Oct 2021 10:34:02 +0800
From:   Zheng Liang <zhengliang6@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <paolo.valente@linaro.org>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <zhengliang6@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2] block, bfq: fix UAF problem in bfqg_stats_init()
Date:   Mon, 18 Oct 2021 10:42:25 +0800
Message-ID: <20211018024225.1493938-1-zhengliang6@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In bfq_pd_alloc(), the function bfqg_stats_init() init bfqg. If
blkg_rwstat_init() init bfqg_stats->bytes successful and init
bfqg_stats->ios failed, bfqg_stats_init() return failed, bfqg will
be freed. But blkg_rwstat->cpu_cnt is not deleted from the list of
percpu_counters. If we traverse the list of percpu_counters, It will
have UAF problem.

we should use blkg_rwstat_exit() to cleanup bfqg_stats bytes in the
above scenario.

Fixes: commit fd41e60331b ("bfq-iosched: stop using blkg->stat_bytes and ->stat_ios")
Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
---
Changes since v1:
    Change some description for this patch
---
 block/bfq-cgroup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e2f14508f2d6..243ffbc1f106 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -463,7 +463,7 @@ static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
 {
 	if (blkg_rwstat_init(&stats->bytes, gfp) ||
 	    blkg_rwstat_init(&stats->ios, gfp))
-		return -ENOMEM;
+		goto error;
 
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	if (blkg_rwstat_init(&stats->merged, gfp) ||
@@ -476,13 +476,15 @@ static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
 	    bfq_stat_init(&stats->dequeue, gfp) ||
 	    bfq_stat_init(&stats->group_wait_time, gfp) ||
 	    bfq_stat_init(&stats->idle_time, gfp) ||
-	    bfq_stat_init(&stats->empty_time, gfp)) {
-		bfqg_stats_exit(stats);
-		return -ENOMEM;
-	}
+	    bfq_stat_init(&stats->empty_time, gfp))
+		goto error;
 #endif
 
 	return 0;
+
+error:
+	bfqg_stats_exit(stats);
+	return -ENOMEM;
 }
 
 static struct bfq_group_data *cpd_to_bfqgd(struct blkcg_policy_data *cpd)
-- 
2.25.4

