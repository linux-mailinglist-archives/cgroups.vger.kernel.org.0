Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43729F2140
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfKFV64 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 16:58:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34819 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbfKFV64 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 16:58:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id i19so189158qki.2;
        Wed, 06 Nov 2019 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1RNkpP/6c1wkNjNfmGzvDFKkj2oY00WdMepvCx/iboM=;
        b=M0kfIohC+qPapy7ut9Htoye6JW+QCVdpyF/vNjQipWuZT4M80T1zYs+77B5U5KaRPL
         CbKinSPyrd4jCiPPxOM+Qy2Jz+cGlQcjwQJTH1IAD2h5zOJUoySJiN6/B6w374BghOtA
         0UVG28lQpCwa3GpAxfRB+FNfZZ3HrDmljbOAwAHnq4OulFkmI/0aF7kgoy5TwrN0ovkc
         NHdl4AQUKsh6Ls6jvCP9TtrJec9Dzrx3JzpfzmqHdMFEQQGTVe5M1Naohu1lSZn5KSW2
         9c8uYIQVRoifYX4nVDap/dIiO2LgrMHCGqJ1S5pUdEvqdPBiXR94spsFiQdwtWt60ORr
         8ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1RNkpP/6c1wkNjNfmGzvDFKkj2oY00WdMepvCx/iboM=;
        b=Cf3vEA7mTzOhjSoJh6uB6qRCzNLH5MgGF3pXVnQeK5Mo26q9vMqdsw2/B+Al4TR1vt
         QF7gowZAIQ3RFjfdbJSRDrti0ZocxcgrfgJ98tk0wnsx5f0DnUjXb6D+zGESKcPHNmb2
         ggMexpuFf72ii5ujwUirm87NllRyPNKDVTUy7+3qHDHpxkHfob0CmMPQkCrS2MKIwx9q
         R/Y58VNmcRk4iZMLDe1Iwwyoz2R6gfgHiWC5lqch7FcBUuE43RIm9ODzDVzo2paF73nO
         c/Nks9XWGBw+a5TZ2M3Ss5vk6zpI7jUbfOUsoG7hTtmKs5qXWsBPxVwhyI0yZ0cLCyUj
         1Hjw==
X-Gm-Message-State: APjAAAXBJy/dBAIoD3tS96gTk6Pwj7AVX4EURN678fgPyQ5p2CrKbxKL
        A1J2mPb6vb6K90VNOlUFTpo=
X-Google-Smtp-Source: APXvYqwiE8EgR3P/YoGuPU2lC93iW0EDVLWZHhEwLyQR9fm1/9rJdVazcT7c+6kR2ad7XWsD2SoTPg==
X-Received: by 2002:a37:c24a:: with SMTP id j10mr4417811qkm.20.1573077533993;
        Wed, 06 Nov 2019 13:58:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5bd1])
        by smtp.gmail.com with ESMTPSA id 23sm85479qkj.52.2019.11.06.13.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:58:53 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] blk-cgroup: separate out blkg_rwstat under CONFIG_BLK_CGROUP_RWSTAT
Date:   Wed,  6 Nov 2019 13:58:38 -0800
Message-Id: <20191106215838.3973497-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106215838.3973497-1-tj@kernel.org>
References: <20191106215838.3973497-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

blkg_rwstat is now only used by bfq-iosched and blk-throtl when on
cgroup1.  Let's move it into its own files and gate it behind a config
option.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/Kconfig              |   4 +
 block/Kconfig.iosched      |   1 +
 block/Makefile             |   1 +
 block/bfq-iosched.h        |   2 +
 block/blk-cgroup-rwstat.c  | 129 ++++++++++++++++++++++++++++++
 block/blk-cgroup-rwstat.h  | 149 ++++++++++++++++++++++++++++++++++
 block/blk-cgroup.c         |  97 ----------------------
 block/blk-throttle.c       |   1 +
 include/linux/blk-cgroup.h | 159 -------------------------------------
 9 files changed, 287 insertions(+), 256 deletions(-)
 create mode 100644 block/blk-cgroup-rwstat.c
 create mode 100644 block/blk-cgroup-rwstat.h

