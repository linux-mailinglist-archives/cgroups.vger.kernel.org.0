Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7B148AE8
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2020 16:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgAXPHw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jan 2020 10:07:52 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29772 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387698AbgAXPHv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jan 2020 10:07:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579878470; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=V/z/hpUlTROc4VymAW3Gg8iFQOabyB5bs0q3YT2E7aw=; b=mJIdQdAwUjsFtN+kpNoSIhKKSV/3rsYOom/WC9XEu+1ZGiXhcA8d4ycjSGPZNrzpBmhB9ngf
 dSd+DWd/ymcLDyxko9DWbjU3LMUrY18om2XCuQOSugSYv976OIV882eFrm8K+Ey91sMrlZOk
 rBaeXxQBYvXL38FeW2h0vvWEi8s=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3MmZiMyIsICJjZ3JvdXBzQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2b0840.7f32b782be68-smtp-out-n03;
 Fri, 24 Jan 2020 15:07:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD207C4479F; Fri, 24 Jan 2020 15:07:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D71DC43383;
        Fri, 24 Jan 2020 15:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D71DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     tj@kernel.org, peterz@infradead.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prateek Sood <prsood@codeaurora.org>
Subject: [PATCH] cpuset: Make cpuset hotplug synchronous
Date:   Fri, 24 Jan 2020 20:37:29 +0530
Message-Id: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun & Peter,

It seems that after following patch we can make cpuset_hotplug_workfn
synchronous:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/cpuset.c?h=v5.5-rc7&id=d74b27d63a8bebe2fe634944e4ebdc7b10db7a39


Could you please share your opinion on the same and below patch. 

Thanks,
Prateek

>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8

Convert cpuset_hotplug_workfn() into synchronous call for cpu hotplug
path. For memory hotplug path it still gets queued as a work item.

Since cpuset_hotplug_workfn() can be made synchronous for cpu hotplug
path, it is not required to wait for cpuset hotplug while thawing
processes.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
---
 include/linux/cpuset.h |  3 ---
 kernel/cgroup/cpuset.c | 31 +++++++++++++++++++------------
 kernel/power/process.c |  2 --
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 04c20de66..cede4cb 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -54,7 +54,6 @@ static inline void cpuset_dec(void)
 extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
-extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_read_lock(void);
 extern void cpuset_read_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
@@ -176,8 +175,6 @@ static inline void cpuset_update_active_cpus(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
-static inline void cpuset_wait_for_hotplug(void) { }
-
 static inline void cpuset_read_lock(void) { }
 static inline void cpuset_read_unlock(void) { }
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58f5073..cafd4d2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3101,7 +3101,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 }
 
 /**
- * cpuset_hotplug_workfn - handle CPU/memory hotunplug for a cpuset
+ * cpuset_hotplug - handle CPU/memory hotunplug for a cpuset
  *
  * This function is called after either CPU or memory configuration has
  * changed and updates cpuset accordingly.  The top_cpuset is always
@@ -3116,7 +3116,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
  * Note that CPU offlining during suspend is ignored.  We don't modify
  * cpusets across suspend/resume cycles at all.
  */
-static void cpuset_hotplug_workfn(struct work_struct *work)
+static void cpuset_hotplug(bool use_cpu_hp_lock)
 {
 	static cpumask_t new_cpus;
 	static nodemask_t new_mems;
@@ -3201,25 +3201,32 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	/* rebuild sched domains if cpus_allowed has changed */
 	if (cpus_updated || force_rebuild) {
 		force_rebuild = false;
-		rebuild_sched_domains();
+		if (use_cpu_hp_lock)
+			rebuild_sched_domains();
+		else {
+			/* Acquiring cpu_hotplug_lock is not required.
+			 * When cpuset_hotplug() is called in hotplug path,
+			 * cpu_hotplug_lock is held by the hotplug context
+			 * which is waiting for cpuhp_thread_fun to indicate
+			 * completion of callback.
+			*/
+			percpu_down_write(&cpuset_rwsem);
+			rebuild_sched_domains_locked();
+			percpu_up_write(&cpuset_rwsem);
+		}
 	}
 
 	free_cpumasks(NULL, ptmp);
 }
 
-void cpuset_update_active_cpus(void)
+static void cpuset_hotplug_workfn(struct work_struct *work)
 {
-	/*
-	 * We're inside cpu hotplug critical region which usually nests
-	 * inside cgroup synchronization.  Bounce actual hotplug processing
-	 * to a work item to avoid reverse locking order.
-	 */
-	schedule_work(&cpuset_hotplug_work);
+	cpuset_hotplug(true);
 }
 
-void cpuset_wait_for_hotplug(void)
+void cpuset_update_active_cpus(void)
 {
-	flush_work(&cpuset_hotplug_work);
+	cpuset_hotplug(false);
 }
 
 /*
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 4b6a54d..08f7019 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -204,8 +204,6 @@ void thaw_processes(void)
 	__usermodehelper_set_disable_depth(UMH_FREEZING);
 	thaw_workqueues();
 
-	cpuset_wait_for_hotplug();
-
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
 		/* No other threads should have PF_SUSPEND_TASK set */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
