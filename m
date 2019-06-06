Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B73719B
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfFFK0f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 06:26:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFFK0e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 06:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BAAihVYxzS+dHN9xB9Nw+15CI5kx2h4JthSMxll4y9U=; b=G0XcDOKyIjGuQvFDrTNBFfYy59
        up0iEJIpwOTqN/Tf4nlpz5lkiPLw4uxgW0cvbaPvJS8bUzxSohynFbYi1GKK1058MCijRZfedePT9
        D4gRPl0I8Ul5gLgP/8EaoeyI31Rt8SlLPz/LZCLeWQGOc8BDKGiie/bMLt40LY/uHHYNLij7jrKvN
        mmwSX54IxqPSw6pE8FGoV/VdxFC0A1W/ML54Y0zZn+JDDn+x0S5JDjN/C8X6ZGOeP2F18sCTGh8Ht
        AOqTQoJji5x1ZT2y42qxd23xP/n5iFw/JVSFdEhOuaxK8RKGL0prRRKFfOu+w89UACOFEZFjB6jW5
        QMiSbMUQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbN-0007h7-AR; Thu, 06 Jun 2019 10:26:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] blk-cgroup: pass blkg_rwstat structures by reference
Date:   Thu,  6 Jun 2019 12:26:20 +0200
Message-Id: <20190606102624.3847-3-hch@lst.de>
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

Returning a structure generates rather bad code, so switch to passing
by reference.  Also don't require the structure to be zeroed and add
to the 0-initialized counters, but actually set the counters to the
calculated value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c         | 15 +++++++++------
 block/blk-cgroup.c         | 31 ++++++++++++++++---------------
 include/linux/blk-cgroup.h | 14 +++++++-------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b3796a40a61a..66abc82179f3 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -935,9 +935,9 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
 					struct blkg_policy_data *pd, int off)
 {
-	struct blkg_rwstat sum = blkg_rwstat_recursive_sum(pd_to_blkg(pd),
-							   &blkcg_policy_bfq,
-							   off);
+	struct blkg_rwstat sum;
+
+	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_bfq, off, &sum);
 	return __blkg_prfill_rwstat(sf, pd, &sum);
 }
 
@@ -975,9 +975,12 @@ static int bfqg_print_stat_sectors(struct seq_file *sf, void *v)
 static u64 bfqg_prfill_sectors_recursive(struct seq_file *sf,
 					 struct blkg_policy_data *pd, int off)
 {
-	struct blkg_rwstat tmp = blkg_rwstat_recursive_sum(pd->blkg, NULL,
-					offsetof(struct blkcg_gq, stat_bytes));
-	u64 sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
+	struct blkg_rwstat tmp;
+	u64 sum;
+
+	blkg_rwstat_recursive_sum(pd->blkg, NULL,
+			offsetof(struct blkcg_gq, stat_bytes), &tmp);
+	sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
 		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
 
 	return __blkg_prfill_u64(sf, pd, sum >> 9);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6f79ace02be4..7d6bf9b03e24 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -602,8 +602,9 @@ EXPORT_SYMBOL_GPL(blkg_prfill_stat);
 u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		       int off)
 {
-	struct blkg_rwstat rwstat = blkg_rwstat_read((void *)pd + off);
+	struct blkg_rwstat rwstat = { };
 
+	blkg_rwstat_read((void *)pd + off, &rwstat);
 	return __blkg_prfill_rwstat(sf, pd, &rwstat);
 }
 EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
@@ -611,8 +612,9 @@ EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
 static u64 blkg_prfill_rwstat_field(struct seq_file *sf,
 				    struct blkg_policy_data *pd, int off)
 {
-	struct blkg_rwstat rwstat = blkg_rwstat_read((void *)pd->blkg + off);
+	struct blkg_rwstat rwstat = { };
 
+	blkg_rwstat_read((void *)pd->blkg + off, &rwstat);
 	return __blkg_prfill_rwstat(sf, pd, &rwstat);
 }
 
