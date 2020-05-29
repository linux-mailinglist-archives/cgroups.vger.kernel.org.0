Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2A1E8BD9
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2020 01:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgE2XUZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 19:20:25 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:53565 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgE2XUZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 19:20:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 79802160A;
        Fri, 29 May 2020 19:20:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 29 May 2020 19:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=NiQG/tD5+WSs469fNdGE5PUeS3
        WKVuh9TA8wXZO+ago=; b=utzddtwMWe13cmAR+D7ZTBr8IOno67gUwV6CBLTXlG
        URzcc1ilvsoh8qbXCwUrUk5Fpta74wSSkc7Wnm5Gc7MXbw9nyV+jvtLptUwPfJrb
        o/XhMXBwRi9Ltuqr+OtYMtZTRqG2o18jE/2Zzb/RhOj3L/let+1fi12Z9lGvqe5Q
        SNqfbEkdY0+UwoWKKQ3cfz5Wb/bMnSABHjfkjgsylfuJT18FBhEZKQVnDPYcrPUm
        4loan7Cr26fDjpZy4Ag2gVI1XFp58xLCCnwvAjTfFpTNobFz7Vr9Z98ERG6UMQrm
        +jVt0WJasuzOcAfP1vyFr7/h84DP3N7c5m8PxLZ2WtfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NiQG/tD5+WSs469fN
        dGE5PUeS3WKVuh9TA8wXZO+ago=; b=s99X2CW9+yulkGMa8h6E47le2k96P7mTU
        BmdO3tZe8PjspdHq4RobNVdoT4ZqDFpgjbgroW1u5M+BbOP1TwEm4/qiPhVrdpri
        4LMFy8LfXw8IaUKK8GdefOhTGGHF4VX6MXzMfF4sEcfgczd5lP1IV0tVWNk93/IY
        nB1Kscl7wROKEFy/uuCmEs1IfCnE+d0PHHD3GOj3ab/xEMUWAdvlRB2QKPy+J9YD
        DMyDTVjFE8owP2jgiM307sqbJZIeURKC5/xQFSsE/oUY03L3wKN0byeNX6RZTeAu
        7s/+Lt1G0NZ0DM0YuHl2Wt2FDya0G6wJJOv2fMv8B1NTY0oR50lyA==
X-ME-Sender: <xms:tJjRXudo9M_1IZrbmlFaDqBUO7OUuIJ0RZAauhfR521zejb1LotvJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitd
    elueeijeefleffveelieefgfejjeeigeekudduteefkefffeethfdvjeevnecukfhppedu
    ieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:tJjRXoNQOnC9McvcvQ4crkctqf9Xcq0nfEFoAIBWMW2BJ_ApilhUQQ>
    <xmx:tJjRXvhRTve9ZWzuVygtQg5zFg_4OHcGr40qwIo0G4Fr5495bzAjyg>
    <xmx:tJjRXr8igY8fIwytzZPi3EPXhsET6GdHoxUQrDibEuiHuKo_u98pdw>
    <xmx:tZjRXuJkoBf2ybY2oa4EfGmnnJwYPPf-WW9_hRH0htuIwgYJTTAV1Chm0qzxbyYd>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 677273280060;
        Fri, 29 May 2020 19:20:20 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH blk-cgroup/for-5.8] blk-cgroup: show global disk stats in root cgroup io.stat
Date:   Fri, 29 May 2020 16:20:17 -0700
Message-Id: <20200529232017.1795920-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In order to improve consistency and usability in cgroup stat accounting,
we would like to support the root cgroup's io.stat.

Since the root cgroup has processes doing io even if the system has no
explicitly created cgroups, we need to be careful to avoid overhead in
that case.  For that reason, the rstat algorithms don't handle the root
cgroup, so just turning the file on wouldn't give correct statistics.

To get around this, we simulate flushing the iostat struct by filling it
out directly from global disk stats. The result is a root cgroup io.stat
file consistent with both /proc/diskstats and io.stat.

