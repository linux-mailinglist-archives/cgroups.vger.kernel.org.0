Return-Path: <cgroups+bounces-2357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3589A9B6
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 10:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78421F2252B
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF773770C;
	Sat,  6 Apr 2024 08:09:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1A2837D;
	Sat,  6 Apr 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390959; cv=none; b=t6wrR18X+osJ3AFM1DdF3otSpMKzdN1lx35HobiiedoNVN/JaPA9Qu21tlIIUHima5BDl9cwaYKgsPe4DEWG0nRakp7Sm7KONFo1uqvN28rRhceg1jiqOHsbAYnuqbrYOGsocKFAfBQ/M5ASJ2mlzYVXi+8YrbXlsWscNa3S9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390959; c=relaxed/simple;
	bh=WJeIAOXxuVPXb/26+piie2EBBu53zikCe5YpY+pHvKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLhOXy2e4nhFxUS8tcQOc9ByG6NbRnqOgIvh9Tapf7QQRIeceVtfJD0o64uhkLr8RQDebF2WOuiS8eKpG+GXVJLrXgWUrtevjkWGFVVHPfNmJhoSrGoGst11/aZ4qbrKZpYyE0/mmeFc/4zmLvJymky+kFwoN3fIL/BsI3unGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSg91x42z4f3jkj;
	Sat,  6 Apr 2024 16:09:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8F53C1A0BD3;
	Sat,  6 Apr 2024 16:09:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAjAxFmnZTkJA--.2125S10;
	Sat, 06 Apr 2024 16:09:13 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	jhs@mojatatu.com,
	svenjoac@gmx.de,
	raven@themaw.net,
	pctammela@mojatatu.com,
	yukuai3@huawei.com,
	qde@naccy.de,
	zhaotianrui@loongson.cn
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 6/6] blk-throtl: switch to use rq_qos
Date: Sat,  6 Apr 2024 16:00:59 +0800
Message-Id: <20240406080059.2248314-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAjAxFmnZTkJA--.2125S10
X-Coremail-Antispam: 1UD129KBjvAXoWfuF4xWr45WF1kKr4kJFyUAwb_yoW8urW3Co
	WfJFZ7XFn5K348trWYq3yxAr1fuw4vqr15ZrnYgrn5Z3W8Aa4jq347KFy5GFyfWF1IyF4x
	AF1jqw4FvF4xGrZ5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	OBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To avoid exposing blk-throttle internal implementation to general block
layer.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c     |   2 -
 block/blk-core.c       |   4 +-
 block/blk-merge.c      |   2 +-
 block/blk-mq-debugfs.c |   2 +
 block/blk-rq-qos.c     |  13 ++
 block/blk-rq-qos.h     |  11 ++
 block/blk-sysfs.c      |   1 -
 block/blk-throttle.c   | 387 +++++++++++++++++++++++------------------
 block/blk-throttle.h   |  50 ------
 block/genhd.c          |   3 -
 include/linux/blkdev.h |   4 -
 11 files changed, 246 insertions(+), 233 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ada9258f78bc..0eede352ece1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -32,7 +32,6 @@
 #include "blk.h"
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
-#include "blk-throttle.h"
 
 static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
 
@@ -1473,7 +1472,6 @@ int blkcg_init_disk(struct gendisk *disk)
 void blkcg_exit_disk(struct gendisk *disk)
 {
 	blkg_destroy_all(disk);
-	blk_throtl_exit(disk);
 }
 
 static void blkcg_exit(struct task_struct *tsk)
diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..27ccc55bac06 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -48,7 +48,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-cgroup.h"
-#include "blk-throttle.h"
+#include "blk-rq-qos.h"
 #include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
@@ -832,7 +832,7 @@ void submit_bio_noacct(struct bio *bio)
 		goto not_supported;
 	}
 
