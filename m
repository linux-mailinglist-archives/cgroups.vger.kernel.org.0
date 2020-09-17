Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25926D9C0
	for <lists+cgroups@lfdr.de>; Thu, 17 Sep 2020 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIQLBI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 07:01:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgIQLAd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 17 Sep 2020 07:00:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F39CFD5A10E084A1EA4;
        Thu, 17 Sep 2020 19:00:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 19:00:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm: memcontrol: remove obsolete comment of mem_cgroup_unmark_under_oom()
Date:   Thu, 17 Sep 2020 06:59:00 -0400
Message-ID: <20200917105900.4337-1-linmiaohe@huawei.com>
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
the mem_cgroup_oom_unlock() is moved here. But this comment make no sense
here because mem_cgroup_oom_lock() does not operate on under_oom field.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cd5f83de9a6f..e44f5afaf78b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1848,10 +1848,6 @@ static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *iter;
 
-	/*
-	 * When a new child is created while the hierarchy is under oom,
-	 * mem_cgroup_oom_lock() may not be called. Watch for underflow.
-	 */
 	spin_lock(&memcg_oom_lock);
 	for_each_mem_cgroup_tree(iter, memcg)
 		if (iter->under_oom > 0)
-- 
2.19.1

