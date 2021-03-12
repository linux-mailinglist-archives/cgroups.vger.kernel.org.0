Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E54338B23
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCLLJV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhCLLJD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7309C061574;
        Fri, 12 Mar 2021 03:09:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e26so1612866pfd.9;
        Fri, 12 Mar 2021 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ud/HIpdKfmY9i4QsmVRo1Nb5Ke6E9oHUsnblYDWdhJA=;
        b=e1vbgjvwidHePgd6EoNDd4Kl3SpU2Ae5fZbmZdf58I/SUQga9/4NxJsg8nhEDi0Xq/
         d0QlLsGmYasbGPSeXTH82FF9XRxKEr8O609+waQaXAWnEn406rZXd13RiIfd+zMBnbGX
         gTK4STN1RllcfTW8fJ87Ihwy0ziWn4t1AK8lelxVyYUPpu6LprxDmVrSVnBWi+XmET2o
         iHgT+1xWgVb/i+AMAlycS8OYhczx5IzZQfrnAPS6/1dr9MCH4QdAtQLYAjcXbdmx8uvZ
         6ybzcpsWnypeog9LOEINXDuFIJTsntRawy7krddQoQ7g7mSfzGAL+GLvmQOFPbxhW/Q6
         Fv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ud/HIpdKfmY9i4QsmVRo1Nb5Ke6E9oHUsnblYDWdhJA=;
        b=lRh0GJdYFSL2lRuqUImnVgwdwbxmitFtWUFxXwpEWWkb2VeYjWav9bwa/NOdYLTvAh
         ZIOwo/rJgfQETvxG6FLhIACbttyq+NfN0GCSDNOs6QKzvEqHVLaA08D8MiL238/6DjLX
         JWdNviuQVHY8Gl4RQYNVE45MkwdFVx1242/C2/sOu5poSOrll4b1fZk5oB6LP20Hvn0X
         xQmc2jAtlGF+oNX6Z7m5J4mxt/bjzpaT2FAfnMOV0LHXAEQNxpNn/NEbtD70sf7RAP71
         HZlDYpsTypTCW3kMjZFrsomeaSKfqF6M7WhmlmwBYe67Y8ftHxOiESXwKhu/8I6xwdpO
         vY8w==
X-Gm-Message-State: AOAM532OQ77w5lbimWptpwaQdi4qB8DKETWdo8ALi5tcIQjXEpjqdakB
        0CulccoxRRx8lc53KF2Qqlk=
X-Google-Smtp-Source: ABdhPJxUdZTkbLNrb0MvnJecybeT3l961ku5o4tPjGZ/oUsdoGbV8jfQYJP6Nphy5bXK4bQdCbT4ag==
X-Received: by 2002:a63:8f5d:: with SMTP id r29mr10970412pgn.353.1615547342505;
        Fri, 12 Mar 2021 03:09:02 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.09.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:01 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 06/11] bfq: expire other class if CLASS_RT is waiting
Date:   Fri, 12 Mar 2021 19:08:40 +0800
Message-Id: <7c5d7791d538aa3f705c7e1da8debe463a6ce174.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Expire bfqq not belong to CLASS_RT and CLASS_RT is waiting for
service, we can further guarantee the latency for CLASS_RT.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 15 ++++++++++-----
 block/bfq-iosched.h |  8 ++++++++
 block/bfq-wf2q.c    | 12 ++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ab00b664348c..8af73473c45c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -428,6 +428,7 @@ void bfq_schedule_dispatch(struct bfq_data *bfqd)
 	}
 }
 
+#define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
 #define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
 
 #define bfq_sample_valid(samples)	((samples) > 80)
@@ -4709,12 +4710,16 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	/*
 	 * Expire bfqq, pretending that its budget expired, if bfqq
 	 * belongs to CLASS_IDLE and other queues are waiting for
-	 * service.
+	 * service, or if bfqq not belongs to CLASS_RT and CLASS_RT
+	 * is waiting for service.
 	 */
-	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
-		goto return_rq;
-
-	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if ((bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)) ||
+	    (!bfq_class_rt(bfqq) && bfqd->busy_groups[0]))
+#else
+	if (bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq))
+#endif
+		bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
 
 return_rq:
 	return rq;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index de7301664ad3..6b87ba53db94 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -531,6 +531,14 @@ struct bfq_data {
 	 */
 	unsigned int num_groups_with_pending_reqs;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	/*
+	 * Per-class (RT, BE, IDLE) number of bfq_groups waiting for
+	 * service.
+	 */
+	unsigned int busy_groups[3];
+#endif
+
 	/*
 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
 	 * requests (including the queue in service, even if it is
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 0ac35fd4f2ab..f6c67a80e454 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1032,11 +1032,14 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
 		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
+		int idx = bfq_class_idx(entity);
 
 		if (!entity->in_groups_with_pending_reqs) {
 			entity->in_groups_with_pending_reqs = true;
 			bfqd->num_groups_with_pending_reqs++;
 		}
+
+		bfqd->busy_groups[idx]++;
 	}
 #endif
 
@@ -1188,6 +1191,9 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_service_tree *st;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_group *bfqg;
+#endif
 	int idx = bfq_class_idx(entity);
 	bool is_in_service;
 
@@ -1229,6 +1235,12 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 		bfq_idle_insert(st, entity);
 
 	sd->bfq_class_last_service[idx] = jiffies;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	bfqg = bfq_entity_to_bfqg(entity);
+	if (bfqg)
+		bfqg->bfqd->busy_groups[idx]--;
+#endif
+
 	return true;
 }
 
-- 
2.30.0

