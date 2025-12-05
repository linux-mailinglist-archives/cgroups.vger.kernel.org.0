Return-Path: <cgroups+bounces-12281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA686CA9312
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0393C3028FCE
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B648340A6C;
	Fri,  5 Dec 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Advv6ByD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173B1C8611;
	Fri,  5 Dec 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964914; cv=none; b=Y1j6S/A1LDzcd/124omV0MNaStzfiD4rUPSIPfCl0MF51Q4+gNFUMFI1xIQXd8BtCL53+pxRe+LS+Fc32IFpNKz1yFzlrXJcFDoMuwtSGWbxRm6jdxCHw7wfxT/40IOOi5IyOTeM53ftX8Ii2TuMxDhNXGO3n+twALef4dVvXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964914; c=relaxed/simple;
	bh=GkR2cvibQzbT5bZlbXOJe6Y3frtwjyAIL4AhMmgcbnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEBkf7jr8r0GW9hf+JxzWbk5hVYXPZ6/gMrMNf1ghVMH5qkA8gWnRVoJG/5PLoavTDNcbn/VvqnoTa7+lp1kG5EKw5a9mvCFWSyOuLyNrK8i4OW8sYZ7kSL2ptpI3VoVpb00zSTN7Mz7+Znku+/ntF6OJApPu1F9eqjy9LoTC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Advv6ByD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764964909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y8JRrP85HeD4bfHzsqESrR1BUs8JDIpk2PBuI2nVfCM=;
	b=Advv6ByDKq8ve4f9Uu3WMvq6lj1OPuBWHBBtjx17tIvUqti2FXx8wEJ3l0t0s7gKzcXiL4
	5eA7OJfQMlbOiSNSeZf6uSVpCmTALXkn/SxaM3N19SU8KiJBbct5dixeG8+nFoeEQcfsPz
	vrpXVt+9MrKdkISt0IyiaKV1F/22B/o=
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
Subject: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Date: Fri,  5 Dec 2025 12:01:06 -0800
Message-ID: <20251205200106.3909330-1-shakeel.butt@linux.dev>
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
and thus all the updates on that CPU for that cgroup was being lost.

To confirm if this skew was indeed due to this CMPXCHG without LOCK in
css_rstat_updated(), we created a repro (using AI) at [1] which shows
that CMPXCHG without LOCK creates almost the same lnode corruption as
seem in Meta's fleet and with LOCK CMPXCHG the issue does not
reproduces.

Link: http://lore.kernel.org/efiagdwmzfwpdzps74fvcwq3n4cs36q33ij7eebcpssactv3zu@se4hqiwxcfxq [1]
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
---
Changes since v1:
- Updated the comments based on Tejun's feedback
- Added link to the reproducer
- Updated commit message
v1: http://lore.kernel.org/20251205022437.1743547-1-shakeel.butt@linux.dev

 kernel/cgroup/rstat.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 91b34ebd5370..3b4d71eec8b9 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -71,7 +71,6 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
 	struct llist_head *lhead;
 	struct css_rstat_cpu *rstatc;
-	struct css_rstat_cpu __percpu *rstatc_pcpu;
 	struct llist_node *self;
 
 	/*
@@ -104,18 +103,22 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	/*
 	 * This function can be renentered by irqs and nmis for the same cgroup
 	 * and may try to insert the same per-cpu lnode into the llist. Note
-	 * that llist_add() does not protect against such scenarios.
+	 * that llist_add() does not protect against such scenarios. In addition
+	 * this same per-cpu lnode can be modified through init_llist_node()
+	 * from css_rstat_flush() running on a different CPU.
 	 *
 	 * To protect against such stacked contexts of irqs/nmis, we use the
 	 * fact that lnode points to itself when not on a list and then use
-	 * this_cpu_cmpxchg() to atomically set to NULL to select the winner
+	 * try_cmpxchg() to atomically set to NULL to select the winner
 	 * which will call llist_add(). The losers can assume the insertion is
 	 * successful and the winner will eventually add the per-cpu lnode to
 	 * the llist.
+	 *
+	 * Please note that we can not use this_cpu_cmpxchg() here as on some
+	 * archs it is not safe against modifications from multiple CPUs.
 	 */
 	self = &rstatc->lnode;
-	rstatc_pcpu = css->rstat_cpu;
-	if (this_cpu_cmpxchg(rstatc_pcpu->lnode.next, self, NULL) != self)
+	if (!try_cmpxchg(&rstatc->lnode.next, &self, NULL))
 		return;
 
 	lhead = ss_lhead_cpu(css->ss, cpu);
-- 
2.47.3


