Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974C6CEEA8
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjC2QGV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjC2QFz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 12:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55AE5BBA
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680105799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdNce1OaiYHGRSBqnplg9LW3FvXe3v9Sj0lSo9jGEts=;
        b=LaCUro5cRA6G3MUtFUR5AYPSMlfAEdAaNTj70cwi2WK/9dS3VxVLZX0c4SBRFftbyJYAXx
        jDF7dxd7jDp72uIUJ/wrQkRYMLhagoAZShzp4kx1iSbprT1RDLVlPoy1Y1lgIRTZ5UjkpN
        b6Mi/ykaOOSC9rHIfHzfGMm0XHF76g4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-8Bgv-gTXP4SCXryUdo8LqA-1; Wed, 29 Mar 2023 12:03:14 -0400
X-MC-Unique: 8Bgv-gTXP4SCXryUdo8LqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 433FB3C0D85F;
        Wed, 29 Mar 2023 16:03:13 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B00C0202701F;
        Wed, 29 Mar 2023 16:03:11 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 6/7] cgroup/cpuset: Protect DL BW data against parallel cpuset_attach()
Date:   Wed, 29 Mar 2023 12:02:40 -0400
Message-Id: <20230329160240.2093277-1-longman@redhat.com>
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is possible to have parallel attach operations to the same cpuset in
progress. To avoid possible corruption of single set of DL BW data in
the cpuset structure, we have to disallow parallel attach operations if
DL tasks are present. Attach operations can still proceed in parallel
as long as no DL tasks are involved.

This patch also stores the CPU where DL BW is allocated and free that BW
back to the same CPU in case cpuset_can_attach() is called.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 05c0a1255218..555a6b1a2b76 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -199,6 +199,7 @@ struct cpuset {
 	 */
 	int nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
+	int dl_bw_cpu;
 	u64 sum_migrate_dl_bw;
 
 	/* Invalid partition error code, not lock protected */
@@ -2502,6 +2503,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	if (cpumask_empty(cs->effective_cpus))
 		goto out_unlock;
 
+	/*
+	 * If there is another parallel attach operations in progress for
+	 * the same cpuset, the single set of DL data there may get
+	 * incorrectly overwritten. So parallel operations are not allowed
+	 * if DL tasks are present.
+	 */
+	ret = -EBUSY;
+	if (cs->nr_migrate_dl_tasks)
+		goto out_unlock;
+
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
@@ -2511,6 +2522,9 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			goto out_unlock;
 
 		if (dl_task(task)) {
+			if (cs->attach_in_progress)
+				goto out_unlock;
+
 			cs->nr_migrate_dl_tasks++;
 			cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
@@ -2533,6 +2547,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			reset_migrate_dl_data(cs);
 			goto out_unlock;
 		}
+		cs->dl_bw_cpu = cpu;
 	}
 
 out_succes:
@@ -2559,9 +2574,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cs->attach_in_progress--;
 
 	if (cs->nr_migrate_dl_tasks) {
-		int cpu = cpumask_any(cs->effective_cpus);
-
-		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
+		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
 		reset_migrate_dl_data(cs);
 	}
 
-- 
2.31.1

