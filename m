Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2126C37F
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIPOCv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 10:02:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbgIPNlI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 16 Sep 2020 09:41:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F550FB1E2A1D7A9514B;
        Wed, 16 Sep 2020 21:20:54 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 21:20:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm: memcontrol: correct the comment of mem_cgroup_unmark_under_oom()
Date:   Wed, 16 Sep 2020 09:19:27 -0400
Message-ID: <20200916131927.11340-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit fb2a6fc56be6 ("mm: memcg: rework and document OOM waiting and
wakeup"), we have renamed mem_cgroup_oom_lock to mem_cgroup_oom_trylock. So
replace mem_cgroup_oom_lock with mem_cgroup_oom_trylock in comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3d26b4b954e2..702aa4d7ebbc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1846,7 +1846,7 @@ static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
 
 	/*
 	 * When a new child is created while the hierarchy is under oom,
-	 * mem_cgroup_oom_lock() may not be called. Watch for underflow.
+	 * mem_cgroup_oom_trylock() may not be called. Watch for underflow.
 	 */
 	spin_lock(&memcg_oom_lock);
 	for_each_mem_cgroup_tree(iter, memcg)
-- 
2.19.1

