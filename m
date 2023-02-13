Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D969430E
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 11:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBMKmJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 05:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBMKmI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 05:42:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499915C84;
        Mon, 13 Feb 2023 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ckmxv8qhJugK1MrR2lVAP90BuFXp6EXY+cU1PNhLSHU=; b=xTAl0YM5g5CYBFm3f8D7umNDo7
        x5HeBP/Pbg1MHWPkf6CXEYrWZLpWDoDWgIw9fgcc3/5pXBgH/C3tBhMee2rv5xHq9wm1Xlaxh+LSG
        tAVHJPE+zFhIPuFtxdBvbVSxnuFAM7meC/kkk/uHJmPq2jiHpSsrJs5JoXbEv2YxPq91ioCE4pJ2G
        P7AR670iFcpc796xctHxG6lp1YsGKH2ffHlwMG0HiutIh1m82GeB+ixnoOjmppaOdKyihfalb3tPe
        z2vrSGwZE75EHQsqtKQ21GguZHKQR8GPD25c30b4Yxc5Nc5SxV84U27MzM82WjdMgSDgCqjfAYje9
        fetC9WIg==;
Received: from [2001:4bb8:181:6771:cbc2:a0cd:a935:7961] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRWHY-00E9Ck-Td; Mon, 13 Feb 2023 10:42:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] blk-cgroup: only grab an inode reference to the disk for each blkg
Date:   Mon, 13 Feb 2023 11:41:34 +0100
Message-Id: <20230213104134.475204-4-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104134.475204-1-hch@lst.de>
References: <20230213104134.475204-1-hch@lst.de>
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

To avoid a circular reference, do not grab a device model reference
to the gendisk for each blkg, but just the lower level inode reference
preventing the memory from beeing freed.

This means blkg freeing and pd_free need to be careful to not rely
on anything torn down in disk_release.

Fixes: c43332fe028c ("blk-cgroup: delay calling blkcg_exit_disk until disk_release")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 935028912e7abf..9e7e48c8fa47ae 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -136,7 +136,7 @@ static void blkg_free_workfn(struct work_struct *work)
 	list_del_init(&blkg->entry);
 	mutex_unlock(&blkg->disk->blkcg_mutex);
 
-	put_disk(blkg->disk);
+	iput(blkg->disk->part0->bd_inode);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -264,9 +264,15 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	if (!blkg->iostat_cpu)
 		goto out_exit_refcnt;
 
+	/*
+	 * Grab a reference the part0 inode, which keeps the memory backing the
+	 * gendisk from beeing released and safe for use in ->pd_free instead of
+	 * the full fledged device model reference because the blkgs are only
+	 * released in disk_release and would thus create circular references.
+	 */
 	if (test_bit(GD_DEAD, &disk->state))
 		goto out_free_iostat;
-	get_device(disk_to_dev(disk));
+	igrab(disk->part0->bd_inode);
 	blkg->disk = disk;
 
 	INIT_LIST_HEAD(&blkg->entry);
@@ -304,7 +310,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	while (--i >= 0)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
-	put_disk(blkg->disk);
+	iput(blkg->disk->part0->bd_inode);
 out_free_iostat:
 	free_percpu(blkg->iostat_cpu);
 out_exit_refcnt:
-- 
2.39.1

