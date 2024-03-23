Return-Path: <cgroups+bounces-2140-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAA8876D0
	for <lists+cgroups@lfdr.de>; Sat, 23 Mar 2024 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEFF1F22EA0
	for <lists+cgroups@lfdr.de>; Sat, 23 Mar 2024 03:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0444137E;
	Sat, 23 Mar 2024 03:00:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79A372;
	Sat, 23 Mar 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162850; cv=none; b=eqAFnWjjUW5gp1eeXBY819TrjBecpMQaxIdL+ZGJx2tarIwaS1z6/v9Yq1Tgf+XgIbLC6j+pkIUwpIjsJ2WSyafu0Ums+8f24MXiAuDExNsD88ywFjA4E5pXBfcHnVI7qDLRJjZN6ctsYDLg+oD16d2r4c+4Opf2nHeFqmOxv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162850; c=relaxed/simple;
	bh=Qwrd0y3q4ERynHu/sl9QuOzztU2SOatvq0Gsviy/Xs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GjnsLQRitttIewpGezP7WjqqRiylc95aby98iwzWZVA/VHP7DsQSWyQpcKaeVvAcv4I9vcEI7utqtKGdamO4gJu6Ud5Lxk9S3Nv+mAtsxQe0sc7yG1uL7VSlVFJhgylKO2lr/hOm44k5DTsYAMsv1eFF6TZAeIfgmJoXckmu1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1kTc3m5Vz4f3jHV;
	Sat, 23 Mar 2024 11:00:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8F9BF1A0845;
	Sat, 23 Mar 2024 11:00:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHYRf5l03gxHw--.2525S4;
	Sat, 23 Mar 2024 11:00:42 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	hch@lst.de,
	ming.lei@redhat.com,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next RFC] blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
Date: Sat, 23 Mar 2024 10:53:22 +0800
Message-Id: <20240323025322.1310935-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHYRf5l03gxHw--.2525S4
X-Coremail-Antispam: 1UD129KBjvAXoWDJFykZFyUAr4ktF4UWr17Jrb_yoWrWF17Zo
	WfXw4fJwn7Gr18Kw4jgwnrtF43ua1kArs8ZrsYv3Z7XF1xJ3yDu3y2ya43Jas3Ca1akFZ8
	CF10gr1Yqa1xAr1fn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYc7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

One the one hand, it's marked EXPERIMENTAL since 2017, and looks like
there are no users since then, and no testers and no developers, it's
just not active at all.

On the other hand, even if the config is disabled, there are still many
fields in throtl_grp and throtl_data and many functions that are only
used for throtl low.

At last, currently blk-throtl is initialized during disk initialization,
and destroyed during disk removal, and it exposes many functions to be
called directly from block layer. Hence I'm planning to optimize
blk-throtl and finially support building it as kernel module. Remove
throtl low will make the work much easier.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/Kconfig        |  11 -
 block/bio.c          |   1 -
 block/blk-stat.c     |   3 -
 block/blk-sysfs.c    |   7 -
 block/blk-throttle.c | 901 ++-----------------------------------------
 block/blk-throttle.h |  26 +-
 block/blk.h          |  11 -
 7 files changed, 45 insertions(+), 915 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 1de4682d48cc..72814e485f82 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -120,17 +120,6 @@ config BLK_DEV_THROTTLING
 
 	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
 
-config BLK_DEV_THROTTLING_LOW
-	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
-	depends on BLK_DEV_THROTTLING
-	help
-	Add .low limit interface for block throttling. The low limit is a best
-	effort limit to prioritize cgroups. Depending on the setting, the limit
-	can be used to protect cgroups in terms of bandwidth/iops and better
-	utilize disk resource.
-
-	Note, this is an experimental interface and could be changed someday.
-
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
 	help
diff --git a/block/bio.c b/block/bio.c
index d24420ed1c4c..4404cd0a2690 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1596,7 +1596,6 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
-	blk_throtl_bio_endio(bio);
 	/* release cgroup info */
 	bio_uninit(bio);
 	if (bio->bi_end_io)
diff --git a/block/blk-stat.c b/block/blk-stat.c
index e42c263e53fb..eaf60097bbe1 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -57,9 +57,6 @@ void blk_stat_add(struct request *rq, u64 now)
 
 	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
 
-	if (req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE)
-		blk_throtl_stat_add(rq, value);
-
 	rcu_read_lock();
 	cpu = get_cpu();
 	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8c8f69d8ba48..674c5c602364 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -516,10 +516,6 @@ QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
-#endif
-
 /* legacy alias for logical_block_size: */
 static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.attr = {.name = "hw_sector_size", .mode = 0444 },
@@ -640,9 +636,6 @@ static struct attribute *queue_attrs[] = {
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
 	&queue_poll_delay_entry.attr,
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	&blk_throtl_sample_time_entry.attr,
-#endif
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
 	NULL,
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f4850a6f860b..1e45e48564f4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -25,18 +25,6 @@
 #define DFL_THROTL_SLICE_HD (HZ / 10)
 #define DFL_THROTL_SLICE_SSD (HZ / 50)
 #define MAX_THROTL_SLICE (HZ)
-#define MAX_IDLE_TIME (5L * 1000 * 1000) /* 5 s */
-#define MIN_THROTL_BPS (320 * 1024)
-#define MIN_THROTL_IOPS (10)
-#define DFL_LATENCY_TARGET (-1L)
-#define DFL_IDLE_THRESHOLD (0)
-#define DFL_HD_BASELINE_LATENCY (4000L) /* 4ms */
-#define LATENCY_FILTERED_SSD (0)
-/*
- * For HD, very small latency comes from sequential IO. Such IO is helpless to
- * help determine if its IO is impacted by others, hence we ignore the IO
- */
-#define LATENCY_FILTERED_HD (1000L) /* 1ms */
 
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
@@ -70,19 +58,6 @@ struct throtl_data
 
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
-	unsigned int limit_index;
-	bool limit_valid[LIMIT_CNT];
-
-	unsigned long low_upgrade_time;
-	unsigned long low_downgrade_time;
-
-	unsigned int scale;
-
-	struct latency_bucket tmp_buckets[2][LATENCY_BUCKET_SIZE];
-	struct avg_latency_bucket avg_buckets[2][LATENCY_BUCKET_SIZE];
-	struct latency_bucket __percpu *latency_buckets[2];
-	unsigned long last_calculate_time;
-	unsigned long filtered_latency;
 
 	bool track_bio_latency;
 };
