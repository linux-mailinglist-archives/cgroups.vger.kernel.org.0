Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3EE7003F6
	for <lists+cgroups@lfdr.de>; Fri, 12 May 2023 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjELJiq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 May 2023 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbjELJio (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 May 2023 05:38:44 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409610E53;
        Fri, 12 May 2023 02:38:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QHkGk1hZPz4f41GK;
        Fri, 12 May 2023 17:38:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33eoZCV5k66u5JA--.8346S8;
        Fri, 12 May 2023 17:38:39 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 4/6] blk-wbt: cleanup rwb_enabled() and wbt_disabled()
Date:   Fri, 12 May 2023 17:35:52 +0800
Message-Id: <20230512093554.911753-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512093554.911753-1-yukuai1@huaweicloud.com>
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eoZCV5k66u5JA--.8346S8
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7uFykGw4DGw18Kr1xKrg_yoW8Gw18pa
        yDGry2kr4qgry0gan2yFZrXrWfCw4rtr17GFWDu3ySk3WrurWa9an5CryUXF4kZrZ5Ca13
        Gw1ayF9xJF1q9rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'wb_normal' will set to 0 if 'min_lat_nsec' is 0, and 'min_lat_nsec' can
only be set to 0 through sysfs configuration where 'WBT_STATE_OFF_MANUAL'
is set together, in the meantime, they can only be cleared together
through sysfs afterwards. Hence 'wb_normal != 0' is the same as
'rwb->enable_state != WBT_STATE_OFF_MANUAL'.

The code is redundan, hence replace the checking of 'wb_normal' to
'enable_state' in rwb_enabled() and reuse rwb_enabled() for
wbt_disabled().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index cb464c572840..06d400fa050d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -146,7 +146,7 @@ enum {
 static inline bool rwb_enabled(struct rq_wb *rwb)
 {
 	return rwb && rwb->enable_state != WBT_STATE_OFF_DEFAULT &&
-		      rwb->wb_normal != 0;
+		      rwb->enable_state != WBT_STATE_OFF_MANUAL;
 }
 
 static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
@@ -494,8 +494,7 @@ bool wbt_disabled(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 
-	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT ||
-	       RQWB(rqos)->enable_state == WBT_STATE_OFF_MANUAL;
+	return !rqos || !rwb_enabled(RQWB(rqos));
 }
 
 u64 wbt_get_min_lat(struct request_queue *q)
-- 
2.39.2

