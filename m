Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173167C7ECA
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjJMHpC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjJMHpB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 03:45:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C4DC
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 00:44:59 -0700 (PDT)
Received: from dggpeml500015.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S6JMs3Qtqz1kv6J;
        Fri, 13 Oct 2023 15:40:57 +0800 (CST)
Received: from huawei.com (10.174.149.20) by dggpeml500015.china.huawei.com
 (7.185.36.226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 13 Oct
 2023 15:44:57 +0800
From:   Ruifeng Su <suruifeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <cgroups@vger.kernel.org>
Subject: [PATCH] mm, memcg: avoid recycling when there is no more recyclable memory
Date:   Fri, 13 Oct 2023 23:40:43 +0800
Message-ID: <20231013154043.1236185-1-suruifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.149.20]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500015.china.huawei.com (7.185.36.226)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the number of alloc anonymous pages exceeds the memory.high,
exc_page_fault successfully alloc code pages,
and is released by mem_cgroup_handle_over_high before return to user mode.
As a result, the program is trapped in a loop to exc page fault and reclaim
pages.

Here is an example of test code(do_alloc_memory is static compilation):
Execution Procedure:
	mkdir -p /sys/fs/cgroup/memory/memcg_high_A
	echo 50M > /sys/fs/cgroup/memory/memcg_high_A/memory.high
	cgexec -g memory:memcg_high_A ./common/do_alloc_memory anon 100M &
Phenomenon:
	[root@localhost memcg_high_A]# cat memory.usage_in_bytes
	53903360

The test result shows that the program frequently sync iCache & dcache.
As a result, 
the number of anon pages requested by the program cannot increase.

This patch changes the behavior of retry recycling.
As long as the number of successfully reclaimed pages is 
less than the target number of reclaimed pages,
memory reclamation exits, 
indicating that there is no more memory to reclaim directly.

Signed-off-by: Ruifeng Su <suruifeng1@huawei.com>
---
 mm/memcontrol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b009b233ab8..e6b5d2ddb4d2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2561,7 +2561,6 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	unsigned long pflags;
 	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
-	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
 	bool in_retry = false;
 
@@ -2616,7 +2615,7 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	 * memory.high, we want to encourage that rather than doing allocator
 	 * throttling.
 	 */
-	if (nr_reclaimed || nr_retries--) {
+	if (nr_reclaimed >= (in_retry ? SWAP_CLUSTER_MAX : nr_pages)) {
 		in_retry = true;
 		goto retry_reclaim;
 	}
-- 
2.33.0

