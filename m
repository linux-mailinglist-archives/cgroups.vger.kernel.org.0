Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFC63D629
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 14:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiK3NBC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiK3NA6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 08:00:58 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFF4E421;
        Wed, 30 Nov 2022 05:00:56 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NMfPR28XyzJp39;
        Wed, 30 Nov 2022 20:57:31 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:00:54 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 30 Nov
 2022 21:00:54 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 8/9] block: fix null-pointer dereference in ioc_pd_init
Date:   Wed, 30 Nov 2022 21:21:55 +0800
Message-ID: <20221130132156.2836184-9-linan122@huawei.com>
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

Remove block device when iocost is initializing may cause
null-pointer dereference:

	CPU1				   CPU2
  ioc_qos_write
   blkcg_conf_open_bdev
    blkdev_get_no_open
     kobject_get_unless_zero
    blk_iocost_init
     rq_qos_add
  					del_gendisk
  					 rq_qos_exit
  					  q->rq_qos = rqos->next
  					   //iocost is removed from q->roqs
      blkcg_activate_policy
       pd_init_fn
        ioc_pd_init
  	 ioc = q_to_ioc(blkg->q)
 	  //cant find iocost and return null

Fix problem by moving rq_qos_exit() to disk_release(). ioc_qos_write() get
bd_device.kobj in blkcg_conf_open_bdev(), so disk_release will not be
actived until iocost initialization is complited.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index dcf200bcbd3e..0db440bbfefb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -656,7 +656,6 @@ void del_gendisk(struct gendisk *disk)
 		elevator_exit(q);
 		mutex_unlock(&q->sysfs_lock);
 	}
-	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
 
 	/*
@@ -1168,6 +1167,7 @@ static void disk_release(struct device *dev)
 	    !test_bit(GD_ADDED, &disk->state))
 		blk_mq_exit_queue(disk->queue);
 
+	rq_qos_exit(disk->queue);
 	blkcg_exit_disk(disk);
 
 	bioset_exit(&disk->bio_split);
-- 
2.31.1

