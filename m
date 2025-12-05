Return-Path: <cgroups+bounces-12271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3621CA5E61
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 03:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80EBC309AE3A
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D52DEA89;
	Fri,  5 Dec 2025 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jniu2i4T"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA842DE718
	for <cgroups@vger.kernel.org>; Fri,  5 Dec 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764901516; cv=none; b=k9RkCsrfkN7zN4bfnGjUpzukymUHhV0iommwgO2ArgDLXbLaa5sotJBXvpv4fKXXJZR+BVa/BFJs7LjX1pKLhhd0b6rN5XVspHePtBvjo+YDR281g34ddIIPu+69TkMjY+1juTBjdhsLJnNBgF4Xx9c8S3Hv95YtgSv1TXtEieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764901516; c=relaxed/simple;
	bh=SyifzKul4ctMh74hj13/AACTWrSeJbpEBM9kZ89WFCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqDK8Sah0ewLkKQN0OrowdvSXCW+l0cQIR40FuFB81z15nNZ+6mhVW2oLFwFjymay9Dgf4GzVF4av8fdbJxDH/XCC8EFfHBnzToq7BxY4dxiXaLLEDbQLqyK5kf8ThhJcQraRrrFXVvlKqxIXeLbrY0xB7TzxnFGVIcUWbJQkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jniu2i4T; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764901501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KAZkzowfBam2M1V24QpnRECZ6TDi4HphjwzU/c/0E4c=;
	b=Jniu2i4T5OR3rn521UQaQZq9Mc0MaK4h8AyAbHn1oXSSA8VQjdK7q7Fn0/vyaN5wPc2e+7
	o+J3FIJgjLXm9VbI/krrDQMUybZD4PzFvy3o9gJnLiirYj88wrN2hYgy9cL/84RZBgYsAu
	M9jq+KBisBbUkBz87Zw1g0gutwllHJM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Date: Thu,  4 Dec 2025 18:24:37 -0800
Message-ID: <20251205022437.1743547-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On x86-64, this_cpu_cmpxchg() uses CMPXCHG without LOCK prefix which
means it is only safe for the local CPU and not for multiple CPUs.
Recently the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
safe") make css_rstat_updated lockless and uses lockless list to allow
reentrancy. Since css_rstat_updated can invoked from process context,
IRQ and NMI, it uses this_cpu_cmpxchg() to select the winner which will
inset the lockless lnode into the global per-cpu lockless list.

However the commit missed one case where lockless node of a cgroup can
be accessed and modified by another CPU doing the flushing. Basically
llist_del_first_init() in css_process_update_tree().

On a cursory look, it can be questioned how css_process_update_tree()
can see a lockless node in global lockless list where the updater is at
this_cpu_cmpxchg() and before llist_add() call in css_rstat_updated().
This can indeed happen in the presence of IRQs/NMI.

Consider this scenario: Updater for cgroup stat C on CPU A in process
context is after llist_on_list() check and before this_cpu_cmpxchg() in
css_rstat_updated() where it get interrupted by IRQ/NMI. In the IRQ/NMI
context, a new updater calls css_rstat_updated() for same cgroup C and
successfully inserts rstatc_pcpu->lnode.

Now concurrently CPU B is running the flusher and it calls
llist_del_first_init() for CPU A and got rstatc_pcpu->lnode of cgroup C
which was added by the IRQ/NMI updater.

Now imagine CPU B calling init_llist_node() on cgroup C's
rstatc_pcpu->lnode of CPU A and on CPU A, the process context updater
calling this_cpu_cmpxchg(rstatc_pcpu->lnode) concurrently.

The CMPXCNG without LOCK on CPU A is not safe and thus we need LOCK
prefix.

In Meta's fleet running the kernel with the commit 36df6e3dbd7e, we are
observing on some machines the memcg stats are getting skewed by more
than the actual memory on the system. On close inspection, we noticed
that lockless node for a workload for specific CPU was in the bad state
and thus all the updates on that CPU for that cgroup was being lost. At
the moment, we are not sure if this CMPXCHG without LOCK is the cause of
that but this needs to be fixed irrespective.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
---
 kernel/cgroup/rstat.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 91b34ebd5370..99aa7e557f92 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -71,8 +71,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
 	struct llist_head *lhead;
 	struct css_rstat_cpu *rstatc;
-	struct css_rstat_cpu __percpu *rstatc_pcpu;
-	struct llist_node *self;
+	struct llist_node *expected;
 
 	/*
 	 * Since bpf programs can call this function, prevent access to
@@ -113,9 +112,8 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	 * successful and the winner will eventually add the per-cpu lnode to
 	 * the llist.
 	 */
-	self = &rstatc->lnode;
-	rstatc_pcpu = css->rstat_cpu;
-	if (this_cpu_cmpxchg(rstatc_pcpu->lnode.next, self, NULL) != self)
+	expected = &rstatc->lnode;
+	if (!try_cmpxchg(&rstatc->lnode.next, &expected, NULL))
 		return;
 
 	lhead = ss_lhead_cpu(css->ss, cpu);
-- 
2.47.3


