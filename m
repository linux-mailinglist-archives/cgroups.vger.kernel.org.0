Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D676384C7
	for <lists+cgroups@lfdr.de>; Fri, 25 Nov 2022 08:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKYHvx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Nov 2022 02:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYHvw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Nov 2022 02:51:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8752F38F
        for <cgroups@vger.kernel.org>; Thu, 24 Nov 2022 23:51:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so6994679pjh.2
        for <cgroups@vger.kernel.org>; Thu, 24 Nov 2022 23:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+6fVVB9BmEJEqb7Ji1ITmJk4l6XMki34cizL1NoHWs=;
        b=aeRBe+pU/jO8Gy99w737xR904Bnhj4f7us8VIYn/UcNkg7f2jsbMct+LXkjRtIQnXR
         GZsrEFlwJuhFVxyPqBGmEIRpqO1FUKXM+fTwxEUSoYWST4Y/WaxRTmuzz2+1Gn+fppTZ
         /JbZzmq3BnXoadA6T17FouZYezsATwTr6Xi7CQprNDZNyatcjS2yA7j2G/euX6k/iJFo
         6tjj1W4cPapz8lnuiHq92v5HPGUBDqQLBnfjzSMHtAPCU+UGMnI/wzefa8on4hZDwhIM
         FTAUduVWvQWY+fGycu13uGrVnHNZ6sUez7Ijg+hMOJ1pNf8Q61ISQpLn1tLexhw73YUq
         LsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+6fVVB9BmEJEqb7Ji1ITmJk4l6XMki34cizL1NoHWs=;
        b=a/wecVxEtpPIoLGGAGhf4XOSdOJxB/S5c29MVGnRGe+LCYQ6/kSb63y6Fau2o+/Y1f
         GADFdWF9grJENstTlGIP7YdcXW4BASTCz0CZXBVBMfXUOvegWkEjn3Lqz7IX2sIzSBmy
         wQW+wVLRJMg8jvWUbl0HJb67KJMsKPSL07vzFj2aPAL2rOxzYMFH96iv5BVc5nRcHc1H
         fP8EtR7GyxUtRsm7f4Y5teHAdQzuo9b+Br732CPiyaM3A67A1/wNpAteqdeBSRxt6C52
         NLTGatbk5vhzQOFlijWiRT8PERJw54Llm4E9Z9GLcxnPhdRpygGnwjqSlBMsPRGVdsFh
         hJhw==
X-Gm-Message-State: ANoB5plemTP+xmnlglngf5tvah4gMlpA08ojAbzKXj7OX9bSBab02m3K
        CUrNpe7jrtpljSnAcifi4o5Kyg==
X-Google-Smtp-Source: AA0mqf6DI53+N6EogVEf5foHezmMcOMrbLA4u8a6joMtZUrnXsRvJVRKypDwwA+f6XKp7C/B1Ni3Dg==
X-Received: by 2002:a17:90a:5918:b0:213:ff:1cda with SMTP id k24-20020a17090a591800b0021300ff1cdamr38252467pji.86.1669362710755;
        Thu, 24 Nov 2022 23:51:50 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id 6-20020a621406000000b0057447bb0ddcsm2433271pfu.49.2022.11.24.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:51:50 -0800 (PST)
From:   "haifeng.xu" <haifeng.xu@shopee.com>
To:     longman@redhat.com
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "haifeng.xu" <haifeng.xu@shopee.com>
Subject: [PATCH] cgroup/cpuset: Clean up cpuset_task_status_allowed
Date:   Fri, 25 Nov 2022 07:51:33 +0000
Message-Id: <20221125075133.12718-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
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

cpuset_task_status_allowed just shows mems_allowed status, so
rename it to task_mems_allowed. Moreover, it's only used in
proc_pid_status, so move it to fs/proc/array.c. There is no
intentional function change.

Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
---
 fs/proc/array.c        | 13 +++++++++++--
 include/linux/cpuset.h |  7 -------
 kernel/cgroup/cpuset.c |  9 ---------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..e6cdef8387e6 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -80,7 +80,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/times.h>
-#include <linux/cpuset.h>
 #include <linux/rcupdate.h>
 #include <linux/delayacct.h>
 #include <linux/seq_file.h>
@@ -413,6 +412,16 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 		   cpumask_pr_args(&task->cpus_mask));
 }
 
+static void task_mems_allowed(struct seq_file *m, struct task_struct *task)
+{
+#ifdef CONFIG_CPUSETS
+	seq_printf(m, "Mems_allowed:\t%*pb\n",
+		   nodemask_pr_args(&task->mems_allowed));
+	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
+		   nodemask_pr_args(&task->mems_allowed));
+#endif
+}
+
 static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
 {
 	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
@@ -449,7 +458,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cap(m, task);
 	task_seccomp(m, task);
 	task_cpus_allowed(m, task);
-	cpuset_task_status_allowed(m, task);
+	task_mems_allowed(m, task);
 	task_context_switch_counts(m, task);
 	return 0;
 }
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..30b91116dd2f 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -112,8 +112,6 @@ extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 extern int cpuset_memory_pressure_enabled;
 extern void __cpuset_memory_pressure_bump(void);
 
-extern void cpuset_task_status_allowed(struct seq_file *m,
-					struct task_struct *task);
 extern int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *tsk);
 
@@ -246,11 +244,6 @@ static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 
 static inline void cpuset_memory_pressure_bump(void) {}
 
-static inline void cpuset_task_status_allowed(struct seq_file *m,
-						struct task_struct *task)
-{
-}
-
 static inline int cpuset_mem_spread_node(void)
 {
 	return 0;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 589827ccda8b..5798d4231662 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4045,12 +4045,3 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	return retval;
 }
 #endif /* CONFIG_PROC_PID_CPUSET */
-
-/* Display task mems_allowed in /proc/<pid>/status file. */
-void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
-{
-	seq_printf(m, "Mems_allowed:\t%*pb\n",
-		   nodemask_pr_args(&task->mems_allowed));
-	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
-		   nodemask_pr_args(&task->mems_allowed));
-}
-- 
2.25.1

