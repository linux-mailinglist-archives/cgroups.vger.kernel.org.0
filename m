Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A447427
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2019 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfFPKPg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jun 2019 06:15:36 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:26069 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725861AbfFPKPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jun 2019 06:15:36 -0400
X-ASG-Debug-ID: 1560680128-0e4108565fd0c500001-hhPYk8
Received: from BJEXCAS010.didichuxing.com (localhost [172.20.35.141]) by bsf02.didichuxing.com with ESMTP id STwXYiE1HPecOHGw; Sun, 16 Jun 2019 18:15:28 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 16 Jun
 2019 18:15:28 +0800
Date:   Sun, 16 Jun 2019 18:15:26 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [PATCH v2 1/4] block: add weighted round robin for blkcgroup
Message-ID: <89ba948de92b5f0150ae506ac37b74ae9bf1987e.1560679439.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v2 1/4] block: add weighted round robin for blkcgroup
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
X-Barracuda-Connect: localhost[172.20.35.141]
X-Barracuda-Start-Time: 1560680128
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 10418
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No, SCORE=-1.52 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72767
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each block cgroup can select a weighted round robin type to make
its io requests go to the specified haredware queue. Now we support
three round robin type high, medium, low like what nvme specification
donse.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-cgroup.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.c     |  3 ++
 block/blk-mq-sched.c       |  6 +++-
 block/blk-mq-tag.c         |  4 +--
 block/blk-mq-tag.h         |  2 +-
 block/blk-mq.c             | 12 +++++--
 block/blk-mq.h             | 17 +++++++--
 block/blk.h                |  2 +-
 include/linux/blk-cgroup.h |  2 ++
 include/linux/blk-mq.h     | 12 +++++++
 10 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b97b479e4f64..0b0234dd2976 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1015,6 +1015,89 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static const char *blk_wrr_name[BLK_WRR_COUNT] = {
+	[BLK_WRR_NONE]		= "none",
+	[BLK_WRR_LOW]		= "low",
+	[BLK_WRR_MEDIUM]	= "medium",
+	[BLK_WRR_HIGH]		= "high",
+};
+
+static inline const char *blk_wrr_to_name(int wrr)
+{
+	if (wrr < BLK_WRR_NONE || wrr >= BLK_WRR_COUNT)
+		return "wrong";
+
+	return blk_wrr_name[wrr];
+}
+
+static ssize_t blkcg_wrr_write(struct kernfs_open_file *of,
+			 char *buf, size_t nbytes, loff_t off)
+{
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	struct gendisk *disk;
+	struct request_queue *q;
+	struct blkcg_gq *blkg;
+	unsigned int major, minor;
+	int wrr, key_len, part, ret;
+	char *body;
+
+	if (sscanf(buf, "%u:%u%n", &major, &minor, &key_len) != 2)
+		return -EINVAL;
+
+	body = buf + key_len;
+	if (!isspace(*body))
+		return -EINVAL;
+	body = skip_spaces(body);
+	wrr = sysfs_match_string(blk_wrr_name, body);
+	if (wrr == BLK_WRR_COUNT)
+		return -EINVAL;
+
+	disk = get_gendisk(MKDEV(major, minor), &part);
+	if (!disk)
+		return -ENODEV;
+	if (part) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	q = disk->queue;
+
+	blkg = blkg_lookup_create(blkcg, q);
+
+	atomic_set(&blkg->wrr, wrr);
+	put_disk_and_module(disk);
+
+	return nbytes;
+fail:
+	put_disk_and_module(disk);
+	return ret;
+}
+
+static int blkcg_wrr_show(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		const char *dname;
+		char *buf;
+		size_t size = seq_get_buf(sf, &buf), off = 0;
+
+		dname = blkg_dev_name(blkg);
+		if (!dname)
+			continue;
+
+		off += scnprintf(buf+off, size-off, "%s %s\n", dname,
+			blk_wrr_to_name(atomic_read(&blkg->wrr)));
+		seq_commit(sf, off);
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
 static struct cftype blkcg_files[] = {
 	{
 		.name = "stat",
@@ -1029,6 +1112,11 @@ static struct cftype blkcg_legacy_files[] = {
 		.name = "reset_stats",
 		.write_u64 = blkcg_reset_stats,
 	},
+	{
+		.name = "wrr",
+		.write = blkcg_wrr_write,
+		.seq_show = blkcg_wrr_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6aea0ebc3a73..a65ec9dbcb27 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -436,6 +436,9 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 static const char *const hctx_types[] = {
 	[HCTX_TYPE_DEFAULT]	= "default",
 	[HCTX_TYPE_READ]	= "read",
+	[HCTX_TYPE_WRR_LOW]	= "wrr_low",
+	[HCTX_TYPE_WRR_MEDIUM]	= "wrr_medium",
+	[HCTX_TYPE_WRR_HIGH]	= "wrr_high",
 	[HCTX_TYPE_POLL]	= "poll",
 };
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74c6bb871f7e..8500c878f0c4 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -322,10 +323,13 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
+	struct blk_mq_hw_ctx *hctx;
+	struct blkcg_gq *blkg = bio->bi_blkg;
+	int wrr = blkg ? atomic_read(&blkg->wrr) : BLK_WRR_NONE;
 	bool ret = false;
 	enum hctx_type type;
 
+	hctx = blk_mq_map_queue(q, bio->bi_opf, ctx, wrr);
 	if (e && e->type->ops.bio_merge) {
 		blk_mq_put_ctx(ctx);
 		return e->type->ops.bio_merge(hctx, bio);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7513c8eaabee..6fd5261c4fbc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -106,7 +106,7 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 		return __sbitmap_queue_get(bt);
 }
 
-unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
+unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data, int wrr)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct sbitmap_queue *bt;
@@ -171,7 +171,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
-						data->ctx);
+						data->ctx, wrr);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
 			bt = &tags->breserved_tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..ef43f819ead8 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -25,7 +25,7 @@ struct blk_mq_tags {
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
-extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
+extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data, int wrr);
 extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
 			   struct blk_mq_ctx *ctx, unsigned int tag);
 extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4ede70..8e8e743c4c0d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -356,6 +356,12 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct request *rq;
 	unsigned int tag;
 	bool put_ctx_on_error = false;