@@ -126,84 +101,24 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 		return container_of(sq, struct throtl_data, service_queue);
 }
 
-/*
- * cgroup's limit in LIMIT_MAX is scaled if low limit is set. This scale is to
- * make the IO dispatch more smooth.
- * Scale up: linearly scale up according to elapsed time since upgrade. For
- *           every throtl_slice, the limit scales up 1/2 .low limit till the
- *           limit hits .max limit
- * Scale down: exponentially scale down if a cgroup doesn't hit its .low limit
- */
-static uint64_t throtl_adjusted_limit(uint64_t low, struct throtl_data *td)
-{
-	/* arbitrary value to avoid too big scale */
-	if (td->scale < 4096 && time_after_eq(jiffies,
-	    td->low_upgrade_time + td->scale * td->throtl_slice))
-		td->scale = (jiffies - td->low_upgrade_time) / td->throtl_slice;
-
-	return low + (low >> 1) * td->scale;
-}
-
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
-	struct throtl_data *td;
-	uint64_t ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return U64_MAX;
 
-	td = tg->td;
-	ret = tg->bps[rw][td->limit_index];
-	if (ret == 0 && td->limit_index == LIMIT_LOW) {
-		/* intermediate node or iops isn't 0 */
-		if (!list_empty(&blkg->blkcg->css.children) ||
-		    tg->iops[rw][td->limit_index])
-			return U64_MAX;
-		else
-			return MIN_THROTL_BPS;
-	}
-
-	if (td->limit_index == LIMIT_MAX && tg->bps[rw][LIMIT_LOW] &&
-	    tg->bps[rw][LIMIT_LOW] != tg->bps[rw][LIMIT_MAX]) {
-		uint64_t adjusted;
-
-		adjusted = throtl_adjusted_limit(tg->bps[rw][LIMIT_LOW], td);
-		ret = min(tg->bps[rw][LIMIT_MAX], adjusted);
-	}
-	return ret;
+	return tg->bps[rw];
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
-	struct throtl_data *td;
-	unsigned int ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return UINT_MAX;
 
-	td = tg->td;
-	ret = tg->iops[rw][td->limit_index];
-	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
-		/* intermediate node or bps isn't 0 */
-		if (!list_empty(&blkg->blkcg->css.children) ||
-		    tg->bps[rw][td->limit_index])
-			return UINT_MAX;
-		else
-			return MIN_THROTL_IOPS;
-	}
-
-	if (td->limit_index == LIMIT_MAX && tg->iops[rw][LIMIT_LOW] &&
-	    tg->iops[rw][LIMIT_LOW] != tg->iops[rw][LIMIT_MAX]) {
-		uint64_t adjusted;
-
-		adjusted = throtl_adjusted_limit(tg->iops[rw][LIMIT_LOW], td);
-		if (adjusted > UINT_MAX)
-			adjusted = UINT_MAX;
-		ret = min_t(unsigned int, tg->iops[rw][LIMIT_MAX], adjusted);
-	}
-	return ret;
+	return tg->iops[rw];
 }
 
 #define request_bucket_index(sectors) \
@@ -359,20 +274,10 @@ static struct blkg_policy_data *throtl_pd_alloc(struct gendisk *disk,
 	}
 
 	RB_CLEAR_NODE(&tg->rb_node);
-	tg->bps[READ][LIMIT_MAX] = U64_MAX;
-	tg->bps[WRITE][LIMIT_MAX] = U64_MAX;
-	tg->iops[READ][LIMIT_MAX] = UINT_MAX;
-	tg->iops[WRITE][LIMIT_MAX] = UINT_MAX;
-	tg->bps_conf[READ][LIMIT_MAX] = U64_MAX;
-	tg->bps_conf[WRITE][LIMIT_MAX] = U64_MAX;
-	tg->iops_conf[READ][LIMIT_MAX] = UINT_MAX;
-	tg->iops_conf[WRITE][LIMIT_MAX] = UINT_MAX;
-	/* LIMIT_LOW will have default value 0 */
-
-	tg->latency_target = DFL_LATENCY_TARGET;
-	tg->latency_target_conf = DFL_LATENCY_TARGET;
-	tg->idletime_threshold = DFL_IDLE_THRESHOLD;
-	tg->idletime_threshold_conf = DFL_IDLE_THRESHOLD;
+	tg->bps[READ] = U64_MAX;
+	tg->bps[WRITE] = U64_MAX;
+	tg->iops[READ] = UINT_MAX;
+	tg->iops[WRITE] = UINT_MAX;
 
 	return &tg->pd;
 
@@ -418,18 +323,15 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 static void tg_update_has_rules(struct throtl_grp *tg)
 {
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
-	struct throtl_data *td = tg->td;
 	int rw;
 
 	for (rw = READ; rw <= WRITE; rw++) {
 		tg->has_rules_iops[rw] =
 			(parent_tg && parent_tg->has_rules_iops[rw]) ||
-			(td->limit_valid[td->limit_index] &&
-			  tg_iops_limit(tg, rw) != UINT_MAX);
+			tg_iops_limit(tg, rw) != UINT_MAX;
 		tg->has_rules_bps[rw] =
 			(parent_tg && parent_tg->has_rules_bps[rw]) ||
-			(td->limit_valid[td->limit_index] &&
-			 (tg_bps_limit(tg, rw) != U64_MAX));
+			tg_bps_limit(tg, rw) != U64_MAX;
 	}
 }
 
