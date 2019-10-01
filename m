Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB19C4115
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJATdd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 15:33:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39148 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJATdc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Oct 2019 15:33:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so16925099wrj.6
        for <cgroups@vger.kernel.org>; Tue, 01 Oct 2019 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0OGfENzQ2AF4jhd2GrXe0NkuTbvQkug4rJhC91MArg=;
        b=J3gkUchf0v/cEnEstyA4QEajBjWadESiIXI5TQ9HavpAFlU5kxWmQRbANQaDOIte34
         +3YtjAhfJYzbfN2EiooNv3nds5S95eTJRHNZgktcqjuQzA3uI/7ugYiHtMSoddXuHP3H
         aTnzGig5xvS9/+EeEF9AMRBvl3Cn55Jjx1S9wiJCkCzVNZ+RRYjoN2QVGz5N/976+jfx
         w3qqcIMJdIJx50YY7ZFIxw/nkn84hBvR8qmU849by/G/hlRlYXzzbwNJKbkNdPmZC/uY
         zWCfyNZPcirU1zAtHkBt7fwkTvTwXiPkntDoHqf9kN71yffYK3HYBNe0Rl8BIw1E9QAC
         E21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0OGfENzQ2AF4jhd2GrXe0NkuTbvQkug4rJhC91MArg=;
        b=sStjnwrLfKJYAtTsYiic0zthXhxJN8G7mHBk1Z5za3tbOuciJVyC/Gx4VF1dyzoihA
         YeiLBsDMpvgnjRdDBRyu+BR80JjOvV2KKOqDBoxfc70PXpfgh0TujeD6naOWJNLqTqqF
         kJ1ksEGcko6M+SbjgX1LebzJfWsNx1HuZnX7tKhOdFUnw5HVHWNeU1hwhAyNzrK9PKce
         iqBFhoBe40tq0n9rfDRpeyV8YoDY5fNsbia7Qgl83GWO1DMEhA1LXwKQ4KLfLfKRhwoF
         zK0jVCvSuPI0WBZKO2HwqgCdULvhF34OECve3UIhDPZxVK6Awli9I+2qoOA3KlW6Hrf8
         FevA==
X-Gm-Message-State: APjAAAXAKIxK0RECznWrIWDiZ3MkdJy2sLCcrCTqUgbB8JWLkP/yaaPa
        NbL5kd+dOfztChrcdkwnAAV8uA==
X-Google-Smtp-Source: APXvYqzhiZD20iukiTnm++qusZAnnL12yA8N95y5Tj0oft+KSFHwEDu67SbFieSo7jxMGSPUdgvSzA==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr19664251wrx.247.1569958410594;
        Tue, 01 Oct 2019 12:33:30 -0700 (PDT)
Received: from localhost.localdomain ([212.140.138.217])
        by smtp.gmail.com with ESMTPSA id q15sm36967632wrg.65.2019.10.01.12.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:33:30 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/2] blkcg: Make bfq disable iocost when enabled
Date:   Tue,  1 Oct 2019 20:33:15 +0100
Message-Id: <20191001193316.3330-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001193316.3330-1-paolo.valente@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

Both iocost and bfq implement weight based IO control.  Currently, bfq
is using io.bfq prefix but wants to drop the bfq part.  To avoid
interface conflict, make bfq disable iocost when it's selected as the
IO scheduler for any block device on the system.  iocost is only
re-enabled when bfq is built as a module and unloaded.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++++---
 block/bfq-cgroup.c                      |  2 ++
 block/bfq-iosched.c                     | 32 +++++++++++++++++++++++++
 block/blk-iocost.c                      |  5 ++--
 include/linux/blk-cgroup.h              |  5 ++++
 kernel/cgroup/cgroup.c                  |  2 ++
 6 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0fa8c0e615c2..8374957213f1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1440,9 +1440,11 @@ IO
 
 The "io" controller regulates the distribution of IO resources.  This
 controller implements both weight based and absolute bandwidth or IOPS
