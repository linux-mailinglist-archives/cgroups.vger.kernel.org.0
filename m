Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA564742A
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2019 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbfFPKPt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jun 2019 06:15:49 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:28760 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725879AbfFPKPt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jun 2019 06:15:49 -0400
X-ASG-Debug-ID: 1560680133-0e408815c34ee750002-hhPYk8
Received: from BJEXCAS01.didichuxing.com (bogon [172.20.36.235]) by bsf01.didichuxing.com with ESMTP id SJpABxcjGMXFEe8p; Sun, 16 Jun 2019 18:15:43 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 16 Jun
 2019 18:15:38 +0800
Date:   Sun, 16 Jun 2019 18:15:37 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [PATCH v2 2/4] null_blk: add support weighted round robin submition
 queue
Message-ID: <c68d416251e1f2ef4c4fec06762e13bd6b5b2def.1560679439.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v2 2/4] null_blk: add support weighted round robin submition
 queue
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1560679439.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.235]
X-Barracuda-Start-Time: 1560680134
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 12731
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72767
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/block/null_blk.h      |   7 +
 drivers/block/null_blk_main.c | 294 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 288 insertions(+), 13 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..aa53c4b6de49 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -12,6 +12,7 @@
 
 struct nullb_cmd {
 	struct list_head list;
+	struct list_head wrr_node;
 	struct llist_node ll_list;
 	struct __call_single_data csd;
 	struct request *rq;
@@ -23,6 +24,8 @@ struct nullb_cmd {
 };
 
 struct nullb_queue {
+	spinlock_t wrr_lock;
+	struct list_head wrr_head;
 	unsigned long *tag_map;
 	wait_queue_head_t wait;
 	unsigned int queue_depth;
@@ -83,6 +86,10 @@ struct nullb {
 	struct nullb_queue *queues;
 	unsigned int nr_queues;
 	char disk_name[DISK_NAME_LEN];
+
+	struct task_struct *wrr_thread;
+	atomic_long_t wrrd_inflight;
+	wait_queue_head_t wrrd_wait;
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 447d635c79a2..100fc0e13036 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -4,6 +4,8 @@
  * Shaohua Li <shli@fb.com>
  */
 #include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/blk-cgroup.h>
 
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
@@ -75,6 +77,7 @@ enum {
 	NULL_IRQ_NONE		= 0,
 	NULL_IRQ_SOFTIRQ	= 1,
 	NULL_IRQ_TIMER		= 2,
+	NULL_IRQ_WRR		= 3,
 };
 
 enum {
@@ -87,10 +90,23 @@ static int g_no_sched;
 module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
+static int g_tagset_nr_maps = 1;
 static int g_submit_queues = 1;
 module_param_named(submit_queues, g_submit_queues, int, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
+#define NULLB_SUBMIT_QUEUE(attr, count) \
+static int g_submit_queues_##attr = count; \
+module_param_named(submit_queues_##attr, g_submit_queues_##attr, int, 0444); \
+MODULE_PARM_DESC(submit_queues_##attr, "Number of " #attr " submission queues");
+
+NULLB_SUBMIT_QUEUE(default, 1)
+NULLB_SUBMIT_QUEUE(read, 0)
+NULLB_SUBMIT_QUEUE(poll, 0)
+NULLB_SUBMIT_QUEUE(wrr_low, 0)
+NULLB_SUBMIT_QUEUE(wrr_medium, 0)
+NULLB_SUBMIT_QUEUE(wrr_high, 0)
+
 static int g_home_node = NUMA_NO_NODE;
 module_param_named(home_node, g_home_node, int, 0444);
 MODULE_PARM_DESC(home_node, "Home node for the device");
@@ -158,7 +174,7 @@ static int g_irqmode = NULL_IRQ_SOFTIRQ;
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
 {
 	return null_param_store_val(str, &g_irqmode, NULL_IRQ_NONE,
-					NULL_IRQ_TIMER);
+					NULL_IRQ_WRR);
 }
 
 static const struct kernel_param_ops null_irqmode_param_ops = {
@@ -643,6 +659,22 @@ static void null_cmd_end_timer(struct nullb_cmd *cmd)
 	hrtimer_start(&cmd->timer, kt, HRTIMER_MODE_REL);
 }
 
+static void null_cmd_wrr_insert(struct nullb_cmd *cmd)
+{
+	struct nullb_queue *nq = cmd->nq;
+	struct nullb *nullb = nq->dev->nullb;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&cmd->wrr_node);
+	spin_lock_irqsave(&nq->wrr_lock, flags);
+	list_add_tail(&cmd->wrr_node, &nq->wrr_head);
+	spin_unlock_irqrestore(&nq->wrr_lock, flags);
+
+	/* wake up wrr_thread if needed */
+	if (atomic_long_inc_return(&nullb->wrrd_inflight) == 1)
+		wake_up_interruptible(&nullb->wrrd_wait);
+}
+
 static void null_complete_rq(struct request *rq)
 {
 	end_cmd(blk_mq_rq_to_pdu(rq));
@@ -1236,6 +1268,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 	case NULL_IRQ_TIMER:
 		null_cmd_end_timer(cmd);
 		break;
+	case NULL_IRQ_WRR:
+		null_cmd_wrr_insert(cmd);
+		break;
 	}
 	return BLK_STS_OK;
 }
@@ -1351,10 +1386,64 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return null_handle_cmd(cmd);
 }
 
+static inline int null_hctx_nr_queue(int type)
+{
+	int ret;
+
+	switch (type) {
+	case HCTX_TYPE_DEFAULT:
+		ret = g_submit_queues_default;
+		break;
+	case HCTX_TYPE_READ:
+		ret = g_submit_queues_read;
+		break;
+	case HCTX_TYPE_POLL:
+		ret = g_submit_queues_poll;
+		break;
+	case HCTX_TYPE_WRR_LOW:
+		ret = g_submit_queues_wrr_low;
+		break;
+	case HCTX_TYPE_WRR_MEDIUM:
+		ret = g_submit_queues_wrr_medium;
+		break;
+	case HCTX_TYPE_WRR_HIGH:
+		ret = g_submit_queues_wrr_high;
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int null_map_queues(struct blk_mq_tag_set *set)
+{
+	int i, offset;
+
+	for (i = 0, offset = 0; i < set->nr_maps; i++) {
+		struct blk_mq_queue_map *map = &set->map[i];
+
+		map->nr_queues = null_hctx_nr_queue(i);
+
+		if (!map->nr_queues) {
+			BUG_ON(i == HCTX_TYPE_DEFAULT);
+			continue;
+		}
+
+		map->queue_offset = offset;
+		blk_mq_map_queues(map);
+		offset += map->nr_queues;
+	}
+
+	return 0;
+}
+
 static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
 	.complete	= null_complete_rq,
 	.timeout	= null_timeout_rq,
+	.map_queues	= null_map_queues,
 };
 
 static void cleanup_queue(struct nullb_queue *nq)
@@ -1397,6 +1486,9 @@ static void null_del_dev(struct nullb *nullb)
 	cleanup_queues(nullb);
 	if (null_cache_active(nullb))
 		null_free_device_storage(nullb->dev, true);
+
+	if (dev->irqmode == NULL_IRQ_WRR)
+		kthread_stop(nullb->wrr_thread);
 	kfree(nullb);
 	dev->nullb = NULL;
 }
@@ -1435,6 +1527,8 @@ static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
 	init_waitqueue_head(&nq->wait);
 	nq->queue_depth = nullb->queue_depth;
 	nq->dev = nullb->dev;
+	INIT_LIST_HEAD(&nq->wrr_head);
+	spin_lock_init(&nq->wrr_lock);
 }
 
 static void null_init_queues(struct nullb *nullb)
@@ -1549,6 +1643,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 						g_submit_queues;
 	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
 						g_hw_queue_depth;
+	set->nr_maps = g_tagset_nr_maps;
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	= sizeof(struct nullb_cmd);
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
@@ -1576,7 +1671,7 @@ static void null_validate_conf(struct nullb_device *dev)
 		dev->submit_queues = 1;
 
 	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
-	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
+	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_WRR);
 
 	/* Do memory allocation, so set blocking */
 	if (dev->memory_backed)
@@ -1616,6 +1711,72 @@ static bool null_setup_fault(void)
 	return true;
 }
 
