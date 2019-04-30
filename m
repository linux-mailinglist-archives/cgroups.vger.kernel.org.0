Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F86F396
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfD3J6x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Apr 2019 05:58:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfD3J6w (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Apr 2019 05:58:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87431EC95546CF99DAEF;
        Tue, 30 Apr 2019 17:58:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Apr 2019 17:58:40 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <cgroups@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH -next] cgroup: Remove unused cgrp variable
Date:   Tue, 30 Apr 2019 17:57:29 +0800
Message-ID: <1556618249-56304-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The 'cgrp' is set but not used in commit <76f969e8948d8>
("cgroup: cgroup v2 freezer").
Remove it to avoid [-Wunused-but-set-variable] warning.

Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 kernel/cgroup/cgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6f09f9b293db..c9f208d944ba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5943,11 +5943,8 @@ void cgroup_post_fork(struct task_struct *child)
 		 * the task into the frozen state.
 		 */
 		if (unlikely(cgroup_task_freeze(child))) {
-			struct cgroup *cgrp;
-
 			spin_lock(&child->sighand->siglock);
 			WARN_ON_ONCE(child->frozen);
-			cgrp = cset->dfl_cgrp;
 			child->jobctl |= JOBCTL_TRAP_FREEZE;
 			spin_unlock(&child->sighand->siglock);
 
-- 
2.7.4