-limit distribution; however, weight based distribution is available
-only if cfq-iosched is in use and neither scheme is available for
-blk-mq devices.
+limit distribution.  Weight based distribution is implemented by
+either iocost controller or bfq IO scheduler.  When bfq is selected as
+the IO scheduler for any block device, iocost is disabled and bfq's
+implementation overrides for all devices.  If bfq is built as a kernel
+module, unloading it re-enables iocost.
 
 
 IO Interface Files
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 86a607cf19a1..decda96770f4 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1194,7 +1194,9 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
+#ifndef CONFIG_BLK_CGROUP_IOCOST
 	.dfl_cftypes		= bfq_blkg_files,
+#endif
 	.legacy_cftypes		= bfq_blkcg_legacy_files,
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d6339822..21d1b08610b1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6382,6 +6382,36 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->sched_data.bfq_class_idle_last_service = jiffies;
 }
 
+#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_BLK_CGROUP_IOCOST)
+static bool bfq_enabled = false;
+
+static void bfq_enable(void)
+{
+	static DEFINE_MUTEX(bfq_enable_mutex);
+
+	mutex_lock(&bfq_enable_mutex);
+	if (!bfq_enabled) {
+		pr_info("bfq-iosched: Overriding iocost\n");
+		blkcg_policy_unregister(&blkcg_policy_iocost);
+		cgroup_add_dfl_cftypes(&io_cgrp_subsys, bfq_blkg_files);
+		bfq_enabled = true;
+	}
+	mutex_unlock(&bfq_enable_mutex);
+}
+
+static void __exit bfq_disable(void)
+{
+	if (bfq_enabled) {
+		pr_info("bfq-iosched: Restoring iocost\n");
+		cgroup_rm_cftypes(bfq_blkg_files);
+		blkcg_policy_register(&blkcg_policy_iocost);
+	}
+}
+#else
+static void bfq_enable(void) {}
+static void __exit bfq_disable(void) {}
+#endif
+
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
@@ -6506,6 +6536,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
 	wbt_disable_default(q);
+	bfq_enable();
 	return 0;
 
 out_free:
@@ -6823,6 +6854,7 @@ static void __exit bfq_exit(void)
 	blkcg_policy_unregister(&blkcg_policy_bfq);
 #endif
 	bfq_slab_kill();
+	bfq_disable();
 }
 
 module_init(bfq_init);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2a3db80c1dce..511bf80b6db3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -605,8 +605,6 @@ static u32 vrate_adj_pct[] =
 	  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
 	  4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 16 };
 
-static struct blkcg_policy blkcg_policy_iocost;
-
 /* accessors and helpers */
 static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 {
@@ -2442,7 +2440,7 @@ static struct cftype ioc_files[] = {
 	{}
 };
 
-static struct blkcg_policy blkcg_policy_iocost = {
+struct blkcg_policy blkcg_policy_iocost = {
 	.dfl_cftypes	= ioc_files,
 	.cpd_alloc_fn	= ioc_cpd_alloc,
 	.cpd_free_fn	= ioc_cpd_free,
@@ -2450,6 +2448,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
 	.pd_init_fn	= ioc_pd_init,
 	.pd_free_fn	= ioc_pd_free,
 };
+EXPORT_SYMBOL_GPL(blkcg_policy_iocost);
 
 static int __init ioc_init(void)
 {
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index bed9e43f9426..5669e3cfa1bc 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -815,6 +815,11 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
+
+#ifdef CONFIG_BLK_CGROUP_IOCOST
+extern struct blkcg_policy blkcg_policy_iocost;
+#endif
+
 #else	/* CONFIG_BLK_CGROUP */
 
 struct blkcg {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 080561bb8a4b..9c9a674c12bd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4059,6 +4059,7 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cgroup_rm_cftypes);
 
 /**
  * cgroup_add_cftypes - add an array of cftypes to a subsystem
@@ -4115,6 +4116,7 @@ int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 		cft->flags |= __CFTYPE_ONLY_ON_DFL;
 	return cgroup_add_cftypes(ss, cfts);
 }
+EXPORT_SYMBOL_GPL(cgroup_add_dfl_cftypes);
 
 /**
  * cgroup_add_legacy_cftypes - add an array of cftypes for legacy hierarchies
-- 
2.20.1