+static inline void null_wrr_handle_map(struct nullb *nullb,
+				struct blk_mq_queue_map *map, int batch)
+{
+	int i, nr;
+	struct nullb_queue *nq;
+	struct nullb_cmd *cmd,*tmp;
+	unsigned long flags;
+
+	for (i = 0; i < map->nr_queues; i++) {
+		nq = &nullb->queues[i + map->queue_offset];
+		nr = batch;
+		spin_lock_irqsave(&nq->wrr_lock, flags);
+		list_for_each_entry_safe(cmd, tmp, &nq->wrr_head, wrr_node) {
+			list_del(&cmd->wrr_node);
+			blk_mq_end_request(cmd->rq, cmd->error);
+			atomic_long_dec(&nullb->wrrd_inflight);
+			if (nr-- == 0)
+				break;
+		}
+		spin_unlock_irqrestore(&nq->wrr_lock, flags);
+	}
+}
+
+static int null_wrr_thread(void *data)
+{
+	struct nullb *nullb = (struct nullb *)data;
+	struct blk_mq_tag_set *set = nullb->tag_set;
+	struct blk_mq_queue_map	*map;
+	DEFINE_WAIT(wait);
+
+	while (1) {
+		if (kthread_should_stop())
+			goto out;
+
+		cond_resched();
+
+		/* handle each hardware queue in weighted round robin way */
+
+		map = &set->map[HCTX_TYPE_WRR_HIGH];
+		null_wrr_handle_map(nullb, map, 8);
+
+		map = &set->map[HCTX_TYPE_WRR_MEDIUM];
+		null_wrr_handle_map(nullb, map, 4);
+
+		map = &set->map[HCTX_TYPE_WRR_LOW];
+		null_wrr_handle_map(nullb, map, 1);
+
+		map = &set->map[HCTX_TYPE_POLL];
+		null_wrr_handle_map(nullb, map, 1);
+
+		map = &set->map[HCTX_TYPE_READ];
+		null_wrr_handle_map(nullb, map, 1);
+
+		map = &set->map[HCTX_TYPE_DEFAULT];
+		null_wrr_handle_map(nullb, map, 1);
+
+		prepare_to_wait(&nullb->wrrd_wait, &wait, TASK_INTERRUPTIBLE);
+		if (0 == atomic_long_read(&nullb->wrrd_inflight))
+			schedule();
+		finish_wait(&nullb->wrrd_wait, &wait);
+	}
+
+out:
+	return 0;
+}
+
 static int null_add_dev(struct nullb_device *dev)
 {
 	struct nullb *nullb;
@@ -1706,15 +1867,27 @@ static int null_add_dev(struct nullb_device *dev)
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
+	if (dev->irqmode == NULL_IRQ_WRR) {
+		init_waitqueue_head(&nullb->wrrd_wait);
+		atomic_long_set(&nullb->wrrd_inflight, 0);
+		nullb->wrr_thread = kthread_run(null_wrr_thread, (void *)nullb,
+			"wrrd_%s", nullb->disk_name);
+		if (!nullb->wrr_thread)
+			goto out_cleanup_zone;
+	}
+
 	rv = null_gendisk_register(nullb);
 	if (rv)
-		goto out_cleanup_zone;
+		goto out_cleanup_wrrd;
 
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
 
 	return 0;
+out_cleanup_wrrd:
+	if (dev->irqmode == NULL_IRQ_WRR)
+		kthread_stop(nullb->wrr_thread);
 out_cleanup_zone:
 	if (dev->zoned)
 		null_zone_exit(dev);
@@ -1731,6 +1904,106 @@ static int null_add_dev(struct nullb_device *dev)
 	return rv;
 }
 
