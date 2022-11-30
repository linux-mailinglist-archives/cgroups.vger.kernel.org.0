Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619463D62A
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 14:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiK3NBE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 08:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiK3NA6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 08:00:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B154EC2A;
        Wed, 30 Nov 2022 05:00:58 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NMfSZ67kyzRpfP;
        Wed, 30 Nov 2022 21:00:14 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:00:55 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 30 Nov
 2022 21:00:54 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 9/9] blk-iocost: fix walk_list corruption
Date:   Wed, 30 Nov 2022 21:21:56 +0800
Message-ID: <20221130132156.2836184-10-linan122@huawei.com>
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

From: Yu Kuai <yukuai3@huawei.com>

Our test report a problem:

------------[ cut here ]------------
list_del corruption. next->prev should be ffff888127e0c4b0, but was ffff888127e090b0
WARNING: CPU: 2 PID: 3117789 at lib/list_debug.c:62 __list_del_entry_valid+0x119/0x130
RIP: 0010:__list_del_entry_valid+0x119/0x130
RIP: 0010:__list_del_entry_valid+0x119/0x130
Call Trace:
 <IRQ>
 iocg_flush_stat.isra.0+0x11e/0x230
 ? ioc_rqos_done+0x230/0x230
 ? ioc_now+0x14f/0x180
 ioc_timer_fn+0x569/0x1640

We haven't reporduced it yet, but we think this is due to parent iocg is
freed before child iocg, and then in ioc_timer_fn, walk_list is
corrupted.

1) Remove child cgroup can concurrent with remove parent cgroup, and
ioc_pd_free for parent iocg can be called before child iocg. This can be
fixed by moving the handle of walk_list to ioc_pd_offline, since that
offline from child is ensured to be called before parent.

2) ioc_pd_free can be triggered from both removing device and removing
cgroup, this patch fix the problem by deleting timer before deactivating
policy, so that free parent iocg first in this case won't matter.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-iocost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 710cf63a1643..d2b873908f88 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2813,13 +2813,14 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
+	del_timer_sync(&ioc->timer);
+
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
 	spin_unlock_irq(&ioc->lock);
 
-	del_timer_sync(&ioc->timer);
 	free_percpu(ioc->pcpu_stat);
 	kfree(ioc);
 }
-- 
2.31.1

