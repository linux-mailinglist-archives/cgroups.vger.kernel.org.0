Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A981D28B5D8
	for <lists+cgroups@lfdr.de>; Mon, 12 Oct 2020 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgJLNQ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Oct 2020 09:16:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388013AbgJLNQ1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 12 Oct 2020 09:16:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7413DE0DD3DA402645AC;
        Mon, 12 Oct 2020 21:16:24 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 12 Oct 2020
 21:16:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm: memcontrol: eliminate redundant check in __mem_cgroup_insert_exceeded()
Date:   Mon, 12 Oct 2020 09:16:07 -0400
Message-ID: <20201012131607.10656-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The mz->usage_in_excess >= mz_node->usage_in_excess check is exactly the
else case of mz->usage_in_excess < mz_node->usage_in_excess. So we could
replace else if (mz->usage_in_excess >= mz_node->usage_in_excess) with else
equally. Also drop the comment which doesn't really explain much.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..b080a9434b9e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -623,14 +623,9 @@ static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 		if (mz->usage_in_excess < mz_node->usage_in_excess) {
 			p = &(*p)->rb_left;
 			rightmost = false;
-		}
-
-		/*
-		 * We can't avoid mem cgroups that are over their soft
-		 * limit by the same amount
-		 */
-		else if (mz->usage_in_excess >= mz_node->usage_in_excess)
+		} else {
 			p = &(*p)->rb_right;
+		}
 	}
 
 	if (rightmost)
-- 
2.19.1

