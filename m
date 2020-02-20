Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE0166380
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 17:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgBTQwg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 11:52:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46726 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQwg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 11:52:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so4154305qkh.13;
        Thu, 20 Feb 2020 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYNVHlKgDQ46X+XbR/60sAiRfHp1T0eWqZr2l7PitAY=;
        b=mRplJTIVJvwxpfcqw1dz1JBHO/xQGnQyFaChntDSc5MNme2JxeChi/bpTJQGi2EMq1
         8cIt6V0A0cRKVgMt8j34VVrEuLKAhSrGC593vKSouczGi3i55noG8wUfiNagIdDdvKke
         rfj2cJeUjjLQzqTr1rzSvR26xwlJ+Lo1sIbrq9vrjXgJe/O2/dWT9tD+zy/YizOlT6Q7
         y8AvtOXyJJyczYaAt+Hk5J7Oqhe2nHEFjUyWAXSTocGoGZCX5Sn1L2GTXx4W8MzYj16z
         H9jjzGwayvlZmXV6qrqv0EgVqVi8iacMxVH7XCeZAw/ZlTfwEvvv77h/VlQpYf06Oc4c
         Kfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYNVHlKgDQ46X+XbR/60sAiRfHp1T0eWqZr2l7PitAY=;
        b=FZSxnQDF9HqL6VutBPP83+EG7q1VD9rm3rpkZ5KgQ+vADJ85hp/oWfW2H6d2ONkJkc
         xS0nkcvNFOztmFbMoKHDSFQaU7c+BLCNgAVFHhKUWlQHRowWooWSgmXyKHS1K1u+Pe+0
         rQ5ErFZnLmCCzWBbxgkDfCi5mMlno0GtzQAIfsg8Ce7L0NSQde5fFOuzkObbjS1yP4DY
         SR8DugdK6tNeRBYN84PSmNw9Bk4hGgxYCBA2/xYGX37acqfOlakZ8eeeIc4xeF7C4y+L
         ZGrl/pGvvpX7tBzdyN2GDkNCJlfVVaKwoRM4p1TgMiL9LDOoWzOtBu1QOWQYiaNGPlZu
         Wt3g==
X-Gm-Message-State: APjAAAXsEzZ2XkeyWbEWbvhotlC8u7eF9kIFUs4847ysFrHUtn9usBmI
        AC/cZxnMuK+JlHIZ01Y56DQ=
X-Google-Smtp-Source: APXvYqzD9cWPQf5UM0f9Pf6Mkn/wkKPaIxfck7hrx6xRV/WzgwEsGJg0M8N/ODEy4+fT++tQp0ZHYQ==
X-Received: by 2002:a37:e317:: with SMTP id y23mr28832696qki.431.1582217554540;
        Thu, 20 Feb 2020 08:52:34 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:500::3:edb0])
        by smtp.gmail.com with ESMTPSA id t55sm43567qte.24.2020.02.20.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:52:33 -0800 (PST)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v3 1/3] loop: Use worker per cgroup instead of kworker
Date:   Thu, 20 Feb 2020 11:51:51 -0500
Message-Id: <118a1bd99d12f1980c7fc01ab732b40ffd8f0537.1582216294.git.schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1582216294.git.schatzberg.dan@gmail.com>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
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
the per-loop-device spinlock any time either is accessed. The existing
implementation serializes all I/O through a single thread anyways, so I
don't believe this is any worse.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 drivers/block/loop.c | 188 +++++++++++++++++++++++++++++++++++++------
 drivers/block/loop.h |  11 ++-
 2 files changed, 170 insertions(+), 29 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..78e5005c6742 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,7 +70,6 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
@@ -83,6 +82,8 @@
 
 #include <linux/uaccess.h>
 
+#define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
@@ -891,27 +892,101 @@ static void loop_config_discard(struct loop_device *lo)
 
 static void loop_unprepare_queue(struct loop_device *lo)
 {
-	kthread_flush_worker(&lo->worker);
-	kthread_stop(lo->worker_task);
-}
-
-static int loop_kthread_worker_fn(void *worker_ptr)
-{
-	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
-	return kthread_worker_fn(worker_ptr);
+	destroy_workqueue(lo->workqueue);
 }
 
 static int loop_prepare_queue(struct loop_device *lo)
 {
-	kthread_init_worker(&lo->worker);
-	lo->worker_task = kthread_run(loop_kthread_worker_fn,
-			&lo->worker, "loop%d", lo->lo_number);
-	if (IS_ERR(lo->worker_task))
+	lo->workqueue = alloc_workqueue("loop%d",
+					WQ_UNBOUND | WQ_FREEZABLE |
+					WQ_MEM_RECLAIM,
+					lo->lo_number);
+	if (IS_ERR(lo->workqueue))
 		return -ENOMEM;
-	set_user_nice(lo->worker_task, MIN_NICE);
+
 	return 0;
 }
 
