Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31157C31B
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiGUEFF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGUEFA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3E78DDE
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:04:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bk6-20020a17090b080600b001f2138a2a7bso3548665pjb.1
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYIMFSr31+Cppft00ZwweosK4yTHz5KYhWo2OmHr+0M=;
        b=QdUORMkLmkF1TeBchXvDKwbtQ2w25HmZACJcQ3QxpqqcR1ttFDE/QNbeNQYBAHZ7AN
         lh8r5emk2M1x/5gbPuxfBPY9Tse0ukWz4QyGyGKvHOPcKxj7UlN5onU2xoMn0WvVc5pJ
         azepAXLIuZ7+ZdoOpiT+N0hz4N59K+GQzyPomlShzbfMg0afAYoqa0RXr4KYpqYP4PR0
         Em1w0fgoj2WAoZ4+DMngFY4BtLRNqlFcythX0GrV41jDEaRuxoNCtY7kW1ochI5Q10GY
         DW5UG1/p1iP2b6JQ5Co2PiWbwGYRLhUZYO9dTLDASdn/VkwIgqXolNi6Wy1Wi8EGX8bB
         Xung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYIMFSr31+Cppft00ZwweosK4yTHz5KYhWo2OmHr+0M=;
        b=fNZA8Dve6PZPo1zJdZps7atp740HFCDKodUPxcgbyPlDFeyzog34NlEgAsewKWvhqL
         H41ciY/dUddlhBu15vSt/en9Xn5C+Mz7+HwoEaQWhUKKzpuX7icZbjEJ6kQWPwOJUToz
         iysha2rCl96HuVPu26sGhpmogGSZ8PSX2SB2DRO4p79/cZD90Zk/s05d+oacMG8fHJ6h
         oFJTSTwmof/o+UjYmNSnFxzaGt1GL6mh5UahwxtHp6F3+bxvLl3eEI1Z1wczJ80kGA4Y
         OSotLT8zurRVYc2Bi7raV9xi5WG18RejDISZqCvEu/ikPUU2yxEYsR6bGjJAqzGBcE6e
         BiiA==
X-Gm-Message-State: AJIora/zTp1aXnN8bCKMZ/8C75Pt2I5n/ciiFLIzNixXCbDYDyvh5L8p
        wy17zF4G7O94HFgJRRFhZ/hWng==
X-Google-Smtp-Source: AGRyM1sjnwAAHoTI14u32rz/nIWx7dzlWwrjiMgT+NwHgyJvevVkF24sjNzGM+yHxeQsw4n9kSvyfA==
X-Received: by 2002:a17:90b:4a08:b0:1ef:f36b:18e1 with SMTP id kk8-20020a17090b4a0800b001eff36b18e1mr9186437pjb.246.1658376298688;
        Wed, 20 Jul 2022 21:04:58 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:04:58 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/9] sched/psi: fix periodic aggregation shut off
Date:   Thu, 21 Jul 2022 12:04:31 +0800
Message-Id: <20220721040439.2651-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We don't want to wake periodic aggregation work back up if the
task change is the aggregation worker itself going to sleep, or
we'll ping-pong forever.

Previously, we would use psi_task_change() in psi_dequeue() when
task going to sleep, so this check was put in psi_task_change().

But commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
defer task sleep handling to psi_task_switch(), won't go through
psi_task_change() anymore.

So this patch move this check to psi_task_switch(). Note for defer sleep
case, we should wake periodic avgs work for common ancestors groups,
since those groups have next task sched_in.

Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..c8a4e644cd2c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -800,7 +800,6 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	bool wake_clock = true;
 	void *iter = NULL;
 	u64 now;
 
@@ -810,19 +809,9 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	psi_flags_change(task, clear, set);
 
 	now = cpu_clock(cpu);
-	/*
-	 * Periodic aggregation shuts off if there is a period of no
-	 * task changes, so we wake it back up if necessary. However,
-	 * don't do this if the task change is the aggregation worker
-	 * itself going to sleep, or we'll ping-pong forever.
-	 */
-	if (unlikely((clear & TSK_RUNNING) &&
-		     (task->flags & PF_WQ_WORKER) &&
-		     wq_worker_last_func(task) == psi_avgs_work))
-		wake_clock = false;
 
 	while ((group = iterate_groups(task, &iter)))
-		psi_group_change(group, cpu, clear, set, now, wake_clock);
+		psi_group_change(group, cpu, clear, set, now, true);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
@@ -858,6 +847,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 	if (prev->pid) {
 		int clear = TSK_ONCPU, set = 0;
+		bool wake_clock = true;
 
 		/*
 		 * When we're going to sleep, psi_dequeue() lets us
@@ -871,13 +861,23 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				clear |= TSK_MEMSTALL_RUNNING;
 			if (prev->in_iowait)
 				set |= TSK_IOWAIT;
+
+			/*
+			 * Periodic aggregation shuts off if there is a period of no
+			 * task changes, so we wake it back up if necessary. However,
+			 * don't do this if the task change is the aggregation worker
+			 * itself going to sleep, or we'll ping-pong forever.
+			 */
+			if (unlikely((prev->flags & PF_WQ_WORKER) &&
+				     wq_worker_last_func(prev) == psi_avgs_work))
+				wake_clock = false;
 		}
 
 		psi_flags_change(prev, clear, set);
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, clear, set, now, true);
+			psi_group_change(group, cpu, clear, set, now, wake_clock);
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
-- 
2.36.1

