Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8146390E7B
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhEZCup (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 22:50:45 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55969 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231128AbhEZCuo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 May 2021 22:50:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ua7n0eQ_1621997351;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ua7n0eQ_1621997351)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 10:49:12 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] cgroup: Fix kernel-doc
Date:   Wed, 26 May 2021 10:49:09 +0800
Message-Id: <1621997349-118999-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix function name in cgroup.c and rstat.c kernel-doc comment
to remove these warnings found by clang_w1.

kernel/cgroup/cgroup.c:2401: warning: expecting prototype for
cgroup_taskset_migrate(). Prototype was for cgroup_migrate_execute()
instead.
kernel/cgroup/rstat.c:233: warning: expecting prototype for
cgroup_rstat_flush_begin(). Prototype was for cgroup_rstat_flush_hold()
instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit e595cd706982 ("cgroup: track migration context in cgroup_mgctx")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 kernel/cgroup/rstat.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 21ecc6e..fc344f4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2389,7 +2389,7 @@ struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 }
 
 /**
- * cgroup_taskset_migrate - migrate a taskset
+ * cgroup_migrate_execute - migrate a taskset
  * @mgctx: migration context
  *
  * Migrate tasks in @mgctx as setup by migration preparation functions.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cee265c..7f0e589 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -220,7 +220,7 @@ void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
 }
 
 /**
- * cgroup_rstat_flush_begin - flush stats in @cgrp's subtree and hold
+ * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
  * @cgrp: target cgroup
  *
  * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
-- 
1.8.3.1

