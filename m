Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9C4F92D8
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiDHK0a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Apr 2022 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiDHK03 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Apr 2022 06:26:29 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41422EB07;
        Fri,  8 Apr 2022 03:24:16 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 238ANXnU038992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 8 Apr 2022 18:23:33 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 8 Apr 2022 18:23:34 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <ke.wang@unisoc.com>
Subject: [PATCH] cgroup: fix attach task fail when subtree_control configured
Date:   Fri, 8 Apr 2022 18:23:14 +0800
Message-ID: <1649413394-17501-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 238ANXnU038992
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

It is found that task attach to a vacant cgroup will fail when its
subtree_control has been configured. Fix it by judging if there is no chrildren
existed.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/cgroup/cgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194d..f00583b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2561,6 +2561,9 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
  */
 int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
 {
+	struct cgroup_subsys_state *css = &dst_cgrp->self;
+	struct list_head *children = &css->children;
+
 	/* v1 doesn't have any restriction */
 	if (!cgroup_on_dfl(dst_cgrp))
 		return 0;
@@ -2581,7 +2584,7 @@ int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
 		return 0;
 
 	/* apply no-internal-process constraint */
-	if (dst_cgrp->subtree_control)
+	if (dst_cgrp->subtree_control && !list_empty(children))
 		return -EBUSY;
 
 	return 0;
-- 
1.9.1

