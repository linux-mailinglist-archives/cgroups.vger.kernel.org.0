Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAD3719E
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfFFK0i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 06:26:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFFK0h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 06:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+sYPZBeRhiiPR5TRnk5jW3BjnslccP2KlO65GxHb92E=; b=K7YLziFUxdI4VEpmgCeKmJPSIx
        SmV2eiB6eg2ThrkdcxWsA1EJ8OOD/X5sg3Y4VCEC0Go/8ZSnBC9OP9V34d0itJJjvUNwI6hrabX6L
        m2A7shwXcZ/4PINojuI0gLH+p9n70AFP6tBHRK0UmS4ECacpHRB02FZNxMQT/ThYqDzyzVUfBk904
        ySzoeymaP0c1HdAFbWr/TV5iqw1dVEidw0AbTc+cJ+telg8dm0e5cy4+c0zEx5GHXs33+RJdUVVDq
        r+nNZXAbjXqixI8rBrBQ0y/+0WD008iGuHW2ChF+JEEbE4MStCrdVkPTPeKVe6VIyuTS3EELlJbht
        OL8JQ9xw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbQ-0007hZ-Dh; Thu, 06 Jun 2019 10:26:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] blk-cgroup: introduce a new struct blkg_rwstat_sample
Date:   Thu,  6 Jun 2019 12:26:21 +0200
Message-Id: <20190606102624.3847-4-hch@lst.de>
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

When sampling the blkcg counts we don't need atomics or per-cpu
variables.  Introduce a new structure just containing plain u64
counters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c         | 10 ++++------
 block/blk-cgroup.c         | 39 +++++++++++++++++++-------------------
 include/linux/blk-cgroup.h | 22 +++++++++++----------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 66abc82179f3..624374a99c6e 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -935,7 +935,7 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
 					struct blkg_policy_data *pd, int off)
 {
-	struct blkg_rwstat sum;
+	struct blkg_rwstat_sample sum;
 
 	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_bfq, off, &sum);
 	return __blkg_prfill_rwstat(sf, pd, &sum);
@@ -975,15 +975,13 @@ static int bfqg_print_stat_sectors(struct seq_file *sf, void *v)
 static u64 bfqg_prfill_sectors_recursive(struct seq_file *sf,
 					 struct blkg_policy_data *pd, int off)
 {
-	struct blkg_rwstat tmp;
-	u64 sum;
+	struct blkg_rwstat_sample tmp;
 
 	blkg_rwstat_recursive_sum(pd->blkg, NULL,
 			offsetof(struct blkcg_gq, stat_bytes), &tmp);
-	sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
 
-	return __blkg_prfill_u64(sf, pd, sum >> 9);
+	return __blkg_prfill_u64(sf, pd,
+		(tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE]) >> 9);
 }
 
 static int bfqg_print_stat_sectors_recursive(struct seq_file *sf, void *v)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7d6bf9b03e24..aad0f5d9a2ea 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -549,7 +549,7 @@ EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
  * Print @rwstat to @sf for the device assocaited with @pd.
  */
 u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
-			 const struct blkg_rwstat *rwstat)
+			 const struct blkg_rwstat_sample *rwstat)
 {
 	static const char *rwstr[] = {
 		[BLKG_RWSTAT_READ]	= "Read",
@@ -567,12 +567,12 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 
 	for (i = 0; i < BLKG_RWSTAT_NR; i++)
 		seq_printf(sf, "%s %s %llu\n", dname, rwstr[i],
-			   (unsigned long long)atomic64_read(&rwstat->aux_cnt[i]));
+			   rwstat->cnt[i]);
 
-	v = atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_WRITE]) +
-		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_DISCARD]);
-	seq_printf(sf, "%s Total %llu\n", dname, (unsigned long long)v);
+	v = rwstat->cnt[BLKG_RWSTAT_READ] +
+		rwstat->cnt[BLKG_RWSTAT_WRITE] +
+		rwstat->cnt[BLKG_RWSTAT_DISCARD];
+	seq_printf(sf, "%s Total %llu\n", dname, v);
 	return v;
 }
 EXPORT_SYMBOL_GPL(__blkg_prfill_rwstat);
