Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99264E959E
	for <lists+cgroups@lfdr.de>; Mon, 28 Mar 2022 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiC1LrZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Mar 2022 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiC1Lpc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Mar 2022 07:45:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC05AA7F;
        Mon, 28 Mar 2022 04:41:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KRrP11mQDz1GD9b;
        Mon, 28 Mar 2022 19:40:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Mar
 2022 19:41:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/memcg: remove unneeded nr_scanned
Date:   Mon, 28 Mar 2022 19:41:44 +0800
Message-ID: <20220328114144.53389-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The local variable nr_scanned is unneeded as mem_cgroup_soft_reclaim always
does *total_scanned += nr_scanned. So we can pass total_scanned directly to
the mem_cgroup_soft_reclaim to simplify the code and save some cpu cycles
of adding nr_scanned to total_scanned.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b686ec4f42c6..79341365ec90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3384,7 +3384,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	int loop = 0;
 	struct mem_cgroup_tree_per_node *mctz;
 	unsigned long excess;
-	unsigned long nr_scanned;
 
 	if (order > 0)
 		return 0;
@@ -3412,11 +3411,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		if (!mz)
 			break;
 
-		nr_scanned = 0;
 		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
-						    gfp_mask, &nr_scanned);
+						    gfp_mask, total_scanned);
 		nr_reclaimed += reclaimed;
-		*total_scanned += nr_scanned;
 		spin_lock_irq(&mctz->lock);
 		__mem_cgroup_remove_exceeded(mz, mctz);
 
-- 
2.23.0

