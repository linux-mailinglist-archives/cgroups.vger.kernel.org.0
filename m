Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D167125C4
	for <lists+cgroups@lfdr.de>; Fri, 26 May 2023 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbjEZLnB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbjEZLnA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 07:43:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CE116;
        Fri, 26 May 2023 04:42:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QSNMf0tK6z4f4PNk;
        Fri, 26 May 2023 19:42:54 +0800 (CST)
Received: from ubuntu1804.huawei.com (unknown [10.67.174.58])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rE7m3BkX_gDKQ--.37908S4;
        Fri, 26 May 2023 19:42:52 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiujianfeng@huaweicloud.com, cuigaosheng1@huawei.com
Subject: [PATCH] cgroup: Stop task iteration when rebinding subsystem
Date:   Fri, 26 May 2023 19:41:39 +0800
Message-Id: <20230526114139.70274-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: gCh0CgBH_rE7m3BkX_gDKQ--.37908S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar17JFW5KF1fXw13Cw13twb_yoW7CryxpF
        15u3y7Ars5Aw4qq3yfJ3sF9r9ag3ykuw1jgrWxtw4fKwnrtry7XF1jkr17XFyxAFZFgF47
        tF4jk3yS9w4Dtr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUym14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We found a refcount UAF bug as follows:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 342 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x148
Workqueue: events cpuset_hotplug_workfn
Call trace:
 refcount_warn_saturate+0xa0/0x148
 __refcount_add.constprop.0+0x5c/0x80
 css_task_iter_advance_css_set+0xd8/0x210
 css_task_iter_advance+0xa8/0x120
 css_task_iter_next+0x94/0x158
 update_tasks_root_domain+0x58/0x98
 rebuild_root_domains+0xa0/0x1b0
 rebuild_sched_domains_locked+0x144/0x188
 cpuset_hotplug_workfn+0x138/0x5a0
 process_one_work+0x1e8/0x448
 worker_thread+0x228/0x3e0
 kthread+0xe0/0xf0
 ret_from_fork+0x10/0x20

then a kernel panic will be triggered as below:

Unable to handle kernel paging request at virtual address 00000000c0000010
Call trace:
 cgroup_apply_control_disable+0xa4/0x16c
 rebind_subsystems+0x224/0x590
 cgroup_destroy_root+0x64/0x2e0
 css_free_rwork_fn+0x198/0x2a0
 process_one_work+0x1d4/0x4bc
 worker_thread+0x158/0x410
 kthread+0x108/0x13c
 ret_from_fork+0x10/0x18

The race that cause this bug can be shown as below:

(hotplug cpu)                | (umount cpuset)
mutex_lock(&cpuset_mutex)    | mutex_lock(&cgroup_mutex)
cpuset_hotplug_workfn        |
 rebuild_root_domains        |  rebind_subsystems
  update_tasks_root_domain   |   spin_lock_irq(&css_set_lock)
   css_task_iter_start       |    list_move_tail(&cset->e_cset_node[ss->id]
   while(css_task_iter_next) |                  &dcgrp->e_csets[ss->id]);
   css_task_iter_end         |   spin_unlock_irq(&css_set_lock)
mutex_unlock(&cpuset_mutex)  | mutex_unlock(&cgroup_mutex)

Inside css_task_iter_start/next/end, css_set_lock is hold and then
released, so when iterating task(left side), the css_set may be moved to
another list(right side), then it->cset_head points to the old list head
and it->cset_pos->next points to the head node of new list, which can't
be used as struct css_set.

To fix this issue, introduce CSS_TASK_ITER_STOPPED flag for css_task_iter.
when moving css_set to dcgrp->e_csets[ss->id] in rebind_subsystems(), stop
the task iteration.

Reported-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Link: https://www.spinics.net/lists/cgroups/msg37935.html
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 567c547cf371..3f1557cb5758 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -47,6 +47,7 @@ struct kernel_clone_args;
 
 /* internal flags */
 #define CSS_TASK_ITER_SKIPPED		(1U << 16)
+#define CSS_TASK_ITER_STOPPED		(1U << 17)
 
 /* a css_task_iter should be treated as an opaque object */
 struct css_task_iter {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8b8ca2e01019..7b16e8d34fca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -240,6 +240,8 @@ static int cgroup_apply_control(struct cgroup *cgrp);
 static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
 static void css_task_iter_skip(struct css_task_iter *it,
 			       struct task_struct *task);
+static void css_task_iter_stop(struct css_task_iter *it,
+			       struct css_set *cset);
 static int cgroup_destroy_locked(struct cgroup *cgrp);
 static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss);
@@ -889,6 +891,19 @@ static void css_set_skip_task_iters(struct css_set *cset,
 		css_task_iter_skip(it, task);
 }
 
+/*
+ * @cset is moving to other list, it's not safe to continue the iteration,
+ * because the cset_head of css_task_iter which is from the old list can
+ * not be used as the stop condition of iteration.
+ */
+static void css_set_stop_iters(struct css_set *cset)
+{
+	struct css_task_iter *it, *pos;
+
+	list_for_each_entry_safe(it, pos, &cset->task_iters, iters_node)
+		css_task_iter_stop(it, cset);
+}
+
 /**
  * css_set_move_task - move a task from one css_set to another
  * @task: task being moved
@@ -1861,9 +1876,11 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		hash_for_each(css_set_table, i, cset, hlist) {
+			css_set_stop_iters(cset);
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		if (ss->css_rstat_flush) {
@@ -4864,6 +4881,15 @@ static void css_task_iter_skip(struct css_task_iter *it,
 	}
 }
 
+static void css_task_iter_stop(struct css_task_iter *it,
+			       struct css_set *cset)
+{
+	lockdep_assert_held(&css_set_lock);
+
+	WARN_ONCE(it->cur_cset != cset, "invalid cur_set for css_task_iter\n");
+	it->flags |= CSS_TASK_ITER_STOPPED;
+}
+
 static void css_task_iter_advance(struct css_task_iter *it)
 {
 	struct task_struct *task;
@@ -4967,6 +4993,11 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
 
 	spin_lock_irq(&css_set_lock);
 
+	if (it->flags & CSS_TASK_ITER_STOPPED) {
+		spin_unlock_irq(&css_set_lock);
+		return NULL;
+	}
+
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
 		css_task_iter_advance(it);
-- 
2.17.1

