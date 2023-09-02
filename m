Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18DC7906D9
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351912AbjIBJNZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjIBJNZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 05:13:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927939F;
        Sat,  2 Sep 2023 02:13:21 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rd8JR3q4XzVk8J;
        Sat,  2 Sep 2023 17:10:47 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 2 Sep
 2023 17:13:17 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] mm, memcg: expose swapcache stat for memcg v1
Date:   Sat, 2 Sep 2023 18:07:28 +0800
Message-ID: <20230902100728.3850149-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit b6038942480e ("mm: memcg: add swapcache stat for memcg v2")
adds swapcache stat for the cgroup v2, it seems there is no reason to
hide it in memcg v1. Conversely, with swapcached it is more accurate to
evaluate the available memory for memcg.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 1 +
 mm/memcontrol.c                                | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index fabaad3fd9c2..fb4abe0dc228 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -546,6 +546,7 @@ memory.stat file includes following statistics:
                     event happens each time a page is unaccounted from the
                     cgroup.
     swap            # of bytes of swap usage
+    swapcached      # of bytes of swap cached in memory
     dirty           # of bytes that are waiting to get written back to the disk.
     writeback       # of bytes of file/anon cache that are queued for syncing to
                     disk.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c465829db92b..619acf479be7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4068,6 +4068,9 @@ static const unsigned int memcg1_stats[] = {
 	WORKINGSET_REFAULT_ANON,
 	WORKINGSET_REFAULT_FILE,
 	MEMCG_SWAP,
+#ifdef CONFIG_SWAP
+	NR_SWAPCACHE,
+#endif
 };
 
 static const char *const memcg1_stat_names[] = {
@@ -4083,6 +4086,9 @@ static const char *const memcg1_stat_names[] = {
 	"workingset_refault_anon",
 	"workingset_refault_file",
 	"swap",
+#ifdef CONFIG_SWAP
+	"swapcached",
+#endif
 };
 
 /* Universal VM events cgroup1 shows, original sort order */
-- 
2.25.1

