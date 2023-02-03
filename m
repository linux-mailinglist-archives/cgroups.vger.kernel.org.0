Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F5689F7D
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjBCQlo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 11:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBCQln (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 11:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B811BDE
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675442458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PcrmDD4uHCC6UG1ke8fLxCH03JicWyxdUu0tRYYVEIs=;
        b=FPlGdhpOtgPL6OIMbb1FyQzFNuPU9jGO+wLsbLJtm1/XwE/s0jPReR2RGL+x4UWHYazI1C
        TXq2u2yxCwGTc5noluymsDISH6tGR9m7wIt6ElibCFJSPoPX0UHceUKQGZmor01d7oc8+s
        iXSDfQpLExj9oytAeu1HicnEt0p9VKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-UxN4cLx1OnKzZvt6K7GIsw-1; Fri, 03 Feb 2023 11:40:54 -0500
X-MC-Unique: UxN4cLx1OnKzZvt6K7GIsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69989800B24;
        Fri,  3 Feb 2023 16:40:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 940C5140EBF4;
        Fri,  3 Feb 2023 16:40:53 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com, Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Don't filter offline CPUs in cpuset_cpus_allowed() for top cpuset tasks
Date:   Fri,  3 Feb 2023 11:40:40 -0500
Message-Id: <20230203164040.213437-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 8f9ea86fdf99 ("sched: Always preserve the user
requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
__sched_setaffinity() unconditionally. This helps to expose a bug in
the current cpuset hotplug code where the cpumasks of the tasks in
the top cpuset are not updated at all when some CPUs become online or
offline. It is likely caused by the fact that some of the tasks in the
top cpuset, like percpu kthreads, cannot have their cpu affinity changed.

One way to reproduce this as suggested by Peter is:
 - boot machine
 - offline all CPUs except one
 - taskset -p ffffffff $$
 - online all CPUs

Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
includes offline CPUs for those tasks that are in the top cpuset. For
tasks not in the top cpuset, the old rule applies and only online CPUs
will be returned in the mask since hotplug events will update their
cpumasks accordingly.

Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
Reported-by: Will Deacon <will@kernel.org>
Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 207bafdb05e8..11554e5845f7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3707,15 +3707,38 @@ void __init cpuset_init_smp(void)
  * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
  * attached to the specified @tsk.  Guaranteed to return some non-empty
  * subset of cpu_online_mask, even if this means going outside the
- * tasks cpuset.
+ * tasks cpuset, except when the task is in the top cpuset.
  **/
 
 void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 {
 	unsigned long flags;
+	struct cpuset *cs;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	guarantee_online_cpus(tsk, pmask);
+	rcu_read_lock();
+
+	cs = task_cs(tsk);
+	if (cs != &top_cpuset)
+		guarantee_online_cpus(tsk, pmask);
+	/*
+	 * TODO: Tasks in the top cpuset won't get update to their cpumasks
+	 * when a hotplug online/offline event happens. So we include all
+	 * offline cpus in the allowed cpu list.
+	 */
+	if ((cs == &top_cpuset) || cpumask_empty(pmask)) {
+		const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+
+		/*
+		 * We first exclude cpus allocated to partitions. If there is no
+		 * allowable online cpu left, we fall back to all possible cpus.
+		 */
+		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);
+		if (!cpumask_intersects(pmask, cpu_online_mask))
+			cpumask_copy(pmask, possible_mask);
+	}
+
+	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
-- 
2.31.1

