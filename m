Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08774720E77
	for <lists+cgroups@lfdr.de>; Sat,  3 Jun 2023 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjFCHVa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Jun 2023 03:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFCHV3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Jun 2023 03:21:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3041180;
        Sat,  3 Jun 2023 00:21:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QYB7Y07PXztQbQ;
        Sat,  3 Jun 2023 15:19:05 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 15:21:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <akpm@linux-foundation.org>
CC:     <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] memcg: use helper macro FLUSH_TIME
Date:   Sat, 3 Jun 2023 15:21:16 +0800
Message-ID: <20230603072116.1101690-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Use helper macro FLUSH_TIME to indicate the flush time to improve the
readability a bit. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d8569594239c..f204c9f2e69c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5397,7 +5397,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
-				   2UL*HZ);
+				   FLUSH_TIME);
 	lru_gen_online_memcg(memcg);
 	return 0;
 offline_kmem:
-- 
2.27.0