-	if (blk_throtl_bio(bio))
+	if (rq_qos_throttle_bio(q, bio))
 		return;
 	submit_bio_noacct_nocheck(bio);
 	return;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2a06fd33039d..eb08b2d91ec5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -14,9 +14,9 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-cgroup.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-throttle.h"
 
 static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
 {
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 94668e72ab09..b7613b811d86 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -756,6 +756,8 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
+	case RQ_QOS_THROTTLE:
+		return "throttle";
 	case RQ_QOS_WBT:
 		return "wbt";
 	case RQ_QOS_LATENCY:
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index dd7310c94713..fc2fc4052708 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -59,6 +59,19 @@ void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq)
 	} while (rqos);
 }
 
+bool __rq_qos_throttle_bio(struct rq_qos *rqos, struct bio *bio)
+{
+	do {
+		if (rqos->ops->throttle_bio &&
+		    rqos->ops->throttle_bio(rqos, bio))
+			return true;
+
+		rqos = rqos->next;
+	} while (rqos);
+
+	return false;
+}
+
 void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio)
 {
 	do {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..03d8daab8ed6 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,6 +14,7 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
+	RQ_QOS_THROTTLE,
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
@@ -35,6 +36,7 @@ struct rq_qos {
 };
 
 struct rq_qos_ops {
+	bool (*throttle_bio)(struct rq_qos *, struct bio *);
 	void (*throttle)(struct rq_qos *, struct bio *);
 	void (*track)(struct rq_qos *, struct request *, struct bio *);
 	void (*merge)(struct rq_qos *, struct request *, struct bio *);
@@ -104,6 +106,7 @@ void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_done(struct rq_qos *rqos, struct request *rq);
 void __rq_qos_issue(struct rq_qos *rqos, struct request *rq);
 void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq);
+bool __rq_qos_throttle_bio(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio);
@@ -144,6 +147,14 @@ static inline void rq_qos_done_bio(struct bio *bio)
 	}
 }
 
