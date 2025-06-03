Return-Path: <cgroups+bounces-8429-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601DACCFF4
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 00:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0961748F7
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A92522B4;
	Tue,  3 Jun 2025 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VP3U9nAQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B044B5AE
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990629; cv=none; b=dgK28WULFg1RBBsSJJAo55XCpx5N1oyT5rvxSHP8N15p7GyoPNSw/cL8DjQhGUHxYq07Blv3TVI4ZMJNklmfQj+ttr6A64K+s/epw0p5xLRb9kC5yGBdG7I5iwc5lav0Z5/NkAX2phulB+Eh8sK16+vJTAtoqMUZvE4TP6NPmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990629; c=relaxed/simple;
	bh=Mr/zA/4M4GEnXmEcc/ETQMfwwojgDga8gHenGQ72hng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MNH0sSTZ++zf2c7F6T9htgvH8Q/sZMXHccpNRUCnZvGzxkCGXYPHSarw4BArktR3VAttZDLD6SuqbJqSFWF9dsUkBWdDp2sjMvPvAB+g7qnln60bleKx3Dh0sAEIeEHIX+4WOI+/r0gswQ+T7D2kZlRx+WdSME2+w+IlTQzkwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VP3U9nAQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b270145b864so3863747a12.3
        for <cgroups@vger.kernel.org>; Tue, 03 Jun 2025 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748990627; x=1749595427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rad0OtrY2NTejMq4uDIuzsfWFxuUo49H5+91h5ncfDE=;
        b=VP3U9nAQb3RFWPgWQudv4NMgWI6Gcw8gjGdqW11pRQg/jNHR25/XKGSUKzswxtBQFe
         FND4syjVUSYNorrridy66ro728+pc+W44tbJKsQOaMmhc55npAkfRhJ4AXo/6Bk7NVlD
         kld9G3CmS+jZOjPX39mmBCs1xaXdXtA1jZWNEY2a9ewvsTGpEu9YOM7wadSwOn75a//9
         AMdQmmYZ4j4LUmBd1X7sAWwF7ErH9e02OfutVcTDcQd4rb7MVxj/GSyDgWyeXfnvwHWw
         rYa81sBInfGHZwE8vy0z9jcJeSfQI7X5agXXSkSwm7h6b/4P3FKFW8gyutaAs+Id9H0V
         9pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748990627; x=1749595427;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rad0OtrY2NTejMq4uDIuzsfWFxuUo49H5+91h5ncfDE=;
        b=tlwKFae6mjX4XepjFbpuj2zrvQltOS8ZiZK0LQS1jG9GVq1PZX5Xh6sMrmfATyVLkh
         GtkkLYBY6zLeLOXpw8qtawcynLH9E1zoQGkcYY2af3EXQXeav3uRGKMwOrJ3fVtnGOGd
         VhJIBoEpU64QHIseHzmm8RdckLW2dqkBbiBXfMUnBkWsmXobQESxYTrCeAKeRiMDSrHv
         Dlu0KBFj5d6CPpMRvJhGsfOUYscfWENt11Bd2jN3Soh3OmM2Qex5yKvLc7gBjIfAeCla
         5OguP5EVIXi0XA9WLdKyxPoxmpieFY+DPXEM2BMhMINmTkEJWlYwttUnxSXtCKht2/tW
         w4jA==
X-Gm-Message-State: AOJu0Yy6x7eOU75IcYj3+2PEw2m6zSUvqJzkWYPxah0wOtX5nC3D3eZ1
	kaF8STJf6KnCl7Dpgg7248thq1YJlWcpAuwBymrpil4AZluxIOYfGn13rHWMaBJlepBCwfZ1nvg
	dN7bz0I4nPA==
X-Google-Smtp-Source: AGHT+IFA/R1fY3wcmP9uXYen9ziekdA+4C8CBx+WLyn7DDqZUZVzNOL+/ubH9faJF7MB/OF+WcMqdpS1oD12
X-Received: from pgct18.prod.google.com ([2002:a05:6a02:5292:b0:b2c:3733:a8ec])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b02:b0:21c:f778:6736
 with SMTP id adf61e73a8af0-21d22b4525dmr805643637.27.1748990626800; Tue, 03
 Jun 2025 15:43:46 -0700 (PDT)
Date: Tue,  3 Jun 2025 22:43:05 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603224304.3198729-3-ynaffit@google.com>
Subject: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org, kernel-team@android.com, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The cgroup v2 freezer controller allows user processes to be dynamically
added to and removed from an interruptible frozen state from
userspace. This feature is helpful for application management, as it
allows background tasks to be frozen to prevent them from being
scheduled or otherwise contending with foreground tasks for resources.
Still, applications are usually unaware of their having been placed in
the freezer cgroup, so any watchdog timers they may have set will fire
when they exit. To address this problem, I propose tracking the per-task
frozen time and exposing it to userland via procfs.

Currently, the cgroup css_set_lock is used to serialize accesses to the
new task_struct counters (frozen_time_total and frozen_time_start). If
we start to see higher contention on this lock, we may want to introduce
a separate per-task mutex or seq_lock, but the main focus in this
initial submission is establishing the right UAPI for this accounting
information.