diff --git a/block/Kconfig b/block/Kconfig
index 41c0917ce622..c23094a14a2b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -32,6 +32,9 @@ config BLK_RQ_ALLOC_TIME
 config BLK_SCSI_REQUEST
 	bool
 
+config BLK_CGROUP_RWSTAT
+	bool
+
 config BLK_DEV_BSG
 	bool "Block layer SG support v4"
 	default y
@@ -86,6 +89,7 @@ config BLK_DEV_ZONED
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
+	select BLK_CGROUP_RWSTAT
 	---help---
 	Block layer bio throttling support. It can be used to limit
 	the IO rate to a device. IO rate policies are per cgroup and
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index b89310a022ad..7df14133adc8 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -31,6 +31,7 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
+       select BLK_CGROUP_RWSTAT
        ---help---
 
        Enable hierarchical scheduling in BFQ, using the blkio
diff --git a/block/Makefile b/block/Makefile
index 9ef57ace90d4..205a5f2fef17 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
+obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 2676c06218f1..9c82c1f35716 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -10,6 +10,8 @@
 #include <linux/hrtimer.h>
 #include <linux/blk-cgroup.h>
 
+#include "blk-cgroup-rwstat.h"
+
 #define BFQ_IOPRIO_CLASSES	3
 #define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
 
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
new file mode 100644
index 000000000000..85d5790ac49b
--- /dev/null
+++ b/block/blk-cgroup-rwstat.c
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Legacy blkg rwstat helpers enabled by CONFIG_BLK_CGROUP_RWSTAT.
+ * Do not use in new code.
+ */
+#include "blk-cgroup-rwstat.h"
+
+int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp)
+{
+	int i, ret;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
+		ret = percpu_counter_init(&rwstat->cpu_cnt[i], 0, gfp);
+		if (ret) {
+			while (--i >= 0)
+				percpu_counter_destroy(&rwstat->cpu_cnt[i]);
+			return ret;
+		}
+		atomic64_set(&rwstat->aux_cnt[i], 0);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blkg_rwstat_init);
+
+void blkg_rwstat_exit(struct blkg_rwstat *rwstat)
+{
+	int i;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++)
+		percpu_counter_destroy(&rwstat->cpu_cnt[i]);
+}
+EXPORT_SYMBOL_GPL(blkg_rwstat_exit);
+
+/**
+ * __blkg_prfill_rwstat - prfill helper for a blkg_rwstat
+ * @sf: seq_file to print to
+ * @pd: policy private data of interest
+ * @rwstat: rwstat to print
+ *
+ * Print @rwstat to @sf for the device assocaited with @pd.
+ */
+u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
+			 const struct blkg_rwstat_sample *rwstat)
+{
+	static const char *rwstr[] = {
+		[BLKG_RWSTAT_READ]	= "Read",
+		[BLKG_RWSTAT_WRITE]	= "Write",
+		[BLKG_RWSTAT_SYNC]	= "Sync",
+		[BLKG_RWSTAT_ASYNC]	= "Async",
+		[BLKG_RWSTAT_DISCARD]	= "Discard",
+	};
+	const char *dname = blkg_dev_name(pd->blkg);
+	u64 v;
+	int i;
+
+	if (!dname)
+		return 0;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++)
+		seq_printf(sf, "%s %s %llu\n", dname, rwstr[i],
+			   rwstat->cnt[i]);
+
+	v = rwstat->cnt[BLKG_RWSTAT_READ] +
+		rwstat->cnt[BLKG_RWSTAT_WRITE] +
+		rwstat->cnt[BLKG_RWSTAT_DISCARD];
+	seq_printf(sf, "%s Total %llu\n", dname, v);
+	return v;
+}
+EXPORT_SYMBOL_GPL(__blkg_prfill_rwstat);
+
+/**
+ * blkg_prfill_rwstat - prfill callback for blkg_rwstat
+ * @sf: seq_file to print to
+ * @pd: policy private data of interest
+ * @off: offset to the blkg_rwstat in @pd
+ *
+ * prfill callback for printing a blkg_rwstat.
+ */
+u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
+		       int off)
+{
+	struct blkg_rwstat_sample rwstat = { };
+
+	blkg_rwstat_read((void *)pd + off, &rwstat);
+	return __blkg_prfill_rwstat(sf, pd, &rwstat);
+}
+EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
+
+/**
+ * blkg_rwstat_recursive_sum - collect hierarchical blkg_rwstat
+ * @blkg: blkg of interest
+ * @pol: blkcg_policy which contains the blkg_rwstat
+ * @off: offset to the blkg_rwstat in blkg_policy_data or @blkg
+ * @sum: blkg_rwstat_sample structure containing the results
+ *
+ * Collect the blkg_rwstat specified by @blkg, @pol and @off and all its
+ * online descendants and their aux counts.  The caller must be holding the
+ * queue lock for online tests.
+ *
+ * If @pol is NULL, blkg_rwstat is at @off bytes into @blkg; otherwise, it
+ * is at @off bytes into @blkg's blkg_policy_data of the policy.
+ */
+void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
+		int off, struct blkg_rwstat_sample *sum)
+{
+	struct blkcg_gq *pos_blkg;
+	struct cgroup_subsys_state *pos_css;
+	unsigned int i;
+
+	lockdep_assert_held(&blkg->q->queue_lock);
+
+	rcu_read_lock();
+	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
+		struct blkg_rwstat *rwstat;
+
+		if (!pos_blkg->online)
+			continue;
+
+		if (pol)
+			rwstat = (void *)blkg_to_pd(pos_blkg, pol) + off;
+		else
+			rwstat = (void *)pos_blkg + off;
+
+		for (i = 0; i < BLKG_RWSTAT_NR; i++)
+			sum->cnt[i] = blkg_rwstat_read_counter(rwstat, i);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(blkg_rwstat_recursive_sum);
diff --git a/block/blk-cgroup-rwstat.h b/block/blk-cgroup-rwstat.h
new file mode 100644
index 000000000000..ee746919c41f
--- /dev/null
+++ b/block/blk-cgroup-rwstat.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Legacy blkg rwstat helpers enabled by CONFIG_BLK_CGROUP_RWSTAT.
+ * Do not use in new code.
+ */
+#ifndef _BLK_CGROUP_RWSTAT_H
+#define _BLK_CGROUP_RWSTAT_H
+
+#include <linux/blk-cgroup.h>
+
+enum blkg_rwstat_type {
+	BLKG_RWSTAT_READ,
+	BLKG_RWSTAT_WRITE,
+	BLKG_RWSTAT_SYNC,
+	BLKG_RWSTAT_ASYNC,
+	BLKG_RWSTAT_DISCARD,
+
+	BLKG_RWSTAT_NR,
+	BLKG_RWSTAT_TOTAL = BLKG_RWSTAT_NR,
+};
+
+/*
+ * blkg_[rw]stat->aux_cnt is excluded for local stats but included for
+ * recursive.  Used to carry stats of dead children.
+ */
+struct blkg_rwstat {
+	struct percpu_counter		cpu_cnt[BLKG_RWSTAT_NR];
+	atomic64_t			aux_cnt[BLKG_RWSTAT_NR];
+};
+
+struct blkg_rwstat_sample {
+	u64				cnt[BLKG_RWSTAT_NR];
+};
+
+static inline u64 blkg_rwstat_read_counter(struct blkg_rwstat *rwstat,
+		unsigned int idx)
+{
+	return atomic64_read(&rwstat->aux_cnt[idx]) +
+		percpu_counter_sum_positive(&rwstat->cpu_cnt[idx]);
+}
+
+int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp);
+void blkg_rwstat_exit(struct blkg_rwstat *rwstat);
+u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
+			 const struct blkg_rwstat_sample *rwstat);
+u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
+		       int off);
+void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
+		int off, struct blkg_rwstat_sample *sum);
+
+
+/**
+ * blkg_rwstat_add - add a value to a blkg_rwstat
+ * @rwstat: target blkg_rwstat
+ * @op: REQ_OP and flags
+ * @val: value to add
+ *
+ * Add @val to @rwstat.  The counters are chosen according to @rw.  The
+ * caller is responsible for synchronizing calls to this function.
+ */
+static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
+				   unsigned int op, uint64_t val)
+{
+	struct percpu_counter *cnt;
+
+	if (op_is_discard(op))
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_DISCARD];
+	else if (op_is_write(op))
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_WRITE];
+	else
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_READ];
+
+	percpu_counter_add_batch(cnt, val, BLKG_STAT_CPU_BATCH);
+
+	if (op_is_sync(op))
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_SYNC];
+	else
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_ASYNC];
+
+	percpu_counter_add_batch(cnt, val, BLKG_STAT_CPU_BATCH);
+}
+
+/**
+ * blkg_rwstat_read - read the current values of a blkg_rwstat
+ * @rwstat: blkg_rwstat to read
+ *
+ * Read the current snapshot of @rwstat and return it in the aux counts.
+ */
+static inline void blkg_rwstat_read(struct blkg_rwstat *rwstat,
+		struct blkg_rwstat_sample *result)
+{
+	int i;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++)
+		result->cnt[i] =
+			percpu_counter_sum_positive(&rwstat->cpu_cnt[i]);
+}
+
+/**
+ * blkg_rwstat_total - read the total count of a blkg_rwstat
+ * @rwstat: blkg_rwstat to read
+ *
+ * Return the total count of @rwstat regardless of the IO direction.  This
+ * function can be called without synchronization and takes care of u64
+ * atomicity.
+ */
+static inline uint64_t blkg_rwstat_total(struct blkg_rwstat *rwstat)
+{
+	struct blkg_rwstat_sample tmp = { };
+
+	blkg_rwstat_read(rwstat, &tmp);
+	return tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE];
+}
+
+/**
+ * blkg_rwstat_reset - reset a blkg_rwstat
+ * @rwstat: blkg_rwstat to reset
+ */
+static inline void blkg_rwstat_reset(struct blkg_rwstat *rwstat)
+{
+	int i;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
+		percpu_counter_set(&rwstat->cpu_cnt[i], 0);
+		atomic64_set(&rwstat->aux_cnt[i], 0);
+	}
+}
+
+/**
+ * blkg_rwstat_add_aux - add a blkg_rwstat into another's aux count
+ * @to: the destination blkg_rwstat
+ * @from: the source
+ *
+ * Add @from's count including the aux one to @to's aux count.
+ */
+static inline void blkg_rwstat_add_aux(struct blkg_rwstat *to,
+				       struct blkg_rwstat *from)
+{
+	u64 sum[BLKG_RWSTAT_NR];
+	int i;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++)
+		sum[i] = percpu_counter_sum_positive(&from->cpu_cnt[i]);
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++)
+		atomic64_add(sum[i] + atomic64_read(&from->aux_cnt[i]),
+			     &to->aux_cnt[i]);
+}
+#endif	/* _BLK_CGROUP_RWSTAT_H */
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0b349f6a6a69..d0b9bfa563eb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -561,103 +561,6 @@ u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 }
 EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
 
