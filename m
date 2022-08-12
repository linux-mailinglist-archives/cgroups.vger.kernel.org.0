Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE3590ECA
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiHLKKh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiHLKKg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 06:10:36 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1338DF0;
        Fri, 12 Aug 2022 03:10:33 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 27CA9VAe044276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 12 Aug 2022 18:09:31 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 12 Aug 2022 18:09:31 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <ke.wang@unisoc.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [RFC PATCH] cgroup: use root_mem_cgroup as css when current is not enabled
Date:   Fri, 12 Aug 2022 18:09:26 +0800
Message-ID: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 27CA9VAe044276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Memory charged on group B abserved on belowing v2 hierarchy where we just would
like to only have group E's memory be controlled and B's descendants compete freely
for memory. This should be the consequences of unified hierarchy. Solve this by
have the cgroup without valid memory css alloced use root_mem_cgroup instead of
its ancestor's.

 A(subtree_control = memory) - B(subtree_control = NULL) - C()
                                                         \ D()
			     - E(subtree_control = memory) - F()
							   \ G()

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/cgroup/cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccd..b29b3f6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -533,6 +533,14 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
 	 * can't test the csses directly.  Test ss_mask.
 	 */
 	while (!(cgroup_ss_mask(cgrp) & (1 << ss->id))) {
+		/*
+		 * charging to the parent cgroup which hasn't distribute
+		 * memory control to its descendants doesn't make sense
+		 * especially on cgroup v2, where the parent could be configured
+		 * to use memory controller as its sibling want to use it
+		 */
+		if (memory_cgrp_id == ss->id)
+			return &root_mem_cgroup->css;
 		cgrp = cgroup_parent(cgrp);
 		if (!cgrp)
 			return NULL;
-- 
1.9.1

