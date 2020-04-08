Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8971A2A23
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2020 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgDHUPD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 16:15:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41178 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgDHUPC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 16:15:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id i3so977726qtv.8;
        Wed, 08 Apr 2020 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ih5upVjhUxfYMhdnP4A5/T8a9y3p/p63bXQ1Cpw5ptI=;
        b=ahdDMthtvdSscTfVMy/vrgXkEE6ZLB/M6Kqlcr4R1o5OQHWIEAP1lo7TbzBshjqpCi
         ijZq34NRYb1Wu/xEtN7bQcDJNh6Gv/5gE9N3nKqoQdfjvMtx9Gohf9fADM/CRUc3c/CZ
         9rKw14KxaKSEjoftno62YvA0eZ0wBdQOFpRG0QiJgot3SK8khszhzpQKBdBkDxhpXX7u
         pXyrkGGwxgGc35KEFON+hvf2NVTqYgULNGVY6GczJRq/gohaYTmvIkP5/Jn6AD8sm5jA
         UFDc3fRkF6wXTWUq86zn7wMUK4PuykXM3UtoOcF6+Nw2CiBwktkCj78chNE6Gia7VXd3
         2qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ih5upVjhUxfYMhdnP4A5/T8a9y3p/p63bXQ1Cpw5ptI=;
        b=MZWUO0RFPr9rQ8Tir/1h1QKDsfqQxuPpAMCMtpZEKE78NRhXqSWFpwaedzg82izJIu
         IhCgDJaBmPssG0U5brolH9H7gJ5FXqYnrIE/ET2LzmS42IZquQioKwZ4WRbhG+HTwVB+
         Lwknezsd8wjCOC0ROhVJcCWWqCidyLD+gucWEZMMZgOBNPzeONH6wB5GXjx9vuhHB/we
         XRMQBOs/JeRecQt72nmi4eY8NgDkLBDRhDP82M5e3MHly/UPdUwiCitm8ySoAmsSzS+L
         U6nxlYz1Gqg7oaiFt4AKvKYPBaXm78p4kALJ2CnVX/btHXmyMdkauUykJGbJTFa6WRti
         0DHQ==
X-Gm-Message-State: AGi0PuZy3cxPWyNG2UpXhDHnJlEq8BLoFyR+gEMHpkrmu8DM71HhPktl
        id0Q196ffdjbGUyfue22scw=
X-Google-Smtp-Source: APiQypJ+V51HeM9lIksTMHTJr0O0aWzVoY1i89+H2QOsGYkxE3JJ60mBLO+vpQ06kVuTddKxSWEEaw==
X-Received: by 2002:aed:3981:: with SMTP id m1mr9341568qte.35.1586376899337;
        Wed, 08 Apr 2020 13:14:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id l22sm20476361qkj.120.2020.04.08.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:14:58 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] block: add request->io_data_len
Date:   Wed,  8 Apr 2020 16:14:47 -0400
Message-Id: <20200408201450.3959560-3-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200408201450.3959560-1-tj@kernel.org>
References: <20200408201450.3959560-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, at the time of completeion, there's no way of knowing how big a
request was. blk-iocost will need this information to account for IO size when
calculating expected latencies.

This patch adds rq->io_data_len which remembers blk_rq_bytes() at the time the
request gets issued. The field is enabled iff CONFIG_BLK_IO_DATA_LEN is set and
doesn't increase the size of the struct even when enabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/Kconfig          | 3 +++
 block/blk-mq.c         | 6 ++++++
 include/linux/blkdev.h | 8 ++++++++
 3 files changed, 17 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 3bc76bb113a0..48308e600dc8 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -26,6 +26,9 @@ menuconfig BLOCK
 
 if BLOCK
 
+config BLK_RQ_IO_DATA_LEN
+	bool
+
 config BLK_RQ_ALLOC_TIME
 	bool
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6291ceedee4..64ed22712fe4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -415,6 +415,9 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		return ERR_PTR(-EWOULDBLOCK);
 
 	rq->__data_len = 0;
+#ifdef CONFIG_BLK_RQ_IO_DATA_LEN
+	rq->io_data_len = 0;
+#endif
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
 	return rq;
@@ -655,6 +658,9 @@ void blk_mq_start_request(struct request *rq)
 
 	trace_block_rq_issue(q, rq);
 
+#ifdef CONFIG_BLK_RQ_IO_DATA_LEN
+	rq->io_data_len = blk_rq_bytes(rq);
+#endif
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
 		rq->io_start_time_ns = ktime_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..bfd34c6a27ef 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -142,6 +142,14 @@ struct request {
 
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
+#ifdef CONFIG_BLK_RQ_IO_DATA_LEN
+	/*
+	 * Total data len at the time of issue. This doesn't get deducted by
+	 * blk_update_request() and can be used by completion path to determine
+	 * the request size.
+	 */
+	unsigned int io_data_len;
+#endif
 	sector_t __sector;		/* sector cursor */
 
 	struct bio *bio;
-- 
2.25.1

