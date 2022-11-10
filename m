Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F4F623C30
	for <lists+cgroups@lfdr.de>; Thu, 10 Nov 2022 07:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKJG5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Nov 2022 01:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiKJG5H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Nov 2022 01:57:07 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D42F38F;
        Wed,  9 Nov 2022 22:57:06 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N7CHG4qjLzJnZY;
        Thu, 10 Nov 2022 14:54:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 14:57:04 +0800
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 14:57:04 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     Lu Jialin <lujialin4@huawei.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] mm/memcontrol.c: drains percpu charge caches in memory.reclaim
Date:   Thu, 10 Nov 2022 14:53:16 +0800
Message-ID: <20221110065316.67204-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When user use memory.reclaim to reclaim memory, after drain percpu lru
caches, drain percpu charge caches for given memcg stock in the hope
of introducing more evictable pages.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 mm/memcontrol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..768091cc6a9a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6593,10 +6593,13 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 		/*
 		 * This is the final attempt, drain percpu lru caches in the
 		 * hope of introducing more evictable pages for
-		 * try_to_free_mem_cgroup_pages().
+		 * try_to_free_mem_cgroup_pages(). Also, drain all percpu
+		 * charge caches for given memcg.
 		 */
-		if (!nr_retries)
+		if (!nr_retries) {
 			lru_add_drain_all();
+			drain_all_stock(memcg);
+		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						nr_to_reclaim - nr_reclaimed,
-- 
2.17.1

