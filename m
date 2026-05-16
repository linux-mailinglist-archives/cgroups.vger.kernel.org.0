Return-Path: <cgroups+bounces-16000-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNhcBlMYCGpwZAMAu9opvQ
	(envelope-from <cgroups+bounces-16000-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 09:10:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8255A912
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 09:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59CA830191B9
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2137E2E5;
	Sat, 16 May 2026 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oyMB6gsV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o9uuHquk"
X-Original-To: cgroups@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E618DB1A;
	Sat, 16 May 2026 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778915400; cv=none; b=e+xn140VjBcCFfLHG4yNVYS6pPPluxEI1XRVNqztSLhVjPOEiL5QLBP7Ow/LfaeLUpuVeOA167vrQSiS+nlhJuT4Vfg6F4566PJl7BZ5MG2ciiWODUNJqWI2jpBQVims2TU5fgxAfLuELl6Jwa39TGCGpqEf7CLLZiqc65tqZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778915400; c=relaxed/simple;
	bh=lV+w0Ac36wFq4l4XxOkdZ/XAMtSjX2uErz74FJbKIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TD/D0A8P6Mvb17isoTnRg/0KGXZ3iYp9DXhaJ/kjJhpLuKKL3j1dT/zwxeCwwUHQLX2JcMm0UWKDUwQx281fW06nAsvQqI7eVmkpGWBHqZ/a79A4XynTZ8zW56lrbZV1GmHRXwub3ooz4t9BPXSSi7kw0iFvYJbdfgKVgYplFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oyMB6gsV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=o9uuHquk; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gHZvR0sf8z9yVt;
	Sat, 16 May 2026 09:09:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778915395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCTRR472fL00L0PSNs+VkKzuj6RmTK8wIoiHmuNbRls=;
	b=oyMB6gsVSD0ghwtNlOgdOxR8dM0Of2tddz2PEWv3N8MIoaEjSebnHERYYcq3/gnchTcMW7
	T1oChKRRnHRPLdCXaKdleZKIGLRUo3GkaJTeq1MKKEil+Nt1CX4q3YXWgMl0DkERVKbEt2
	jRQNb5Cg9VsxFS+my5b4Ig/Nnb2kZtbAouXZTANHYJnkuyBeJauoN/+9Iw7ziENHkcSBB5
	pDv4sGl7MWL7BZZ5qS9w3Usqwb7h1YkpR+Ze3Zs7UuacZsDSuPAlq68SWfGwHnG1sNDKO8
	kRIeKLD+Y5/OmOtLYevI4oxcOquYxHNl3Q+d18UM1iwuPkvQasRo11cQnINejw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=o9uuHquk;
	spf=pass (outgoing_mbo_mout: domain of a0yami@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a0yami@mailbox.org
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778915393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCTRR472fL00L0PSNs+VkKzuj6RmTK8wIoiHmuNbRls=;
	b=o9uuHqukR5PEQQJ2wmOSoCVU49Sf+2P0LanFGDJ1Vs4UlaAct3i8mlyULrcgLtxUz8Sccg
	f0gFs8TK3rxPTv5xa9eRo1V6u2Pj5LfAReUtz96izGOfWkrQsNRxF1iObIB0CkCf6bT0i6
	oRvkCOs7WSHRIZhjlEIG1ttQOE6po/yis1KP5wlg/yaHkrcfyOgW08A03yfC5JxyAN3tWL
	0LwBsasx8OA6hfCsqD2r3t0KURdbvUChc/4JAJJzSdACQ7Gz6tIZpXCBUHgvm7a+yNnLf9
	c3ALg4HSYfGARle732btOo3bC46xx1Wwj4P3Nx6spKWf1oetBdqh91OoQo6oNg==
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH v2] cgroup/rstat: validate cpu before css_rstat_cpu() access
Date: Sat, 16 May 2026 15:08:49 +0800
Message-ID: <20260516070849.106141-1-a0yami@mailbox.org>
In-Reply-To: <20260515122952.59209-1-a0yami@mailbox.org>
References: <20260515122952.59209-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cqjtyprk1mgmjgi3m5anood8wjajaezk
X-MBO-RS-ID: 2e6ac942611f7cd341e
X-Rspamd-Queue-Id: 61B8255A912
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16000-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0yami@mailbox.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

css_rstat_updated() is exposed as a BPF kfunc and accepts a
caller-provided cpu argument. The function uses cpu for per-cpu rstat
lookups without checking whether it refers to a valid possible CPU.

A BPF iter/cgroup program with CAP_BPF and CAP_PERFMON can pass an
invalid cpu value. On an unfixed UBSCAN_BOUNDS test kernel, cpu ==
0x7fffffff triggers:

  UBSAN: array-index-out-of-bounds in kernel/cgroup/rstat.c:31:9
  index 2147483647 is out of range for type 'long unsigned int [64]'
  Call Trace:
    css_rstat_updated
    bpf_iter_run_prog
    cgroup_iter_seq_show
    bpf_seq_read

Add cpu validation to the BPF-facing css_rstat_updated() kfunc and
move the common implementation to __css_rstat_updated() for in-kernel
callers.

Fixes: a319185be9f5 ("cgroup: bpf: enable bpf programs to integrate with rstat")
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
v2:
- Split css_rstat_updated() into a BPF-visible wrapper and an internal
  __css_rstat_updated() helper.
- Switch internal callers to __css_rstat_updated().

 block/blk-cgroup.c     |  2 +-
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 30 ++++++++++++++++++++----------
 mm/memcontrol.c        |  6 +++---
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 554c87bb4a86..bc63bd220865 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2241,7 +2241,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	css_rstat_updated(&blkcg->css, cpu);
+	__css_rstat_updated(&blkcg->css, cpu);
 	put_cpu();
 }
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f6d037a30fd8..c5648fcf74e2 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -777,6 +777,7 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup scalable recursive statistics.
  */