@@ -443,49 +345,6 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(tg);
 }
 
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-static void blk_throtl_update_limit_valid(struct throtl_data *td)
-{
-	struct cgroup_subsys_state *pos_css;
-	struct blkcg_gq *blkg;
-	bool low_valid = false;
-
-	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-
-		if (tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
-		    tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) {
-			low_valid = true;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	td->limit_valid[LIMIT_LOW] = low_valid;
-}
-#else
-static inline void blk_throtl_update_limit_valid(struct throtl_data *td)
-{
-}
-#endif
-
-static void throtl_upgrade_state(struct throtl_data *td);
-static void throtl_pd_offline(struct blkg_policy_data *pd)
-{
-	struct throtl_grp *tg = pd_to_tg(pd);
-
-	tg->bps[READ][LIMIT_LOW] = 0;
-	tg->bps[WRITE][LIMIT_LOW] = 0;
-	tg->iops[READ][LIMIT_LOW] = 0;
-	tg->iops[WRITE][LIMIT_LOW] = 0;
-
-	blk_throtl_update_limit_valid(tg->td);
-
-	if (!tg->td->limit_valid[tg->td->limit_index])
-		throtl_upgrade_state(tg->td);
-}
-
 static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -1151,8 +1010,6 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 	return nr_disp;
 }
 
-static bool throtl_can_upgrade(struct throtl_data *td,
-	struct throtl_grp *this_tg);
 /**
  * throtl_pending_timer_fn - timer function for service_queue->pending_timer
  * @t: the pending_timer member of the throtl_service_queue being serviced
@@ -1189,9 +1046,6 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	if (!q->root_blkg)
 		goto out_unlock;
 
-	if (throtl_can_upgrade(td, NULL))
-		throtl_upgrade_state(td);
-
 again:
 	parent_sq = sq->parent_sq;
 	dispatched = false;
@@ -1339,14 +1193,6 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		    !blkg->parent->parent)
 			continue;
 		parent_tg = blkg_to_tg(blkg->parent);
-		/*
-		 * make sure all children has lower idle time threshold and
-		 * higher latency target
-		 */
-		this_tg->idletime_threshold = min(this_tg->idletime_threshold,
-				parent_tg->idletime_threshold);
-		this_tg->latency_target = max(this_tg->latency_target,
-				parent_tg->latency_target);
 	}
 	rcu_read_unlock();
 
@@ -1444,25 +1290,25 @@ static int tg_print_rwstat_recursive(struct seq_file *sf, void *v)
 static struct cftype throtl_legacy_files[] = {
 	{
 		.name = "throttle.read_bps_device",
-		.private = offsetof(struct throtl_grp, bps[READ][LIMIT_MAX]),
+		.private = offsetof(struct throtl_grp, bps[READ]),
 		.seq_show = tg_print_conf_u64,
 		.write = tg_set_conf_u64,
 	},
 	{
 		.name = "throttle.write_bps_device",
-		.private = offsetof(struct throtl_grp, bps[WRITE][LIMIT_MAX]),
+		.private = offsetof(struct throtl_grp, bps[WRITE]),
 		.seq_show = tg_print_conf_u64,
 		.write = tg_set_conf_u64,
 	},
 	{
 		.name = "throttle.read_iops_device",
-		.private = offsetof(struct throtl_grp, iops[READ][LIMIT_MAX]),
+		.private = offsetof(struct throtl_grp, iops[READ]),
 		.seq_show = tg_print_conf_uint,
 		.write = tg_set_conf_uint,
 	},
 	{
 		.name = "throttle.write_iops_device",
-		.private = offsetof(struct throtl_grp, iops[WRITE][LIMIT_MAX]),
+		.private = offsetof(struct throtl_grp, iops[WRITE]),
 		.seq_show = tg_print_conf_uint,
 		.write = tg_set_conf_uint,
 	},
@@ -1497,58 +1343,30 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
-	char idle_time[26] = "";
-	char latency_time[26] = "";
 
 	if (!dname)
 		return 0;
 
-	if (off == LIMIT_LOW) {
-		bps_dft = 0;
-		iops_dft = 0;
-	} else {
-		bps_dft = U64_MAX;
-		iops_dft = UINT_MAX;
-	}
+	bps_dft = U64_MAX;
+	iops_dft = UINT_MAX;
 
-	if (tg->bps_conf[READ][off] == bps_dft &&
-	    tg->bps_conf[WRITE][off] == bps_dft &&
-	    tg->iops_conf[READ][off] == iops_dft &&
-	    tg->iops_conf[WRITE][off] == iops_dft &&
-	    (off != LIMIT_LOW ||
-	     (tg->idletime_threshold_conf == DFL_IDLE_THRESHOLD &&
-	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
+	if (tg->bps[READ] == bps_dft &&
+	    tg->bps[WRITE] == bps_dft &&
+	    tg->iops[READ] == iops_dft &&
+	    tg->iops[WRITE] == iops_dft)
 		return 0;
 
-	if (tg->bps_conf[READ][off] != U64_MAX)
-		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
-			tg->bps_conf[READ][off]);
-	if (tg->bps_conf[WRITE][off] != U64_MAX)
-		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
-			tg->bps_conf[WRITE][off]);
-	if (tg->iops_conf[READ][off] != UINT_MAX)
-		snprintf(bufs[2], sizeof(bufs[2]), "%u",
-			tg->iops_conf[READ][off]);
-	if (tg->iops_conf[WRITE][off] != UINT_MAX)
-		snprintf(bufs[3], sizeof(bufs[3]), "%u",
-			tg->iops_conf[WRITE][off]);
-	if (off == LIMIT_LOW) {
-		if (tg->idletime_threshold_conf == ULONG_MAX)
-			strcpy(idle_time, " idle=max");
-		else
-			snprintf(idle_time, sizeof(idle_time), " idle=%lu",
-				tg->idletime_threshold_conf);
-
-		if (tg->latency_target_conf == ULONG_MAX)
-			strcpy(latency_time, " latency=max");
-		else
-			snprintf(latency_time, sizeof(latency_time),
-				" latency=%lu", tg->latency_target_conf);
-	}
-
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time,
-		   latency_time);
+	if (tg->bps[READ] != U64_MAX)
+		snprintf(bufs[0], sizeof(bufs[0]), "%llu", tg->bps[READ]);
+	if (tg->bps[WRITE] != U64_MAX)
+		snprintf(bufs[1], sizeof(bufs[1]), "%llu", tg->bps[WRITE]);
+	if (tg->iops[READ] != UINT_MAX)
+		snprintf(bufs[2], sizeof(bufs[2]), "%u", tg->iops[READ]);
+	if (tg->iops[WRITE] != UINT_MAX)
+		snprintf(bufs[3], sizeof(bufs[3]), "%u", tg->iops[WRITE]);
+
+	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s\n",
+		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
 	return 0;
 }
 
