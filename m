Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EF357DC2
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 10:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhDHIEH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 04:04:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15967 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHIEE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 04:04:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGDHR1mXZzyNhH;
        Thu,  8 Apr 2021 16:01:39 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 16:03:43 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>
CC:     Lu Jialin <lujialin4@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: fix typos in comments
Date:   Thu, 8 Apr 2021 16:03:46 +0800
Message-ID: <20210408080346.166046-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change hierachy to hierarchy and unrechable to unreachable,
no functionality changed.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 kernel/cgroup/cpuset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5258b68153e0..a945504c0ae7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -585,7 +585,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 
 	par = parent_cs(cur);
 
-	/* On legacy hiearchy, we must be a subset of our parent cpuset. */
+	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
 	ret = -EACCES;
 	if (!is_in_v2_mode() && !is_cpuset_subset(trial, par))
 		goto out;
@@ -1726,7 +1726,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
  * When configured nodemask is changed, the effective nodemasks of this cpuset
  * and all its descendants need to be updated.
  *
- * On legacy hiearchy, effective_mems will be the same with mems_allowed.
+ * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  *
  * Called with cpuset_mutex held
  */
@@ -2500,7 +2500,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 		BUG();
 	}
 
-	/* Unrechable but makes gcc happy */
+	/* Unreachable but makes gcc happy */
 	return 0;
 }
 
-- 
2.17.1

