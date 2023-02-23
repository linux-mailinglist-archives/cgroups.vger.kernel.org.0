Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C56A103C
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjBWTLW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 14:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBWTLN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 14:11:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E3652DD3
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l25so11156419wrb.3
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiVS63wbAWm+QNHUVgj2Zht/JYfZt2Iaghb+UJPmGJA=;
        b=fIYGRnAgdM1pkszU9vujdElW+ZXCpTTf26yDfbUIv79L8uorGratJSQKy5JJHH9DQ+
         mPbuFR4q4LajY8N0objspMBuREs1C8bEczpR+yZelsroKn3N/FpjN/oT7oxBNg139zUa
         PyiGiRirGFQgNB0Gd7VZRP6nDveoPxnPuvIJ3741+SjfmENOI4oTXnnvvm/FTpMVQ9N8
         aRpzzIsafVX1tcketysgCV3PX8OB9+epSy1Mompzex59kSU8k4jFGekd7RMUSWcJq8TT
         LmOjl6fYcaFyY2DN/1vWEV0HB7KlYF2iNDl/Trfy7C5ruK9qvJmFBD+6ZkCnqYmRMa9S
         P0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiVS63wbAWm+QNHUVgj2Zht/JYfZt2Iaghb+UJPmGJA=;
        b=Jst3gsBFPJwqLg1KXZKTGI+EG0Jav/4aBQEqOu4vcWVnrIQyRNCQiUfss1ajOIgYFB
         JD51eOc4YczgdQdZUA1FSWpfsRJ35C6ilSyjGKX1z3piImrv7KPPih0srMIorpXvDZvm
         nV+epap0OzOBXsMuuYP2G7cQkzSjp5rAIBq6zYAYbjl8R/oLYTRdEWlhTn5fWExrvzt6
         z/a1UYSa6N48W4AjMw/4qpWt6gR3sqMJLpBISbQJiFy5C3bfwkK4OZQSoMi3vD/H9DLb
         FpC6iEUinCvu4+VjD3Sh3HmsCiax1HXrKycqm/Eb3c9+2Ud0Rp8xb1DCec4RZMybUpEE
         wDUA==
X-Gm-Message-State: AO0yUKW9XKqa9OT6UlL0Hv8GIjC6s4Tz3dqlWRW++ldS/r0fFdtRnCuP
        xvwL3juCKNn1dkaChoLcxJWWKw==
X-Google-Smtp-Source: AK7set8ailWUj1cm9/MR8T00RP9NTdvcApBMpjUfy6nYCzgaS9+P6dhi4HqQHx97xYFu87vC8YFEtQ==
X-Received: by 2002:a05:6000:1c04:b0:2c5:4ffb:b5d4 with SMTP id ba4-20020a0560001c0400b002c54ffbb5d4mr10630447wrb.19.1677179447566;
        Thu, 23 Feb 2023 11:10:47 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:47 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v8 2/8] sched: Introduce latency-nice as a per-task attribute
Date:   Thu, 23 Feb 2023 20:10:35 +0100
Message-Id: <20230223191041.577305-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223191041.577305-1-vincent.guittot@linaro.org>
References: <20230223191041.577305-1-vincent.guittot@linaro.org>
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

