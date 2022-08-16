Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C4595ED1
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiHPPLo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiHPPLn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 11:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D8972851
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660662699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DDEyD7Oc6PgrEZHkHqv7mnoGrf2YiFnazEzhrXs74I=;
        b=NnS3U9/P5PFbNZWmmSnI42ItC2B3hNfJRkg44LxlqNo2VDSnLtrXfg3xClm6wODe97qK5t
        /ptEbLV7lX+XHaArIln7GQwueNX5Jcc5qyT1znfCdF9qYzEHrMZ53bb6gXseMtWPKSddkm
        B2V4Z/9/ExdPVdIRk4PgdVh7/VnQW9E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-fJIR_h_2O9K3A2toj1k55g-1; Tue, 16 Aug 2022 11:11:36 -0400
X-MC-Unique: fJIR_h_2O9K3A2toj1k55g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2E663C11980;
        Tue, 16 Aug 2022 15:11:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7D3492C3B;
        Tue, 16 Aug 2022 15:11:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/3] cgroup/cpuset: Keep user set cpus affinity
Date:   Tue, 16 Aug 2022 11:11:19 -0400
Message-Id: <20220816151119.29534-4-longman@redhat.com>
In-Reply-To: <20220816151119.29534-1-longman@redhat.com>
References: <20220816151119.29534-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that any change to the current cpuset hierarchy may reset
the cpumask of the tasks in the affected cpusets to the default cpuset
value even if those tasks have cpus affinity explicitly set by the users
before. That is especially easy to trigger under a cgroup v2 environment
where writing "+cpuset" to the root cgroup's cgroup.subtree_control
file will reset the cpus affinity of all the processes in the system.

That is problematic in a nohz_full environment where the tasks running
in the nohz_full CPUs usually have their cpus affinity explicitly set
and will behave incorrectly if cpus affinity changes.

Fix this problem by looking at user_cpus_ptr which will be set if
cpus affinity have been explicitly set before and use it to restrcit
the given cpumask unless there is no overlap. In that case, it will
fallback to the given one.

With that change in place, it was verified that tasks that have its
cpus affinity explicitly set will not be affected by changes made to
the v2 cgroup.subtree_control files.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58aadfda9b8b..cabfac540fd8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -704,6 +704,30 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	return ret;
 }
 
+/*
+ * Preserve user provided cpumask (if set) as much as possible unless there
+ * is no overlap with the given mask.
+ */
+static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
+				       const struct cpumask *mask)
+{
+	if (p->user_cpus_ptr) {
+		cpumask_var_t new_mask;
+
+		if (alloc_cpumask_var(&new_mask, GFP_KERNEL) &&
+		    copy_user_cpus_mask(p, new_mask) &&
+		    cpumask_and(new_mask, new_mask, mask)) {
+			int ret = set_cpus_allowed_ptr(p, new_mask);
+
+			free_cpumask_var(new_mask);
+			return ret;
+		}
+		free_cpumask_var(new_mask);
+	}
+
+	return set_cpus_allowed_ptr(p, mask);
+}
+
 #ifdef CONFIG_SMP
 /*
  * Helper routine for generate_sched_domains().
@@ -1130,7 +1154,7 @@ static void update_tasks_cpumask(struct cpuset *cs)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
-		set_cpus_allowed_ptr(task, cs->effective_cpus);
+		cpuset_set_cpus_allowed_ptr(task, cs->effective_cpus);
 	css_task_iter_end(&it);
 }
 
@@ -2303,7 +2327,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
 		 */
-		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+		WARN_ON_ONCE(cpuset_set_cpus_allowed_ptr(task, cpus_attach));
 
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 		cpuset_update_task_spread_flag(cs, task);
-- 
2.31.1

