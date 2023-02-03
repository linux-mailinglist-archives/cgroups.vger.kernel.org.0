Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF7689C8E
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjBCPEU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjBCPET (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:04:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B2A1453;
        Fri,  3 Feb 2023 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EPfnq7z73vpmLopiiLSTsg+UYOgAEEjPrhtrmGL5ArE=; b=AwMWRjxiNUZumIZ/RvVRdozfgz
        Nfas8+h6EDKSy8XDYq2bAODAwkQUR1l/nA78fvNicYSKbjpYO+ha5q8/Xk/NCUaybuDMb8dw2ITgg
        bDF93rneapU48ftfXzGVDLBnoCUimwbPLk9R0dyLkow1hKH80/YpNcMTK3HYRTu68sQQWwQvHzFuL
        1bmTCe9uy6HWQmwKiec+jk9qbtvdkuh0iMff6A19quScNyCC1XEp9oD7AcXvKX3NSl3Fo6zUaicw5
        RMMIqI1kbZK/Rg9QrK0wA3NTWXVtDE67P9E+j+bI4nVehr/49u7eCC+P7c4w293I0y2GCuURrcRYO
        LujfEDyA==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxbr-002a1p-7z; Fri, 03 Feb 2023 15:04:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 04/19] blk-cgroup: simplify blkg freeing from initialization failure paths
Date:   Fri,  3 Feb 2023 16:03:45 +0100
Message-Id: <20230203150400.3199230-5-hch@lst.de>
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

There is no need to delay freeing a blkg to a workqueue when freeing it
after an initialization failure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9df02a6d04d35a..1038688568926e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -114,10 +114,8 @@ static bool blkcg_policy_enabled(struct request_queue *q,
 	return pol && test_bit(pol->plid, q->blkcg_pols);
 }
 
-static void blkg_free_workfn(struct work_struct *work)
+static void blkg_free(struct blkcg_gq *blkg)
 {
-	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
-					     free_work);
 	struct request_queue *q = blkg->q;
 	int i;
 
@@ -143,23 +141,9 @@ static void blkg_free_workfn(struct work_struct *work)
 	kfree(blkg);
 }
 
-/**
- * blkg_free - free a blkg
- * @blkg: blkg to free
- *
- * Free @blkg which may be partially allocated.
- */
-static void blkg_free(struct blkcg_gq *blkg)
+static void blkg_free_workfn(struct work_struct *work)
 {
-	if (!blkg)
-		return;
-
-	/*
-	 * Both ->pd_free_fn() and request queue's release handler may
-	 * sleep, so free us by scheduling one work func
-	 */
-	INIT_WORK(&blkg->free_work, blkg_free_workfn);
-	schedule_work(&blkg->free_work);
+	blkg_free(container_of(work, struct blkcg_gq, free_work));
 }
 
 static void __blkg_release(struct rcu_head *rcu)
@@ -170,7 +154,10 @@ static void __blkg_release(struct rcu_head *rcu)
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
-	blkg_free(blkg);
+
+	/* ->pd_free_fn() may sleep, so free from a work queue */
+	INIT_WORK(&blkg->free_work, blkg_free_workfn);
+	schedule_work(&blkg->free_work);
 }
 
 /*
-- 
2.39.0

