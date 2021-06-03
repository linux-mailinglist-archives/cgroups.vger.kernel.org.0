Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91BF39A3C7
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhFCO7O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhFCO7O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 10:59:14 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5844EC06174A;
        Thu,  3 Jun 2021 07:57:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a15so4603511qta.0;
        Thu, 03 Jun 2021 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/sL/MX7/Rs8uAvj8Nz+qL4hAo4Z7vik4smu8z42Kj0=;
        b=F4F2Larp/mwm58QH55fRn31Qhcv4ojpCYI59jbj6lS6OmeDhCSWro2zt1uBhdcePpG
         aJF9pXbAGJUomlHFC56jetEEJyuTuA1+WOmaQEIA4TI4MqH7s8Vxd5sIScDn+4KmrkQy
         7etwj9Q4R0luJsb6rno7VczyMLxPLCM+AGTUnpHizsapuEg22njKegkr9pbvBLDD7eqi
         T26WkGgG3vvBHxkRShO/SA5mysTtsEM0O4k//6kLOimhiuG3XbIAYe64rBOTQ+WfUwdV
         LXzJjAv+YNpPK6EzlENqugl21PBrUHPKRXNvChjgTdHcF8dZzA7XNiKg5SAvJ4ts25Tt
         YXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/sL/MX7/Rs8uAvj8Nz+qL4hAo4Z7vik4smu8z42Kj0=;
        b=YuYs4ix3f4tTKOtvAHCHniUpCQVng05KYdnr0czv0LMVZOM0W0CwYIkIk/m/Y7nyQv
         dx8pKq+tVq19eyZyrLbV71a0uosqmnfCQVrLUG07pfhMqukR9Tutb2VnkmRZnayZ6O2J
         IzyPgVvkZWhHSLGUYt7B0gkQuq3nK1bkfid4pGzVokDgYrHh2xk6+1ROcWW7lbqDpA/U
         XiTTq6t10J/Jo71YS3X0QZjgGafjOIwws38DM9ZkAvAXx/dN9H7n7Px9iZw5udLIyq/B
         vT1+olkDVGCz/2H9adgKoGwql2Y27LS3hycU9G/+9IOt29+myNRQCHg3tGU5oNRWGSQ3
         tv/Q==
X-Gm-Message-State: AOAM530fj7abhTYrRxlgCpoNy8snKWrusEd+lWFhKSBMqJGPpOsFsSYK
        nVhKm/P6cz+47zBNiRhgQ4aWsayINQ4=
X-Google-Smtp-Source: ABdhPJzBzv/GKp3vIFT5IludnKsw3tSk3lFcIfH4mql7s36ZGo1G7f00Kdn0xVZ/AjQdiXaKP5V4GQ==
X-Received: by 2002:ac8:76c5:: with SMTP id q5mr271848qtr.205.1622732248518;
        Thu, 03 Jun 2021 07:57:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8008])
        by smtp.gmail.com with ESMTPSA id d12sm2036677qkn.126.2021.06.03.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:57:28 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH 1/3] loop: Use worker per cgroup instead of kworker
Date:   Thu,  3 Jun 2021 07:57:05 -0700
Message-Id: <20210603145707.4031641-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603145707.4031641-1-schatzberg.dan@gmail.com>
References: <20210603145707.4031641-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Existing uses of loop device may have multiple cgroups reading/writing
to the same device. Simply charging resources for I/O to the backing
file could result in priority inversion where one cgroup gets
synchronously blocked, holding up all other I/O to the loop device.

In order to avoid this priority inversion, we use a single workqueue
where each work item is a "struct loop_worker" which contains a queue of
struct loop_cmds to issue. The loop device maintains a tree mapping blk
css_id -> loop_worker. This allows each cgroup to independently make
forward progress issuing I/O to the backing file.

There is also a single queue for I/O associated with the rootcg which
can be used in cases of extreme memory shortage where we cannot allocate
a loop_worker.

The locking for the tree and queues is fairly heavy handed - we acquire
a per-loop-device spinlock any time either is accessed. The existing
implementation serializes all I/O through a single thread anyways, so I
don't believe this is any worse.

Fixes-from: Colin Ian King <colin.king@canonical.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 drivers/block/loop.c | 200 ++++++++++++++++++++++++++++++++++++-------
 drivers/block/loop.h |  12 ++-
 2 files changed, 175 insertions(+), 37 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..935edcf7c7b1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -71,7 +71,6 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
@@ -84,6 +83,8 @@
 
 #include <linux/uaccess.h>
 
