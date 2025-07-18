Return-Path: <cgroups+bounces-8778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10302B0A8E2
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3982B5C1A60
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E72E6D2E;
	Fri, 18 Jul 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J14utVha"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9712DEA8E
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857372; cv=none; b=TQ5Gc32fPeshpBSz2cbCZnzIVEtNLFpZz4NLnqJCjum5sw1BsQB6TYKKhrHgqp509oT3YPVTptMvSOxPCynwpg8q6Ln1gNL4VasqfSk7HoFaKxCjEDC7QsbvH8EuNzGrf3sVoIPdBoshWKKuZ8QB38r2yp83ZRmOJjs5k2ttfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857372; c=relaxed/simple;
	bh=4uoXBBfWbqYL3O4e8u7GIuSRK9OMIEk0Tri9CKXPXgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3xomWvMVWZGEX5QwnJ2U94KOKZwtj2c+W7OdqTAB78hf6dSqKuxgAQ1u3vp+J7HmPwPpQlhdCixNySV8Yvp68cH1e7qXHzlQzxoOP2RTxHpt47Ed9fVpnZ8o0c6hyk+rEtgM0ywXj2n8CD6QpQvNybwGvN/ul6OBgA2qRCZkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J14utVha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752857368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZcCp9t+rgA1nQ2OVuDyJEw0PACPvSc+gXRhn6+fay0=;
	b=J14utVhaOHdKtRu8wCqU87YJR/ZaR9REAm3d+HnwH6aNL4YC+ERFxWMBuFbzGm71IC8sPg
	c5cTyw6tzkqXax/uhcx7Fht76h4s8mbvDqi+NHEeD9JdOuztezp3W2mkOUaEhkcyjEiQ1Z
	JTIdtNwsRnLxIikFRSKhBimiDzj5MDE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-ep-vzKe8N7ei0CH1Pn3d3A-1; Fri,
 18 Jul 2025 12:49:25 -0400
X-MC-Unique: ep-vzKe8N7ei0CH1Pn3d3A-1
X-Mimecast-MFC-AGG-ID: ep-vzKe8N7ei0CH1Pn3d3A_1752857363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F280C180034E;
	Fri, 18 Jul 2025 16:49:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6F78180049D;
	Fri, 18 Jul 2025 16:49:19 +0000 (UTC)
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
Subject: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online CPU left
Date: Fri, 18 Jul 2025 12:48:56 -0400
Message-ID: <20250718164857.31963-1-longman@redhat.com>
In-Reply-To: <20250718164143.31338-1-longman@redhat.com>
References: <20250718164143.31338-1-longman@redhat.com>
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


