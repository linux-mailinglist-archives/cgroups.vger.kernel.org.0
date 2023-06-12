Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318A72D4EC
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 01:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjFLX2G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jun 2023 19:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjFLX2F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jun 2023 19:28:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C91BC
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 16:28:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so7158668276.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686612484; x=1689204484;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B47KW5jxTOZnVNWxUxID6P/+Y+TQgLo1hBb1KHXImro=;
        b=z4xkjDD0Y064fp/ZbLacHzg7x9kJ8re4ii7lXm4mF4MTs6UxwuEqQyAHhKeHNQkxPE
         tBOjvs1TKr3JYFY6w5Dr4w6Pv9BGaW/peKwuka9LaQgRfdaXTwjQlTQhbH5KYUlAKEqN
         IQwKONqJuo/vChP5MTWpmwDkOOh8hzhsEl2m3xzW9ePz2c6nuNnRCFuckU9CeO9nLPjH
         p5KogcFq3+jwza8RJ9pKCPLTq+zhgodIRkJnzXsN57zc9fG0+mLwp3J5nqx4gzcD5ZDp
         T8OQh/IltApJ5f7kKm4almvxlaW/MMGwnjHvu1SmbWB7817BjwiavtUKNQoGtob7D0Ci
         2jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612484; x=1689204484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B47KW5jxTOZnVNWxUxID6P/+Y+TQgLo1hBb1KHXImro=;
        b=Pmp7SJgkM4uUbUXpsn3FJd4WvUXfL6fNm1/5VsTenUfkRWEeeyabW5FC22TE+eTr6R
         Z5xhWZezX9iKOUjZdHCDIabVd/9VrvxR1tI69RyBfgjeoxB7RXLAWKWQTO6ElIbQXnBJ
         lRm+2pijvVLaX7vfj2NsY8FD0BXwxWSjjiDpUNVq72VmplYXaG2a9qfet8pJ0oBoqoOV
         QAbEN3nI8LKvqdwj3XUZlY3UAmEsPn6tTeaDTbnMtobIZHH5lNSFgERW2kuR8atrb7vl
         2SeaUkXAP5638TrTdksTSgvlqRj2njz4LcEvcSOQQbbA7n2qMGAmLdGQormdGp9NiG9t
         tc+A==
X-Gm-Message-State: AC+VfDxz5+QV2b3kGLnGpszbFx7gK/XOfGgko700jIC9wV9cw9j8NF9P
        QJyBqgQ10Apn/ZyFGRXLcthSq089Aq4M
X-Google-Smtp-Source: ACHHUZ6ma50k+njTRVCfIHC3fZTeAVPcIkiE0ZQLBVLMvon0Wcep28BHvVBx/DdzaaDlnk0vnpp97/Nja/g6
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:5b1e:752c:c184:9d6c])
 (user=joshdon job=sendgmr) by 2002:a25:854e:0:b0:ba8:929a:2073 with SMTP id
 f14-20020a25854e000000b00ba8929a2073mr111898ybn.1.1686612483710; Mon, 12 Jun
 2023 16:28:03 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:27:47 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230612232748.3948659-1-joshdon@google.com>
Subject: [PATCH v2 1/2] sched: don't account throttle time for empty groups
From:   Josh Don <joshdon@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>,
        Josh Don <joshdon@google.com>
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
 kernel/sched/fair.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0ca13ac..ddd5dc18b238 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4873,8 +4873,14 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (cfs_rq->nr_running == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq))
+		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
+		} else {
+#ifdef CONFIG_CFS_BANDWIDTH
+			if (!cfs_rq->throttled_clock)
+				cfs_rq->throttled_clock = rq_clock(rq_of(cfs_rq));
+#endif
+		}
 	}
 }
 
@@ -5480,7 +5486,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
+	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -5498,7 +5506,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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

