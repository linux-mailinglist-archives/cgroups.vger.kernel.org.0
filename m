Return-Path: <cgroups+bounces-97-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAC7D8CD3
	for <lists+cgroups@lfdr.de>; Fri, 27 Oct 2023 03:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C771C20BE2
	for <lists+cgroups@lfdr.de>; Fri, 27 Oct 2023 01:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBB10F7;
	Fri, 27 Oct 2023 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67C10E9
	for <cgroups@vger.kernel.org>; Fri, 27 Oct 2023 01:34:40 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF31B6
	for <cgroups@vger.kernel.org>; Thu, 26 Oct 2023 18:34:38 -0700 (PDT)
Received: from dggpeml500015.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SGlWK4mvVz1L9FJ;
	Fri, 27 Oct 2023 09:31:41 +0800 (CST)
Received: from huawei.com (10.174.149.20) by dggpeml500015.china.huawei.com
 (7.185.36.226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 27 Oct
 2023 09:34:35 +0800
From: Ruifeng Su <suruifeng1@huawei.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <mhocko@kernel.org>,
	<roman.gushchin@linux.dev>, <hannes@cmpxchg.org>, <linmiaohe@huawei.com>,
	<suruifeng1@huawei.com>
Subject: [PATCH] mm, memcg: avoid recycling when there is no more recyclable memory
Date: Fri, 27 Oct 2023 17:30:04 +0800
Message-ID: <20231027093004.681270-1-suruifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.20]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500015.china.huawei.com (7.185.36.226)
X-CFilter-Loop: Reflected

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