@@ -654,8 +656,9 @@ static u64 blkg_prfill_rwstat_field_recursive(struct seq_file *sf,
 					      struct blkg_policy_data *pd,
 					      int off)
 {
-	struct blkg_rwstat rwstat = blkg_rwstat_recursive_sum(pd->blkg,
-							      NULL, off);
+	struct blkg_rwstat rwstat;
+
+	blkg_rwstat_recursive_sum(pd->blkg, NULL, off, &rwstat);
 	return __blkg_prfill_rwstat(sf, pd, &rwstat);
 }
 
@@ -736,6 +739,7 @@ EXPORT_SYMBOL_GPL(blkg_stat_recursive_sum);
  * @blkg: blkg of interest
  * @pol: blkcg_policy which contains the blkg_rwstat
  * @off: offset to the blkg_rwstat in blkg_policy_data or @blkg
+ * @sum: blkg_rwstat structure containing the results
  *
  * Collect the blkg_rwstat specified by @blkg, @pol and @off and all its
  * online descendants and their aux counts.  The caller must be holding the
@@ -744,12 +748,11 @@ EXPORT_SYMBOL_GPL(blkg_stat_recursive_sum);
  * If @pol is NULL, blkg_rwstat is at @off bytes into @blkg; otherwise, it
  * is at @off bytes into @blkg's blkg_policy_data of the policy.
  */
-struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
-					     struct blkcg_policy *pol, int off)
+void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
+		int off, struct blkg_rwstat *sum)
 {
 	struct blkcg_gq *pos_blkg;
 	struct cgroup_subsys_state *pos_css;
-	struct blkg_rwstat sum = { };
 	unsigned int i;
 
 	lockdep_assert_held(&blkg->q->queue_lock);
@@ -767,12 +770,10 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
 			rwstat = (void *)pos_blkg + off;
 
 		for (i = 0; i < BLKG_RWSTAT_NR; i++)
-			atomic64_add(blkg_rwstat_read_counter(rwstat, i),
-				&sum.aux_cnt[i]);
+			atomic64_set(&sum->aux_cnt[i],
+				blkg_rwstat_read_counter(rwstat, i));
 	}
 	rcu_read_unlock();
-
-	return sum;
 }
 EXPORT_SYMBOL_GPL(blkg_rwstat_recursive_sum);
 
@@ -958,14 +959,14 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 		spin_lock_irq(&blkg->q->queue_lock);
 
-		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
-					offsetof(struct blkcg_gq, stat_bytes));
+		blkg_rwstat_recursive_sum(blkg, NULL,
+				offsetof(struct blkcg_gq, stat_bytes), &rwstat);
 		rbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
 		dbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
-		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
-					offsetof(struct blkcg_gq, stat_ios));
+		blkg_rwstat_recursive_sum(blkg, NULL,
+					offsetof(struct blkcg_gq, stat_ios), &rwstat);
 		rios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
 		dios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 06236f56a840..3ee858111274 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -224,8 +224,8 @@ int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v);
 
 u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
 			    struct blkcg_policy *pol, int off);
-struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
-					     struct blkcg_policy *pol, int off);
+void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
+		int off, struct blkg_rwstat *sum);
 
 struct blkg_conf_ctx {
 	struct gendisk			*disk;
@@ -700,15 +700,14 @@ static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
  *
  * Read the current snapshot of @rwstat and return it in the aux counts.
  */
-static inline struct blkg_rwstat blkg_rwstat_read(struct blkg_rwstat *rwstat)
+static inline void blkg_rwstat_read(struct blkg_rwstat *rwstat,
+		struct blkg_rwstat *result)
 {
-	struct blkg_rwstat result;
 	int i;
 
 	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		atomic64_set(&result.aux_cnt[i],
+		atomic64_set(&result->aux_cnt[i],
 			     percpu_counter_sum_positive(&rwstat->cpu_cnt[i]));
-	return result;
 }
 
 /**
@@ -721,8 +720,9 @@ static inline struct blkg_rwstat blkg_rwstat_read(struct blkg_rwstat *rwstat)
  */
 static inline uint64_t blkg_rwstat_total(struct blkg_rwstat *rwstat)
 {
-	struct blkg_rwstat tmp = blkg_rwstat_read(rwstat);
+	struct blkg_rwstat tmp = { };
 
+	blkg_rwstat_read(rwstat, &tmp);
 	return atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
 		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
 }
-- 
2.20.1

