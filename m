Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B882656B02
	for <lists+cgroups@lfdr.de>; Tue, 27 Dec 2022 13:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiL0Men (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Dec 2022 07:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiL0Mek (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Dec 2022 07:34:40 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9132A3;
        Tue, 27 Dec 2022 04:34:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NhDcR4cLHz4f3jMg;
        Tue, 27 Dec 2022 20:34:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbBZ5qpjAnByAg--.34791S5;
        Tue, 27 Dec 2022 20:34:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Date:   Tue, 27 Dec 2022 20:55:01 +0800
Message-Id: <20221227125502.541931-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221227125502.541931-1-yukuai1@huaweicloud.com>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbBZ5qpjAnByAg--.34791S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kKFW8ZFW7CryxXr45GFg_yoW5Kr43pF
        13W345Cay5JF4xuws8t3ZrXw1rAw4fWr4kKrWfWwnYyr17Ar10q3WkA348Ga4rCFZxZr43
        XF18KFWUGr4jvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU
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

iocost requires that child iocg must exit before parent iocg, otherwise
kernel might crash in ioc_timer_fn(). However, currently iocg is exited
in pd_free_fn(), which can't guarantee such order:

1) remove cgroup can concurrent with deactivate policy;
2) blkg_free() triggered by remove cgroup is asynchronously, remove
child cgroup can concurrent with remove parent cgroup;

Fix the problem by add refcounting for iocg, and child iocg will grab
reference of parent iocg, so that parent iocg will wait for all child
iocg to be exited.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 74 +++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7a0d754b9eb2..525e93e1175a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -461,6 +461,8 @@ struct ioc_gq {
 	struct blkg_policy_data		pd;
 	struct ioc			*ioc;
 
+	refcount_t			ref;
+
 	/*
 	 * A iocg can get its weight from two sources - an explicit
 	 * per-device-cgroup configuration or the default weight of the
@@ -2943,9 +2945,53 @@ static struct blkg_policy_data *ioc_pd_alloc(gfp_t gfp, struct request_queue *q,
 		return NULL;
 	}
 
+	refcount_set(&iocg->ref, 1);
 	return &iocg->pd;
 }
 
+static void iocg_get(struct ioc_gq *iocg)
+{
+	refcount_inc(&iocg->ref);
+}
+
+static void iocg_put(struct ioc_gq *iocg)
+{
+	struct ioc *ioc = iocg->ioc;
+	unsigned long flags;
+	struct ioc_gq *parent = NULL;
+
+	if (!refcount_dec_and_test(&iocg->ref))
+		return;
+
+	if (iocg->level > 0)
+		parent = iocg->ancestors[iocg->level - 1];
+
+	if (ioc) {
+		spin_lock_irqsave(&ioc->lock, flags);
+
+		if (!list_empty(&iocg->active_list)) {
+			struct ioc_now now;
+
+			ioc_now(ioc, &now);
+			propagate_weights(iocg, 0, 0, false, &now);
+			list_del_init(&iocg->active_list);
+		}
+
+		WARN_ON_ONCE(!list_empty(&iocg->walk_list));
+		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
+
+		spin_unlock_irqrestore(&ioc->lock, flags);
+
+		hrtimer_cancel(&iocg->waitq_timer);
+	}
+
+	free_percpu(iocg->pcpu_stat);
+	kfree(iocg);
+
+	if (parent)
+		iocg_put(parent);
+}
+
 static void ioc_pd_init(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
@@ -2973,6 +3019,9 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 
 	iocg->level = blkg->blkcg->css.cgroup->level;
 
+	if (blkg->parent)
+		iocg_get(blkg_to_iocg(blkg->parent));
+
 	for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
 		struct ioc_gq *tiocg = blkg_to_iocg(tblkg);
 		iocg->ancestors[tiocg->level] = tiocg;
@@ -2985,30 +3034,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 
 static void ioc_pd_free(struct blkg_policy_data *pd)
 {
-	struct ioc_gq *iocg = pd_to_iocg(pd);
-	struct ioc *ioc = iocg->ioc;
-	unsigned long flags;
-
-	if (ioc) {
-		spin_lock_irqsave(&ioc->lock, flags);
-
-		if (!list_empty(&iocg->active_list)) {
-			struct ioc_now now;
-
-			ioc_now(ioc, &now);
-			propagate_weights(iocg, 0, 0, false, &now);
-			list_del_init(&iocg->active_list);
-		}
-
-		WARN_ON_ONCE(!list_empty(&iocg->walk_list));
-		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
-
-		spin_unlock_irqrestore(&ioc->lock, flags);
-
-		hrtimer_cancel(&iocg->waitq_timer);
-	}
-	free_percpu(iocg->pcpu_stat);
-	kfree(iocg);
+	iocg_put(pd_to_iocg(pd));
 }
 
 static void ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
-- 
2.31.1