@@ -1566,10 +1384,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	struct blkg_conf_ctx ctx;
 	struct throtl_grp *tg;
 	u64 v[4];
-	unsigned long idle_time;
-	unsigned long latency_time;
 	int ret;
-	int index = of_cft(of)->private;
 
 	blkg_conf_init(&ctx, buf);
 
@@ -1580,13 +1395,11 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	tg = blkg_to_tg(ctx.blkg);
 	tg_update_carryover(tg);
 
-	v[0] = tg->bps_conf[READ][index];
-	v[1] = tg->bps_conf[WRITE][index];
-	v[2] = tg->iops_conf[READ][index];
-	v[3] = tg->iops_conf[WRITE][index];
+	v[0] = tg->bps[READ];
+	v[1] = tg->bps[WRITE];
+	v[2] = tg->iops[READ];
+	v[3] = tg->iops[WRITE];
 
-	idle_time = tg->idletime_threshold_conf;
-	latency_time = tg->latency_target_conf;
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
@@ -1618,60 +1431,16 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			v[2] = min_t(u64, val, UINT_MAX);
 		else if (!strcmp(tok, "wiops") && val > 1)
 			v[3] = min_t(u64, val, UINT_MAX);
-		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
-			idle_time = val;
-		else if (off == LIMIT_LOW && !strcmp(tok, "latency"))
-			latency_time = val;
 		else
 			goto out_finish;
 	}
 
-	tg->bps_conf[READ][index] = v[0];
-	tg->bps_conf[WRITE][index] = v[1];
-	tg->iops_conf[READ][index] = v[2];
-	tg->iops_conf[WRITE][index] = v[3];
+	tg->bps[READ] = v[0];
+	tg->bps[WRITE] = v[1];
+	tg->iops[READ] = v[2];
+	tg->iops[WRITE] = v[3];
 
-	if (index == LIMIT_MAX) {
-		tg->bps[READ][index] = v[0];
-		tg->bps[WRITE][index] = v[1];
-		tg->iops[READ][index] = v[2];
-		tg->iops[WRITE][index] = v[3];
-	}
-	tg->bps[READ][LIMIT_LOW] = min(tg->bps_conf[READ][LIMIT_LOW],
-		tg->bps_conf[READ][LIMIT_MAX]);
-	tg->bps[WRITE][LIMIT_LOW] = min(tg->bps_conf[WRITE][LIMIT_LOW],
-		tg->bps_conf[WRITE][LIMIT_MAX]);
-	tg->iops[READ][LIMIT_LOW] = min(tg->iops_conf[READ][LIMIT_LOW],
-		tg->iops_conf[READ][LIMIT_MAX]);
-	tg->iops[WRITE][LIMIT_LOW] = min(tg->iops_conf[WRITE][LIMIT_LOW],
-		tg->iops_conf[WRITE][LIMIT_MAX]);
-	tg->idletime_threshold_conf = idle_time;
-	tg->latency_target_conf = latency_time;
-
-	/* force user to configure all settings for low limit  */
-	if (!(tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW] ||
-	      tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) ||
-	    tg->idletime_threshold_conf == DFL_IDLE_THRESHOLD ||
-	    tg->latency_target_conf == DFL_LATENCY_TARGET) {
-		tg->bps[READ][LIMIT_LOW] = 0;
-		tg->bps[WRITE][LIMIT_LOW] = 0;
-		tg->iops[READ][LIMIT_LOW] = 0;
-		tg->iops[WRITE][LIMIT_LOW] = 0;
-		tg->idletime_threshold = DFL_IDLE_THRESHOLD;
-		tg->latency_target = DFL_LATENCY_TARGET;
-	} else if (index == LIMIT_LOW) {
-		tg->idletime_threshold = tg->idletime_threshold_conf;
-		tg->latency_target = tg->latency_target_conf;
-	}
-
-	blk_throtl_update_limit_valid(tg->td);
-	if (tg->td->limit_valid[LIMIT_LOW]) {
-		if (index == LIMIT_LOW)
-			tg->td->limit_index = LIMIT_LOW;
-	} else
-		tg->td->limit_index = LIMIT_MAX;
-	tg_conf_updated(tg, index == LIMIT_LOW &&
-		tg->td->limit_valid[LIMIT_LOW]);
+	tg_conf_updated(tg, false);
 	ret = 0;
 out_finish:
 	blkg_conf_exit(&ctx);
@@ -1679,21 +1448,11 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 }
 
 static struct cftype throtl_files[] = {
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	{
-		.name = "low",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = tg_print_limit,
-		.write = tg_set_limit,
-		.private = LIMIT_LOW,
-	},
-#endif
 	{
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = tg_print_limit,
 		.write = tg_set_limit,
-		.private = LIMIT_MAX,
 	},
 	{ }	/* terminate */
 };
