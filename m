Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372F6E3BBE
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2019 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391577AbfJXTDz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 15:03:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41182 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390604AbfJXTDz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 15:03:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id o3so196912qtj.8;
        Thu, 24 Oct 2019 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSS8P0vN/PxXEmV06HpJZaLV3hskEfA+4rwAT2vwCyU=;
        b=pwML1vBlwRkiJWesFjdGD5QQzUbDEF1w02INiI14MC+GlhI1IQsypg6KPI1kdXDXxR
         Oyn3gLVs0ldCaDtc09gaB1wQjmAA6rTwa3vhjKqA/6l8xtvLQy+Qrk+CGbFxwOEQSx6j
         de67f5jhg6xr9JQqlBVLjqBb3F6ApYkomMrw7NviGOwqPkSKplh4jjMaDlfGfr/c3I2+
         udnjJy32lNcmiPDnzk4jwueydgXHwh/wIcJVUYsgpoD+aVSFpDf216G7UuQTdB65MJhM
         GTnT3jmahS8lYSaLxcGMlvsr+15fLMrNcw6hRiYpqpTuXuKdnLe8ESP/J23LI69tM0bS
         ymig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSS8P0vN/PxXEmV06HpJZaLV3hskEfA+4rwAT2vwCyU=;
        b=AP9emMM7PT1KnBSHMP2Cxx876OwJRG7mbleKPbxDwHuEU8KJeXZivn2q2WsjfOVwdq
         lJZl2UXS6NSGkC5UcOYv4wDVwkM9yDyBlHcdaffhIEX+yZS3g8XTQPbVfbBlH0cAwaro
         dqUsITcpfiZewhtvp92tOKcj8JSdQc/AfV3qC2NNQRaKblZpzq0Fyx4+03NlYAepClbx
         /JISpZrxb9r45FIvM6duhoAmZMmvQvybZtQmnrfD9rCr0/5VgLHO2BlapKcSokYSR36e
         phCDI9u1ZvZSdo7DBP5qNnjIazD9itCqKXnzS1hpsn1Q1h+wzPpXpas1NBfVgOnpAwd4
         FbJQ==
X-Gm-Message-State: APjAAAUNfnEds0rbGCkfUA1oR2d2aDQNV2xeUvwO1Bz+jnpR+LtpO6jr
        zV9sfgyPw+D1CdQ0ZvXAfZI=
X-Google-Smtp-Source: APXvYqwmaiIKdQUg+gAD/pG+m8M05imQXeHFdc+UXV8d19eiJhfWF/YsOCnbG1rZnss5dubZCpJYug==
X-Received: by 2002:a0c:9873:: with SMTP id e48mr3274028qvd.115.1571943833844;
        Thu, 24 Oct 2019 12:03:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:b2e])
        by smtp.gmail.com with ESMTPSA id h20sm5169897qtr.29.2019.10.24.12.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 12:03:53 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:03:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH cgroup/for-5.5] cgroup: remove cgroup_enable_task_cg_lists()
 optimization
Message-ID: <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021142111.GB1339@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_enable_task_cg_lists() is used to lazyily initialize task
cgroup associations on the first use to reduce fork / exit overheads
on systems which don't use cgroup.  Unfortunately, locking around it
has never been actually correct and its value is dubious given how the
vast majority of systems use cgroup right away from boot.

This patch removes the optimization.  For now, replace the cg_list
based branches with WARN_ON_ONCE()'s to be on the safe side.  We can
simplify the logic further in the future.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/cgroup.h |    1 
 kernel/cgroup/cgroup.c |  184 ++++++++++---------------------------------------
 kernel/cgroup/cpuset.c |    2 
 3 files changed, 39 insertions(+), 148 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3ba3e6da13a6..f6b048902d6c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -150,7 +150,6 @@ struct task_struct *cgroup_taskset_first(struct cgroup_taskset *tset,
 struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 					struct cgroup_subsys_state **dst_cssp);
 
-void cgroup_enable_task_cg_lists(void);
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it);
 struct task_struct *css_task_iter_next(struct css_task_iter *it);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8b1c4fd47a7a..cf32c0c7a45d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1883,65 +1883,6 @@ static int cgroup_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