While any comments on this RFC are appreciated, there are several areas
where feedback would be especially welcome:
   1. I know there is some hesitancy toward adding new proc files to
      the system, so I would welcome suggestions as to how this per-task
      accounting might be better exposed to userland.
   2. Unlike the cgroup v1 freezer controller, the cgroup v2 freezer
      does not use the system-wide freezer shared by the power
      management system to freeze tasks. Instead, tasks are placed into
      a cgroup v2 freezer-specific frozen state similar to jobctl
      stop. Consequently, the time being accounted for here is somewhat
      narrow and specific to cgroup v2 functionality, but there may be
      better ways to generalize it.

Since this is a first stab at discussing the potential interface, I've
not yet updated the procfs documentation for this. Once there is
consensus around the interface, I will fill that out.

Thank you for your time!
Tiffany

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chen Ridong <chenridong@huawei.com>
---
 fs/proc/base.c          |  2 ++
 include/linux/cgroup.h  |  2 ++
 include/linux/sched.h   |  3 +++
 kernel/cgroup/cgroup.c  |  2 ++
 kernel/cgroup/freezer.c | 20 ++++++++++++++++++++
 5 files changed, 29 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c667702dc69b..38a05bb53cd1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3377,6 +3377,7 @@ static const struct pid_entry tgid_base_stuff[] =3D {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+	ONE("cgroup_v2_freezer_time_frozen",  0444, proc_cgroup_frztime_show),
 #endif
 #ifdef CONFIG_PROC_CPU_RESCTRL
 	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
@@ -3724,6 +3725,7 @@ static const struct pid_entry tid_base_stuff[] =3D {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+	ONE("cgroup_v2_freezer_time_frozen",  0444, proc_cgroup_frztime_show),
 #endif
 #ifdef CONFIG_PROC_CPU_RESCTRL
 	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..871831808e22 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -837,6 +837,8 @@ void cgroup_update_frozen(struct cgroup *cgrp);
 void cgroup_freeze(struct cgroup *cgrp, bool freeze);
 void cgroup_freezer_migrate_task(struct task_struct *task, struct cgroup *=
src,
 				 struct cgroup *dst);
+int proc_cgroup_frztime_show(struct seq_file *m, struct pid_namespace *ns,
+			     struct pid *pid, struct task_struct *tsk);
=20
 static inline bool cgroup_task_frozen(struct task_struct *task)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa9c5be7a632..55d173fd070c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1321,6 +1321,9 @@ struct task_struct {
 	struct css_set __rcu		*cgroups;
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
+	/* freezer stats protected by the css_set_lock: */
+	u64				frozen_time_total;
+	u64				frozen_time_start;
 #endif
 #ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..05e1d2cf3654 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6470,6 +6470,8 @@ void cgroup_fork(struct task_struct *child)
 {
 	RCU_INIT_POINTER(child->cgroups, &init_css_set);
 	INIT_LIST_HEAD(&child->cg_list);
+	child->frozen_time_total =3D 0;
+	child->frozen_time_start =3D 0;
 }
=20
 /**
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..7dd9e70a47c5 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -110,6 +110,7 @@ void cgroup_enter_frozen(void)
=20
 	spin_lock_irq(&css_set_lock);
 	current->frozen =3D true;
+	current->frozen_time_start =3D ktime_get_ns();
 	cgrp =3D task_dfl_cgroup(current);
 	cgroup_inc_frozen_cnt(cgrp);
 	cgroup_update_frozen(cgrp);
@@ -132,10 +133,13 @@ void cgroup_leave_frozen(bool always_leave)
 	spin_lock_irq(&css_set_lock);
 	cgrp =3D task_dfl_cgroup(current);
 	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
+		u64 end_ns;
 		cgroup_dec_frozen_cnt(cgrp);
 		cgroup_update_frozen(cgrp);
 		WARN_ON_ONCE(!current->frozen);
 		current->frozen =3D false;
+		end_ns =3D ktime_get_ns();
+		current->frozen_time_total +=3D (end_ns - current->frozen_time_start);
 	} else if (!(current->jobctl & JOBCTL_TRAP_FREEZE)) {
 		spin_lock(&current->sighand->siglock);
 		current->jobctl |=3D JOBCTL_TRAP_FREEZE;
@@ -254,6 +258,22 @@ void cgroup_freezer_migrate_task(struct task_struct *t=
ask,
 	cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
 }
=20
+int proc_cgroup_frztime_show(struct seq_file *m, struct pid_namespace *ns,
+			     struct pid *pid, struct task_struct *tsk)
+{
+	u64 delta =3D 0;
+
+	spin_lock_irq(&css_set_lock);
+	if (tsk->frozen)
+		delta =3D ktime_get() - tsk->frozen_time_start;
+
+	seq_printf(m, "%llu\n",
+		   (unsigned long long)(tsk->frozen_time_total + delta));
+	spin_unlock_irq(&css_set_lock);
+
+	return 0;
+}
+
 void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 {
 	struct cgroup_subsys_state *css;
--=20
2.49.0.1204.g71687c7c1d-goog


