Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2098696D04
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjBNSds (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 13:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjBNSdr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 13:33:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0A10F7;
        Tue, 14 Feb 2023 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7z80PKihpF8oDf7peAKd5FOgX3qb4pCIkqQBMbAkPbA=; b=jqrjjlMWAQcU2u9yCF3OG3Gm01
        4BDBO3fXJWT/VPLro3VfJjPh9nttZbuelkQNsJXi5Er2DH0GgF39BpsaF+ZduIVD4VR/NYVjtQxSs
        OJMWpwoS4GIuq0f+GmzWB6O0YIUm4RNMlKLs6Vbx3hnaOTUdkUXYe48tLiwklb+Z2KGJf+p1QGlLS
        73wNQAGnms+Q6kq1npfUMAwu49sBIyHFCwVD/fsinacPpoUf1qwcYNS4yzymepK75yHQqE4jPNIMG
        NfXdNzm21/XPudDP7lPTFUYkSaYTJergPnywiXIhI5jZqZdPUF3FrJG9otL/2kC5kK9hELgY+6y3j
        mwT+S9ug==;
Received: from [2001:4bb8:181:6771:29b8:d178:cc31:6d8f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS07X-003Bev-3o; Tue, 14 Feb 2023 18:33:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 4/5] Revert "blk-cgroup: pass a gendisk to blkg_lookup"
Date:   Tue, 14 Feb 2023 19:33:07 +0100
Message-Id: <20230214183308.1658775-5-hch@lst.de>
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

This reverts commit 821e840c08ad83736eced4037cdad864e95e2584.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 16 ++++++++--------
 block/blk-cgroup.h | 20 ++++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1653786644eab1..1574566321245e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -350,7 +350,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
-		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk);
+		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
 			goto err_put_css;
@@ -423,12 +423,12 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	blkg = blkg_lookup(blkcg, disk);
+	blkg = blkg_lookup(blkcg, q);
 	if (blkg)
 		return blkg;
 
 	spin_lock_irqsave(&q->queue_lock, flags);
-	blkg = blkg_lookup(blkcg, disk);
+	blkg = blkg_lookup(blkcg, q);
 	if (blkg) {
 		if (blkcg != &blkcg_root &&
 		    blkg != rcu_dereference(blkcg->blkg_hint))
@@ -447,7 +447,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		struct blkcg_gq *ret_blkg = q->root_blkg;
 
 		while (parent) {
-			blkg = blkg_lookup(parent, disk);
+			blkg = blkg_lookup(parent, q);
 			if (blkg) {
 				/* remember closest blkg */
 				ret_blkg = blkg;
@@ -733,7 +733,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		goto fail_unlock;
 	}
 
-	blkg = blkg_lookup(blkcg, disk);
+	blkg = blkg_lookup(blkcg, q);
 	if (blkg)
 		goto success;
 
@@ -747,7 +747,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		struct blkcg_gq *new_blkg;
 
 		parent = blkcg_parent(blkcg);
-		while (parent && !blkg_lookup(parent, disk)) {
+		while (parent && !blkg_lookup(parent, q)) {
 			pos = parent;
 			parent = blkcg_parent(parent);
 		}
@@ -777,7 +777,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_preloaded;
 		}
 
-		blkg = blkg_lookup(pos, disk);
+		blkg = blkg_lookup(pos, q);
 		if (blkg) {
 			blkg_free(new_blkg);
 		} else {
@@ -1852,7 +1852,7 @@ void blkcg_maybe_throttle_current(void)
 	blkcg = css_to_blkcg(blkcg_css());
 	if (!blkcg)
 		goto out;
-	blkg = blkg_lookup(blkcg, disk);
+	blkg = blkg_lookup(blkcg, disk->queue);
 	if (!blkg)
 		goto out;
 	if (!blkg_tryget(blkg))
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 151f24de253985..3d9e42c519db86 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -234,30 +234,30 @@ static inline bool bio_issue_as_root_blkg(struct bio *bio)
 }
 
 /**
- * blkg_lookup - lookup blkg for the specified blkcg - disk pair
+ * blkg_lookup - lookup blkg for the specified blkcg - q pair
  * @blkcg: blkcg of interest
- * @disk: gendisk of interest
+ * @q: request_queue of interest
  *
- * Lookup blkg for the @blkcg - @disk pair.
+ * Lookup blkg for the @blkcg - @q pair.
 
  * Must be called in a RCU critical section.
  */
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
-					   struct gendisk *disk)
+					   struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (blkcg == &blkcg_root)
-		return disk->queue->root_blkg;
+		return q->root_blkg;
 
 	blkg = rcu_dereference(blkcg->blkg_hint);
-	if (blkg && blkg->disk == disk)
+	if (blkg && blkg->disk->queue == q)
 		return blkg;
 
-	blkg = radix_tree_lookup(&blkcg->blkg_tree, disk->queue->id);
-	if (blkg && blkg->disk != disk)
+	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
+	if (blkg && blkg->disk->queue != q)
 		blkg = NULL;
 	return blkg;
 }
@@ -357,7 +357,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->disk)))
+					    (p_blkg)->disk->queue)))
 
 /**
  * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
@@ -372,7 +372,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->disk)))
+					    (p_blkg)->disk->queue)))
 
 bool __blkcg_punt_bio_submit(struct bio *bio);
 
-- 
2.39.1

