Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2599ACB8BD
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2019 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfJDK6G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Oct 2019 06:58:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728848AbfJDK6G (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B060FAC26;
        Fri,  4 Oct 2019 10:58:03 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 2/5] cgroup: Optimize single thread migration
Date:   Fri,  4 Oct 2019 12:57:40 +0200
Message-Id: <20191004105743.363-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004105743.363-1-mkoutny@suse.com>
References: <20191004105743.363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are reports of users who use thread migrations between cgroups and
they report performance drop after d59cfc09c32a ("sched, cgroup: replace
signal_struct->group_rwsem with a global percpu_rwsem"). The effect is
pronounced on machines with more CPUs.

The migration is affected by forking noise happening in the background,
after the mentioned commit a migrating thread must wait for all
(forking) processes on the system, not only of its threadgroup.

There are several places that need to synchronize with migration:
	a) do_exit,
	b) de_thread,
	c) copy_process,
	d) cgroup_update_dfl_csses,
	e) parallel migration (cgroup_{proc,thread}s_write).

In the case of self-migrating thread, we relax the synchronization on
cgroup_threadgroup_rwsem to avoid the cost of waiting. d) and e) are
excluded with cgroup_mutex, c) does not matter in case of single thread
migration and the executing thread cannot exec(2) or exit(2) while it is
writing into cgroup.threads. In case of do_exit because of signal
delivery, we either exit before the migration or finish the migration
(of not yet PF_EXITING thread) and die afterwards.

This patch handles only the case of self-migration by writing "0" into
cgroup.threads. For simplicity, we always take cgroup_threadgroup_rwsem
with numeric PIDs.

This change improves migration dependent workload performance similar
to per-signal_struct state.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-internal.h |  5 +++--
 kernel/cgroup/cgroup-v1.c       |  5 +++--
 kernel/cgroup/cgroup.c          | 39 +++++++++++++++++++++++++--------
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 809e34a3c017..90d1710fef6c 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -231,9 +231,10 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
-struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup)
+struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
+					     bool *locked)
 	__acquires(&cgroup_threadgroup_rwsem);
-void cgroup_procs_write_finish(struct task_struct *task)
+void cgroup_procs_write_finish(struct task_struct *task, bool locked)
 	__releases(&cgroup_threadgroup_rwsem);
 
 void cgroup_lock_and_drain_offline(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 88006be40ea3..dd0b263430d5 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -514,12 +514,13 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	struct task_struct *task;
 	const struct cred *cred, *tcred;
 	ssize_t ret;
+	bool locked;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, threadgroup);
+	task = cgroup_procs_write_start(buf, threadgroup, &locked);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -541,7 +542,7 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	ret = cgroup_attach_task(cgrp, task, threadgroup);
 
 out_finish:
-	cgroup_procs_write_finish(task);
+	cgroup_procs_write_finish(task, locked);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1488bb732902..3f806dbe279b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2822,7 +2822,8 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	return ret;
 }
 
-struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup)
+struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
+					     bool *locked)
 	__acquires(&cgroup_threadgroup_rwsem)
 {
 	struct task_struct *tsk;
@@ -2831,7 +2832,21 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup)
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return ERR_PTR(-EINVAL);
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	/*
+	 * If we migrate a single thread, we don't care about threadgroup
+	 * stability. If the thread is `current`, it won't exit(2) under our
+	 * hands or change PID through exec(2). We exclude
+	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
+	 * callers by cgroup_mutex.
+	 * Therefore, we can skip the global lock.
+	 */
+	lockdep_assert_held(&cgroup_mutex);
+	if (pid || threadgroup) {
+		percpu_down_write(&cgroup_threadgroup_rwsem);
+		*locked = true;
+	} else {
+		*locked = false;
+	}
 
 	rcu_read_lock();
 	if (pid) {
@@ -2862,13 +2877,16 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup)
 	goto out_unlock_rcu;
 
 out_unlock_threadgroup:
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	if (*locked) {
+		percpu_up_write(&cgroup_threadgroup_rwsem);
+		*locked = false;
+	}
 out_unlock_rcu:
 	rcu_read_unlock();
 	return tsk;
 }
 
-void cgroup_procs_write_finish(struct task_struct *task)
+void cgroup_procs_write_finish(struct task_struct *task, bool locked)
 	__releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
@@ -2877,7 +2895,8 @@ void cgroup_procs_write_finish(struct task_struct *task)
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
 
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	if (locked)
+		percpu_up_write(&cgroup_threadgroup_rwsem);
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
 			ss->post_attach();
@@ -4752,12 +4771,13 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
 	ssize_t ret;
+	bool locked;
 
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!dst_cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, true);
+	task = cgroup_procs_write_start(buf, true, &locked);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -4775,7 +4795,7 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	ret = cgroup_attach_task(dst_cgrp, task, true);
 
 out_finish:
-	cgroup_procs_write_finish(task);
+	cgroup_procs_write_finish(task, locked);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
@@ -4793,6 +4813,7 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
 	ssize_t ret;
+	bool locked;
 
 	buf = strstrip(buf);
 
@@ -4800,7 +4821,7 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	if (!dst_cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, false);
+	task = cgroup_procs_write_start(buf, false, &locked);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -4824,7 +4845,7 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	ret = cgroup_attach_task(dst_cgrp, task, false);
 
 out_finish:
-	cgroup_procs_write_finish(task);
+	cgroup_procs_write_finish(task, locked);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
-- 
2.21.0

