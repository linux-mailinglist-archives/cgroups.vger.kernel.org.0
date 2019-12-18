Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA01124F79
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2019 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLRRiQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Dec 2019 12:38:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRRiQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Dec 2019 12:38:16 -0500
Received: from host.242.234.23.62.rev.coltfrance.com ([62.23.234.242] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihdGo-00046Q-Mf; Wed, 18 Dec 2019 17:37:58 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 1/3] cgroup: unify attach permission checking
Date:   Wed, 18 Dec 2019 18:35:14 +0100
Message-Id: <20191218173516.7875-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218173516.7875-1-christian.brauner@ubuntu.com>
References: <20191218173516.7875-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/cgroup/cgroup.c | 46 +++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..5ee06c1f7456 100644
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
@@ -4690,6 +4686,33 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 	return 0;
 }
 
+static inline bool cgroup_same_domain(const struct cgroup *src_cgrp,
+				      const struct cgroup *dst_cgrp)
+{
+	return src_cgrp->dom_cgrp == dst_cgrp->dom_cgrp;
+}
+
+static int cgroup_attach_permissions(struct cgroup *src_cgrp,
+				     struct cgroup *dst_cgrp,
+				     struct super_block *sb, bool thread)
+{
+	int ret;
+
+	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
+	if (ret)
+		return ret;
+
+	ret = cgroup_migrate_vet_dst(dst_cgrp);
+	if (ret)
+		return ret;
+
+	if (thread &&
+	    !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
+		ret = -EOPNOTSUPP;
+
+	return 0;
+}
+
 static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 				  char *buf, size_t nbytes, loff_t off)
 {
@@ -4712,8 +4735,8 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
 	spin_unlock_irq(&css_set_lock);
 
-	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp,
-					    of->file->f_path.dentry->d_sb);
+	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+					of->file->f_path.dentry->d_sb, true);
 	if (ret)
 		goto out_finish;
 
@@ -4757,16 +4780,11 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	spin_unlock_irq(&css_set_lock);
 
 	/* thread migrations follow the cgroup.procs delegation rule */
-	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp,
-					    of->file->f_path.dentry->d_sb);
+	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+					of->file->f_path.dentry->d_sb, true);
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
2.24.0

