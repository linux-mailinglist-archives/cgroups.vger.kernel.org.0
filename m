Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA647447CD
	for <lists+cgroups@lfdr.de>; Sat,  1 Jul 2023 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGAHij (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Jul 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGAHih (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Jul 2023 03:38:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA11199;
        Sat,  1 Jul 2023 00:38:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QtPCx4LL3zTknD;
        Sat,  1 Jul 2023 15:37:33 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 1 Jul
 2023 15:38:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: remove unneeded return value of cgroup_rm_cftypes_locked()
Date:   Sat, 1 Jul 2023 15:38:56 +0800
Message-ID: <20230701073856.2095425-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The return value of cgroup_rm_cftypes_locked() is always 0. So remove
it to simplify the code. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bfe3cd8ccf36..b0d98542eea2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4320,14 +4320,13 @@ static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 	return ret;
 }
 
-static int cgroup_rm_cftypes_locked(struct cftype *cfts)
+static void cgroup_rm_cftypes_locked(struct cftype *cfts)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
 	list_del(&cfts->node);
 	cgroup_apply_cftypes(cfts, false);
 	cgroup_exit_cftypes(cfts);
-	return 0;
 }
 
 /**
@@ -4343,8 +4342,6 @@ static int cgroup_rm_cftypes_locked(struct cftype *cfts)
  */
 int cgroup_rm_cftypes(struct cftype *cfts)
 {
-	int ret;
-
 	if (!cfts || cfts[0].name[0] == '\0')
 		return 0;
 
@@ -4352,9 +4349,9 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 		return -ENOENT;
 
 	cgroup_lock();
-	ret = cgroup_rm_cftypes_locked(cfts);
+	cgroup_rm_cftypes_locked(cfts);
 	cgroup_unlock();
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.33.0

