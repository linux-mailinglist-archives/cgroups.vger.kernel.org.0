Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0A6562C5
	for <lists+cgroups@lfdr.de>; Mon, 26 Dec 2022 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiLZNFW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Dec 2022 08:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiLZNFV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Dec 2022 08:05:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD041143
        for <cgroups@vger.kernel.org>; Mon, 26 Dec 2022 05:05:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so10633569pjj.4
        for <cgroups@vger.kernel.org>; Mon, 26 Dec 2022 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nE7yJwFAP/zkGtRmnIRtac0TUO9NfSKJNGcyhbdNgL8=;
        b=EIWRvUG6w6BpGVljPLu29Cqw6SgK7myTN/ND1p0+c2x0VTOiDgEe1nnuW8IEHGfs5o
         W0BQM/QzfWsNhJhfVoh5AJQOEsvEfgLfn17K+ffzcKKYP7gzpffhtP6upvfKzm0pOsVG
         +vYFIjSHnl0LNwf/vKmuzPOMjpU5X0KwYedp7hbO/aAXUCuufM46gia2OGwTZ4ozuPRQ
         AjSsGg9+/TNkFCPdVRNrsqygIblFi2UNP5fLXcqYQZshNfHXhJWDlyBUzez1GTZY64HQ
         YT3gIYPTZTqtIG91CMcLLMVzm0erxIVx+QaDWaPnlN5snLcLmxivoiArUd97keTo8NtD
         1x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE7yJwFAP/zkGtRmnIRtac0TUO9NfSKJNGcyhbdNgL8=;
        b=fWGx3Cm4Pps5mlN9UYjOhL1xu9CZofqwTECbqquyIZpMAY85Bp0ZfV5BixarZ1wDor
         WDV6RShqoF2GMUdsnsVwMuo7GhG2KDZekQeXv6dZq7231MleSPbGwxF9JwbSxjd8UFU4
         zZOPPRpvbfYBXKhrW+TXBNQ2uGhLTLaLHUQ0qc/3F5EGlPmSuMwepuRnMUF9biZYsvxi
         ZfJSaRm/eo4DiW9Hbvub7DqRMeN3FLolskx+wc3WLi9oY9RheIhIkDyakaKcsXH94x8x
         6Y1lYQ/zjdiaHsCy5owkg7S/0IRkg9XLcI/zReM5jhMyEDDtFeZbVZMFyD/zedadpivP
         ZY0Q==
X-Gm-Message-State: AFqh2kosUOtMBlCS9A1TeRw3cfgqGC9KTk0RZmEM5DFyjTQo2SVWxYq0
        uBpL56UaCUalqyiiqIQYTjnfx5YwRi3CrhDTaPo=
X-Google-Smtp-Source: AMrXdXtUvINrZ/n8z0Jp/5N0BXqODp6VXuLXA41j83K8qQeg7cVGSbF3p/54kbFdxLImuG9eQHrFxQ==
X-Received: by 2002:a17:902:ba8e:b0:189:db2b:ac1a with SMTP id k14-20020a170902ba8e00b00189db2bac1amr31991745pls.36.1672059917944;
        Mon, 26 Dec 2022 05:05:17 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b00182d25a1e4bsm7037697plg.259.2022.12.26.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 05:05:17 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v3] blk-throtl: Introduce sync and async queues for blk-throtl
Date:   Mon, 26 Dec 2022 21:05:05 +0800
Message-Id: <20221226130505.7186-1-hanjinke.666@bytedance.com>
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

With this patch, do the same test above, the duration of the fsync sent
by vim drops to several hundreds of milliseconds.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---

Changes in v2
- Make code more simple.
Changes in v3
- Fix mismatch of waiting bio and the next dispatched bio.
- Rename dispatch_sync_cnt to disp_sync_cnt.
- Add more notes.

 block/blk-throttle.c | 135 ++++++++++++++++++++++++++++++++++++++++---
 block/blk-throttle.h |  13 ++++-
 2 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..c4db7873dfa8 100644
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
@@ -88,6 +95,7 @@ struct throtl_data
 };
 
 static void throtl_pending_timer_fn(struct timer_list *t);
