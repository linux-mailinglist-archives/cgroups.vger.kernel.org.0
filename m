Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9756868672E
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 14:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBANmL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 08:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjBANmD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 08:42:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE434CE7D;
        Wed,  1 Feb 2023 05:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XppORhqACzXr/tYTziTms4imtQlY5N3dyLLJTn5U4h0=; b=gS0IyX2ODrvyKlDI6hqlp5xTS8
        y2pKrxbY6RrBjs1nWaxr58+1EgxXSflVkNc/r+RSV+KWP/lrhqZ2fa6U9CjjaOPOC10SNWqXfBla3
        FVPn3mY2a737PhMxlq1gGTY3JqphGSiYZ+XwzqEvQ7/e3ufivF9cvIuXXSJ6gBOCUxD4taDHTQGOw
        AjEpdaWkwkHLiRvEWv0Qlhl7FomQgU154aPKZeknr2d7xxZz2HaqNvWtLTMsHlCImWaGjexXAot/C
        0m3IHBDx0wNf3taw28Yo59PWsLkHCzh3AwC7gVduAlOd3K9hVzAq1KvG5PH/fCJLFJtR9+6dgyM8T
        uv1tpNcw==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDN4-00C7XK-AR; Wed, 01 Feb 2023 13:41:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 10/19] blk-wbt: move private information from blk-wbt.h to blk-wbt.c
Date:   Wed,  1 Feb 2023 14:41:14 +0100
Message-Id: <20230201134123.2656505-11-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A large part of blk-wbt.h is only used in blk-wbt.c, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c |  1 +
 block/blk-sysfs.c    |  1 +
 block/blk-wbt.c      | 77 +++++++++++++++++++++++++++++++++++++++
 block/blk-wbt.h      | 86 --------------------------------------------
 4 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9c9713c9269cc4..896b4654ab00fa 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 
 #include "blk.h"
+#include "blk-rq-qos.h"
 #include "blk-wbt.h"
 
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c2adf640e5c816..d70ebecb534798 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -16,6 +16,7 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
+#include "blk-rq-qos.h"
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 542271fa99e8f7..58f41a98fda911 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -25,6 +25,7 @@
 #include <linux/backing-dev.h>
 #include <linux/swap.h>
 
+#include "blk-stat.h"
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
 #include "elevator.h"
@@ -32,6 +33,72 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
 
+enum wbt_flags {
+	WBT_TRACKED		= 1,	/* write, tracked for throttling */
+	WBT_READ		= 2,	/* read */
+	WBT_KSWAPD		= 4,	/* write, from kswapd */
+	WBT_DISCARD		= 8,	/* discard */
+
+	WBT_NR_BITS		= 4,	/* number of bits */
+};
+
+enum {
+	WBT_RWQ_BG		= 0,
+	WBT_RWQ_KSWAPD,
+	WBT_RWQ_DISCARD,
+	WBT_NUM_RWQ,
+};
+
+/*
+ * If current state is WBT_STATE_ON/OFF_DEFAULT, it can be covered to any other
+ * state, if current state is WBT_STATE_ON/OFF_MANUAL, it can only be covered
+ * to WBT_STATE_OFF/ON_MANUAL.
+ */
+enum {
+	WBT_STATE_ON_DEFAULT	= 1,	/* on by default */
+	WBT_STATE_ON_MANUAL	= 2,	/* on manually by sysfs */
+	WBT_STATE_OFF_DEFAULT	= 3,	/* off by default */
+	WBT_STATE_OFF_MANUAL	= 4,	/* off manually by sysfs */
+};
+
+struct rq_wb {
+	/*
+	 * Settings that govern how we throttle
+	 */
+	unsigned int wb_background;		/* background writeback */
+	unsigned int wb_normal;			/* normal writeback */
+
+	short enable_state;			/* WBT_STATE_* */
+
+	/*
+	 * Number of consecutive periods where we don't have enough
+	 * information to make a firm scale up/down decision.
+	 */
+	unsigned int unknown_cnt;
+
+	u64 win_nsec;				/* default window size */
+	u64 cur_win_nsec;			/* current window size */
+
+	struct blk_stat_callback *cb;
+
+	u64 sync_issue;
+	void *sync_cookie;
+
+	unsigned int wc;
+
+	unsigned long last_issue;		/* last non-throttled issue */
+	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long min_lat_nsec;
+	struct rq_qos rqos;
+	struct rq_wait rq_wait[WBT_NUM_RWQ];
+	struct rq_depth rq_depth;
+};
+
+static inline struct rq_wb *RQWB(struct rq_qos *rqos)
+{
+	return container_of(rqos, struct rq_wb, rqos);
+}
+
 static inline void wbt_clear_state(struct request *rq)
 {
 	rq->wbt_flags = 0;
@@ -226,6 +293,16 @@ static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
 	return now - issue;
 }
 
