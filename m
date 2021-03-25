Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34503348997
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYG6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCYG6E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F41C06174A;
        Wed, 24 Mar 2021 23:58:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f10so841762pgl.9;
        Wed, 24 Mar 2021 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YXgpUa5T67Dw4AbYp5KoLO/kJdOhq1vLhGhKXZoWFNo=;
        b=UfiE8S8t+ji0dCZpU85Zwz3hrk3sX4wQAhLWiO0wK13nnrEtUcSQdBlP1eCglmh+EN
         h2NWAPcDUVvMmvB5ELTbdpsgl1YVEI+C8ZNWQY+KBmQxYeFWUTVZN0+kikNRzTm0KnQh
         ufJKpRtSo7H9FwnehaB03id7SW9BbOK15fKXSSsglMNKyX1EbBCGZchiIM3AGadlKzZq
         U6hUQvTKy9wSzZ1xCZM2yjUlafe+9RffAcC4WThShLOCQmHtHTu+yEh77j92Trvd1K74
         SWfkVrNqrmud1zlzBWOXqxVOUYb3VWqUMc6mVKzxXtHToG4YbHbeJDuYvp5yG4IlJ1UX
         HPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YXgpUa5T67Dw4AbYp5KoLO/kJdOhq1vLhGhKXZoWFNo=;
        b=iwM99A1fcx7u+4EassSkI9H+PnTwaWp+0JO41DZ+PzItaO/tAUC6H0oTHvQh8akh71
         svjkoFn0vTHm1MOgbLdOIVceDKsubSbncgC7ZgNtHJOL1AxKLfwGEDWw1iuWs4mOGJjA
         Vi8KBQHNwfx/FotQaQNVdw9bhYjgJewxmQm0xI7nY/aB9rhH7OxyGXI3GMDKNg8YHSDV
         dJEgNknn4dZbHWk+59oTHYrzyMS4lGm9Vlb9X6TzWlCdItpHUE1eDFN3fAv6K/1d07G5
         rex6+6sE1H07ackSJRgisr/b2aSmM8sOeCXpNLFOxXDfWIlikpNUohY/N9FLuE/l6Z9J
         spRw==
X-Gm-Message-State: AOAM5306n+K4RjIR3I2cOsRFuA13Tfk3U4hx3ufPcharSUPTJ2Z9ZlYR
        DlQAldmoyCwJkicDAsLZpJc=
X-Google-Smtp-Source: ABdhPJwCPiBmem4nKH4Oc7XbzbfsfmthSzX7HeIMXM9QFTudnHINpB0tMRW46YdXCAf52D5hJQswKw==
X-Received: by 2002:a17:902:700c:b029:e7:137c:1ddb with SMTP id y12-20020a170902700cb02900e7137c1ddbmr3044761plk.41.1616655484174;
        Wed, 24 Mar 2021 23:58:04 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:03 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] bfq: convert the type of bfq_group.bfqd to bfq_data*
Date:   Thu, 25 Mar 2021 14:57:46 +0800
Message-Id: <bbc36a05f3f752d0b1f7c4db5b6c9cce85fa130b.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Setting bfq_group.bfqd to void* type does not seem to make much sense.
This will cause unnecessary type conversion. Perhaps it would be better
to change it to bfq_data* type.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.h | 2 +-
 block/bfq-wf2q.c    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a5f544a..50d06c7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -224,7 +224,7 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
-	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+	if (!(bfqq == bfqg->bfqd->in_service_queue))
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a6f98e9..28d8590 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -914,7 +914,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	void *bfqd;
+	struct bfq_data *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
 	struct bfq_queue *async_idle_bfqq;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 5ff0028..276f225 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -498,7 +498,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
@@ -597,7 +597,7 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
@@ -743,7 +743,7 @@ struct bfq_service_tree *
 		else {
 			sd = entity->my_sched_data;
 			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
+			bfqd = bfqg->bfqd;
 		}
 #endif
 
-- 
1.8.3.1