+static inline struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn);
 
 static inline struct blkcg_gq *tg_to_blkg(struct throtl_grp *tg)
 {
@@ -241,11 +249,28 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
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
+	qn->disp_sync_cnt = (rw == READ) ? UINT_MAX : 0;
+	qn->next_to_disp = NULL;
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
@@ -261,13 +286,45 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
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
 
+/**
+ * throtl_qnode_bio_peek - peek a bio for a qn
+ * @qn: the qnode to peek from
+ *
+ * For read qn, just peek bio from the SYNC queue and return.
+ * For write qn, we first ask the next_to_disp for bio and will pop a bio
+ * to fill it if it's NULL. The next_to_disp is used to pin the bio for
+ * next to dispatch. It is necessary. In the dispatching  process, a peeked
+ * bio may can't be dispatched due to lack of budget and has to wait, the
+ * dispatching process may give up and the spin lock of the request queue
+ * will be released. New bio may be queued in as the spin lock were released.
+ * When it's time to dispatch the waiting bio, another bio may be selected to
+ * check the limit and may be dispatched. If the dispatched bio is smaller
+ * than the waiting bio, the bandwidth may be hard to satisfied as we may
+ * trim the slice after each dispatch.
+ * So pinning the next_to_disp to make sure that the waiting bio and the
+ * dispatched one later always the same one in case that the spin lock of
+ * queue was released and re-holded.
+ */
+static inline struct bio *throtl_qnode_bio_peek(struct throtl_qnode *qn)
+{
+	/* qn for read ios */
+	if (qn->disp_sync_cnt == UINT_MAX)
+		return bio_list_peek(&qn->bios[SYNC]);
+
+	/* qn for write ios */
+	if (!qn->next_to_disp)
+		qn->next_to_disp  = throtl_qnode_bio_list_pop(qn);
+
+	return qn->next_to_disp;
+}
+
 /**
  * throtl_peek_queued - peek the first bio on a qnode list
  * @queued: the qnode list to peek
@@ -281,11 +338,73 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_peek(&qn->bios);
+	bio = throtl_qnode_bio_peek(qn);
 	WARN_ON_ONCE(!bio);
 	return bio;
 }
 
+/**
+ * throtl_qnode_bio_pop: pop a bio from sync/async queue
+ * @qn: the qnode to pop a bio from
+ *
+ * For write io qn, the target queue to pop was determined by the disp_sync_cnt.
+ * Try to pop bio from target queue, fetch the bio and return it when it is not
+ * empty. If the target queue empty, pop bio from another queue instead.
+ */
+static inline struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn)
+{
+	struct bio *bio;
+	int from = SYNC;
+
+	if (qn->disp_sync_cnt == THROTL_SYNC_FACTOR)
+		from = ASYNC;
+
+	bio = bio_list_pop(&qn->bios[from]);
+	if (!bio) {
+		from = 1 - from;
+		bio = bio_list_pop(&qn->bios[from]);
+	}
+
+	if ((qn->disp_sync_cnt < THROTL_SYNC_FACTOR) &&
+		(from == SYNC))
+		qn->disp_sync_cnt++;
+	else
+		qn->disp_sync_cnt = 0;
+
+	return bio;
+}
+
+/**
+ * throtl_qnode_bio_pop: pop a bio from a qnode
+ * @qn: the qnode to pop a bio from
+ */
+static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
+{
+	struct bio *bio;
+
+	/* qn for read ios */
+	if (qn->disp_sync_cnt == UINT_MAX)
+		return bio_list_pop(&qn->bios[SYNC]);
+
+	/* qn for write ios */
+	if (qn->next_to_disp) {
+		bio = qn->next_to_disp;
+		qn->next_to_disp = NULL;
+		return bio;
+	}
+
+	return throtl_qnode_bio_list_pop(qn);
+}
+
+static inline bool throtl_qnode_empty(struct throtl_qnode *qn)
+{
+	if (!qn->next_to_disp &&
+		bio_list_empty(&qn->bios[SYNC]) &&
+		bio_list_empty(&qn->bios[ASYNC]))
+		return true;
+	return false;
+}
+
 /**
  * throtl_pop_queued - pop the first bio form a qnode list
  * @queued: the qnode list to pop a bio from
@@ -310,10 +429,10 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
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
@@ -355,8 +474,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
 	throtl_service_queue_init(&tg->service_queue);
 
 	for (rw = READ; rw <= WRITE; rw++) {
-		throtl_qnode_init(&tg->qnode_on_self[rw], tg);
-		throtl_qnode_init(&tg->qnode_on_parent[rw], tg);
+		throtl_qnode_init(&tg->qnode_on_self[rw], tg, rw);
+		throtl_qnode_init(&tg->qnode_on_parent[rw], tg, rw);
 	}
 
 	RB_CLEAR_NODE(&tg->rb_node);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987..bd4fff65b6d9 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -28,8 +28,19 @@
  */
 struct throtl_qnode {
 	struct list_head	node;		/* service_queue->queued[] */
-	struct bio_list		bios;		/* queued bios */
+	struct bio_list		bios[2];	/* queued bios */
 	struct throtl_grp	*tg;		/* tg this qnode belongs to */
+
+	struct bio		*next_to_disp;	/* pinned for next to dispatch */
+	/*
+	 * 1) for write throtl_qnode:
+	 * [0, THROTL_SYNC_FACTOR-1]: dispatch sync io
+	 * [THROTL_SYNC_FACTOR]: dispatch async io
+	 *
+	 * 2) for read throtl_qnode:
+	 * UINT_MAX
+	 */
+	unsigned int disp_sync_cnt;         /* sync io dispatch counter */
 };
 
 struct throtl_service_queue {
-- 
2.20.1

