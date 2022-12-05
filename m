Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989496427EE
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiLEL7i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 06:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiLEL7f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 06:59:35 -0500
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 03:59:31 PST
Received: from njjs-sys-mailin02.njjs.baidu.com (mx315.baidu.com [180.101.52.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99DBE034
        for <cgroups@vger.kernel.org>; Mon,  5 Dec 2022 03:59:31 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin02.njjs.baidu.com (Postfix) with ESMTP id 5A4211654004B;
        Mon,  5 Dec 2022 19:49:52 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 4601AD9932;
        Mon,  5 Dec 2022 19:49:52 +0800 (CST)
From:   lirongqing@baidu.com
To:     linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org
Subject: [PATCH] mm: memcontrol: speedup memory cgroup resize
Date:   Mon,  5 Dec 2022 19:49:52 +0800
Message-Id: <1670240992-28563-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

when resize memory cgroup, avoid to free memory cgroup page
one by one, and try to free needed number pages once

same to emtpy a memory cgroup memory

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/memcontrol.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..86993d055d86 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3464,6 +3464,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	bool drained = false;
 	int ret;
 	bool limits_invariant;
+	unsigned long nr_pages;
 	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
 
 	do {
@@ -3498,7 +3499,13 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 			continue;
 		}
 
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+		nr_pages = page_counter_read(counter);
+
+		if (nr_pages > max)
+			nr_pages = nr_pages - max;
+		else
+			nr_pages = 1;
+		if (!try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
 					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
 			ret = -EBUSY;
 			break;
@@ -3598,6 +3605,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
 	int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned long nr_pages;
 
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
@@ -3605,11 +3613,11 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 	drain_all_stock(memcg);
 
 	/* try to free all pages in this cgroup */
-	while (nr_retries && page_counter_read(&memcg->memory)) {
+	while (nr_retries && (nr_pages = page_counter_read(&memcg->memory))) {
 		if (signal_pending(current))
 			return -EINTR;
 
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+		if (!try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
 						  MEMCG_RECLAIM_MAY_SWAP))
 			nr_retries--;
 	}
-- 
2.27.0

