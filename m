Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E74696D01
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 19:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBNSdc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 13:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBNSdb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 13:33:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9A6A4D;
        Tue, 14 Feb 2023 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wfdndwasUMNmL4Xl1uyeX7F8cBc1ybrmZwsSnnhoFFE=; b=phj7XiVzQFY+hkL62n4SKNc/wI
        FCux5wUogq9gZVivEibaurvg3JT1wtipOb2LxvP+axjxR4yKCjglqbuO3NFXwqVmLq8thT9ddv9KS
        Aa0Pt6zBc+hfq/JBCqTQ+XoYlN2EgznyZB9scZEtYr0gPgof7SDn9EkQdkOf2QZyZZu0n5hrDhO1B
        y+UI3o+CT02as290fl7f4JqpANvLX5gkSSVBoQ/m8ZRdTvCfwyRdM9xTnE/zCGBCIahRxY88sv66Z
        21dM1yAQ4R+OxYL6KlUBpiaH8AP1Nw8T4PeUOLQM22BhdxEkSaCkgLy3vZMDcv+ktoJ4MCgyiZVlj
        ur3zdy6g==;
Received: from [2001:4bb8:181:6771:29b8:d178:cc31:6d8f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS07K-003BcT-AJ; Tue, 14 Feb 2023 18:33:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/5] Revert "blk-cgroup: delay calling blkcg_exit_disk until disk_release"
Date:   Tue, 14 Feb 2023 19:33:05 +0100
Message-Id: <20230214183308.1658775-3-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214183308.1658775-1-hch@lst.de>
References: <20230214183308.1658775-1-hch@lst.de>
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

This reverts commit c43332fe028c252a2a28e46be70a530f64fc3c9d as it is not
needed without moving to disk references in the blkg.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c | 3 +--
 block/genhd.c        | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 21c8d5e871eac9..74bb1e753ea09d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2407,8 +2407,7 @@ void blk_throtl_exit(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 
-	if (!q->td)
-		return;
+	BUG_ON(!q->td);
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
diff --git a/block/genhd.c b/block/genhd.c
index 65373738c70b02..7e031559bf514c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -668,6 +668,8 @@ void del_gendisk(struct gendisk *disk)
 	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
 
+	blkcg_exit_disk(disk);
+
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
@@ -1164,8 +1166,6 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	blkcg_exit_disk(disk);
-
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-- 
2.39.1