-/**
- * __blkg_prfill_rwstat - prfill helper for a blkg_rwstat
- * @sf: seq_file to print to
- * @pd: policy private data of interest
- * @rwstat: rwstat to print
- *
- * Print @rwstat to @sf for the device assocaited with @pd.
- */
-u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
-			 const struct blkg_rwstat_sample *rwstat)
-{
-	static const char *rwstr[] = {
-		[BLKG_RWSTAT_READ]	= "Read",
-		[BLKG_RWSTAT_WRITE]	= "Write",
-		[BLKG_RWSTAT_SYNC]	= "Sync",
-		[BLKG_RWSTAT_ASYNC]	= "Async",
-		[BLKG_RWSTAT_DISCARD]	= "Discard",
-	};
-	const char *dname = blkg_dev_name(pd->blkg);
-	u64 v;
-	int i;
-
-	if (!dname)
-		return 0;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		seq_printf(sf, "%s %s %llu\n", dname, rwstr[i],
-			   rwstat->cnt[i]);
-
-	v = rwstat->cnt[BLKG_RWSTAT_READ] +
-		rwstat->cnt[BLKG_RWSTAT_WRITE] +
-		rwstat->cnt[BLKG_RWSTAT_DISCARD];
-	seq_printf(sf, "%s Total %llu\n", dname, v);
-	return v;
-}
-EXPORT_SYMBOL_GPL(__blkg_prfill_rwstat);
-
-/**
- * blkg_prfill_rwstat - prfill callback for blkg_rwstat
- * @sf: seq_file to print to
- * @pd: policy private data of interest
- * @off: offset to the blkg_rwstat in @pd
- *
- * prfill callback for printing a blkg_rwstat.
- */
-u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
-		       int off)
-{
-	struct blkg_rwstat_sample rwstat = { };
-
-	blkg_rwstat_read((void *)pd + off, &rwstat);
-	return __blkg_prfill_rwstat(sf, pd, &rwstat);
-}
-EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
-
-/**
- * blkg_rwstat_recursive_sum - collect hierarchical blkg_rwstat
- * @blkg: blkg of interest
- * @pol: blkcg_policy which contains the blkg_rwstat
- * @off: offset to the blkg_rwstat in blkg_policy_data or @blkg
- * @sum: blkg_rwstat_sample structure containing the results
- *
- * Collect the blkg_rwstat specified by @blkg, @pol and @off and all its
- * online descendants and their aux counts.  The caller must be holding the
- * queue lock for online tests.
- *
- * If @pol is NULL, blkg_rwstat is at @off bytes into @blkg; otherwise, it
- * is at @off bytes into @blkg's blkg_policy_data of the policy.
- */
-void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
-		int off, struct blkg_rwstat_sample *sum)
-{
-	struct blkcg_gq *pos_blkg;
-	struct cgroup_subsys_state *pos_css;
-	unsigned int i;
-
-	lockdep_assert_held(&blkg->q->queue_lock);
-
-	rcu_read_lock();
-	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
-		struct blkg_rwstat *rwstat;
-
-		if (!pos_blkg->online)
-			continue;
-
-		if (pol)
-			rwstat = (void *)blkg_to_pd(pos_blkg, pol) + off;
-		else
-			rwstat = (void *)pos_blkg + off;
-
-		for (i = 0; i < BLKG_RWSTAT_NR; i++)
-			sum->cnt[i] = blkg_rwstat_read_counter(rwstat, i);
-	}
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL_GPL(blkg_rwstat_recursive_sum);
-
 /* Performs queue bypass and policy enabled checks then looks up blkg. */
 static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 					  const struct blkcg_policy *pol,
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6ac5b5d56170..ae1f73a92e12 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -12,6 +12,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-cgroup.h>
 #include "blk.h"
