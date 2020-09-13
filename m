Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25254267EF8
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIMJmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 05:42:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgIMJmz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 13 Sep 2020 05:42:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB749B5481E1115E4EE8;
        Sun, 13 Sep 2020 17:42:52 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sun, 13 Sep 2020
 17:42:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm: memcontrol: Correct the comment of mem_cgroup_iter()
Date:   Sun, 13 Sep 2020 05:41:29 -0400
Message-ID: <20200913094129.44558-1-linmiaohe@huawei.com>
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

Since commit bbec2e15170a ("mm: rename page_counter's count/limit into
usage/max"), the arg @reclaim has no priority field anymore.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..a57aa0f42d40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1138,9 +1138,9 @@ static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
  * invocations for reference counting, or use mem_cgroup_iter_break()
  * to cancel a hierarchy walk before the round-trip is complete.
  *
- * Reclaimers can specify a node and a priority level in @reclaim to
- * divide up the memcgs in the hierarchy among all concurrent
- * reclaimers operating on the same node and priority.
+ * Reclaimers can specify a node in @reclaim to divide up the memcgs
+ * in the hierarchy among all concurrent reclaimers operating on the
+ * same node.
  */
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
-- 
2.19.1

