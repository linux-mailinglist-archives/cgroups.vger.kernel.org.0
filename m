Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA838E3F5
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEXKZz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 06:25:55 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52488 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhEXKZz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 May 2021 06:25:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UZwEXTs_1621851864;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UZwEXTs_1621851864)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 18:24:25 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] mm: memcontrol: fix kernel-doc
Date:   Mon, 24 May 2021 18:24:22 +0800
Message-Id: <1621851862-34443-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix function name in mm/memcontrol.c kernel-doc comment
to remove a warning.

mm/memcontrol.c:6546: warning: expecting prototype for
mem_cgroup_protected(). Prototype was for
mem_cgroup_calculate_protection() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e..030c1dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6456,7 +6456,7 @@ static unsigned long effective_protection(unsigned long usage,
 }
 
 /**
- * mem_cgroup_protected - check if memory consumption is in the normal range
+ * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
-- 
1.8.3.1

