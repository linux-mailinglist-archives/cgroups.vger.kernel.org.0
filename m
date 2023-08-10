Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46517776E9
	for <lists+cgroups@lfdr.de>; Thu, 10 Aug 2023 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjHJL0o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Aug 2023 07:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjHJL0m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Aug 2023 07:26:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE4126BA
        for <cgroups@vger.kernel.org>; Thu, 10 Aug 2023 04:26:33 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM4NF1qP7zkXBQ;
        Thu, 10 Aug 2023 19:25:17 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.118) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 19:26:30 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>
CC:     Lu Jialin <lujialin4@huawei.com>, <cgroups@vger.kernel.org>
Subject: [PATCH] cgroup:namespace: Remove unused cgroup_namespaces_init()
Date:   Thu, 10 Aug 2023 11:25:28 +0000
Message-ID: <20230810112528.838797-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.118]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_namspace_init() just return 0. Therefore, there is no need to
call it during start_kernel. Just remove it.

Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 kernel/cgroup/namespace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 0d5c29879a50..144a464e45c6 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -149,9 +149,3 @@ const struct proc_ns_operations cgroupns_operations = {
 	.install	= cgroupns_install,
 	.owner		= cgroupns_owner,
 };
-
-static __init int cgroup_namespaces_init(void)
-{
-	return 0;
-}
-subsys_initcall(cgroup_namespaces_init);
-- 
2.34.1

