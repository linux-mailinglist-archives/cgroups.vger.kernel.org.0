Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC081EB00B
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2020 22:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFAUMK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jun 2020 16:12:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56349 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728182AbgFAUMJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jun 2020 16:12:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5B4465800CD;
        Mon,  1 Jun 2020 16:12:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 Jun 2020 16:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=DE5A1pDeUlAS6
        J6Hm2FCy4eO+Aqp9r8mLKpvKieIGpk=; b=tXO4ec6M5U6cRhK8NpoundvKbN6pq
        sxSBw5afa9IvJR5ayy2g6ZROhav4JD7HWkYhURYIzFWmIoOiC7kzVGebLSVVPVL/
        k8ezA44mPoay4leTbnUsbciY0PjB34NeQ2JQWKJxMT8/LFmXwX2fQcKIePWrShhh
        YmMCHA/efPlAxN0ixuFhsdZdnku5WRdKWR0PPW2oSsSvTGe18/iyGpwS2YV6BKv6
        b+JMTfcj2kr0q5wvbuXag9LxzOb7Jp6gXOQL34YXg+fjJ3oravvi8Kns3vtdsrcg
        JfR47tBMmo6AT5G8z9XgPNeMwAaex9Pq1RXuFeU/6VkAv4Asac10ExVyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=DE5A1pDeUlAS6J6Hm2FCy4eO+Aqp9r8mLKpvKieIGpk=; b=IgwYa7RQ
        1z0MVOoF+UKp0JFR1N6oFhIk7VvA1XunClivHFRuOk/2IrLlPCgNRpNUmlU1czra
        0aH9/PIxftzC1nzPxW9Mo6G11iWJ+X8NR3+oOllUl9DM2bZI+qJDLxoIWGDtoolQ
        obHXW41NmkREpsD6vmGP75xR+kAScLfrCB0lDu/MB+dB/8oooScq+NJyigaQK+N3
        eSNsmkvJjry5YB4dVhQhBFkohu7m3ekG4ax0dc+LGwBtmTqMnP7GOntQHU+hxxEc
        CDzm/XdsmgH8GcBw+TX8jjVvOHeGpTugJPabtmTfcrsm0m8pQoqKx2rVup2PJt4x
        zOqi1CVrjL0Srw==
X-ME-Sender: <xms:GGHVXk5jgB6edgd2Ib0BM4Rv-1KzIBqE9pIIBlIbND4qsvTQBMqjhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefhedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:GGHVXl54wM2feoxbVYO5-wUzdnW7bLtF4LtFxqYtefwB-Ri0tp7dpw>
    <xmx:GGHVXjcMIPkEaFd-AUTdykPI4p10rdBNdrqzBwLP0_H2zs50lx3-1w>
    <xmx:GGHVXpIJNhcGnHwCuAZRexppX3TFUwi9E43Ql6DC-n8K8FDyZHCNlQ>
    <xmx:GGHVXs31l56Bd2QNhlSs8tx0ahrRTfTK2oLFoBmmkbGu2BLAlfpmmrkBhxc>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4DB83280060;
        Mon,  1 Jun 2020 16:12:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH 2/2 blk-cgroup/for-5.8] blk-cgroup: show global disk stats in root cgroup io.stat
Date:   Mon,  1 Jun 2020 13:12:05 -0700
Message-Id: <20200601201205.1658417-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200601154351.GD31548@mtj.thefacebook.com>
References: <20200601154351.GD31548@mtj.thefacebook.com>
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

Note that in order to collect the disk stats, we needed to iterate over
devices. To facilitate that, we had to change the linkage of a disk_type
to external so that it can be used from blk-cgroup.c to iterate over
disks.

Signed-off-by: Boris Burkov <boris@bur.io>
Suggested-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  3 +-
 block/blk-cgroup.c                      | 57 ++++++++++++++++++++++++-
 block/genhd.c                           |  4 +-
 include/linux/genhd.h                   |  1 +
 4 files changed, 58 insertions(+), 7 deletions(-)

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
index 1606f419255c..a285572c2436 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -810,12 +810,66 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	rcu_read_unlock();
 }
 
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
@@ -904,7 +958,6 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 static struct cftype blkcg_files[] = {
 	{
 		.name = "stat",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = blkcg_print_stat,
 	},
 	{ }	/* terminate */
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

