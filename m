Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3185AF385B
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfKGTSO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:18:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGTSO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:18:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id y39so3651121qty.0;
        Thu, 07 Nov 2019 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xtRJy0h7C1YGD2EnSPEUZFAgaH1uL5OYTuzgSNt/iVM=;
        b=pUB/azFAGpBRWFY58zdbH4OPq1uOjGqFXzihxWn4zu/4YeW/WZvJbE0anEgs1rKM7W
         w5xuKjVjbn4yRzrZU8F4cFGMV5cKi/sxi5QdZhRhCcPBxyWgyf69B42xwceNgczzDmPs
         bDhmlsYDKIGJASTMulgG5Z4D7ywSOz5h53ri3guJIyNhDRHzb7Ay93Eabv48ivCXbKl7
         vdr8C9pSFfKMLW2q+9egxVRQUVC3ZBr6L2hSVkg4891f8OJkqVomgRB6VjmBoSogF6S1
         W2yx1pYDTZ59sPZnlQBOeBJ1L7SYLjRvdUGRzwy7mr8E2TzTWwQ4JCUvj80Gsf7a+NhI
         EYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xtRJy0h7C1YGD2EnSPEUZFAgaH1uL5OYTuzgSNt/iVM=;
        b=HlvGrbcmuHBZC3nyUVMVEppGWGYgH2HhaYn5aB8/j1bNpwQObAtRE9GmjuEPLX9uTy
         Nini4LZHtdTMWjphD0Qu6MKTD7il7bBLz13XuPPruxNIMZQdYOu7ernb9R4fRjHwQp6I
         HYg7emXW+Ur6DdDlBkSPkYdowhNUH+n89WcqZcLKc3Yt53KoXbOJnNL1UqhXpdx3LYEZ
         RzvdMUFOXQAsGj0jPdx5W/fC4aGXPRH4QCgfsnGelbJRySTwRyA2MT3kEDJBppxCDu7W
         aDNcL1dNecr8OnldxG04Om+eY2MjgIyuEHr98uAtTyJq8CNO9BUbIUvzlTugHl878owI
         dheA==
X-Gm-Message-State: APjAAAVUBaZnJDo/DsIDrubiKX74XcpxIE8vW7XyXtILqmATpDYv8aqd
        MKdkKLfm9o57G3bjfy5S7wA=
X-Google-Smtp-Source: APXvYqyV9AOwdQ7tA/bVLpKPwb0kbWhz6+1mCZ96J4QCEzLPRw8asWn4ybQHTf91PhtsIFZ92Euz1Q==
X-Received: by 2002:ac8:f52:: with SMTP id l18mr5653549qtk.126.1573154292940;
        Thu, 07 Nov 2019 11:18:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id u22sm985460qtb.59.2019.11.07.11.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:18:12 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/6] bfq-iosched: stop using blkg->stat_bytes and ->stat_ios
Date:   Thu,  7 Nov 2019 11:18:00 -0800
Message-Id: <20191107191804.3735303-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107191804.3735303-1-tj@kernel.org>
References: <20191107191804.3735303-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When used on cgroup1, bfq uses the blkg->stat_bytes and ->stat_ios
from blk-cgroup core to populate six stat knobs.  blk-cgroup core is
moving away from blkg_rwstat to improve scalability and won't be able
to support this usage.

It isn't like the sharing gains all that much.  Let's break it out to
dedicated rwstat counters which are updated when on cgroup1.  This
makes use of bfqg_*rwstat*() helpers outside of
CONFIG_BFQ_CGROUP_DEBUG.  Move them out.

v2: Compile fix when !CONFIG_BFQ_CGROUP_DEBUG.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  | 39 +++++++++++++++++++++++++++------------
 block/bfq-iosched.c |  4 ++++
 block/bfq-iosched.h |  4 ++++
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index d4755d4ad009..cea0ae12f937 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -347,6 +347,14 @@ void bfqg_and_blkg_put(struct bfq_group *bfqg)
 	bfqg_put(bfqg);
 }
 
