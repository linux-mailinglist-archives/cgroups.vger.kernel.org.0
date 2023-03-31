Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9556D2310
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjCaOwv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Mar 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjCaOwt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Mar 2023 10:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC72520D82
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680274279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spcnenCmiq2qvQdcV7Gzytx8zR6D02wtS5KoOT6JRrs=;
        b=TmyIha7SbcMZwtlKksOLE6lHICiktsHNdlYM/hRvXxGAfdUdWeZhhYDqfC+IcztR7g4oQg
        xWSzxgHGdrLbeiavHUhLPf/sxK2RN0ytKUMzfA5hafNH7qoyW5xfvOT8VsuXbgyGPD1Qax
        NizYx1SU1MiU6gAqniujagjBfC2t738=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-HcamogozNVGQqZtQgZ91Hw-1; Fri, 31 Mar 2023 10:51:17 -0400
X-MC-Unique: HcamogozNVGQqZtQgZ91Hw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68BA41C0878B;
        Fri, 31 Mar 2023 14:51:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8BB3492B00;
        Fri, 31 Mar 2023 14:51:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] cgroup/cpuset: Allow only one active attach operation per cpuset
Date:   Fri, 31 Mar 2023 10:50:45 -0400
Message-Id: <20230331145045.2251683-4-longman@redhat.com>
In-Reply-To: <20230331145045.2251683-1-longman@redhat.com>
References: <20230331145045.2251683-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current cpuset code uses the global cpuset_attach_old_cs variable
to store the old cpuset value between consecutive cpuset_can_attach()
and cpuset_attach() calls. Since a caller of cpuset_can_attach() may
not need to hold the global cgroup_threadgroup_rwsem, parallel cpuset
attach operations are possible.

When there are concurrent cpuset attach operations in progress,
cpuset_attach() may fetch the wrong value from cpuset_attach_old_cs
causing incorrect result.  To avoid this problem while still allowing
certain level of parallelism, drop cpuset_attach_old_cs and use a
per-cpuset attach_old_cs value. Also restrict to at most one active
attach operation per cpuset to avoid corrupting the value of the
per-cpuset attach_old_cs value.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2367de611c42..3f925c261513 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -198,6 +198,8 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	struct cpuset *attach_old_cs;
 };
 
 /*
@@ -2456,22 +2458,27 @@ static int fmeter_getrate(struct fmeter *fmp)
 	return val;
 }
 
-static struct cpuset *cpuset_attach_old_cs;
-
 /* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
+	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	int ret;
 
 	/* used later by cpuset_attach() */
-	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
+	oldcs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
 	percpu_down_write(&cpuset_rwsem);
 
+	/*
+	 * Only one cpuset attach operation is allowed for each cpuset.
+	 */
+	ret = -EBUSY;
+	if (cs->attach_in_progress)
+		goto out_unlock;
+
 	/* allow moving tasks into an empty cpuset if on default hierarchy */
 	ret = -ENOSPC;
 	if (!is_in_v2_mode() &&
@@ -2498,6 +2505,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+	cs->attach_old_cs = oldcs;
 	ret = 0;
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
@@ -2548,7 +2556,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *leader;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
+	struct cpuset *oldcs;
 	bool cpus_updated, mems_updated;
 
 	cgroup_taskset_first(tset, &css);
@@ -2556,6 +2564,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	percpu_down_write(&cpuset_rwsem);
+	oldcs = cs->attach_old_cs;
 	cpus_updated = !cpumask_equal(cs->effective_cpus,
 				      oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
-- 
2.31.1

