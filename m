Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A83A325D
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFJRnN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 13:43:13 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35552 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhFJRnJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 13:43:09 -0400
Received: by mail-qk1-f173.google.com with SMTP id j189so28228072qkf.2;
        Thu, 10 Jun 2021 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJIm18e4PpawbVoKgbHVrGJrxEY+IxOXNktYagljzSs=;
        b=QdXJaINwy/NpNcHfO6r+pZO7yxptiQfjs8olLYZlteZrLcCfhawLTv/sm/ZXiyIvkq
         MuwF31YELaSBsWzo4eZ8lx9NNQ/x3zb2BrHhhFSP4pGeg9OI4fgFeUEynH9qv0ToCqy9
         rVVsWsv1PWppqQ/x+ajUCzRl5gMbqkxvvoaShvIwCFf9KMGAfXYLO2/veCp7+SkELo+M
         FHBgvxzKSL/MSLvA4TVTBjLDZlfDKWUZaNaWvL/7cNRjGlmHn4op5AFbTyMxRfbvwmTn
         Z78QRlZGA1KT9tT1JpRVRw/zk4Be8/4/PPUtbYWTJ29BGASmIr7KjZ+gtyCkAAa8Ciwr
         aRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJIm18e4PpawbVoKgbHVrGJrxEY+IxOXNktYagljzSs=;
        b=ke9DE7DHCdtpw+fMiJJA+diss4JH3jylRdixogamSmf7CT57jVpZK8PHiaUsYIVTjf
         s5kF30SrfziaTjXe9y4nxmqiG7AmJRH7Pb40I6hycR/fFa9j7U1c+oSU5+pqJEOufrNv
         34i+B7vCGGvR3p+D9tf9eGjbNRFs/KrLiTfiGECHLpolymmA8ay9oNRRTEq5FpLi03dv
         zScuneoQiA5SGbQwTuXvap0BFBfRFzQ0/3iMeDJBDnQ6tqToxviiY5H8jk13kX2JwujA
         ndvyzCfOkXuNB2LJCxdd+Ny2kat+6SN0HDqnhaoZsw/7/CATl8uLTeqVUwWUi20HvUxP
         Kd8Q==
X-Gm-Message-State: AOAM533FmPWcmeAZC38lR51D+sfgzar40N4swzL6Q6j3F1s9jpsxluhS
        pzAjmuavXwham8oUxMhD3h6jUYEumLmkyA==
X-Google-Smtp-Source: ABdhPJzNsA8mpG1QH1phmDuCkqfzvwRflB+jk+YhkTbnLsGobBVg/k69jshudORFoFO6BYHq2/Ktyg==
X-Received: by 2002:a37:a505:: with SMTP id o5mr641495qke.355.1623346801224;
        Thu, 10 Jun 2021 10:40:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be7a])
        by smtp.gmail.com with ESMTPSA id w2sm2567401qkf.88.2021.06.10.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:40:00 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Date:   Thu, 10 Jun 2021 10:39:44 -0700
Message-Id: <20210610173944.1203706-4-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current code only associates with the existing blkcg when aio is
used to access the backing file. This patch covers all types of i/o to
the backing file and also associates the memcg so if the backing file is
on tmpfs, memory is charged appropriately.

This patch also exports cgroup_get_e_css and int_active_memcg so it
can be used by the loop module.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/loop.c       | 61 +++++++++++++++++++++++++-------------
 drivers/block/loop.h       |  3 +-
 include/linux/memcontrol.h |  6 ++++
 kernel/cgroup/cgroup.c     |  1 +
 mm/memcontrol.c            |  1 +
 5 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fc4a0186d381..5198d8ad181c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -78,6 +78,7 @@
 #include <linux/uio.h>
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
+#include <linux/sched/mm.h>
 
 #include "loop.h"
 
@@ -516,8 +517,6 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
-	if (cmd->css)
-		css_put(cmd->css);
 	cmd->ret = ret;
 	lo_rw_aio_do_completion(cmd);
 }
@@ -578,8 +577,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
-	if (cmd->css)
-		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -587,7 +584,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
@@ -928,7 +924,7 @@ struct loop_worker {
 	struct list_head cmd_list;
 	struct list_head idle_list;
 	struct loop_device *lo;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
 	unsigned long last_ran_at;
 };
 