+#define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
@@ -921,27 +922,80 @@ static void loop_config_discard(struct loop_device *lo)
 	q->limits.discard_alignment = 0;
 }
 
-static void loop_unprepare_queue(struct loop_device *lo)
-{
-	kthread_flush_worker(&lo->worker);
-	kthread_stop(lo->worker_task);
-}
+struct loop_worker {
+	struct rb_node rb_node;
+	struct work_struct work;
+	struct list_head cmd_list;
+	struct list_head idle_list;
+	struct loop_device *lo;
+	struct cgroup_subsys_state *css;
+	unsigned long last_ran_at;
+};
 
-static int loop_kthread_worker_fn(void *worker_ptr)
-{
-	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	return kthread_worker_fn(worker_ptr);
-}
+static void loop_workfn(struct work_struct *work);
+static void loop_rootcg_workfn(struct work_struct *work);
+static void loop_free_idle_workers(struct timer_list *timer);
 
-static int loop_prepare_queue(struct loop_device *lo)
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
-	kthread_init_worker(&lo->worker);
-	lo->worker_task = kthread_run(loop_kthread_worker_fn,
-			&lo->worker, "loop%d", lo->lo_number);
-	if (IS_ERR(lo->worker_task))
-		return -ENOMEM;
-	set_user_nice(lo->worker_task, MIN_NICE);
-	return 0;
+	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
+	struct loop_worker *cur_worker, *worker = NULL;
+
+	spin_lock_irq(&lo->lo_work_lock);
+
+	if (!cmd->css)
+		goto queue_work;
+
+	node = &lo->worker_tree.rb_node;
+
+	while (*node) {
+		parent = *node;
+		cur_worker = container_of(*node, struct loop_worker, rb_node);
+		if (cur_worker->css == cmd->css) {
+			worker = cur_worker;
+			break;
+		} else if ((long)cur_worker->css < (long)cmd->css) {
+			node = &(*node)->rb_left;
+		} else {
+			node = &(*node)->rb_right;
+		}
+	}
+	if (worker)
+		goto queue_work;
+
+	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	/*
+	 * In the event we cannot allocate a worker, just queue on the
+	 * rootcg worker
+	 */
+	if (!worker)
+		goto queue_work;
+
+	worker->css = cmd->css;
+	css_get(worker->css);
+	INIT_WORK(&worker->work, loop_workfn);
+	INIT_LIST_HEAD(&worker->cmd_list);
+	INIT_LIST_HEAD(&worker->idle_list);
+	worker->lo = lo;
+	rb_link_node(&worker->rb_node, parent, node);
+	rb_insert_color(&worker->rb_node, &lo->worker_tree);
+queue_work:
+	if (worker) {
+		list_add_tail(&cmd->list_entry, &worker->cmd_list);
+		/*
+		 * We need to remove from the idle list here while
+		 * holding the lock so that the idle timer doesn't
+		 * free the worker
+		 */
+		if (!list_empty(&worker->idle_list)) {
+			list_del_init(&worker->idle_list);
+			queue_work(lo->workqueue, &worker->work);
+		}
+	} else {
+		list_add_tail(&cmd->list_entry, &lo->rootcg_cmd_list);
+		queue_work(lo->workqueue, &lo->rootcg_work);
+	}
+	spin_unlock_irq(&lo->lo_work_lock);
 }
 
 static void loop_update_rotational(struct loop_device *lo)
@@ -1127,12 +1181,23 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = loop_prepare_queue(lo);
-	if (error)
+	lo->workqueue = alloc_workqueue("loop%d",
+					WQ_UNBOUND | WQ_FREEZABLE,
+					0,
+					lo->lo_number);
+	if (!lo->workqueue) {
+		error = -ENOMEM;
 		goto out_unlock;
+	}
 
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
+	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
+	INIT_LIST_HEAD(&lo->idle_worker_list);
+	lo->worker_tree = RB_ROOT;
+	timer_setup(&lo->timer, loop_free_idle_workers,
+		TIMER_DEFERRABLE);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
@@ -1200,6 +1265,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	int err = 0;
 	bool partscan = false;
 	int lo_number;
+	struct loop_worker *pos, *worker;
 
 	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
@@ -1219,6 +1285,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	destroy_workqueue(lo->workqueue);
+	spin_lock_irq(&lo->lo_work_lock);
+	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
+				idle_list) {
+		list_del(&worker->idle_list);
+		rb_erase(&worker->rb_node, &lo->worker_tree);
+		css_put(worker->css);
+		kfree(worker);
+	}
+	spin_unlock_irq(&lo->lo_work_lock);
+	del_timer_sync(&lo->timer);
+
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
@@ -1255,7 +1333,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
-	loop_unprepare_queue(lo);
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
@@ -2026,7 +2103,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	} else
 #endif
 		cmd->css = NULL;
