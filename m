Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B564FE9B
	for <lists+cgroups@lfdr.de>; Sun, 18 Dec 2022 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiLRLNf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLRLNb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 06:13:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D45FCE
        for <cgroups@vger.kernel.org>; Sun, 18 Dec 2022 03:13:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l10so6451148plb.8
        for <cgroups@vger.kernel.org>; Sun, 18 Dec 2022 03:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj58fIt+qJydCfyNzVeCHORGcPLQ9XK7V8aCuX3pXug=;
        b=5a1eXguRdAGVjYb/NPWQ9Ytpxe5kmDCVYyojCgvvb83+9XeovdU6lB6nvW8a+0tMAd
         NcUL9eaH5VQERezbLbZW4zBj70WRQSWu9d56z4MsVXEIlhGL2nrIEUK3LeiGrWuo+DpK
         tpQ2QZ2H8OXv+i4kPX7oJ5Gc+LAkJuUY9w4nOyMZa2NlO5KuHoBVFz2mVRutkjiT+JMQ
         DDkayo4nsPlJErSwX+YNpfao+UqQyyA24b9o1ed2dIiBmFIoyz6Kb1nIghxfc92RZj4j
         L6kIHMxbDTPV4vY3YUCtN+pRi0g4wYToUpUQ0c47WJAiKNcyQNdnkXoCo7/yFP76DIdk
         COcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bj58fIt+qJydCfyNzVeCHORGcPLQ9XK7V8aCuX3pXug=;
        b=voxoHLoIxQ1zBFqItzgK7y/UzH7Zz4MjSZhinDENuL4B/W+oOi3gDlFwtZUWfUjx18
         t31rb8a/7OZ99piBRWGx5LR67WXlqbKcnfJnijCVMJKcz8XlHvNTGpL0ccEXieoWchFZ
         gS9srxxidg8MHP/BodJkAoRPZJcU8fjgn3M0i7+e7FBbZfjw3PU+4oE14mSdHmMccUP5
         BZpVKgwFxyqKCfa4U5clF03mj4M6WbiJFE5zKh1WCz/RQbdH1BGp2bM6VOocG+i6Uis+
         T//k5b1I9DW6l+BhF23LZfW7AnZWNYB5uO3lIEIV1ZdmQANH1nGc9/QL2bLQ2xTFH9Ec
         97Rw==
X-Gm-Message-State: AFqh2kpmPUp8rPnCZYlmRptLTMwb12IoGkGH9MHi+39uWM3gt/lKqiMo
        VrWwBAJI02CkvB1Z0xFPjwNptg==
X-Google-Smtp-Source: AMrXdXtBJ3f5/hcS5KH8J4TUZSeF7LgpX1tc9Z/zVcLXR1oDs/v2wQ1IrHxLolGz5FsJOAfNFTEb5A==
X-Received: by 2002:a05:6a20:2d8f:b0:b0:2070:2ef5 with SMTP id bf15-20020a056a202d8f00b000b020702ef5mr2606422pzb.22.1671362008699;
        Sun, 18 Dec 2022 03:13:28 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id x21-20020a63fe55000000b0043c22e926f8sm4227235pgj.84.2022.12.18.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:13:28 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] blk-throtl: Introduce sync and async queues for blk-throtl
Date:   Sun, 18 Dec 2022 19:13:14 +0800
Message-Id: <20221218111314.55525-1-hanjinke.666@bytedance.com>
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

This patch splits bio queue into sync and async queues for blk-throtl
and gives a huge priority to sync write ios. Sync queue only make sense
for write ios as we treat all read io as sync io. I think it's a nice
respond to the semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO
gains the same priority as they are important to fs. This may avoid
some potential priority inversion problems.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 block/blk-throttle.c | 108 +++++++++++++++++++++++++++++++++++++++----
 block/blk-throttle.h |  12 ++++-
 2 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..57acfae9f820 100644
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
+	struct bio *bio1, *bio2;
+
+	/* qn for read ios */
+	if (qn->dispatch_sync_cnt == UINT_MAX)
+		return bio_list_peek(&qn->bios[SYNC]);
+
+	/* qn for write ios */
+	bio1 = bio_list_peek(&qn->bios[SYNC]);
+	bio2 = bio_list_peek(&qn->bios[ASYNC]);
+
+	if (bio1 && bio2) {
+		if (qn->dispatch_sync_cnt == THROTL_SYNC_FACTOR)
+			return bio2;
+		return bio1;
+	}
+
+	return bio1 ?: bio2;
+}
+
 /**
  * throtl_peek_queued - peek the first bio on a qnode list
  * @queued: the qnode list to peek
@@ -281,11 +325,59 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
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
+ * For read io qn, just pop bio from sync queu and return.
+ * For write io qn, the target queue to pop was determined by the dispatch_sync_cnt.
+ * Try to pop bio from target queue, fetch the bio and return when it is not empty.
+ * If the target queue empty, pop bio from other queue instead.
+ */
+static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
+{
+	struct bio *bio;
+
+	/* qn for read ios */
+	if (qn->dispatch_sync_cnt == UINT_MAX)
+		return bio_list_pop(&qn->bios[SYNC]);
+
+	/* try to dispatch sync io */
+	if (qn->dispatch_sync_cnt < THROTL_SYNC_FACTOR) {
+		bio = bio_list_pop(&qn->bios[SYNC]);
+		if (bio) {
+			qn->dispatch_sync_cnt++;
+			return bio;
+		}
+		bio = bio_list_pop(&qn->bios[ASYNC]);
+		qn->dispatch_sync_cnt = 0;
+		return bio;
+	}
+
+	/* try to dispatch async io */
+	bio = bio_list_pop(&qn->bios[ASYNC]);
+	if (bio) {
+		qn->dispatch_sync_cnt = 0;
+		return bio;
+	}
+	bio = bio_list_pop(&qn->bios[SYNC]);
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
@@ -310,10 +402,10 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
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
@@ -355,8 +447,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
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

