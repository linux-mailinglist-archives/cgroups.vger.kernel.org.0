Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D7387944
	for <lists+cgroups@lfdr.de>; Tue, 18 May 2021 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349396AbhERM4U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 May 2021 08:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349395AbhERM4R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 May 2021 08:56:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F0C061760
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 05:54:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v6so11425175ljj.5
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHrO7R178ZgAEl57M73kYgQb5jhyv+gIfGWJWUwWLPc=;
        b=W3GL++BT3PKitCks3wvqU3a7V9CTSU83IAVCzWRBUQIkZO1oz9lQAtum11OWRhuZa5
         8dIxNcx7bE4GyAYf/nCoIxt3nRyW1T71W7sT3t/7ViNYw0mGaegEnJJO7zGs7KUeRFuG
         bZtd0VdAKG6bUFG9LwJ5Jk7fJqXVOuDLgY8PAKnU+biM8HhgpiFDKIjqra+cO2mm47Ov
         JWF/nfansj2ksgn861WROFG6HrzeNhh8yoNNWPhmNmchqSixFEUH4OO/ssDO6v5/ZgEt
         vso/Fd05uD/5wxl1wOYbSOzKAni0/FMZhkv5pQ4Sfp8QFCflud+9rTAGvEbIR7RJYk92
         SdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHrO7R178ZgAEl57M73kYgQb5jhyv+gIfGWJWUwWLPc=;
        b=DtZXPjMlIKWdAgdZBD1pPd//SxuWMzayBvBBvxRnDSE0IppcPx9YIsdCCGwG4cZ6dP
         CeY5RWvpazgwb1H5WNozCzYyAtjl1rrFbCjLwqifdK2y4LHUjAh/fscxELgA/sHZMTyr
         fcneJ6b80mhHu4CThTWwKLfuK/CowI9sN6RcpZgQSU8VKg4eooRcK3qQAg570tD0G11f
         SW/M8HErBu5DFXU/duOSYLOTVsCtxiOsqFBB+17nRM5G+PqwtNg2H8He0DWjdZ0AjxMP
         Odh7Bdbk5gEonp884TdRjNki+uXoqfS//7M2sZHbWZAh5jghg/JwMEX3wKWGuyIr3yVc
         531A==
X-Gm-Message-State: AOAM532ufcdgzYsgxFXJ1gyfVSvcxZ7gkhLulUwR1kA5RsyDkkyh/GxK
        IY4fZNFNCJPk0/FxA3NzVFCQDQ==
X-Google-Smtp-Source: ABdhPJxrQmPyCBnJBQIw+zDRDd2PshuShGr+0IhK6b84ELpkckV8GkPl+t9D7vUS/Yya4XS2ak+CCw==
X-Received: by 2002:a2e:8e66:: with SMTP id t6mr3996220ljk.481.1621342497929;
        Tue, 18 May 2021 05:54:57 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id v14sm2265898lfb.201.2021.05.18.05.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:54:57 -0700 (PDT)
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
Subject: [PATCH 2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
Date:   Tue, 18 May 2021 14:52:01 +0200
Message-Id: <20210518125202.78658-3-odin@uged.al>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518125202.78658-1-odin@uged.al>
References: <20210518125202.78658-1-odin@uged.al>
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

This fix change this behavior to save what cfs_rq's was removed from the
list, and readds them properly on unthrottle.

Can often lead to sutiations like this for equally weighted control
groups:

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1

Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c  | 11 ++++++-----
 kernel/sched/sched.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ceda53c2a87a..e7423d658389 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -376,7 +376,8 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+/* Returns 1 if cfs_rq was present in the list and removed */
+static inline bool list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->on_list) {
 		struct rq *rq = rq_of(cfs_rq);
@@ -393,7 +394,9 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 
 		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
 		cfs_rq->on_list = 0;
+		return 1;
 	}
+	return 0;
 }
 
 static inline void assert_list_leaf_cfs_rq(struct rq *rq)
@@ -4742,9 +4745,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
-
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		if (cfs_rq->insert_on_unthrottle)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
@@ -4759,7 +4760,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_task = rq_clock_task(rq);
-		list_del_leaf_cfs_rq(cfs_rq);
+		cfs_rq->insert_on_unthrottle = list_del_leaf_cfs_rq(cfs_rq);
 	}
 	cfs_rq->throttle_count++;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..12a707d99ee6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -602,6 +602,7 @@ struct cfs_rq {
 	u64			throttled_clock_task_time;
 	int			throttled;
 	int			throttle_count;
+	int			insert_on_unthrottle;
 	struct list_head	throttled_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
-- 
2.31.1