Signed-off-by: Boris Burkov <boris@bur.io>
Suggested-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |   3 +-
 block/blk-cgroup.c                      | 199 +++++++++++++++---------
 block/genhd.c                           |   4 +-
 include/linux/genhd.h                   |   1 +
 4 files changed, 129 insertions(+), 78 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index fed4e1d2a343..1eaea1ddaeb9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1465,8 +1465,7 @@ IO Interface Files
 ~~~~~~~~~~~~~~~~~~
 
   io.stat
-	A read-only nested-keyed file which exists on non-root
-	cgroups.
+	A read-only nested-keyed file.
 
 	Lines are keyed by $MAJ:$MIN device numbers and not ordered.
 	The following nested keys are defined.
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ecc897b225c..a285572c2436 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -739,12 +739,137 @@ void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
+static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] = src->bytes[i];
+		dst->ios[i] = src->ios[i];
+	}
+}
+
+static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] += src->bytes[i];
+		dst->ios[i] += src->ios[i];
+	}
+}
+
+static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] -= src->bytes[i];
+		dst->ios[i] -= src->ios[i];
+	}
+}
+
+static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct blkcg_gq *parent = blkg->parent;
+		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
+		struct blkg_iostat cur, delta;
+		unsigned int seq;
+
+		/* fetch the current per-cpu values */
+		do {
+			seq = u64_stats_fetch_begin(&bisc->sync);
+			blkg_iostat_set(&cur, &bisc->cur);
+		} while (u64_stats_fetch_retry(&bisc->sync, seq));
+
+		/* propagate percpu delta to global */
+		u64_stats_update_begin(&blkg->iostat.sync);
+		blkg_iostat_set(&delta, &cur);
+		blkg_iostat_sub(&delta, &bisc->last);
+		blkg_iostat_add(&blkg->iostat.cur, &delta);
+		blkg_iostat_add(&bisc->last, &delta);
+		u64_stats_update_end(&blkg->iostat.sync);
+
+		/* propagate global delta to parent */
+		if (parent) {
+			u64_stats_update_begin(&parent->iostat.sync);
+			blkg_iostat_set(&delta, &blkg->iostat.cur);
+			blkg_iostat_sub(&delta, &blkg->iostat.last);
+			blkg_iostat_add(&parent->iostat.cur, &delta);
+			blkg_iostat_add(&blkg->iostat.last, &delta);
+			u64_stats_update_end(&parent->iostat.sync);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * The rstat algorithms intentionally don't handle the root cgroup to avoid
+ * incurring overhead when no cgroups are defined. For that reason,
+ * cgroup_rstat_flush in blkcg_print_stat does not actually fill out the
+ * iostat in the root cgroup's blkcg_gq.
+ *
+ * However, we would like to re-use the printing code between the root and
+ * non-root cgroups to the extent possible. For that reason, we simulate
+ * flushing the root cgroup's stats by explicitly filling in the iostat
+ * with disk level statistics.
+ */
+static void blkcg_fill_root_iostats(void)
+{
+	struct class_dev_iter iter;
+	struct device *dev;
+
+	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
+	while ((dev = class_dev_iter_next(&iter))) {
+		struct gendisk *disk = dev_to_disk(dev);
+		struct hd_struct *part = disk_get_part(disk, 0);
+		struct blkcg_gq *blkg = blk_queue_root_blkg(disk->queue);
+		struct blkg_iostat tmp;
+		int cpu;
+
+		memset(&tmp, 0, sizeof(tmp));
+		for_each_possible_cpu(cpu) {
+			struct disk_stats *cpu_dkstats;
+
+			cpu_dkstats = per_cpu_ptr(part->dkstats, cpu);
+			tmp.ios[BLKG_IOSTAT_READ] +=
+				cpu_dkstats->ios[STAT_READ];
+			tmp.ios[BLKG_IOSTAT_WRITE] +=
+				cpu_dkstats->ios[STAT_WRITE];
+			tmp.ios[BLKG_IOSTAT_DISCARD] +=
+				cpu_dkstats->ios[STAT_DISCARD];
+			// convert sectors to bytes
+			tmp.bytes[BLKG_IOSTAT_READ] +=
+				cpu_dkstats->sectors[STAT_READ] << 9;
+			tmp.bytes[BLKG_IOSTAT_WRITE] +=
+				cpu_dkstats->sectors[STAT_WRITE] << 9;
+			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
+				cpu_dkstats->sectors[STAT_DISCARD] << 9;
+
+			u64_stats_update_begin(&blkg->iostat.sync);
+			blkg_iostat_set(&blkg->iostat.cur, &tmp);
+			u64_stats_update_end(&blkg->iostat.sync);
+		}
+	}
+}
+
 static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct blkcg_gq *blkg;
 
-	cgroup_rstat_flush(blkcg->css.cgroup);
+	if (!seq_css(sf)->parent)
+		blkcg_fill_root_iostats();
+	else
+		cgroup_rstat_flush(blkcg->css.cgroup);
+
 	rcu_read_lock();
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -833,7 +958,6 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 static struct cftype blkcg_files[] = {
 	{
 		.name = "stat",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = blkcg_print_stat,
 	},
 	{ }	/* terminate */
@@ -1114,77 +1238,6 @@ static int blkcg_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
-static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] = src->bytes[i];
-		dst->ios[i] = src->ios[i];
-	}
-}
-
-static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] += src->bytes[i];
-		dst->ios[i] += src->ios[i];
-	}
-}
-
-static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] -= src->bytes[i];
-		dst->ios[i] -= src->ios[i];
-	}
-}
-
-static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
-{
-	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
-
-	rcu_read_lock();
-
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct blkcg_gq *parent = blkg->parent;
-		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
-		struct blkg_iostat cur, delta;
-		unsigned seq;
-
-		/* fetch the current per-cpu values */
-		do {
-			seq = u64_stats_fetch_begin(&bisc->sync);
-			blkg_iostat_set(&cur, &bisc->cur);
-		} while (u64_stats_fetch_retry(&bisc->sync, seq));
-
-		/* propagate percpu delta to global */
-		u64_stats_update_begin(&blkg->iostat.sync);
-		blkg_iostat_set(&delta, &cur);
-		blkg_iostat_sub(&delta, &bisc->last);
-		blkg_iostat_add(&blkg->iostat.cur, &delta);
-		blkg_iostat_add(&bisc->last, &delta);
-		u64_stats_update_end(&blkg->iostat.sync);
-
-		/* propagate global delta to parent */
-		if (parent) {
-			u64_stats_update_begin(&parent->iostat.sync);
-			blkg_iostat_set(&delta, &blkg->iostat.cur);
-			blkg_iostat_sub(&delta, &blkg->iostat.last);
-			blkg_iostat_add(&parent->iostat.cur, &delta);
-			blkg_iostat_add(&blkg->iostat.last, &delta);
-			u64_stats_update_end(&parent->iostat.sync);
-		}
-	}
-
-	rcu_read_unlock();
-}
-
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
 {
 	int i;
diff --git a/block/genhd.c b/block/genhd.c
index afdb2c3e5b22..4f5f4590517c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -38,8 +38,6 @@ static struct kobject *block_depr;
 static DEFINE_SPINLOCK(ext_devt_lock);
 static DEFINE_IDR(ext_devt_idr);
 
-static const struct device_type disk_type;
-
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
 static void disk_alloc_events(struct gendisk *disk);
@@ -1566,7 +1564,7 @@ static char *block_devnode(struct device *dev, umode_t *mode,
 	return NULL;
 }
 
-static const struct device_type disk_type = {
+const struct device_type disk_type = {
 	.name		= "disk",
 	.groups		= disk_attr_groups,
 	.release	= disk_release,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a9384449465a..ea38bc36bc6d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -26,6 +26,7 @@
 #define disk_to_dev(disk)	(&(disk)->part0.__dev)
 #define part_to_dev(part)	(&((part)->__dev))
 
+extern const struct device_type disk_type;
 extern struct device_type part_type;
 extern struct class block_class;
 
-- 
2.24.1

