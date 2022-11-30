Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C954763D62F
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiK3NBB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 08:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiK3NA5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 08:00:57 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665EF4AF34;
        Wed, 30 Nov 2022 05:00:56 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NMfSY2Z9Gz15N01;
        Wed, 30 Nov 2022 21:00:13 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:00:53 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 30 Nov
 2022 21:00:52 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 5/9] blk-iocost: fix divide by 0 error in calc_lcoefs()
Date:   Wed, 30 Nov 2022 21:21:52 +0800
Message-ID: <20221130132156.2836184-6-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221130132156.2836184-1-linan122@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

echo max of u64 to cost.model can cause divide by 0 error.

  # echo 8:0 rbps=18446744073709551615 > /sys/fs/cgroup/io.cost.model

  divide error: 0000 [#1] PREEMPT SMP
  RIP: 0010:calc_lcoefs+0x4c/0xc0
  Call Trace:
   <TASK>
   ioc_refresh_params+0x2b3/0x4f0
   ioc_cost_model_write+0x3cb/0x4c0
   ? _copy_from_iter+0x6d/0x6c0
   ? kernfs_fop_write_iter+0xfc/0x270
   cgroup_file_write+0xa0/0x200
   kernfs_fop_write_iter+0x17d/0x270
   vfs_write+0x414/0x620
   ksys_write+0x73/0x160
   __x64_sys_write+0x1e/0x30
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

calc_lcoefs() uses the input value of cost.model in DIV_ROUND_UP_ULL,
overflow would happen if bps plus IOC_PAGE_SIZE is greater than
ULLONG_MAX, it can cause divide by 0 error.I_LCOEF_MAX is introduced to
prevent it.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-iocost.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3a96cd557c47..f4a754b9d10f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -306,6 +306,9 @@ enum {
 	IOC_PAGE_SIZE		= 1 << IOC_PAGE_SHIFT,
 	IOC_SECT_TO_PAGE_SHIFT	= IOC_PAGE_SHIFT - SECTOR_SHIFT,
 
+	/* avoid overflow */
+	I_LCOEF_MAX		= ULLONG_MAX - IOC_PAGE_SIZE,
+
 	/* if apart further than 16M, consider randio for linear model */
 	LCOEF_RANDIO_PAGES	= 4096,
 };
@@ -3431,6 +3434,8 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 			goto out_unlock;
 		}
 
+		if (v > I_LCOEF_MAX)
+			goto out_unlock;
 		u[tok] = v;
 		user = true;
 	}
-- 
2.31.1

