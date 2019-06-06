Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6B371A1
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfFFK0m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 06:26:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFFK0k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 06:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fBbeJ8TX3B2AC21lSwXxghVP00smD74nfHhnKgyXrpU=; b=OHAMgjCF7p0adZ/m1kGXRHxU0h
        BlieU6gWdrBe58hJI6Nuqw5E72a7m7aaLgGx9yA3ZXiS3pDfIxWdtasCNj8RC2ruXCLJI9/kpjRKq
        XWBn74+0eTuKCiM7khCrkoFHFa3V5LQWCk3s3rBjQJ8HEcobkpp3ROyORa/9E3Xcfg/aTWdFTPhy5
        z+ehn8zQNIjFkh4+vrpZvkdlExNc7Xudpxn25oM/ZjmPE5O4wAmJcm7cZW0zYXL7jQrAnKiKauonC
        Gjjb5cOdGLgQ//dE0niKwvtxXQab3GrMhtOvCmpySpjzKXnwPoTgNgE+3ZwZCC4OQ35qIoYPtnzEc
        4AvKz0lQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbT-0007ho-CN; Thu, 06 Jun 2019 10:26:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] blk-cgroup: move struct blkg_stat to bfq
Date:   Thu,  6 Jun 2019 12:26:22 +0200
Message-Id: <20190606102624.3847-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This structure and assorted infrastructure is only used by the bfq I/O
scheduler.  Move it there instead of bloating the common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c         | 192 ++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h        |  19 ++--
 block/blk-cgroup.c         |  56 -----------
 include/linux/blk-cgroup.h |  71 --------------
 4 files changed, 167 insertions(+), 171 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 624374a99c6e..a691dca7e966 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -17,6 +17,124 @@
 
 #if defined(CONFIG_BFQ_GROUP_IOSCHED) &&  defined(CONFIG_DEBUG_BLK_CGROUP)
 
