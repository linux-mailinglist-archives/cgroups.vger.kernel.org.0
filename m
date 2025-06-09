Return-Path: <cgroups+bounces-8467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E110BAD2A01
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 00:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E1171250
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C522688B;
	Mon,  9 Jun 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpWU8hZ3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DF2253F7
	for <cgroups@vger.kernel.org>; Mon,  9 Jun 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509792; cv=none; b=RibNov7DbDs/lOot3Ranp9w65LZPZlw6qWiVdDGRXa5tm8jfX/q1Ths3oO/CpvuWXuWqmp9q7ac6Sl1M3foxQwXENA15XpwoQZ2XG9WWc7wGPiq8VbqN4f8JnDuJhWM9gMuEp4bZo7Yag+CSRqTuWHxzBZjxIONsiKK4VCWt8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509792; c=relaxed/simple;
	bh=q/5uQgl9QRgYBR7ahdMseA6XxY7GRQsOpumksRP85aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GczlDTcahECYPCu2gfImw0p9D6h5oXvyvyy4R4lr/Jdu+sdsQMi8SLfyX3enlMwYK6dxy1a7LhEdTmHLc89ELBHx8L4DTei6/nBG3QzKtR6m+tZsvAmPMZP3O5RFmLwYqUFKo4F3L8x4TWfKOzIIYYptj3Q/M6F3mNXquN8jw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpWU8hZ3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749509788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ipQfALEF/dBZznaVw0Klj9I7jvOAPbti7+InyzJ+44=;
	b=wpWU8hZ36G9p/4DRgAXIGESz1EZxzTdj//O6Df64GuE54onSIdS0slIj7gKAPNCTbjrS5E
	2KlHWmrflLMQaEGV9qhrhaOUUtKUHOWD1/b0kpDDB9P0Am8exWCDg1FM8+obWe67EKAW5A
	2sbpiDjBNYfA05yQIppOJCGTFdOS1jI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Date: Mon,  9 Jun 2025 15:56:10 -0700
Message-ID: <20250609225611.3967338-3-shakeel.butt@linux.dev>
In-Reply-To: <20250609225611.3967338-1-shakeel.butt@linux.dev>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To make css_rstat_updated() able to safely run in nmi context, let's
move the rstat update tree creation at the flush side and use per-cpu
lockless lists in struct cgroup_subsys to track the css whose stats are
updated on that cpu.

The struct cgroup_subsys_state now has per-cpu lnode which needs to be
inserted into the corresponding per-cpu lhead of struct cgroup_subsys.
Since we want the insertion to be nmi safe, there can be multiple
inserters on the same cpu for the same lnode. The current llist does not
provide function to protect against the scenario where multiple
inserters can use the same lnode. So, using llist_node() out of the box
is not safe for this scenario.

However we can protect against multiple inserters using the same lnode
by using the fact llist node points to itself when not on the llist and
atomically reset it and select the winner as the single inserter.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 57 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a5608ae2be27..4fabd7973067 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -138,13 +138,15 @@ void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
  * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
- * rstat_cpu->updated_children list. See the comment on top of
- * css_rstat_cpu definition for details.
+ * Atomically inserts the css in the ss's llist for the given cpu. This is nmi
+ * safe. The ss's llist will be processed at the flush time to create the update
+ * tree.
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	unsigned long flags;
+	struct llist_head *lhead = ss_lhead_cpu(css->ss, cpu);
+	struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
+	struct llist_node *self;
 
 	/*
 	 * Since bpf programs can call this function, prevent access to
@@ -153,19 +155,37 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (!css_uses_rstat(css))
 		return;
 
+	lockdep_assert_preemption_disabled();
+
+	/*
+	 * For arch that does not support nmi safe cmpxchg, we ignore the
+	 * requests from nmi context for rstat update llist additions.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && in_nmi())
+		return;
+
+	/* If already on list return. */
+	if (llist_on_list(&rstatc->lnode))
+		return;
+
 	/*
-	 * Speculative already-on-list test. This may race leading to
-	 * temporary inaccuracies, which is fine.
+	 * Make sure only one insert request can proceed on this cpu for this
+	 * specific lnode and thus this needs to be safe against irqs and nmis.
 	 *
-	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @css is on the list by
-	 * testing the next pointer for NULL.
+	 * Please note that llist_add() does not protect against multiple
+	 * inserters for the same lnode. We use the fact that lnode points to
+	 * itself when not on a list and then atomically set it to NULL to
+	 * select the single inserter.
 	 */
-	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
+	self = &rstatc->lnode;
+	if (!try_cmpxchg(&(rstatc->lnode.next), &self, NULL))
 		return;
 
-	flags = _css_rstat_cpu_lock(css, cpu, true);
+	llist_add(&rstatc->lnode, lhead);
+}
 
+static void __css_process_update_tree(struct cgroup_subsys_state *css, int cpu)
+{
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
@@ -191,8 +211,19 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
 		css = parent;
 	}
+}
+
+static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
+{
+	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
+	struct llist_node *lnode;
+
+	while ((lnode = llist_del_first_init(lhead))) {
+		struct css_rstat_cpu *rstatc;
 
-	_css_rstat_cpu_unlock(css, cpu, flags, true);
+		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
+		__css_process_update_tree(rstatc->owner, cpu);
+	}
 }
 
 /**
@@ -300,6 +331,8 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	flags = _css_rstat_cpu_lock(root, cpu, false);
 
+	css_process_update_tree(root->ss, cpu);
+
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
 		goto unlock_ret;
-- 
2.47.1


