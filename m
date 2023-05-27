Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83671315B
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 03:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjE0BKY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 21:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjE0BKW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 21:10:22 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8712189;
        Fri, 26 May 2023 18:10:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QSkHD5Qdlz4f3pCT;
        Sat, 27 May 2023 09:10:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J0WHFkNZwtKQ--.29147S9;
        Sat, 27 May 2023 09:10:17 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 5/5] blk-sysfs: add a new attr_group for blk_mq
Date:   Sat, 27 May 2023 09:06:44 +0800
Message-Id: <20230527010644.647900-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230527010644.647900-1-yukuai1@huaweicloud.com>
References: <20230527010644.647900-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J0WHFkNZwtKQ--.29147S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4ktFWUWF1UZF48tr17GFg_yoWrWr15pF
        4DAa4UZwsYvw42qayxJw4UXwnI9ry09r43Xr97Kr1vyF12q34fWFy0yryjqrWxArWkGw43
        JF4DtrWDArZ7ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently wbt sysfs entry is created for bio based device, and wbt can
be enabled for such device through sysfs while it doesn't make sense
because wbt can only work for rq based device. In the meantime, there
are other similar sysfs entries.

Fix this by adding a new attr_group for blk_mq, and sysfs entries will
only be created when the device is rq based.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6c1c4ba66bc0..afc797fb0dfc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -621,7 +621,6 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 #endif
 
 static struct attribute *queue_attrs[] = {
-	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
@@ -629,7 +628,6 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
-	&elv_iosched_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
@@ -650,7 +648,6 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
 	&queue_nomerges_entry.attr,
-	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_random_entry.attr,
@@ -658,11 +655,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
-#ifdef CONFIG_BLK_WBT
-	&queue_wb_lat_entry.attr,
-#endif
 	&queue_poll_delay_entry.attr,
-	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&blk_throtl_sample_time_entry.attr,
 #endif
@@ -671,16 +664,23 @@ static struct attribute *queue_attrs[] = {
 	NULL,
 };
 
+static struct attribute *blk_mq_queue_attrs[] = {
+	&queue_requests_entry.attr,
+	&elv_iosched_entry.attr,
+	&queue_rq_affinity_entry.attr,
+	&queue_io_timeout_entry.attr,
+#ifdef CONFIG_BLK_WBT
+	&queue_wb_lat_entry.attr,
+#endif
+	NULL,
+};
+
 static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 				int n)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
 
-	if (attr == &queue_io_timeout_entry.attr &&
-		(!q->mq_ops || !q->mq_ops->timeout))
-			return 0;
-
 	if ((attr == &queue_max_open_zones_entry.attr ||
 	     attr == &queue_max_active_zones_entry.attr) &&
 	    !blk_queue_is_zoned(q))
@@ -689,11 +689,30 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 	return attr->mode;
 }
 
+static umode_t blk_mq_queue_attr_visible(struct kobject *kobj,
+					 struct attribute *attr, int n)
+{
+	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
+	struct request_queue *q = disk->queue;
+
+	if (!queue_is_mq(q))
+		return 0;
+
+	if (attr == &queue_io_timeout_entry.attr && !q->mq_ops->timeout)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group queue_attr_group = {
 	.attrs = queue_attrs,
 	.is_visible = queue_attr_visible,
 };
 
+static struct attribute_group blk_mq_queue_attr_group = {
+	.attrs = blk_mq_queue_attrs,
+	.is_visible = blk_mq_queue_attr_visible,
+};
 
 #define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
 
@@ -738,6 +757,7 @@ static const struct sysfs_ops queue_sysfs_ops = {
 
 static const struct attribute_group *blk_queue_attr_groups[] = {
 	&queue_attr_group,
+	&blk_mq_queue_attr_group,
 	NULL
 };
 
-- 
2.39.2