+static int bfq_stat_init(struct bfq_stat *stat, gfp_t gfp)
+{
+	int ret;
+
+	ret = percpu_counter_init(&stat->cpu_cnt, 0, gfp);
+	if (ret)
+		return ret;
+
+	atomic64_set(&stat->aux_cnt, 0);
+	return 0;
+}
+
+static void bfq_stat_exit(struct bfq_stat *stat)
+{
+	percpu_counter_destroy(&stat->cpu_cnt);
+}
+
+/**
+ * bfq_stat_add - add a value to a bfq_stat
+ * @stat: target bfq_stat
+ * @val: value to add
+ *
+ * Add @val to @stat.  The caller must ensure that IRQ on the same CPU
+ * don't re-enter this function for the same counter.
+ */
+static inline void bfq_stat_add(struct bfq_stat *stat, uint64_t val)
+{
+	percpu_counter_add_batch(&stat->cpu_cnt, val, BLKG_STAT_CPU_BATCH);
+}
+
+/**
+ * bfq_stat_read - read the current value of a bfq_stat
+ * @stat: bfq_stat to read
+ */
+static inline uint64_t bfq_stat_read(struct bfq_stat *stat)
+{
+	return percpu_counter_sum_positive(&stat->cpu_cnt);
+}
+
+/**
+ * bfq_stat_reset - reset a bfq_stat
+ * @stat: bfq_stat to reset
+ */
+static inline void bfq_stat_reset(struct bfq_stat *stat)
+{
+	percpu_counter_set(&stat->cpu_cnt, 0);
+	atomic64_set(&stat->aux_cnt, 0);
+}
+
+/**
+ * bfq_stat_add_aux - add a bfq_stat into another's aux count
+ * @to: the destination bfq_stat
+ * @from: the source
+ *
+ * Add @from's count including the aux one to @to's aux count.
+ */
+static inline void bfq_stat_add_aux(struct bfq_stat *to,
+				     struct bfq_stat *from)
+{
+	atomic64_add(bfq_stat_read(from) + atomic64_read(&from->aux_cnt),
+		     &to->aux_cnt);
+}
+
+/**
+ * bfq_stat_recursive_sum - collect hierarchical bfq_stat
+ * @blkg: blkg of interest
+ * @pol: blkcg_policy which contains the bfq_stat
+ * @off: offset to the bfq_stat in blkg_policy_data or @blkg
+ *
+ * Collect the bfq_stat specified by @blkg, @pol and @off and all its
+ * online descendants and their aux counts.  The caller must be holding the
+ * queue lock for online tests.
+ *
+ * If @pol is NULL, bfq_stat is at @off bytes into @blkg; otherwise, it is
+ * at @off bytes into @blkg's blkg_policy_data of the policy.
+ */
+static u64 bfq_stat_recursive_sum(struct blkcg_gq *blkg,
+			    struct blkcg_policy *pol, int off)
+{
+	struct blkcg_gq *pos_blkg;
+	struct cgroup_subsys_state *pos_css;
+	u64 sum = 0;
+
+	lockdep_assert_held(&blkg->q->queue_lock);
+
+	rcu_read_lock();
+	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
+		struct bfq_stat *stat;
+
+		if (!pos_blkg->online)
+			continue;
+
+		if (pol)
+			stat = (void *)blkg_to_pd(pos_blkg, pol) + off;
+		else
+			stat = (void *)blkg + off;
+
+		sum += bfq_stat_read(stat) + atomic64_read(&stat->aux_cnt);
+	}
+	rcu_read_unlock();
+
+	return sum;
+}
+
+/**
+ * blkg_prfill_stat - prfill callback for bfq_stat
+ * @sf: seq_file to print to
+ * @pd: policy private data of interest
+ * @off: offset to the bfq_stat in @pd
+ *
+ * prfill callback for printing a bfq_stat.
+ */
+static u64 blkg_prfill_stat(struct seq_file *sf, struct blkg_policy_data *pd,
+		int off)
+{
+	return __blkg_prfill_u64(sf, pd, bfq_stat_read((void *)pd + off));
+}
+
 /* bfqg stats flags */
 enum bfqg_stats_flags {
 	BFQG_stats_waiting = 0,
@@ -53,7 +171,7 @@ static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
 
 	now = ktime_get_ns();
 	if (now > stats->start_group_wait_time)
-		blkg_stat_add(&stats->group_wait_time,
+		bfq_stat_add(&stats->group_wait_time,
 			      now - stats->start_group_wait_time);
 	bfqg_stats_clear_waiting(stats);
 }
@@ -82,14 +200,14 @@ static void bfqg_stats_end_empty_time(struct bfqg_stats *stats)
 
 	now = ktime_get_ns();
 	if (now > stats->start_empty_time)
-		blkg_stat_add(&stats->empty_time,
+		bfq_stat_add(&stats->empty_time,
 			      now - stats->start_empty_time);
 	bfqg_stats_clear_empty(stats);
 }
 
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg)
 {
-	blkg_stat_add(&bfqg->stats.dequeue, 1);
+	bfq_stat_add(&bfqg->stats.dequeue, 1);
 }
 
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
@@ -119,7 +237,7 @@ void bfqg_stats_update_idle_time(struct bfq_group *bfqg)
 		u64 now = ktime_get_ns();
 
 		if (now > stats->start_idle_time)
-			blkg_stat_add(&stats->idle_time,
+			bfq_stat_add(&stats->idle_time,
 				      now - stats->start_idle_time);
 		bfqg_stats_clear_idling(stats);
 	}
@@ -137,9 +255,9 @@ void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
 
-	blkg_stat_add(&stats->avg_queue_size_sum,
+	bfq_stat_add(&stats->avg_queue_size_sum,
 		      blkg_rwstat_total(&stats->queued));
-	blkg_stat_add(&stats->avg_queue_size_samples, 1);
+	bfq_stat_add(&stats->avg_queue_size_samples, 1);
 	bfqg_stats_update_group_wait_time(stats);
 }
 
@@ -279,13 +397,13 @@ static void bfqg_stats_reset(struct bfqg_stats *stats)
 	blkg_rwstat_reset(&stats->merged);
 	blkg_rwstat_reset(&stats->service_time);
 	blkg_rwstat_reset(&stats->wait_time);
