Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542BC2E76B8
	for <lists+cgroups@lfdr.de>; Wed, 30 Dec 2020 08:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL3HAT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Dec 2020 02:00:19 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53882 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgL3HAT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Dec 2020 02:00:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UKChRao_1609311552;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UKChRao_1609311552)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 14:59:34 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] mm: fix: Uninitialized variable ret.
Date:   Wed, 30 Dec 2020 14:59:11 +0800
Message-Id: <1609311551-97108-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The ret is being used but it isn't being initialized,
need to assign a value to it, like 0.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671..15ba17d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3366,7 +3366,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 {
 	bool enlarge = false;
 	bool drained = false;
-	int ret;
+	int ret = 0;
 	bool limits_invariant;
 	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
 
-- 
1.8.3.1

