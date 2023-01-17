Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161966D66D
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 07:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAQGn7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 01:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjAQGn5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 01:43:57 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3716E1DB8E;
        Mon, 16 Jan 2023 22:43:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nwzr40zfGz4f3nZ8;
        Tue, 17 Jan 2023 14:43:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R+jQ8ZjDSvYBg--.16287S7;
        Tue, 17 Jan 2023 14:43:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH v4 3/5] blk-iocost: read params inside lock in sysfs apis
Date:   Tue, 17 Jan 2023 15:08:04 +0800
Message-Id: <20230117070806.3857142-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230117070806.3857142-1-yukuai1@huaweicloud.com>
References: <20230117070806.3857142-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R+jQ8ZjDSvYBg--.16287S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4UGr18JrWkKryUCF4DJwb_yoW8WryfpF
        WYg397K3yFvr1xGFsxtF40q3Z5Wa1qqr4fXr47CryfAryaqr12qFsrCr40vw48ZFWxu398
        WFWagrW8Ar15C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Otherwise, user might get abnormal values if params is updated
concurrently.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d6256731cae4..d6f692d2283c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3129,6 +3129,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (!dname)
 		return 0;
 
+	spin_lock_irq(&ioc->lock);
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
 		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
@@ -3141,6 +3142,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 		   ioc->params.qos[QOS_MIN] % 10000 / 100,
 		   ioc->params.qos[QOS_MAX] / 10000,
 		   ioc->params.qos[QOS_MAX] % 10000 / 100);
+	spin_unlock_irq(&ioc->lock);
 	return 0;
 }
 
@@ -3320,12 +3322,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 	if (!dname)
 		return 0;
 
+	spin_lock_irq(&ioc->lock);
 	seq_printf(sf, "%s ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
+	spin_unlock_irq(&ioc->lock);
 	return 0;
 }
 
-- 
2.31.1