+void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq)
+{
+	struct bfq_group *bfqg = blkg_to_bfqg(rq->bio->bi_blkg);
+
+	blkg_rwstat_add(&bfqg->stats.bytes, rq->cmd_flags, blk_rq_bytes(rq));
+	blkg_rwstat_add(&bfqg->stats.ios, rq->cmd_flags, 1);
+}
+
 /* @stats = 0 */
 static void bfqg_stats_reset(struct bfqg_stats *stats)
 {
@@ -431,6 +439,8 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 
 static void bfqg_stats_exit(struct bfqg_stats *stats)
 {
+	blkg_rwstat_exit(&stats->bytes);
+	blkg_rwstat_exit(&stats->ios);
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	blkg_rwstat_exit(&stats->merged);
 	blkg_rwstat_exit(&stats->service_time);
@@ -448,6 +458,10 @@ static void bfqg_stats_exit(struct bfqg_stats *stats)
 
 static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
 {
+	if (blkg_rwstat_init(&stats->bytes, gfp) ||
+	    blkg_rwstat_init(&stats->ios, gfp))
+		return -ENOMEM;
+
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	if (blkg_rwstat_init(&stats->merged, gfp) ||
 	    blkg_rwstat_init(&stats->service_time, gfp) ||
@@ -1057,7 +1071,6 @@ static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
 	return bfq_io_set_device_weight(of, buf, nbytes, off);
 }
 
-#ifdef CONFIG_BFQ_CGROUP_DEBUG
 static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
@@ -1082,6 +1095,7 @@ static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 static int bfqg_print_stat(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
@@ -1125,7 +1139,8 @@ static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
 static u64 bfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
 			       int off)
 {
-	u64 sum = blkg_rwstat_total(&pd->blkg->stat_bytes);
+	struct bfq_group *bfqg = blkg_to_bfqg(pd->blkg);
+	u64 sum = blkg_rwstat_total(&bfqg->stats.bytes);
 
 	return __blkg_prfill_u64(sf, pd, sum >> 9);
 }
@@ -1142,8 +1157,8 @@ static u64 bfqg_prfill_sectors_recursive(struct seq_file *sf,
 {
 	struct blkg_rwstat_sample tmp;
 
-	blkg_rwstat_recursive_sum(pd->blkg, NULL,
-			offsetof(struct blkcg_gq, stat_bytes), &tmp);
+	blkg_rwstat_recursive_sum(pd->blkg, &blkcg_policy_bfq,
+			offsetof(struct bfq_group, stats.bytes), &tmp);
 
 	return __blkg_prfill_u64(sf, pd,
 		(tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE]) >> 9);
@@ -1226,13 +1241,13 @@ struct cftype bfq_blkcg_legacy_files[] = {
 	/* statistics, covers only the tasks in the bfqg */
 	{
 		.name = "bfq.io_service_bytes",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_bytes,
+		.private = offsetof(struct bfq_group, stats.bytes),
+		.seq_show = bfqg_print_rwstat,
 	},
 	{
 		.name = "bfq.io_serviced",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_ios,
+		.private = offsetof(struct bfq_group, stats.ios),
+		.seq_show = bfqg_print_rwstat,
 	},
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
@@ -1269,13 +1284,13 @@ struct cftype bfq_blkcg_legacy_files[] = {
 	/* the same statistics which cover the bfqg and its descendants */
 	{
 		.name = "bfq.io_service_bytes_recursive",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_bytes_recursive,
+		.private = offsetof(struct bfq_group, stats.bytes),
+		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
 		.name = "bfq.io_serviced_recursive",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_ios_recursive,
+		.private = offsetof(struct bfq_group, stats.ios),
+		.seq_show = bfqg_print_rwstat_recursive,
 	},
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d6339822..41d2d83c919b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5464,6 +5464,10 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	bool idle_timer_disabled = false;
 	unsigned int cmd_flags;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
+		bfqg_stats_update_legacy_io(q, rq);
+#endif
 	spin_lock_irq(&bfqd->lock);
 	if (blk_mq_sched_try_insert_merge(q, rq)) {
 		spin_unlock_irq(&bfqd->lock);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5d1a519640f6..2676c06218f1 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -809,6 +809,9 @@ struct bfq_stat {
 };
 
 struct bfqg_stats {
+	/* basic stats */
+	struct blkg_rwstat		bytes;
+	struct blkg_rwstat		ios;
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	/* number of ios merged */
 	struct blkg_rwstat		merged;
@@ -956,6 +959,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 
 /* ---------------- cgroups-support interface ---------------- */
 
+void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 			      unsigned int op);
 void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
-- 
2.17.1

