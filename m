Return-Path: <cgroups+bounces-2223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B4588FA26
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB0B2957CA
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6B54745;
	Thu, 28 Mar 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLwVEFS3"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD55A115;
	Thu, 28 Mar 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615325; cv=none; b=r4rGIt+qRxq/JiFAVIilCd3J+mGi30g0rq2kQY1SL92iq8HPg/UhRee6lbtGwA2a1VLasr1MVjZo1noIoV3gQFgBml0pu2Bdt9jgtjAz3wpXX3jJlo8IvujBooCOXPGi2nNDBujrj0W6mFOjHnQsgdpsPiqubYBzI4YKMPn7OSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615325; c=relaxed/simple;
	bh=SLlqvyL3TL9vgsw3zd7v3Ptwluo3/holK9AlT3jHqCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjQUJBlETPU8/KAuLrNVa2siL2v91CL8X5gC97A39V0+aeEfyus/DTtCfAFKwMn02xJJkoyVdRKT3WBabZF8KUHIkSHmeCAHsBO95iIvR9riIDjbwELLLAaKsCRGjJXR+3pDatr8JSSk2Ik7DRwibIEbJfziofFDfz85hcua5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZLwVEFS3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8fTQV38eQ/b1Z+Bm25KT7LxD4h3yYabjEAsC+3r8YDI=; b=ZLwVEFS3M5/jYqrIOL6Yq99rQB
	0akAI+2v1xaHe1S+up86XvFi5suS0l8ZcXjTliG5m7Xkn6uHONSKzKeMdggnIy25SX3kM1zl37oLW
	8vua1wdIyK6xYf4VDesY5W+Kow8TEmEMCpsB1CTpoQd8xstPfbSkF1j5rW6xfM2MYvgXRNMvrMb0L
	3f9c2hkImSE+zkWKrgWZgz1evaXuXKCiWNAFmJcNrzzhayIHvJSqDVG4yJdOrGLYCw6lVNTkTi05x
	8R8Z2H3LG2YY+WbBHpU7RIlIqhzdlQ3TdIPAREJsXqTEe9nNjBJxCTzZT5Ec1VXshJhZkxDQURNBY
	7I+yd9Dg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplKi-0000000D7av-1Ep3;
	Thu, 28 Mar 2024 08:42:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] dm: use bio_list_merge_init
Date: Thu, 28 Mar 2024 09:41:46 +0100
Message-Id: <20240328084147.2954434-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
References: <20240328084147.2954434-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use bio_list_merge_init instead of open coding bio_list_merge and
bio_list_init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-bio-prison-v2.c |  3 +--
 drivers/md/dm-cache-target.c  | 12 ++++--------
 drivers/md/dm-clone-target.c  | 14 +++++---------
 drivers/md/dm-era-target.c    |  3 +--
 drivers/md/dm-mpath.c         |  3 +--
 drivers/md/dm-thin.c          | 12 +++---------
 drivers/md/dm-vdo/data-vio.c  |  3 +--
 drivers/md/dm-vdo/flush.c     |  3 +--
 8 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v2.c b/drivers/md/dm-bio-prison-v2.c
