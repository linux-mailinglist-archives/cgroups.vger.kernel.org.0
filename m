Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE5348992
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCYG6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCYG6D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFFBC06174A;
        Wed, 24 Mar 2021 23:58:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h25so865270pgm.3;
        Wed, 24 Mar 2021 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k7foMZZRtisGPq+uUebUl4zeTE385Qk+YuiaUy6ZRfU=;
        b=KxFwKNK/nsKaD7xzfnqTW5+rorL6xoI0FLsaXHB+QpodbGJPtUJwK1Q7sa7QD+mccV
         zkNHurCkqFInNElsD9L3teeQXt2bllYy/sf1cBEU7iZhSCBzeBZ2CaHJu9a780j1Ay4H
         1WIyzsz9BxOkWRq58zmkeazoa8QCfxIbNPHRMMauzzaDIjqpEGKrsZ/F/pxNtC5qHF5L
         +lP9PJ+48mBgHsZ74PaWgl8vYaqioattjvM+OURKFcBSPg4ftShfaCUUyKG6rU/dzNK2
         TQg+1JNs9d/alCD572CoezXJlhtKME0PiFMHps7lZ/Ji4g/oS5ahISdqZKQziZbocPE4
         1rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k7foMZZRtisGPq+uUebUl4zeTE385Qk+YuiaUy6ZRfU=;
        b=qTlJx1SUYE3UjL20REPeAI7geVgvRFo9DtOHla1C08B9eryoT9/z5ed8ibr1JAkGUU
         k8IOBPjD7qQJ7zLRnSomRG73KxhgZU1PtMa0wLoC73PYE6EmCkgsSRgaMzyN0W/3VIMs
         /pfSgkspcMmQR615GzXXaX32lZXJNYOUQXff3s3bVXWvRjtumGWVU+Ho8r00m3970uiW
         ohwXDVDDBKxRacp2rXEgDWdgITlUhJQ/sgXnHqBpR1E7gl5Jgxvau3XtgcvuwpEA+rHE
         lZX/MsbvyDFlPBTl09B8D4b4buyIlitfBFruE+pxi4dqeOSxIDxPJz44vLHQGjVn5o4H
         SB9A==
X-Gm-Message-State: AOAM531+c+z9ibmss4m5tR3q/qxy48HWufvgMi9Jsx6+Lqn/kicnTMxd
        gDaUj3jb8PdF6rM4Mf+HepMdTZppiOX0Aw==
X-Google-Smtp-Source: ABdhPJw3+m2NVA6v0ggjCHjgmOoPNGTuXOEpL8cKhI5aVlicc/5vMYN51MnEryoO22hJ76LFbWbk2g==
X-Received: by 2002:a17:902:c154:b029:e5:e7cf:9627 with SMTP id 20-20020a170902c154b02900e5e7cf9627mr7959942plj.68.1616655482566;
        Wed, 24 Mar 2021 23:58:02 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:02 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] bfq: introduce bfq_entity_to_bfqg helper method
Date:   Thu, 25 Mar 2021 14:57:45 +0800
Message-Id: <7a0e764e663056c78ab004b6b6c6fe4e46123930.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Introduce bfq_entity_to_bfqg() to make it easier to obtain the
bfq_group corresponding to the entity.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  |  6 ++----
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b791e20..a5f544a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -309,8 +309,7 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *group_entity = bfqq->entity.parent;
 
-	return group_entity ? container_of(group_entity, struct bfq_group,
-					   entity) :
+	return group_entity ? bfq_entity_to_bfqg(group_entity) :
 			      bfqq->bfqd->root_group;
 }
 
@@ -610,8 +609,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	 */
 	entity = &bfqg->entity;
 	for_each_entity(entity) {
-		struct bfq_group *curr_bfqg = container_of(entity,
-						struct bfq_group, entity);
+		struct bfq_group *curr_bfqg = bfq_entity_to_bfqg(entity);
 		if (curr_bfqg != bfqd->root_group) {
 			parent = bfqg_parent(curr_bfqg);
 			if (!parent)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index b8e793c..a6f98e9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -941,6 +941,7 @@ struct bfq_group {
 #endif
 
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity);
 
 /* --------------- main algorithm interface ----------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 070e34a..5ff0028 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -149,7 +149,7 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
 	if (!group_entity)
 		group_entity = &bfqq->bfqd->root_group->entity;
 
-	return container_of(group_entity, struct bfq_group, entity);
+	return bfq_entity_to_bfqg(group_entity);
 }
 
 /*
@@ -208,7 +208,7 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	if (bfq_entity_to_bfqq(entity))
 		return true;
 
-	bfqg = container_of(entity, struct bfq_group, entity);
+	bfqg = bfq_entity_to_bfqg(entity);
 
 	/*
 	 * The field active_entities does not always contain the
@@ -266,6 +266,15 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
 	return bfqq;
 }
 
+struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity)
+{
+	struct bfq_group *bfqg = NULL;
+
+	if (entity->my_sched_data)
+		bfqg = container_of(entity, struct bfq_group, entity);
+
+	return bfqg;
+}
 
 /**
  * bfq_delta - map service into the virtual time domain.
@@ -1001,8 +1010,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
-		struct bfq_group *bfqg =
-			container_of(entity, struct bfq_group, entity);
+		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
 
 		if (!entity->in_groups_with_pending_reqs) {
-- 
1.8.3.1

