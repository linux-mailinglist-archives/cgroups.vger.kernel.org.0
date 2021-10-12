Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F52429B28
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJLBwP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 21:52:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23365 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhJLBwP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 21:52:15 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HSz5P4nqgzQjGB;
        Tue, 12 Oct 2021 09:45:45 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 12
 Oct 2021 09:50:12 +0800
From:   Zheng Liang <zhengliang6@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yanaijie@huawei.com>
Subject: [PATCH] block, bfq: fix UAF problem in bfqg_stats_init()
Date:   Tue, 12 Oct 2021 09:58:41 +0800
Message-ID: <20211012015841.233753-1-zhengliang6@huawei.com>
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
blkg_rwstat_init() init bytes successful and init ios failed,
bfqg_stats_init() return failed, bfqg will be freed. If we traverse
the list of percpu_counters, It will have use after free problem.

we should use blkg_rwstat_exit() to cleanup bfqg_stats bytes in the
above scenario.

Fixes: commit fd41e60331b ("bfq-iosched: stop using blkg->stat_bytes and ->stat_ios")
Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
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

