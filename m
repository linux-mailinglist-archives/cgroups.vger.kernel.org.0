Return-Path: <cgroups+bounces-2829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFD8C09DF
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 04:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF961F22EBE
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0490146D55;
	Thu,  9 May 2024 02:41:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A966146A7C;
	Thu,  9 May 2024 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222489; cv=none; b=r320G7sDsz+zZKTizQxcPKMcIFid/0UqsETSwddyB2aPOfDUUM+gC4cdpJ3IRZbGSy4w2hQnO4GL0kTl9Neps4dvWej1p+FWzXXq2QOFj4VC/S5hKhn2IDXQ+fGw5sluZGdosQIpEI3Zt6UkK+1dwQUpf1BtRqW2Dg7NYTmMYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222489; c=relaxed/simple;
	bh=cxIwpQSHcfuYZZ9GvvSMLZ3wG9q7rFvAlf9yitR+PVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+Y5RPWRqjzq3kP2YWn2J+J7akh3v2X9H88JFgqPinTeYLgauIJbx3i7P3n3J5D7dMVBJSZIqr3yKEkFzYMz825bjHfmLFmZExIEnhUkeadghVI83ZELTUKoCemuOky6rAupdua/BCHXXc+uQK4NFAiJVyMK/ZDRN99UxhPkutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4492dk5p051858;
	Thu, 9 May 2024 10:39:46 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VZbkH4hbGz2PGl6X;
	Thu,  9 May 2024 10:36:39 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 9 May 2024 10:39:43 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo
	<tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/2] block: introduce helper function to calculate bps budgt
Date: Thu, 9 May 2024 10:39:36 +0800
Message-ID: <20240509023937.1090421-2-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4492dk5p051858

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

The 'over-sized' bio under blk throttle control will be delayed to
launch which breaks original IO timing and have the immediate BW be
not within the bps limit. Introduce a helper function to calculate block
device's budgt which provide the allowed bytes for current bio.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/blk-throttle.c       | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 10 +++++++++
 2 files changed, 54 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f4850a6f860b..41c75258183d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -10,6 +10,7 @@
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/blktrace_api.h>
+#include <linux/cgroup.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
 #include "blk-stat.h"
@@ -2365,6 +2366,49 @@ void blk_throtl_bio_endio(struct bio *bio)
 }
 #endif
 
+unsigned long blk_throttle_budgt(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	struct throtl_grp *tg;
+	long long bytes_allowed = 0;
+	unsigned long jiffy_elapsed, jiffy_elapsed_rnd;
+	u64 bps_limit;
+
+	if (!q)
+		return U64_MAX;
+
+	rcu_read_lock();
+	spin_lock_irq(&q->queue_lock);
+	blkcg =	css_to_blkcg(task_css(current, io_cgrp_id));
+	if (!blkcg)
+		goto out;
+
+	blkg = blkg_lookup(blkcg, q);
+	if (!blkg || !blkg_tryget(blkg))
+		goto out;
+
+	tg = blkg_to_tg(blkg);
+	bps_limit = tg_bps_limit(tg, READ);
+	if (bps_limit == U64_MAX)
+		goto out;
+
+	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[READ];
+	if (!jiffy_elapsed)
+		jiffy_elapsed_rnd = tg->td->throtl_slice;
+
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
+			tg->carryover_bytes[READ];
+	blkg_put(blkg);
+out:
+	spin_unlock_irq(&q->queue_lock);
+	rcu_read_unlock();
+	return bytes_allowed;
+}
+
+
 int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index dd5841a42c33..ba79fa464e0a 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -15,10 +15,12 @@
  */
 
 #include <linux/types.h>
+#include <linux/limits.h>
 
 struct bio;
 struct cgroup_subsys_state;
 struct gendisk;
+struct block_device;
 
 #define FC_APPID_LEN              129
 
@@ -45,6 +47,14 @@ static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
 }
 #endif	/* CONFIG_BLK_CGROUP */
 
+#ifdef CONFIG_BLK_DEV_THROTTLING
+unsigned long blk_throttle_budgt(struct block_device *bdev);
+#else
+static inline unsigned long blk_throttle_budgt(struct block_device *bdev)
+{
+	return U64_MAX;
+}
+#endif
 int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
 char *blkcg_get_fc_appid(struct bio *bio);
 
-- 
2.25.1


