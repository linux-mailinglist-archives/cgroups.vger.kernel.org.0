Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6990B48AAE7
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiAKJ4N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 04:56:13 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42642 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237188AbiAKJ4M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 04:56:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1ZVy34_1641894961;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V1ZVy34_1641894961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Jan 2022 17:56:08 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] sched/core: Accounting forceidle time for all tasks except idle task
Date:   Tue, 11 Jan 2022 17:55:59 +0800
Message-Id: <1641894961-9241-2-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are two types of forced idle time: forced idle time from cookie'd
task and forced idle time form uncookie'd task. The forced idle time from
uncookie'd task is actually caused by the cookie'd task in runqueue
indirectly, and it's more accurate to measure the capacity loss with the
sum of both.

Assuming cpu x and cpu y are a pair of SMT siblings, consider the
following scenarios:
  1.There's a cookie'd task running on cpu x, and there're 4 uncookie'd
    tasks running on cpu y. For cpu x, there will be 80% forced idle time
    (from uncookie'd task); for cpu y, there will be 20% forced idle time
    (from cookie'd task).
  2.There's a uncookie'd task running on cpu x, and there're 4 cookie'd
    tasks running on cpu y. For cpu x, there will be 80% forced idle time
    (from cookie'd task); for cpu y, there will be 20% forced idle time
    (from uncookie'd task).

The scenario1 can recurrent by stress-ng(scenario2 can recurrent similary):
    (cookie'd)taskset -c x stress-ng -c 1 -l 100
    (uncookie'd)taskset -c y stress-ng -c 4 -l 100

In the above two scenarios, the total capacity loss is 1 cpu, but in
scenario1, the cookie'd forced idle time tells us 20% cpu capacity loss, in
scenario2, the cookie'd forced idle time tells us 80% cpu capacity loss,
which are not accurate. It'll be more accurate to measure with cookie'd
forced idle time and uncookie'd forced idle time.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c       | 3 +--
 kernel/sched/core_sched.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00..e8187e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5822,8 +5822,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	}
 
 	if (schedstat_enabled() && rq->core->core_forceidle_count) {
-		if (cookie)
-			rq->core->core_forceidle_start = rq_clock(rq->core);
+		rq->core->core_forceidle_start = rq_clock(rq->core);
 		rq->core->core_forceidle_occupation = occ;
 	}
 
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1fb4567..c8746a9 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -277,7 +277,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
-		if (!p->core_cookie)
+		if (p == rq_i->idle)
 			continue;
 
 		__schedstat_add(p->stats.core_forceidle_sum, delta);
-- 
1.8.3.1

