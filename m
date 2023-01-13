Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1809A6699C7
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbjAMOPD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 09:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbjAMONz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 09:13:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF684669B2
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so21168285wrb.11
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfA7fOK3LCcmN6R2CxD4VildndRtCjudzidz68b+vdE=;
        b=fO5NzU8X5twvuoxI8ACLZI8Gu+yGI2YSIMh067qxr7DL8dFlZI5g+mHS2UiYb3j4to
         viZ2CnpjxEKrL4kusySj8Ic40GZF0LCq6Pid4UYvGWpYSlfZG3oDxZMImm0B0G/GpiaG
         +jZNS0FPJfq1VMX4bBosB3QxN3Uu+giZgBLYATIUEDdo3b5Zo+EYbPhB8lqESdE6UhEF
         3sBoCYdB68/uJ7bLSp6cFBWw+8VO5THrtEPNMT2PIq8tCHB+0A24FKS+30Kp1NY3pW6c
         3pxx1WaKh3wiEW0dHOvJhV7cLSmKPwk9PSPtYeI1T3EH1zPMSYWrY+l5SHSQrsvI2htA
         /ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfA7fOK3LCcmN6R2CxD4VildndRtCjudzidz68b+vdE=;
        b=ePfSbOj8BMXv52QOySwc+LcvLETxkZVevibrqs+wcR9gnfKzQYRNtoItrY8flaXbQl
         JIC8TXHcG+QdMgjG4HByRdl4+6Mmu7U4DiIafmNHP9XkFKBKiF69kHMHOqbhZyRAohGb
         Jb+Rb6LvvX1ynGiQih6kRR0/p6fcT+6+qKcJYwHLsYzTCszD5z09WyAGz9s8b2ZhK3Sg
         5xYzOd3w4wpS1AzVgcjGSUJIXpNL/tY4plERSGGSaBVAzSvMbz8/WzkX/Wkb8F7GuLLV
         xVSDlfHmo0YUnOzqUL7HtxdPCADqXmNozn8y/ssuIfGF/uTZzHaKi8C0NODr46Z5aUca
         BlAA==
X-Gm-Message-State: AFqh2kpivnZ3eNNkPzJcGNBxBBTjx6g7+fzWQlF6HuQtbIfsl0F/JZ2h
        yCSahEbMVlHvtPfmhoZnMsxHqw==
X-Google-Smtp-Source: AMrXdXt8zsIpuEkpxLQRExZJ6xt5328moIhVjqal/WnZQOovbnt2aN+Ev3S+ae1amiTke6izdm5bVg==
X-Received: by 2002:a05:6000:806:b0:293:1868:3a14 with SMTP id bt6-20020a056000080600b0029318683a14mr32347854wrb.0.1673619173276;
        Fri, 13 Jan 2023 06:12:53 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:51 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 9/9] sched/fair: remove check_preempt_from_others
Date:   Fri, 13 Jan 2023 15:12:34 +0100
Message-Id: <20230113141234.260128-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With the dedicated latency list, we don't have to take care of this special
case anymore as pick_next_entity checks for a runnable latency sensitive
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8f0e32431e2..fb2a5b2e3440 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6240,35 +6240,6 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
-static void set_next_buddy(struct sched_entity *se);
-
-static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
-{
-	struct sched_entity *next;
-
-	if (se->latency_offset >= 0)
-		return;
-
-	if (cfs->nr_running <= 1)
-		return;
-	/*
-	 * When waking from another class, we don't need to check to preempt at
-	 * wakeup and don't set next buddy as a candidate for being picked in
-	 * priority.
-	 * In case of simultaneous wakeup when current is another class, the
-	 * latency sensitive tasks lost opportunity to preempt non sensitive
-	 * tasks which woke up simultaneously.
-	 */
-
-	if (cfs->next)
-		next = cfs->next;
-	else
-		next = __pick_first_entity(cfs);
-
-	if (next && wakeup_preempt_entity(next, se) == 1)
-		set_next_buddy(se);
-}
-
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6355,15 +6326,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
-	if (rq->curr->sched_class != &fair_sched_class)
-		check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
-
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
 }
 
+static void set_next_buddy(struct sched_entity *se);
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
-- 
2.34.1