+static int null_verify_queues(void)
+{
+	int queues, nr;
+
+	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
+		if (g_submit_queues != nr_online_nodes) {
+			pr_warn("null_blk: submit_queues param is set to %u.\n",
+							nr_online_nodes);
+			g_submit_queues = nr_online_nodes;
+		}
+	} else if (g_submit_queues > nr_cpu_ids)
+		g_submit_queues = nr_cpu_ids;
+	else if (g_submit_queues <= 0)
+		g_submit_queues = 1;
+
+	/* at least leave one queue for default */
+	g_submit_queues_default = 1;
+	queues = g_submit_queues - 1;
+	if (queues == 0)
+		goto def;
+
+	/* read queues */
+	nr = g_submit_queues_read;
+	if (nr < 0 || nr > queues) {
+		pr_warn("null_blk: invalid read queue count\n");
+		return -EINVAL;
+	}
+	g_tagset_nr_maps++;
+	queues -= nr;
+	if (queues == 0)
+		goto read;
+
+	/* poll queues */
+	nr = g_submit_queues_poll;
+	if (nr < 0 || nr > queues) {
+		pr_warn("null_blk: invalid poll queue count\n");
+		return -EINVAL;
+	}
+	g_tagset_nr_maps++;
+	queues -= nr;
+	if (queues == 0)
+		goto poll;
+
+	/* wrr_low queues */
+	nr = g_submit_queues_wrr_low;
+	if (nr < 0 || nr > queues) {
+		pr_warn("null_blk: invalid wrr_low queue count\n");
+		return -EINVAL;
+	}
+	g_tagset_nr_maps++;
+	queues -= nr;
+	if (queues == 0)
+		goto wrr_low;
+
+	/* wrr_medium queues */
+	nr = g_submit_queues_wrr_medium;
+	if (nr < 0 || nr > queues) {
+		pr_warn("null_blk: invalid wrr_medium queue count\n");
+		return -EINVAL;
+	}
+	g_tagset_nr_maps++;
+	queues -= nr;
+	if (queues == 0)
+		goto wrr_medium;
+
+	/* wrr_high queues */
+	nr = g_submit_queues_wrr_high;
+	if (nr < 0 || nr > queues) {
+		pr_warn("null_blk: invalid wrr_medium queue count\n");
+		return -EINVAL;
+	}
+	g_tagset_nr_maps++;
+	queues -= nr;
+
+	/* add all others queue to default group */
+	g_submit_queues_default += queues;
+
+	goto out;
+
+def:
+	g_submit_queues_read = 0;
+read:
+	g_submit_queues_poll = 0;
+poll:
+	g_submit_queues_wrr_low = 0;
+wrr_low:
+	g_submit_queues_wrr_medium = 0;
+wrr_medium:
+	g_submit_queues_wrr_high = 0;
+out:
+	pr_info("null_blk: total submit queues:%d, nr_map:%d, default:%d, "
+		"read:%d, poll:%d, wrr_low:%d, wrr_medium:%d wrr_high:%d\n",
+		g_submit_queues, g_tagset_nr_maps, g_submit_queues_default,
+		g_submit_queues_read, g_submit_queues_poll,
+		g_submit_queues_wrr_low, g_submit_queues_wrr_medium,
+		g_submit_queues_wrr_high);
+
+	return 0;
+}
+
 static int __init null_init(void)
 {
 	int ret = 0;
@@ -1758,16 +2031,11 @@ static int __init null_init(void)
 		pr_err("null_blk: legacy IO path no longer available\n");
 		return -EINVAL;
 	}
-	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
-		if (g_submit_queues != nr_online_nodes) {
-			pr_warn("null_blk: submit_queues param is set to %u.\n",
-							nr_online_nodes);
-			g_submit_queues = nr_online_nodes;
-		}
-	} else if (g_submit_queues > nr_cpu_ids)
-		g_submit_queues = nr_cpu_ids;
-	else if (g_submit_queues <= 0)
-		g_submit_queues = 1;
+
+	if (null_verify_queues()){
+		pr_err("null_blk: invalid submit queue parameter\n");
+		return -EINVAL;
+	}
 
 	if (g_queue_mode == NULL_Q_MQ && shared_tags) {
 		ret = null_init_tag_set(NULL, &tag_set);
-- 
2.14.1

