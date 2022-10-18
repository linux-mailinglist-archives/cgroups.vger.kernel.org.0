Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8079602B8A
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJRMTl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Oct 2022 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJRMTi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Oct 2022 08:19:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6DA11478;
        Tue, 18 Oct 2022 05:19:37 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsCWk0YdYzpVjT;
        Tue, 18 Oct 2022 20:16:18 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:19:34 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 1/5] blk-iocost: Fix typo in comment
Date:   Tue, 18 Oct 2022 20:19:28 +0800
Message-ID: <20221018121932.10792-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
References: <20221018121932.10792-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

soley -> solely

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 495396425bad..be4bc38821e2 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -111,7 +111,7 @@
  * busy signal.
  *
  * As devices can have deep queues and be unfair in how the queued commands
- * are executed, soley depending on rq wait may not result in satisfactory
+ * are executed, solely depending on rq wait may not result in satisfactory
  * control quality.  For a better control quality, completion latency QoS
  * parameters can be configured so that the device is considered saturated
  * if N'th percentile completion latency rises above the set point.
-- 
2.30.0

