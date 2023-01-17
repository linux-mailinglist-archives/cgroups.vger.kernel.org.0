Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C166D7B0
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjAQINN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbjAQINH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 03:13:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0843021953;
        Tue, 17 Jan 2023 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=u4BtYojSSHY1pr6Qxzatfu3KbcIWTBHedcaCK8xLKug=; b=hx+K9Y8IA0k+SYJ85uMwwiUnVB
        NaavNZsaNToJt0wtJ0lQCrmHpaKxQgPpOwl4ujAwgWlHVxwBxekTEXy342aYndOjey6HAVX9sdD+I
        Gy4px6sJW9fii2UUFHBcY1xfrEx/N1Prs7z3WrDAhcQU+j3WU+DdiaYugUliuis9CHZVa0mub9WPK
        /z4lHLOqF85vP41uoIoFQ3bPlHNEzH0cA43yHWb7CEstpWfMOyEqSemYLJ+e2y/YIlxK7QZv6J9rK
        QxcU1+d524jVaYtsOTRQI3Ll4mGZS2VYDDPAmFBT5MiON8dTT+TDwXTxGqIec6mfuej0+NuGtEnWw
        X8PX9jrQ==;
Received: from [2001:4bb8:19a:2039:eaa2:3b9e:be2e:bd2a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh5a-00DHgv-OZ; Tue, 17 Jan 2023 08:13:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Date:   Tue, 17 Jan 2023 09:12:43 +0100
Message-Id: <20230117081257.3089859-2-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117081257.3089859-1-hch@lst.de>
References: <20230117081257.3089859-1-hch@lst.de>
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

Now that blk_put_queue can be called from process context, ther is no
need for the asynchronous execution.

This effectively reverts commit d578c770c85233af592e54537f93f3831bde7e9a.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 32 ++++++++++----------------------
 block/blk-cgroup.h |  5 +----
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ce6a2b7d3dfb2b..30d493b43f9272 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -114,12 +114,19 @@ static bool blkcg_policy_enabled(struct request_queue *q,
 	return pol && test_bit(pol->plid, q->blkcg_pols);
 }
 
-static void blkg_free_workfn(struct work_struct *work)
+/**
+ * blkg_free - free a blkg
+ * @blkg: blkg to free
+ *
+ * Free @blkg which may be partially allocated.
+ */
+static void blkg_free(struct blkcg_gq *blkg)
 {
-	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
-					     free_work);
 	int i;
 
+	if (!blkg)
+		return;
+
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
@@ -131,25 +138,6 @@ static void blkg_free_workfn(struct work_struct *work)
 	kfree(blkg);
 }
 
-/**
- * blkg_free - free a blkg
- * @blkg: blkg to free
- *
- * Free @blkg which may be partially allocated.
- */
-static void blkg_free(struct blkcg_gq *blkg)
-{
-	if (!blkg)
-		return;
-
-	/*
-	 * Both ->pd_free_fn() and request queue's release handler may
-	 * sleep, so free us by scheduling one work func
-	 */
-	INIT_WORK(&blkg->free_work, blkg_free_workfn);
-	schedule_work(&blkg->free_work);
-}
-
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1e94e404eaa80a..f126fe36001eb3 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -75,10 +75,7 @@ struct blkcg_gq {
 
 	spinlock_t			async_bio_lock;
 	struct bio_list			async_bios;
-	union {
-		struct work_struct	async_bio_work;
-		struct work_struct	free_work;
-	};
+	struct work_struct		async_bio_work;
 
 	atomic_t			use_delay;
 	atomic64_t			delay_nsec;
-- 
2.39.0

