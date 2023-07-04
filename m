Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E674705B
	for <lists+cgroups@lfdr.de>; Tue,  4 Jul 2023 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGDMEc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jul 2023 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGDMEc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jul 2023 08:04:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB9E7E;
        Tue,  4 Jul 2023 05:03:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QwLws1dBlzLmsg;
        Tue,  4 Jul 2023 20:01:17 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 20:03:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <longman@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
        <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup/cpuset: avoid unneeded cpuset_mutex re-lock
Date:   Tue, 4 Jul 2023 20:03:52 +0800
Message-ID: <20230704120352.1226787-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

cpuset_mutex unlock and lock pair is only needed when transferring tasks
out of empty cpuset. Avoid unneeded cpuset_mutex re-lock when !is_empty
to save cpu cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cpuset.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 601c40da8e03..e136269c152c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3521,17 +3521,16 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	mutex_unlock(&cpuset_mutex);
-
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
 	 * This is full cgroup operation which will also call back into
 	 * cpuset. Should be done outside any lock.
 	 */
-	if (is_empty)
+	if (is_empty) {
+		mutex_unlock(&cpuset_mutex);
 		remove_tasks_in_empty_cpuset(cs);
-
-	mutex_lock(&cpuset_mutex);
+		mutex_lock(&cpuset_mutex);
+	}
 }
 
 static void
-- 
2.33.0

