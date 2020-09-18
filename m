Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5993626F8C7
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 10:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIRI6o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 04:58:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgIRI6o (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 04:58:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42DAB29796FAA4D95A1E;
        Fri, 18 Sep 2020 16:58:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 16:58:32 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>
CC:     <linuxarm@huawei.com>, <cgroups@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] cgroup: Fix a comment in function cgroup_wq_init()
Date:   Fri, 18 Sep 2020 16:54:52 +0800
Message-ID: <1600419292-191248-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Use function workqueue_init() instead of init_workqueues() which
is not used in kernel.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd24774..c34b03d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5784,7 +5784,7 @@ static int __init cgroup_wq_init(void)
 	 * Use 1 for @max_active.
 	 *
 	 * We would prefer to do this in cgroup_init() above, but that
-	 * is called before init_workqueues(): so leave this until after.
+	 * is called before workqueue_init(): so leave this until after.
 	 */
 	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 1);
 	BUG_ON(!cgroup_destroy_wq);
-- 
2.8.1

