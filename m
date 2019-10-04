Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5879ACB8BA
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2019 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfJDK6F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Oct 2019 06:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfJDK6F (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E917EABC6;
        Fri,  4 Oct 2019 10:58:02 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 1/5] cgroup: Update comments about task exit path
Date:   Fri,  4 Oct 2019 12:57:39 +0200
Message-Id: <20191004105743.363-2-mkoutny@suse.com>
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

We no longer take cgroup_mutex in cgroup_exit and the exiting tasks are
not moved to init_css_set, reflect that in several comments to prevent
confusion.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549f..1488bb732902 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -899,8 +899,7 @@ static void css_set_move_task(struct task_struct *task,
 		/*
 		 * We are synchronized through cgroup_threadgroup_rwsem
 		 * against PF_EXITING setting such that we can't race
-		 * against cgroup_exit() changing the css_set to
-		 * init_css_set and dropping the old one.
+		 * against cgroup_exit()/cgroup_free() dropping the css_set.
 		 */
 		WARN_ON_ONCE(task->flags & PF_EXITING);
 
@@ -1430,9 +1429,8 @@ struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
 {
 	/*
-	 * No need to lock the task - since we hold cgroup_mutex the
-	 * task can't change groups, so the only thing that can happen
-	 * is that it exits and its css is set back to init_css_set.
+	 * No need to lock the task - since we hold css_set_lock the
+	 * task can't change groups.
 	 */
 	return cset_cgroup_from_root(task_css_set(task), root);
 }
@@ -6020,7 +6018,7 @@ void cgroup_post_fork(struct task_struct *child)
 		struct css_set *cset;
 
 		spin_lock_irq(&css_set_lock);
-		cset = task_css_set(current);
+		cset = task_css_set(current); /* current is @child's parent */
 		if (list_empty(&child->cg_list)) {
 			get_css_set(cset);
 			cset->nr_tasks++;
@@ -6063,20 +6061,8 @@ void cgroup_post_fork(struct task_struct *child)
  * cgroup_exit - detach cgroup from exiting task
  * @tsk: pointer to task_struct of exiting process
  *
- * Description: Detach cgroup from @tsk and release it.
- *
- * Note that cgroups marked notify_on_release force every task in
- * them to take the global cgroup_mutex mutex when exiting.
- * This could impact scaling on very large systems.  Be reluctant to
- * use notify_on_release cgroups where very high task exit scaling
- * is required on large systems.
+ * Description: Detach cgroup from @tsk.
  *
- * We set the exiting tasks cgroup to the root cgroup (top_cgroup).  We
- * call cgroup_exit() while the task is still competent to handle
- * notify_on_release(), then leave the task attached to the root cgroup in
- * each hierarchy for the remainder of its exit.  No need to bother with
- * init_css_set refcnting.  init_css_set never goes away and we can't race
- * with migration path - PF_EXITING is visible to migration path.
  */
 void cgroup_exit(struct task_struct *tsk)
 {
@@ -6086,7 +6072,8 @@ void cgroup_exit(struct task_struct *tsk)
 
 	/*
 	 * Unlink from @tsk from its css_set.  As migration path can't race
-	 * with us, we can check css_set and cg_list without synchronization.
+	 * with us (thanks to cgroup_threadgroup_rwsem), we can check css_set
+	 * and cg_list without synchronization.
 	 */
 	cset = task_css_set(tsk);
 
@@ -6102,6 +6089,8 @@ void cgroup_exit(struct task_struct *tsk)
 
 		spin_unlock_irq(&css_set_lock);
 	} else {
+		/* Take reference to avoid freeing init_css_set in cgroup_free,
+		 * see cgroup_fork(). */
 		get_css_set(cset);
 	}
 
-- 
2.21.0

