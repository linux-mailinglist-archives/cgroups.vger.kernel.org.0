Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449A835516F
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 12:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhDFLAE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 07:00:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35346 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237930AbhDFLAD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 07:00:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617706795; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=V34Gl62R+ZKZkGqDlj2SaxJjLzUma8Qf6Yp9wpC1uIk=; b=Zb/MlS2FwwQ0VM0o0o+1WiYT7cMeNN0wZsLHHV4R1mjM+QooOJ+Hzvs6diKtgSYDb5zUUsOB
 kmleAR+CI5ZE8GnUW0D4gWpa2XFV1yMUs4jxneJBkiTKuxQMM5LHcc5QmTbHV792Mp1jAC0c
 td13/aXFz6c2M+b+42gkc/psNrk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3MmZiMyIsICJjZ3JvdXBzQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606c3f1d8807bcde1d4929a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 10:59:41
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C013DC43462; Tue,  6 Apr 2021 10:59:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27FB5C433ED;
        Tue,  6 Apr 2021 10:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27FB5C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Quentin Perret <qperret@google.com>, Wei Wang <wvw@google.com>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>
Subject: [PATCH] cgroup: Relax restrictions on kernel threads moving out of root cpu cgroup
Date:   Tue,  6 Apr 2021 16:29:13 +0530
Message-Id: <1617706753-25349-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In Android GKI, CONFIG_FAIR_GROUP_SCHED is enabled [1] to help prioritize
important work. Given that CPU shares of root cgroup can't be changed,
leaving the tasks inside root cgroup will give them higher share
compared to the other tasks inside important cgroups. This is mitigated
by moving all tasks inside root cgroup to a different cgroup after
Android is booted. However, there are many kernel tasks stuck in the
root cgroup after the boot.

We see all kworker threads are in the root cpu cgroup. This is because,
tasks with PF_NO_SETAFFINITY flag set are forbidden from cgroup migration.
This restriction is in place to avoid kworkers getting moved to a cpuset
which conflicts with kworker affinity. Relax this restriction by explicitly
checking if the task is moving out of a cpuset cgroup. This allows kworkers
to be moved out root cpu cgroup.

We also see kthreadd_task and any kernel thread created after the Android boot
also stuck in the root cgroup. The current code prevents kthreadd_task moving
out root cgroup to avoid the possibility of creating new RT kernel threads
inside a cgroup with no RT runtime allocated. Apply this restriction when tasks
are moving out of cpu cgroup under CONFIG_RT_GROUP_SCHED. This allows all
kernel threads to be moved out of root cpu cgroup if the kernel does not
enable RT group scheduling.

[1] https://android.googlesource.com/kernel/common/+/f08f049de11c15a4251cb1db08cf0bee20bd9b59

Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup-v1.c       |  2 +-
 kernel/cgroup/cgroup.c          | 24 +++++++++++++++++++-----
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc..a96ed9a 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -232,7 +232,8 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
-					     bool *locked)
+					     bool *locked,
+					     struct cgroup *dst_cgrp)
 	__acquires(&cgroup_threadgroup_rwsem);
 void cgroup_procs_write_finish(struct task_struct *task, bool locked)
 	__releases(&cgroup_threadgroup_rwsem);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a575178..d674a6c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -497,7 +497,7 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, threadgroup, &locked);
+	task = cgroup_procs_write_start(buf, threadgroup, &locked, cgrp);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20..41864a8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2744,7 +2744,8 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 }
 
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
-					     bool *locked)
+					     bool *locked,
+					     struct cgroup *dst_cgrp)
 	__acquires(&cgroup_threadgroup_rwsem)
 {
 	struct task_struct *tsk;
@@ -2784,15 +2785,28 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 		tsk = tsk->group_leader;
 
 	/*
+	 * RT kthreads may be born in a cgroup with no rt_runtime allocated.
+	 * Just say no.
+	 */
+#ifdef CONFIG_RT_GROUP_SCHED
+	if (tsk->no_cgroup_migration && (dst_cgrp->root->subsys_mask & (1U << cpu_cgrp_id))) {
+		tsk = ERR_PTR(-EINVAL);
+		goto out_unlock_threadgroup;
+	}
+#endif
+
+	/*
 	 * kthreads may acquire PF_NO_SETAFFINITY during initialization.
 	 * If userland migrates such a kthread to a non-root cgroup, it can
-	 * become trapped in a cpuset, or RT kthread may be born in a
-	 * cgroup with no rt_runtime allocated.  Just say no.
+	 * become trapped in a cpuset. Just say no.
 	 */
-	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
+#ifdef CONFIG_CPUSETS
+	if ((tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) &&
+			(dst_cgrp->root->subsys_mask & (1U << cpuset_cgrp_id))) {
 		tsk = ERR_PTR(-EINVAL);
 		goto out_unlock_threadgroup;
 	}
+#endif
 
 	get_task_struct(tsk);
 	goto out_unlock_rcu;
@@ -4740,7 +4754,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	if (!dst_cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, threadgroup, &locked);
+	task = cgroup_procs_write_start(buf, threadgroup, &locked, dst_cgrp);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

