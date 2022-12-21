Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF45652FBF
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLUKnE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Dec 2022 05:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLUKnA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Dec 2022 05:43:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B0E6B
        for <cgroups@vger.kernel.org>; Wed, 21 Dec 2022 02:42:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k79so10391703pfd.7
        for <cgroups@vger.kernel.org>; Wed, 21 Dec 2022 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXjeVHBjgltp+/cJKno9ptSj0CNQ0nCLFPpP59WHeTg=;
        b=v2cmregMrOgOmaHu3rRG6LJSTP80ziH9u8gUdncnLU79cFiheMn2QQheiuo3ocdciu
         MoE7g+CJ6bnGGTrRdEfJ1DOWfANVEQ0wOVgz6esUHbzhcBt57qEtkghDqYw5C5K0ax4q
         Ex+Q+PBasUjQmEPgCtc7LwDSNazovn2cFMY8LLJ3WdjzhvtECGxD2Cnio5A7278uXSty
         X6VUExuPNhGkYVotqXKqymLbxbDCqavFKx5vMWL+PjyeSEobhwVm4uEt0iDGeJHnvsjE
         J9SWzOUy6OPC7wqZLlEBLHpLo0vOdh5C0oGqDpEKfCH2HFK3t+HuMJflxn7f7IkqwEPX
         bAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXjeVHBjgltp+/cJKno9ptSj0CNQ0nCLFPpP59WHeTg=;
        b=6d0w7hjVpiXme+FaY7i/+uT/wrgpNV9d7huz3bLEL5MGQ0GjC8/LPXC7gYoR2U/Ihv
         Hyne9BDZqxf6qcujruZc1LBFfyZ/wYNR+8EJ0O+g5BjznNs0g4rze+K3QorkW5SVWfa7
         otjc397/vt3F8lJln9bFssMl1XtZHHCyrwFMO0zPsgTHia6gPX3dfBrbXXpvrUSDhmAT
         FG4ouTZKB2gNf0OJ34iCCbzr4qZ8LxUkCFeN+hSQumZT7rsIO9a1AFR1uS4awS9NaBTa
         NWWGPL2kucZPlmMcVBPil6M7v1LpXZ24MnjnqiDlk+Nx8I5IhqyS6ggmprBgq7i+HOZN
         22LA==
X-Gm-Message-State: AFqh2kocjeYVsFNBNmOokxMo3oJLc+vAcr+fpWTRMYIFb7hbHV7JyD+k
        l35kUEfKYGGXmnTzB16KOzwaIA==
X-Google-Smtp-Source: AMrXdXvVQfDhNobuiWiV0jGOoH6nE3BdmpChsGX9GzVDDQ5O8riwb3fnkQyQ5VOCtjokG5LprMgrmQ==
X-Received: by 2002:a62:2903:0:b0:57f:f2cd:6180 with SMTP id p3-20020a622903000000b0057ff2cd6180mr2006841pfp.0.1671619377258;
        Wed, 21 Dec 2022 02:42:57 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm10243469pfl.206.2022.12.21.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:42:56 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v2] blk-throtl: Introduce sync and async queues for blk-throtl
Date:   Wed, 21 Dec 2022 18:42:46 +0800
Message-Id: <20221221104246.37714-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221218111314.55525-1-hanjinke.666@bytedance.com>
References: <20221218111314.55525-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=ham
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

This patch splits bio queue into sync and async queues for blk-throtl
and gives a huge priority to sync write ios. Sync queue only make sense
for write ios as we treat all read io as sync io. I think it's a nice
respond to the semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO
gains the same priority as they are important to fs. This may avoid
some potential priority inversion problems.

With this patch, do the same test above, the duration of the fsync sent
by vim drops to servral hundreds of milliseconds.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---

Changes in v2:
- Make the code more simple

 block/blk-throttle.c | 105 +++++++++++++++++++++++++++++++++++++++----
 block/blk-throttle.h |  12 ++++-
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..f3285c7da9f7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -21,6 +21,13 @@
 /* Total max dispatch from all groups in one round */
 #define THROTL_QUANTUM 32
 
+/* For write ios, dispatch 4 sync ios and 1 normal io in one loop */
+#define THROTL_SYNC_FACTOR 4
+
+/* Only make sense for write ios, all read ios are treated as SYNC */
+#define SYNC	0
+#define ASYNC	1
+
 /* Throttling is performed over a slice and after that slice is renewed */
 #define DFL_THROTL_SLICE_HD (HZ / 10)
 #define DFL_THROTL_SLICE_SSD (HZ / 50)
@@ -241,11 +248,27 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
 	return bio->bi_iter.bi_size;
 }
 
