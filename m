Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786964F71A
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLQCov (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQCou (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:44:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AD70214;
        Fri, 16 Dec 2022 18:44:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYr0W2xM2z4f3pc5;
        Sat, 17 Dec 2022 10:44:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9gcLZ1j2O96CQ--.47195S5;
        Sat, 17 Dec 2022 10:44:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 1/4] blk-iocost: track whether iocg is still online
Date:   Sat, 17 Dec 2022 11:05:24 +0800
Message-Id: <20221217030527.1250083-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9gcLZ1j2O96CQ--.47195S5
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrurykGw48Ww1xtrWDJwb_yoW8Cr17pF
        47WFZ09ayqvFn29w43Ja1xZr1Fvw1kuw4xJ3y3Cwn0y347G3saq3Z5A345AFn5CrsxCFZ3
        ZF1SqrW8Ga12vrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU
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

blkcg_gq->online can't be used in iocost because it gets cleared only after
all policies are offlined. This patch add a new field 'online' in iocg.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3aeb8538f0c3..1498879c4a52 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -459,6 +459,8 @@ struct ioc_gq {
 	struct blkg_policy_data		pd;
 	struct ioc			*ioc;
 
+	bool online;
+
 	/*
 	 * A iocg can get its weight from two sources - an explicit
 	 * per-device-cgroup configuration or the default weight of the
@@ -2952,6 +2954,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	ioc_now(ioc, &now);
 
 	iocg->ioc = ioc;
+	iocg->online = true;
 	atomic64_set(&iocg->vtime, now.vnow);
 	atomic64_set(&iocg->done_vtime, now.vnow);
 	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
@@ -2977,6 +2980,19 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
+static void ioc_pd_offline(struct blkg_policy_data *pd)
+{
+	struct ioc_gq *iocg = pd_to_iocg(pd);
+	struct ioc *ioc = iocg->ioc;
+	unsigned long flags;
+
+	if (ioc) {
+		spin_lock_irqsave(&ioc->lock, flags);
+		iocg->online = false;
+		spin_unlock_irqrestore(&ioc->lock, flags);
+	}
+}
+
 static void ioc_pd_free(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
@@ -3467,6 +3483,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
 	.cpd_free_fn	= ioc_cpd_free,
 	.pd_alloc_fn	= ioc_pd_alloc,
 	.pd_init_fn	= ioc_pd_init,
+	.pd_offline_fn	= ioc_pd_offline,
 	.pd_free_fn	= ioc_pd_free,
 	.pd_stat_fn	= ioc_pd_stat,
 };
-- 
2.31.1

