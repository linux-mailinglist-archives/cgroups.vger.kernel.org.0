Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07F38E250
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 10:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEXIcA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 04:32:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5527 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhEXIb7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 May 2021 04:31:59 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpVhC3tDyzkYdF;
        Mon, 24 May 2021 16:27:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:30:29 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:30:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] cgroup: fix spelling mistakes
Date:   Mon, 24 May 2021 16:29:43 +0800
Message-ID: <20210524082943.8730-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix some spelling mistakes in comments:
hierarhcy ==> hierarchy
automtically ==> automatically
overriden ==> overridden
In absense of .. or ==> In absence of .. and
assocaited ==> associated
taget ==> target
initate ==> initiate
succeded ==> succeeded
curremt ==> current
udpated ==> updated

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/cgroup-defs.h | 6 +++---
 include/linux/cgroup.h      | 2 +-
 kernel/cgroup/cgroup-v1.c   | 2 +-
 kernel/cgroup/cgroup.c      | 8 ++++----
 kernel/cgroup/cpuset.c      | 2 +-
 kernel/cgroup/rdma.c        | 2 +-
 kernel/cgroup/rstat.c       | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 559ee05f86b2..fb8f6d2cd104 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -232,7 +232,7 @@ struct css_set {
 	struct list_head task_iters;
 
 	/*
-	 * On the default hierarhcy, ->subsys[ssid] may point to a css
+	 * On the default hierarchy, ->subsys[ssid] may point to a css
 	 * attached to an ancestor instead of the cgroup this css_set is
 	 * associated with.  The following node is anchored at
 	 * ->subsys[ssid]->cgroup->e_csets[ssid] and provides a way to
@@ -668,7 +668,7 @@ struct cgroup_subsys {
 	 */
 	bool threaded:1;
 
-	/* the following two fields are initialized automtically during boot */
+	/* the following two fields are initialized automatically during boot */
 	int id;
 	const char *name;
 
@@ -757,7 +757,7 @@ static inline void cgroup_threadgroup_change_end(struct task_struct *tsk) {}
  * sock_cgroup_data overloads (prioidx, classid) and the cgroup pointer.
  * On boot, sock_cgroup_data records the cgroup that the sock was created
  * in so that cgroup2 matches can be made; however, once either net_prio or
- * net_cls starts being used, the area is overriden to carry prioidx and/or
+ * net_cls starts being used, the area is overridden to carry prioidx and/or
  * classid.  The two modes are distinguished by whether the lowest bit is
  * set.  Clear bit indicates cgroup pointer while set bit prioidx and
  * classid.
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4f2f79de083e..6bc9c76680b2 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -32,7 +32,7 @@ struct kernel_clone_args;
 #ifdef CONFIG_CGROUPS
 
 /*
- * All weight knobs on the default hierarhcy should use the following min,
+ * All weight knobs on the default hierarchy should use the following min,
  * default and max values.  The default value is the logarithmic center of
  * MIN and MAX and allows 100x to be expressed in both directions.
  */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 391aa570369b..8190b6bfc978 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1001,7 +1001,7 @@ static int check_cgroupfs_options(struct fs_context *fc)
 	ctx->subsys_mask &= enabled;
 
 	/*
-	 * In absense of 'none', 'name=' or subsystem name options,
+	 * In absence of 'none', 'name=' and subsystem name options,
 	 * let's default to 'all'.
 	 */
 	if (!ctx->subsys_mask && !ctx->none && !ctx->name)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e049edd66776..d18dc75d3bf5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -468,7 +468,7 @@ static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
  * @cgrp: the cgroup of interest
  * @ss: the subsystem of interest
  *
- * Find and get @cgrp's css assocaited with @ss.  If the css doesn't exist
+ * Find and get @cgrp's css associated with @ss.  If the css doesn't exist
  * or is offline, %NULL is returned.
  */
 static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
@@ -1633,7 +1633,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 
 /**
  * css_clear_dir - remove subsys files in a cgroup directory
- * @css: taget css
+ * @css: target css
  */
 static void css_clear_dir(struct cgroup_subsys_state *css)
 {
@@ -5350,7 +5350,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 /*
  * This is called when the refcnt of a css is confirmed to be killed.
  * css_tryget_online() is now guaranteed to fail.  Tell the subsystem to
- * initate destruction and put the css ref from kill_css().
+ * initiate destruction and put the css ref from kill_css().
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
@@ -6058,7 +6058,7 @@ int cgroup_can_fork(struct task_struct *child, struct kernel_clone_args *kargs)
  * @kargs: the arguments passed to create the child process
  *
  * This calls the cancel_fork() callbacks if a fork failed *after*
- * cgroup_can_fork() succeded and cleans up references we took to
+ * cgroup_can_fork() succeeded and cleans up references we took to
  * prepare a new css_set for the child process in cgroup_can_fork().
  */
 void cgroup_cancel_fork(struct task_struct *child,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a945504c0ae7..adb5190c4429 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3376,7 +3376,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 }
 
 /**
- * cpuset_nodemask_valid_mems_allowed - check nodemask vs. curremt mems_allowed
+ * cpuset_nodemask_valid_mems_allowed - check nodemask vs. current mems_allowed
  * @nodemask: the nodemask to be checked
  *
  * Are any of the nodes in the nodemask allowed in current->mems_allowed?
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index ae042c347c64..3135406608c7 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(rdmacg_uncharge);
  * This function follows charging resource in hierarchical way.
  * It will fail if the charge would cause the new value to exceed the
  * hierarchical limit.
- * Returns 0 if the charge succeded, otherwise -EAGAIN, -ENOMEM or -EINVAL.
+ * Returns 0 if the charge succeeded, otherwise -EAGAIN, -ENOMEM or -EINVAL.
  * Returns pointer to rdmacg for this resource when charging is successful.
  *
  * Charger needs to account resources on two criteria.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 3a3fd2993a65..cee265cb535c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -75,7 +75,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
  * @root: root of the tree to traversal
  * @cpu: target cpu
  *
- * Walks the udpated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
+ * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
  * the traversal and %NULL return indicates the end.  During traversal,
  * each returned cgroup is unlinked from the tree.  Must be called with the
  * matching cgroup_rstat_cpu_lock held.
-- 
2.25.1


