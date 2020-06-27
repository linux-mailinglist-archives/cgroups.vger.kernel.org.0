Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC54F20BFAF
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgF0Hct (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgF0Hcs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:48 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D94C03E97A;
        Sat, 27 Jun 2020 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nuU16mRXYOwpUOjAQFerIPbRDEcrM6bzFgPQvCmulVk=; b=t6EZGTFGBUvjVe9FE06mcfQP9/
        n767z99i4jIPRAXgH9/mbSMB7z2/YITi3XlIWlAfZ5cEVNhbPatenibpnHRDe/sl6/rEwIBXSRZBh
        B5R6PgNKGt+bqJ46jUTvqi5oHz7KhhZcabwle7BRHv23uOHRjQ2KQu6uSFklyLr/I4Mao10HglTSW
        7bvpNcxEXH1jO1UB9hjBc3/AnBPBaQ2+hLaVIO6krs64UiNsJp6N3UnZA7+qwoRU69G/KRrUCowuq
        embVsxiF/hDPQndhKoOtkLYTDv8CKCU0vL1mV9afQzj5X0EUgRI16ySiZNq9IhV1d2iyKgpiJqeMJ
        U18LHFig==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Jz-0006n0-L2; Sat, 27 Jun 2020 07:32:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 06/14] block: move the bio cgroup associatation helpers to blk-cgroup.c
Date:   Sat, 27 Jun 2020 09:31:51 +0200
Message-Id: <20200627073159.2447325-7-hch@lst.de>
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

Keep the cgroup code together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                |  75 ---------------------------
 block/blk-cgroup.c         | 103 ++++++++++++++++++++++++++++++++++++-
 include/linux/blk-cgroup.h |  30 -----------
 3 files changed, 101 insertions(+), 107 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 901d22715dd4f3..fc1299f9d86a24 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1627,81 +1627,6 @@ int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
 }
 EXPORT_SYMBOL(bioset_init_from_src);
 
