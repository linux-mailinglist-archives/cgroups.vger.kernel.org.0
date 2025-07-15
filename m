Return-Path: <cgroups+bounces-8739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173DB0639F
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528B45813F3
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623D2517B9;
	Tue, 15 Jul 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQrq+/hc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C61F30CC
	for <cgroups@vger.kernel.org>; Tue, 15 Jul 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595112; cv=none; b=OF3/9EVuLe4zWWSw1VsGSvFwU5H/aMk5+8VKGLL7MSApvUTqv9cFz6Di3nACw2hk6irTf0Q7Z2G/AdTNGPuTS7C2G6PkLXMbiuzN8R5alx5jXOi3Usu0k4y6LSZRZJRY0hhnQSRi69RWQCuNDcrmzPI7/CJiE2RVjZZDfcjIXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595112; c=relaxed/simple;
	bh=cKMlPCMr8z+Kl0EsCyLFR5dI/wqk1vQV8i2gO4zqriA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxhtAyQuUN+8ZZdimnuuBD/yJRpBJqMW3Komp/kHPMgsQ6YMynrw5d8H3FeveHuoBuJcmm9QMZr+qPq8nCpo1V9Bp71Cd5pMOrf9zW+ViRWY8GHXKEdY9u1Ar85mNrWN3JhNQG6JVQ5c8TL3TwWXRVg8xhPDz4wyTaUUmc7/9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQrq+/hc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OADDMNuAq8J8y+2fwgXMkukxv4NImbyH1LzAofLT2gg=;
	b=JQrq+/hclIT6JeqdYCYUW1vs+T2WiX2zwW8T3XNgXC/ovWkluBy8L3DhSLpt+776L56ah5
	lwn5LP4vcevhUFf6Pvcue3z86U8JN+VLTCpXZ5bvwioJaVps/CGRXnzTkPsd9WXY3cj2Xi
	dWgEzeISpbgL7yCPyYn82PJAn0JcP5I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-aE1RnelJMY2EGeYBE8J14A-1; Tue,
 15 Jul 2025 11:58:25 -0400
X-MC-Unique: aE1RnelJMY2EGeYBE8J14A-1
X-Mimecast-MFC-AGG-ID: aE1RnelJMY2EGeYBE8J14A_1752595104
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC79F19560B2;
	Tue, 15 Jul 2025 15:58:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.66.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39D921956096;
	Tue, 15 Jul 2025 15:58:18 +0000 (UTC)
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
Subject: [PATCH] sched/core: Mask out offline CPUs when user_cpus_ptr is used
Date: Tue, 15 Jul 2025 11:58:10 -0400
Message-ID: <20250715155810.514141-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Fix this failure by masking out offline CPUs when user_cpus_ptr masking
has to be done and fall back to ignoring user_cpus_ptr if the resulting
cpumask is empty.

Reported-by: Chen Ridong <chenridong@huaweicloud.com>
Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
Fixes: da019032819a ("sched: Enforce user requested affinity")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df1..4cf25dd8827f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3172,10 +3172,15 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
 	/*
 	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
 	 * flags are set.
+	 *
+	 * Even though the given new_mask must have at least one online CPU,
+	 * masking with user_cpus_ptr may strip out all online CPUs causing
+	 * failure. So offline CPUs have to be masked out too.
 	 */
 	if (p->user_cpus_ptr &&
 	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
-	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
+	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
+	    cpumask_and(rq->scratch_mask, rq->scratch_mask, cpu_active_mask))
 		ctx->new_mask = rq->scratch_mask;
 
 	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
-- 
2.50.0


