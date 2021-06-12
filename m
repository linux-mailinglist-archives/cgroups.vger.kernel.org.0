Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7403A4E56
	for <lists+cgroups@lfdr.de>; Sat, 12 Jun 2021 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhFLLdZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Jun 2021 07:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFLLdZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Jun 2021 07:33:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D0BC061574
        for <cgroups@vger.kernel.org>; Sat, 12 Jun 2021 04:31:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so7051783lfr.10
        for <cgroups@vger.kernel.org>; Sat, 12 Jun 2021 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=826uE2Kw+fTQSJLI8zdA2YaMxd3hohLsaAzT8wyrsVQ=;
        b=eFusKu4DwR6m/lIazbGM17SldgdtK6zkE+iGNrh8Z9u2xqPxNAEU6/Y1nN9AUOBtsh
         bGkiI6Ok+z1277Ojo0r4NIf6hfL38DBt5wrBc4ddPFi5nSyfyMXzTXOqIWrp+nbqMwah
         asI0gfB3cJ3bFO/VUuVYwnG+GeNVHNTufGhCsMDmo6XAyPxY+woMnrz5H4KPmZyf2efS
         Fcdo6aR0ZLSYQyySdDbfREyhFxALi4pyzvrauN5fCR9N3JT4p8aLsqyPn6fQq9byYnFL
         V31rpeGRfkawTOtcwpeOG9Tu+/z/dinfh19f6lSHZ+low25TAp6PE8oH0sVt0Qexir6n
         Huiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=826uE2Kw+fTQSJLI8zdA2YaMxd3hohLsaAzT8wyrsVQ=;
        b=aHhqUqA8alU2w6DiYROd/OMyQPEhU7+wDXSE3XQ+4BNTGqiUjPvXzxyaDjwC3mLPgF
         dUZZaMJb/B3dLWxXq7j1NifgZNfjjjsObaAAhlWgrFm0WcBkFVlUpYafmtvTbWBMosfx
         CrK6ssSBPXoG3e3TK1WNicIaCSePwLIybtkVvPyBwsHgAisVJzK3dRIIFEbZchr9sSHl
         POzlWcC4z2WKfvxv2JvpCukRoMGNqZytuNOCmp+RayEfVTm4TJc6yo7U/8Yvr5fE7UaZ
         QnAaw35mEULI0rtBTL8avn2ZvIHT5Nd9c1WMB/Iqlke5ZqBa1XBY+jjnSrB0HE1EDoTH
         g8/Q==
X-Gm-Message-State: AOAM533QgVOOW0a1G9F8hI3aXER3dpKY2JAs38zWyrnDoPoKggaqjeC5
        4BDz1L3amqRypQH3K6cJxKrxYw==
X-Google-Smtp-Source: ABdhPJzStg6LvgD8k5hgKKK3JV0rpromU9WrbxSTrWWPYvVZuVQNikiZz1Q9Xp8elCePF5r17QaJlQ==
X-Received: by 2002:a05:6512:acb:: with SMTP id n11mr1896826lfu.560.1623497483748;
        Sat, 12 Jun 2021 04:31:23 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id c16sm876093lfi.18.2021.06.12.04.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:31:23 -0700 (PDT)
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
Subject: [PATCH v5] sched/fair: Correctly insert cfs_rq's to list on unthrottle
Date:   Sat, 12 Jun 2021 13:28:15 +0200
Message-Id: <20210612112815.61678-1-odin@uged.al>
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
Changes since v4:
 - Move cfs_rq_is_decayed again

 kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..c48d1d409b20 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3283,6 +3283,24 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+	if (cfs_rq->avg.load_sum)
+		return false;
+
+	if (cfs_rq->avg.util_sum)
+		return false;
+
+	if (cfs_rq->avg.runnable_sum)
+		return false;
+
+	return true;
+}
+
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
@@ -4719,8 +4737,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		/* Add cfs_rq with load or one or more already running entities to the list */
+		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
@@ -7895,23 +7913,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
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

