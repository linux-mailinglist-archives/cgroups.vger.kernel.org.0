Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D977173744C
	for <lists+cgroups@lfdr.de>; Tue, 20 Jun 2023 20:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFTSdN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jun 2023 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTSdM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jun 2023 14:33:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0951730
        for <cgroups@vger.kernel.org>; Tue, 20 Jun 2023 11:33:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bcef239a9fbso12009098276.1
        for <cgroups@vger.kernel.org>; Tue, 20 Jun 2023 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687285981; x=1689877981;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sBPwNjci+mVKgvTGGSvenUmGifZY3Myji5qjgOuCzdY=;
        b=CV163j2PUGaavyM9SvGsrlqZLN2xBHrKdDynwlJOjsbY0BnCYcw8OuXxIYqTcePd/4
         75NNiIVKAORJDQqeVbt8R+SXRThRGQvhEqlcna+1G+zhYFac2tqz+Kx++pU6u41NWRnI
         IzUsvovlGgT4EJdq0PTaZ4Dm0WIXjBtD0wLcnJDoVjgRFlPCmyTU8VsNYLZJDmPqxxCL
         OT/TGrpF+2O7PaMxGBI6yeul6VwI9pwRx5/fUXqA3PQO4hd7oy3cRJyi66jJCV40Dd2x
         EjZ+GR+fkHQuIwCMlkwh6W3+frRhMueAcukods0XG7+nZMO2shq9cUUTv+JNlJgKJmLI
         hdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687285981; x=1689877981;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBPwNjci+mVKgvTGGSvenUmGifZY3Myji5qjgOuCzdY=;
        b=fB0Mzwl1ps5QK9onZp1Vmkb5JQfwYiqE/hcLITlapWmvDe4ent/z17s3o1HqVRCPkg
         8LJztfxdMqU5+T9rR38/3sdywnASO4ns9fH+IVZ8NgnHTkjD5Sbfqyab2fpzD4jxVYIN
         tU4QYzdY+aGfBthSZMCJPYAoHA8ifvevRSaKcumrq/MIafYwriocZBJxQdkS/NxXAr7O
         ZUV5hhUfU01BIPfsQaa5LaeOcMsjyPX6GNQaek83LjvzZOnCaXkvM3v77OqhzB7d8Sv4
         Che+hEQLxOYJQwfek1fYR4lNC8XIHHsyhTWfQ2/rXL3OB0FH3gRclyjiZggTiuEArivm
         5Nxg==
X-Gm-Message-State: AC+VfDz7COgdJHud3WabS4jWOPBmH8rOEuCsMv4PRz8LEeDw1dsSbOeu
        jQbODqL14yEzcnPQV8dL51fE2/J+QnS0
X-Google-Smtp-Source: ACHHUZ7bOatjzQX/Jut8CVloG02AZ3Trw8/m9G2F+ZHZd5l0tbEhR1q1/c7ee6EvEK8TAYW2EztlWHwe8MOW
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:7f30:1fa1:c3c6:d39a])
 (user=joshdon job=sendgmr) by 2002:a05:6902:561:b0:bad:2b06:da3 with SMTP id
 a1-20020a056902056100b00bad2b060da3mr4934249ybt.3.1687285981208; Tue, 20 Jun
 2023 11:33:01 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:32:46 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230620183247.737942-1-joshdon@google.com>
Subject: [PATCH v3 1/2] sched: don't account throttle time for empty groups
From:   Josh Don <joshdon@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkoutny@suse.com, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is easy for a cfs_rq to become throttled even when it has no enqueued
entities (for example, if we have just put_prev()'d the last runnable
task of the cfs_rq, and the cfs_rq is out of quota).

Avoid accounting this time towards total throttle time, since it
otherwise falsely inflates the stats.

Note that the dequeue path is special, since we normally disallow
migrations when a task is in a throttled hierarchy (see
throttled_lb_pair()).

Signed-off-by: Josh Don <joshdon@google.com>
---
v3: fix bug with nested limits
 kernel/sched/fair.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a45635..72571d48559a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4787,6 +4787,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
+static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static inline bool cfs_bandwidth_used(void);
 
@@ -4873,8 +4874,14 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (cfs_rq->nr_running == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq))
+		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
+		} else {
+#ifdef CONFIG_CFS_BANDWIDTH
+			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
+				cfs_rq->throttled_clock = rq_clock(rq_of(cfs_rq));
+#endif
+		}
 	}
 }
 
@@ -5480,7 +5487,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
+	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -5498,7 +5507,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	update_rq_clock(rq);
 
 	raw_spin_lock(&cfs_b->lock);
-	cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+	if (cfs_rq->throttled_clock) {
+		cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+		cfs_rq->throttled_clock = 0;
+	}
 	list_del_rcu(&cfs_rq->throttled_list);
 	raw_spin_unlock(&cfs_b->lock);
 
-- 
2.41.0.162.gfafddb0af9-goog

