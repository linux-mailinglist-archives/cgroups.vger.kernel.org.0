Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A65A16FB
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiHYQnp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbiHYQnM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 12:43:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994CBBA65
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:42:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so2368417pjj.5
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WejlGClWGOz4bz39sTGrt+zcC+1FgtAJxwc+yuBUn+0=;
        b=SaF4V56o98RwyKm4Dd9nmZJgCPmnYVFL9biZ4nY7UVTw8PLe9hkPGSpcJ7JhVfqSpo
         4Wo2DhNt0zt75QS2NiNriICjnCg1VwUFXEob4tUMn/HzRN25XnP5BQ3NdSdTuuTw+yqj
         KkRjfGpl/qxuQFhWvAkxvrVYfcbhK81Tz5EbiAv2/S7TSUPhu6fOCtNq/S1TWZl1dH9j
         +xgN+KslrcRgYvGpWPuev08WdqzlH5Ou2+VlEBeDAvirALpBkB1aoKLSDbV+X/cgJXyb
         iKSkaBMNgF9qnMpkMopBugxFvSY80G2kqQd0XHsNV/yZi5cDYTNgzgo6lsVxvm/BlRvL
         SBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WejlGClWGOz4bz39sTGrt+zcC+1FgtAJxwc+yuBUn+0=;
        b=YfacwFmb/DqHeaJBEUCusxRkW3lQOo28KOF+wNahTJgJMFJQ2zRIc0hNVoEBZg21/1
         r3CqEIdUIHs7rV2TmExdKyH3G8YnlYbN/GyFNXdoDDY9VAVt+jWdyQaN40MnxoN8BMcQ
         TbXBMmHcMs6T+noCffOcRqTZfF5D7iZXRPENEJtVTGe82tl949G7657H+vGEoz0bUepp
         IpbjhdmyQMd1P9Q9IBJ5cklhnqtEV+nAVAI4OFZFVs27kZLKzkoLoROZ3gcs2hp7xqJo
         VNmBsSQKhrSUFBABcECmTGaK1CjMJ7LO4VyWhhg5juJ1GPtrg42/C4TnLd7jV9lvfUTQ
         fxaA==
X-Gm-Message-State: ACgBeo03yT1+ChiQAnO5LWiDh1mrUJKXUJVTk8BurtlA9+SxiXbdNn3e
        9QZCIMv9SO6jahHOvlSBhVq5Fg==
X-Google-Smtp-Source: AA6agR6rDKNnv/vTW/guSIqvLU9/pQQzzWn8IkTmPgdhXECN9znL/NqCgRcJsa76TlZc9Q0A0XUk9Q==
X-Received: by 2002:a17:902:a511:b0:172:97a7:6f5d with SMTP id s17-20020a170902a51100b0017297a76f5dmr4619678plq.159.1661445759842;
        Thu, 25 Aug 2022 09:42:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm12779408pff.67.2022.08.25.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:42:39 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com,
        surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 01/10] sched/psi: fix periodic aggregation shut off
Date:   Fri, 26 Aug 2022 00:41:02 +0800
Message-Id: <20220825164111.29534-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164111.29534-1-zhouchengming@bytedance.com>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

So this patch move this check to psi_task_switch().

Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ecb4b4ff4ce0..39463dcc16bb 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -796,7 +796,6 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	bool wake_clock = true;
 	void *iter = NULL;
 	u64 now;
 
@@ -806,19 +805,9 @@ void psi_task_change(struct task_struct *task, int clear, int set)
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
@@ -854,6 +843,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 	if (prev->pid) {
 		int clear = TSK_ONCPU, set = 0;
+		bool wake_clock = true;
 
 		/*
 		 * When we're going to sleep, psi_dequeue() lets us
@@ -867,13 +857,23 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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
@@ -882,7 +882,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if (sleep) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
-				psi_group_change(group, cpu, clear, set, now, true);
+				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
 }
-- 
2.37.2