@@ -1712,7 +1471,6 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
-	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1761,418 +1519,6 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	spin_unlock_irq(&q->queue_lock);
 }
 
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-static unsigned long __tg_last_low_overflow_time(struct throtl_grp *tg)
-{
-	unsigned long rtime = jiffies, wtime = jiffies;
-
-	if (tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW])
-		rtime = tg->last_low_overflow_time[READ];
-	if (tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW])
-		wtime = tg->last_low_overflow_time[WRITE];
-	return min(rtime, wtime);
-}
-
-static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
-{
-	struct throtl_service_queue *parent_sq;
-	struct throtl_grp *parent = tg;
-	unsigned long ret = __tg_last_low_overflow_time(tg);
-
-	while (true) {
-		parent_sq = parent->service_queue.parent_sq;
-		parent = sq_to_tg(parent_sq);
-		if (!parent)
-			break;
-
-		/*
-		 * The parent doesn't have low limit, it always reaches low
-		 * limit. Its overflow time is useless for children
-		 */
-		if (!parent->bps[READ][LIMIT_LOW] &&
-		    !parent->iops[READ][LIMIT_LOW] &&
-		    !parent->bps[WRITE][LIMIT_LOW] &&
-		    !parent->iops[WRITE][LIMIT_LOW])
-			continue;
-		if (time_after(__tg_last_low_overflow_time(parent), ret))
-			ret = __tg_last_low_overflow_time(parent);
-	}
-	return ret;
-}
-
-static bool throtl_tg_is_idle(struct throtl_grp *tg)
-{
-	/*
-	 * cgroup is idle if:
-	 * - single idle is too long, longer than a fixed value (in case user
-	 *   configure a too big threshold) or 4 times of idletime threshold
-	 * - average think time is more than threshold
-	 * - IO latency is largely below threshold
-	 */
-	unsigned long time;
-	bool ret;
-
-	time = min_t(unsigned long, MAX_IDLE_TIME, 4 * tg->idletime_threshold);
-	ret = tg->latency_target == DFL_LATENCY_TARGET ||
-	      tg->idletime_threshold == DFL_IDLE_THRESHOLD ||
-	      (blk_time_get_ns() >> 10) - tg->last_finish_time > time ||
-	      tg->avg_idletime > tg->idletime_threshold ||
-	      (tg->latency_target && tg->bio_cnt &&
-		tg->bad_bio_cnt * 5 < tg->bio_cnt);
-	throtl_log(&tg->service_queue,
-		"avg_idle=%ld, idle_threshold=%ld, bad_bio=%d, total_bio=%d, is_idle=%d, scale=%d",
-		tg->avg_idletime, tg->idletime_threshold, tg->bad_bio_cnt,
-		tg->bio_cnt, ret, tg->td->scale);
-	return ret;
-}
-
-static bool throtl_low_limit_reached(struct throtl_grp *tg, int rw)
-{
-	struct throtl_service_queue *sq = &tg->service_queue;
-	bool limit = tg->bps[rw][LIMIT_LOW] || tg->iops[rw][LIMIT_LOW];
-
-	/*
-	 * if low limit is zero, low limit is always reached.
-	 * if low limit is non-zero, we can check if there is any request
-	 * is queued to determine if low limit is reached as we throttle
-	 * request according to limit.
-	 */
-	return !limit || sq->nr_queued[rw];
-}
-
-static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
-{
-	/*
-	 * cgroup reaches low limit when low limit of READ and WRITE are
-	 * both reached, it's ok to upgrade to next limit if cgroup reaches
-	 * low limit
-	 */
-	if (throtl_low_limit_reached(tg, READ) &&
-	    throtl_low_limit_reached(tg, WRITE))
-		return true;
-
-	if (time_after_eq(jiffies,
-		tg_last_low_overflow_time(tg) + tg->td->throtl_slice) &&
-	    throtl_tg_is_idle(tg))
-		return true;
-	return false;
-}
-
-static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
-{
-	while (true) {
-		if (throtl_tg_can_upgrade(tg))
-			return true;
-		tg = sq_to_tg(tg->service_queue.parent_sq);
-		if (!tg || !tg_to_blkg(tg)->parent)
-			return false;
-	}
-	return false;
-}
-
-static bool throtl_can_upgrade(struct throtl_data *td,
-	struct throtl_grp *this_tg)
-{
-	struct cgroup_subsys_state *pos_css;
-	struct blkcg_gq *blkg;
-
-	if (td->limit_index != LIMIT_LOW)
-		return false;
-
-	if (time_before(jiffies, td->low_downgrade_time + td->throtl_slice))
-		return false;
-
-	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-
-		if (tg == this_tg)
-			continue;
-		if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
-			continue;
-		if (!throtl_hierarchy_can_upgrade(tg)) {
-			rcu_read_unlock();
-			return false;
-		}
-	}
-	rcu_read_unlock();
-	return true;
-}
-
-static void throtl_upgrade_check(struct throtl_grp *tg)
-{
-	unsigned long now = jiffies;
-
-	if (tg->td->limit_index != LIMIT_LOW)
-		return;
-
-	if (time_after(tg->last_check_time + tg->td->throtl_slice, now))
-		return;
-
-	tg->last_check_time = now;
-
-	if (!time_after_eq(now,
-	     __tg_last_low_overflow_time(tg) + tg->td->throtl_slice))
-		return;
-
-	if (throtl_can_upgrade(tg->td, NULL))
-		throtl_upgrade_state(tg->td);
-}
-
-static void throtl_upgrade_state(struct throtl_data *td)
-{
-	struct cgroup_subsys_state *pos_css;
-	struct blkcg_gq *blkg;
-
-	throtl_log(&td->service_queue, "upgrade to max");
-	td->limit_index = LIMIT_MAX;
-	td->low_upgrade_time = jiffies;
-	td->scale = 0;
-	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-		struct throtl_service_queue *sq = &tg->service_queue;
-
-		tg->disptime = jiffies - 1;
-		throtl_select_dispatch(sq);
-		throtl_schedule_next_dispatch(sq, true);
-	}
-	rcu_read_unlock();
-	throtl_select_dispatch(&td->service_queue);
-	throtl_schedule_next_dispatch(&td->service_queue, true);
-	queue_work(kthrotld_workqueue, &td->dispatch_work);
-}
-
-static void throtl_downgrade_state(struct throtl_data *td)
-{
-	td->scale /= 2;
-
-	throtl_log(&td->service_queue, "downgrade, scale %d", td->scale);
-	if (td->scale) {
-		td->low_upgrade_time = jiffies - td->scale * td->throtl_slice;
-		return;
-	}
-
-	td->limit_index = LIMIT_LOW;
-	td->low_downgrade_time = jiffies;
-}
-
-static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
-{
-	struct throtl_data *td = tg->td;
-	unsigned long now = jiffies;
-
-	/*
-	 * If cgroup is below low limit, consider downgrade and throttle other
-	 * cgroups
-	 */
-	if (time_after_eq(now, tg_last_low_overflow_time(tg) +
-					td->throtl_slice) &&
-	    (!throtl_tg_is_idle(tg) ||
-	     !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
-		return true;
-	return false;
-}
-
-static bool throtl_hierarchy_can_downgrade(struct throtl_grp *tg)
-{
-	struct throtl_data *td = tg->td;
-
-	if (time_before(jiffies, td->low_upgrade_time + td->throtl_slice))
-		return false;
-
-	while (true) {
-		if (!throtl_tg_can_downgrade(tg))
-			return false;
-		tg = sq_to_tg(tg->service_queue.parent_sq);
-		if (!tg || !tg_to_blkg(tg)->parent)
-			break;
-	}
-	return true;
-}
-
-static void throtl_downgrade_check(struct throtl_grp *tg)
-{
-	uint64_t bps;
-	unsigned int iops;
-	unsigned long elapsed_time;
-	unsigned long now = jiffies;
-
-	if (tg->td->limit_index != LIMIT_MAX ||
-	    !tg->td->limit_valid[LIMIT_LOW])
-		return;
-	if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
-		return;
-	if (time_after(tg->last_check_time + tg->td->throtl_slice, now))
-		return;
-
-	elapsed_time = now - tg->last_check_time;
-	tg->last_check_time = now;
-
-	if (time_before(now, tg_last_low_overflow_time(tg) +
-			tg->td->throtl_slice))
-		return;
-
-	if (tg->bps[READ][LIMIT_LOW]) {
-		bps = tg->last_bytes_disp[READ] * HZ;
-		do_div(bps, elapsed_time);
-		if (bps >= tg->bps[READ][LIMIT_LOW])
-			tg->last_low_overflow_time[READ] = now;
-	}
-
-	if (tg->bps[WRITE][LIMIT_LOW]) {
-		bps = tg->last_bytes_disp[WRITE] * HZ;
-		do_div(bps, elapsed_time);
-		if (bps >= tg->bps[WRITE][LIMIT_LOW])
-			tg->last_low_overflow_time[WRITE] = now;
-	}
-
-	if (tg->iops[READ][LIMIT_LOW]) {
-		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
-		if (iops >= tg->iops[READ][LIMIT_LOW])
-			tg->last_low_overflow_time[READ] = now;
-	}
-
-	if (tg->iops[WRITE][LIMIT_LOW]) {
-		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
-		if (iops >= tg->iops[WRITE][LIMIT_LOW])
-			tg->last_low_overflow_time[WRITE] = now;
-	}
-
-	/*
-	 * If cgroup is below low limit, consider downgrade and throttle other
-	 * cgroups
-	 */
-	if (throtl_hierarchy_can_downgrade(tg))
-		throtl_downgrade_state(tg->td);
-
-	tg->last_bytes_disp[READ] = 0;
-	tg->last_bytes_disp[WRITE] = 0;
-	tg->last_io_disp[READ] = 0;
-	tg->last_io_disp[WRITE] = 0;
-}
-
-static void blk_throtl_update_idletime(struct throtl_grp *tg)
-{
-	unsigned long now;
-	unsigned long last_finish_time = tg->last_finish_time;
-
-	if (last_finish_time == 0)
-		return;
-
-	now = blk_time_get_ns() >> 10;
-	if (now <= last_finish_time ||
-	    last_finish_time == tg->checked_last_finish_time)
-		return;
-
-	tg->avg_idletime = (tg->avg_idletime * 7 + now - last_finish_time) >> 3;
-	tg->checked_last_finish_time = last_finish_time;
-}
-
-static void throtl_update_latency_buckets(struct throtl_data *td)
-{
-	struct avg_latency_bucket avg_latency[2][LATENCY_BUCKET_SIZE];
-	int i, cpu, rw;
-	unsigned long last_latency[2] = { 0 };
-	unsigned long latency[2];
-
-	if (!blk_queue_nonrot(td->queue) || !td->limit_valid[LIMIT_LOW])
-		return;
-	if (time_before(jiffies, td->last_calculate_time + HZ))
-		return;
-	td->last_calculate_time = jiffies;
-
-	memset(avg_latency, 0, sizeof(avg_latency));
-	for (rw = READ; rw <= WRITE; rw++) {
-		for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
-			struct latency_bucket *tmp = &td->tmp_buckets[rw][i];
-
-			for_each_possible_cpu(cpu) {
-				struct latency_bucket *bucket;
-
-				/* this isn't race free, but ok in practice */
-				bucket = per_cpu_ptr(td->latency_buckets[rw],
-					cpu);
-				tmp->total_latency += bucket[i].total_latency;
-				tmp->samples += bucket[i].samples;
-				bucket[i].total_latency = 0;
-				bucket[i].samples = 0;
-			}
-
-			if (tmp->samples >= 32) {
-				int samples = tmp->samples;
-
-				latency[rw] = tmp->total_latency;
-
-				tmp->total_latency = 0;
-				tmp->samples = 0;
-				latency[rw] /= samples;
-				if (latency[rw] == 0)
-					continue;
-				avg_latency[rw][i].latency = latency[rw];
-			}
-		}
-	}
-
-	for (rw = READ; rw <= WRITE; rw++) {
-		for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
-			if (!avg_latency[rw][i].latency) {
-				if (td->avg_buckets[rw][i].latency < last_latency[rw])
-					td->avg_buckets[rw][i].latency =
-						last_latency[rw];
-				continue;
-			}
-
-			if (!td->avg_buckets[rw][i].valid)
-				latency[rw] = avg_latency[rw][i].latency;
-			else
-				latency[rw] = (td->avg_buckets[rw][i].latency * 7 +
-					avg_latency[rw][i].latency) >> 3;
-
-			td->avg_buckets[rw][i].latency = max(latency[rw],
-				last_latency[rw]);
-			td->avg_buckets[rw][i].valid = true;
-			last_latency[rw] = td->avg_buckets[rw][i].latency;
-		}
-	}
-
-	for (i = 0; i < LATENCY_BUCKET_SIZE; i++)
-		throtl_log(&td->service_queue,
-			"Latency bucket %d: read latency=%ld, read valid=%d, "
-			"write latency=%ld, write valid=%d", i,
-			td->avg_buckets[READ][i].latency,
-			td->avg_buckets[READ][i].valid,
-			td->avg_buckets[WRITE][i].latency,
-			td->avg_buckets[WRITE][i].valid);
-}
-#else
-static inline void throtl_update_latency_buckets(struct throtl_data *td)
-{
-}
-
-static void blk_throtl_update_idletime(struct throtl_grp *tg)
-{
-}
-
-static void throtl_downgrade_check(struct throtl_grp *tg)
-{
-}
-
-static void throtl_upgrade_check(struct throtl_grp *tg)
-{
-}
-
-static bool throtl_can_upgrade(struct throtl_data *td,
-	struct throtl_grp *this_tg)
-{
-	return false;
-}
-
-static void throtl_upgrade_state(struct throtl_data *td)
-{
-}
-#endif
-
 bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -2185,21 +1531,12 @@ bool __blk_throtl_bio(struct bio *bio)
 	struct throtl_data *td = tg->td;
 
 	rcu_read_lock();
