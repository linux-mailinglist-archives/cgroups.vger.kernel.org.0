Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5851E50800F
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355302AbiDTEas (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiDTEan (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF512DE0;
        Tue, 19 Apr 2022 21:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RTBsVzJBND1nqetjFQqCsdv2l0GyA0YbgdeKMwUD0x4=; b=K+PSnuBV0LeiX2kIUJegUp0sx7
        ujFb1kPnDIwVz1CKzZby0GFw0SjFbFK7VGl2PtQSq2V72oQDTrEbL+Nj9SCWYkwvM5HUMuL6jqKGH
        8yy4hPHM/EkLRIuF6YOlS+HDwC5FB72ZOFDk+6H88tMg+M7dOx8oe81ImYzxx6MlhiYARaAg63X9N
        cLHs02gMH60Ob79m782JQrwtiFNwzuOQ6ENAVjW+bkl7Ng9Vsm2rfiIGwE16YIJRc1L4NKi8uoFkd
        7+F6tC/nEL3wPT6UzU5+yv3k6MRp5QxiJftI8r/w51wB326/jg+VUbm3pcqyHkLqKYu/K0MEsnsTy
        6oMVQgnA==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wZ-007FSI-Iq; Wed, 20 Apr 2022 04:27:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 09/15] blk-cgroup: replace bio_blkcg with bio_blkcg_css
Date:   Wed, 20 Apr 2022 06:27:17 +0200
Message-Id: <20220420042723.1010598-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

All callers of bio_blkcg actually want the CSS, so replace it with an
interface that does return the CSS.  This now allows to move
struct blkcg_gq to block/blk-cgroup.h instead of exposing it in a
public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 18 ++++++++-
 block/blk-cgroup.h         | 67 ++++++++++++++++++++++++++++--
 drivers/block/loop.c       | 12 +++---
 include/linux/blk-cgroup.h | 83 +++-----------------------------------
 kernel/trace/blktrace.c    |  6 ++-
 5 files changed, 97 insertions(+), 89 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bb52797c02bd7..8e32cc494808d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -155,6 +155,22 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 		blk_finish_plug(&plug);
 }
 
+/**
+ * bio_blkcg_css - return the blkcg CSS associated with a bio
+ * @bio: target bio
+ *
+ * This returns the CSS for the blkcg associated with a bio, or %NULL if not
+ * associated. Callers are expected to either handle %NULL or know association
+ * has been done prior to calling this.
+ */
+struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
+{
+	if (!bio || !bio->bi_blkg)
+		return NULL;
+	return &bio->bi_blkg->blkcg->css;
+}
+EXPORT_SYMBOL_GPL(bio_blkcg_css);
+
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
@@ -1938,7 +1954,7 @@ void bio_associate_blkg(struct bio *bio)
 	rcu_read_lock();
 
 	if (bio->bi_blkg)
-		css = &bio_blkcg(bio)->css;
+		css = bio_blkcg_css(bio);
 	else
 		css = blkcg_css();
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index b00fb1169e7ce..03405ddf2a7ba 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -25,6 +25,64 @@ struct blkg_policy_data;
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
 
 #ifdef CONFIG_BLK_CGROUP
