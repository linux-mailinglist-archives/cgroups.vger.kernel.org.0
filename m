Return-Path: <cgroups+bounces-172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A747E0D69
	for <lists+cgroups@lfdr.de>; Sat,  4 Nov 2023 04:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A11F225FC
	for <lists+cgroups@lfdr.de>; Sat,  4 Nov 2023 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFEB3D8A;
	Sat,  4 Nov 2023 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC36yAi0"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD61FA2
	for <cgroups@vger.kernel.org>; Sat,  4 Nov 2023 03:13:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D72BD71
	for <cgroups@vger.kernel.org>; Fri,  3 Nov 2023 20:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699067604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ag+X6OdrPM4qcS+lve0uYD4xt7fsfaJmYoOAVQ+n5M0=;
	b=fC36yAi0OxjF+foF+lLHo43trLXkbH62c20NDbq2uP3kBhElVdDxp5+lMhX534khIjqKzt
	AmtqvKyU6he7DYk4Loi3uWVTQBOoSIn0kHgw/uuX1CVdLjh+gvqzeiixwgAzpxA2Vd8sW2
	KfdpBfT9XBdBh/TMfVn0TI+RPW4czo0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-spme2rO_PhOq1tF1su41mw-1; Fri,
 03 Nov 2023 23:13:19 -0400
X-MC-Unique: spme2rO_PhOq1tF1su41mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A1FE29A9A10;
	Sat,  4 Nov 2023 03:13:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B72AC1290F;
	Sat,  4 Nov 2023 03:13:18 +0000 (UTC)
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
Subject: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Date: Fri,  3 Nov 2023 23:13:02 -0400
Message-Id: <20231104031303.592879-3-longman@redhat.com>
In-Reply-To: <20231104031303.592879-1-longman@redhat.com>
References: <20231104031303.592879-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The current design of cgroup_rstat_cpu_pop_updated() is to traverse
the updated tree in a way to pop out the leaf nodes first before
their parents. This can cause traversal of multiple nodes before a
leaf node can be found and popped out. IOW, a given node in the tree
can be visited multiple times before the whole operation is done. So
it is not very efficient and the code can be hard to read.

With the introduction of cgroup_rstat_updated_list() to build a list
of cgroups to be flushed first before any flushing operation is being
done, we can optimize the way the updated tree nodes are being popped
by pushing the parents first to the tail end of the list before their
children. In this way, most updated tree nodes will be visited only
once with the exception of the subtree root as we still need to go
back to its parent and popped it out of its updated_children list.
This also makes the code easier to read.

A parallel kernel build on a 2-socket x86-64 server is used as the
benchmarking tool for measuring the lock hold time. Below were the lock
hold time frequency distribution before and after the patch:

     Hold time        Before patch       After patch
     ---------        ------------       -----------
       0-01 us        13,738,708         14,594,545
      01-05 us         1,177,194            439,926
      05-10 us             4,984              5,960
      10-15 us             3,562              3,543
      15-20 us             1,314              1,397
      20-25 us                18                 25
      25-30 us                12                 12

It can be seen that the patch pushes the lock hold time towards the
lower end.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/rstat.c | 132 ++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 62 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1f300bf4dc40..d2b709cfeb2a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -74,64 +74,90 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 }
 
 /**
- * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu updated tree
- * @pos: current position
- * @root: root of the tree to traversal
+ * cgroup_rstat_push_children - push children cgroups into the given list
+ * @head: current head of the list (= parent cgroup)
+ * @prstatc: cgroup_rstat_cpu of the parent cgroup
  * @cpu: target cpu
+ * Return: A new singly linked list of cgroups to be flush
  *
- * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
- * the traversal and %NULL return indicates the end.  During traversal,
- * each returned cgroup is unlinked from the tree.  Must be called with the
- * matching cgroup_rstat_cpu_lock held.
+ * Recursively traverse down the cgroup_rstat_cpu updated tree and push
+ * parent first before its children. The parent is pushed by the caller.
+ * The recursion depth is the depth of the current updated tree.
+ */
+static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
+				struct cgroup_rstat_cpu *prstatc, int cpu)
+{
+	struct cgroup *child, *parent;
+	struct cgroup_rstat_cpu *crstatc;
+
+	parent = head;
+	child = prstatc->updated_children;
+	prstatc->updated_children = parent;
+
+	/* updated_next is parent cgroup terminated */
+	while (child != parent) {
+		child->rstat_flush_next = head;
+		head = child;
+		crstatc = cgroup_rstat_cpu(child, cpu);
+		if (crstatc->updated_children != parent)
+			head = cgroup_rstat_push_children(head, crstatc, cpu);
+		child = crstatc->updated_next;
+		crstatc->updated_next = NULL;
+	}
+	return head;
+}
+
+/**
+ * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
+ * @root: root of the cgroup subtree to traverse
+ * @cpu: target cpu
+ * Return: A singly linked list of cgroups to be flushed
+ *
+ * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
+ * each returned cgroup is unlinked from the updated tree.  Must be called
+ * with the matching cgroup_rstat_cpu_lock held.
  *
  * The only ordering guarantee is that, for a parent and a child pair
- * covered by a given traversal, if a child is visited, its parent is
- * guaranteed to be visited afterwards.
+ * covered by a given traversal, the child is before its parent in
+ * the list.
+ *
+ * Note that updated_children is self terminated while updated_next is
+ * parent cgroup terminated except the cgroup root which can be self
+ * terminated.
  */