-/*
- * To reduce the fork() overhead for systems that are not actually using
- * their cgroups capability, we don't maintain the lists running through
- * each css_set to its tasks until we see the list actually used - in other
- * words after the first mount.
- */
-static bool use_task_css_set_links __read_mostly;
-
-void cgroup_enable_task_cg_lists(void)
-{
-	struct task_struct *p, *g;
-
-	/*
-	 * We need tasklist_lock because RCU is not safe against
-	 * while_each_thread(). Besides, a forking task that has passed
-	 * cgroup_post_fork() without seeing use_task_css_set_links = 1
-	 * is not guaranteed to have its child immediately visible in the
-	 * tasklist if we walk through it with RCU.
-	 */
-	read_lock(&tasklist_lock);
-	spin_lock_irq(&css_set_lock);
-
-	if (use_task_css_set_links)
-		goto out_unlock;
-
-	use_task_css_set_links = true;
-
-	do_each_thread(g, p) {
-		WARN_ON_ONCE(!list_empty(&p->cg_list) ||
-			     task_css_set(p) != &init_css_set);
-
-		/*
-		 * We should check if the process is exiting, otherwise
-		 * it will race with cgroup_exit() in that the list
-		 * entry won't be deleted though the process has exited.
-		 * Do it while holding siglock so that we don't end up
-		 * racing against cgroup_exit().
-		 *
-		 * Interrupts were already disabled while acquiring
-		 * the css_set_lock, so we do not need to disable it
-		 * again when acquiring the sighand->siglock here.
-		 */
-		spin_lock(&p->sighand->siglock);
-		if (!(p->flags & PF_EXITING)) {
-			struct css_set *cset = task_css_set(p);
-
-			if (!css_set_populated(cset))
-				css_set_update_populated(cset, true);
-			list_add_tail(&p->cg_list, &cset->tasks);
-			get_css_set(cset);
-			cset->nr_tasks++;
-		}
-		spin_unlock(&p->sighand->siglock);
-	} while_each_thread(g, p);
-out_unlock:
-	spin_unlock_irq(&css_set_lock);
-	read_unlock(&tasklist_lock);
-}
-
 static void init_cgroup_housekeeping(struct cgroup *cgrp)
 {
 	struct cgroup_subsys *ss;
@@ -2187,13 +2128,6 @@ static int cgroup_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
-	/*
-	 * The first time anyone tries to mount a cgroup, enable the list
-	 * linking each css_set to its tasks and fix up all existing tasks.
-	 */
-	if (!use_task_css_set_links)
-		cgroup_enable_task_cg_lists();
-
 	ctx->ns = current->nsproxy->cgroup_ns;
 	get_cgroup_ns(ctx->ns);
 	fc->fs_private = &ctx->kfc;
@@ -2371,9 +2305,8 @@ static void cgroup_migrate_add_task(struct task_struct *task,
 	if (task->flags & PF_EXITING)
 		return;
 
-	/* leave @task alone if post_fork() hasn't linked it yet */
-	if (list_empty(&task->cg_list))
-		return;
+	/* cgroup_threadgroup_rwsem protects racing against forks */
+	WARN_ON_ONCE(list_empty(&task->cg_list));
 
 	cset = task_css_set(task);
 	if (!cset->mg_src_cgrp)
@@ -4586,9 +4519,6 @@ static void css_task_iter_advance(struct css_task_iter *it)
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it)
 {
-	/* no one should try to iterate before mounting cgroups */
-	WARN_ON_ONCE(!use_task_css_set_links);
-
 	memset(it, 0, sizeof(*it));
 
 	spin_lock_irq(&css_set_lock);
@@ -6022,62 +5952,38 @@ void cgroup_cancel_fork(struct task_struct *child)
 void cgroup_post_fork(struct task_struct *child)
 {
 	struct cgroup_subsys *ss;
+	struct css_set *cset;
 	int i;
 
+	spin_lock_irq(&css_set_lock);
+
+	WARN_ON_ONCE(!list_empty(&child->cg_list));
+	cset = task_css_set(current); /* current is @child's parent */
+	get_css_set(cset);
+	cset->nr_tasks++;
+	css_set_move_task(child, NULL, cset, false);
+
 	/*
-	 * This may race against cgroup_enable_task_cg_lists().  As that
-	 * function sets use_task_css_set_links before grabbing
-	 * tasklist_lock and we just went through tasklist_lock to add
-	 * @child, it's guaranteed that either we see the set
-	 * use_task_css_set_links or cgroup_enable_task_cg_lists() sees
-	 * @child during its iteration.
-	 *
-	 * If we won the race, @child is associated with %current's
-	 * css_set.  Grabbing css_set_lock guarantees both that the
-	 * association is stable, and, on completion of the parent's
-	 * migration, @child is visible in the source of migration or
-	 * already in the destination cgroup.  This guarantee is necessary
-	 * when implementing operations which need to migrate all tasks of
-	 * a cgroup to another.
-	 *
-	 * Note that if we lose to cgroup_enable_task_cg_lists(), @child
-	 * will remain in init_css_set.  This is safe because all tasks are
-	 * in the init_css_set before cg_links is enabled and there's no
-	 * operation which transfers all tasks out of init_css_set.
+	 * If the cgroup has to be frozen, the new task has too.  Let's set
+	 * the JOBCTL_TRAP_FREEZE jobctl bit to get the task into the
+	 * frozen state.
 	 */
-	if (use_task_css_set_links) {
-		struct css_set *cset;
-
-		spin_lock_irq(&css_set_lock);
-		cset = task_css_set(current); /* current is @child's parent */
-		if (list_empty(&child->cg_list)) {
-			get_css_set(cset);
-			cset->nr_tasks++;
-			css_set_move_task(child, NULL, cset, false);
-		}
+	if (unlikely(cgroup_task_freeze(child))) {
+		spin_lock(&child->sighand->siglock);
+		WARN_ON_ONCE(child->frozen);
+		child->jobctl |= JOBCTL_TRAP_FREEZE;
+		spin_unlock(&child->sighand->siglock);
 
 		/*
-		 * If the cgroup has to be frozen, the new task has too.
-		 * Let's set the JOBCTL_TRAP_FREEZE jobctl bit to get
-		 * the task into the frozen state.
+		 * Calling cgroup_update_frozen() isn't required here,
+		 * because it will be called anyway a bit later from
+		 * do_freezer_trap(). So we avoid cgroup's transient switch
+		 * from the frozen state and back.
 		 */
-		if (unlikely(cgroup_task_freeze(child))) {
-			spin_lock(&child->sighand->siglock);
-			WARN_ON_ONCE(child->frozen);
-			child->jobctl |= JOBCTL_TRAP_FREEZE;
-			spin_unlock(&child->sighand->siglock);
-
-			/*
-			 * Calling cgroup_update_frozen() isn't required here,
-			 * because it will be called anyway a bit later
-			 * from do_freezer_trap(). So we avoid cgroup's
-			 * transient switch from the frozen state and back.
-			 */
-		}
-
-		spin_unlock_irq(&css_set_lock);
 	}
 
+	spin_unlock_irq(&css_set_lock);
+
 	/*
 	 * Call ss->fork().  This must happen after @child is linked on
 	 * css_set; otherwise, @child might change state between ->fork()
@@ -6101,29 +6007,19 @@ void cgroup_exit(struct task_struct *tsk)
 	struct css_set *cset;
 	int i;
 
-	/*
-	 * Unlink from @tsk from its css_set.  As migration path can't race
-	 * with us (thanks to cgroup_threadgroup_rwsem), we can check css_set
-	 * and cg_list without synchronization.
-	 */
-	cset = task_css_set(tsk);
+	spin_lock_irq(&css_set_lock);
 
-	if (!list_empty(&tsk->cg_list)) {
-		spin_lock_irq(&css_set_lock);
-		css_set_move_task(tsk, cset, NULL, false);
-		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
-		cset->nr_tasks--;
+	WARN_ON_ONCE(list_empty(&tsk->cg_list));
+	cset = task_css_set(tsk);
+	css_set_move_task(tsk, cset, NULL, false);
+	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
+	cset->nr_tasks--;
 
-		WARN_ON_ONCE(cgroup_task_frozen(tsk));
-		if (unlikely(cgroup_task_freeze(tsk)))
-			cgroup_update_frozen(task_dfl_cgroup(tsk));
+	WARN_ON_ONCE(cgroup_task_frozen(tsk));
+	if (unlikely(cgroup_task_freeze(tsk)))
+		cgroup_update_frozen(task_dfl_cgroup(tsk));
 
-		spin_unlock_irq(&css_set_lock);
-	} else {
-		/* Take reference to avoid freeing init_css_set in cgroup_free,
-		 * see cgroup_fork(). */
-		get_css_set(cset);
-	}
+	spin_unlock_irq(&css_set_lock);
 
 	/* see cgroup_post_fork() for details */
 	do_each_subsys_mask(ss, i, have_exit_callback) {
@@ -6140,12 +6036,10 @@ void cgroup_release(struct task_struct *task)
 		ss->release(task);
 	} while_each_subsys_mask();
 
-	if (use_task_css_set_links) {
-		spin_lock_irq(&css_set_lock);
-		css_set_skip_task_iters(task_css_set(task), task);
-		list_del_init(&task->cg_list);
-		spin_unlock_irq(&css_set_lock);
-	}
+	spin_lock_irq(&css_set_lock);
+	css_set_skip_task_iters(task_css_set(task), task);
+	list_del_init(&task->cg_list);
+	spin_unlock_irq(&css_set_lock);
 }
 
 void cgroup_free(struct task_struct *task)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c52bc91f882b..faff8f99e8f2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -928,8 +928,6 @@ static void rebuild_root_domains(void)
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
-	cgroup_enable_task_cg_lists();
-
 	rcu_read_lock();
 
 	/*