+	int wrr;
+
+	if (bio && bio->bi_blkg)
+		wrr = atomic_read(&bio->bi_blkg->wrr);
+	else
+		wrr = BLK_WRR_NONE;
 
 	blk_queue_enter_live(q);
 	data->q = q;
@@ -365,7 +371,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx);
+						data->ctx, wrr);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -385,7 +391,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		blk_mq_tag_busy(data->hctx);
 	}
 
-	tag = blk_mq_get_tag(data);
+	tag = blk_mq_get_tag(data, wrr);
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (put_ctx_on_error) {
 			blk_mq_put_ctx(data->ctx);
@@ -1060,7 +1066,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
 	shared = blk_mq_tag_busy(data.hctx);
-	rq->tag = blk_mq_get_tag(&data);
+	rq->tag = blk_mq_get_tag(&data, BLK_WRR_NONE);
 	if (rq->tag >= 0) {
 		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 633a5a77ee8b..51d59462c825 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -101,7 +101,8 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
-						     struct blk_mq_ctx *ctx)
+						     struct blk_mq_ctx *ctx,
+						     int wrr)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
@@ -110,7 +111,19 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	 */
 	if (flags & REQ_HIPRI)
 		type = HCTX_TYPE_POLL;
-	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
+	else if (wrr > BLK_WRR_NONE && wrr < BLK_WRR_COUNT) {
+		switch (wrr) {
+		case BLK_WRR_LOW:
+			type = HCTX_TYPE_WRR_LOW;
+			break;
+		case BLK_WRR_MEDIUM:
+			type = HCTX_TYPE_WRR_MEDIUM;
+			break;
+		default:
+			type = HCTX_TYPE_WRR_HIGH;
+			break;
+		}
+	} else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
 	
 	return ctx->hctxs[type];
diff --git a/block/blk.h b/block/blk.h
index 91b3581b7c7a..6ea188c499f4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -38,7 +38,7 @@ extern struct ida blk_queue_ida;
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
+	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx, BLK_WRR_NONE)->fq;
 }
 
 static inline void __blk_get_queue(struct request_queue *q)
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 76c61318fda5..0a6a9bcea590 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -141,6 +141,8 @@ struct blkcg_gq {
 	atomic64_t			delay_start;
 	u64				last_delay;
 	int				last_use;
+	/* weighted round robin */
+	atomic_t			wrr;
 };
 
 typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa53d96c..b07e7b866cec 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -85,11 +85,23 @@ struct blk_mq_queue_map {
 enum hctx_type {
 	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
 	HCTX_TYPE_READ,		/* just for READ I/O */
+	HCTX_TYPE_WRR_LOW,	/* blkcg: weighted round robin - low */
+	HCTX_TYPE_WRR_MEDIUM,	/* blkcg: weighted round robin - medium */
+	HCTX_TYPE_WRR_HIGH,	/* blkcg: weighted round robin - high */
 	HCTX_TYPE_POLL,		/* polled I/O of any kind */
 
 	HCTX_MAX_TYPES,
 };
 
+enum blk_wrr {
+	BLK_WRR_NONE,
+	BLK_WRR_LOW,
+	BLK_WRR_MEDIUM,
+	BLK_WRR_HIGH,
+
+	BLK_WRR_COUNT,
+};
+
 struct blk_mq_tag_set {
 	/*
 	 * map[] holds ctx -> hctx mappings, one map exists for each type
-- 
2.14.1

