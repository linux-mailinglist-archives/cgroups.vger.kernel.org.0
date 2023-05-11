Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57D6FE998
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 03:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjEKBr4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 21:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjEKBrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 21:47:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F805B89;
        Wed, 10 May 2023 18:47:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QGvst2zvdz4f3jJ2;
        Thu, 11 May 2023 09:47:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33eo_SVxkrgJdJA--.7260S6;
        Thu, 11 May 2023 09:47:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 2/6] blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
Date:   Thu, 11 May 2023 09:45:05 +0800
Message-Id: <20230511014509.679482-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511014509.679482-1-yukuai1@huaweicloud.com>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eo_SVxkrgJdJA--.7260S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW7AFykJFWxXw1DAF4xZwb_yoW7ZFWDp3
        y3JFy3Aa10qF4xXryxAr4DC3y3ur1kKrW3JrWxCwnayF17Kr45WF18ta48WFyrJrWkCw43
        urs0qFsY9rW8JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

sysfs entry /sys/block/[device]/queue/wbt_lat_usec will be created even
if CONFIG_BLK_WBT is disabled, while read and write will always fail.
It doesn't make sense to create a sysfs entry that can't be accessed,
so don't create such entry.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 143 ++++++++++++++++++++++++----------------------
 block/blk-wbt.h   |  19 ------
 2 files changed, 74 insertions(+), 88 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a64208583853..6c1c4ba66bc0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -47,19 +47,6 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 	return count;
 }
 
-static ssize_t queue_var_store64(s64 *var, const char *page)
-{
-	int err;
-	s64 v;
-
-	err = kstrtos64(page, 10, &v);
-	if (err < 0)
-		return err;
-
-	*var = v;
-	return 0;
-}
-
 static ssize_t queue_requests_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->nr_requests, page);
@@ -451,61 +438,6 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
-{
-	if (!wbt_rq_qos(q))
-		return -EINVAL;
-
-	if (wbt_disabled(q))
-		return sprintf(page, "0\n");
-
-	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
-}
-
-static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
-				  size_t count)
-{
-	struct rq_qos *rqos;
-	ssize_t ret;
-	s64 val;
-
-	ret = queue_var_store64(&val, page);
-	if (ret < 0)
-		return ret;
-	if (val < -1)
-		return -EINVAL;
-
-	rqos = wbt_rq_qos(q);
-	if (!rqos) {
-		ret = wbt_init(q->disk);
-		if (ret)
-			return ret;
-	}
-
-	if (val == -1)
-		val = wbt_default_latency_nsec(q);
-	else if (val >= 0)
-		val *= 1000ULL;
-
-	if (wbt_get_min_lat(q) == val)
-		return count;
-
-	/*
-	 * Ensure that the queue is idled, in case the latency update
-	 * ends up either enabling or disabling wbt completely. We can't
-	 * have IO inflight if that happens.
-	 */
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-
-	wbt_set_min_lat(q, val);
-
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
-
-	return count;
-}
-
 static ssize_t queue_wc_show(struct request_queue *q, char *page)
 {
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
@@ -598,7 +530,6 @@ QUEUE_RW_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
-QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
@@ -617,6 +548,78 @@ QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
+#ifdef CONFIG_BLK_WBT
+static ssize_t queue_var_store64(s64 *var, const char *page)
+{
+	int err;
+	s64 v;
+
+	err = kstrtos64(page, 10, &v);
+	if (err < 0)
+		return err;
+
+	*var = v;
+	return 0;
+}
+
+static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
+{
+	if (!wbt_rq_qos(q))
+		return -EINVAL;
+
+	if (wbt_disabled(q))
+		return sprintf(page, "0\n");
+
+	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+}
+
+static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
+				  size_t count)
+{
+	struct rq_qos *rqos;
+	ssize_t ret;
+	s64 val;
+
+	ret = queue_var_store64(&val, page);
+	if (ret < 0)
+		return ret;
+	if (val < -1)
+		return -EINVAL;
+
+	rqos = wbt_rq_qos(q);
+	if (!rqos) {
+		ret = wbt_init(q->disk);
+		if (ret)
+			return ret;
+	}
+
+	if (val == -1)
+		val = wbt_default_latency_nsec(q);
+	else if (val >= 0)
+		val *= 1000ULL;
+
+	if (wbt_get_min_lat(q) == val)
+		return count;
+
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	wbt_set_min_lat(q, val);
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+
+	return count;
+}
+
+QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
+#endif
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -655,7 +658,9 @@ static struct attribute *queue_attrs[] = {
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
+#ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
+#endif
 	&queue_poll_delay_entry.attr,
 	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index ba6cca5849a6..8a029e138f7a 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -18,10 +18,6 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline int wbt_init(struct gendisk *disk)
-{
-	return -EINVAL;
-}
 static inline void wbt_disable_default(struct gendisk *disk)
 {
 }
@@ -31,21 +27,6 @@ static inline void wbt_enable_default(struct gendisk *disk)
 static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
 {
 }
-static inline u64 wbt_get_min_lat(struct request_queue *q)
-{
-	return 0;
-}
-static inline void wbt_set_min_lat(struct request_queue *q, u64 val)
-{
-}
-static inline u64 wbt_default_latency_nsec(struct request_queue *q)
-{
-	return 0;
-}
-static inline bool wbt_disabled(struct request_queue *q)
-{
-	return true;
-}
 
 #endif /* CONFIG_BLK_WBT */
 
-- 
2.39.2