@@ -602,7 +602,7 @@ EXPORT_SYMBOL_GPL(blkg_prfill_stat);
 u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		       int off)
 {
-	struct blkg_rwstat rwstat = { };
+	struct blkg_rwstat_sample rwstat = { };
 
 	blkg_rwstat_read((void *)pd + off, &rwstat);
 	return __blkg_prfill_rwstat(sf, pd, &rwstat);
@@ -612,7 +612,7 @@ EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
 static u64 blkg_prfill_rwstat_field(struct seq_file *sf,
 				    struct blkg_policy_data *pd, int off)
 {
-	struct blkg_rwstat rwstat = { };
+	struct blkg_rwstat_sample rwstat = { };
 
 	blkg_rwstat_read((void *)pd->blkg + off, &rwstat);
 	return __blkg_prfill_rwstat(sf, pd, &rwstat);
@@ -656,7 +656,7 @@ static u64 blkg_prfill_rwstat_field_recursive(struct seq_file *sf,
 					      struct blkg_policy_data *pd,
 					      int off)
 {
-	struct blkg_rwstat rwstat;
+	struct blkg_rwstat_sample rwstat;
 
 	blkg_rwstat_recursive_sum(pd->blkg, NULL, off, &rwstat);
 	return __blkg_prfill_rwstat(sf, pd, &rwstat);
@@ -739,7 +739,7 @@ EXPORT_SYMBOL_GPL(blkg_stat_recursive_sum);
  * @blkg: blkg of interest
  * @pol: blkcg_policy which contains the blkg_rwstat
  * @off: offset to the blkg_rwstat in blkg_policy_data or @blkg
- * @sum: blkg_rwstat structure containing the results
+ * @sum: blkg_rwstat_sample structure containing the results
  *
  * Collect the blkg_rwstat specified by @blkg, @pol and @off and all its
  * online descendants and their aux counts.  The caller must be holding the
@@ -749,7 +749,7 @@ EXPORT_SYMBOL_GPL(blkg_stat_recursive_sum);
  * is at @off bytes into @blkg's blkg_policy_data of the policy.
  */
 void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
-		int off, struct blkg_rwstat *sum)
+		int off, struct blkg_rwstat_sample *sum)
 {
 	struct blkcg_gq *pos_blkg;
 	struct cgroup_subsys_state *pos_css;
@@ -770,8 +770,7 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 			rwstat = (void *)pos_blkg + off;
 
 		for (i = 0; i < BLKG_RWSTAT_NR; i++)
-			atomic64_set(&sum->aux_cnt[i],
-				blkg_rwstat_read_counter(rwstat, i));
+			sum->cnt[i] = blkg_rwstat_read_counter(rwstat, i);
 	}
 	rcu_read_unlock();
 }
@@ -939,7 +938,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		const char *dname;
 		char *buf;
-		struct blkg_rwstat rwstat;
+		struct blkg_rwstat_sample rwstat;
 		u64 rbytes, wbytes, rios, wios, dbytes, dios;
 		size_t size = seq_get_buf(sf, &buf), off = 0;
 		int i;
@@ -961,15 +960,15 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 		blkg_rwstat_recursive_sum(blkg, NULL,
 				offsetof(struct blkcg_gq, stat_bytes), &rwstat);
-		rbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
-		wbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
-		dbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
+		rbytes = rwstat.cnt[BLKG_RWSTAT_READ];
+		wbytes = rwstat.cnt[BLKG_RWSTAT_WRITE];
+		dbytes = rwstat.cnt[BLKG_RWSTAT_DISCARD];
 
 		blkg_rwstat_recursive_sum(blkg, NULL,
 					offsetof(struct blkcg_gq, stat_ios), &rwstat);
-		rios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
-		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
-		dios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
+		rios = rwstat.cnt[BLKG_RWSTAT_READ];
+		wios = rwstat.cnt[BLKG_RWSTAT_WRITE];
+		dios = rwstat.cnt[BLKG_RWSTAT_DISCARD];
 
 		spin_unlock_irq(&blkg->q->queue_lock);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3ee858111274..e4a81767e111 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -63,8 +63,7 @@ struct blkcg {
 
 /*
  * blkg_[rw]stat->aux_cnt is excluded for local stats but included for
- * recursive.  Used to carry stats of dead children, and, for blkg_rwstat,
- * to carry result values from read and sum operations.
+ * recursive.  Used to carry stats of dead children.
  */
 struct blkg_stat {
 	struct percpu_counter		cpu_cnt;
@@ -76,6 +75,10 @@ struct blkg_rwstat {
 	atomic64_t			aux_cnt[BLKG_RWSTAT_NR];
 };
 
+struct blkg_rwstat_sample {
+	u64				cnt[BLKG_RWSTAT_NR];
+};
+
 /*
  * A blkcg_gq (blkg) is association between a block cgroup (blkcg) and a
  * request_queue (q).  This is used by blkcg policies which need to track
@@ -213,7 +216,7 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       bool show_total);
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
 u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
-			 const struct blkg_rwstat *rwstat);
+			 const struct blkg_rwstat_sample *rwstat);
 u64 blkg_prfill_stat(struct seq_file *sf, struct blkg_policy_data *pd, int off);
 u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		       int off);
@@ -225,7 +228,7 @@ int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v);
 u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
 			    struct blkcg_policy *pol, int off);
 void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
-		int off, struct blkg_rwstat *sum);
+		int off, struct blkg_rwstat_sample *sum);
 
 struct blkg_conf_ctx {
 	struct gendisk			*disk;
@@ -701,13 +704,13 @@ static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
  * Read the current snapshot of @rwstat and return it in the aux counts.
  */
 static inline void blkg_rwstat_read(struct blkg_rwstat *rwstat,
-		struct blkg_rwstat *result)
+		struct blkg_rwstat_sample *result)
 {
 	int i;
 
 	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		atomic64_set(&result->aux_cnt[i],
-			     percpu_counter_sum_positive(&rwstat->cpu_cnt[i]));
+		result->cnt[i] =
+			percpu_counter_sum_positive(&rwstat->cpu_cnt[i]);
 }
 
 /**
@@ -720,11 +723,10 @@ static inline void blkg_rwstat_read(struct blkg_rwstat *rwstat,
  */
 static inline uint64_t blkg_rwstat_total(struct blkg_rwstat *rwstat)
 {
-	struct blkg_rwstat tmp = { };
+	struct blkg_rwstat_sample tmp = { };
 
 	blkg_rwstat_read(rwstat, &tmp);
-	return atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
+	return tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE];
 }
 
 /**
-- 
2.20.1

