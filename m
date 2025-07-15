Return-Path: <cgroups+bounces-8738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174F8B04DF9
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 04:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B941AA0F32
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B692D0278;
	Tue, 15 Jul 2025 02:47:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444D25CC64;
	Tue, 15 Jul 2025 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547673; cv=none; b=F26ojUs46/8PH+XWirolL/SLn++1bL2vEHRHK5phnQTGG+M7aheLIu7q24+8G9HWBXlU4NdP0dHIKx3OwDGLUwyMl2Tu36nzp4vyEWpANA/1NYRsrNp8FYmaWrnAG1y5z55dWQwyU4s6QK87mFyJhA/STD4EUmHb3SpnizPIMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547673; c=relaxed/simple;
	bh=GaCRh1zfrpviFjUuy+y1TkFYOao3HjhtyNQeULb4w6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPajlYR8Z04Oj5fEw1lu06HogzGx/Nx/oTd2iRPmVJc36sHNttuPg0CmxUqN8cmuB+o45L7pEAg4NXDhtKCbgxnPJJGG+Kyeo8isDFT7c9eihwTpArF2LIwkMmy0Po/RPp4gTlm72gmV5fS9Jti3ducLOZx35Qa+1ZZiM6Ms2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bh3Wg2nP5zKHN1y;
	Tue, 15 Jul 2025 10:47:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ED5E71A0CD4;
	Tue, 15 Jul 2025 10:47:41 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxA5wXVo72g4AQ--.60195S2;
	Tue, 15 Jul 2025 10:47:41 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	peterz@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH v2 -next] cpuset: fix warning when attaching tasks with offline CPUs
Date: Tue, 15 Jul 2025 02:33:40 +0000
Message-Id: <20250715023340.3617147-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxA5wXVo72g4AQ--.60195S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW5Gw1Utr48uw4xCw47XFb_yoW5Zw1kpF
	WI93WUtw45X3Wj939xG39FgFyFga1kCFy7JFn3Kw1rAFy3GF1j9a1jqFn8Ary5trW5C3Wr
	uFyDZr4YgF1qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A kernel warning was observed in the cpuset migration path:

     WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
     cgroup_migrate_execute+0x8df/0xf30
     Call Trace:
      cgroup_transfer_tasks+0x2f3/0x3b0
      cpuset_migrate_tasks_workfn+0x146/0x3b0
      process_one_work+0x5ba/0xda0
      worker_thread+0x788/0x1220

The issue can be reliably reproduced with:

     # Setup test cpuset
     mkdir /sys/fs/cgroup/cpuset/test
     echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
     echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems

     # Start test process
     sleep 100 &
     pid=$!
     echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
     taskset -p 0xC $pid  # Bind to CPUs 2-3

     # Take CPUs offline
     echo 0 > /sys/devices/system/cpu/cpu3/online
     echo 0 > /sys/devices/system/cpu/cpu2/online

Root cause analysis:
When tasks are migrated to top_cpuset due to CPUs going offline,
cpuset_attach_task() sets the CPU affinity using cpus_attach which
is initialized from cpu_possible_mask. This mask may include offline
CPUs. When __set_cpus_allowed_ptr() computes the intersection between:
1. cpus_attach (possible CPUs, may include offline)
2. p->user_cpus_ptr (original user-set mask)
The resulting new_mask may contain only offline CPUs, causing the
operation to fail.

To resolve this issue, if the call to set_cpus_allowed_ptr fails, retry
using the intersection of cpus_attach and cpu_active_mask.

Fixes: da019032819a ("sched: Enforce user requested affinity")
Suggested-by: Waiman Long <llong@redhat.com>
Reported-by: Yang Lijin <yanglijin@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f74d04429a29..2cf788a8982a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3114,6 +3114,10 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 static cpumask_var_t cpus_attach;
 static nodemask_t cpuset_attach_nodemask_to;
 
+/*
+ * Note that tasks in the top cpuset won't get update to their cpumasks when
+ * a hotplug event happens. So we include offline CPUs as well.
+ */
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
 	lockdep_assert_held(&cpuset_mutex);
@@ -3127,7 +3131,16 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	 * can_attach beforehand should guarantee that this doesn't
 	 * fail.  TODO: have a better way to handle failure here
 	 */
-	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+	if (unlikely(set_cpus_allowed_ptr(task, cpus_attach))) {
+		/*
+		 * Since offline CPUs are included for top_cpuset,
+		 * set_cpus_allowed_ptr() can fail if user_cpus_ptr contains
+		 * only offline CPUs. Take out the offline CPUs and retry.
+		 */
+		if (cs == &top_cpuset)
+			cpumask_and(cpus_attach, cpus_attach, cpu_active_mask);
+		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+	}
 
 	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 	cpuset1_update_task_spread_flags(cs, task);
-- 
2.34.1


