Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F178875DFC1
	for <lists+cgroups@lfdr.de>; Sun, 23 Jul 2023 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGWDTr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 22 Jul 2023 23:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWDTq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 22 Jul 2023 23:19:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330F10CA;
        Sat, 22 Jul 2023 20:19:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R7pPL6zp3zHnVL;
        Sun, 23 Jul 2023 11:17:10 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 11:19:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
Date:   Sun, 23 Jul 2023 11:19:32 +0800
Message-ID: <20230723031932.3152951-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
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

Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
called when CONFIG_CGROUP_SCHED. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup.c | 63 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 31603146e7c2..7296331c7582 100644
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
@@ -3686,8 +3686,9 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
-static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
-						 struct cgroup *cgrp, int ssid)
+#ifdef CONFIG_CGROUP_SCHED
+static int cgroup_local_stat_show(struct seq_file *seq,
+				  struct cgroup *cgrp, int ssid)
 {
 	struct cgroup_subsys *ss = cgroup_subsys[ssid];
 	struct cgroup_subsys_state *css;
@@ -3707,14 +3708,16 @@ static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
 
 static int cpu_local_stat_show(struct seq_file *seq, void *v)
 {
-	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
-	int ret = 0;
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
 
-#ifdef CONFIG_CGROUP_SCHED
-	ret = cgroup_local_stat_show(seq, cgrp, cpu_cgrp_id);
-#endif
-	return ret;
+	return cgroup_local_stat_show(seq, cgrp, cpu_cgrp_id);
+}
+#else
+static int cpu_local_stat_show(struct seq_file *seq, void *v)
+{
+	return 0;
 }
+#endif
 
 #ifdef CONFIG_PSI
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
-- 
2.33.0

