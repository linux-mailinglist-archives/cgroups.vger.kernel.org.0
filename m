Return-Path: <cgroups+bounces-12169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB431C7EE6B
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 04:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE9794E0EE2
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 03:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A844925F7B9;
	Mon, 24 Nov 2025 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5wp0N1y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60936D50C
	for <cgroups@vger.kernel.org>; Mon, 24 Nov 2025 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763955302; cv=none; b=qzR3EkP0ZlV9EBVXaqNNm7e6QuDm3Y5IWxILYrop3Oes70Y9mOR7qrxo62GfrcDCVUdJW5RKRuW9ZZHo6XkLpdyRG49mUQKCtajFA7h7XtC+NRaY7gQteDI6Q1OKjCnbBXY3GwgJXXkh9bTaIb0NlqxaLw9m7DgXPTuc55YtlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763955302; c=relaxed/simple;
	bh=R61HooRzOl5iZLZ+6eP6z5HBdBtySBxQEeqSgIVV6YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR7zQjYahKCu1n+CP+A1eOw+PGdT0X7TNPsXOuGcgcGxH6ptDOUmDvna6TEXIUlToFDLP9qLB+zrWeXbZzWmvThAYv7buApXwEL98zSOQ7kbK0X52mgL7CY7cFzxkDCDO7ekBO19fpQd5GrBY2zoDHMg/GSnrWYTSfUXX/Y2+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5wp0N1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763955298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3XHEpgyFAambA4QUXpRraFGSX1hDedeGitjAG9I5fc=;
	b=C5wp0N1yki+0zK2/M00jo3NHEPuYa8IzZ73LfLjk9NN0kjAzzyAAqQWMtQq7F6GU2xxuAA
	tCq+5RSOLZrUmhRaVkXnDNf/DpoR766o82P8yqKlpE8zuRBhEswRLRhZtGdudMdD+aq5r+
	rtrr3gPaPRi0CKQNKo9kSLPu27Urj40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-1pFamA8lMb2r8KR02bCvjg-1; Sun,
 23 Nov 2025 22:34:34 -0500
X-MC-Unique: 1pFamA8lMb2r8KR02bCvjg-1
X-Mimecast-MFC-AGG-ID: 1pFamA8lMb2r8KR02bCvjg_1763955272
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08DD01800447;
	Mon, 24 Nov 2025 03:34:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D9A919560A7;
	Mon, 24 Nov 2025 03:34:22 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/deadline: Fix potential race in dl_add_task_root_domain()
Date: Mon, 24 Nov 2025 11:34:15 +0800
Message-ID: <20251124033415.10784-1-piliu@redhat.com>
In-Reply-To: <https://lore.kernel.org/lkml/20251119095525.12019-3-piliu@redhat.com>
References: <https://lore.kernel.org/lkml/20251119095525.12019-3-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The access rule for local_cpu_mask_dl requires it to be called on the
local CPU with preemption disabled. However, dl_add_task_root_domain()
currently violates this rule.

Without preemption disabled, the following race can occur:

1. ThreadA calls dl_add_task_root_domain() on CPU 0
2. Gets pointer to CPU 0's local_cpu_mask_dl
3. ThreadA is preempted and migrated to CPU 1
4. ThreadA continues using CPU 0's local_cpu_mask_dl
5. Meanwhile, the scheduler on CPU 0 calls find_later_rq() which also
   uses local_cpu_mask_dl (with preemption properly disabled)
6. Both contexts now corrupt the same per-CPU buffer concurrently

Fix this by moving the local_cpu_mask_dl access to the preemption
disabled section.

Closes: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb
Fixes: 318e18ed22e8 ("sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug")
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: cgroups@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 kernel/sched/deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 194a341e85864..e9153e86de0a7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2944,7 +2944,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq *rq;
 	struct dl_bw *dl_b;
 	unsigned int cpu;
-	struct cpumask *msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
+	struct cpumask *msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2952,6 +2952,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
+	msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
 	/*
 	 * Get an active rq, whose rq->rd traces the correct root
 	 * domain.
-- 
2.49.0