+struct loop_worker {
+	struct rb_node rb_node;
+	struct work_struct work;
+	struct list_head cmd_list;
+	struct list_head idle_list;
+	struct loop_device *lo;
+	struct cgroup_subsys_state *css;
+	unsigned long last_ran_at;
+};
+
+static void loop_workfn(struct work_struct *work);
+static void loop_rootcg_workfn(struct work_struct *work);
+static void loop_free_idle_workers(struct timer_list *timer);
+
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
+{
+	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
+	struct loop_worker *cur_worker, *worker = NULL;
+	struct work_struct *work;
+	struct list_head *cmd_list;
+
+	spin_lock_irq(&lo->lo_lock);
+
+	if (!cmd->css)
+		goto queue_work;
+
+	node = &(lo->worker_tree.rb_node);
+
+	while (*node) {
+		parent = *node;
+		cur_worker = container_of(*node, struct loop_worker, rb_node);
+		if ((long)cur_worker->css == (long)cmd->css) {
+			worker = cur_worker;
+			break;
+		} else if ((long)cur_worker->css < (long)cmd->css) {
+			node = &((*node)->rb_left);
+		} else {
+			node = &((*node)->rb_right);
+		}
+	}
+	if (worker)
+		goto queue_work;
+
+	worker = kzalloc(sizeof(struct loop_worker),
+			GFP_NOWAIT | __GFP_NOWARN);
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
+		/*
+		 * We need to remove from the idle list here while
+		 * holding the lock so that the idle timer doesn't
+		 * free the worker
+		 */
+		if (!list_empty(&worker->idle_list))
+			list_del_init(&worker->idle_list);
+		work = &worker->work;
+		cmd_list = &worker->cmd_list;
+	} else {
+		work = &lo->rootcg_work;
+		cmd_list = &lo->rootcg_cmd_list;
+	}
+	list_add_tail(&cmd->list_entry, cmd_list);
+	queue_work(lo->workqueue, work);
+	spin_unlock_irq(&lo->lo_lock);
+}
+
 static void loop_update_rotational(struct loop_device *lo)
 {
 	struct file *file = lo->lo_backing_file;
@@ -993,6 +1068,12 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
+	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
+	INIT_LIST_HEAD(&lo->idle_worker_list);
+	lo->worker_tree = RB_ROOT;
+	timer_setup(&lo->timer, loop_free_idle_workers,
+		TIMER_DEFERRABLE);
 	lo->use_dio = false;
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
@@ -1155,6 +1236,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
 	loop_unprepare_queue(lo);
+	del_timer_sync(&lo->timer);
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan) {
@@ -1932,7 +2014,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	} else
 #endif
 		cmd->css = NULL;
-	kthread_queue_work(&lo->worker, &cmd->work);
+	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
 }
@@ -1958,26 +2040,82 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	}
 }
 
-static void loop_queue_work(struct kthread_work *work)
+static void loop_set_timer(struct loop_device *lo)
 {
-	struct loop_cmd *cmd =
-		container_of(work, struct loop_cmd, work);
+	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
+}
+
+static void loop_process_work(struct loop_worker *worker,
+			struct list_head *cmd_list, struct loop_device *lo)
+{
+	int orig_flags = current->flags;
+	struct loop_cmd *cmd;
+
+	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
+	while (1) {
+		spin_lock_irq(&lo->lo_lock);
+		if (list_empty(cmd_list))
+			break;
+
+		cmd = container_of(
+			cmd_list->next, struct loop_cmd, list_entry);
+		list_del(cmd_list->next);
+		spin_unlock_irq(&lo->lo_lock);
+		loop_handle_cmd(cmd);
+		cond_resched();
+	}
 
-	loop_handle_cmd(cmd);
+	/*
+	 * We only add to the idle list if there are no pending cmds
+	 * *and* the worker will not run again which ensures that it
+	 * is safe to free any worker on the idle list
+	 */
+	if (worker && !work_pending(&worker->work)) {
+		worker->last_ran_at = jiffies;
+		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
+		loop_set_timer(lo);
+	}
+	spin_unlock_irq(&lo->lo_lock);
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
+	spin_lock_irq(&lo->lo_lock);
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
+	spin_unlock_irq(&lo->lo_lock);
 }
 
 static const struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
-	.init_request	= loop_init_request,
 	.complete	= lo_complete_rq,
 };
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index af75a5ee4094..87fd0e372227 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -14,7 +14,6 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/kthread.h>
 #include <uapi/linux/loop.h>
 
 /* Possible states of device */
@@ -54,8 +53,12 @@ struct loop_device {
 
 	spinlock_t		lo_lock;
 	int			lo_state;
-	struct kthread_worker	worker;
-	struct task_struct	*worker_task;
+	struct workqueue_struct *workqueue;
+	struct work_struct      rootcg_work;
+	struct list_head        rootcg_cmd_list;
+	struct list_head        idle_worker_list;
+	struct rb_root          worker_tree;
+	struct timer_list       timer;
 	bool			use_dio;
 	bool			sysfs_inited;
 
@@ -65,7 +68,7 @@ struct loop_device {
 };
 
 struct loop_cmd {
-	struct kthread_work work;
+	struct list_head list_entry;
 	bool use_aio; /* use AIO interface to handle I/O */
 	atomic_t ref; /* only for aio */
 	long ret;
-- 
2.17.1

