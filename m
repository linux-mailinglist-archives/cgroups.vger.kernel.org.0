Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687433489AB
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCYG6u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhCYG6R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9AC06174A;
        Wed, 24 Mar 2021 23:58:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s21so651541pjq.1;
        Wed, 24 Mar 2021 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gKQxiL9Ics9FEiHObsHY8UcO0dmLMvnwEV9tZC7Iho0=;
        b=L/1YxwipDPbGlV3OvtnrF5Zs6ewcstH0eyvCsYmC6jf4Y49EMnKnnS5uVgcAkfF5YT
         TP0FfChTGF1e/uTdTwDj3DR5rVmo9xiHLMmGtF9ZEErMToKFaOLzTVY7CCqSH6ziQZp0
         YEwcsC7WkML+ogRIGSh9FUDsVfpDecNXHD1azfiSZEdkgubRsEPNVXnrHfJLQRVgtl0l
         72YSqMVl8Rz7whfxJ/hSaR5X8PUGA29XnPBOVdGgHWs80xt0NVzNeBBAhMwl9vApvluB
         tiGWmiRF1T/7YjoY1kJlc7yS9ZEB3oaUmJmT74NCgzcYn0Vlghwfgfs26JnnQJLfX2p7
         drMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gKQxiL9Ics9FEiHObsHY8UcO0dmLMvnwEV9tZC7Iho0=;
        b=T7Dcmp2Wm3OKqN6lUfRgXhvfR8SmDb8nd7tCVLX/lRCQwyd8rueCqmPQiu3RyDEj37
         Fxnz0lJ8HtrKOxf1UzFIFc59FNs8q8efI7ylKsgmBAnFjvh6lZTnNw9hRrjcCGxK9GZE
         KKP180fPiQdfFCMHG1YB2IID/jd2Nbj2HfoNkmCJnujTQtHUZb+C/c8L9X1Ru71zLvbF
         2X5d7adXlUCB8sNE76532v//G0zDbPKwIfBB8zIFGn5+J/3OF6N1/TklmYntmvPvY3T2
         b1cQMlgSZqCmlKydb2ukxjgLx4W8YVjgp/ebB3WCC/ETy7nvPXkKbvxgKxbMo5Fu+hBk
         xNJg==
X-Gm-Message-State: AOAM532BdK2sJ9PYfqK4vQC5buJVofd5IDTjijJAVarHW5ditVwauzKB
        OWJn1nPkcIFqc4OQqW8YbfM=
X-Google-Smtp-Source: ABdhPJyT2Y/w1fwzEByiwagc82Zln03NFf7G5FQALNO9FZgRzCTVMvn5f2Y+WD/WzQmyQyEUGI2osg==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr7585583pju.54.1616655497101;
        Wed, 24 Mar 2021 23:58:17 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:16 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] bfq: expire in_serv_queue for prio_expire under better_fairness
Date:   Thu, 25 Mar 2021 14:57:53 +0800
Message-Id: <f2cb0781623e336d2ac6a6b010d22a8353ed0f83.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Traverse all schedule domains upward, if there are higher
priority tasks waiting for service, mark in_service_queue
prio_expire and then expire it, so the So RT tasks can be
scheduled in time.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c |  7 +++----
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6e19b5a..51192bd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4736,10 +4736,9 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	 * belongs to CLASS_IDLE and other queues are waiting for
 	 * service.
 	 */
-	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
-		goto return_rq;
-
-	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
+	if ((bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)) ||
+	    bfq_bfqq_prio_expire(bfqq))
+		bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
 
 return_rq:
 	return rq;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 8af5ac0..1406398 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -989,6 +989,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_schedule_dispatch(struct bfq_data *bfqd);
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
+bool bfq_may_expire_in_serv_for_prio(struct bfq_entity *entity);
 
 /* ------------ end of main algorithm interface -------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 1f8f3c5..b477a9b 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -161,6 +161,51 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
 	return bfq_entity_to_bfqg(group_entity);
 }
 
+bool bfq_may_expire_in_serv_for_prio(struct bfq_entity *entity)
+{
+	struct bfq_sched_data *sd;
+	struct bfq_queue *bfqq;
+	struct bfq_group *bfqg;
+	bool ret = false;
+
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+
+	if (likely(!bfqg->bfqd->better_fairness))
+		return false;
+
+	bfqq = bfqg->bfqd->in_service_queue;
+	if (bfqq) {
+		struct bfq_entity *next_in_serv;
+
+		/*
+		 * Traverse the upper-level scheduling domain for
+		 * prio preemption, and expire in_service_queue
+		 * if necessary.
+		 */
+		entity = &bfqq->entity;
+		for_each_entity(entity) {
+			sd = entity->sched_data;
+			next_in_serv = sd->next_in_service;
+
+			if (!next_in_serv)
+				continue;
+
+			/*
+			 * Expire bfqq, if next_in_serv belongs to
+			 * a higher class.
+			 */
+			if (bfq_class_idx(next_in_serv) <
+			    bfq_class_idx(entity)) {
+				bfq_mark_bfqq_prio_expire(bfqq);
+				ret = true;
+				break;
+			}
+		}
+	}
+	return ret;
+}
+
 /*
  * Returns true if this budget changes may let next_in_service->parent
  * become the next_in_service entity for its parent entity.
@@ -244,6 +289,11 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
 	return bfqq->bfqd->root_group;
 }
 
+bool bfq_may_expire_in_serv_for_prio(struct bfq_entity *entity)
+{
+	return false;
+}
+
 static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
 {
 	return false;
@@ -1162,6 +1212,7 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 					bool non_blocking_wait_rq,
 					bool requeue, bool expiration)
 {
+	struct bfq_entity *old_entity = entity;
 	struct bfq_sched_data *sd;
 
 	for_each_entity(entity) {
@@ -1172,6 +1223,15 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 		    !requeue)
 			break;
 	}
+
+	/*
+	 * Expire in_service_queue, if a task belongs to higher class
+	 * is added to the upper-level scheduling domain, we should
+	 * initiate a new schedule. But here is just to mark bfqq
+	 * prio_expire, the real schedule occurs in
+	 * bfq_dispatch_rq_from_bfqq().
+	 */
+	bfq_may_expire_in_serv_for_prio(old_entity);
 }
 
 /**
-- 
1.8.3.1