-
 	spin_lock_irq(&q->queue_lock);
-
-	throtl_update_latency_buckets(td);
-
-	blk_throtl_update_idletime(tg);
-
 	sq = &tg->service_queue;
 
-again:
 	while (true) {
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
-		throtl_downgrade_check(tg);
-		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
@@ -2207,10 +1544,6 @@ bool __blk_throtl_bio(struct bio *bio)
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
 			tg->last_low_overflow_time[rw] = jiffies;
-			if (throtl_can_upgrade(td, tg)) {
-				throtl_upgrade_state(td);
-				goto again;
-			}
 			break;
 		}
 
@@ -2270,101 +1603,12 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (throttled || !td->track_bio_latency)
-		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
-#endif
 	spin_unlock_irq(&q->queue_lock);
 
 	rcu_read_unlock();
 	return throttled;
 }
 
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-static void throtl_track_latency(struct throtl_data *td, sector_t size,
-				 enum req_op op, unsigned long time)
-{
-	const bool rw = op_is_write(op);
-	struct latency_bucket *latency;
-	int index;
-
-	if (!td || td->limit_index != LIMIT_LOW ||
-	    !(op == REQ_OP_READ || op == REQ_OP_WRITE) ||
-	    !blk_queue_nonrot(td->queue))
-		return;
-
-	index = request_bucket_index(size);
-
-	latency = get_cpu_ptr(td->latency_buckets[rw]);
-	latency[index].total_latency += time;
-	latency[index].samples++;
-	put_cpu_ptr(td->latency_buckets[rw]);
-}
-
-void blk_throtl_stat_add(struct request *rq, u64 time_ns)
-{
-	struct request_queue *q = rq->q;
-	struct throtl_data *td = q->td;
-
-	throtl_track_latency(td, blk_rq_stats_sectors(rq), req_op(rq),
-			     time_ns >> 10);
-}
-
-void blk_throtl_bio_endio(struct bio *bio)
-{
-	struct blkcg_gq *blkg;
-	struct throtl_grp *tg;
-	u64 finish_time_ns;
-	unsigned long finish_time;
-	unsigned long start_time;
-	unsigned long lat;
-	int rw = bio_data_dir(bio);
-
-	blkg = bio->bi_blkg;
-	if (!blkg)
-		return;
-	tg = blkg_to_tg(blkg);
-	if (!tg->td->limit_valid[LIMIT_LOW])
-		return;
-
-	finish_time_ns = blk_time_get_ns();
-	tg->last_finish_time = finish_time_ns >> 10;
-
-	start_time = bio_issue_time(&bio->bi_issue) >> 10;
-	finish_time = __bio_issue_time(finish_time_ns) >> 10;
-	if (!start_time || finish_time <= start_time)
-		return;
-
-	lat = finish_time - start_time;
-	/* this is only for bio based driver */
-	if (!(bio->bi_issue.value & BIO_ISSUE_THROTL_SKIP_LATENCY))
-		throtl_track_latency(tg->td, bio_issue_size(&bio->bi_issue),
-				     bio_op(bio), lat);
-
-	if (tg->latency_target && lat >= tg->td->filtered_latency) {
-		int bucket;
-		unsigned int threshold;
-
-		bucket = request_bucket_index(bio_issue_size(&bio->bi_issue));
-		threshold = tg->td->avg_buckets[rw][bucket].latency +
-			tg->latency_target;
-		if (lat > threshold)
-			tg->bad_bio_cnt++;
-		/*
-		 * Not race free, could get wrong count, which means cgroups
-		 * will be throttled
-		 */
-		tg->bio_cnt++;
-	}
-
-	if (time_after(jiffies, tg->bio_cnt_reset_time) || tg->bio_cnt > 1024) {
-		tg->bio_cnt_reset_time = tg->td->throtl_slice + jiffies;
-		tg->bio_cnt /= 2;
-		tg->bad_bio_cnt /= 2;
-	}
-}
-#endif
-
 int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
