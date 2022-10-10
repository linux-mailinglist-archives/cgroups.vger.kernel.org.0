Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154565F9703
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJJCjL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 Oct 2022 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJJCjH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 Oct 2022 22:39:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB53ECDF;
        Sun,  9 Oct 2022 19:39:04 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mm30H13b5zVhrg;
        Mon, 10 Oct 2022 10:34:39 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 10:39:01 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 1/4] blk-cgroup: Remove unnecessary blk_ioprio_exit in blkcg_init_queue
Date:   Mon, 10 Oct 2022 10:38:56 +0800
Message-ID: <20221010023859.11896-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221010023859.11896-1-shikemeng@huawei.com>
References: <20221010023859.11896-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Function blk_ioprio_init only alloc blkg_policy_data which will be freed
in blkg_destroy_all, so no blk_ioprio_exit is called when blk_throtl_init
is failed in blkcg_init_queue. Also blk_ioprio_exit is not called in
blkcg_exit_queue for the same reason. Just remove blk_ioprio_exit to
keep behavior consistent.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 869af9d72bcf..bc4dec705572 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1302,7 +1302,6 @@ int blkcg_init_queue(struct request_queue *q)
 	ret = blk_iolatency_init(q);
 	if (ret) {
 		blk_throtl_exit(q);
-		blk_ioprio_exit(q);
 		goto err_destroy_all;
 	}
 
-- 
2.30.0

