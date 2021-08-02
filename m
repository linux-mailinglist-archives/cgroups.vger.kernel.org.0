Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C33DCEFE
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 05:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhHBDwK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 1 Aug 2021 23:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhHBDwJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 1 Aug 2021 23:52:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DFCC06175F;
        Sun,  1 Aug 2021 20:52:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k2so634932plk.13;
        Sun, 01 Aug 2021 20:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ewn+EI6qbIfdhlpZR/OWbSCkPz5dXjXMmqvAd/fj+PE=;
        b=t2D+HKyskSkmLy6VTqcNWp227BboiDJjuNRpS0ZpN2BusRewXoqdEWsN+Hi04GMNxJ
         V9XHiqFbsuuIv/We6qruyQTaDwEb1WQ0sDJ9D1NAes5r4Xerms6oyLHV1V1UG9i0/40m
         26nQY8Lvh1kWlFEoOWBmij9Y7DJtuxgzZP18jsGAae7XRM1blbW33YBDLzIXyNMK3vBv
         FukpQl9Rxal3KL3bE3HaCHauGndcfGv6RUQ+dTy5HhYWibI8FgFIt/FYLI7wYy8a3/Xe
         VjbENDgTEWYd1GPsxetZ8pfaZvVXt5qDJ2C/WVxxl+ckpVGy9Ue8vuDnA5OsPduv0fgd
         KF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ewn+EI6qbIfdhlpZR/OWbSCkPz5dXjXMmqvAd/fj+PE=;
        b=F3ppLceCi0IcAY8Kib8Se3bcY1vEmOpY+jxkh3KENLOQI59Z8GIuPAmFbfWw0DseRj
         GtmSjyp2+NRsFtCpzAo5HQfkNRc6453O3tccrnxXd9pji0U8Prk1A5Wbknw331HEnmdN
         WalK3nz5/B3pyQaqvWt0Jwy+grmq63kFcAKejMu92D9Jmy5z11L/MEtyE87v/jj99IGI
         PEKQJV0msH6k7tN6/H+yl47HKQe3CzvuBF/4pOr0k/u40Fs3MXbGu5Ttd0xaO/V1/nfM
         mzm2SKLQachszp2akCQJieLCN1br09ETVV4dYNWU4Meio3tkZV+T1JJMpJcFt28QwOFQ
         q1dw==
X-Gm-Message-State: AOAM532OFSRQWl2+zBXz/eJ8KQiGehSlaBvsXhPzXE3k4sBFf3Kjp4GS
        E4pJQNalAlvNoBonmAq/K0U=
X-Google-Smtp-Source: ABdhPJxQdR4jx0TvLHkCp6Yn/JEJkf3QFIzNdouN66uji6mPYbRyGQqe0Q96GhGLnBH+kWKgHQP4dQ==
X-Received: by 2002:a65:615a:: with SMTP id o26mr4535441pgv.177.1627876319581;
        Sun, 01 Aug 2021 20:51:59 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x24sm8894471pjk.43.2021.08.01.20.51.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Aug 2021 20:51:59 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH v3] blk-throtl: optimize IOPS throttle for large IO scenarios
Date:   Mon,  2 Aug 2021 11:51:56 +0800
Message-Id: <65869aaad05475797d63b4c3fed4f529febe3c26.1627876014.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

After patch 54efd50 (block: make generic_make_request handle
arbitrarily sized bios), the IO through io-throttle may be larger,
and these IOs may be further split into more small IOs. However,
IOPS throttle does not seem to be aware of this change, which
makes the calculation of IOPS of large IOs incomplete, resulting
in disk-side IOPS that does not meet expectations. Maybe we should
fix this problem.

We can reproduce it by set max_sectors_kb of disk to 128, set
blkio.write_iops_throttle to 100, run a dd instance inside blkio
and use iostat to watch IOPS:

dd if=/dev/zero of=/dev/sdb bs=1M count=1000 oflag=direct

As a result, without this change the average IOPS is 1995, with
this change the IOPS is 98.

v3: Optimize the use of atomic variables.
v2: Use atomic variables to solve synchronization problems.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-merge.c    |  2 ++
 block/blk-throttle.c | 32 ++++++++++++++++++++++++++++++++
 block/blk.h          |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a11b3b53717e..22eeaad190d7 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -348,6 +348,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
 		submit_bio_noacct(*bio);
 		*bio = split;
+
+		blk_throtl_charge_bio_split(*bio);
 	}
 }
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b1b22d863bdf..55c49015e533 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -178,6 +178,9 @@ struct throtl_grp {
 	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
 	unsigned long bio_cnt_reset_time;
 
+	atomic_t io_split_cnt[2];
+	atomic_t last_io_split_cnt[2];
+
 	struct blkg_rwstat stat_bytes;
 	struct blkg_rwstat stat_ios;
 };
@@ -777,6 +780,8 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 
+	atomic_set(&tg->io_split_cnt[rw], 0);
+
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
 	 * bio dispatch. That means since start of last slice, we never used
@@ -799,6 +804,9 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 	tg->io_disp[rw] = 0;
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+
+	atomic_set(&tg->io_split_cnt[rw], 0);
+
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -1031,6 +1039,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 				jiffies + tg->td->throtl_slice);
 	}
 
+	if (iops_limit != UINT_MAX)
+		tg->io_disp[rw] += atomic_xchg(&tg->io_split_cnt[rw], 0);
+
 	if (tg_with_in_bps_limit(tg, bio, bps_limit, &bps_wait) &&
 	    tg_with_in_iops_limit(tg, bio, iops_limit, &iops_wait)) {
 		if (wait)
@@ -2052,12 +2063,14 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	}
 
 	if (tg->iops[READ][LIMIT_LOW]) {
+		tg->last_io_disp[READ] += atomic_xchg(&tg->last_io_split_cnt[READ], 0);
 		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
 		if (iops >= tg->iops[READ][LIMIT_LOW])
 			tg->last_low_overflow_time[READ] = now;
 	}
 
 	if (tg->iops[WRITE][LIMIT_LOW]) {
+		tg->last_io_disp[WRITE] += atomic_xchg(&tg->last_io_split_cnt[WRITE], 0);
 		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
 		if (iops >= tg->iops[WRITE][LIMIT_LOW])
 			tg->last_low_overflow_time[WRITE] = now;
@@ -2176,6 +2189,25 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
+void blk_throtl_charge_bio_split(struct bio *bio)
+{
+	struct blkcg_gq *blkg = bio->bi_blkg;
+	struct throtl_grp *parent = blkg_to_tg(blkg);
+	struct throtl_service_queue *parent_sq;
+	bool rw = bio_data_dir(bio);
+
+	do {
+		if (!parent->has_rules[rw])
+			break;
+
+		atomic_inc(&parent->io_split_cnt[rw]);
+		atomic_inc(&parent->last_io_split_cnt[rw]);
+
+		parent_sq = parent->service_queue.parent_sq;
+		parent = sq_to_tg(parent_sq);
+	} while (parent);
+}
+
 bool blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
diff --git a/block/blk.h b/block/blk.h
index 4b885c0f6708..fb9ec838e4b9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -293,11 +293,13 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
 extern void blk_throtl_register_queue(struct request_queue *q);
+extern void blk_throtl_charge_bio_split(struct bio *bio);
 bool blk_throtl_bio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
+static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-- 
2.30.0

