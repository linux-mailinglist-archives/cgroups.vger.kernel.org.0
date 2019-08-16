Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A199900A1
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2019 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfHPLTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Aug 2019 07:19:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42053 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfHPLS7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Aug 2019 07:18:59 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyaG1-0008PI-TE; Fri, 16 Aug 2019 13:18:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] cgroup: Consolidate users of cgroup_rstat_lock.
Date:   Fri, 16 Aug 2019 13:18:15 +0200
Message-Id: <20190816111817.834-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816111817.834-1-bigeasy@linutronix.de>
References: <20190816111817.834-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_rstat_flush_irqsafe() has no users, remove it.
cgroup_rstat_flush_hold() and cgroup_rstat_flush_release() are only used wi=
thin
this file. Make it static.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/cgroup.h |  3 ---
 kernel/cgroup/rstat.c  | 19 ++-----------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f6b048902d6c5..2d1cb3f534ce1 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -749,9 +749,6 @@ static inline void cgroup_path_from_kernfs_id(const uni=
on kernfs_node_id *id,
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
-void cgroup_rstat_flush_hold(struct cgroup *cgrp);
-void cgroup_rstat_flush_release(void);
=20
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 72ba0ec4ae209..22e83497362ff 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -200,21 +200,6 @@ void cgroup_rstat_flush(struct cgroup *cgrp)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
=20
-/**
- * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush()
- * @cgrp: target cgroup
- *
- * This function can be called from any context.
- */
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cgroup_rstat_lock, flags);
-	cgroup_rstat_flush_locked(cgrp, false);
-	spin_unlock_irqrestore(&cgroup_rstat_lock, flags);
-}
-
 /**
  * cgroup_rstat_flush_begin - flush stats in @cgrp's subtree and hold
  * @cgrp: target cgroup
@@ -224,7 +209,7 @@ void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
  *
  * This function may block.
  */
-void cgroup_rstat_flush_hold(struct cgroup *cgrp)
+static void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
@@ -235,7 +220,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  */
-void cgroup_rstat_flush_release(void)
+static void cgroup_rstat_flush_release(void)
 	__releases(&cgroup_rstat_lock)
 {
 	spin_unlock_irq(&cgroup_rstat_lock);
--=20
2.23.0.rc1