-#ifdef CONFIG_BLK_CGROUP
-/**
- * bio_associate_blkg_from_css - associate a bio with a specified css
- * @bio: target bio
- * @css: target css
- *
- * Associate @bio with the blkg found by combining the css's blkg and the
- * request_queue of the @bio.  An association failure is handled by walking up
- * the blkg tree.  Therefore, the blkg associated can be anything between @blkg
- * and q->root_blkg.  This situation only happens when a cgroup is dying and
- * then the remaining bios will spill to the closest alive blkg.
- *
- * A reference will be taken on the blkg and will be released when @bio is
- * freed.
- */
-void bio_associate_blkg_from_css(struct bio *bio,
-				 struct cgroup_subsys_state *css)
-{
-	struct request_queue *q = bio->bi_disk->queue;
-	struct blkcg_gq *blkg = q->root_blkg;
-
-	if (bio->bi_blkg)
-		blkg_put(bio->bi_blkg);
-
-	rcu_read_lock();
-	if (css && css->parent)
-		blkg = blkg_lookup_create(css_to_blkcg(css), q);
-	bio->bi_blkg = blkg_tryget_closest(blkg);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
-
-/**
- * bio_associate_blkg - associate a bio with a blkg
- * @bio: target bio
- *
- * Associate @bio with the blkg found from the bio's css and request_queue.
- * If one is not found, bio_lookup_blkg() creates the blkg.  If a blkg is
- * already associated, the css is reused and association redone as the
- * request_queue may have changed.
- */
-void bio_associate_blkg(struct bio *bio)
-{
-	struct cgroup_subsys_state *css;
-
-	rcu_read_lock();
-
-	if (bio->bi_blkg)
-		css = &bio_blkcg(bio)->css;
-	else
-		css = blkcg_css();
-
-	bio_associate_blkg_from_css(bio, css);
-
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL_GPL(bio_associate_blkg);
-
-/**
- * bio_clone_blkg_association - clone blkg association from src to dst bio
- * @dst: destination bio
- * @src: source bio
- */
-void bio_clone_blkg_association(struct bio *dst, struct bio *src)
-{
-	if (src->bi_blkg) {
-		if (dst->bi_blkg)
-			blkg_put(dst->bi_blkg);
-		blkg_get(src->bi_blkg);
-		dst->bi_blkg = src->bi_blkg;
-	}
-}
-EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
-#endif /* CONFIG_BLK_CGROUP */
-
 static void __init biovec_init_slabs(void)
 {
 	int i;
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ecc897b225c96..bb0607bfd771cd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -328,7 +328,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
  * Returns the blkg or the closest blkg if blkg_create() fails as it walks
  * down from root.
  */
-struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+static struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 				      struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
@@ -377,7 +377,7 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
  * This looks up or creates the blkg representing the unique pair
  * of the blkcg and the request_queue.
  */
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 				    struct request_queue *q)
 {
 	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
@@ -1727,6 +1727,105 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 	atomic64_add(delta, &blkg->delay_nsec);
 }
 
+/**
+ * blkg_tryget_closest - try and get a blkg ref on the closet blkg
+ * @blkg: blkg to get
+ *
+ * This needs to be called rcu protected.  As the failure mode here is to walk
+ * up the blkg tree, this ensure that the blkg->parent pointers are always
+ * valid.  This returns the blkg that it ended up taking a reference on or %NULL
+ * if no reference was taken.
+ */
+static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
+{
+	struct blkcg_gq *ret_blkg = NULL;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	while (blkg) {
+		if (blkg_tryget(blkg)) {
+			ret_blkg = blkg;
+			break;
+		}
+		blkg = blkg->parent;
+	}
+
+	return ret_blkg;
+}
+
+/**
+ * bio_associate_blkg_from_css - associate a bio with a specified css
+ * @bio: target bio
+ * @css: target css
+ *
+ * Associate @bio with the blkg found by combining the css's blkg and the
+ * request_queue of the @bio.  An association failure is handled by walking up
+ * the blkg tree.  Therefore, the blkg associated can be anything between @blkg
+ * and q->root_blkg.  This situation only happens when a cgroup is dying and
+ * then the remaining bios will spill to the closest alive blkg.
+ *
+ * A reference will be taken on the blkg and will be released when @bio is
+ * freed.
+ */
+void bio_associate_blkg_from_css(struct bio *bio,
+				 struct cgroup_subsys_state *css)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	struct blkcg_gq *blkg = q->root_blkg;
+
+	if (bio->bi_blkg)
+		blkg_put(bio->bi_blkg);
+
+	rcu_read_lock();
+	if (css && css->parent)
+		blkg = blkg_lookup_create(css_to_blkcg(css), q);
+	bio->bi_blkg = blkg_tryget_closest(blkg);
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
+
+/**
+ * bio_associate_blkg - associate a bio with a blkg
+ * @bio: target bio
+ *
+ * Associate @bio with the blkg found from the bio's css and request_queue.
+ * If one is not found, bio_lookup_blkg() creates the blkg.  If a blkg is
+ * already associated, the css is reused and association redone as the
+ * request_queue may have changed.
+ */
+void bio_associate_blkg(struct bio *bio)
+{
+	struct cgroup_subsys_state *css;
+
+	rcu_read_lock();
+
+	if (bio->bi_blkg)
+		css = &bio_blkcg(bio)->css;
+	else
+		css = blkcg_css();
+
+	bio_associate_blkg_from_css(bio, css);
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(bio_associate_blkg);
+
+/**
+ * bio_clone_blkg_association - clone blkg association from src to dst bio
+ * @dst: destination bio
+ * @src: source bio
+ */
+void bio_clone_blkg_association(struct bio *dst, struct bio *src)
+{
+	if (src->bi_blkg) {
+		if (dst->bi_blkg)
+			blkg_put(dst->bi_blkg);
+		blkg_get(src->bi_blkg);
+		dst->bi_blkg = src->bi_blkg;
+	}
+}
+EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
+
 static int __init blkcg_init(void)
 {
 	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a57ebe2f00abd8..60df97202314c7 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -183,10 +183,6 @@ extern bool blkcg_debug_stats;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
-struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
-				      struct request_queue *q);
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q);
 int blkcg_init_queue(struct request_queue *q);
 void blkcg_exit_queue(struct request_queue *q);
 
@@ -480,32 +476,6 @@ static inline bool blkg_tryget(struct blkcg_gq *blkg)
 	return blkg && percpu_ref_tryget(&blkg->refcnt);
 }
 
-/**
- * blkg_tryget_closest - try and get a blkg ref on the closet blkg
- * @blkg: blkg to get
- *
- * This needs to be called rcu protected.  As the failure mode here is to walk
- * up the blkg tree, this ensure that the blkg->parent pointers are always
- * valid.  This returns the blkg that it ended up taking a reference on or %NULL
- * if no reference was taken.
- */
-static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
-{
-	struct blkcg_gq *ret_blkg = NULL;
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	while (blkg) {
-		if (blkg_tryget(blkg)) {
-			ret_blkg = blkg;
-			break;
-		}
-		blkg = blkg->parent;
-	}
-
-	return ret_blkg;
-}
-
 /**
  * blkg_put - put a blkg reference
  * @blkg: blkg to put
-- 
2.26.2

