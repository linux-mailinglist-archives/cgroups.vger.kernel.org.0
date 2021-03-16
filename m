Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB50833D7C4
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhCPPhh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhCPPhc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 11:37:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D151FC06174A;
        Tue, 16 Mar 2021 08:37:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t4so35670472qkp.1;
        Tue, 16 Mar 2021 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SADjSKEOkix4t8p9x6JY890dWdHLGsY9Rc7Lg6faQoU=;
        b=rM8fq07zA9C4bo9WSbloq+ek277Q5kGSB7HNIy5MooE0Bf/vReCLqO4IviXlNiZ2aw
         gFCQU9fv/bm/p05hS5ZbsOFJ+grHxZU2+2COb0cuhEMZurcChMHtmgh/wQBzpehMLhBI
         7u5utpXXm68vTqK72bGlfjCek7+nFC7VbUauxGyzLmY+68pwX4dfEOm3HM+kkzlwOZZu
         aoK9mYEyMOmLn4nf4iF05Zkme8X9tDhtgVeDxLr1SpsYTE+PyelRbgcrL7W9/EtqeXLw
         mXP1Rs1RBVP+kUdU5RkduPWn1/dpECrMQGZzo+5ioaoNCumIxQ9jdLWS/KWgOAgCUwcf
         4gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SADjSKEOkix4t8p9x6JY890dWdHLGsY9Rc7Lg6faQoU=;
        b=dvYTd1y0T5bHako3qX5y0bER4y2rL5k7ZtFDWTjDabekNZtyp0ZWH6itEgas2htxEA
         rkwTfM15axoiIjMU4dTvbLB0FVb3gJn+cB3/9na4uLeXiqSc472HKa7wEPAmCxzhW9Di
         7YgXQVAwB7wdPyzbKH+VIkg0o6zvbDdm9Elw0Rtv2Lj85iejEn8BwrkL3d+NlBWN1k9Z
         IlypKwuUTNH+a6/dNJ1Skr9g4/ObRbBWVIvOnXR5GV4TeZN7ln7cZqp4sxmLzEXdD4kO
         SgxUm+pLsrkZn5HskVKmBoYbQwfKIq1hvAJxE7hgWabjGoyLUN9uSSJtNUeGbM4NigZe
         CaMg==
X-Gm-Message-State: AOAM533wLiWnzzQYNZY0IJeMR1EQG+1+wWIPtcLt1MrsK9Re1mfsFu24
        vHqlu3NdjyFHOEXfy794NgK8qWINjzicgw==
X-Google-Smtp-Source: ABdhPJy7GZTEmdCMo498WUqWo9a2uGPWdWpqsedqeFm0EtTYld1vhYQOY8G7RBbK3kSdSt6fd4aawQ==
X-Received: by 2002:a37:7b41:: with SMTP id w62mr195775qkc.256.1615909051073;
        Tue, 16 Mar 2021 08:37:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1ee])
        by smtp.gmail.com with ESMTPSA id h11sm10255114qtp.24.2021.03.16.08.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:37:30 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Date:   Tue, 16 Mar 2021 08:36:52 -0700
Message-Id: <20210316153655.500806-4-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316153655.500806-1-schatzberg.dan@gmail.com>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
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
 include/linux/memcontrol.h | 11 +++++++
 kernel/cgroup/cgroup.c     |  1 +
 mm/memcontrol.c            |  1 +
 5 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5c080af73caa..6cf3086a2e75 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,6 +77,7 @@
 #include <linux/uio.h>
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
+#include <linux/sched/mm.h>
 
 #include "loop.h"
 
@@ -515,8 +516,6 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
-	if (cmd->css)
-		css_put(cmd->css);
 	cmd->ret = ret;
 	lo_rw_aio_do_completion(cmd);
 }
@@ -577,8 +576,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
-	if (cmd->css)
-		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -586,7 +583,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
@@ -927,7 +923,7 @@ struct loop_worker {
 	struct list_head cmd_list;
 	struct list_head idle_list;
 	struct loop_device *lo;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
 	unsigned long last_ran_at;
 };
 
@@ -944,7 +940,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (!cmd->css)
+	if (!cmd->blkcg_css)
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -952,10 +948,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -967,13 +963,18 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -1297,7 +1298,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 				idle_list) {
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2102,13 +2103,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -2120,13 +2126,28 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
@@ -2205,7 +2226,7 @@ static void loop_free_idle_workers(struct timer_list *timer)
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
index 0c04d39a7967..fd5dd961d01f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1187,6 +1187,17 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
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
index 9153b20e5cc6..94c88f7221c5 100644
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
index 9a1b23ed3412..f05501669e29 100644
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

