Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B985C900A4
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2019 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHPLTE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Aug 2019 07:19:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42058 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfHPLTB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Aug 2019 07:19:01 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyaG3-0008PI-80; Fri, 16 Aug 2019 13:18:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] cgroup: Acquire cgroup_rstat_lock with enabled interrupts
Date:   Fri, 16 Aug 2019 13:18:17 +0200
Message-Id: <20190816111817.834-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816111817.834-1-bigeasy@linutronix.de>
References: <20190816111817.834-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no need to disable interrupts while cgroup_rstat_lock is
acquired. The lock is never used in-IRQ context so a simple spin_lock()
is enough for synchronisation purpose.

Acquire cgroup_rstat_lock without disabling interrupts and ensure that
cgroup_rstat_cpu_lock is acquired with disabled interrupts (this one is
acquired in-IRQ context).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/rstat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index bbfce474c66a2..a59962e66aea1 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -161,17 +161,17 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp)
 						       cpu);
 		struct cgroup *pos =3D NULL;
=20
-		raw_spin_lock(cpu_lock);
+		raw_spin_lock_irq(cpu_lock);
 		while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu)))
 			cgroup_base_stat_flush(pos, cpu);
=20
-		raw_spin_unlock(cpu_lock);
+		raw_spin_unlock_irq(cpu_lock);
=20
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			spin_unlock_irq(&cgroup_rstat_lock);
+			spin_unlock(&cgroup_rstat_lock);
 			if (!cond_resched())
 				cpu_relax();
-			spin_lock_irq(&cgroup_rstat_lock);
+			spin_lock(&cgroup_rstat_lock);
 		}
 	}
 }
@@ -193,9 +193,9 @@ void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
=20
-	spin_lock_irq(&cgroup_rstat_lock);
+	spin_lock(&cgroup_rstat_lock);
 	cgroup_rstat_flush_locked(cgrp);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock(&cgroup_rstat_lock);
 }
=20
 /**
@@ -211,7 +211,7 @@ static void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	spin_lock_irq(&cgroup_rstat_lock);
+	spin_lock(&cgroup_rstat_lock);
 	cgroup_rstat_flush_locked(cgrp);
 }
=20
@@ -221,7 +221,7 @@ static void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 static void cgroup_rstat_flush_release(void)
 	__releases(&cgroup_rstat_lock)
 {
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock(&cgroup_rstat_lock);
 }
=20
 int cgroup_rstat_init(struct cgroup *cgrp)
--=20
2.23.0.rc1

