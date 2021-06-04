Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD239B702
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhFDK3H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Jun 2021 06:29:07 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:41761 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFDK3H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Jun 2021 06:29:07 -0400
Received: by mail-lj1-f175.google.com with SMTP id p20so10877981ljj.8
        for <cgroups@vger.kernel.org>; Fri, 04 Jun 2021 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bs3XH4WZd6E/C1uTgCierdB67bFqe7Y81Sb7TkTn2M=;
        b=gbFYhwn8pOM/7ph23QfoO3M+4l04YwAWr2awCxogavPFl/D4bhWDJamyo33F0xQSWm
         xBTJa+57nUaVtoY/P+yk9mIeh9vwa/jzw7/WnoKkkGJCPkehsPBDsrv517LUWVxDvbFl
         P1Gc0zxDggAg1kbe3iI3a9QV8PxV/AEloCb/s1GD/0rV0JvSCGWfy8yZ6vrCJYI9Kpz5
         2XcvxSVnHhT9W1CaLhUh5KuzJRWZn5Ua/2Et2hUoxW0zk6tM1W00KE4i0XK+XS6W/3A1
         q5tjFIGbWzEwloT3XMgFvAXj0aRL49NNSWj3B6ADCVjhzQe6DEfCfCwvUI6gIlJkBomc
         cV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bs3XH4WZd6E/C1uTgCierdB67bFqe7Y81Sb7TkTn2M=;
        b=N31/CIgONj0/xkVTfJiEUyKNGYPQ53VfX715Z5eVtoyVV/oZeLw7912QEjLFUpd+q/
         p+i7QcAgD73W71pXGBTQ3pVPDBLLfVg/AtDpVB0x4V+xy/5XY5OUVtYrooM+B4Dr7ZFD
         cS7nrjeSwcPRa5UgfXw6ymGAQidv/7TnzauW+7MdSP42TX983O0k8nBZtsn5q4nz6GmL
         fd/RQSoLIjkOBU+4yepEbJTfUaKZ/wbxY4Tc+JGOMw7W3eHoh59E2rjR2Uf1G45dgFRC
         pReZw1x4JG317WXLrnLnNtj6qJNJ3NYIti4/sASbAOQBgAQPeiCSSpJt5TeY0AC1XJYn
         psGQ==
X-Gm-Message-State: AOAM530c3sDRWcev8TbAHpOe2+6K3bueRNVGugP3/3JX5NCnq9LNX09s
        M5fUDMUKvm+t6GkOwgMn58g5pg==
X-Google-Smtp-Source: ABdhPJzMylnxjSIKf3ULGlogKwNTUlCj5lHRUbaiKtam3Y+kDoD9ibL+SBUryZ7kygxDpLk9aBs+fg==
X-Received: by 2002:a2e:8e63:: with SMTP id t3mr2910818ljk.71.1622802368510;
        Fri, 04 Jun 2021 03:26:08 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id t8sm576262lfr.194.2021.06.04.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 03:26:07 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on unthrottle
Date:   Fri,  4 Jun 2021 12:23:14 +0200
Message-Id: <20210604102314.697749-1-odin@uged.al>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This fixes an issue where fairness is decreased since cfs_rq's can
end up not being decayed properly. For two sibling control groups with
the same priority, this can often lead to a load ratio of 99/1 (!!).

This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
will be removed from the leaf list. When they initial cfs_rq is
unthrottled, it will currently only re add descendant cfs_rq's if they
have one or more entities enqueued. This is not a perfect heuristic.

Instead, we insert all cfs_rq's that contain one or more enqueued
entities, or it its load is not completely decayed.

Can often lead to situations like this for equally weighted control
groups:

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1

Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
Changes since v1:
 - Replaced cfs_rq field with using tg_load_avg_contrib
 - Went from 3 to 1 patches; one is merged and one is replaced
   by a new patchset.
Changes since v2:
 - Use !cfs_rq_is_decayed() instead of tg_load_avg_contrib
 - Moved cfs_rq_is_decayed to above its new use
Changes since v3:
 - (hopefully) Fix config for !CONFIG_SMP
 kernel/sched/fair.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..eec32f214ff8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -712,6 +712,25 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return calc_delta_fair(sched_slice(cfs_rq, se), se);
 }
 
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+#ifdef CONFIG_SMP
+	if (cfs_rq->avg.load_sum)
+		return false;
+
+	if (cfs_rq->avg.util_sum)
+		return false;
+
+	if (cfs_rq->avg.runnable_sum)
+		return false;
+#endif
+
+	return true;
+}
+
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
@@ -4719,8 +4738,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		/* Add cfs_rq with load or one or more already running entities to the list */
+		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
@@ -7895,23 +7914,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_sum)
-		return false;
-
-	return true;
-}
-
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
 	struct cfs_rq *cfs_rq, *pos;
-- 
2.31.1