-static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
-						   struct cgroup *root, int cpu)
+static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc;
-	struct cgroup *parent;
-
-	if (pos == root)
-		return NULL;
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
+	struct cgroup *head = NULL, *parent;
+	unsigned long flags;
 
 	/*
-	 * We're gonna walk down to the first leaf and visit/remove it.  We
-	 * can pick whatever unvisited node as the starting point.
+	 * The _irqsave() is needed because cgroup_rstat_lock is
+	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
+	 * this lock with the _irq() suffix only disables interrupts on
+	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
+	 * interrupts on both configurations. The _irqsave() ensures
+	 * that interrupts are always disabled and later restored.
 	 */
-	if (!pos) {
-		pos = root;
-		/* return NULL if this subtree is not on-list */
-		if (!cgroup_rstat_cpu(pos, cpu)->updated_next)
-			return NULL;
-	} else {
-		pos = cgroup_parent(pos);
-	}
+	raw_spin_lock_irqsave(cpu_lock, flags);
 
-	/* walk down to the first leaf */
-	while (true) {
-		rstatc = cgroup_rstat_cpu(pos, cpu);
-		if (rstatc->updated_children == pos)
-			break;
-		pos = rstatc->updated_children;
-	}
+	/* Return NULL if this subtree is not on-list */
+	if (!rstatc->updated_next)
+		goto unlock_ret;
 
 	/*
-	 * Unlink @pos from the tree.  As the updated_children list is
+	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
-	 * However, due to the way we traverse, @pos will be the first
-	 * child in most cases. The only exception is @root.
 	 */
-	parent = cgroup_parent(pos);
+	parent = cgroup_parent(root);
 	if (parent) {
 		struct cgroup_rstat_cpu *prstatc;
 		struct cgroup **nextp;
 
 		prstatc = cgroup_rstat_cpu(parent, cpu);
 		nextp = &prstatc->updated_children;
-		while (*nextp != pos) {
+		while (*nextp != root) {
 			struct cgroup_rstat_cpu *nrstatc;
 
 			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
@@ -142,31 +168,13 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	}
 
 	rstatc->updated_next = NULL;
-	return pos;
-}
-
-/* Return a list of updated cgroups to be flushed */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
-{
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup *head, *tail, *next;
-	unsigned long flags;
 
-	/*
-	 * The _irqsave() is needed because cgroup_rstat_lock is
-	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-	 * this lock with the _irq() suffix only disables interrupts on
-	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-	 * interrupts on both configurations. The _irqsave() ensures
-	 * that interrupts are always disabled and later restored.
-	 */
-	raw_spin_lock_irqsave(cpu_lock, flags);
-	head = tail = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
-	while (tail) {
-		next = cgroup_rstat_cpu_pop_updated(tail, root, cpu);
-		tail->rstat_flush_next = next;
-		tail = next;
-	}
+	/* Push @root to the list first before pushing the children */
+	head = root;
+	root->rstat_flush_next = NULL;
+	if (rstatc->updated_children != root)
+		head = cgroup_rstat_push_children(head, rstatc, cpu);
+unlock_ret:
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 	return head;
 }
-- 
2.39.3


