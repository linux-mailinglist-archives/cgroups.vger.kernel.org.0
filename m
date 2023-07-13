Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6B7520FE
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjGMMPX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jul 2023 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjGMMPW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jul 2023 08:15:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78AC2D42;
        Thu, 13 Jul 2023 05:14:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R1tl30qWczLnhW;
        Thu, 13 Jul 2023 20:11:59 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 13 Jul
 2023 20:14:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>
CC:     <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/memcg: fix obsolete comment above MEM_CGROUP_MAX_RECLAIM_LOOPS
Date:   Thu, 13 Jul 2023 20:14:32 +0800
Message-ID: <20230713121432.273381-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 5660048ccac8 ("mm: move memcg hierarchy reclaim to generic
reclaim code"), mem_cgroup_hierarchical_reclaim() is already renamed to
mem_cgroup_soft_reclaim(). Update the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3eaeb69ef9f5..93e3cc581b51 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -197,7 +197,7 @@ static struct move_charge_struct {
 };
 
 /*
- * Maximum loops in mem_cgroup_hierarchical_reclaim(), used for soft
+ * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
  * limit reclaim to prevent infinite loops, if they ever occur.
  */
 #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
-- 
2.33.0

