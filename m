Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5178414B403
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2020 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgA1MKZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jan 2020 07:10:25 -0500
Received: from mx1.didichuxing.com ([111.202.154.82]:9383 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725959AbgA1MKY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jan 2020 07:10:24 -0500
X-ASG-Debug-ID: 1580212352-0e41082813877660001-hhPYk8
Received: from mail.didiglobal.com (localhost [172.20.36.245]) by bsf02.didichuxing.com with ESMTP id IGrohZmG1rklzFOT; Tue, 28 Jan 2020 19:52:32 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 19:52:32 +0800
Date:   Tue, 28 Jan 2020 19:52:31 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>, <tglx@linutronix.de>,
        <edmund.nadolski@intel.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v4 1/5] block: add weighted round robin for blkcgroup
Message-ID: <79d9823e0bd750d3634f45a19c1310b6c62f92b7.1580211965.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v4 1/5] block: add weighted round robin for blkcgroup
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        tglx@linutronix.de, edmund.nadolski@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1580211965.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1580211965.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.245]
X-Barracuda-Start-Time: 1580212352
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 10908
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79617
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each block cgroup can select a weighted round robin type to make
its io requests go to the specified haredware queue. Now we support
four round robin type urgent, high, medium, low like what nvme specification
dose.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-cgroup.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.c     |  4 ++
 block/blk-mq-sched.c       |  5 ++-
 block/blk-mq-tag.c         |  4 +-
 block/blk-mq-tag.h         |  2 +-
 block/blk-mq.c             | 12 ++++--
 block/blk-mq.h             | 20 +++++++++-
 block/blk.h                |  2 +-
 include/linux/blk-cgroup.h |  2 +
 include/linux/blk-mq.h     | 18 +++++++++
 10 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a229b94d5390..a81888c7cb2d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -830,6 +830,91 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static const char *blk_wrr_name[BLK_WRR_COUNT] = {
+	[BLK_WRR_NONE]		= "none",
+	[BLK_WRR_LOW]		= "low",
+	[BLK_WRR_MEDIUM]	= "medium",
+	[BLK_WRR_HIGH]		= "high",
+	[BLK_WRR_URGENT]	= "urgent",
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
+
 static struct cftype blkcg_files[] = {
 	{
 		.name = "stat",
@@ -844,6 +929,12 @@ static struct cftype blkcg_legacy_files[] = {
 		.name = "reset_stats",
 		.write_u64 = blkcg_reset_stats,
 	},
+	{
+		.name = "wrr",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write = blkcg_wrr_write,
+		.seq_show = blkcg_wrr_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..455e5a21ee0c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -420,6 +420,10 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 static const char *const hctx_types[] = {
 	[HCTX_TYPE_DEFAULT]	= "default",
 	[HCTX_TYPE_READ]	= "read",
+	[HCTX_TYPE_WRR_LOW]	= "wrr_low",
+	[HCTX_TYPE_WRR_MEDIUM]	= "wrr_medium",
+	[HCTX_TYPE_WRR_HIGH]	= "wrr_high",
+	[HCTX_TYPE_WRR_URGENT]	= "wrr_urgent",
 	[HCTX_TYPE_POLL]	= "poll",
 };
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..32e948445eb0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -326,7 +327,9 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 {
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
+	struct blkcg_gq *blkg = bio->bi_blkg;
+	int wrr = blkg ? atomic_read(&blkg->wrr) : BLK_WRR_NONE;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx, wrr);
 	bool ret = false;
 	enum hctx_type type;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fbacde454718..e46d2c34a27f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -99,7 +99,7 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 		return __sbitmap_queue_get(bt);
 }
 
-unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
+unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data, int wrr)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct sbitmap_queue *bt;
@@ -159,7 +159,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
-						data->ctx);
+						data->ctx, wrr);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
 			bt = &tags->breserved_tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 15bc74acb57e..5d951a0f32fe 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -25,7 +25,7 @@ struct blk_mq_tags {
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
-extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
+extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data, int wrr);
 extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
 			   struct blk_mq_ctx *ctx, unsigned int tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..26383bde2792 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -340,6 +340,12 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	unsigned int tag;
 	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
