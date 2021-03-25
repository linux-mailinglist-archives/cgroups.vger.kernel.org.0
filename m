Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4134899D
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCYG6S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCYG6I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F12C06174A;
        Wed, 24 Mar 2021 23:58:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h3so1025584pfr.12;
        Wed, 24 Mar 2021 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hPH8DsECt5xnwFiwZHAUQb2WmzQbShnA545eG6/RNz0=;
        b=pMLWKUf1N40MVt0ryRnco5Yj9BGvy7Ncfvog0V1iIoT0pvsd7aHSkYh9c23lQRGTPt
         /Mu3GQo43nXXR+5WbJL3d9+ocRfBun29XfCLAHOzWzhkg/2eD/uVqiaJ5yFbS1ExerNO
         rbQ4AcH18A1zNagwBlVS6/fFFs5DcX3uRZee8xyVOHgVpngsi0Y4nwwdpEbeHCcXwnl0
         Js8hfcpxKnZgfgDPj3GDuYTT05Q7o4r5bg7iOCoqUw4ammVL6UTzdsTtImFgfwgwOxgc
         w8QNYfIWT5WzrmcHmVJLIyXjrCPhNJA1HkjFGIyWJzRuRskIedLtmtTTOZcwxUCaNxxT
         GNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hPH8DsECt5xnwFiwZHAUQb2WmzQbShnA545eG6/RNz0=;
        b=YtsXiZFl87YQccDRoKqpgpQKAfb33fXc8gz6NpK9tBiegYuw0p8AHJAjyZKDRseEi4
         8WCKpIuLlYuS5PIBDw6fKLy8wyFKVYK/PYLKMZLBHMFJoS1zatUKVD3z9uz9g4q9z0tP
         vzrd3H7QisvUEKtHLRZy7n6pch/Sd7QaAzD5R8TqQCuDNPzV61poDrovWM4mDsG9d7ZD
         XfwJA3k6ky+8BQnzf27aKYnJznx0I6MQwm0FYVILZgGJYBzVxyNr8bSEAvU2gPdlqE12
         CaUy+Ofs0Y195JxkgEQuRCrBxHxoH3RpKdlFzv5WI2nCXJAApsPUnOoEb3vnIqCMEnAj
         eWpw==
X-Gm-Message-State: AOAM533FX/H0hu/SMNauRemJOWGpUc+BTSHEz4UUHPXGu5YG7S8wnrX+
        ntR2ObqU0DnbTn+Od5GwNYc=
X-Google-Smtp-Source: ABdhPJyjg3BKIMX5Ah1ZDp7pmvIQU9Udkb/a3/jJpJGjyu6AkkIiAQlxERoIH//+FcGW9e/86DtkKg==
X-Received: by 2002:a62:f207:0:b029:1f6:11a4:1b81 with SMTP id m7-20020a62f2070000b02901f611a41b81mr6769926pfh.19.1616655487803;
        Wed, 24 Mar 2021 23:58:07 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:07 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] bfq: introduce bfq_ioprio_class to get ioprio class
Date:   Thu, 25 Mar 2021 14:57:48 +0800
Message-Id: <fd37b831bf65c2048047441ffeacd3494ab73224.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since the tasks inside the container itself have different
ioprio, in order to be compatible with the actual production
environment, when scheduling within a group, we use the task
ioprio class, but outside the group, we use the group ioprio
class. For example, when counting busy_queues, tasks from
the CLASS_IDLE group, regardless of their ioprio, are always
treated as CLASS_IDLE tasks.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 29 ++++++++++++++++++++++++++---
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    |  4 ++--
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ec482e6..5f7a0cc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -428,7 +428,30 @@ void bfq_schedule_dispatch(struct bfq_data *bfqd)
 	}
 }
 
-#define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
+unsigned short bfq_ioprio_class(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	unsigned short class = BFQ_DEFAULT_GRP_CLASS;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_group *bfqg;
+
+	if (bfqq) {
+		bfqg = bfqq_group(bfqq);
+		class = bfqg->ioprio_class?:bfqq->ioprio_class;
+	} else {
+		bfqg = bfq_entity_to_bfqg(entity);
+		class = bfqg->ioprio_class?:BFQ_DEFAULT_GRP_CLASS;
+	}
+#else
+	if (bfqq)
+		class = bfqq->ioprio_class;
+#endif
+	return class;
+}
+
+#define bfq_class(bfq)		(bfq_ioprio_class(&bfq->entity))
+#define bfq_class_rt(bfq)	(bfq_ioprio_class(&bfq->entity) == IOPRIO_CLASS_RT)
+#define bfq_class_idle(bfq)	(bfq_ioprio_class(&bfq->entity) == IOPRIO_CLASS_IDLE)
 
 #define bfq_sample_valid(samples)	((samples) > 80)
 
@@ -1635,7 +1658,7 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 {
 	int bfqq_weight, in_serv_weight;
 
-	if (bfqq->ioprio_class < in_serv_bfqq->ioprio_class)
+	if (bfq_class(bfqq) < bfq_class(in_serv_bfqq))
 		return true;
 
 	if (in_serv_bfqq->entity.parent == bfqq->entity.parent) {
@@ -2600,7 +2623,7 @@ static bool bfq_may_be_close_cooperator(struct bfq_queue *bfqq,
 		return false;
 
 	if (bfq_class_idle(bfqq) || bfq_class_idle(new_bfqq) ||
-	    (bfqq->ioprio_class != new_bfqq->ioprio_class))
+	    (bfq_class(bfqq) != bfq_class(new_bfqq)))
 		return false;
 
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3416a75..29a56b8 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1071,6 +1071,7 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		       bool expiration);
 void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+unsigned short bfq_ioprio_class(struct bfq_entity *entity);
 
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 7405be9..c91109e 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1702,7 +1702,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfq_clear_bfqq_busy(bfqq);
 
-	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
+	bfqd->busy_queues[bfq_ioprio_class(&bfqq->entity) - 1]--;
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
@@ -1725,7 +1725,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_activate_bfqq(bfqd, bfqq);
 
 	bfq_mark_bfqq_busy(bfqq);
-	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
+	bfqd->busy_queues[bfq_ioprio_class(&bfqq->entity) - 1]++;
 
 	if (!bfqq->dispatched)
 		if (bfqq->wr_coeff == 1)
-- 
1.8.3.1

