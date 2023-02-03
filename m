Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5A689CA5
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjBCPFD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjBCPFC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:05:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDCFA4292;
        Fri,  3 Feb 2023 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lRMkDwjXETogqKVD0njgXQKT4QGLdzdpZrobtciYzxk=; b=fh7uH0tS+juHPYzOX58KvNo+4D
        I22dIMpyrqcOSJaK6AtUzWy/hphblYXmNGjb6CcaauL2xsnDmRgQHXOQBGCONu6dRr+ZzSCXRbNvz
        Sf6u5yjPReIfi7W07d3X5JqOJooRc3MsOfZOlF0LKm9gGUE8B9PWPzWQIlG7vVG38jDDVVxYnD0Vg
        OrBbWgY24brP/kYQ0Lc8EQK+Vg8LYzWA+ctNCHBceFvhLS/cLPGnCYgkZKwhQPDJybbRj4tNv0tP+
        VlFTT5o5Y1pVNwEQJ/moMq8U7rk41pDM3f1eL//C8700t6U4q5/59O7Qp7NBnwtQ7J/TJqqVK7HyN
        h7RfxZVg==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxcQ-002aEx-VI; Fri, 03 Feb 2023 15:04:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 14/19] blk-rq-qos: constify rq_qos_ops
Date:   Fri,  3 Feb 2023 16:03:55 +0100
Message-Id: <20230203150400.3199230-15-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
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

These op vectors are constant, so mark them const.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c    | 2 +-
 block/blk-iolatency.c | 2 +-
 block/blk-rq-qos.c    | 2 +-
 block/blk-rq-qos.h    | 4 ++--
 block/blk-wbt.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5f28463cba0afe..6f1da7883905b3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2832,7 +2832,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
-static struct rq_qos_ops ioc_rqos_ops = {
+static const struct rq_qos_ops ioc_rqos_ops = {
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
 	.done_bio = ioc_rqos_done_bio,
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 1c394bd77aa0b4..f6aeb3d3fdae59 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -650,7 +650,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	kfree(blkiolat);
 }
 
-static struct rq_qos_ops blkcg_iolatency_ops = {
+static const struct rq_qos_ops blkcg_iolatency_ops = {
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 14bee1bd761362..8e83734cfe8dbc 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -296,7 +296,7 @@ void rq_qos_exit(struct request_queue *q)
 }
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		struct rq_qos_ops *ops)
+		const struct rq_qos_ops *ops)
 {
 	struct request_queue *q = disk->queue;
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 22552785aa31ed..2b7b668479f71a 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -25,7 +25,7 @@ struct rq_wait {
 };
 
 struct rq_qos {
-	struct rq_qos_ops *ops;
+	const struct rq_qos_ops *ops;
 	struct request_queue *q;
 	enum rq_qos_id id;
 	struct rq_qos *next;
@@ -86,7 +86,7 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 }
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		struct rq_qos_ops *ops);
+		const struct rq_qos_ops *ops);
 void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 75565ae2775297..1a78d54c8152b0 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -898,7 +898,7 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 };
 #endif
 
-static struct rq_qos_ops wbt_rqos_ops = {
+static const struct rq_qos_ops wbt_rqos_ops = {
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
 	.track = wbt_track,
-- 
2.39.0

