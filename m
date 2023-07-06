Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56E7498AD
	for <lists+cgroups@lfdr.de>; Thu,  6 Jul 2023 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjGFJm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jul 2023 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGFJmZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jul 2023 05:42:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54801727;
        Thu,  6 Jul 2023 02:42:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxWkP2wlGzTmH6;
        Thu,  6 Jul 2023 17:41:17 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 17:42:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: minor cleanup for cgroup_extra_stat_show()
Date:   Thu, 6 Jul 2023 17:42:42 +0800
Message-ID: <20230706094242.1707709-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
And further fetch cgrp inside cgroup_extra_stat_show() directly to rid
of __maybe_unused annotation of cgrp. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bfe3cd8ccf36..b990eda6b3cd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3654,9 +3654,10 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int __maybe_unused cgroup_extra_stat_show(struct seq_file *seq,
-						 struct cgroup *cgrp, int ssid)
+#ifdef CONFIG_CGROUP_SCHED
+static int cgroup_extra_stat_show(struct seq_file *seq, int ssid)
 {
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	struct cgroup_subsys *ss = cgroup_subsys[ssid];
 	struct cgroup_subsys_state *css;
 	int ret;
@@ -3672,15 +3673,15 @@ static int __maybe_unused cgroup_extra_stat_show(struct seq_file *seq,
 	css_put(css);
 	return ret;
 }
+#endif
 
 static int cpu_stat_show(struct seq_file *seq, void *v)
 {
-	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
 	int ret = 0;
 
 	cgroup_base_stat_cputime_show(seq);
 #ifdef CONFIG_CGROUP_SCHED
-	ret = cgroup_extra_stat_show(seq, cgrp, cpu_cgrp_id);
+	ret = cgroup_extra_stat_show(seq, cpu_cgrp_id);
 #endif
 	return ret;
 }
-- 
2.33.0

