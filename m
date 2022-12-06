Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB255644983
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiLFQk1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 11:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiLFQkG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 11:40:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE485FF1
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 08:38:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 130so15005266pfu.8
        for <cgroups@vger.kernel.org>; Tue, 06 Dec 2022 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvhqGNfZHYPrNa3BihNBSaEDPogspIa8w2pPkMm+z9Y=;
        b=5kEW4tl4dXzh85X9h0gAg4N74pmIpxh0Oyj+nknU8RDMjTS2hC00RFqyTfR3bctz8d
         Ix0Ic8jdeHaS11ZknOTJ4sglufgXHfwR/ozN58VujUWxlWp8e+wrAdqIHseAqUXZp+M2
         5vczzJ4clCL+K21DLGvv77piA371kOmuLkGm4Z6CnuvGEZg3TUDqIa1kAPP/Q11fsBvh
         OkpAFrWSLxdHT3yhwF3Q4vIh8OuxDF6NnehUMRWj6Rz1kD8rhKapjuAx+7f9c/tEPMby
         09XpzDFfBvBOt6BtCcznunT0+G452Dobqs90OYPyBuDilHQ5+gLfVjf3iCL0BiCwN1w0
         KQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvhqGNfZHYPrNa3BihNBSaEDPogspIa8w2pPkMm+z9Y=;
        b=vwNfDoWgeDuor/7YCKMSHmqh8Qtw0yPh/PJ+zHOs+eJfwGRlCwmxTRn2eGLEkHCj1t
         98Oq8FP8FKrOe+mW19UvSsL0eERWIkztclaXV/mLcyB+pj1lcQCy2FXyu3dqSBJfDNL/
         WVenIwfMwYAlR4or1guEE6zmODVb8iDyhLn9bLseq4dV4y6XBgK23BkQZPnUg3pNBELN
         SBfK3QQzxjiteCPBk5THAxhmt0cJBwpYghNBXtkXg2LX38BE+K/4tnpT7A3OSU1y7rg+
         nNY8l3r2PFm9L38dC/QyN96x9u1ejAovTrtT/Sgx0zZieGSOMr9lV3Z0OKl4PEE6Y978
         c4hA==
X-Gm-Message-State: ANoB5pmGWAIy+ZqWQAg1c9umP6+MHg688t9md+f5g4j1THDNBpJEBu62
        AANfQZnKmGb3xN8HO7nJ18jY3GMF4j3ky543
X-Google-Smtp-Source: AA0mqf7xyEC0ye0/AJmWdBBERYgOG0Vikwb2T83f0kna8CNsKHH8XVNAGmMbR/bmVW6zqSOcz9DM+Q==
X-Received: by 2002:a05:6a00:d66:b0:56a:fd45:d054 with SMTP id n38-20020a056a000d6600b0056afd45d054mr76941698pfv.3.1670344724899;
        Tue, 06 Dec 2022 08:38:44 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 3-20020a631543000000b0044ed37dbca8sm10102407pgv.2.2022.12.06.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:38:44 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [RFC PATCH] blk-throtl: Introduce sync queue for write ios
Date:   Wed,  7 Dec 2022 00:38:26 +0800
Message-Id: <20221206163826.10700-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

Now we don't distinguish sync write ios from normal buffer write ios
in blk-throtl. A bio with REQ_SYNC tagged always mean it will be wait
until write completion soon after it submit. So it's reasonable for sync
io to complete as soon as possible.

In our test, fio writes a 100g file in sequential 4k blocksize in
a container with low bps limit configured (wbps=10M). More than 1200
ios were throttled in blk-throtl queue and the avarage throtle time
of each io is 140s. At the same time, the operation of saving a small
file by vim will be blocked amolst 140s. As a fsync will be send by vim,
the sync ios of fsync will be blocked by a huge amount of buffer write
ios ahead. This is also a priority inversion problem within one cgroup.
In the database scene, things got really bad with blk-throtle enabled
as fsync is called very often.

This patch introduces a independent sync queue for write ios and gives
a huge priority to sync write ios. I think it's a nice respond to the
semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO gains the same
priority as they are important to fs. This may avoid some potential
priority inversion problems.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-throttle.c | 83 ++++++++++++++++++++++++++++++++++++++++----
 block/blk-throttle.h |  9 ++++-
 2 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..5d290fb95f5a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -21,6 +21,9 @@
 /* Total max dispatch from all groups in one round */
 #define THROTL_QUANTUM 32
 
+/* For write ios, dispatch 4 sync ios and 1 normal io in one loop */
+#define THROTL_SYNC_FACTOR 4
+
 /* Throttling is performed over a slice and after that slice is renewed */
 #define DFL_THROTL_SLICE_HD (HZ / 10)
 #define DFL_THROTL_SLICE_SSD (HZ / 50)
@@ -241,11 +244,27 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
 	return bio->bi_iter.bi_size;
 }
 
