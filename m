Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80687243BA
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 15:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbjFFNIB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Jun 2023 09:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjFFNIA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Jun 2023 09:08:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D075C170A;
        Tue,  6 Jun 2023 06:07:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb9f76BC7zLpwx;
        Tue,  6 Jun 2023 21:03:59 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 21:07:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup-v1: tweak the output format of cgroupstats
Date:   Tue, 6 Jun 2023 21:06:49 +0800
Message-ID: <20230606130649.485821-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The output of /proc/cgroups is somewhat awful now. For example, it may
look like below:

subsys_name	hierarchy	num_cgroups	enabled
cpuset	7	95	1
...
perf_event	6	1	1
...
files	10	1	1

Tweak the output format of cgroup stats to make it look better. After
patch applied, it will look like below:

subsys_name	hierarchy	num_cgroups	enabled
cpuset      	11       	73         	1
...
perf_event  	10       	1          	1
...
files       	7        	1          	1

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index aeef06c465ef..916871babeea 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -677,7 +677,7 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 */
 
 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
+		seq_printf(m, "%-12s\t%-9d\t%-11d\t%-7d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
-- 
2.27.0