+
+enum blkg_iostat_type {
+	BLKG_IOSTAT_READ,
+	BLKG_IOSTAT_WRITE,
+	BLKG_IOSTAT_DISCARD,
+
+	BLKG_IOSTAT_NR,
+};
+
+struct blkg_iostat {
+	u64				bytes[BLKG_IOSTAT_NR];
+	u64				ios[BLKG_IOSTAT_NR];
+};
+
+struct blkg_iostat_set {
+	struct u64_stats_sync		sync;
+	struct blkg_iostat		cur;
+	struct blkg_iostat		last;
+};
+
+/* association between a blk cgroup and a request queue */
+struct blkcg_gq {
+	/* Pointer to the associated request_queue */
+	struct request_queue		*q;
+	struct list_head		q_node;
+	struct hlist_node		blkcg_node;
+	struct blkcg			*blkcg;
+
+	/* all non-root blkcg_gq's are guaranteed to have access to parent */
+	struct blkcg_gq			*parent;
+
+	/* reference count */
+	struct percpu_ref		refcnt;
+
+	/* is this blkg online? protected by both blkcg and q locks */
+	bool				online;
+
+	struct blkg_iostat_set __percpu	*iostat_cpu;
+	struct blkg_iostat_set		iostat;
+
+	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
+
+	spinlock_t			async_bio_lock;
+	struct bio_list			async_bios;
+	union {
+		struct work_struct	async_bio_work;
+		struct work_struct	free_work;
+	};
+
+	atomic_t			use_delay;
+	atomic64_t			delay_nsec;
+	atomic64_t			delay_start;
+	u64				last_delay;
+	int				last_use;
+
+	struct rcu_head			rcu_head;
+};
+
 struct blkcg {
 	struct cgroup_subsys_state	css;
 	spinlock_t			lock;
@@ -173,9 +231,9 @@ static inline struct cgroup_subsys_state *blkcg_css(void)
  *
  * In order to avoid priority inversions we sometimes need to issue a bio as if
  * it were attached to the root blkg, and then backcharge to the actual owning
- * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
- * bio and attach the appropriate blkg to the bio.  Then we call this helper and
- * if it is true run with the root blkg for that queue and then do any
+ * blkg.  The idea is we do bio_blkcg_css() to look up the actual context for
+ * the bio and attach the appropriate blkg to the bio.  Then we call this helper
+ * and if it is true run with the root blkg for that queue and then do any
  * backcharging to the originating cgroup once the io is complete.
  */
 static inline bool bio_issue_as_root_blkg(struct bio *bio)
@@ -464,6 +522,9 @@ struct blkcg_policy_data {
 struct blkcg_policy {
 };
 
+struct blkcg {
+};
+
 #ifdef CONFIG_BLOCK
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 976cf987b3920..fabcf647306af 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1829,12 +1829,14 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->blkcg_css = NULL;
 	cmd->memcg_css = NULL;
 #ifdef CONFIG_BLK_CGROUP
-	if (rq->bio && rq->bio->bi_blkg) {
-		cmd->blkcg_css = &bio_blkcg(rq->bio)->css;
+	if (rq->bio) {
+		cmd->blkcg_css = bio_blkcg_css(rq->bio);
 #ifdef CONFIG_MEMCG
-		cmd->memcg_css =
-			cgroup_get_e_css(cmd->blkcg_css->cgroup,
-					&memory_cgrp_subsys);
+		if (cmd->blkcg_css) {
+			cmd->memcg_css =
+				cgroup_get_e_css(cmd->blkcg_css->cgroup,
+						&memory_cgrp_subsys);
+		}
 #endif
 	}
 #endif
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index d7b1880950402..97c7968e32040 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -28,94 +28,18 @@
 #define FC_APPID_LEN              129
 
 #ifdef CONFIG_BLK_CGROUP
-
-enum blkg_iostat_type {
-	BLKG_IOSTAT_READ,
-	BLKG_IOSTAT_WRITE,
-	BLKG_IOSTAT_DISCARD,
-
-	BLKG_IOSTAT_NR,
-};
-
-struct blkg_iostat {
-	u64				bytes[BLKG_IOSTAT_NR];
-	u64				ios[BLKG_IOSTAT_NR];
-};
-
-struct blkg_iostat_set {
-	struct u64_stats_sync		sync;
-	struct blkg_iostat		cur;
-	struct blkg_iostat		last;
-};
-
-/* association between a blk cgroup and a request queue */
-struct blkcg_gq {
-	/* Pointer to the associated request_queue */
-	struct request_queue		*q;
-	struct list_head		q_node;
-	struct hlist_node		blkcg_node;
-	struct blkcg			*blkcg;
-
-	/* all non-root blkcg_gq's are guaranteed to have access to parent */
-	struct blkcg_gq			*parent;
-
-	/* reference count */
-	struct percpu_ref		refcnt;
-
-	/* is this blkg online? protected by both blkcg and q locks */
-	bool				online;
-
-	struct blkg_iostat_set __percpu	*iostat_cpu;
-	struct blkg_iostat_set		iostat;
-
-	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
-
-	spinlock_t			async_bio_lock;
-	struct bio_list			async_bios;
-	union {
-		struct work_struct	async_bio_work;
-		struct work_struct	free_work;
-	};
-
-	atomic_t			use_delay;
-	atomic64_t			delay_nsec;
-	atomic64_t			delay_start;
-	u64				last_delay;
-	int				last_use;
-
-	struct rcu_head			rcu_head;
-};
-
 extern struct cgroup_subsys_state * const blkcg_root_css;
 
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
-
-/**
- * bio_blkcg - grab the blkcg associated with a bio
- * @bio: target bio
- *
- * This returns the blkcg associated with a bio, %NULL if not associated.
- * Callers are expected to either handle %NULL or know association has been
- * done prior to calling this.
- */
-static inline struct blkcg *bio_blkcg(struct bio *bio)
-{
-	if (bio && bio->bi_blkg)
-		return bio->bi_blkg->blkcg;
-	return NULL;
-}
-
 bool blk_cgroup_congested(void);
 void blkcg_pin_online(struct cgroup_subsys_state *blkcg_css);
 void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css);
 struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio);
 
 #else	/* CONFIG_BLK_CGROUP */
 
-struct blkcg_gq {
-};
-
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
 
 static inline void blkcg_maybe_throttle_current(void) { }
@@ -123,7 +47,10 @@ static inline bool blk_cgroup_congested(void) { return false; }
 
 #ifdef CONFIG_BLOCK
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
-static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
+static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
+{
+	return NULL;
+}
 #endif /* CONFIG_BLOCK */
 
 #endif	/* CONFIG_BLK_CGROUP */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 9ef349ac49c01..10a32b0f2deb6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -783,6 +783,7 @@ void blk_trace_shutdown(struct request_queue *q)
 #ifdef CONFIG_BLK_CGROUP
 static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 {
+	struct cgroup_subsys_state *blkcg_css;
 	struct blk_trace *bt;
 
 	/* We don't use the 'bt' value here except as an optimization... */
@@ -790,9 +791,10 @@ static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
 		return 0;
 
-	if (!bio->bi_blkg)
+	blkcg_css = bio_blkcg_css(bio);
+	if (!blkcg_css)
 		return 0;
-	return cgroup_id(bio_blkcg(bio)->css.cgroup);
+	return cgroup_id(blkcg_css->cgroup);
 }
 #else
 static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
-- 
2.30.2