index fd852981ef9ccb..cf433b0cf74275 100644
--- a/drivers/md/dm-bio-prison-v2.c
+++ b/drivers/md/dm-bio-prison-v2.c
@@ -321,8 +321,7 @@ static bool __unlock(struct dm_bio_prison_v2 *prison,
 {
 	BUG_ON(!cell->exclusive_lock);
 
-	bio_list_merge(bios, &cell->bios);
-	bio_list_init(&cell->bios);
+	bio_list_merge_init(bios, &cell->bios);
 
 	if (cell->shared_count) {
 		cell->exclusive_lock = false;
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 911f73f7ebbaa0..0fcbf8603846b5 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -115,8 +115,7 @@ static void __commit(struct work_struct *_ws)
 	 */
 	spin_lock_irq(&b->lock);
 	list_splice_init(&b->work_items, &work_items);
-	bio_list_merge(&bios, &b->bios);
-	bio_list_init(&b->bios);
+	bio_list_merge_init(&bios, &b->bios);
 	b->commit_scheduled = false;
 	spin_unlock_irq(&b->lock);
 
@@ -565,8 +564,7 @@ static void defer_bio(struct cache *cache, struct bio *bio)
 static void defer_bios(struct cache *cache, struct bio_list *bios)
 {
 	spin_lock_irq(&cache->lock);
-	bio_list_merge(&cache->deferred_bios, bios);
-	bio_list_init(bios);
+	bio_list_merge_init(&cache->deferred_bios, bios);
 	spin_unlock_irq(&cache->lock);
 
 	wake_deferred_bio_worker(cache);
@@ -1816,8 +1814,7 @@ static void process_deferred_bios(struct work_struct *ws)
 	bio_list_init(&bios);
 
 	spin_lock_irq(&cache->lock);
-	bio_list_merge(&bios, &cache->deferred_bios);
-	bio_list_init(&cache->deferred_bios);
+	bio_list_merge_init(&bios, &cache->deferred_bios);
 	spin_unlock_irq(&cache->lock);
 
 	while ((bio = bio_list_pop(&bios))) {
@@ -1847,8 +1844,7 @@ static void requeue_deferred_bios(struct cache *cache)
 	struct bio_list bios;
 
 	bio_list_init(&bios);
-	bio_list_merge(&bios, &cache->deferred_bios);
-	bio_list_init(&cache->deferred_bios);
+	bio_list_merge_init(&bios, &cache->deferred_bios);
 
 	while ((bio = bio_list_pop(&bios))) {
 		bio->bi_status = BLK_STS_DM_REQUEUE;
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 94b2fc33f64be3..3f68672ab7c938 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -1181,8 +1181,7 @@ static void process_deferred_discards(struct clone *clone)
 	struct bio_list discards = BIO_EMPTY_LIST;
 
 	spin_lock_irq(&clone->lock);
-	bio_list_merge(&discards, &clone->deferred_discard_bios);
-	bio_list_init(&clone->deferred_discard_bios);
+	bio_list_merge_init(&discards, &clone->deferred_discard_bios);
 	spin_unlock_irq(&clone->lock);
 
 	if (bio_list_empty(&discards))
@@ -1215,8 +1214,7 @@ static void process_deferred_bios(struct clone *clone)
 	struct bio_list bios = BIO_EMPTY_LIST;
 
 	spin_lock_irq(&clone->lock);
-	bio_list_merge(&bios, &clone->deferred_bios);
-	bio_list_init(&clone->deferred_bios);
+	bio_list_merge_init(&bios, &clone->deferred_bios);
 	spin_unlock_irq(&clone->lock);
 
 	if (bio_list_empty(&bios))
@@ -1237,11 +1235,9 @@ static void process_deferred_flush_bios(struct clone *clone)
 	 * before issuing them or signaling their completion.
 	 */
 	spin_lock_irq(&clone->lock);
-	bio_list_merge(&bios, &clone->deferred_flush_bios);
-	bio_list_init(&clone->deferred_flush_bios);
-
-	bio_list_merge(&bio_completions, &clone->deferred_flush_completions);
-	bio_list_init(&clone->deferred_flush_completions);
+	bio_list_merge_init(&bios, &clone->deferred_flush_bios);
+	bio_list_merge_init(&bio_completions,
+			    &clone->deferred_flush_completions);
 	spin_unlock_irq(&clone->lock);
 
 	if (bio_list_empty(&bios) && bio_list_empty(&bio_completions) &&
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index 6acfa5bf97a400..8f81e597858d5c 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1272,8 +1272,7 @@ static void process_deferred_bios(struct era *era)
 	bio_list_init(&marked_bios);
 
 	spin_lock(&era->deferred_lock);
-	bio_list_merge(&deferred_bios, &era->deferred_bios);
-	bio_list_init(&era->deferred_bios);
+	bio_list_merge_init(&deferred_bios, &era->deferred_bios);
 	spin_unlock(&era->deferred_lock);
 
 	if (bio_list_empty(&deferred_bios))
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 05d1328d18119c..15b681b901531f 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -704,8 +704,7 @@ static void process_queued_bios(struct work_struct *work)
 		return;
 	}
 
-	bio_list_merge(&bios, &m->queued_bios);
-	bio_list_init(&m->queued_bios);
+	bio_list_merge_init(&bios, &m->queued_bios);
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 4793ad2aa1f7e8..f359984c8ef27e 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -592,12 +592,6 @@ struct dm_thin_endio_hook {
 	struct dm_bio_prison_cell *cell;
 };
 
-static void __merge_bio_list(struct bio_list *bios, struct bio_list *master)
-{
-	bio_list_merge(bios, master);
-	bio_list_init(master);
-}
-
 static void error_bio_list(struct bio_list *bios, blk_status_t error)
 {
 	struct bio *bio;
@@ -616,7 +610,7 @@ static void error_thin_bio_list(struct thin_c *tc, struct bio_list *master,
 	bio_list_init(&bios);
 
 	spin_lock_irq(&tc->lock);
-	__merge_bio_list(&bios, master);
+	bio_list_merge_init(&bios, master);
 	spin_unlock_irq(&tc->lock);
 
 	error_bio_list(&bios, error);
@@ -645,8 +639,8 @@ static void requeue_io(struct thin_c *tc)
 	bio_list_init(&bios);
 
 	spin_lock_irq(&tc->lock);
-	__merge_bio_list(&bios, &tc->deferred_bio_list);
-	__merge_bio_list(&bios, &tc->retry_on_resume_list);
+	bio_list_merge_init(&bios, &tc->deferred_bio_list);
+	bio_list_merge_init(&bios, &tc->retry_on_resume_list);
 	spin_unlock_irq(&tc->lock);
 
 	error_bio_list(&bios, BLK_STS_DM_REQUEUE);
diff --git a/drivers/md/dm-vdo/data-vio.c b/drivers/md/dm-vdo/data-vio.c
index 94f6f1ccfb7d6d..ab3ea833780946 100644
--- a/drivers/md/dm-vdo/data-vio.c
+++ b/drivers/md/dm-vdo/data-vio.c
@@ -604,8 +604,7 @@ static void assign_discard_permit(struct limiter *limiter)
 
 static void get_waiters(struct limiter *limiter)
 {
-	bio_list_merge(&limiter->waiters, &limiter->new_waiters);
-	bio_list_init(&limiter->new_waiters);
+	bio_list_merge_init(&limiter->waiters, &limiter->new_waiters);
 }
 
 static inline struct data_vio *get_available_data_vio(struct data_vio_pool *pool)
diff --git a/drivers/md/dm-vdo/flush.c b/drivers/md/dm-vdo/flush.c
index 57e87f0d706970..dd4fdee2ca0c5a 100644
--- a/drivers/md/dm-vdo/flush.c
+++ b/drivers/md/dm-vdo/flush.c
@@ -369,8 +369,7 @@ void vdo_dump_flusher(const struct flusher *flusher)
 static void initialize_flush(struct vdo_flush *flush, struct vdo *vdo)
 {
 	bio_list_init(&flush->bios);
-	bio_list_merge(&flush->bios, &vdo->flusher->waiting_flush_bios);
-	bio_list_init(&vdo->flusher->waiting_flush_bios);
+	bio_list_merge_init(&flush->bios, &vdo->flusher->waiting_flush_bios);
 }
 
 static void launch_flush(struct vdo_flush *flush)
-- 
2.39.2


