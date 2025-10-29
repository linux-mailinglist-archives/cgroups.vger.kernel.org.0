Return-Path: <cgroups+bounces-11408-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC28C1D6F8
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E82E18828EE
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6431985D;
	Wed, 29 Oct 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyNQuS+3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEE314D24
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773281; cv=none; b=qjCZfM4LHzOc8NPTkjT9EBLgQeVTxcKeiC0mtP/GDUi2LBguZpR7j0k/HoyCWcdVy5jfz4QJHPDEkTBCz4IJP9KT1tCEPmXqitntRxMMnfOG2kruDc+HUEtIOvaLiyDLJhflWDKBdijPJzp7dblp1BRSHJ0E+jGxkdxiIf6FxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773281; c=relaxed/simple;
	bh=Ol8uIjpXLm5JLToEvmrotc3+xfQ9a2v4MOzvl4YW6/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMgSqBokcMYVSIqqSnavXiwPBg0LphJwJilN7UPO7dyeVn04qPRVkJh+UgOlsY9dHMB41NB3wD/ErwYUEXRi2t3W7eq96FG1uFblnwkA1Oifj0cD8RwHANGWaPbzEbTas1KqbNHyrmXt7LNlIiZhy+CSmqXjEFnmEWVvgGYRr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyNQuS+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761773279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdlxoXp1B1UCIfE5AuCnbPjiaDl2Ha4WytPV9wHK+Cs=;
	b=gyNQuS+339yBlmRczVjFdE3ShdEtpl33umQIPShpxmpeEbFWCTgDHbnm0d6ErxwzNQ5ZsR
	FRACKd1OnnD+ELZiS4t64yC9ACdBeVc2P+NrbcMLVp6hLODVTjdnqOhO1xbV2sSLU+nryy
	cpNT9R2/jl/AG70Qyn6If0HMTVLtAGg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-8n-ZHefuPgCGwyEAwcPM8w-1; Wed,
 29 Oct 2025 17:27:55 -0400
X-MC-Unique: 8n-ZHefuPgCGwyEAwcPM8w-1
X-Mimecast-MFC-AGG-ID: 8n-ZHefuPgCGwyEAwcPM8w_1761773274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B1CE195422D;
	Wed, 29 Oct 2025 21:27:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2411A1955F1B;
	Wed, 29 Oct 2025 21:27:46 +0000 (UTC)
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
Subject: [RESEND PATCH v3] sched/core: Skip user_cpus_ptr masking if no online CPU left
Date: Wed, 29 Oct 2025 17:27:24 -0400
Message-ID: <20251029212724.1005063-1-longman@redhat.com>
In-Reply-To: <20250718164143.31338-1-longman@redhat.com>
References: <20250718164143.31338-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Chen Ridong reported that cpuset could report a kernel warning for a task
due to set_cpus_allowed_ptr() returning failure in the corner case that:

1) the task used sched_setaffinity(2) to set its CPU affinity mask to
   be the same as the cpuset.cpus of its cpuset,
2) all the CPUs assigned to that cpuset were taken offline, and
3) cpuset v1 is in use and the task had to be migrated to top_cpuset.
   Task migration is not needed for cpuset v2.

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
index f1ebf67b48e2..66cd21582822 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3146,12 +3146,13 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
 
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
2.51.0


