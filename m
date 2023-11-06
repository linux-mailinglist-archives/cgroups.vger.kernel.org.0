Return-Path: <cgroups+bounces-202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DA47E2E9A
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 22:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CEC280D3E
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903BE2E64C;
	Mon,  6 Nov 2023 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Am9wcnFL"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969102E645
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 21:06:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F485D51
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699304775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfEa/PGrfaQZvR+CyJp9bolRL2l7BniJt6LJ8tbhPMY=;
	b=Am9wcnFLAehlKYhhbcg4Qjy+lnW2dPS4EKVZYnf9BmoP88FXeMrbGueXCZh39MxAhBibOt
	peL+QgrX3/h99bQB4nMXhQyXyvyVhZ064HLKaDmPaAPBzoVdEzgve5BQ0H/5oF5Xvqyjvx
	owdP3pQNmaLNEfE54ee3kWpa53qlqJs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-EQmo40T3O0GojW5nqBdPsA-1; Mon,
 06 Nov 2023 16:06:10 -0500
X-MC-Unique: EQmo40T3O0GojW5nqBdPsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEE242800E96;
	Mon,  6 Nov 2023 21:06:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.168])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4116BC016B9;
	Mon,  6 Nov 2023 21:06:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/3] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
Date: Mon,  6 Nov 2023 16:05:41 -0500
Message-Id: <20231106210543.717486-2-longman@redhat.com>
In-Reply-To: <20231106210543.717486-1-longman@redhat.com>
References: <20231106210543.717486-1-longman@redhat.com>
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
happen when there is a page fault even though the task is running in
user space most of the time.

The percpu cpu_lock is used to protect the update tree -
updated_next and updated_children. This protection is only needed when
cgroup_rstat_cpu_pop_updated() is being called. The subsequent flushing
operation which can take a much longer time does not need that protection
as it is already protected by cgroup_rstat_lock.

To reduce the cpu_lock hold time, we need to perform all the
cgroup_rstat_cpu_pop_updated() calls up front with the lock
released afterward before doing any flushing. This patch adds a new
cgroup_rstat_updated_list() function to return a singly linked list of
cgroups to be flushed.

Some instrumentation code are added to measure the cpu_lock hold time
right after lock acquisition to after releasing the lock. Parallel
kernel build on a 2-socket x86-64 server is used as the benchmarking
tool for measuring the lock hold time.

The maximum cpu_lock hold time before and after the patch are 100us and
29us respectively. So the worst case time is reduced to about 30% of
the original. However, there may be some OS or hardware noises like NMI
or SMI in the test system that can worsen the worst case value. Those
noises are usually tuned out in a real production environment to get
a better result.

OTOH, the lock hold time frequency distribution should give a better
idea of the performance benefit of the patch.  Below were the frequency
distribution before and after the patch:

     Hold time        Before patch       After patch
     ---------        ------------       -----------
       0-01 us           804,139         13,738,708
      01-05 us         9,772,767          1,177,194
      05-10 us         4,595,028              4,984
      10-15 us           303,481              3,562
      15-20 us            78,971              1,314
      20-25 us            24,583                 18
      25-30 us             6,908                 12
      30-40 us             8,015
      40-50 us             2,192
      50-60 us               316
      60-70 us                43
      70-80 us                 7
      80-90 us                 2
        >90 us                 3

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/cgroup-defs.h |  7 ++++++
 kernel/cgroup/rstat.c       | 43 ++++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 265da00a1a8b..ff4b4c590f32 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -491,6 +491,13 @@ struct cgroup {
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
 	struct list_head rstat_css_list;
 
+	/*
+	 * A singly-linked list of cgroup structures to be rstat flushed.
+	 * This is a scratch field to be used exclusively by
+	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
+	 */
+	struct cgroup	*rstat_flush_next;
+
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d80d7a608141..1f300bf4dc40 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -145,6 +145,32 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/* Return a list of updated cgroups to be flushed */
+static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
+{
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	struct cgroup *head, *tail, *next;
+	unsigned long flags;
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
+	head = tail = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
+	while (tail) {
+		next = cgroup_rstat_cpu_pop_updated(tail, root, cpu);
+		tail->rstat_flush_next = next;
+		tail = next;
+	}
+	raw_spin_unlock_irqrestore(cpu_lock, flags);
+	return head;
+}
+
 /*
  * A hook for bpf stat collectors to attach to and flush their stats.
  * Together with providing bpf kfuncs for cgroup_rstat_updated() and
@@ -179,21 +205,9 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
-						       cpu);
-		struct cgroup *pos = NULL;
-		unsigned long flags;
+		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
 
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
+		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
@@ -205,7 +219,6 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		raw_spin_unlock_irqrestore(cpu_lock, flags);
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-- 
2.39.3


