Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849D92FE48B
	for <lists+cgroups@lfdr.de>; Thu, 21 Jan 2021 09:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbhAUIBh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jan 2021 03:01:37 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42700 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727935AbhAUIBe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jan 2021 03:01:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UMPTiNr_1611216031;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMPTiNr_1611216031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 16:00:50 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] mm/memcontrol: remove redundant NULL check
Date:   Thu, 21 Jan 2021 16:00:29 +0800
Message-Id: <1611216029-34397-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix below warnings reported by coccicheck:
./mm/memcontrol.c:451:3-9: WARNING: NULL check before some freeing
functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 mm/memcontrol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671..f6a561b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -447,8 +447,7 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
 		map = rcu_dereference_protected(pn->shrinker_map, true);
-		if (map)
-			kvfree(map);
+		kvfree(map);
 		rcu_assign_pointer(pn->shrinker_map, NULL);
 	}
 }
-- 
1.8.3.1