-static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
+static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg,
+			      bool rw)
 {
 	INIT_LIST_HEAD(&qn->node);
-	bio_list_init(&qn->bios);
+	bio_list_init(&qn->bios[SYNC]);
+	bio_list_init(&qn->bios[ASYNC]);
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
+	if ((rw == READ) || BLK_THROTL_SYNC(bio))
+		bio_list_add(&qn->bios[SYNC], bio);
+	else
+		bio_list_add(&qn->bios[ASYNC], bio);
 }
 
 /**
@@ -261,13 +284,34 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
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
+	struct bio *bio;
+	int from = SYNC;
+
+	/* qn for read ios */
+	if (qn->dispatch_sync_cnt == UINT_MAX)
+		return bio_list_peek(&qn->bios[from]);
+
+	/* qn for write ios */
+	if (qn->dispatch_sync_cnt == THROTL_SYNC_FACTOR)
+		from = ASYNC;
+	bio = bio_list_peek(&qn->bios[from]);
+	if (!bio) {
+		from = 1 - from;
+		bio = bio_list_peek(&qn->bios[from]);
+	}
+
+	return bio;
+}
+
 /**
  * throtl_peek_queued - peek the first bio on a qnode list
  * @queued: the qnode list to peek
@@ -281,11 +325,56 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_peek(&qn->bios);
+	bio = throtl_qnode_bio_peek(qn);
 	WARN_ON_ONCE(!bio);
 	return bio;
 }
 
+/**
+ * throtl_qnode_bio_pop: pop a bio from a qnode
+ * @qn: the qnode to pop a bio from
+ *
+ * For read io qn, just pop bio from sync queue and return.
+ * For write io qn, the target queue to pop was determined by the dispatch_sync_cnt.
+ * Try to pop bio from target queue, fetch the bio and return when it is not empty.
+ * If the target queue empty, pop bio from other queue instead.
+ */
+static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
+{
+	struct bio *bio;
+	int from = SYNC;
+
+	/* qn for read ios */
+	if (qn->dispatch_sync_cnt == UINT_MAX)
+		return bio_list_pop(&qn->bios[from]);
+
+	/* qn for write ios */
+	if (qn->dispatch_sync_cnt == THROTL_SYNC_FACTOR)
+		from = ASYNC;
+
+	bio = bio_list_pop(&qn->bios[from]);
+	if (!bio) {
+		from = 1 - from;
+		bio = bio_list_pop(&qn->bios[from]);
+	}
+
+	if ((qn->dispatch_sync_cnt < THROTL_SYNC_FACTOR) &&
+		(from == SYNC))
+		qn->dispatch_sync_cnt++;
+	else if (from == ASYNC)
+		qn->dispatch_sync_cnt = 0;
+
+	return bio;
+}
+
+static inline bool throtl_qnode_empty(struct throtl_qnode *qn)
+{
+	if (bio_list_empty(&qn->bios[SYNC]) &&
+		bio_list_empty(&qn->bios[ASYNC]))
+		return true;
+	return false;
+}
+
 /**
  * throtl_pop_queued - pop the first bio form a qnode list
  * @queued: the qnode list to pop a bio from
@@ -310,10 +399,10 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_pop(&qn->bios);
+	bio = throtl_qnode_bio_pop(qn);
 	WARN_ON_ONCE(!bio);
 
-	if (bio_list_empty(&qn->bios)) {
+	if (throtl_qnode_empty(qn)) {
 		list_del_init(&qn->node);
 		if (tg_to_put)
 			*tg_to_put = qn->tg;
@@ -355,8 +444,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
 	throtl_service_queue_init(&tg->service_queue);
 
 	for (rw = READ; rw <= WRITE; rw++) {
-		throtl_qnode_init(&tg->qnode_on_self[rw], tg);
-		throtl_qnode_init(&tg->qnode_on_parent[rw], tg);
+		throtl_qnode_init(&tg->qnode_on_self[rw], tg, rw);
+		throtl_qnode_init(&tg->qnode_on_parent[rw], tg, rw);
 	}
 
 	RB_CLEAR_NODE(&tg->rb_node);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987..55f3a9594e0d 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -28,8 +28,18 @@
  */
 struct throtl_qnode {
 	struct list_head	node;		/* service_queue->queued[] */
-	struct bio_list		bios;		/* queued bios */
+	struct bio_list		bios[2];	/* queued bios */
 	struct throtl_grp	*tg;		/* tg this qnode belongs to */
+
+	/*
+	 * 1) for write throtl_qnode:
+	 * [0, THROTL_SYNC_FACTOR-1]: dispatch sync io
+	 * [THROTL_SYNC_FACTOR]: dispatch async io
+	 *
+	 * 2) for read throtl_qnode:
+	 * UINT_MAX
+	 */
+	unsigned int dispatch_sync_cnt;         /* sync io dispatch counter */
 };
 
 struct throtl_service_queue {
-- 
2.20.1

