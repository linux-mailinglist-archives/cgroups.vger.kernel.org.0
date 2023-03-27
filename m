Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E836C9924
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjC0AuD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjC0AuC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:50:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478349F5;
        Sun, 26 Mar 2023 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pj7d/inDg8RK1dUYuNlUKNWpx/8QKmO27tOlzu2yAOY=; b=PcrqjweRAcFZCnI7YZSBwjRJtk
        mCGOA6EoTIGRy3e7V0v2LyRPZQsNERGhjkE/y9Rj+J0GXOt0w8578cEgJOezWgERD2HK4efKEASl5
        /0GLfeUS3lhByoMsRsHanbzETjMZeSu6o+57CrS8fIBQMErMpLBSoR5lq751uJx/CF3O+CQXvce6y
        XZH23AuJ4a1BQ3wvaYdVxMf8RudRJZ2WrXjgpWzMqjEZN1um8SbRntR5myXchrxM42xhtFOMMtBfS
        N4LcU69pk0BSS1LY58x/mA4YfuCT9bJcbTKNmEd4Sdf3UBDTxAxMVz3rmkEgGP6hZcAR9APeWuRzx
        wyxoiGnA==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3c-009QtN-33;
        Mon, 27 Mar 2023 00:49:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs, block: move REQ_CGROUP_PUNT to btrfs
Date:   Mon, 27 Mar 2023 09:49:51 +0900
Message-Id: <20230327004954.728797-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327004954.728797-1-hch@lst.de>
References: <20230327004954.728797-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

REQ_CGROUP_PUNT is a bit annoying as it is hard to follow and adds
a branch to the bio submission hot path.  To fix this, export
blkcg_punt_bio_submit and let btrfs call it directly.  Add a new
REQ_FS_PRIVATE flag for btrfs to indicate to it's own low-level
bio submission code that a punt to the cgroup submission helper
is required.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c        | 31 +++++++++++++++++--------------
 block/blk-cgroup.h        | 12 ------------
 block/blk-core.c          |  3 ---
 fs/btrfs/bio.c            | 12 ++++++++----
 fs/btrfs/bio.h            |  3 +++
 fs/btrfs/extent_io.c      |  2 +-
 fs/btrfs/inode.c          |  2 +-
 include/linux/bio.h       |  5 +++++
 include/linux/blk_types.h | 18 +++++-------------
 9 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb6135..9f5f3263c1781e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1688,24 +1688,27 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
 
-bool __blkcg_punt_bio_submit(struct bio *bio)
+/*
+ * When a shared kthread issues a bio for a cgroup, doing so synchronously can
+ * lead to priority inversions as the kthread can be trapped waiting for that
+ * cgroup.  Use this helper instead of submit_bio to punt the actual issuing to
+ * a dedicated per-blkcg work item to avoid such priority inversions.
+ */
+void blkcg_punt_bio_submit(struct bio *bio)
 {
 	struct blkcg_gq *blkg = bio->bi_blkg;
 
-	/* consume the flag first */
-	bio->bi_opf &= ~REQ_CGROUP_PUNT;
-
-	/* never bounce for the root cgroup */
-	if (!blkg->parent)
-		return false;
-
-	spin_lock_bh(&blkg->async_bio_lock);
-	bio_list_add(&blkg->async_bios, bio);
-	spin_unlock_bh(&blkg->async_bio_lock);
-
-	queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
-	return true;
+	if (blkg->parent) {
+		spin_lock_bh(&blkg->async_bio_lock);
+		bio_list_add(&blkg->async_bios, bio);
+		spin_unlock_bh(&blkg->async_bio_lock);
+		queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
+	} else {
+		/* never bounce for the root cgroup */
+		submit_bio(bio);
+	}
 }
