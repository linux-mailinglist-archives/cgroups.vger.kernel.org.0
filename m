Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4837BC13EC
	for <lists+cgroups@lfdr.de>; Sun, 29 Sep 2019 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfI2IWy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Sep 2019 04:22:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfI2IWy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 29 Sep 2019 04:22:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 138A8D7D4C8D755545CF;
        Sun, 29 Sep 2019 16:22:52 +0800 (CST)
Received: from huawei.com (10.175.104.217) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sun, 29 Sep 2019
 16:22:41 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linmiaohe@huawei.com>, <mingfangsen@huawei.com>
Subject: [PATCH] cgroup: short-circuit current_cgns_cgroup_from_root() on the default hierarchy
Date:   Sun, 29 Sep 2019 16:06:58 +0800
Message-ID: <20190929080658.11430-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.21.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.217]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Like commit 13d82fb77abb ("cgroup: short-circuit cset_cgroup_from_root() on
the default hierarchy"), short-circuit current_cgns_cgroup_from_root() on
the default hierarchy.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8be1da1ebd9a..b90c8b200aa2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1374,6 +1374,8 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 	cset = current->nsproxy->cgroup_ns->root_cset;
 	if (cset == &init_css_set) {
 		res = &root->cgrp;
+	} else if (root == &cgrp_dfl_root) {
+		res = cset->dfl_cgrp;
 	} else {
 		struct cgrp_cset_link *link;
 
-- 
2.21.GIT

