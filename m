Return-Path: <cgroups+bounces-7881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4438AA02C4
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 08:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DA7A8145
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292C2750FC;
	Tue, 29 Apr 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qa6imcJj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA82749D1
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907180; cv=none; b=k4MZf44KaRc3rI0o2IPxMSGD0xOJdCkNzIbHKvcLyS0IAYKhYTTJ9CPu1rqnkZhiqqaGHL1RaCe7uoPtdjzxdW9gK0loLiRzOtUhS2z0DO7aJBmhVN/Ed/PHQQT5tIhwGc/nhcBXjl14r5mNDFNyQpRNpXZ5IL9Buq74SqFaUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907180; c=relaxed/simple;
	bh=LGzOhpprAoBQZnCUsPj/B5Fwxfaw//sslHr+ORGEDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+q1/C8q2BUlw+bvpD93/sZ02Sw8PS2QccbNAMTm2zkRR8TdIPoSX9l36XGUVlS7tp2IuPzuq+jCgm9oSvgMpGqGCVdRxgcMwpOhKSuI6a+l2Vwc5UoSu7a+tnpMlUU8XZ7L6vUE6pV5f36T6cGtLSYGt3xJNUydMeOBGIaJRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qa6imcJj; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqpKBip5whX4ZC0ZaGAtJrvmSdx6nd074HOCBHkJ5Ac=;
	b=Qa6imcJjxykAmPNV/TT22Ru7Cjx3Dvd9LfbSP/iJBAFNAh845oZ0q8rXfAk44sv710Z0zs
	VaFpbjsP0/GobfHHADuUhqBF6uQJROwddwoaGXG5vM5Fdgk/vXlst6w0O4fH906uJKaszj
	OanLTE7r9YSNCbwn6IC3dAhS3w232TA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 3/3] cgroup: make css_rstat_updated nmi safe
Date: Mon, 28 Apr 2025 23:12:09 -0700
Message-ID: <20250429061211.1295443-4-shakeel.butt@linux.dev>
In-Reply-To: <20250429061211.1295443-1-shakeel.butt@linux.dev>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To make css_rstat_updated() able to safely run in nmi context, it can
not spin on locks and rather has to do trylock on the per-cpu per-ss raw
spinlock. This patch implements the backlog mechanism to handle the
failure in acquiring the per-cpu per-ss raw spinlock.

Each subsystem provides a per-cpu lockless list on which the kernel
stores the css given to css_rstat_updated() on trylock failure. These
lockless lists serve as backlog. On cgroup stats flushing code path, the
kernel first processes all the per-cpu lockless backlog lists of the
given ss and then proceeds to flush the update stat trees.

With css_rstat_updated() being nmi safe, the memch stats can and will be
converted to be nmi safe to enable nmi safe mem charging.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 99 +++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d3092b4c85d7..ac533e46afa9 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,7 @@
 
 static DEFINE_SPINLOCK(rstat_base_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
+static DEFINE_PER_CPU(struct llist_head, rstat_backlog_list);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -42,6 +43,13 @@ static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
 	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
 }
 
+static struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
+{
+	if (ss)
+		return per_cpu_ptr(ss->lhead, cpu);
+	return per_cpu_ptr(&rstat_backlog_list, cpu);
+}
+
 /*
  * Helper functions for rstat per CPU locks.
  *
@@ -86,6 +94,21 @@ unsigned long _css_rstat_cpu_lock(struct cgroup_subsys_state *css, int cpu,
 	return flags;
 }
 
+static __always_inline
+bool _css_rstat_cpu_trylock(struct cgroup_subsys_state *css, int cpu,
+			    unsigned long *flags)
+{
+	struct cgroup *cgrp = css->cgroup;
+	raw_spinlock_t *cpu_lock;
+	bool contended;
+
+	cpu_lock = ss_rstat_cpu_lock(css->ss, cpu);
+	contended = !raw_spin_trylock_irqsave(cpu_lock, *flags);
+	if (contended)
+		trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, contended);
+	return !contended;
+}
+
 static __always_inline
 void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
 		unsigned long flags, const bool fast_path)
@@ -102,32 +125,16 @@ void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 }
 
-/**
- * css_rstat_updated - keep track of updated rstat_cpu
- * @css: target cgroup subsystem state
- * @cpu: cpu on which rstat_cpu was updated
- *
- * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
- * rstat_cpu->updated_children list. See the comment on top of
- * css_rstat_cpu definition for details.
- */
-__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+static void css_add_to_backlog(struct cgroup_subsys_state *css, int cpu)
 {
-	unsigned long flags;
-
-	/*
-	 * Speculative already-on-list test. This may race leading to
-	 * temporary inaccuracies, which is fine.
-	 *
-	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @css is on the list by
-	 * testing the next pointer for NULL.
-	 */
-	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
-		return;
+	struct llist_head *lhead = ss_lhead_cpu(css->ss, cpu);
+	struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-	flags = _css_rstat_cpu_lock(css, cpu, true);
+	llist_add_iff_not_on_list(&rstatc->lnode, lhead);
+}
 
+static void __css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+{
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
@@ -153,6 +160,51 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
 		css = parent;
 	}
+}
+
+static void css_process_backlog(struct cgroup_subsys *ss, int cpu)
+{
+	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
+	struct llist_node *lnode;
+
+	while ((lnode = llist_del_first_init(lhead))) {
+		struct css_rstat_cpu *rstatc;
+
+		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
+		__css_rstat_updated(rstatc->owner, cpu);
+	}
+}
+
+/**
+ * css_rstat_updated - keep track of updated rstat_cpu
+ * @css: target cgroup subsystem state
+ * @cpu: cpu on which rstat_cpu was updated
+ *
+ * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
+ * rstat_cpu->updated_children list. See the comment on top of
+ * css_rstat_cpu definition for details.
+ */
+__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+{
+	unsigned long flags;
+
+	/*
+	 * Speculative already-on-list test. This may race leading to
+	 * temporary inaccuracies, which is fine.
+	 *
+	 * Because @parent's updated_children is terminated with @parent
+	 * instead of NULL, we can tell whether @css is on the list by
+	 * testing the next pointer for NULL.
+	 */
+	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
+		return;
+
+	if (!_css_rstat_cpu_trylock(css, cpu, &flags)) {
+		css_add_to_backlog(css, cpu);
+		return;
+	}
+
+	__css_rstat_updated(css, cpu);
 
 	_css_rstat_cpu_unlock(css, cpu, flags, true);
 }
@@ -255,6 +307,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	flags = _css_rstat_cpu_lock(root, cpu, false);
 
+	css_process_backlog(root->ss, cpu);
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
 		goto unlock_ret;
-- 
2.47.1


