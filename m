Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5234D2C8
	for <lists+cgroups@lfdr.de>; Mon, 29 Mar 2021 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhC2Otx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhC2OtW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Mar 2021 10:49:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01ADC061574;
        Mon, 29 Mar 2021 07:49:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g24so9464018qts.6;
        Mon, 29 Mar 2021 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbYEH0bK6c1spCCH0RHfSscRq2p/YYpBz/KqOzM+cU8=;
        b=ljcmkJr4RPUxq3moGpdv87vYDF1VNPTVPk58wiZrjdImNidpLTeEsoA0Y4sEwPe+Y9
         0/USP4uwfiOzEly19Q8/99NDNGym935Iza9j4TiealAl1uzoxgSrg3/0F/LOAjAhb8Td
         199wup5aM1hTMmUTZAxbU/K0zA0JzUMZEsvB7vdgQhla5ynhNbWfNq8x0FlKSlZRVpRd
         w6u1LB2cjutgnkOcJqq3V0h5h9O/qPA2TUfNkC4WjBB1XnaFoBYTWWvpKdDCcbdEkhC+
         qBSZiyRIuw8jl5mqGSCigKArM4o3Z+/IcgAhtxFl/HZvY9ySIue9Gonihvn+NTcCMNRB
         9Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbYEH0bK6c1spCCH0RHfSscRq2p/YYpBz/KqOzM+cU8=;
        b=n/FyIUhQB2mT6ORJHAq1ofQsH/kQx/G4FyMcDqjy5ir1/Z57utDlhCWhxUS1YlDNC9
         PTq5fWKZvrNo8+gZalRSYzP8dOwS4VCNWAscQWlc07CDnHlxPEXWRmLTY8jShKYwK5nA
         rKt1+G1Ais1wMzszN5qr6lCiouz6+iCvJskkv9smNrWEU8AouWwmWmpuYjxjmCL/i52R
         MJOLZI7hyHpTCzxokxhQyEeTzMx23PgW3l4kvjqTkhwYTzIEn1nN5V7p8bl1iWE16I4A
         UVLaNmeZG2xSBjSkbh6+AIdrPXjil9U0BVB5O09bSirAXiBYENzmKgL9PaVa81TUuV3Q
         ySEw==
X-Gm-Message-State: AOAM530RoZFtnWsRHQtYlSggd8WHfabtXfWeX2fnW7c8XOO/qqGDE4nr
        qoH9i9vHB6XM72QeSf8nOs4=
X-Google-Smtp-Source: ABdhPJxh7iPVXR3zMeNTtuuceKO6zpYpaIMyxEhgXRlQCiYkY5NZ9lZ4nnajD/5kpjNV2cC+gvJolg==
X-Received: by 2002:a05:622a:1192:: with SMTP id m18mr21910620qtk.27.1617029357105;
        Mon, 29 Mar 2021 07:49:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6ffc])
        by smtp.gmail.com with ESMTPSA id p5sm13662831qkj.35.2021.03.29.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:49:16 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        Chris Down <chris@chrisdown.name>
Subject: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Date:   Mon, 29 Mar 2021 07:48:25 -0700
Message-Id: <20210329144829.1834347-4-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329144829.1834347-1-schatzberg.dan@gmail.com>
References: <20210329144829.1834347-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
---
 drivers/block/loop.c       | 61 +++++++++++++++++++++++++-------------
 drivers/block/loop.h       |  3 +-
 include/linux/memcontrol.h |  6 ++++
 kernel/cgroup/cgroup.c     |  1 +
 mm/memcontrol.c            |  1 +
 5 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5c18e6b856c2..96ade57c9f7c 100644
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
 
@@ -945,7 +941,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (!cmd->css)
+	if (!cmd->blkcg_css)
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -953,10 +949,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -968,13 +964,18 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -1298,7 +1299,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 				idle_list) {
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2103,13 +2104,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -2121,13 +2127,28 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
@@ -2206,7 +2227,7 @@ static void loop_free_idle_workers(struct timer_list *timer)
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
index 4064c9dda534..df42be35b5fb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1178,6 +1178,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
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
index e049edd66776..8c84a5374238 100644
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
index adc618814fd2..4aacdf06c6c8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -78,6 +78,7 @@ struct mem_cgroup *root_mem_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
+EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
 
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket;
-- 
2.30.2