@@ -2374,19 +1618,6 @@ int blk_throtl_init(struct gendisk *disk)
 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
 	if (!td)
 		return -ENOMEM;
-	td->latency_buckets[READ] = __alloc_percpu(sizeof(struct latency_bucket) *
-		LATENCY_BUCKET_SIZE, __alignof__(u64));
-	if (!td->latency_buckets[READ]) {
-		kfree(td);
-		return -ENOMEM;
-	}
-	td->latency_buckets[WRITE] = __alloc_percpu(sizeof(struct latency_bucket) *
-		LATENCY_BUCKET_SIZE, __alignof__(u64));
-	if (!td->latency_buckets[WRITE]) {
-		free_percpu(td->latency_buckets[READ]);
-		kfree(td);
-		return -ENOMEM;
-	}
 
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
@@ -2394,18 +1625,10 @@ int blk_throtl_init(struct gendisk *disk)
 	q->td = td;
 	td->queue = q;
 
-	td->limit_valid[LIMIT_MAX] = true;
-	td->limit_index = LIMIT_MAX;
-	td->low_upgrade_time = jiffies;
-	td->low_downgrade_time = jiffies;
-
 	/* activate policy */
 	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
-	if (ret) {
-		free_percpu(td->latency_buckets[READ]);
-		free_percpu(td->latency_buckets[WRITE]);
+	if (ret)
 		kfree(td);
-	}
 	return ret;
 }
 