+	int wrr;
+
+	if (bio && bio->bi_blkg)
+		wrr = atomic_read(&bio->bi_blkg->wrr);
+	else
+		wrr = BLK_WRR_NONE;
 
 	blk_queue_enter_live(q);
 
@@ -354,7 +360,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx);
+						data->ctx, wrr);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -374,7 +380,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		blk_mq_tag_busy(data->hctx);
 	}
 
-	tag = blk_mq_get_tag(data);
+	tag = blk_mq_get_tag(data, wrr);
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (clear_ctx_on_error)
 			data->ctx = NULL;
@@ -1044,7 +1050,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
 	shared = blk_mq_tag_busy(data.hctx);
-	rq->tag = blk_mq_get_tag(&data);
+	rq->tag = blk_mq_get_tag(&data, BLK_WRR_NONE);
 	if (rq->tag >= 0) {
 		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..e6aac5b46edb 100644
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
 
@@ -110,7 +111,22 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
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
+		case BLK_WRR_HIGH:
+			type = HCTX_TYPE_WRR_HIGH;
+			break;
+		default:
+			type = HCTX_TYPE_WRR_URGENT;
+			break;
+		}
+	} else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
 	
 	return ctx->hctxs[type];
diff --git a/block/blk.h b/block/blk.h
index 6842f28c033e..ba97a6a35a73 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -40,7 +40,7 @@ extern struct ida blk_queue_ida;
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
+	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx, BLK_WRR_NONE)->fq;
 }
 
 static inline void __blk_get_queue(struct request_queue *q)
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e4a6949fd171..aab168a36d88 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -138,6 +138,8 @@ struct blkcg_gq {
 	atomic64_t			delay_start;
 	u64				last_delay;
 	int				last_use;
+	/* weighted round robin */
+	atomic_t			wrr;
 
 	struct rcu_head			rcu_head;
 };
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..e210778a94f0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -193,17 +193,35 @@ struct blk_mq_queue_map {
  * enum hctx_type - Type of hardware queue
  * @HCTX_TYPE_DEFAULT:	All I/O not otherwise accounted for.
  * @HCTX_TYPE_READ:	Just for READ I/O.
+ * @HCTX_TYPE_WRR_LOW:     Weighted Round Robin low priority, when I/O is not polled.
+ * @HCTX_TYPE_WRR_MEDIUM:  Weighted Round Robin medium priority, when I/O is not polled.
+ * @HCTX_TYPE_WRR_HIGH:    Weighted Round Robin high priority, when I/O is not polled.
+ * @HCTX_TYPE_WRR_URGENT:  Weighted Round Robin urgent priority, when I/O is not polled.
  * @HCTX_TYPE_POLL:	Polled I/O of any kind.
  * @HCTX_MAX_TYPES:	Number of types of hctx.
  */
 enum hctx_type {
 	HCTX_TYPE_DEFAULT,
 	HCTX_TYPE_READ,
+	HCTX_TYPE_WRR_LOW,
+	HCTX_TYPE_WRR_MEDIUM,
+	HCTX_TYPE_WRR_HIGH,
+	HCTX_TYPE_WRR_URGENT,
 	HCTX_TYPE_POLL,
 
 	HCTX_MAX_TYPES,
 };
 
+enum blk_wrr {
+	BLK_WRR_NONE,
+	BLK_WRR_LOW,
+	BLK_WRR_MEDIUM,
+	BLK_WRR_HIGH,
+	BLK_WRR_URGENT,
+
+	BLK_WRR_COUNT,
+};
+
 /**
  * struct blk_mq_tag_set - tag set that can be shared between request queues
  * @map:	   One or more ctx -> hctx mappings. One map exists for each
-- 
2.14.1

