Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42558C72E
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiHHLFq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbiHHLFM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:05:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59514D04
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:05:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x10so8227018plb.3
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZF+ptlZ7x1rV90unZdPOJJUv9JpctUIbzaWac6sYWYU=;
        b=IT9T5n3uzaIyYCDoAvf1GKOtIDooo4d192E3n80U67HsrhgOBrqqRKN65ZT3tIZeS8
         r7J9Npsendjqi2CuZuFjuvWCjxioqgm2ZFQENgvKsOeMpFRYJRk4WeXmU3kDGo3uggLG
         C4Pk+lVauLT0M9bz1asuYe4TPOjS2qL9jxzDs1K0BOg7Uz/132vLzLC4OARg6kH+FrcX
         YF7g2xylrqFW05z8L54j37rsi0S7tiCDlkr7Y7notxS2bt+mYzYkhh6xZ04P4LKHUBqt
         Nii6RUV4eBr8iz9Y6oKxnuLvsAx1Dvb6E+ByIAWszbpkWUGpQRceGc0bBhM/vibPHULV
         97nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZF+ptlZ7x1rV90unZdPOJJUv9JpctUIbzaWac6sYWYU=;
        b=dEmgU4OeA9XsvVO0AAnsT3PvOnIux7He/O+daAUk7rl5dGXxZ90hz86o0j+fX0uhhx
         lkIiIeyw5u9OIEFDsgUTaPEwcRiZJLaIljElr38q2RvYsORrwFmVRFMo9vdXs87Aml8z
         gIlc1UaVlnF6FuNwQvnXC20AOhMG93SgXsca23es9ljzFT1hdOEopAT8HzvFxskZk+4Y
         NybEYS3WoiH+d1YARRAQsNRUAioTaeP5AfbFQbtPx0plxVKjetWMo7RTck7jgXdkMkcv
         2ssJktgONo46x9dTlvFZftZsUbBe8W3+RlPKGql/Q4cO4QeYCCp/vTliJSDHZTZjQvpc
         c3fw==
X-Gm-Message-State: ACgBeo0es7OJs9Fz2gt46juP1W3F+/XHCHaclfu7fExD5GNE5MxaCJkC
        aSNbfAqppewR6l4JULA02zdq6A==
X-Google-Smtp-Source: AA6agR5tMkDltpGNZ426qYm3ZBSzERjw0pUrjxLSG8+rd7Gc2baWLE+FRwX+ScJkWGExyuaSdEeajw==
X-Received: by 2002:a17:902:edc4:b0:16d:4635:130c with SMTP id q4-20020a170902edc400b0016d4635130cmr18779724plk.64.1659956709766;
        Mon, 08 Aug 2022 04:05:09 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:05:09 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 07/10] sched/psi: remove NR_ONCPU task accounting
Date:   Mon,  8 Aug 2022 19:03:38 +0800
Message-Id: <20220808110341.15799-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
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

From: Johannes Weiner <hannes@cmpxchg.org>

We put all fields updated by the scheduler in the first cacheline of
struct psi_group_cpu for performance.

Since we want add another PSI_IRQ_FULL to track IRQ/SOFTIRQ pressure,
we need to reclaim space first. This patch remove NR_ONCPU task accounting
in struct psi_group_cpu, use one bit in state_mask to track instead.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi_types.h | 16 +++++++---------
 kernel/sched/psi.c        | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c7fe7c089718..54cb74946db4 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -15,13 +15,6 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
-	/*
-	 * This can't have values other than 0 or 1 and could be
-	 * implemented as a bit flag. But for now we still have room
-	 * in the first cacheline of psi_group_cpu, and this way we
-	 * don't have to special case any state tracking for it.
-	 */
-	NR_ONCPU,
 	/*
 	 * For IO and CPU stalls the presence of running/oncpu tasks
 	 * in the domain means a partial rather than a full stall.
@@ -32,16 +25,18 @@ enum psi_task_count {
 	 * threads and memstall ones.
 	 */
 	NR_MEMSTALL_RUNNING,
-	NR_PSI_TASK_COUNTS = 5,
+	NR_PSI_TASK_COUNTS = 4,
 };
 
 /* Task state bitmasks */
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
-#define TSK_ONCPU	(1 << NR_ONCPU)
 #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
 
+/* Only one task can be scheduled, no corresponding task count */
+#define TSK_ONCPU	(1 << NR_PSI_TASK_COUNTS)
+
 /* Resources that workloads could be stalled on */
 enum psi_res {
 	PSI_IO,
@@ -68,6 +63,9 @@ enum psi_states {
 	NR_PSI_STATES = 7,
 };
 
+/* Use one bit in the state mask to track TSK_ONCPU */
+#define PSI_ONCPU	(1 << NR_PSI_STATES)
+
 enum psi_aggregators {
 	PSI_AVGS = 0,
 	PSI_POLL,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 595a6c8230b7..1c675715ed33 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -216,7 +216,7 @@ void __init psi_init(void)
 	group_init(&psi_system);
 }
 
-static bool test_state(unsigned int *tasks, enum psi_states state)
+static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
 {
 	switch (state) {
 	case PSI_IO_SOME:
@@ -229,9 +229,9 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 		return unlikely(tasks[NR_MEMSTALL] &&
 			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
 	case PSI_CPU_SOME:
-		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
+		return unlikely(tasks[NR_RUNNING] > oncpu);
 	case PSI_CPU_FULL:
-		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
+		return unlikely(tasks[NR_RUNNING] && !oncpu);
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -693,9 +693,9 @@ static void psi_group_change(struct psi_group *group, int cpu,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
-	u32 state_mask = 0;
 	unsigned int t, m;
 	enum psi_states s;
+	u32 state_mask;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -711,6 +711,26 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	record_times(groupc, now);
 
+	/*
+	 * Start with TSK_ONCPU, which doesn't have a corresponding
+	 * task count - it's just a boolean flag directly encoded in
+	 * the state mask. Clear, set, or carry the current state if
+	 * no changes are requested.
+	 */
+	if (clear & TSK_ONCPU) {
+		state_mask = 0;
+		clear &= ~TSK_ONCPU;
+	} else if (set & TSK_ONCPU) {
+		state_mask = PSI_ONCPU;
+		set &= ~TSK_ONCPU;
+	} else {
+		state_mask = groupc->state_mask & PSI_ONCPU;
+	}
+
+	/*
+	 * The rest of the state mask is calculated based on the task
+	 * counts. Update those first, then construct the mask.
+	 */
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
 			continue;
@@ -730,9 +750,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
-	/* Calculate state mask representing active states */
 	for (s = 0; s < NR_PSI_STATES; s++) {
-		if (test_state(groupc->tasks, s))
+		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
 			state_mask |= (1 << s);
 	}
 
@@ -744,7 +763,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * task in a cgroup is in_memstall, the corresponding groupc
 	 * on that cpu is in PSI_MEM_FULL state.
 	 */
-	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
+	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
 	groupc->state_mask = state_mask;
@@ -835,7 +854,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
+			    PSI_ONCPU) {
 				common = group;
 				break;
 			}
-- 
2.36.1