@@ -2417,8 +1640,6 @@ void blk_throtl_exit(struct gendisk *disk)
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
-	free_percpu(q->td->latency_buckets[READ]);
-	free_percpu(q->td->latency_buckets[WRITE]);
 	kfree(q->td);
 }
 
@@ -2426,58 +1647,18 @@ void blk_throtl_register(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
-	int i;
 
 	td = q->td;
 	BUG_ON(!td);
 
-	if (blk_queue_nonrot(q)) {
+	if (blk_queue_nonrot(q))
 		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-		td->filtered_latency = LATENCY_FILTERED_SSD;
-	} else {
+	else
 		td->throtl_slice = DFL_THROTL_SLICE_HD;
-		td->filtered_latency = LATENCY_FILTERED_HD;
-		for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
-			td->avg_buckets[READ][i].latency = DFL_HD_BASELINE_LATENCY;
-			td->avg_buckets[WRITE][i].latency = DFL_HD_BASELINE_LATENCY;
-		}
-	}
-#ifndef CONFIG_BLK_DEV_THROTTLING_LOW
-	/* if no low limit, use previous default */
-	td->throtl_slice = DFL_THROTL_SLICE_HD;
-
-#else
 	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
-#endif
-}
-
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page)
-{
-	if (!q->td)
-		return -EINVAL;
-	return sprintf(page, "%u\n", jiffies_to_msecs(q->td->throtl_slice));
-}
-
-ssize_t blk_throtl_sample_time_store(struct request_queue *q,
-	const char *page, size_t count)
-{
-	unsigned long v;
-	unsigned long t;
-
-	if (!q->td)
-		return -EINVAL;
-	if (kstrtoul(page, 10, &v))
-		return -EINVAL;
-	t = msecs_to_jiffies(v);
-	if (t == 0 || t > MAX_THROTL_SLICE)
-		return -EINVAL;
-	q->td->throtl_slice = t;
-	return count;
 }
-#endif
 
 static int __init throtl_init(void)
 {
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index bffbc9cfc8ab..32503fd83a84 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -58,12 +58,6 @@ enum tg_state_flags {
 	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel bio */
 };
 
-enum {
-	LIMIT_LOW,
-	LIMIT_MAX,
-	LIMIT_CNT,
-};
-
 struct throtl_grp {
 	/* must be the first member */
 	struct blkg_policy_data pd;
@@ -102,14 +96,14 @@ struct throtl_grp {
 	bool has_rules_iops[2];
 
 	/* internally used bytes per second rate limits */
-	uint64_t bps[2][LIMIT_CNT];
+	uint64_t bps[2];
 	/* user configured bps limits */
-	uint64_t bps_conf[2][LIMIT_CNT];
+	uint64_t bps_conf[2];
 
 	/* internally used IOPS limits */
-	unsigned int iops[2][LIMIT_CNT];
+	unsigned int iops[2];
 	/* user configured IOPS limits */
-	unsigned int iops_conf[2][LIMIT_CNT];
+	unsigned int iops_conf[2];
 
 	/* Number of bytes dispatched in current slice */
 	uint64_t bytes_disp[2];
@@ -132,22 +126,10 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
-	unsigned long latency_target; /* us */
-	unsigned long latency_target_conf; /* us */
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
 
-	unsigned long last_finish_time; /* ns / 1024 */
-	unsigned long checked_last_finish_time; /* ns / 1024 */
-	unsigned long avg_idletime; /* ns / 1024 */
-	unsigned long idletime_threshold; /* us */
-	unsigned long idletime_threshold_conf; /* us */
-
-	unsigned int bio_cnt; /* total bios */
-	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
-	unsigned long bio_cnt_reset_time;
-
 	struct blkg_rwstat stat_bytes;
 	struct blkg_rwstat stat_ios;
 };
diff --git a/block/blk.h b/block/blk.h
index 5cac4e29ae17..47960bf31543 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -379,17 +379,6 @@ static inline void ioc_clear_queue(struct request_queue *q)
 }
 #endif /* CONFIG_BLK_ICQ */
 
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
-extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
-	const char *page, size_t count);
-extern void blk_throtl_bio_endio(struct bio *bio);
-extern void blk_throtl_stat_add(struct request *rq, u64 time);
-#else
-static inline void blk_throtl_bio_endio(struct bio *bio) { }
-static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
-#endif
-
 struct bio *__blk_queue_bounce(struct bio *bio, struct request_queue *q);
 
 static inline bool blk_queue_may_bounce(struct request_queue *q)
-- 
2.39.2


