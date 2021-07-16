Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3933F3CB26A
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhGPGZs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 02:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhGPGZs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 02:25:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F34C06175F;
        Thu, 15 Jul 2021 23:22:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s18so8970728pgg.8;
        Thu, 15 Jul 2021 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qBZgZ1rhUXrPQtQ1RtY6PTOQRojpxXbKtuLlXE/iYow=;
        b=A/AiFzqwhhU2cqITL0fNNzFEVtilgMAATbE5B4mhB06UhLd8ASAZbVW+cCA5x+njML
         mCrfkD7e0dh6+yS5L/ixigSwXXPXCuldq6rRWO74AJ5gB1o26IYkBRWe682enIAeJ46S
         7+LKvk7nouKC8MXNXbtKyqg8oej/p0TetmNNllY21dpbT6qttnJ9mMjmyUYu57vG/qFH
         ro7Ul8bza2FdizqbcY7jc1BOVIK6gznJCZ/SFD3VtjIaYlHBFAJqy/WcdF5TqDOCJ1TP
         +8oGL4ZPGdUzH2NS79oIkap3bZVUJK9PZaaqfBN1nk51EtZG/9Vn2b5IYXzYBfkmXpsQ
         FWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qBZgZ1rhUXrPQtQ1RtY6PTOQRojpxXbKtuLlXE/iYow=;
        b=Sldo1+jfcmQlcEFAPEMo7AERZOJy0iTm+bjGoyjkqpnrCKwTeSgeOOQEeEoG5xG1oG
         T9vWpkP5yXFGyAgY26QQK5FuHutCThu6LreqQVHzyd+pLw3VYCMGC4E26oXOjSiPsCKe
         9bT2+Uqk1sSBbzhRcUeBJ4izZC7MGY+UwnhgCWoA5d5/SsMPoC/J3SDSG9LeIW0FuMIQ
         tQsSXiWKPlBnW4yODUFqSlAVTc9sVtQ8b9pX1VCNVWPZgP6ysXzlXw3x8T/NiCBH1+g2
         WQCoJNH7jbcrUNjsAwkif56EexQBw44Yoo43uGbyIu31ORdhpWolJW448G+0hbYWzM/s
         rIeA==
X-Gm-Message-State: AOAM5304ch44rMHEz88bGDSn+/qftZgVH+YHTVC6lxPOz3DEt4UH6ANe
        YQhj5VO3rsUiOrBHgWomCL8=
X-Google-Smtp-Source: ABdhPJxKgk5DwsG81U+8j+wkhdCUBpmerUHKGMitNohYAg2bY1jSm7C7OIW4U94qdFckfe+tZT2whQ==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr8801669pfh.17.1626416572760;
        Thu, 15 Jul 2021 23:22:52 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s24sm6740794pfg.186.2021.07.15.23.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jul 2021 23:22:52 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
Date:   Fri, 16 Jul 2021 14:22:49 +0800
Message-Id: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
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

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-merge.c    |  2 ++
 block/blk-throttle.c | 34 ++++++++++++++++++++++++++++++++++
 block/blk.h          |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a11b3b5..86ff943 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -348,6 +348,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
 		submit_bio_noacct(*bio);
 		*bio = split;
+
+		blk_throtl_recharge_bio(*bio);
 	}
 }
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b1b22d8..1967438 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2176,6 +2176,40 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
+void blk_throtl_recharge_bio(struct bio *bio)
+{
+	bool rw = bio_data_dir(bio);
+	struct blkcg_gq *blkg = bio->bi_blkg;
+	struct throtl_grp *tg = blkg_to_tg(blkg);
+	u32 iops_limit = tg_iops_limit(tg, rw);
+
+	if (iops_limit == UINT_MAX)
+		return;
+
+	/*
+	 * If previous slice expired, start a new one otherwise renew/extend
+	 * existing slice to make sure it is at least throtl_slice interval
+	 * long since now. New slice is started only for empty throttle group.
+	 * If there is queued bio, that means there should be an active
+	 * slice and it should be extended instead.
+	 */
+	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
+		throtl_start_new_slice(tg, rw);
+	else {
+		if (time_before(tg->slice_end[rw],
+		    jiffies + tg->td->throtl_slice))
+			throtl_extend_slice(tg, rw,
+				jiffies + tg->td->throtl_slice);
+	}
+
+	/* Recharge the bio to the group, as some BIOs will be further split
+	 * after passing through the throttle, causing the actual IOPS to
+	 * be greater than the expected value.
+	 */
+	tg->last_io_disp[rw]++;
+	tg->io_disp[rw]++;
+}
+
 bool blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
diff --git a/block/blk.h b/block/blk.h
index 4b885c0..067634a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -293,12 +293,14 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
 extern void blk_throtl_register_queue(struct request_queue *q);
+extern void blk_throtl_recharge_bio(struct bio *bio);
 bool blk_throtl_bio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+static inline void blk_throtl_recharge_bio(struct bio *bio) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
-- 
1.8.3.1