-	blkg_stat_reset(&stats->time);
-	blkg_stat_reset(&stats->avg_queue_size_sum);
-	blkg_stat_reset(&stats->avg_queue_size_samples);
-	blkg_stat_reset(&stats->dequeue);
-	blkg_stat_reset(&stats->group_wait_time);
-	blkg_stat_reset(&stats->idle_time);
-	blkg_stat_reset(&stats->empty_time);
+	bfq_stat_reset(&stats->time);
+	bfq_stat_reset(&stats->avg_queue_size_sum);
+	bfq_stat_reset(&stats->avg_queue_size_samples);
+	bfq_stat_reset(&stats->dequeue);
+	bfq_stat_reset(&stats->group_wait_time);
+	bfq_stat_reset(&stats->idle_time);
+	bfq_stat_reset(&stats->empty_time);
 #endif
 }
 
@@ -300,14 +418,14 @@ static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
 	blkg_rwstat_add_aux(&to->merged, &from->merged);
 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
 	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
-	blkg_stat_add_aux(&from->time, &from->time);
-	blkg_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
-	blkg_stat_add_aux(&to->avg_queue_size_samples,
+	bfq_stat_add_aux(&from->time, &from->time);
+	bfq_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
+	bfq_stat_add_aux(&to->avg_queue_size_samples,
 			  &from->avg_queue_size_samples);
-	blkg_stat_add_aux(&to->dequeue, &from->dequeue);
-	blkg_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
-	blkg_stat_add_aux(&to->idle_time, &from->idle_time);
-	blkg_stat_add_aux(&to->empty_time, &from->empty_time);
+	bfq_stat_add_aux(&to->dequeue, &from->dequeue);
+	bfq_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
+	bfq_stat_add_aux(&to->idle_time, &from->idle_time);
+	bfq_stat_add_aux(&to->empty_time, &from->empty_time);
 #endif
 }
 
@@ -360,13 +478,13 @@ static void bfqg_stats_exit(struct bfqg_stats *stats)
 	blkg_rwstat_exit(&stats->service_time);
 	blkg_rwstat_exit(&stats->wait_time);
 	blkg_rwstat_exit(&stats->queued);
-	blkg_stat_exit(&stats->time);
-	blkg_stat_exit(&stats->avg_queue_size_sum);
-	blkg_stat_exit(&stats->avg_queue_size_samples);
-	blkg_stat_exit(&stats->dequeue);
-	blkg_stat_exit(&stats->group_wait_time);
-	blkg_stat_exit(&stats->idle_time);
-	blkg_stat_exit(&stats->empty_time);
+	bfq_stat_exit(&stats->time);
+	bfq_stat_exit(&stats->avg_queue_size_sum);
+	bfq_stat_exit(&stats->avg_queue_size_samples);
+	bfq_stat_exit(&stats->dequeue);
+	bfq_stat_exit(&stats->group_wait_time);
+	bfq_stat_exit(&stats->idle_time);
+	bfq_stat_exit(&stats->empty_time);
 #endif
 }
 
@@ -377,13 +495,13 @@ static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
 	    blkg_rwstat_init(&stats->service_time, gfp) ||
 	    blkg_rwstat_init(&stats->wait_time, gfp) ||
 	    blkg_rwstat_init(&stats->queued, gfp) ||
-	    blkg_stat_init(&stats->time, gfp) ||
-	    blkg_stat_init(&stats->avg_queue_size_sum, gfp) ||
-	    blkg_stat_init(&stats->avg_queue_size_samples, gfp) ||
-	    blkg_stat_init(&stats->dequeue, gfp) ||
-	    blkg_stat_init(&stats->group_wait_time, gfp) ||
-	    blkg_stat_init(&stats->idle_time, gfp) ||
-	    blkg_stat_init(&stats->empty_time, gfp)) {
+	    bfq_stat_init(&stats->time, gfp) ||
+	    bfq_stat_init(&stats->avg_queue_size_sum, gfp) ||
+	    bfq_stat_init(&stats->avg_queue_size_samples, gfp) ||
+	    bfq_stat_init(&stats->dequeue, gfp) ||
+	    bfq_stat_init(&stats->group_wait_time, gfp) ||
+	    bfq_stat_init(&stats->idle_time, gfp) ||
+	    bfq_stat_init(&stats->empty_time, gfp)) {
 		bfqg_stats_exit(stats);
 		return -ENOMEM;
 	}
