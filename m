Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA0679161
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 07:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjAXG5p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 01:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjAXG5o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 01:57:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428A1721;
        Mon, 23 Jan 2023 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=evxwlHP6hYFLNCCxHqPA/7nYjEdgIE49tiH9tt6oiLM=; b=yOyjk7zqDpiw4ADQuPVRV8AcMp
        39mj/a1LnrU4fKaFzKe0CAr9pBgBnyTKMKn9R6awDyoE0kyfRc2joJLC/+Um4IBdl7NmnWcaZQ9fK
        KwoMVfTvmRRM/t9Jv6/ZiHE+vb8SVD7FTVM2pyepoY3ZXfoz7BXkoYLYVqeL/sreNivHZ2oGMDTI8
        if60ZLC4tJlTWnlEosS4RYGyjEyRZdgP/iRzDzJMdD5gWFkatx2EZOc9HBu4Tjkl3hIzj85Jtmv7+
        3RXn1zSIf8hZBizZs0Wki4v0WqZ1P3s1GL/1v4XA0FwSZQxfpQMJJwNvud0HsAMm2y4z8HpDHV9KC
        XOeo6a0g==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFV-002aS7-7S; Tue, 24 Jan 2023 06:57:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 05/15] blk-cgroup: store a gendisk to throttle in struct task_struct
Date:   Tue, 24 Jan 2023 07:57:05 +0100
Message-Id: <20230124065716.152286-6-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124065716.152286-1-hch@lst.de>
References: <20230124065716.152286-1-hch@lst.de>
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

Switch from a request_queue pointer and reference to a gendisk once
for the throttle information in struct task_struct.

Move the check for the dead disk to the latest place now that is is
unbundled from the reference grab.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-cgroup.c    | 37 +++++++++++++++++++------------------
 include/linux/sched.h |  2 +-
 kernel/fork.c         |  2 +-
 mm/swapfile.c         |  2 +-
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f5a634ed098db0..603e911d1350db 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1334,9 +1334,9 @@ static void blkcg_bind(struct cgroup_subsys_state *root_css)
 
 static void blkcg_exit(struct task_struct *tsk)
 {
-	if (tsk->throttle_queue)
-		blk_put_queue(tsk->throttle_queue);
-	tsk->throttle_queue = NULL;
+	if (tsk->throttle_disk)
+		put_disk(tsk->throttle_disk);
+	tsk->throttle_disk = NULL;
 }
 
 struct cgroup_subsys io_cgrp_subsys = {
@@ -1778,29 +1778,32 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
  *
  * This is only called if we've been marked with set_notify_resume().  Obviously
  * we can be set_notify_resume() for reasons other than blkcg throttling, so we
- * check to see if current->throttle_queue is set and if not this doesn't do
+ * check to see if current->throttle_disk is set and if not this doesn't do
  * anything.  This should only ever be called by the resume code, it's not meant
  * to be called by people willy-nilly as it will actually do the work to
  * throttle the task if it is setup for throttling.
  */
 void blkcg_maybe_throttle_current(void)
 {
-	struct request_queue *q = current->throttle_queue;
+	struct gendisk *disk = current->throttle_disk;
 	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool use_memdelay = current->use_memdelay;
 
-	if (!q)
+	if (!disk)
 		return;
 
-	current->throttle_queue = NULL;
+	current->throttle_disk = NULL;
 	current->use_memdelay = false;
 
+	if (test_bit(GD_DEAD, &disk->state))
+		goto out_put_disk;
+
 	rcu_read_lock();
 	blkcg = css_to_blkcg(blkcg_css());
 	if (!blkcg)
 		goto out;
-	blkg = blkg_lookup(blkcg, q);
+	blkg = blkg_lookup(blkcg, disk->queue);
 	if (!blkg)
 		goto out;
 	if (!blkg_tryget(blkg))
@@ -1809,11 +1812,12 @@ void blkcg_maybe_throttle_current(void)
 
 	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
 	blkg_put(blkg);
-	blk_put_queue(q);
+	put_disk(disk);
 	return;
 out:
 	rcu_read_unlock();
-	blk_put_queue(q);
+out_put_disk:
+	put_disk(disk);
 }
 
 /**
@@ -1835,18 +1839,15 @@ void blkcg_maybe_throttle_current(void)
  */
 void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
 {
-	struct request_queue *q = disk->queue;
-
 	if (unlikely(current->flags & PF_KTHREAD))
 		return;
 
-	if (current->throttle_queue != q) {
-		if (!blk_get_queue(q))
-			return;
+	if (current->throttle_disk != disk) {
+		get_device(disk_to_dev(disk));
 
-		if (current->throttle_queue)
-			blk_put_queue(current->throttle_queue);
-		current->throttle_queue = q;
+		if (current->throttle_disk)
+			put_disk(current->throttle_disk);
+		current->throttle_disk = disk;
 	}
 
 	if (use_memdelay)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562bda..6f6ce9ca709798 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1436,7 +1436,7 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-	struct request_queue		*throttle_queue;
+	struct gendisk			*throttle_disk;
 #endif
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe354189785..d9c97704b7c9a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1044,7 +1044,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-	tsk->throttle_queue = NULL;
+	tsk->throttle_disk = NULL;
 	tsk->use_memdelay = 0;
 #endif
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 908a529bca12c9..3e0a742fb7bbff 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3642,7 +3642,7 @@ void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 	 * We've already scheduled a throttle, avoid taking the global swap
 	 * lock.
 	 */
-	if (current->throttle_queue)
+	if (current->throttle_disk)
 		return;
 
 	spin_lock(&swap_avail_lock);
-- 
2.39.0