-static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
+static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg,
+			      bool rw)
 {
 	INIT_LIST_HEAD(&qn->node);
 	bio_list_init(&qn->bios);
+	bio_list_init(&qn->sync_bios);
 	qn->tg = tg;
+	qn->dispatch_sync_cnt = (rw == READ) ? UINT_MAX : 0;
+}
+
+#define BLK_THROTL_SYNC(bio) (bio->bi_opf & (REQ_SYNC | REQ_META | REQ_PRIO))
+
+static inline void throtl_qnode_add_bio_list(struct throtl_qnode *qn,
+					     struct bio *bio)
+{
+	bool rw = bio_data_dir(bio);
+
+	if ((rw == WRITE) && (BLK_THROTL_SYNC(bio)))
+		bio_list_add(&qn->sync_bios, bio);
+	else
+		bio_list_add(&qn->bios, bio);
 }
 
 /**
@@ -261,13 +280,34 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
 static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 				 struct list_head *queued)
 {
-	bio_list_add(&qn->bios, bio);
+	throtl_qnode_add_bio_list(qn, bio);
 	if (list_empty(&qn->node)) {
 		list_add_tail(&qn->node, queued);
 		blkg_get(tg_to_blkg(qn->tg));
 	}
 }
 
+static inline struct bio *throtl_qnode_bio_peek(struct throtl_qnode *qn)
+{
+	struct bio *bio1, *bio2;
+
+	/* qn for read ios */
+	if (qn->dispatch_sync_cnt == UINT_MAX)
+		return bio_list_peek(&qn->bios);
+
+	/* qn for write ios */
+	bio1 = bio_list_peek(&qn->bios);
+	bio2 = bio_list_peek(&qn->sync_bios);
+
+	if (bio1 && bio2) {
+		if (qn->dispatch_sync_cnt == THROTL_SYNC_FACTOR)
+			return bio1;
+		return bio2;
+	}
+
+	return bio1 ?: bio2;
+}
+
 /**
  * throtl_peek_queued - peek the first bio on a qnode list
  * @queued: the qnode list to peek
@@ -281,11 +321,42 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_peek(&qn->bios);
+	bio = throtl_qnode_bio_peek(qn);
 	WARN_ON_ONCE(!bio);
 	return bio;
 }
 
+static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
+{
+	struct bio *bio;
+
+	/* qn for read ios */
+	if (qn->dispatch_sync_cnt == UINT_MAX)
+		return bio_list_pop(&qn->bios);
+
+	/* try to dispatch sync io */
+	if (qn->dispatch_sync_cnt < THROTL_SYNC_FACTOR) {
+		bio = bio_list_pop(&qn->sync_bios);
+		if (bio) {
+			qn->dispatch_sync_cnt++;
+			return bio;
+		}
+		bio = bio_list_pop(&qn->bios);
+		qn->dispatch_sync_cnt = 0;
+		return bio;
+	}
+
+	/* try to dispatch normal io */
+	bio = bio_list_pop(&qn->bios);
+	if (bio) {
+		qn->dispatch_sync_cnt = 0;
+		return bio;
+	}
+	bio = bio_list_pop(&qn->sync_bios);
+
+	return bio;
+}
+
 /**
  * throtl_pop_queued - pop the first bio form a qnode list
  * @queued: the qnode list to pop a bio from
@@ -310,7 +381,7 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_pop(&qn->bios);
+	bio = throtl_qnode_bio_pop(qn);
 	WARN_ON_ONCE(!bio);
 
 	if (bio_list_empty(&qn->bios)) {
@@ -355,8 +426,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
 	throtl_service_queue_init(&tg->service_queue);
 
 	for (rw = READ; rw <= WRITE; rw++) {
-		throtl_qnode_init(&tg->qnode_on_self[rw], tg);
-		throtl_qnode_init(&tg->qnode_on_parent[rw], tg);
+		throtl_qnode_init(&tg->qnode_on_self[rw], tg, rw);
+		throtl_qnode_init(&tg->qnode_on_parent[rw], tg, rw);
 	}
 
 	RB_CLEAR_NODE(&tg->rb_node);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987..6a857c9420f9 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -28,8 +28,15 @@
  */
 struct throtl_qnode {
 	struct list_head	node;		/* service_queue->queued[] */
-	struct bio_list		bios;		/* queued bios */
+	struct bio_list		bios;		/* queued normal bios */
+	struct bio_list		sync_bios;	/* queued sync write bios */
 	struct throtl_grp	*tg;		/* tg this qnode belongs to */
+
+	/*
+	 * [0, THROTL_SYNC_FACTOR-1] dispatch sync io, THROTL_SYNC_FACTOR
+	 * dispatch normal io
+	 */
+	unsigned int dispatch_sync_cnt;         /* sync io dispatch counter */
 };
 
 struct throtl_service_queue {
-- 
2.20.1

