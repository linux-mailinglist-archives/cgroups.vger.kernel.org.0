Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE46E55A775
	for <lists+cgroups@lfdr.de>; Sat, 25 Jun 2022 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiFYGVA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 02:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiFYGU7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 02:20:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958C3BC9E;
        Fri, 24 Jun 2022 23:20:58 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LVP2j2DR7zkWXD;
        Sat, 25 Jun 2022 14:19:09 +0800 (CST)
Received: from ubuntu1604.huawei.com (10.67.174.160) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 14:20:54 +0800
From:   Xiang Yang <xiangyang3@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <songmuchun@bytedance.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <xiangyang3@huawei.com>
Subject: [PATCH -next] mm/memcontrol.c: replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled()
Date:   Sat, 25 Jun 2022 14:18:44 +0800
Message-ID: <20220625061844.226764-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_kmem_disabled() checks whether the kmem accounting is off.
Therefore, replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled(),
which is the same work in percpu.c and slab_common.c.

Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 85adc43c5a25..4672c9ddd188 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3815,7 +3815,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	if (cgroup_memory_nokmem)
+	if (mem_cgroup_kmem_disabled())
 		return 0;
 
 	if (unlikely(mem_cgroup_is_root(memcg)))
@@ -3830,7 +3830,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	if (cgroup_memory_nokmem)
+	if (mem_cgroup_kmem_disabled())
 		return;
 
 	if (unlikely(mem_cgroup_is_root(memcg)))
-- 
2.22.0