@@ -927,7 +1045,7 @@ static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 				      struct blkg_policy_data *pd, int off)
 {
-	u64 sum = blkg_stat_recursive_sum(pd_to_blkg(pd),
+	u64 sum = bfq_stat_recursive_sum(pd_to_blkg(pd),
 					  &blkcg_policy_bfq, off);
 	return __blkg_prfill_u64(sf, pd, sum);
 }
@@ -996,11 +1114,11 @@ static u64 bfqg_prfill_avg_queue_size(struct seq_file *sf,
 				      struct blkg_policy_data *pd, int off)
 {
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
-	u64 samples = blkg_stat_read(&bfqg->stats.avg_queue_size_samples);
+	u64 samples = bfq_stat_read(&bfqg->stats.avg_queue_size_samples);
 	u64 v = 0;
 
 	if (samples) {
-		v = blkg_stat_read(&bfqg->stats.avg_queue_size_sum);
+		v = bfq_stat_read(&bfqg->stats.avg_queue_size_sum);
 		v = div64_u64(v, samples);
 	}
 	__blkg_prfill_u64(sf, pd, v);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index c2faa77824f8..aef4fa0046b8 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -777,6 +777,11 @@ enum bfqq_expiration {
 	BFQQE_PREEMPTED		/* preemption in progress */
 };
 
+struct bfq_stat {
+	struct percpu_counter		cpu_cnt;
+	atomic64_t			aux_cnt;
+};
+
 struct bfqg_stats {
 #if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
 	/* number of ios merged */
@@ -788,19 +793,19 @@ struct bfqg_stats {
 	/* number of IOs queued up */
 	struct blkg_rwstat		queued;
 	/* total disk time and nr sectors dispatched by this group */
-	struct blkg_stat		time;
+	struct bfq_stat		time;
 	/* sum of number of ios queued across all samples */
-	struct blkg_stat		avg_queue_size_sum;
+	struct bfq_stat		avg_queue_size_sum;
 	/* count of samples taken for average */
-	struct blkg_stat		avg_queue_size_samples;
+	struct bfq_stat		avg_queue_size_samples;
 	/* how many times this group has been removed from service tree */
-	struct blkg_stat		dequeue;
+	struct bfq_stat		dequeue;
 	/* total time spent waiting for it to be assigned a timeslice. */
-	struct blkg_stat		group_wait_time;
+	struct bfq_stat		group_wait_time;
 	/* time spent idling for this blkcg_gq */
-	struct blkg_stat		idle_time;
+	struct bfq_stat		idle_time;
 	/* total time with empty current active q with other requests queued */
-	struct blkg_stat		empty_time;
+	struct bfq_stat		empty_time;
 	/* fields after this shouldn't be cleared on stat reset */
 	u64				start_group_wait_time;
 	u64				start_idle_time;
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index aad0f5d9a2ea..1aa5c64675d6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -577,20 +577,6 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 }
 EXPORT_SYMBOL_GPL(__blkg_prfill_rwstat);
 
-/**
- * blkg_prfill_stat - prfill callback for blkg_stat
- * @sf: seq_file to print to
- * @pd: policy private data of interest
- * @off: offset to the blkg_stat in @pd
- *
- * prfill callback for printing a blkg_stat.
- */
-u64 blkg_prfill_stat(struct seq_file *sf, struct blkg_policy_data *pd, int off)
-{
-	return __blkg_prfill_u64(sf, pd, blkg_stat_read((void *)pd + off));
-}
-EXPORT_SYMBOL_GPL(blkg_prfill_stat);
-
 /**
  * blkg_prfill_rwstat - prfill callback for blkg_rwstat
  * @sf: seq_file to print to
@@ -692,48 +678,6 @@ int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v)
 }
 EXPORT_SYMBOL_GPL(blkg_print_stat_ios_recursive);
 
-/**
- * blkg_stat_recursive_sum - collect hierarchical blkg_stat
- * @blkg: blkg of interest
- * @pol: blkcg_policy which contains the blkg_stat
- * @off: offset to the blkg_stat in blkg_policy_data or @blkg
- *
- * Collect the blkg_stat specified by @blkg, @pol and @off and all its
- * online descendants and their aux counts.  The caller must be holding the
- * queue lock for online tests.
- *
- * If @pol is NULL, blkg_stat is at @off bytes into @blkg; otherwise, it is
- * at @off bytes into @blkg's blkg_policy_data of the policy.
- */
-u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
-			    struct blkcg_policy *pol, int off)
-{
-	struct blkcg_gq *pos_blkg;
-	struct cgroup_subsys_state *pos_css;
-	u64 sum = 0;
-
-	lockdep_assert_held(&blkg->q->queue_lock);
-
-	rcu_read_lock();
-	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
-		struct blkg_stat *stat;
-
-		if (!pos_blkg->online)
-			continue;
-
-		if (pol)
-			stat = (void *)blkg_to_pd(pos_blkg, pol) + off;
-		else
-			stat = (void *)blkg + off;
-
-		sum += blkg_stat_read(stat) + atomic64_read(&stat->aux_cnt);
-	}
-	rcu_read_unlock();
-
-	return sum;
-}
-EXPORT_SYMBOL_GPL(blkg_stat_recursive_sum);
-
 /**
  * blkg_rwstat_recursive_sum - collect hierarchical blkg_rwstat
  * @blkg: blkg of interest
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e4a81767e111..33f23a858438 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -65,11 +65,6 @@ struct blkcg {
  * blkg_[rw]stat->aux_cnt is excluded for local stats but included for
  * recursive.  Used to carry stats of dead children.
  */
-struct blkg_stat {
-	struct percpu_counter		cpu_cnt;
-	atomic64_t			aux_cnt;
-};
-
 struct blkg_rwstat {
 	struct percpu_counter		cpu_cnt[BLKG_RWSTAT_NR];
 	atomic64_t			aux_cnt[BLKG_RWSTAT_NR];
@@ -217,7 +212,6 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
 u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			 const struct blkg_rwstat_sample *rwstat);
-u64 blkg_prfill_stat(struct seq_file *sf, struct blkg_policy_data *pd, int off);
 u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		       int off);
 int blkg_print_stat_bytes(struct seq_file *sf, void *v);