+static inline bool rq_qos_throttle_bio(struct request_queue *q, struct bio *bio)
+{
+	if (q->rq_qos)
+		return __rq_qos_throttle_bio(q->rq_qos, bio);
+
+	return false;
+}
+
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
 	if (q->rq_qos) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1e2a0b18360c..7f5ece4b8f9e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -18,7 +18,6 @@
 #include "blk-rq-qos.h"
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
-#include "blk-throttle.h"
 
 struct queue_sysfs_entry {
 	struct attribute attr;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5c16be07a594..b1ff0640a39a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/blktrace_api.h>
 #include "blk.h"
+#include "blk-rq-qos.h"
 #include "blk-cgroup-rwstat.h"
 #include "blk-stat.h"
 #include "blk-throttle.h"
@@ -45,8 +46,8 @@ struct avg_latency_bucket {
 	bool valid;
 };
 
-struct throtl_data
-{
+struct throtl_data {
+	struct rq_qos rqos;
 	/* service tree for active throtl groups */
 	struct throtl_service_queue service_queue;
 
@@ -65,6 +66,19 @@ struct throtl_data
 
 static void throtl_pending_timer_fn(struct timer_list *t);
 
+static struct throtl_data *rqos_to_td(struct rq_qos *rqos)
+{
+	if (!rqos)
+		return NULL;
+
+	return container_of(rqos, struct throtl_data, rqos);
+}
+
+static struct throtl_data *q_to_td(struct request_queue *q)
+{
+	return rqos_to_td(rq_qos_id(q, RQ_QOS_THROTTLE));
+}
+
 static inline struct blkcg_gq *tg_to_blkg(struct throtl_grp *tg)
 {
 	return pd_to_blkg(&tg->pd);
@@ -293,7 +307,7 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
-	struct throtl_data *td = blkg->q->td;
+	struct throtl_data *td = q_to_td(blkg->q);
 	struct throtl_service_queue *sq = &tg->service_queue;
 
 	/*
@@ -1230,6 +1244,192 @@ static bool tg_conf_updated(struct throtl_grp *tg, bool global)
 	return has_rules;
 }
 
+static void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	spin_lock_irq(&q->queue_lock);
+	/*
+	 * queue_lock is held, rcu lock is not needed here technically.
+	 * However, rcu lock is still held to emphasize that following
+	 * path need RCU protection and to prevent warning from lockdep.
+	 */
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+		struct throtl_service_queue *sq = &tg->service_queue;
+
+		/*
+		 * Set the flag to make sure throtl_pending_timer_fn() won't
+		 * stop until all throttled bios are dispatched.
+		 */
+		tg->flags |= THROTL_TG_CANCELING;
+
+		/*
+		 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
+		 * will be inserted to service queue without THROTL_TG_PENDING
+		 * set in tg_update_disptime below. Then IO dispatched from
+		 * child in tg_dispatch_one_bio will trigger double insertion
+		 * and corrupt the tree.
+		 */
+		if (!(tg->flags & THROTL_TG_PENDING))
+			continue;
+
+		/*
+		 * Update disptime after setting the above flag to make sure
+		 * throtl_select_dispatch() won't exit without dispatching.
+		 */
+		tg_update_disptime(tg);
+
+		throtl_schedule_pending_timer(sq, jiffies + 1);
+	}
+	rcu_read_unlock();
+	spin_unlock_irq(&q->queue_lock);
+}
+
+static void blk_throtl_exit(struct rq_qos *rqos)
+{
+	struct throtl_data *td = rqos_to_td(rqos);
+
+	blk_throtl_cancel_bios(td->queue);
+	/*
+	 * There are no rules, all throttled BIO should be dispatched
+	 * immediately.
+	 */
+	wait_event(destroy_wait, !td_has_io(td));
+
+	del_timer_sync(&td->service_queue.pending_timer);
+	cancel_work_sync(&td->dispatch_work);
+	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_throtl);
+	kfree(td);
+}
+
+static bool blk_should_throtl(struct throtl_grp *tg, struct bio *bio)
+{
+	int rw = bio_data_dir(bio);
+
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+					bio->bi_iter.bi_size);
+		}
+		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	}
+
+	/* iops limit is always counted */
+	if (tg->has_rules_iops[rw])
+		return true;
+
+	if (tg->has_rules_bps[rw] && !bio_flagged(bio, BIO_BPS_THROTTLED))
+		return true;
+
+	return false;
+}
+
+static bool __blk_throtl_bio(struct throtl_grp *tg, struct bio *bio)
+{
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+	struct throtl_qnode *qn = NULL;
+	struct throtl_service_queue *sq;
+	bool rw = bio_data_dir(bio);
+	bool throttled = false;
+	struct throtl_data *td = tg->td;
+
+	rcu_read_lock();
+	spin_lock_irq(&q->queue_lock);
+	sq = &tg->service_queue;
+
+	while (true) {
+		if (tg->last_low_overflow_time[rw] == 0)
+			tg->last_low_overflow_time[rw] = jiffies;
+		/* throtl is FIFO - if bios are already queued, should queue */
+		if (sq->nr_queued[rw])
+			break;
+
+		/* if above limits, break to queue */
+		if (!tg_may_dispatch(tg, bio, NULL)) {
+			tg->last_low_overflow_time[rw] = jiffies;
+			break;
+		}
+
+		/* within limits, let's charge and dispatch directly */
+		throtl_charge_bio(tg, bio);
+
+		/*
+		 * We need to trim slice even when bios are not being queued
+		 * otherwise it might happen that a bio is not queued for
+		 * a long time and slice keeps on extending and trim is not
+		 * called for a long time. Now if limits are reduced suddenly
+		 * we take into account all the IO dispatched so far at new
+		 * low rate and * newly queued IO gets a really long dispatch
+		 * time.
+		 *
+		 * So keep on trimming slice even if bio is not queued.
+		 */
+		throtl_trim_slice(tg, rw);
+
+		/*
+		 * @bio passed through this layer without being throttled.
+		 * Climb up the ladder.  If we're already at the top, it
+		 * can be executed directly.
+		 */
+		qn = &tg->qnode_on_parent[rw];
+		sq = sq->parent_sq;
+		tg = sq_to_tg(sq);
+		if (!tg) {
+			bio_set_flag(bio, BIO_BPS_THROTTLED);
+			goto out_unlock;
+		}
+	}
+
+	/* out-of-limit, queue to @tg */
+	throtl_log(sq, "[%c] bio. bdisp=%llu sz=%u bps=%llu iodisp=%u iops=%u queued=%d/%d",
+		   rw == READ ? 'R' : 'W',
+		   tg->bytes_disp[rw], bio->bi_iter.bi_size,
+		   tg_bps_limit(tg, rw),
+		   tg->io_disp[rw], tg_iops_limit(tg, rw),
+		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
+
+	tg->last_low_overflow_time[rw] = jiffies;
+
+	td->nr_queued[rw]++;
+	throtl_add_bio_tg(bio, qn, tg);
+	throttled = true;
+
+	/*
+	 * Update @tg's dispatch time and force schedule dispatch if @tg
+	 * was empty before @bio.  The forced scheduling isn't likely to
+	 * cause undue delay as @bio is likely to be dispatched directly if
+	 * its @tg's disptime is not in the future.
+	 */
+	if (tg->flags & THROTL_TG_WAS_EMPTY) {
+		tg_update_disptime(tg);
+		throtl_schedule_next_dispatch(tg->service_queue.parent_sq, true);
+	}
+
+out_unlock:
+	spin_unlock_irq(&q->queue_lock);
+
+	rcu_read_unlock();
+	return throttled;
+}
+
+static bool blk_throtl_bio(struct rq_qos *rqos, struct bio *bio)
+{
+	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
+
+	if (!blk_should_throtl(tg, bio))
+		return false;
+
+	return __blk_throtl_bio(tg, bio);
+}
+
+static const struct rq_qos_ops throtl_rqos_ops = {
+	.throttle_bio = blk_throtl_bio,
+	.exit = blk_throtl_exit,
+};
 static int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
@@ -1243,20 +1443,21 @@ static int blk_throtl_init(struct gendisk *disk)
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
-	/*
-	 * freeze queue before setting q->td, so that IO path won't see
-	 * q->td while policy is not activated yet.
-	 */
 	blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
-	q->td = td;
 	td->queue = q;
 
+	ret = rq_qos_add(&td->rqos, disk, RQ_QOS_THROTTLE, &throtl_rqos_ops);
+	if (ret) {
+		kfree(td);
+		goto out;
+	}
+
 	/* activate policy */
 	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
-		q->td = NULL;
+		rq_qos_del(&td->rqos);
 		kfree(td);
 		goto out;
 	}
