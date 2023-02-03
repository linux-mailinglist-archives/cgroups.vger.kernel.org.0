Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBD0689C8A
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjBCPEM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjBCPEM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:04:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53501A003B;
        Fri,  3 Feb 2023 07:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KASJ+cDO5LYIEBF7LSCq8pAmH1ISWk3RLTuGYzaGKiE=; b=pVww5TCmpXYm0e0NJherg9cJAc
        rmFyji4ozgkBI0w3M2AaCgP5L6tEc3ioFUB9TtqLmYrRWe6x1wc2XfiQui/YpFFo8n5HXNPHVoSqr
        ZFsNzagq8+qLQ/UjGLucU/keQOVrqUm7Yn/lBCHHG8KUxPsBXjMk07ha0boiE2njZF63FLQbjN7O0
        r9V6lug3jMgRwSdesNVf6Mka7IYj48wgp/bRO3PIrb4MBPOnYNdR0fEWW27gYVEU3NuApxszt3PFC
        L8XuMpo0iwnUHL9EuWQeQ0zBhU5HF6z9/XxESw92h/NXrych+lZmQmkRVZ1B29f9Lzu3dBEa3C2gH
        BkTmfIAg==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxbk-002ZzO-CF; Fri, 03 Feb 2023 15:04:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 02/19] blk-cgroup: delay blk-cgroup initialization until add_disk
Date:   Fri,  3 Feb 2023 16:03:43 +0100
Message-Id: <20230203150400.3199230-3-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no need to initialize the cgroup code before the disk is marked
live.  Moving the cgroup initialization earlier will help to have a
fully initialized struct device in the gendisk for the cgroup code to
use in the future.  Similarly tear the cgroup information down in
del_gendisk to be symmetric and because none of the cgroup tracking is
needed once non-passthrough I/O stops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/genhd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331cde..705dec0800d62e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -466,10 +466,14 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	ret = blk_integrity_add(disk);
+	ret = blkcg_init_disk(disk);
 	if (ret)
 		goto out_del_block_link;
 
+	ret = blk_integrity_add(disk);
+	if (ret)
+		goto out_blkcg_exit;
+
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
 	if (!disk->part0->bd_holder_dir) {
@@ -534,6 +538,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	kobject_put(disk->part0->bd_holder_dir);
 out_del_integrity:
 	blk_integrity_del(disk);
+out_blkcg_exit:
+	blkcg_exit_disk(disk);
 out_del_block_link:
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(ddev));
@@ -662,6 +668,8 @@ void del_gendisk(struct gendisk *disk)
 	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
 
+	blkcg_exit_disk(disk);
+
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
@@ -1171,8 +1179,6 @@ static void disk_release(struct device *dev)
 	    !test_bit(GD_ADDED, &disk->state))
 		blk_mq_exit_queue(disk->queue);
 
-	blkcg_exit_disk(disk);
-
 	bioset_exit(&disk->bio_split);
 
 	disk_release_events(disk);
@@ -1385,9 +1391,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
 
-	if (blkcg_init_disk(disk))
-		goto out_erase_part0;
-
 	rand_initialize_disk(disk);
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
@@ -1400,8 +1403,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 #endif
 	return disk;
 
-out_erase_part0:
-	xa_erase(&disk->part_tbl, 0);
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-- 
2.39.0

