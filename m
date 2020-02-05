Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22171531CB
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBEN0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:26:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56952 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgBEN0s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Feb 2020 08:26:48 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1izKhY-00035h-Hv; Wed, 05 Feb 2020 13:26:44 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v6 1/6] cgroup: unify attach permission checking
Date:   Wed,  5 Feb 2020 14:26:18 +0100
Message-Id: <20200205132623.670015-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205132623.670015-1-christian.brauner@ubuntu.com>
References: <20200205132623.670015-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The core codepaths to check whether a process can be attached to a
cgroup are the same for threads and thread-group leaders. Only a small
piece of code verifying that source and destination cgroup are in the
same domain differentiates the thread permission checking from
thread-group leader permission checking.
Since cgroup_migrate_vet_dst() only matters cgroup2 - it is a noop on
cgroup1 - we can move it out of cgroup_attach_task().
All checks can now be consolidated into a new helper
cgroup_attach_permissions() callable from both cgroup_procs_write() and
cgroup_threads_write().

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191218173516.7875-2-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191223061504.28716-2-christian.brauner@ubuntu.com
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Fix return value of cgroup_attach_permissions. It used to return 0
    when it should've returned -EOPNOTSUPP.
  - Fix call to cgroup_attach_permissions() in cgroup_procs_write(). It
    accidently specified that a thread was moved causing an additional
    check for domain-group equality to be executed that is not needed.

/* v3 */
Link: https://lore.kernel.org/r/20200117002143.15559-2-christian.brauner@ubuntu.com
unchanged

/* v4 */
Link: https://lore.kernel.org/r/20200117181219.14542-2-christian.brauner@ubuntu.com
unchanged

/* v5 */
Link: https://lore.kernel.org/r/20200121154844.411-2-christian.brauner@ubuntu.com
unchanged

/* v6 */
- Michal Koutný <mkoutny@suse.com>:
  - Invert logic to use threadgroup argument to match other codepaths.
---
 kernel/cgroup/cgroup.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..5f84177e2065 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2719,11 +2719,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 {
 	DEFINE_CGROUP_MGCTX(mgctx);
 	struct task_struct *task;
-	int ret;
-
-	ret = cgroup_migrate_vet_dst(dst_cgrp);
-	if (ret)
-		return ret;
+	int ret = 0;
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
@@ -4690,6 +4686,26 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 	return 0;
 }
 
+static int cgroup_attach_permissions(struct cgroup *src_cgrp,
+				     struct cgroup *dst_cgrp,
+				     struct super_block *sb, bool threadgroup)
+{
+	int ret = 0;
+
+	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
+	if (ret)
+		return ret;
+
+	ret = cgroup_migrate_vet_dst(dst_cgrp);
+	if (ret)
+		return ret;
+
+	if (!threadgroup && (src_cgrp->dom_cgrp != dst_cgrp->dom_cgrp))
+		ret = -EOPNOTSUPP;
+
+	return ret;
+}
+
 static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 				  char *buf, size_t nbytes, loff_t off)
 {
@@ -4712,8 +4728,8 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
 	spin_unlock_irq(&css_set_lock);
 
-	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp,
-					    of->file->f_path.dentry->d_sb);
+	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+					of->file->f_path.dentry->d_sb, true);
 	if (ret)
 		goto out_finish;
 
@@ -4757,16 +4773,11 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	spin_unlock_irq(&css_set_lock);
 
 	/* thread migrations follow the cgroup.procs delegation rule */
-	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp,
-					    of->file->f_path.dentry->d_sb);
+	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+					of->file->f_path.dentry->d_sb, false);
 	if (ret)
 		goto out_finish;
 
-	/* and must be contained in the same domain */
-	ret = -EOPNOTSUPP;
-	if (src_cgrp->dom_cgrp != dst_cgrp->dom_cgrp)
-		goto out_finish;
-
 	ret = cgroup_attach_task(dst_cgrp, task, false);
 
 out_finish:
-- 
2.25.0

