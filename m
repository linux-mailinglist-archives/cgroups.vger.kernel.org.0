Return-Path: <cgroups+bounces-8776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CABB0A8A7
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA78A83C49
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6462E6D1D;
	Fri, 18 Jul 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SByd7Bx5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4431EB5B
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856921; cv=none; b=puITGK8XfXim1TSf6dKhXZkU4u+lOXCXcbm7dQd4wfYnp9cWPWddnQHKJxUD/MXFnb/pa58oPIovdVN1MDYjC3IVhcddjrME6cSvkQpAlinkZLyjXWNuQ46GmruKzG5RESjYTtXP2vbA4x7zpJnLzfk7Kg6qbHVz1GgmL/Vo8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856921; c=relaxed/simple;
	bh=4uoXBBfWbqYL3O4e8u7GIuSRK9OMIEk0Tri9CKXPXgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXaMYwlh4MXqENsppHItzeG7f7B+GLlKd8gU8CIu4tQD46Xl0VPWrqE+QfahSnQsFubsLhoMoXIioQxgor76v1+3QTsH4Ig4JsNsp6o/+x+fC8dg6ac5isovG/IXUNCvtmsH81BnKKobZAYsRbDMrdP07VToIQV/R+fqRtO1ACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SByd7Bx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752856918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aZcCp9t+rgA1nQ2OVuDyJEw0PACPvSc+gXRhn6+fay0=;
	b=SByd7Bx55+njhM7QQgLpgKNw0u7jJjWIV2nS7j7aM7UiP1vs6CtBar3vjko3I5Kav5aJGA
	Szl/LK1OUWxtXI8bm31MsCOJncrp84WM2NWPonYiWD8BkC5bw8pPzs4pQNekR19FQgi24v
	Re9XOF5SHuTSIBp1idHnVqx/29ZVNqU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-YmvIhxf8Niu_G_fXWBgeVQ-1; Fri,
 18 Jul 2025 12:41:55 -0400
X-MC-Unique: YmvIhxf8Niu_G_fXWBgeVQ-1
X-Mimecast-MFC-AGG-ID: YmvIhxf8Niu_G_fXWBgeVQ_1752856913
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E62B1956095;
	Fri, 18 Jul 2025 16:41:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29D4D18003FC;
	Fri, 18 Jul 2025 16:41:49 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] sched/core: Mask out offline CPUs when user_cpus_ptr is used
Date: Fri, 18 Jul 2025 12:41:43 -0400
Message-ID: <20250718164143.31338-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Chen Ridong reported that cpuset could report a kernel warning for a task
due to set_cpus_allowed_ptr() returning failure in the corner case that:

1) the task used sched_setaffinity(2) to set its CPU affinity mask to
   be the same as the cpuset.cpus of its cpuset,
2) all the CPUs assigned to that cpuset were taken offline, and
3) cpuset v1 is in use and the task had to be migrated to the top cpuset.

Due to the fact that CPU affinity of the tasks in the top cpuset are
not updated when a CPU hotplug online/offline event happens, offline
CPUs are included in CPU affinity of those tasks. It is possible
that further masking with user_cpus_ptr set by sched_setaffinity(2)
in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
to return failure with an empty CPU affinity.

Fix this failure by skipping user_cpus_ptr masking if there is no online
CPU left.

Reported-by: Chen Ridong <chenridong@huaweicloud.com>
Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
Fixes: da019032819a ("sched: Enforce user requested affinity")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df1..208f8af73134 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3170,12 +3170,13 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
 
 	rq = task_rq_lock(p, &rf);
 	/*
-	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
-	 * flags are set.
+	 * Masking should be skipped if SCA_USER, any of the SCA_MIGRATE_*
+	 * flags are set or no online CPU left.
 	 */
 	if (p->user_cpus_ptr &&
 	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
-	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
+	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
+	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
 		ctx->new_mask = rq->scratch_mask;
 
 	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
-- 
2.50.0


