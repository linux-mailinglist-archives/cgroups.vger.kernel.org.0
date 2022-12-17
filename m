Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67E64F71F
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLQCow (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLQCou (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:44:50 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79287020E;
        Fri, 16 Dec 2022 18:44:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NYr0W4lMkz4f3nqB;
        Sat, 17 Dec 2022 10:44:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9gcLZ1j2O96CQ--.47195S6;
        Sat, 17 Dec 2022 10:44:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 2/4] blk-iocost: don't throttle bio if iocg is offlined
Date:   Sat, 17 Dec 2022 11:05:25 +0800
Message-Id: <20221217030527.1250083-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9gcLZ1j2O96CQ--.47195S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw17tw45ZFW8trykWr4kZwb_yoW5Gr4fpF
        43Ww15AayDAr4xu3ZxJF47Z3ySka1kurW7KrW3Zw13tr1DKr92q3WkAry8AFyrAFWfCr13
        XFn5KrWxGa1j9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

bio will grab blkg reference, however, blkcg->online_pin is not grabbed,
hence cgroup can be removed after thread exit while bio is still in
progress. Bypass io in this case since it doesn't make sense to
throttle bio while cgroup is removed.

This patch also prepare to move operations on iocg from ioc_pd_free()
to ioc_pd_offline().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 1498879c4a52..23cc734dbe43 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -695,6 +695,20 @@ static struct ioc_cgrp *blkcg_to_iocc(struct blkcg *blkcg)
 			    struct ioc_cgrp, cpd);
 }
 
+static struct ioc_gq *ioc_bio_iocg(struct bio *bio)
+{
+	struct blkcg_gq *blkg = bio->bi_blkg;
+
+	if (blkg && blkg->online) {
+		struct ioc_gq *iocg = blkg_to_iocg(blkg);
+
+		if (iocg && iocg->online)
+			return iocg;
+	}
+
+	return NULL;
+}
+
 /*
  * Scale @abs_cost to the inverse of @hw_inuse.  The lower the hierarchical
  * weight, the more expensive each IO.  Must round up.
@@ -1262,6 +1276,9 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 
 	spin_lock_irq(&ioc->lock);
 
+	if (!iocg->online)
+		goto fail_unlock;
+
 	ioc_now(ioc, now);
 
 	/* update period */
@@ -2561,9 +2578,8 @@ static u64 calc_size_vtime_cost(struct request *rq, struct ioc *ioc)
 
 static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 {
-	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct ioc *ioc = rqos_to_ioc(rqos);
-	struct ioc_gq *iocg = blkg_to_iocg(blkg);
+	struct ioc_gq *iocg = ioc_bio_iocg(bio);
 	struct ioc_now now;
 	struct iocg_wait wait;
 	u64 abs_cost, cost, vtime;
@@ -2697,7 +2713,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 			   struct bio *bio)
 {
-	struct ioc_gq *iocg = blkg_to_iocg(bio->bi_blkg);
+	struct ioc_gq *iocg = ioc_bio_iocg(bio);
 	struct ioc *ioc = rqos_to_ioc(rqos);
 	sector_t bio_end = bio_end_sector(bio);
 	struct ioc_now now;
@@ -2755,7 +2771,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 
 static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
 {
-	struct ioc_gq *iocg = blkg_to_iocg(bio->bi_blkg);
+	struct ioc_gq *iocg = ioc_bio_iocg(bio);
 
 	if (iocg && bio->bi_iocost_cost)
 		atomic64_add(bio->bi_iocost_cost, &iocg->done_vtime);
-- 
2.31.1

