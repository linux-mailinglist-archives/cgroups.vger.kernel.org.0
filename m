Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBE67917C
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 07:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjAXG6V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 01:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjAXG6U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 01:58:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D211117C;
        Mon, 23 Jan 2023 22:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NZLDUBJPrIYcuYYeQA8bitp+4kRAGVy+hKmq8vSRtu4=; b=nJxhx4L3fpUuOv8BfSgUgk0fpa
        wTktovZaSEq6CHhB+1SCJgTxo4RdJgrM0VTkqvg+sUXA5/bUFp1KJ2MEAxoqUFTSrcksJHyalFpdr
        qzHrdexdwNll5/1RIP/E3ftSgsaED7jRWVFXqJ7fBjP/d81NvTPmYUt/uaq2Gb0r2Cpr0mFpylkXD
        M+YlH6QJH2vGEVzBLqhYqrYPNbOknJL5//y/38dvK1w/hBoax4f8ATPagWXxUrwosc4zO9dDcg5ZW
        2k6aJ1pAYuI2Yk+AwJdP6PjemnsuNcmPakV8IT1Q/IkbHS3qlVmRUNZY1yiYZ21d3MPkURoKhcok0
        5hBdZZ+A==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFx-002aX4-0P; Tue, 24 Jan 2023 06:58:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 14/15] blk-cgroup: pass a gendisk to blkg_lookup
Date:   Tue, 24 Jan 2023 07:57:14 +0100
Message-Id: <20230124065716.152286-15-hch@lst.de>
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

Pass a gendisk to blkg_lookup and use that to find the match as part
of phasing out usage of the request_queue in the blk-cgroup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-cgroup.c | 16 ++++++++--------
 block/blk-cgroup.h | 20 ++++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2fa42b5b538069..b9883ea81ad0da 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -320,7 +320,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
-		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
+		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
 			goto err_put_css;
@@ -389,12 +389,12 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	blkg = blkg_lookup(blkcg, q);
+	blkg = blkg_lookup(blkcg, disk);
 	if (blkg)
 		return blkg;
 
 	spin_lock_irqsave(&q->queue_lock, flags);
-	blkg = blkg_lookup(blkcg, q);
+	blkg = blkg_lookup(blkcg, disk);
 	if (blkg) {
 		if (blkcg != &blkcg_root &&
 		    blkg != rcu_dereference(blkcg->blkg_hint))
@@ -413,7 +413,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		struct blkcg_gq *ret_blkg = q->root_blkg;
 
 		while (parent) {
-			blkg = blkg_lookup(parent, q);
+			blkg = blkg_lookup(parent, disk);
 			if (blkg) {
 				/* remember closest blkg */
 				ret_blkg = blkg;
@@ -692,7 +692,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		goto fail_unlock;
 	}
 
-	blkg = blkg_lookup(blkcg, q);
+	blkg = blkg_lookup(blkcg, disk);
 	if (blkg)
 		goto success;
 
@@ -706,7 +706,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		struct blkcg_gq *new_blkg;
 
 		parent = blkcg_parent(blkcg);
-		while (parent && !blkg_lookup(parent, q)) {
+		while (parent && !blkg_lookup(parent, disk)) {
 			pos = parent;
 			parent = blkcg_parent(parent);
 		}
@@ -736,7 +736,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_preloaded;
 		}
 
-		blkg = blkg_lookup(pos, q);
+		blkg = blkg_lookup(pos, disk);
 		if (blkg) {
 			blkg_free(new_blkg);
 		} else {
@@ -1804,7 +1804,7 @@ void blkcg_maybe_throttle_current(void)
 	blkcg = css_to_blkcg(blkcg_css());
 	if (!blkcg)
 		goto out;
-	blkg = blkg_lookup(blkcg, disk->queue);
+	blkg = blkg_lookup(blkcg, disk);
 	if (!blkg)
 		goto out;
 	if (!blkg_tryget(blkg))
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 9a2cd3c71a94a2..3e7508907f33d8 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -230,30 +230,30 @@ static inline bool bio_issue_as_root_blkg(struct bio *bio)
 }
 
 /**
- * blkg_lookup - lookup blkg for the specified blkcg - q pair
+ * blkg_lookup - lookup blkg for the specified blkcg - disk pair
  * @blkcg: blkcg of interest
- * @q: request_queue of interest
+ * @disk: gendisk of interest
  *
- * Lookup blkg for the @blkcg - @q pair.
+ * Lookup blkg for the @blkcg - @disk pair.
 
  * Must be called in a RCU critical section.
  */
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
-					   struct request_queue *q)
+					   struct gendisk *disk)
 {
 	struct blkcg_gq *blkg;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (blkcg == &blkcg_root)
-		return q->root_blkg;
+		return disk->queue->root_blkg;
 
 	blkg = rcu_dereference(blkcg->blkg_hint);
-	if (blkg && blkg->disk->queue == q)
+	if (blkg && blkg->disk == disk)
 		return blkg;
 
-	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
-	if (blkg && blkg->disk->queue != q)
+	blkg = radix_tree_lookup(&blkcg->blkg_tree, disk->queue->id);
+	if (blkg && blkg->disk != disk)
 		blkg = NULL;
 	return blkg;
 }
@@ -353,7 +353,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->disk->queue)))
+					    (p_blkg)->disk)))
 
 /**
  * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
@@ -368,7 +368,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->disk->queue)))
+					    (p_blkg)->disk)))
 
 bool __blkcg_punt_bio_submit(struct bio *bio);
 
-- 
2.39.0

