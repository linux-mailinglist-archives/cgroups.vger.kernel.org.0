Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCE610DA3
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ1JtU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ1JtL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 05:49:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95861C4ED2;
        Fri, 28 Oct 2022 02:49:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MzHkq0khRzlFZG;
        Fri, 28 Oct 2022 17:46:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCntOaQpVtjHAtNAQ--.59885S6;
        Fri, 28 Oct 2022 17:49:07 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: [PATCH -next 2/5] blk-iocost: improve hanlder of match_u64()
Date:   Fri, 28 Oct 2022 18:10:53 +0800
Message-Id: <20221028101056.1971715-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCntOaQpVtjHAtNAQ--.59885S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry8Cw1rGw4kZrW5CF45KFg_yoW8Cry3pF
        Wa9rZIqFy5Jrs2gFnrCFnF9a43C392qryxGayDGa4fJr17Jr9FgFn5JryDJFy8JrWfGws0
        gFnay3y8G3ZrCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
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

1) There are one place that return value of match_u64() is not checked.
2) If match_u64() failed, return value is set to -EINVAL despite that
   there are other possible errnos.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fd495e823db2..c532129a1456 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3202,6 +3202,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
 		int tok;
+		int err;
 		s64 v;
 
 		if (!*p)
@@ -3209,7 +3210,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 		switch (match_token(p, qos_ctrl_tokens, args)) {
 		case QOS_ENABLE:
-			match_u64(&args[0], &v);
+			err = match_u64(&args[0], &v);
+			if (err) {
+				ret = err;
+				goto out_unlock;
+			}
+
 			enable = v;
 			continue;
 		case QOS_CTRL:
@@ -3238,8 +3244,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			break;
 		case QOS_RLAT:
 		case QOS_WLAT:
-			if (match_u64(&args[0], &v))
+			err = match_u64(&args[0], &v);
+			if (err) {
+				ret = err;
 				goto out_unlock;
+			}
+
 			qos[tok] = v;
 			break;
 		case QOS_MIN:
@@ -3374,6 +3384,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
 		int tok;
+		int err;
 		u64 v;
 
 		if (!*p)
@@ -3399,8 +3410,13 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		tok = match_token(p, i_lcoef_tokens, args);
 		if (tok == NR_I_LCOEFS)
 			goto out_unlock;
-		if (match_u64(&args[0], &v))
+
+		err = match_u64(&args[0], &v);
+		if (err) {
+			ret = err;
 			goto out_unlock;
+		}
+
 		u[tok] = v;
 		user = true;
 	}
-- 
2.31.1

