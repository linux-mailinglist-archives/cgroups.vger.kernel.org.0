Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02776FF8F
	for <lists+cgroups@lfdr.de>; Fri,  4 Aug 2023 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHDLkF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Aug 2023 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHDLkE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Aug 2023 07:40:04 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1909B9;
        Fri,  4 Aug 2023 04:40:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHNzy65zMz4f3k6Z;
        Fri,  4 Aug 2023 19:39:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7KO48xkcKosPg--.36807S4;
        Fri, 04 Aug 2023 19:39:59 +0800 (CST)
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
To:     tj@kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yukuai3@huawei.com,
        linan122@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com, lilingfeng3@huawei.com
Subject: [PATCH -next] block: remove init_mutex in blk_iolatency_try_init
Date:   Fri,  4 Aug 2023 19:36:59 +0800
Message-Id: <20230804113659.3816877-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7KO48xkcKosPg--.36807S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW8GF48WFWkJr4kJF4kXrb_yoW8XrW5p3
        yrWrsIk3yUKr4kXF4ktw1xur1UK3ykKFyUGF4rCFy5JFyq9r1SgF18ZF1FgrW8urWfAFs8
        Jr48Xryvkr45G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
a mutex named "init_mutex" in blk_iolatency_try_init for the race
condition of initializing RQ_QOS_LATENCY.
Now a new lock has been add to struct request_queue by commit a13bd91be223
("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
held in blkg_conf_open_bdev before calling blk_iolatency_init.
So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
remove it.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 block/blk-iolatency.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index fd5fec989e39..8fbd6bc96acb 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -826,7 +826,6 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
 
 static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
 {
-	static DEFINE_MUTEX(init_mutex);
 	int ret;
 
 	ret = blkg_conf_open_bdev(ctx);
@@ -837,13 +836,9 @@ static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
 	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
 	 * confuse iolat_rq_qos() test. Make the test and init atomic.
 	 */
-	mutex_lock(&init_mutex);
-
 	if (!iolat_rq_qos(ctx->bdev->bd_queue))
 		ret = blk_iolatency_init(ctx->bdev->bd_disk);
 
-	mutex_unlock(&init_mutex);
-
 	return ret;
 }
 
-- 
2.39.2

