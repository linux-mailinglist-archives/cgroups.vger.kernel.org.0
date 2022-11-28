Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981BD63AC28
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 16:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiK1PXh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 10:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiK1PXc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 10:23:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617072DFC;
        Mon, 28 Nov 2022 07:23:32 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLTk15F8fzHw8m;
        Mon, 28 Nov 2022 23:22:49 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 23:23:30 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 23:23:30 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 8/8] block: fix null-pointer dereference in ioc_pd_init
Date:   Mon, 28 Nov 2022 23:44:34 +0800
Message-ID: <20221128154434.4177442-9-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128154434.4177442-1-linan122@huawei.com>
References: <20221128154434.4177442-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
index dcf200bcbd3e..c264da49eaaa 100644
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
 
+	rq_qos_exit(q);
 	blkcg_exit_disk(disk);
 
 	bioset_exit(&disk->bio_split);
-- 
2.31.1