+EXPORT_SYMBOL_GPL(blkcg_punt_bio_submit);
 
 /*
  * Scale the accumulated delay based on how long it has been since we updated
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 9c5078755e5e19..64758ab9f1f134 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -375,16 +375,6 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
 					    (p_blkg)->q)))
 
-bool __blkcg_punt_bio_submit(struct bio *bio);
-
-static inline bool blkcg_punt_bio_submit(struct bio *bio)
-{
-	if (bio->bi_opf & REQ_CGROUP_PUNT)
-		return __blkcg_punt_bio_submit(bio);
-	else
-		return false;
-}
-
 static inline void blkcg_bio_issue_init(struct bio *bio)
 {
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
@@ -506,8 +496,6 @@ static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return
 static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
-
-static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline void blk_cgroup_bio_start(struct bio *bio) { }
 static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
diff --git a/block/blk-core.c b/block/blk-core.c
index 42926e6cb83c8e..478978dcb2bd50 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -830,9 +830,6 @@ EXPORT_SYMBOL(submit_bio_noacct);
  */
 void submit_bio(struct bio *bio)
 {
-	if (blkcg_punt_bio_submit(bio))
-		return;
-
 	if (bio_op(bio) == REQ_OP_READ) {
 		task_io_account_read(bio->bi_iter.bi_size);
 		count_vm_events(PGPGIN, bio_sectors(bio));
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edbee..60cf186085bf0a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -421,7 +421,11 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		dev->devid, bio->bi_iter.bi_size);
 
 	btrfsic_check_bio(bio);
-	submit_bio(bio);
+
+	if (bio->bi_opf & REQ_BTRFS_CGROUP_PUNT)
+		blkcg_punt_bio_submit(bio);
+	else
+		submit_bio(bio);
 }
 
 static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
@@ -537,10 +541,10 @@ static void run_one_async_done(struct btrfs_work *work)
 
 	/*
 	 * All of the bios that pass through here are from async helpers.
-	 * Use REQ_CGROUP_PUNT to issue them from the owning cgroup's context.
-	 * This changes nothing when cgroups aren't in use.
+	 * Use REQ_BTRFS_CGROUP_PUNT to issue them from the owning cgroup's
+	 * context.  This changes nothing when cgroups aren't in use.
 	 */
-	bio->bi_opf |= REQ_CGROUP_PUNT;
+	bio->bi_opf |= REQ_BTRFS_CGROUP_PUNT;
 	__btrfs_submit_bio(bio, async->bioc, &async->smap, async->mirror_num);
 }
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index dbf125f6fa336d..8edf3c35eead90 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -88,6 +88,9 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 /* Bio only refers to one ordered extent. */
 #define REQ_BTRFS_ONE_ORDERED			REQ_DRV
 
+/* Submit using blkcg_punt_bio_submit. */
+#define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
+
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f5702b1e2b86b0..f40e4a002f789a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2538,7 +2538,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.wbc = &wbc_writepages,
 		/* We're called from an async helper function */
-		.opf = REQ_OP_WRITE | REQ_CGROUP_PUNT |
+		.opf = REQ_OP_WRITE | REQ_BTRFS_CGROUP_PUNT |
 			wbc_to_write_flags(&wbc_writepages),
 		.extent_locked = 1,
 	};
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 713b47792b9b7e..1a34374c8e327e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1615,7 +1615,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		if (blkcg_css != blkcg_root_css) {
 			css_get(blkcg_css);
 			async_chunk[i].blkcg_css = blkcg_css;
-			async_chunk[i].write_flags |= REQ_CGROUP_PUNT;
+			async_chunk[i].write_flags |= REQ_BTRFS_CGROUP_PUNT;
 		} else {
 			async_chunk[i].blkcg_css = NULL;
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e151..b3e7529ff55eb3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -500,6 +500,7 @@ void bio_associate_blkg(struct bio *bio);
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
+void blkcg_punt_bio_submit(struct bio *bio);
 #else	/* CONFIG_BLK_CGROUP */
 static inline void bio_associate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg_from_css(struct bio *bio,
@@ -507,6 +508,10 @@ static inline void bio_associate_blkg_from_css(struct bio *bio,
 { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
+static inline void blkcg_punt_bio_submit(struct bio *bio)
+{
+	submit_bio(bio);
+}
 #endif	/* CONFIG_BLK_CGROUP */
 
 static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f6e..fb8843990d288e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -404,18 +404,11 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
-	/*
-	 * When a shared kthread needs to issue a bio for a cgroup, doing
-	 * so synchronously can lead to priority inversions as the kthread
-	 * can be trapped waiting for that cgroup.  CGROUP_PUNT flag makes
-	 * submit_bio() punt the actual issuing to a dedicated per-blkcg
-	 * work item to avoid such priority inversions.
-	 */
-	__REQ_CGROUP_PUNT,
 	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
 	__REQ_SWAP,		/* swap I/O */
 	__REQ_DRV,		/* for driver use */
+	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 
 	/*
 	 * Command specific flags, keep last:
@@ -443,14 +436,13 @@ enum req_flag_bits {
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
-#define REQ_CGROUP_PUNT	(__force blk_opf_t)(1ULL << __REQ_CGROUP_PUNT)
-
-#define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
-
-#define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
+#define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
+#define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
+
+#define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.39.2

