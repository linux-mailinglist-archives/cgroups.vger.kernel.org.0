Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D108013A8FF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 13:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgANMJy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 07:09:54 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24226 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANMJy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 07:09:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tnj2qd._1579003781;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tnj2qd._1579003781)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 20:09:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: remove for_each_e_css
Date:   Tue, 14 Jan 2020 20:09:32 +0800
Message-Id: <1579003772-46038-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After commit 37ff9f8f4742 ("cgroup: make cgroup[_taskset]_migrate()
take cgroup_r', No one use this macro.
So it'e better to remove.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/cgroup/cgroup.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..7d916ad33e59 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -663,21 +663,6 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
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
1.8.3.1

