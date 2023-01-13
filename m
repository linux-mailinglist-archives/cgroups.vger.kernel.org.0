Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891F6699BD
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbjAMOOu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 09:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbjAMONt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 09:13:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4D538B8
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id az7so21195375wrb.5
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiVS63wbAWm+QNHUVgj2Zht/JYfZt2Iaghb+UJPmGJA=;
        b=Qh85uD1YsNWfsXSd0d73mm0u8hDaGmsaRhIZGgLJv8V9BgvN+HigCnzW5b9dMcw03V
         LcFIYpE7cA4lzuSa8n9vvPMFUvGTtVjfNY9gpmAGy9CGlYRhkqXxwXn8Nl0IrWDqRUhe
         S4uaRLOt5G79qMoW8ItaBtopKB9BDhstDF+PQKqqhRIuTheyU/YuaGxhtjsfZivHQwVl
         5epEhNrXjIJhyXgi3pMDMbwWSwcglnz+3DzHSPNhas1TcW4iyDzZwzhHFYm4S6884GVj
         SszmSBo/CQH+3x+o+201a6zSuaD3xxy9PeGmUEZCnVzq3ykO+k+v8MbDsyoeNyR1JihL
         In1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiVS63wbAWm+QNHUVgj2Zht/JYfZt2Iaghb+UJPmGJA=;
        b=zfbnIWwUplIzcRlnRjqQhFupevchBf3qgUeX5Y4W4tttfa3Qpvxj1ZoRnYmIyVU9cX
         2qsu/PscqHkCRMmB/pqVtcrclIPv8lgg23vRvCR/AnNSxzEKkR+eoNX3wuqjwg5LgWBT
         /otUrUA8RiquoMsDPMfbHoreZJG2xVFjpxY/N1bL4egjjYL4V+QfhnS1w2JooFcoCk99
         F1X+U82HtoVcsUxEqsaWRWNLzu8sencciLYlFd8Lzy+Z0g7BIdbFyciBDP10RdWtH4/a
         M8wL9p1jsGUQnAAVuU8UHlCE4T6kLMahzgLPN9S6294WmsmPNg0DIfC8mNeQE1ApAC2H
         oe1A==
X-Gm-Message-State: AFqh2krN3BoM6vH+ZfYyyx52FFuUgc1D8BpGzsFuIgP17GwmcjVfsq8t
        JP6stU1rl0fgnXpCUH6vkIZ7qA==
X-Google-Smtp-Source: AMrXdXt1Bi5uBYA2hJ1xsxt4Mlf0z4gmrE6DNZwSGTqhseSe+PeYAaT/2R6CKBdA0swjgp/eMhmN/g==
X-Received: by 2002:a5d:63c1:0:b0:2bd:bdb5:baf1 with SMTP id c1-20020a5d63c1000000b002bdbdb5baf1mr9347506wrw.10.1673619161369;
        Fri, 13 Jan 2023 06:12:41 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:40 -0800 (PST)
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
Subject: [PATCH v10 2/9] sched: Introduce latency-nice as a per-task attribute
Date:   Fri, 13 Jan 2023 15:12:27 +0100
Message-Id: <20230113141234.260128-3-vincent.guittot@linaro.org>
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

From: Parth Shah <parth@linux.ibm.com>

Latency-nice indicates the latency requirements of a task with respect
to the other tasks in the system. The value of the attribute can be within
the range of [-20, 19] both inclusive to be in-line with the values just
like task nice values.

latency_nice = -20 indicates the task to have the least latency as
compared to the tasks having latency_nice = +19.

The latency_nice may affect only the CFS SCHED_CLASS by getting
latency requirements from the userspace.

Additionally, add debugging bits for newly added latency_nice attribute.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase, move defines in sched/prio.h]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h      |  1 +
 include/linux/sched/prio.h | 18 ++++++++++++++++++
 kernel/sched/debug.c       |  1 +
 3 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4df2b3e76b30..6c61bde49152 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -784,6 +784,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_nice;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index ab83d85e1183..bfcd7f1d1e11 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -42,4 +42,22 @@ static inline long rlimit_to_nice(long prio)
 	return (MAX_NICE - prio + 1);
 }
 
+/*
+ * Latency nice is meant to provide scheduler hints about the relative
+ * latency requirements of a task with respect to other tasks.
+ * Thus a task with latency_nice == 19 can be hinted as the task with no
+ * latency requirements, in contrast to the task with latency_nice == -20
+ * which should be given priority in terms of lower latency.
+ */
+#define MAX_LATENCY_NICE	19
+#define MIN_LATENCY_NICE	-20
+
+#define LATENCY_NICE_WIDTH	\
+	(MAX_LATENCY_NICE - MIN_LATENCY_NICE + 1)
+
+/*
+ * Default tasks should be treated as a task with latency_nice = 0.
+ */
+#define DEFAULT_LATENCY_NICE	0
+
 #endif /* _LINUX_SCHED_PRIO_H */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..68be7a3e42a3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1043,6 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
+	P(latency_nice);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
-- 
2.34.1

