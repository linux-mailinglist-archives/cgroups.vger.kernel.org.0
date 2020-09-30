Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0187627E5B6
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3JzL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 05:55:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3JzL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Sep 2020 05:55:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4E394DBEC0FDEECB944F;
        Wed, 30 Sep 2020 17:55:09 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3] mm: memcontrol: reword obsolete comment of mem_cgroup_unmark_under_oom()
Date:   Wed, 30 Sep 2020 05:53:36 -0400
Message-ID: <20200930095336.21323-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 79dfdaccd1d5 ("memcg: make oom_lock 0 and 1 based rather than
counter"), the mem_cgroup_unmark_under_oom() is added and the comment of
the mem_cgroup_oom_unlock() is moved here.  But this comment make no sense
here because mem_cgroup_oom_lock() does not operate on under_oom field. So
we reword the comment as this would be helpful.
[Thanks Michal Hocko for rewording this comment.]

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6877c765b8d0..4f0c14cb8690 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1817,8 +1817,8 @@ static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
 	struct mem_cgroup *iter;
 
 	/*
-	 * When a new child is created while the hierarchy is under oom,
-	 * mem_cgroup_oom_lock() may not be called. Watch for underflow.
+	 * Be careful about under_oom underflows becase a child memcg
+	 * could have been added after mem_cgroup_mark_under_oom.
 	 */
 	spin_lock(&memcg_oom_lock);
 	for_each_mem_cgroup_tree(iter, memcg)
-- 
2.19.1

