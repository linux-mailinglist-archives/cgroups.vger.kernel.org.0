Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3501400C9
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 01:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgAQAVv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jan 2020 19:21:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54605 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgAQAVu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jan 2020 19:21:50 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isFOV-0001a1-Bo; Fri, 17 Jan 2020 00:21:47 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH v3 1/5] cgroup: unify attach permission checking
Date:   Fri, 17 Jan 2020 01:21:39 +0100
Message-Id: <20200117002143.15559-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117002143.15559-1-christian.brauner@ubuntu.com>
References: <20200117002143.15559-1-christian.brauner@ubuntu.com>
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
unchanged
---
 kernel/cgroup/cgroup.c | 46 +++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..ad1f9fea5c14 100644
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
+	if (thread &&
+	    !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
+		ret = -EOPNOTSUPP;
+
+	return ret;
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
+					of->file->f_path.dentry->d_sb, false);
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
2.25.0