+#include "blk-cgroup-rwstat.h"
 
 /* Max dispatch from a group in 1 round */
 static int throtl_grp_quantum = 8;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 867ab391e409..48a66738143d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -41,17 +41,6 @@ enum blkg_iostat_type {
 	BLKG_IOSTAT_NR,
 };
 
-enum blkg_rwstat_type {
-	BLKG_RWSTAT_READ,
-	BLKG_RWSTAT_WRITE,
-	BLKG_RWSTAT_SYNC,
-	BLKG_RWSTAT_ASYNC,
-	BLKG_RWSTAT_DISCARD,
-
-	BLKG_RWSTAT_NR,
-	BLKG_RWSTAT_TOTAL = BLKG_RWSTAT_NR,
-};
-
 struct blkcg_gq;
 
 struct blkcg {
@@ -82,19 +71,6 @@ struct blkg_iostat_set {
 	struct blkg_iostat		last;
 };
 
-/*
- * blkg_[rw]stat->aux_cnt is excluded for local stats but included for
- * recursive.  Used to carry stats of dead children.
- */
-struct blkg_rwstat {
-	struct percpu_counter		cpu_cnt[BLKG_RWSTAT_NR];
-	atomic64_t			aux_cnt[BLKG_RWSTAT_NR];
-};
-
-struct blkg_rwstat_sample {
-	u64				cnt[BLKG_RWSTAT_NR];
-};
-
 /*
  * A blkcg_gq (blkg) is association between a block cgroup (blkcg) and a
  * request_queue (q).  This is used by blkcg policies which need to track
@@ -223,13 +199,6 @@ int blkcg_activate_policy(struct request_queue *q,
 void blkcg_deactivate_policy(struct request_queue *q,
 			     const struct blkcg_policy *pol);
 
-static inline u64 blkg_rwstat_read_counter(struct blkg_rwstat *rwstat,
-		unsigned int idx)
-{
-	return atomic64_read(&rwstat->aux_cnt[idx]) +
-		percpu_counter_sum_positive(&rwstat->cpu_cnt[idx]);
-}
-
 const char *blkg_dev_name(struct blkcg_gq *blkg);
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       u64 (*prfill)(struct seq_file *,
@@ -237,12 +206,6 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       const struct blkcg_policy *pol, int data,
 		       bool show_total);
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
-u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
-			 const struct blkg_rwstat_sample *rwstat);
-u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
-		       int off);
-void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
-		int off, struct blkg_rwstat_sample *sum);
 
 struct blkg_conf_ctx {
 	struct gendisk			*disk;
@@ -594,128 +557,6 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
 					      (p_blkg)->q, false)))
 
-static inline int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp)
-{
-	int i, ret;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
-		ret = percpu_counter_init(&rwstat->cpu_cnt[i], 0, gfp);
-		if (ret) {
-			while (--i >= 0)
-				percpu_counter_destroy(&rwstat->cpu_cnt[i]);
-			return ret;
-		}
-		atomic64_set(&rwstat->aux_cnt[i], 0);
-	}
-	return 0;
-}
-
-static inline void blkg_rwstat_exit(struct blkg_rwstat *rwstat)
-{
-	int i;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		percpu_counter_destroy(&rwstat->cpu_cnt[i]);
-}
-
-/**
- * blkg_rwstat_add - add a value to a blkg_rwstat
- * @rwstat: target blkg_rwstat
- * @op: REQ_OP and flags
- * @val: value to add
- *
- * Add @val to @rwstat.  The counters are chosen according to @rw.  The
- * caller is responsible for synchronizing calls to this function.
- */
-static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
-				   unsigned int op, uint64_t val)
-{
-	struct percpu_counter *cnt;
-
-	if (op_is_discard(op))
-		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_DISCARD];
-	else if (op_is_write(op))
-		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_WRITE];
-	else
-		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_READ];
-
-	percpu_counter_add_batch(cnt, val, BLKG_STAT_CPU_BATCH);
-
-	if (op_is_sync(op))
-		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_SYNC];
-	else
-		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_ASYNC];
-
-	percpu_counter_add_batch(cnt, val, BLKG_STAT_CPU_BATCH);
-}
-
-/**
- * blkg_rwstat_read - read the current values of a blkg_rwstat
- * @rwstat: blkg_rwstat to read
- *
- * Read the current snapshot of @rwstat and return it in the aux counts.
- */
-static inline void blkg_rwstat_read(struct blkg_rwstat *rwstat,
-		struct blkg_rwstat_sample *result)
-{
-	int i;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		result->cnt[i] =
-			percpu_counter_sum_positive(&rwstat->cpu_cnt[i]);
-}
-
-/**
- * blkg_rwstat_total - read the total count of a blkg_rwstat
- * @rwstat: blkg_rwstat to read
- *
- * Return the total count of @rwstat regardless of the IO direction.  This
- * function can be called without synchronization and takes care of u64
- * atomicity.
- */
-static inline uint64_t blkg_rwstat_total(struct blkg_rwstat *rwstat)
-{
-	struct blkg_rwstat_sample tmp = { };
-
-	blkg_rwstat_read(rwstat, &tmp);
-	return tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE];
-}
-
-/**
- * blkg_rwstat_reset - reset a blkg_rwstat
- * @rwstat: blkg_rwstat to reset
- */
-static inline void blkg_rwstat_reset(struct blkg_rwstat *rwstat)
-{
-	int i;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
-		percpu_counter_set(&rwstat->cpu_cnt[i], 0);
-		atomic64_set(&rwstat->aux_cnt[i], 0);
-	}
-}
-
-/**
- * blkg_rwstat_add_aux - add a blkg_rwstat into another's aux count
- * @to: the destination blkg_rwstat
- * @from: the source
- *
- * Add @from's count including the aux one to @to's aux count.
- */
-static inline void blkg_rwstat_add_aux(struct blkg_rwstat *to,
-				       struct blkg_rwstat *from)
-{
-	u64 sum[BLKG_RWSTAT_NR];
-	int i;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		sum[i] = percpu_counter_sum_positive(&from->cpu_cnt[i]);
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		atomic64_add(sum[i] + atomic64_read(&from->aux_cnt[i]),
-			     &to->aux_cnt[i]);
-}
-
 #ifdef CONFIG_BLK_DEV_THROTTLING
 extern bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 			   struct bio *bio);
-- 
2.17.1