+static inline unsigned int wbt_inflight(struct rq_wb *rwb)
+{
+	unsigned int i, ret = 0;
+
+	for (i = 0; i < WBT_NUM_RWQ; i++)
+		ret += atomic_read(&rwb->rq_wait[i].inflight);
+
+	return ret;
+}
+
 enum {
 	LAT_OK = 1,
 	LAT_UNKNOWN,
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index b673da41a867d3..ba6cca5849a655 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -2,92 +2,6 @@
 #ifndef WB_THROTTLE_H
 #define WB_THROTTLE_H
 
-#include <linux/kernel.h>
-#include <linux/atomic.h>
-#include <linux/wait.h>
-#include <linux/timer.h>
-#include <linux/ktime.h>
-
-#include "blk-stat.h"
-#include "blk-rq-qos.h"
-
-enum wbt_flags {
-	WBT_TRACKED		= 1,	/* write, tracked for throttling */
-	WBT_READ		= 2,	/* read */
-	WBT_KSWAPD		= 4,	/* write, from kswapd */
-	WBT_DISCARD		= 8,	/* discard */
-
-	WBT_NR_BITS		= 4,	/* number of bits */
-};
-
-enum {
-	WBT_RWQ_BG		= 0,
-	WBT_RWQ_KSWAPD,
-	WBT_RWQ_DISCARD,
-	WBT_NUM_RWQ,
-};
-
-/*
- * If current state is WBT_STATE_ON/OFF_DEFAULT, it can be covered to any other
- * state, if current state is WBT_STATE_ON/OFF_MANUAL, it can only be covered
- * to WBT_STATE_OFF/ON_MANUAL.
- */
-enum {
-	WBT_STATE_ON_DEFAULT	= 1,	/* on by default */
-	WBT_STATE_ON_MANUAL	= 2,	/* on manually by sysfs */
-	WBT_STATE_OFF_DEFAULT	= 3,	/* off by default */
-	WBT_STATE_OFF_MANUAL	= 4,	/* off manually by sysfs */
-};
-
-struct rq_wb {
-	/*
-	 * Settings that govern how we throttle
-	 */
-	unsigned int wb_background;		/* background writeback */
-	unsigned int wb_normal;			/* normal writeback */
-
-	short enable_state;			/* WBT_STATE_* */
-
-	/*
-	 * Number of consecutive periods where we don't have enough
-	 * information to make a firm scale up/down decision.
-	 */
-	unsigned int unknown_cnt;
-
-	u64 win_nsec;				/* default window size */
-	u64 cur_win_nsec;			/* current window size */
-
-	struct blk_stat_callback *cb;
-
-	u64 sync_issue;
-	void *sync_cookie;
-
-	unsigned int wc;
-
-	unsigned long last_issue;		/* last non-throttled issue */
-	unsigned long last_comp;		/* last non-throttled comp */
-	unsigned long min_lat_nsec;
-	struct rq_qos rqos;
-	struct rq_wait rq_wait[WBT_NUM_RWQ];
-	struct rq_depth rq_depth;
-};
-
-static inline struct rq_wb *RQWB(struct rq_qos *rqos)
-{
-	return container_of(rqos, struct rq_wb, rqos);
-}
-
-static inline unsigned int wbt_inflight(struct rq_wb *rwb)
-{
-	unsigned int i, ret = 0;
-
-	for (i = 0; i < WBT_NUM_RWQ; i++)
-		ret += atomic_read(&rwb->rq_wait[i].inflight);
-
-	return ret;
-}
-
-
 #ifdef CONFIG_BLK_WBT
 
 int wbt_init(struct gendisk *disk);
-- 
2.39.0