-	kthread_queue_work(&lo->worker, &cmd->work);
+	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
 }
@@ -2056,26 +2133,82 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	}
 }
 
-static void loop_queue_work(struct kthread_work *work)
+static void loop_set_timer(struct loop_device *lo)
+{
+	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
+}
+
+static void loop_process_work(struct loop_worker *worker,
+			struct list_head *cmd_list, struct loop_device *lo)
 {
-	struct loop_cmd *cmd =
-		container_of(work, struct loop_cmd, work);
+	int orig_flags = current->flags;
+	struct loop_cmd *cmd;
 
-	loop_handle_cmd(cmd);
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+	spin_lock_irq(&lo->lo_work_lock);
+	while (!list_empty(cmd_list)) {
+		cmd = container_of(
+			cmd_list->next, struct loop_cmd, list_entry);
+		list_del(cmd_list->next);
+		spin_unlock_irq(&lo->lo_work_lock);
+
+		loop_handle_cmd(cmd);
+		cond_resched();
+
+		spin_lock_irq(&lo->lo_work_lock);
+	}
+
+	/*
+	 * We only add to the idle list if there are no pending cmds
+	 * *and* the worker will not run again which ensures that it
+	 * is safe to free any worker on the idle list
+	 */
+	if (worker) {
+		worker->last_ran_at = jiffies;
+		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
+		loop_set_timer(lo);
+	}
+	spin_unlock_irq(&lo->lo_work_lock);
+	current->flags = orig_flags;
 }
 
-static int loop_init_request(struct blk_mq_tag_set *set, struct request *rq,
-		unsigned int hctx_idx, unsigned int numa_node)
+static void loop_workfn(struct work_struct *work)
 {
-	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct loop_worker *worker =
+		container_of(work, struct loop_worker, work);
+	loop_process_work(worker, &worker->cmd_list, worker->lo);
+}
 
-	kthread_init_work(&cmd->work, loop_queue_work);
-	return 0;
+static void loop_rootcg_workfn(struct work_struct *work)
+{
+	struct loop_device *lo =
+		container_of(work, struct loop_device, rootcg_work);
+	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
+}
+
+static void loop_free_idle_workers(struct timer_list *timer)
+{
+	struct loop_device *lo = container_of(timer, struct loop_device, timer);
+	struct loop_worker *pos, *worker;
+
+	spin_lock_irq(&lo->lo_work_lock);
+	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
+				idle_list) {
+		if (time_is_after_jiffies(worker->last_ran_at +
+						LOOP_IDLE_WORKER_TIMEOUT))
+			break;
+		list_del(&worker->idle_list);
+		rb_erase(&worker->rb_node, &lo->worker_tree);
+		css_put(worker->css);
+		kfree(worker);
+	}
+	if (!list_empty(&lo->idle_worker_list))
+		loop_set_timer(lo);
+	spin_unlock_irq(&lo->lo_work_lock);
 }
 
 static const struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
-	.init_request	= loop_init_request,
 	.complete	= lo_complete_rq,
 };
 
@@ -2164,6 +2297,7 @@ static int loop_add(struct loop_device **l, int i)
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
+	spin_lock_init(&lo->lo_work_lock);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
 	disk->fops		= &lo_fops;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index a3c04f310672..9289c1cd6374 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -14,7 +14,6 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/kthread.h>
 #include <uapi/linux/loop.h>
 
 /* Possible states of device */
@@ -54,8 +53,13 @@ struct loop_device {
 
 	spinlock_t		lo_lock;
 	int			lo_state;
-	struct kthread_worker	worker;
-	struct task_struct	*worker_task;
+	spinlock_t              lo_work_lock;
+	struct workqueue_struct *workqueue;
+	struct work_struct      rootcg_work;
+	struct list_head        rootcg_cmd_list;
+	struct list_head        idle_worker_list;
+	struct rb_root          worker_tree;
+	struct timer_list       timer;
 	bool			use_dio;
 	bool			sysfs_inited;
 
@@ -66,7 +70,7 @@ struct loop_device {
 };
 
 struct loop_cmd {
-	struct kthread_work work;
+	struct list_head list_entry;
 	bool use_aio; /* use AIO interface to handle I/O */
 	atomic_t ref; /* only for aio */
 	long ret;
-- 
2.30.2

