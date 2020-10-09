Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A63288A0C
	for <lists+cgroups@lfdr.de>; Fri,  9 Oct 2020 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbgJINvW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Oct 2020 09:51:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732456AbgJINvW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 9 Oct 2020 09:51:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4CAA0C8C8E38F4713939;
        Fri,  9 Oct 2020 21:51:20 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 21:51:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm: memcontrol: eliminate redundant check in __mem_cgroup_insert_exceeded()
Date:   Fri, 9 Oct 2020 09:51:04 -0400
Message-ID: <20201009135104.39048-1-linmiaohe@huawei.com>
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
equally.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..f607afd0fcbf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -629,7 +629,7 @@ static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 		 * We can't avoid mem cgroups that are over their soft
 		 * limit by the same amount
 		 */
-		else if (mz->usage_in_excess >= mz_node->usage_in_excess)
+		else
 			p = &(*p)->rb_right;
 	}
 
-- 
2.19.1