+void __css_rstat_updated(struct cgroup_subsys_state *css, int cpu);
 void css_rstat_updated(struct cgroup_subsys_state *css, int cpu);
 void css_rstat_flush(struct cgroup_subsys_state *css);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 150e5871e66f..ed60ba119c68 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "cgroup-internal.h"
 
+#include <linux/cpumask.h>
 #include <linux/sched/cputime.h>
 
 #include <linux/bpf.h>
@@ -53,7 +54,7 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
 }
 
 /**
- * css_rstat_updated - keep track of updated rstat_cpu
+ * __css_rstat_updated - keep track of updated rstat_cpu
  * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
@@ -63,20 +64,17 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
  *
  * NOTE: if the user needs the guarantee that the updater either add itself in
  * the lockless list or the concurrent flusher flushes its updated stats, a
- * memory barrier is needed before the call to css_rstat_updated() i.e. a
+ * memory barrier is needed before the call to __css_rstat_updated() i.e. a
  * barrier after updating the per-cpu stats and before calling
- * css_rstat_updated().
+ * __css_rstat_updated().
  */
-__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+void __css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
 	struct llist_head *lhead;
 	struct css_rstat_cpu *rstatc;
 	struct llist_node *self;
 
-	/*
-	 * Since bpf programs can call this function, prevent access to
-	 * uninitialized rstat pointers.
-	 */
+	/* Prevent access to uninitialized rstat pointers. */
 	if (!css_uses_rstat(css))
 		return;
 
@@ -125,6 +123,18 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	llist_add(&rstatc->lnode, lhead);
 }
 
+/*
+ * BPF-facing wrapper for __css_rstat_updated(). Validate the caller-provided
+ * CPU before passing it to the internal rstat updater.
+ */
+__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+{
+	if (unlikely(cpu < 0 || cpu >= nr_cpu_ids || !cpu_possible(cpu)))
+		return;
+
+	__css_rstat_updated(css, cpu);
+}
+
 static void __css_process_update_tree(struct cgroup_subsys_state *css, int cpu)
 {
 	/* put @css and all ancestors on the corresponding updated lists */
@@ -170,7 +180,7 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
 		 * flusher flush the stats updated by the updater who have
 		 * observed that they are already on the list. The
 		 * corresponding barrier pair for this one should be before
-		 * css_rstat_updated() by the user.
+		 * __css_rstat_updated() by the user.
 		 *
 		 * For now, there aren't any such user, so not adding the
 		 * barrier here but if such a use-case arise, please add
@@ -614,7 +624,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
-	css_rstat_updated(&cgrp->self, smp_processor_id());
+	__css_rstat_updated(&cgrp->self, smp_processor_id());
 	put_cpu_ptr(rstatbc);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d466..749c128b4fad 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -679,7 +679,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, long val,
 	if (!val)
 		return;
 
-	css_rstat_updated(&memcg->css, cpu);
+	__css_rstat_updated(&memcg->css, cpu);
 	statc_pcpu = memcg->vmstats_percpu;
 	for (; statc_pcpu; statc_pcpu = statc->parent_pcpu) {
 		statc = this_cpu_ptr(statc_pcpu);
@@ -2796,7 +2796,7 @@ static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
 
 		/* preemption is disabled in_nmi(). */
-		css_rstat_updated(&memcg->css, smp_processor_id());
+		__css_rstat_updated(&memcg->css, smp_processor_id());
 		if (idx == NR_SLAB_RECLAIMABLE_B)
 			atomic_add(nr, &pn->slab_reclaimable);
 		else
@@ -3019,7 +3019,7 @@ static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
 		mod_memcg_state(memcg, MEMCG_KMEM, val);
 	} else {
 		/* preemption is disabled in_nmi(). */
-		css_rstat_updated(&memcg->css, smp_processor_id());
+		__css_rstat_updated(&memcg->css, smp_processor_id());
 		atomic_add(val, &memcg->kmem_stat);
 	}
 }
-- 
2.53.0


