Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FF974E455
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 04:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGKCi0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 22:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGKCiY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 22:38:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2AE4D;
        Mon, 10 Jul 2023 19:38:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R0Q3M64vxzPk5Y;
        Tue, 11 Jul 2023 10:35:59 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 10:38:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <sfr@canb.auug.org.au>,
        <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED
Date:   Tue, 11 Jul 2023 10:38:20 +0800
Message-ID: <20230711023820.3854596-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED to fix the warning
of 'cgroup_tryget_css' defined but not used [-Wunused-function] when
CONFIG_CGROUP_SCHED is disabled.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b990eda6b3cd..46401157028e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -492,28 +492,6 @@ static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
 		return &cgrp->self;
 }
 
-/**
- * cgroup_tryget_css - try to get a cgroup's css for the specified subsystem
- * @cgrp: the cgroup of interest
- * @ss: the subsystem of interest
- *
- * Find and get @cgrp's css associated with @ss.  If the css doesn't exist
- * or is offline, %NULL is returned.
- */
-static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
-						     struct cgroup_subsys *ss)
-{
-	struct cgroup_subsys_state *css;
-
-	rcu_read_lock();
-	css = cgroup_css(cgrp, ss);
-	if (css && !css_tryget_online(css))
-		css = NULL;
-	rcu_read_unlock();
-
-	return css;
-}
-
 /**
  * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
  * @cgrp: the cgroup of interest
@@ -3655,6 +3633,28 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_CGROUP_SCHED
+/**
+ * cgroup_tryget_css - try to get a cgroup's css for the specified subsystem
+ * @cgrp: the cgroup of interest
+ * @ss: the subsystem of interest
+ *
+ * Find and get @cgrp's css associated with @ss.  If the css doesn't exist
+ * or is offline, %NULL is returned.
+ */
+static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
+						     struct cgroup_subsys *ss)
+{
+	struct cgroup_subsys_state *css;
+
+	rcu_read_lock();
+	css = cgroup_css(cgrp, ss);
+	if (css && !css_tryget_online(css))
+		css = NULL;
+	rcu_read_unlock();
+
+	return css;
+}
+
 static int cgroup_extra_stat_show(struct seq_file *seq, int ssid)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-- 
2.33.0

