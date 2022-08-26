Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690025A1F1D
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 04:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiHZCsp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 22:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZCso (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 22:48:44 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B27CCE29
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 19:48:41 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27Q2mUvE015509;
        Fri, 26 Aug 2022 11:48:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 26 Aug 2022 11:48:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27Q2mUHH015505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Aug 2022 11:48:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5ea67858-cda6-bf8d-565e-d793b608e93c@I-love.SAKURA.ne.jp>
Date:   Fri, 26 Aug 2022 11:48:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Cgroups <cgroups@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] cgroup: Use cgroup_attach_{lock,unlock}() from
 cgroup_attach_task_all()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No behavior changes; preparing for potential locking changes in future.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/cgroup/cgroup-internal.h | 2 ++
 kernel/cgroup/cgroup-v1.c       | 6 ++----
 kernel/cgroup/cgroup.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 36b740cb3d59..2c7ecca226be 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -250,6 +250,8 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
+void cgroup_attach_lock(bool lock_threadgroup);
+void cgroup_attach_unlock(bool lock_threadgroup);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *locked)
 	__acquires(&cgroup_threadgroup_rwsem);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index ff6a8099eb2a..52bb5a74a23b 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -59,8 +59,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	mutex_lock(&cgroup_mutex);
-	cpus_read_lock();
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	cgroup_attach_lock(true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -72,8 +71,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	percpu_up_write(&cgroup_threadgroup_rwsem);
-	cpus_read_unlock();
+	cgroup_attach_unlock(true);
 	mutex_unlock(&cgroup_mutex);
 
 	return retval;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e4bb5d57f4d1..5aee34bcf003 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2393,7 +2393,7 @@ EXPORT_SYMBOL_GPL(task_cgroup_path);
  * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  * CPU hotplug is disabled on entry.
  */
-static void cgroup_attach_lock(bool lock_threadgroup)
+void cgroup_attach_lock(bool lock_threadgroup)
 {
 	cpus_read_lock();
 	if (lock_threadgroup)
@@ -2404,7 +2404,7 @@ static void cgroup_attach_lock(bool lock_threadgroup)
  * cgroup_attach_unlock - Undo cgroup_attach_lock()
  * @lock_threadgroup: whether to up_write cgroup_threadgroup_rwsem
  */
-static void cgroup_attach_unlock(bool lock_threadgroup)
+void cgroup_attach_unlock(bool lock_threadgroup)
 {
 	if (lock_threadgroup)
 		percpu_up_write(&cgroup_threadgroup_rwsem);
-- 
2.18.4

