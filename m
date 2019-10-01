Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33819C411A
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJATdm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 15:33:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54869 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfJATdf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Oct 2019 15:33:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so4640310wmp.4
        for <cgroups@vger.kernel.org>; Tue, 01 Oct 2019 12:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzszKoFLT5NZbsdUd0WPglNj1NW4fnrsvxmRV31aUBU=;
        b=fB+4Rxsip2rgYkAaVfwvGIDHK2K/xujvY+JTVeEQEmhUG59m7hp3vst6MoKVDlCvcI
         cDRRM6pcb1wkVeG8TzYFrZ6GlwUMb/w5R/renXsLTyP+MhkBiHZtz7XeqlGNqwX/orwS
         GwWYuBA2aYWAuKFw+BJfrGZj893f+kEFZFuLykvuTAcTswS9MJfHHsq2Qb7axBU+JJaD
         y4YSjrl14Qszvdx8WVz2fl5cZt2n3defYe33ZG7zwPoKn7cXvVGDr2H/iaCsXR3UteKP
         8wEP8yTOOSoCNxBKr3o3731RFcecfo5egA8otbAQ7JCbMRGsMHH2bK5rlNDuk8zyangZ
         5LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzszKoFLT5NZbsdUd0WPglNj1NW4fnrsvxmRV31aUBU=;
        b=GrgsMcfyKihBsyarcoheZ7SsU8GeF+5MPgpmtNW8SheRv65SuqZpi1g+YD9racIVU6
         WCwwA6YcYgAUsC7GomYyhviA3EjWcS6STtQULqIYoX5fmCdz6+vQxKdATVgaVMSmqsIe
         LnuzhasSlQMqqt6P8Y3YodtV51uJ7v6WMDCLlMnwfQ05rJzrWXKjsjFV13++45k7SxEj
         kjtQfZIQE6fJUc9Iz2VAr5JU4YpydNUOlfQwcPcRtLJN37Qt5/G2HyEHieOR1d7lahLl
         F75Jk7gZZH12J816M+ztcXdHi2wMVKUdtkQHc5qK9yoZGRWqhNVynHWqeKWND2hB/hjU
         U5Ew==
X-Gm-Message-State: APjAAAW6/43ViOVChDO1+6EKElTfhJQzC1DXQ+Mc0u4Wb7ADWJ1tVgEw
        Nh5l2nuiEGPDR5viYE/5d+e+kg==
X-Google-Smtp-Source: APXvYqyiZvluY93z+fCSecUMw35Ea67CwwoPralkN+KQwVlJiq0vjXEwkD1KpICk6TuIqWfFZVicDQ==
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr4930236wme.77.1569958411663;
        Tue, 01 Oct 2019 12:33:31 -0700 (PDT)
Received: from localhost.localdomain ([212.140.138.217])
        by smtp.gmail.com with ESMTPSA id q15sm36967632wrg.65.2019.10.01.12.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:33:31 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/2] block, bfq: present a double cgroups interface
Date:   Tue,  1 Oct 2019 20:33:16 +0100
Message-Id: <20191001193316.3330-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001193316.3330-1-paolo.valente@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When bfq was merged into mainline, there were two I/O schedulers that
implemented the proportional-share policy: bfq for blk-mq and cfq for
legacy blk. bfq's interface files in the blkio/io controller have the
same names as cfq. But the cgroups interface doesn't allow two
entities to use the same name for their files, so for bfq we had to
prepend the "bfq" prefix to each of its files. However no legacy code
uses these modified file names. This naming also causes confusion, as,
e.g., in [1].

Now cfq has gone with legacy blk, so there is no need any longer for
these prefixes in (the never used) bfq names. Yet some people may have
started to use the current bfq interface. So, as suggested by Tejun
Heo [2], make bfq present a double interface, one with the file names
prepended with the "bfq" prefix, and the other one with no prefix.

[1] https://github.com/systemd/systemd/issues/7057
[2] https://lkml.org/lkml/2019/9/18/736

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/block/bfq-iosched.rst |  40 +++--
 block/bfq-cgroup.c                  | 258 ++++++++++++++--------------
 2 files changed, 153 insertions(+), 145 deletions(-)

diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index 0d237d402860..8ecd37903391 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -536,12 +536,14 @@ process.
 To get proportional sharing of bandwidth with BFQ for a given device,
 BFQ must of course be the active scheduler for that device.
 
-Within each group directory, the names of the files associated with
-BFQ-specific cgroup parameters and stats begin with the "bfq."
-prefix. So, with cgroups-v1 or cgroups-v2, the full prefix for
-BFQ-specific files is "blkio.bfq." or "io.bfq." For example, the group
-parameter to set the weight of a group with BFQ is blkio.bfq.weight
-or io.bfq.weight.
+The interface of the proportional-share policy implemented by BFQ
+consists of a series of cgroup parameters. For legacy issues, each
+parameter can be read or written, equivalently, through one of two
+files: the first file has the same name as the parameter to
+read/write, while the second file has that same name prepended by the
+prefix "bfq.". For example, the two files by which to set/show the
+weight of a group are blkio.weight and blkio.bfq.weight with
+cgroups-v1, or io.weight and io.bfq.weight with cgroups-v2.
 
 As for cgroups-v1 (blkio controller), the exact set of stat files
 created, and kept up-to-date by bfq, depends on whether
@@ -550,14 +552,15 @@ the stat files documented in
 Documentation/admin-guide/cgroup-v1/blkio-controller.rst. If, instead,
 CONFIG_BFQ_CGROUP_DEBUG is not set, then bfq creates only the files::
 
-  blkio.bfq.io_service_bytes
-  blkio.bfq.io_service_bytes_recursive
-  blkio.bfq.io_serviced
-  blkio.bfq.io_serviced_recursive
+  blkio.io_service_bytes
+  blkio.io_service_bytes_recursive
+  blkio.io_serviced
+  blkio.io_serviced_recursive
 
-The value of CONFIG_BFQ_CGROUP_DEBUG greatly influences the maximum
-throughput sustainable with bfq, because updating the blkio.bfq.*
-stats is rather costly, especially for some of the stats enabled by
+(plus their counterparts with also the bfq prefix). The value of
+CONFIG_BFQ_CGROUP_DEBUG greatly influences the maximum throughput
+sustainable with BFQ, because updating the blkio.* stats is rather
+costly, especially for some of the stats enabled by
 CONFIG_BFQ_CGROUP_DEBUG.
 
 Parameters to set
@@ -565,11 +568,12 @@ Parameters to set
 
 For each group, there is only the following parameter to set.
 
-weight (namely blkio.bfq.weight or io.bfq-weight): the weight of the
-group inside its parent. Available values: 1..10000 (default 100). The
-linear mapping between ioprio and weights, described at the beginning
-of the tunable section, is still valid, but all weights higher than
-IOPRIO_BE_NR*10 are mapped to ioprio 0.
+weight (namely blkio.weight/blkio.bfq.weight or
+io.weight/io.bfq.weight): the weight of the group inside its
+parent. Available values: 1..10000 (default 100). The linear mapping
+between ioprio and weights, described at the beginning of the tunable
+section, is still valid, but all weights higher than IOPRIO_BE_NR*10
+are mapped to ioprio 0.
 
 Recall that, if low-latency is set, then BFQ automatically raises the
 weight of the queues associated with interactive and soft real-time
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index decda96770f4..d3b59b731992 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1211,139 +1211,143 @@ struct blkcg_policy blkcg_policy_bfq = {
 	.pd_reset_stats_fn	= bfq_pd_reset_stats,
 };
 
