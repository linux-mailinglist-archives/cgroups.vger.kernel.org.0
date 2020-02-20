Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE81166388
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgBTQwp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 11:52:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37750 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQwo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 11:52:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3343196qtk.4;
        Thu, 20 Feb 2020 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFqJ14YKY+5wy3KCvZ+515HEc/MVkRiy5DoJCFVvdM4=;
        b=ounh9xWSSx7BkWdsIV7CUBQbJ3a9Lg44mK+wLrArRT1iZjJcWysvsqbKEJMH64eLWQ
         EYCWwBvoIx+I67W8yDM38s66MmDgzvuFur4v2Xnp51FRfZXONqQp5PuzIk/Y0tKRUT6Z
         //wAa49WHf2IRfdxjW/dyDbhiSSJuLK6QKAnawcTEnIB+uIczylEFdmC05EoYhCvB983
         h/wpOxBdYm15yALIdACfemBPlnIPPaSS6jYtpSuUDVonvTbQtL63FK6obk6a7s60vh2+
         zKtlq8fV+J4bAGdJZB27jtxJbV3egGZPSSsf4ppgKNy4kxNgY81ITftVX2l+H454QXpd
         FYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFqJ14YKY+5wy3KCvZ+515HEc/MVkRiy5DoJCFVvdM4=;
        b=hepV1ZEpJQ/MyHld3zyPZu0saq7vD5VZXgJITEf7n88ohhPKxJ/R18dYG9uP6M9YMa
         PygVbhYlhyB61TntKPBaWwomx/GBu/WVtrCXr+zmPtzNBr5YZUC8n9q2sWunEtGrqaoL
         800yw6XI9YOyhg5R+QhPCMbUiokR//AT1G01MxCCrqowJWJvDFiKSN1Au3pv6pKSTGJg
         Y/R3UsXi94OF+TlW/nO7Nsxju6TdKaphEBtK1Jpyvlged/zIt4Yfj+t1kXQwOjLF3560
         A4XJ0uBdFAJnAVi2j5+aqu4T0iuTWh5G2bM2/q6YoCdKW0V0koD9LDzEsnnN86NMfalk
         4i3g==
X-Gm-Message-State: APjAAAX8qDBKZaZ1jNLB5WDAS1x7dD0vdy8a6j/8YzSYBFth3bLAPXJY
        KPjyCywx61HErbpnIBi7enk=
X-Google-Smtp-Source: APXvYqySmGLf8naIjHM7lRSfnO3lL50yvtDB/fzEXPc6UkiyNWC0qCVyKSnBLYOg/Xwkb1XOvYVLXA==
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr27604183qtq.388.1582217563077;
        Thu, 20 Feb 2020 08:52:43 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:500::3:edb0])
        by smtp.gmail.com with ESMTPSA id t55sm43567qte.24.2020.02.20.08.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:52:42 -0800 (PST)
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
Subject: [PATCH v3 3/3] loop: Charge i/o to mem and blk cg
Date:   Thu, 20 Feb 2020 11:51:53 -0500
Message-Id: <78060dcbf6578b4da6081f9f48b24b33726c5083.1582216295.git.schatzberg.dan@gmail.com>
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

The current code only associates with the existing blkcg when aio is
used to access the backing file. This patch covers all types of i/o to
the backing file and also associates the memcg so if the backing file is
on tmpfs, memory is charged appropriately.

This patch also exports cgroup_get_e_css so it can be used by the loop
module.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 drivers/block/loop.c       | 59 ++++++++++++++++++++++++--------------
 drivers/block/loop.h       |  3 +-
 include/linux/memcontrol.h |  6 ++++
 kernel/cgroup/cgroup.c     |  1 +
 4 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 78e5005c6742..cc091a66b0d0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,6 +77,7 @@
 #include <linux/uio.h>
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
+#include <linux/sched/mm.h>
 
 #include "loop.h"
 
@@ -134,7 +135,7 @@ static struct loop_func_table xor_funcs = {
 	.number = LO_CRYPT_XOR,
 	.transfer = transfer_xor,
 	.init = xor_init
-}; 
+};
 
 /* xfer_funcs[0] is special - its release function is never called */
 static struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
@@ -504,8 +505,6 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
-	if (cmd->css)
-		css_put(cmd->css);
 	cmd->ret = ret;
 	lo_rw_aio_do_completion(cmd);
 }
@@ -566,8 +565,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
-	if (cmd->css)
-		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -575,7 +572,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
@@ -913,7 +909,7 @@ struct loop_worker {
 	struct list_head cmd_list;
 	struct list_head idle_list;
 	struct loop_device *lo;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
 	unsigned long last_ran_at;
 };
 
@@ -930,7 +926,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 
 	spin_lock_irq(&lo->lo_lock);
 
-	if (!cmd->css)
+	if (!cmd->blkcg_css)
 		goto queue_work;
 
 	node = &(lo->worker_tree.rb_node);
@@ -938,10 +934,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	while (*node) {
 		parent = *node;
 		cur_worker = container_of(*node, struct loop_worker, rb_node);
-		if ((long)cur_worker->css == (long)cmd->css) {
+		if ((long)cur_worker->blkcg_css == (long)cmd->blkcg_css) {
 			worker = cur_worker;
 			break;
-		} else if ((long)cur_worker->css < (long)cmd->css) {
+		} else if ((long)cur_worker->blkcg_css < (long)cmd->blkcg_css) {
 			node = &((*node)->rb_left);
 		} else {
 			node = &((*node)->rb_right);
@@ -954,13 +950,16 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 			GFP_NOWAIT | __GFP_NOWARN);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
-	 * rootcg worker
+	 * rootcg worker and issue the I/O as the rootcg
 	 */
-	if (!worker)
+	if (!worker) {
+		cmd->blkcg_css = NULL;
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
@@ -2007,13 +2006,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -2031,8 +2035,21 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 		goto failed;
 	}
 
+	if (cmd->blkcg_css)
+		kthread_associate_blkcg(cmd->blkcg_css);
+	if (cmd->memcg_css)
+		memalloc_use_memcg(mem_cgroup_from_css(cmd->memcg_css));
+
 	ret = do_req_filebacked(lo, rq);
- failed:
+
+	if (cmd->blkcg_css)
+		kthread_associate_blkcg(NULL);
+
+	if (cmd->memcg_css) {
+		memalloc_unuse_memcg();
+		css_put(cmd->memcg_css);
+	}
+failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
 		cmd->ret = ret ? -EIO : 0;
@@ -2106,7 +2123,7 @@ static void loop_free_idle_workers(struct timer_list *timer)
 			break;
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	if (!list_empty(&lo->idle_worker_list))
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 87fd0e372227..3e65acf7a0e9 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -74,7 +74,8 @@ struct loop_cmd {
 	long ret;
 	struct kiocb iocb;
 	struct bio_vec *bvec;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
+	struct cgroup_subsys_state *memcg_css;
 };
 
 /* Support for loadable transfer modules */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..aeb51f2ded46 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -922,6 +922,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
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
index 75f687301bbf..c3896c2e0942 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -587,6 +587,7 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	rcu_read_unlock();
 	return css;
 }
+EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 
 static void cgroup_get_live(struct cgroup *cgrp)
 {
-- 
2.17.1

