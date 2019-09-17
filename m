Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8AEB5127
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfIQPNj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 11:13:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33036 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfIQPNj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Sep 2019 11:13:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so4421388qkb.0;
        Tue, 17 Sep 2019 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wSF64Sv9YEZzkU5NW2nI/DUGXcru3f1vbdKzb0+xRjU=;
        b=GNanJicUsDiZTH0ZLVbbKfVFv7WpneUpk1FZW61z0QwC9nf0hr47iaAKlTd0qYXlaA
         GGSTyI4cxc2fyRbsVHfxDmhyaHM0rvA+1TL9GOuNBp+XZcClMl8HuvxVdDQWJSUc2uw4
         /fUeFlWL/MZ0BpvtTy/Xxyk2z6K+f3lo59sypfs2MJux8eo3ms4Mi0f6pnyOcjQlZdQV
         OxfXCDBQGiUuy6BHf1lzVL7eh/Kr8IO4MI63f2jvc3q4r00BtvT/znjgHyyaXNklNO+M
         CTLFQl8pxiErsUvPwWX0aKV9GqQasY3VJY6OEOXGmLww3uWDTUTzDTYbZii+PyrjgY0M
         YmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSF64Sv9YEZzkU5NW2nI/DUGXcru3f1vbdKzb0+xRjU=;
        b=iyUgA3x5RQsT/EGTowKjA1OXlkrM3CMjofAqmcDj6k8a1KtwLCwxrcKHln/xACeKWY
         6LymtYe6FMnE0v7SG7qvWyB+S1mk/DnN5iSu7tXQFwBY3Xt1v3GAsfiTd9nwxDS9R8hz
         wbEKRPwl9FoaRVOXe+66mao/mN/TLSiYFojD+j9PPtYBWlY6ujmCHay+dx/bMKHQIOmA
         d4exGrazb+wfkWrNMjyrfxTyrCTRR1JjFwC1nLT2kY2fndzdH5P1r9p/bK/+cu5zppj1
         I+E8fEcDr5SecxFQoIOwU5d74Qs95YmiaRtF6kro8aMCQH5oR8yf0ogRVzFdrBuSdKnk
         tTfQ==
X-Gm-Message-State: APjAAAWfGgTdCiwDK+lKCKswBCuxgg/YbGTZJ+8Cd7eJbhSKXX4kV58D
        AJpIrtdKweeBjiOFQ2IlbdU=
X-Google-Smtp-Source: APXvYqyWNEGuBCTeeYqe2xBxQKmG1RCeKN/0s2/BxV/xsm5ht5VKaDYN28tfPyxujy9FGmauCf5ebg==
X-Received: by 2002:a37:a00f:: with SMTP id j15mr4206395qke.335.1568733217440;
        Tue, 17 Sep 2019 08:13:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8d29])
        by smtp.gmail.com with ESMTPSA id e7sm1368545qtb.94.2019.09.17.08.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:13:36 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:13:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 2/2] blkcg: Make bfq disable iocost when enabled
Message-ID: <20190917151334.GI3084169@devbig004.ftw2.facebook.com>
References: <20190917151308.GH3084169@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917151308.GH3084169@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Both iocost and bfq implement weight based IO control.  Currently, bfq
is using io.bfq prefix but wants to drop the bfq part.  To avoid
interface conflict, make bfq disable iocost when it's selected as the
IO scheduler for any block device on the system.  iocost is only
re-enabled when bfq is built as a module and unloaded.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/admin-guide/cgroup-v2.rst |    8 +++++---
 block/bfq-cgroup.c                      |    2 ++
 block/bfq-iosched.c                     |   32 ++++++++++++++++++++++++++++++++
 block/blk-iocost.c                      |    5 ++---
 include/linux/blk-cgroup.h              |    5 +++++
 kernel/cgroup/cgroup.c                  |    2 ++
 6 files changed, 48 insertions(+), 6 deletions(-)

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1406,9 +1406,11 @@ IO
 
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
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1194,7 +1194,9 @@ struct bfq_group *bfq_create_group_hiera
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
+#ifndef CONFIG_BLK_CGROUP_IOCOST
 	.dfl_cftypes		= bfq_blkg_files,
+#endif
 	.legacy_cftypes		= bfq_blkcg_legacy_files,
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6365,6 +6365,36 @@ static void bfq_init_root_group(struct b
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
@@ -6489,6 +6519,7 @@ static int bfq_init_queue(struct request
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
 	wbt_disable_default(q);
+	bfq_enable();
 	return 0;
 
 out_free:
@@ -6806,6 +6837,7 @@ static void __exit bfq_exit(void)
 	blkcg_policy_unregister(&blkcg_policy_bfq);
 #endif
 	bfq_slab_kill();
+	bfq_disable();
 }
 
 module_init(bfq_init);
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
@@ -2434,7 +2432,7 @@ static struct cftype ioc_files[] = {
 	{}
 };
 
-static struct blkcg_policy blkcg_policy_iocost = {
+struct blkcg_policy blkcg_policy_iocost = {
 	.dfl_cftypes	= ioc_files,
 	.cpd_alloc_fn	= ioc_cpd_alloc,
 	.cpd_free_fn	= ioc_cpd_free,
@@ -2442,6 +2440,7 @@ static struct blkcg_policy blkcg_policy_
 	.pd_init_fn	= ioc_pd_init,
 	.pd_free_fn	= ioc_pd_free,
 };
+EXPORT_SYMBOL_GPL(blkcg_policy_iocost);
 
 static int __init ioc_init(void)
 {
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -815,6 +815,11 @@ static inline void blkcg_clear_delay(str
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
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4059,6 +4059,7 @@ int cgroup_rm_cftypes(struct cftype *cft
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cgroup_rm_cftypes);
 
 /**
  * cgroup_add_cftypes - add an array of cftypes to a subsystem
@@ -4115,6 +4116,7 @@ int cgroup_add_dfl_cftypes(struct cgroup
 		cft->flags |= __CFTYPE_ONLY_ON_DFL;
 	return cgroup_add_cftypes(ss, cfts);
 }
+EXPORT_SYMBOL_GPL(cgroup_add_dfl_cftypes);
 
 /**
  * cgroup_add_legacy_cftypes - add an array of cftypes for legacy hierarchies
