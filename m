Return-Path: <cgroups+bounces-144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9A7DE466
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E28B20F1F
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5A14290;
	Wed,  1 Nov 2023 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X19jPjsC"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDE12B8B
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 16:09:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AEAFD
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698854979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=weAhIXN5PXtoiXEIYu5w/2Q9wOZehC52EigYsa65J4Y=;
	b=X19jPjsCkgySVfFk6L0r9LFdN2TfT/jMR4C4EtEfjbjOUruVWweBIK0MJylBolcqGk3cuX
	98MzMgo/zaEh5FqXnKBVqts7oPfLtQ148zgvN0or5Ehggn4lup4Y3SALlKpJnWTk/nxp7v
	obCGVkX0fyyNWCrO86hfhjYQWaNer9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-EnA82G9lNGKQ5WKHccFtRQ-1; Wed, 01 Nov 2023 12:09:36 -0400
X-MC-Unique: EnA82G9lNGKQ5WKHccFtRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E197D881E24;
	Wed,  1 Nov 2023 16:09:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79414C1290F;
	Wed,  1 Nov 2023 16:09:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
Date: Wed,  1 Nov 2023 12:09:11 -0400
Message-Id: <20231101160911.394526-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

When cgroup_rstat_updated() isn't being called concurrently with
cgroup_rstat_flush_locked(), its run time is pretty short. When
both are called concurrently, the cgroup_rstat_updated() run time
can spike to a pretty high value due to high cpu_lock hold time in
cgroup_rstat_flush_locked(). This can be problematic if the task calling
cgroup_rstat_updated() is a realtime task running on an isolated CPU
with a strict latency requirement. The cgroup_rstat_updated() call can
happens when there is a page fault even though the task is running in
user space most of the time.

The percpu cpu_lock is used to protect the update tree -
updated_next and updated_children. This protection is only needed
when cgroup_rstat_cpu_pop_updated() is being called. The subsequent
flushing operation which can take a much longer time does not need
that protection.

To reduce the cpu_lock hold time, we need to perform all the
cgroup_rstat_cpu_pop_updated() calls up front with the lock
released afterward before doing any flushing. This patch adds a new
cgroup_rstat_flush_list() function to do just that and return a singly
linked list of cgroup_rstat_cpu structures to be flushed.

By adding some instrumentation code to measure the maximum elapsed times
of the new cgroup_rstat_flush_list() function and each cpu iteration
of cgroup_rstat_flush_locked() around the old cpu_lock lock/unlock pair
on a 2-socket x86-64 server running parallel kernel build, the maximum
elapsed times are 31us and 118us respectively. The maximum cpu_lock
hold time is now reduced to about 1/4 of the original.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h |  7 +++++
 kernel/cgroup/rstat.c       | 57 +++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 265da00a1a8b..22adb94ebb74 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -368,6 +368,13 @@ struct cgroup_rstat_cpu {
 	 */
 	struct cgroup *updated_children;	/* terminated by self cgroup */
 	struct cgroup *updated_next;		/* NULL iff not on the list */
+
+	/*
+	 * A singly-linked list of cgroup_rstat_cpu structures to be flushed.
+	 * Protected by cgroup_rstat_lock.
+	 */
+	struct cgroup_rstat_cpu *flush_next;
+	struct cgroup *cgroup;			/* Cgroup back pointer */
 };
 
 struct cgroup_freezer_state {
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d80d7a608141..93ef2795a68d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -145,6 +145,42 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/*
+ * Return a list of cgroup_rstat_cpu structures to be flushed
+ */
+static struct cgroup_rstat_cpu *cgroup_rstat_flush_list(struct cgroup *root,
+							int cpu)
+{
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	struct cgroup_rstat_cpu *head = NULL, *tail, *next;
+	unsigned long flags;
+	struct cgroup *pos;
+
+	/*
+	 * The _irqsave() is needed because cgroup_rstat_lock is
+	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
+	 * this lock with the _irq() suffix only disables interrupts on
+	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
+	 * interrupts on both configurations. The _irqsave() ensures
+	 * that interrupts are always disabled and later restored.
+	 */
+	raw_spin_lock_irqsave(cpu_lock, flags);
+	pos = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
+	if (!pos)
+		goto unlock;
+
+	head = tail = cgroup_rstat_cpu(pos, cpu);
+	while ((pos = cgroup_rstat_cpu_pop_updated(pos, root, cpu))) {
+		next = cgroup_rstat_cpu(pos, cpu);
+		tail->flush_next = next;
+		tail = next;
+	}
+	tail->flush_next = NULL;
+unlock:
+	raw_spin_unlock_irqrestore(cpu_lock, flags);
+	return head;
+}
+
 /*
  * A hook for bpf stat collectors to attach to and flush their stats.
  * Together with providing bpf kfuncs for cgroup_rstat_updated() and
@@ -179,23 +215,14 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
-						       cpu);
-		struct cgroup *pos = NULL;
-		unsigned long flags;
+		struct cgroup_rstat_cpu *rstat_cpu_next;
 
-		/*
-		 * The _irqsave() is needed because cgroup_rstat_lock is
-		 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-		 * this lock with the _irq() suffix only disables interrupts on
-		 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-		 * interrupts on both configurations. The _irqsave() ensures
-		 * that interrupts are always disabled and later restored.
-		 */
-		raw_spin_lock_irqsave(cpu_lock, flags);
-		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
+		rstat_cpu_next = cgroup_rstat_flush_list(cgrp, cpu);
+		while (rstat_cpu_next) {
+			struct cgroup *pos = rstat_cpu_next->cgroup;
 			struct cgroup_subsys_state *css;
 
+			rstat_cpu_next = rstat_cpu_next->flush_next;
 			cgroup_base_stat_flush(pos, cpu);
 			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
@@ -205,7 +232,6 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		raw_spin_unlock_irqrestore(cpu_lock, flags);
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
@@ -281,6 +307,7 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 
 		rstatc->updated_children = cgrp;
+		rstatc->cgroup = cgrp;
 		u64_stats_init(&rstatc->bsync);
 	}
 
-- 
2.39.3