-struct cftype bfq_blkcg_legacy_files[] = {
-	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight_legacy,
-		.write_u64 = bfq_io_set_weight_legacy,
-	},
-	{
-		.name = "bfq.weight_device",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight,
-		.write = bfq_io_set_weight,
-	},
-
-	/* statistics, covers only the tasks in the bfqg */
-	{
-		.name = "bfq.io_service_bytes",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_bytes,
-	},
-	{
-		.name = "bfq.io_serviced",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_ios,
-	},
-#ifdef CONFIG_BFQ_CGROUP_DEBUG
-	{
-		.name = "bfq.time",
-		.private = offsetof(struct bfq_group, stats.time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.sectors",
-		.seq_show = bfqg_print_stat_sectors,
-	},
-	{
-		.name = "bfq.io_service_time",
-		.private = offsetof(struct bfq_group, stats.service_time),
-		.seq_show = bfqg_print_rwstat,
-	},
-	{
-		.name = "bfq.io_wait_time",
-		.private = offsetof(struct bfq_group, stats.wait_time),
-		.seq_show = bfqg_print_rwstat,
-	},
-	{
-		.name = "bfq.io_merged",
-		.private = offsetof(struct bfq_group, stats.merged),
-		.seq_show = bfqg_print_rwstat,
-	},
-	{
-		.name = "bfq.io_queued",
-		.private = offsetof(struct bfq_group, stats.queued),
-		.seq_show = bfqg_print_rwstat,
-	},
-#endif /* CONFIG_BFQ_CGROUP_DEBUG */
+#define bfq_make_blkcg_legacy_files(prefix)			\
+	{							\
+		.name = #prefix "weight",			\
+		.flags = CFTYPE_NOT_ON_ROOT,			\
+		.seq_show = bfq_io_show_weight,			\
+		.write_u64 = bfq_io_set_weight_legacy,		\
+	},							\
+								\
+	/* statistics, covers only the tasks in the bfqg */	\
+	{							\
+		.name = #prefix "io_service_bytes",		\
+		.private = (unsigned long)&blkcg_policy_bfq,	\
+		.seq_show = blkg_print_stat_bytes,		\
+	},							\
+	{							\
+		.name = #prefix "io_serviced",		\
+		.private = (unsigned long)&blkcg_policy_bfq,	\
+		.seq_show = blkg_print_stat_ios,		\
+	},							\
+								\
+	/* the same statistics which cover the bfqg and its descendants */ \
+	{							\
+		.name = #prefix "io_service_bytes_recursive",	\
+		.private = (unsigned long)&blkcg_policy_bfq,	\
+		.seq_show = blkg_print_stat_bytes_recursive,	\
+	},							\
+	{							\
+		.name = #prefix "io_serviced_recursive",	\
+		.private = (unsigned long)&blkcg_policy_bfq,	\
+		.seq_show = blkg_print_stat_ios_recursive,	\
+	}
+
+#define bfq_make_blkcg_legacy_debug_files(prefix)			\
+	{								\
+		.name = #prefix "time",				\
+		.private = offsetof(struct bfq_group, stats.time),	\
+		.seq_show = bfqg_print_stat,				\
+	},								\
+	{								\
+		.name = #prefix "sectors",				\
+		.seq_show = bfqg_print_stat_sectors,			\
+	},								\
+	{								\
+		.name = #prefix "io_service_time",			\
+		.private = offsetof(struct bfq_group, stats.service_time), \
+		.seq_show = bfqg_print_rwstat,				\
+	},								\
+	{								\
+		.name = #prefix "io_wait_time",			\
+		.private = offsetof(struct bfq_group, stats.wait_time),	\
+		.seq_show = bfqg_print_rwstat,				\
+	},								\
+	{								\
+		.name = #prefix "io_merged",				\
+		.private = offsetof(struct bfq_group, stats.merged),	\
+		.seq_show = bfqg_print_rwstat,				\
+	},								\
+	{								\
+		.name = #prefix "io_queued",				\
+		.private = offsetof(struct bfq_group, stats.queued),	\
+		.seq_show = bfqg_print_rwstat,				\
+	},								\
+	{								\
+		.name = #prefix "time_recursive",			\
+		.private = offsetof(struct bfq_group, stats.time),	\
+		.seq_show = bfqg_print_stat_recursive,			\
+	},								\
+	{								\
+		.name = #prefix "sectors_recursive",			\
+		.seq_show = bfqg_print_stat_sectors_recursive,		\
+	},								\
+	{								\
+		.name = #prefix "io_service_time_recursive",		\
+		.private = offsetof(struct bfq_group, stats.service_time), \
+		.seq_show = bfqg_print_rwstat_recursive,		\
+	},								\
+	{								\
+		.name = #prefix "io_wait_time_recursive",		\
+		.private = offsetof(struct bfq_group, stats.wait_time),	\
+		.seq_show = bfqg_print_rwstat_recursive,		\
+	},								\
+	{								\
+		.name = #prefix "io_merged_recursive",		\
+		.private = offsetof(struct bfq_group, stats.merged),	\
+		.seq_show = bfqg_print_rwstat_recursive,		\
+	},								\
+	{								\
+		.name = #prefix "io_queued_recursive",		\
+		.private = offsetof(struct bfq_group, stats.queued),	\
+		.seq_show = bfqg_print_rwstat_recursive,		\
+	},								\
+	{								\
+		.name = #prefix "avg_queue_size",			\
+		.seq_show = bfqg_print_avg_queue_size,			\
+	},								\
+	{								\
+		.name = #prefix "group_wait_time",			\
+		.private = offsetof(struct bfq_group, stats.group_wait_time), \
+		.seq_show = bfqg_print_stat,				\
+	},								\
+	{								\
+		.name = #prefix "idle_time",				\
+		.private = offsetof(struct bfq_group, stats.idle_time),	\
+		.seq_show = bfqg_print_stat,				\
+	},								\
+	{								\
+		.name = #prefix "empty_time",				\
+		.private = offsetof(struct bfq_group, stats.empty_time), \
+		.seq_show = bfqg_print_stat,				\
+	},								\
+	{								\
+		.name = #prefix "dequeue",				\
+		.private = offsetof(struct bfq_group, stats.dequeue),	\
+		.seq_show = bfqg_print_stat,				\
+	}
 
-	/* the same statistics which cover the bfqg and its descendants */
-	{
-		.name = "bfq.io_service_bytes_recursive",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_bytes_recursive,
-	},
-	{
-		.name = "bfq.io_serviced_recursive",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_ios_recursive,
-	},
+struct cftype bfq_blkcg_legacy_files[] = {
+	bfq_make_blkcg_legacy_files(bfq.),
+	bfq_make_blkcg_legacy_files(),
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
-	{
-		.name = "bfq.time_recursive",
-		.private = offsetof(struct bfq_group, stats.time),
-		.seq_show = bfqg_print_stat_recursive,
-	},
-	{
-		.name = "bfq.sectors_recursive",
-		.seq_show = bfqg_print_stat_sectors_recursive,
-	},
-	{
-		.name = "bfq.io_service_time_recursive",
-		.private = offsetof(struct bfq_group, stats.service_time),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.io_wait_time_recursive",
-		.private = offsetof(struct bfq_group, stats.wait_time),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.io_merged_recursive",
-		.private = offsetof(struct bfq_group, stats.merged),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.io_queued_recursive",
-		.private = offsetof(struct bfq_group, stats.queued),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.avg_queue_size",
-		.seq_show = bfqg_print_avg_queue_size,
-	},
-	{
-		.name = "bfq.group_wait_time",
-		.private = offsetof(struct bfq_group, stats.group_wait_time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.idle_time",
-		.private = offsetof(struct bfq_group, stats.idle_time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.empty_time",
-		.private = offsetof(struct bfq_group, stats.empty_time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.dequeue",
-		.private = offsetof(struct bfq_group, stats.dequeue),
-		.seq_show = bfqg_print_stat,
-	},
-#endif	/* CONFIG_BFQ_CGROUP_DEBUG */
+	bfq_make_blkcg_legacy_debug_files(bfq.),
+	bfq_make_blkcg_legacy_debug_files(),
+#endif
 	{ }	/* terminate */
 };
 
+#define bfq_make_blkg_files(prefix)		\
+	{					\
+		.name = #prefix "weight",	\
+		.flags = CFTYPE_NOT_ON_ROOT,	\
+		.seq_show = bfq_io_show_weight,	\
+		.write = bfq_io_set_weight,	\
+	}
+
 struct cftype bfq_blkg_files[] = {
-	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight,
-		.write = bfq_io_set_weight,
-	},
+	bfq_make_blkg_files(bfq.),
+	bfq_make_blkg_files(),
 	{} /* terminate */
 };
 
-- 
2.20.1