@@ -957,7 +953,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (queue_on_root_worker(cmd->css))
+	if (queue_on_root_worker(cmd->blkcg_css))
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -965,10 +961,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	while (*node) {
 		parent = *node;
 		cur_worker = container_of(*node, struct loop_worker, rb_node);
-		if (cur_worker->css == cmd->css) {
+		if (cur_worker->blkcg_css == cmd->blkcg_css) {
 			worker = cur_worker;
 			break;
-		} else if ((long)cur_worker->css < (long)cmd->css) {
+		} else if ((long)cur_worker->blkcg_css < (long)cmd->blkcg_css) {
 			node = &(*node)->rb_left;
 		} else {
 			node = &(*node)->rb_right;
@@ -980,13 +976,18 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
-	 * rootcg worker
+	 * rootcg worker and issue the I/O as the rootcg
 	 */
-	if (!worker)
+	if (!worker) {
+		cmd->blkcg_css = NULL;
+		if (cmd->memcg_css)
+			css_put(cmd->memcg_css);
+		cmd->memcg_css = NULL;
 		goto queue_work;
+	}
 
-	worker->css = cmd->css;
-	css_get(worker->css);
+	worker->blkcg_css = cmd->blkcg_css;
+	css_get(worker->blkcg_css);
 	INIT_WORK(&worker->work, loop_workfn);
 	INIT_LIST_HEAD(&worker->cmd_list);
 	INIT_LIST_HEAD(&worker->idle_list);
@@ -1306,7 +1307,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 				idle_list) {
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2111,13 +2112,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	/* always use the first bio's css */
+	cmd->blkcg_css = NULL;
+	cmd->memcg_css = NULL;
 #ifdef CONFIG_BLK_CGROUP
-	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
-		cmd->css = &bio_blkcg(rq->bio)->css;
-		css_get(cmd->css);
-	} else
+	if (rq->bio && rq->bio->bi_blkg) {
+		cmd->blkcg_css = &bio_blkcg(rq->bio)->css;
+#ifdef CONFIG_MEMCG
+		cmd->memcg_css =
+			cgroup_get_e_css(cmd->blkcg_css->cgroup,
+					&memory_cgrp_subsys);
+#endif
+	}
 #endif
-		cmd->css = NULL;
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
@@ -2129,13 +2135,28 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	const bool write = op_is_write(req_op(rq));
 	struct loop_device *lo = rq->q->queuedata;
 	int ret = 0;
+	struct mem_cgroup *old_memcg = NULL;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
 	}
 
+	if (cmd->blkcg_css)
+		kthread_associate_blkcg(cmd->blkcg_css);
+	if (cmd->memcg_css)
+		old_memcg = set_active_memcg(
+			mem_cgroup_from_css(cmd->memcg_css));
+
 	ret = do_req_filebacked(lo, rq);
+
+	if (cmd->blkcg_css)
+		kthread_associate_blkcg(NULL);
+
+	if (cmd->memcg_css) {
+		set_active_memcg(old_memcg);
+		css_put(cmd->memcg_css);
+	}
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
@@ -2214,7 +2235,7 @@ static void loop_free_idle_workers(struct timer_list *timer)
 			break;
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	if (!list_empty(&lo->idle_worker_list))
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 9289c1cd6374..cd24a81e00e6 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -76,7 +76,8 @@ struct loop_cmd {
 	long ret;
 	struct kiocb iocb;
 	struct bio_vec *bvec;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
+	struct cgroup_subsys_state *memcg_css;
 };
 
 /* Support for loadable transfer modules */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bd0644d3a6df..360e61de53d7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1230,6 +1230,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return NULL;
 }
 
+static inline
+struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 74e3cc801615..90329cfff48d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -577,6 +577,7 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	rcu_read_unlock();
 	return css;
 }
+EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 
 static void cgroup_get_live(struct cgroup *cgrp)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 919736ee656b..ae1f5d0cb581 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -78,6 +78,7 @@ struct mem_cgroup *root_mem_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
+EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
 
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket __ro_after_init;
-- 
2.30.2