@@ -225,8 +219,6 @@ int blkg_print_stat_ios(struct seq_file *sf, void *v);
 int blkg_print_stat_bytes_recursive(struct seq_file *sf, void *v);
 int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v);
 
-u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
-			    struct blkcg_policy *pol, int off);
 void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 		int off, struct blkg_rwstat_sample *sum);
 
@@ -579,69 +571,6 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
 					      (p_blkg)->q, false)))
 
-static inline int blkg_stat_init(struct blkg_stat *stat, gfp_t gfp)
-{
-	int ret;
-
-	ret = percpu_counter_init(&stat->cpu_cnt, 0, gfp);
-	if (ret)
-		return ret;
-
-	atomic64_set(&stat->aux_cnt, 0);
-	return 0;
-}
-
-static inline void blkg_stat_exit(struct blkg_stat *stat)
-{
-	percpu_counter_destroy(&stat->cpu_cnt);
-}
-
-/**
- * blkg_stat_add - add a value to a blkg_stat
- * @stat: target blkg_stat
- * @val: value to add
- *
- * Add @val to @stat.  The caller must ensure that IRQ on the same CPU
- * don't re-enter this function for the same counter.
- */
-static inline void blkg_stat_add(struct blkg_stat *stat, uint64_t val)
-{
-	percpu_counter_add_batch(&stat->cpu_cnt, val, BLKG_STAT_CPU_BATCH);
-}
-
-/**
- * blkg_stat_read - read the current value of a blkg_stat
- * @stat: blkg_stat to read
- */
-static inline uint64_t blkg_stat_read(struct blkg_stat *stat)
-{
-	return percpu_counter_sum_positive(&stat->cpu_cnt);
-}
-
-/**
- * blkg_stat_reset - reset a blkg_stat
- * @stat: blkg_stat to reset
- */
-static inline void blkg_stat_reset(struct blkg_stat *stat)
-{
-	percpu_counter_set(&stat->cpu_cnt, 0);
-	atomic64_set(&stat->aux_cnt, 0);
-}
-
-/**
- * blkg_stat_add_aux - add a blkg_stat into another's aux count
- * @to: the destination blkg_stat
- * @from: the source
- *
- * Add @from's count including the aux one to @to's aux count.
- */
-static inline void blkg_stat_add_aux(struct blkg_stat *to,
-				     struct blkg_stat *from)
-{
-	atomic64_add(blkg_stat_read(from) + atomic64_read(&from->aux_cnt),
-		     &to->aux_cnt);
-}
-
 static inline int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp)
 {
 	int i, ret;
-- 
2.20.1

