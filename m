Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771DD9DE9D
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2019 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfH0HV0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Aug 2019 03:21:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfH0HV0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Aug 2019 03:21:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D927B75A98B991A4FDC5;
        Tue, 27 Aug 2019 15:21:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 15:21:14 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <cgroups@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Tejun Heo <tj@kernel.org>, "Li Zefan" <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [RESEND PATCH] cgroup: Remove unused for_each_e_css macro and comment
Date:   Tue, 27 Aug 2019 15:19:01 +0800
Message-ID: <1566890341-38158-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

'for_each_e_css' macro became unused after commit <37ff9f8f4742>
("cgroup: make cgroup[_taskset]_migrate() take cgroup_root instead of
cgroup").
Remove it and its comment.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 kernel/cgroup/cgroup.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e43cbcfd7b78..9e4cf8ba206f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -663,21 +663,6 @@ EXPORT_SYMBOL_GPL(of_css);
 		else
 
 /**
- * for_each_e_css - iterate all effective css's of a cgroup
- * @css: the iteration cursor
- * @ssid: the index of the subsystem, CGROUP_SUBSYS_COUNT after reaching the end
- * @cgrp: the target cgroup to iterate css's of
- *
- * Should be called under cgroup_[tree_]mutex.
- */
-#define for_each_e_css(css, ssid, cgrp)					    \
-	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	    \
-		if (!((css) = cgroup_e_css_by_mask(cgrp,		    \
-						   cgroup_subsys[(ssid)]))) \
-			;						    \
-		else
-
-/**
  * do_each_subsys_mask - filter for_each_subsys with a bitmask
  * @ss: the iteration cursor
  * @ssid: the index of @ss, CGROUP_SUBSYS_COUNT after reaching the end
-- 
2.7.4

