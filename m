Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4C77D7B8
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbjHPBa5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 21:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbjHPBax (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 21:30:53 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64888211E;
        Tue, 15 Aug 2023 18:30:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQVvX5Ktsz4f3nV9;
        Wed, 16 Aug 2023 09:30:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KbHJtxkQuVAAw--.55976S5;
        Wed, 16 Aug 2023 09:30:49 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 1/4] blk-throttle: print signed value 'carryover_bytes/ios' for user
Date:   Wed, 16 Aug 2023 09:27:05 +0800
Message-Id: <20230816012708.1193747-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KbHJtxkQuVAAw--.55976S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWrAF1UJr48WF1fArWxCrg_yoW8XF4kpF
        W3KrW8GF12qFnxCa13G3W5t3yUZan7Jry8A390kF13AF12k34qgr95ur1Skay0yFn3CF4v
        v34qqryxJF1Uu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjeWlDUUUUU=
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'carryover_bytes/ios' can be negative, indicate that some bio is
dispatched in advance within slice while configuration is updated.
Print a huge value is not user-friendly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 2 +-
 block/blk-throttle.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7397ff199d66..5184f17f5129 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -816,7 +816,7 @@ static void tg_update_carryover(struct throtl_grp *tg)
 		__tg_update_carryover(tg, WRITE);
 
 	/* see comments in struct throtl_grp for meaning of these fields. */
-	throtl_log(&tg->service_queue, "%s: %llu %llu %u %u\n", __func__,
+	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
 		   tg->carryover_bytes[READ], tg->carryover_bytes[WRITE],
 		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
 }
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index d1ccbfe9f797..bffbc9cfc8ab 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -127,8 +127,8 @@ struct throtl_grp {
 	 * bytes/ios are waited already in previous configuration, and they will
 	 * be used to calculate wait time under new configuration.
 	 */
-	uint64_t carryover_bytes[2];
-	unsigned int carryover_ios[2];
+	long long carryover_bytes[2];
+	int carryover_ios[2];
 
 	unsigned long last_check_time;
 
-- 
2.39.2

