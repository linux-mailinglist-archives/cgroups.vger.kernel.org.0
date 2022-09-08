Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5A5B162A
	for <lists+cgroups@lfdr.de>; Thu,  8 Sep 2022 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIHIBV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 04:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIHIBU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 04:01:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D49C16;
        Thu,  8 Sep 2022 01:01:19 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNWjj2CyvzHngv;
        Thu,  8 Sep 2022 15:59:21 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 16:01:16 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 16:01:16 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/memcontrol: use kstrtobool for swapaccount param parsing
Date:   Thu, 8 Sep 2022 16:34:52 +0800
Message-ID: <20220908083452.2844125-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use kstrtobool which is more powerful to handle all kinds of parameters
like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 ++++---
 mm/memcontrol.c                                 | 8 ++++----
 mm/swap_cgroup.c                                | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2434c6729f1c..5f8531e39bc9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6037,10 +6037,11 @@
 			Execution Facility on pSeries.
 
 	swapaccount=	[KNL]
-			Format: [0|1]
+			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 }
 			Enable accounting of swap in memory resource
-			controller if no parameter or 1 is given or disable
-			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
+			controller if no parameter or [oO][Nn]/Y/y/1 is given
+			or disable it if [oO][Ff]/N/n/0 is given
+			(See Documentation/admin-guide/cgroup-v1/memory.rst)
 
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
 			Format: { <int> [,<int>] | force | noforce }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0a1a8a846870..5511c0c120d9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7434,10 +7434,10 @@ bool mem_cgroup_swap_full(struct folio *folio)
 
 static int __init setup_swap_account(char *s)
 {
-	if (!strcmp(s, "1"))
-		cgroup_memory_noswap = false;
-	else if (!strcmp(s, "0"))
-		cgroup_memory_noswap = true;
+	bool res;
+
+	if (!kstrtobool(s, &res))
+		cgroup_memory_noswap = !res;
 	return 1;
 }
 __setup("swapaccount=", setup_swap_account);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 5a9442979a18..107dd0e94b01 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -194,7 +194,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	return 0;
 nomem:
 	pr_info("couldn't allocate enough memory for swap_cgroup\n");
-	pr_info("swap_cgroup can be disabled by swapaccount=0 boot option\n");
+	pr_info("swap_cgroup can be disabled by swapaccount=[oO][Ff]/N/n/0 boot option\n");
 	return -ENOMEM;
 }
 
-- 
2.25.1

