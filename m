Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F620BFAE
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgF0Hct (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0Hcs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:48 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3156FC03E979;
        Sat, 27 Jun 2020 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S7ew7tFSTCy/AgXfhknQUe2b8dthYpBxIvPKvi74jmI=; b=YdxLWQTAi5Ieyyatgq0h9uJfn1
        BGXkahQmOZuu9szIz6bz4ij6CxtHBH4Ab+5mc0WAE/Lz8VHb2l3vz9Nv11Uau3jfnvvMhlNtPph2W
        476eG96my0sNe0X6xcuGOWkoLNTLAI+BVMhRNE0mZwr/vfKAhSeeNtn3WYUlfeHKbQ9zEBNfM1+jG
        v8F/RPXkYoIfuas7wxO0yuB2C3eigotYi1AfVik7M7Aq4YZM4wdxg5AJyNa4tU1cYZ+Q1Y+i+4Y16
        g6mVz15f41EyQ+5CSe/9nlppdQ+Cj70QyR+cStzXHF091tiiVKIUcfiuT+A4vIT+UoaeT0mQtmyXX
        0VA1lnlw==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5K3-0006nC-48; Sat, 27 Jun 2020 07:32:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 07/14] block: merge blkg_lookup_create and __blkg_lookup_create
Date:   Sat, 27 Jun 2020 09:31:52 +0200
Message-Id: <20200627073159.2447325-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No good reason to keep these two functions split.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 49 +++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bb0607bfd771cd..6aedb73ffbf473 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -316,30 +316,35 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 }
 
 /**
- * __blkg_lookup_create - lookup blkg, try to create one if not there
+ * blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
  *
  * Lookup blkg for the @blkcg - @q pair.  If it doesn't exist, try to
  * create one.  blkg creation is performed recursively from blkcg_root such
  * that all non-root blkg's have access to the parent blkg.  This function
- * should be called under RCU read lock and @q->queue_lock.
+ * should be called under RCU read lock and takes @q->queue_lock.
  *
  * Returns the blkg or the closest blkg if blkg_create() fails as it walks
  * down from root.
  */
-static struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
-				      struct request_queue *q)
+static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+		struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
+	unsigned long flags;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	lockdep_assert_held(&q->queue_lock);
 
-	blkg = __blkg_lookup(blkcg, q, true);
+	blkg = blkg_lookup(blkcg, q);
 	if (blkg)
 		return blkg;
 
+	spin_lock_irqsave(&q->queue_lock, flags);
+	blkg = __blkg_lookup(blkcg, q, true);
+	if (blkg)
+		goto found;
+
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
 	 * non-root blkgs have access to their parents.  Returns the closest
@@ -362,34 +367,16 @@ static struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 		}
 
 		blkg = blkg_create(pos, q, NULL);
-		if (IS_ERR(blkg))
-			return ret_blkg;
+		if (IS_ERR(blkg)) {
+			blkg = ret_blkg;
+			break;
+		}
 		if (pos == blkcg)
-			return blkg;
-	}
-}
-
-/**
- * blkg_lookup_create - find or create a blkg
- * @blkcg: target block cgroup
- * @q: target request_queue
- *
- * This looks up or creates the blkg representing the unique pair
- * of the blkcg and the request_queue.
- */
-static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q)
-{
-	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
-
-	if (unlikely(!blkg)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&q->queue_lock, flags);
-		blkg = __blkg_lookup_create(blkcg, q);
-		spin_unlock_irqrestore(&q->queue_lock, flags);
+			break;
 	}
 
+found:
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 	return blkg;
 }
 
-- 
2.26.2

