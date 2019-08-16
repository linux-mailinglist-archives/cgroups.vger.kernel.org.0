Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F0900A5
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2019 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHPLTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Aug 2019 07:19:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42055 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHPLTA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Aug 2019 07:19:00 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyaG2-0008PI-IV; Fri, 16 Aug 2019 13:18:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] cgroup: Remove `may_sleep' from cgroup_rstat_flush_locked()
Date:   Fri, 16 Aug 2019 13:18:16 +0200
Message-Id: <20190816111817.834-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816111817.834-1-bigeasy@linutronix.de>
References: <20190816111817.834-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_rstat_flush_locked() is always invoked with `may_sleep' set to
true so that this case can be made default and the parameter removed.

Remove the `may_sleep' parameter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/rstat.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 22e83497362ff..bbfce474c66a2 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -149,7 +149,7 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(stru=
ct cgroup *pos,
 }
=20
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
+static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
 	int cpu;
@@ -167,9 +167,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cg=
rp, bool may_sleep)
=20
 		raw_spin_unlock(cpu_lock);
=20
-		/* if @may_sleep, play nice and yield if necessary */
-		if (may_sleep && (need_resched() ||
-				  spin_needbreak(&cgroup_rstat_lock))) {
+		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
 			spin_unlock_irq(&cgroup_rstat_lock);
 			if (!cond_resched())
 				cpu_relax();
@@ -196,7 +194,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp)
 	might_sleep();
=20
 	spin_lock_irq(&cgroup_rstat_lock);
-	cgroup_rstat_flush_locked(cgrp, true);
+	cgroup_rstat_flush_locked(cgrp);
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
=20
@@ -214,7 +212,7 @@ static void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 {
 	might_sleep();
 	spin_lock_irq(&cgroup_rstat_lock);
-	cgroup_rstat_flush_locked(cgrp, true);
+	cgroup_rstat_flush_locked(cgrp);
 }
=20
 /**
--=20
2.23.0.rc1

