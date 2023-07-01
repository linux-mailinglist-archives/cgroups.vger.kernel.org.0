Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5174476E
	for <lists+cgroups@lfdr.de>; Sat,  1 Jul 2023 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGAG4S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Jul 2023 02:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGAGza (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Jul 2023 02:55:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11539423B;
        Fri, 30 Jun 2023 23:50:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QtN966WN7zqSKb;
        Sat,  1 Jul 2023 14:50:02 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 1 Jul
 2023 14:50:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <longman@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
        <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup/cpuset: update parent subparts cpumask while holding css refcnt
Date:   Sat, 1 Jul 2023 14:50:49 +0800
Message-ID: <20230701065049.1758266-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

update_parent_subparts_cpumask() is called outside RCU read-side critical
section without holding extra css refcnt of cp. In theroy, cp could be
freed at any time. Holding extra css refcnt to ensure cp is valid while
updating parent subparts cpumask.

Fixes: d7c8142d5a55 ("cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58e6f18f01c1..632a9986d5de 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		cpuset_for_each_child(cp, css, parent)
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
+				if (!css_tryget_online(&cp->css))
+					continue;
 				rcu_read_unlock();
 				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
 				rcu_read_lock();
+				css_put(&cp->css);
 			}
 		rcu_read_unlock();
 		retval = 0;
-- 
2.33.0