@@ -1276,30 +1477,14 @@ static int blk_throtl_init(struct gendisk *disk)
 	return ret;
 }
 
-void blk_throtl_exit(struct gendisk *disk)
-{
-	struct request_queue *q = disk->queue;
-
-	if (!q->td)
-		return;
-
-	del_timer_sync(&q->td->service_queue.pending_timer);
-	cancel_work_sync(&q->td->dispatch_work);
-	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
-	kfree(q->td);
-	q->td = NULL;
-}
-
 static void blk_throtl_destroy(struct gendisk *disk)
 {
-	struct throtl_data *td = disk->queue->td;
+	struct throtl_data *td = q_to_td(disk->queue);
 
-	/*
-	 * There are no rules, all throttled BIO should be dispatched
-	 * immediately.
-	 */
-	wait_event(destroy_wait, !td_has_io(td));
-	blk_throtl_exit(disk);
+	lockdep_assert_held(&td->queue->rq_qos_mutex);
+
+	rq_qos_del(&td->rqos);
+	blk_throtl_exit(&td->rqos);
 }
 
 static ssize_t tg_set_conf(struct kernfs_open_file *of,
@@ -1317,7 +1502,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (ret)
 		goto out_finish;
 
-	if (!ctx.bdev->bd_queue->td) {
+	if (!q_to_td(ctx.bdev->bd_queue)) {
 		ret = blk_throtl_init(ctx.bdev->bd_disk);
 		if (ret)
 			goto out_finish;
@@ -1495,7 +1680,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	if (ret)
 		goto out_finish;
 
-	if (!ctx.bdev->bd_queue->td) {
+	if (!q_to_td(ctx.bdev->bd_queue)) {
 		ret = blk_throtl_init(ctx.bdev->bd_disk);
 		if (ret)
 			goto out_finish;
@@ -1584,144 +1769,6 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
-void blk_throtl_cancel_bios(struct gendisk *disk)
-{
-	struct request_queue *q = disk->queue;
-	struct cgroup_subsys_state *pos_css;
-	struct blkcg_gq *blkg;
-
-	if (!q->td)
-		return;
-
-	spin_lock_irq(&q->queue_lock);
-	/*
-	 * queue_lock is held, rcu lock is not needed here technically.
-	 * However, rcu lock is still held to emphasize that following
-	 * path need RCU protection and to prevent warning from lockdep.
-	 */
-	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-		struct throtl_service_queue *sq = &tg->service_queue;
-
-		/*
-		 * Set the flag to make sure throtl_pending_timer_fn() won't
-		 * stop until all throttled bios are dispatched.
-		 */
-		tg->flags |= THROTL_TG_CANCELING;
-
-		/*
-		 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
-		 * will be inserted to service queue without THROTL_TG_PENDING
-		 * set in tg_update_disptime below. Then IO dispatched from
-		 * child in tg_dispatch_one_bio will trigger double insertion
-		 * and corrupt the tree.
-		 */
-		if (!(tg->flags & THROTL_TG_PENDING))
-			continue;
-
-		/*
-		 * Update disptime after setting the above flag to make sure
-		 * throtl_select_dispatch() won't exit without dispatching.
-		 */
-		tg_update_disptime(tg);
-
-		throtl_schedule_pending_timer(sq, jiffies + 1);
-	}
-	rcu_read_unlock();
-	spin_unlock_irq(&q->queue_lock);
-}
-
-bool __blk_throtl_bio(struct bio *bio)
-{
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	struct blkcg_gq *blkg = bio->bi_blkg;
-	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg);
-	struct throtl_service_queue *sq;
-	bool rw = bio_data_dir(bio);
-	bool throttled = false;
-	struct throtl_data *td = tg->td;
-
-	rcu_read_lock();
-	spin_lock_irq(&q->queue_lock);
-	sq = &tg->service_queue;
-
-	while (true) {
-		if (tg->last_low_overflow_time[rw] == 0)
-			tg->last_low_overflow_time[rw] = jiffies;
-		/* throtl is FIFO - if bios are already queued, should queue */
-		if (sq->nr_queued[rw])
-			break;
-
-		/* if above limits, break to queue */
-		if (!tg_may_dispatch(tg, bio, NULL)) {
-			tg->last_low_overflow_time[rw] = jiffies;
-			break;
-		}
-
-		/* within limits, let's charge and dispatch directly */
-		throtl_charge_bio(tg, bio);
-
-		/*
-		 * We need to trim slice even when bios are not being queued
-		 * otherwise it might happen that a bio is not queued for
-		 * a long time and slice keeps on extending and trim is not
-		 * called for a long time. Now if limits are reduced suddenly
-		 * we take into account all the IO dispatched so far at new
-		 * low rate and * newly queued IO gets a really long dispatch
-		 * time.
-		 *
-		 * So keep on trimming slice even if bio is not queued.
-		 */
-		throtl_trim_slice(tg, rw);
-
-		/*
-		 * @bio passed through this layer without being throttled.
-		 * Climb up the ladder.  If we're already at the top, it
-		 * can be executed directly.
-		 */
-		qn = &tg->qnode_on_parent[rw];
-		sq = sq->parent_sq;
-		tg = sq_to_tg(sq);
-		if (!tg) {
-			bio_set_flag(bio, BIO_BPS_THROTTLED);
-			goto out_unlock;
-		}
-	}
-
-	/* out-of-limit, queue to @tg */
-	throtl_log(sq, "[%c] bio. bdisp=%llu sz=%u bps=%llu iodisp=%u iops=%u queued=%d/%d",
-		   rw == READ ? 'R' : 'W',
-		   tg->bytes_disp[rw], bio->bi_iter.bi_size,
-		   tg_bps_limit(tg, rw),
-		   tg->io_disp[rw], tg_iops_limit(tg, rw),
-		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
-
-	tg->last_low_overflow_time[rw] = jiffies;
-
-	td->nr_queued[rw]++;
-	throtl_add_bio_tg(bio, qn, tg);
-	throttled = true;
-
-	/*
-	 * Update @tg's dispatch time and force schedule dispatch if @tg
-	 * was empty before @bio.  The forced scheduling isn't likely to
-	 * cause undue delay as @bio is likely to be dispatched directly if
-	 * its @tg's disptime is not in the future.
-	 */
-	if (tg->flags & THROTL_TG_WAS_EMPTY) {
-		tg_update_disptime(tg);
-		throtl_schedule_next_dispatch(tg->service_queue.parent_sq, true);
-	}
-
-out_unlock:
-	spin_unlock_irq(&q->queue_lock);
-
-	rcu_read_unlock();
-	return throttled;
-}
-
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index e7f5562a32e9..147940c4a7ca 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -146,54 +146,4 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
 	return pd_to_tg(blkg_to_pd(blkg, &blkcg_policy_throtl));
 }
 
-/*
- * Internal throttling interface
- */
-#ifndef CONFIG_BLK_DEV_THROTTLING
-static inline void blk_throtl_exit(struct gendisk *disk) { }
-static inline bool blk_throtl_bio(struct bio *bio) { return false; }
-static inline void blk_throtl_cancel_bios(struct gendisk *disk) { }
-#else /* CONFIG_BLK_DEV_THROTTLING */
-void blk_throtl_exit(struct gendisk *disk);
-bool __blk_throtl_bio(struct bio *bio);
-void blk_throtl_cancel_bios(struct gendisk *disk);
-
-static inline bool blk_should_throtl(struct bio *bio)
-{
-	struct throtl_grp *tg;
-	int rw = bio_data_dir(bio);
-
-	if (!bio->bi_bdev->bd_queue->td)
-		return false;
-
-	tg = blkg_to_tg(bio->bi_blkg);
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
-			bio_set_flag(bio, BIO_CGROUP_ACCT);
-			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-					bio->bi_iter.bi_size);
-		}
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
-	}
-
-	/* iops limit is always counted */
-	if (tg->has_rules_iops[rw])
-		return true;
-
-	if (tg->has_rules_bps[rw] && !bio_flagged(bio, BIO_BPS_THROTTLED))
-		return true;
-
-	return false;
-}
-
-static inline bool blk_throtl_bio(struct bio *bio)
-{
-
-	if (!blk_should_throtl(bio))
-		return false;
-
-	return __blk_throtl_bio(bio);
-}
 #endif /* CONFIG_BLK_DEV_THROTTLING */
-
-#endif
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..9bc55321e606 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,7 +27,6 @@
 #include <linux/part_stat.h>
 #include <linux/blktrace_api.h>
 
-#include "blk-throttle.h"
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
@@ -699,8 +698,6 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
-	blk_throtl_cancel_bios(disk);
-
 	blk_sync_queue(q);
 	blk_flush_integrity();
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..368f450f74f2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -487,10 +487,6 @@ struct request_queue {
 
 	int			mq_freeze_depth;
 
-#ifdef CONFIG_BLK_DEV_THROTTLING
-	/* Throttle data */
-	struct throtl_data *td;
-#endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
 	/*
-- 
2.39.2


