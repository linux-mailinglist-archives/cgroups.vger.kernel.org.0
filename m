Return-Path: <cgroups+bounces-8245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C37ABA2FD
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC9FA2782F
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03727E7E3;
	Fri, 16 May 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wGT+sTxw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC842701A7
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420417; cv=none; b=qX4q391QeAUtziANJ5CAU5fD62rfPPboXldS+hvZQTo7KAfzUU/SjPbPcfdJdBEvEmjr+k/WTtI8nfiqKvyNjQ475kSMOwFyPGkk+qrlCCrOPcRpTIL4yyhSSey9DIaBMRJn+LTkWNEu53OAwXDkRZq8sIj0H4647vuZgh+XFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420417; c=relaxed/simple;
	bh=L1FANs75GnyENPpCSObB44OAjAEmVoUmb9ZL9SNNgvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD0v8lNVroSKtGyt1NgT/hSgZ1JB2mMYpJr2rXbMCL4mVWyse4lyPYIyZ76dFoTrQEFyAK7+ugE/OTMfZEFRc0w8Ina6oTRIYAZjqt+/Y4IfIbbor5vTwTYGKqzarbyzk+KDwDKHjySJKC6J2fayX9zbLFE2GVaI/8v7C4ejtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wGT+sTxw; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747420413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SZJx0aaLO11/z+3A95G9xQwNAh1dQNdtZG0PH2m5B0=;
	b=wGT+sTxw8c5WygTZyHNWxHhaBeB2Db0T1IwGsnrjo6DRHxIVPalq/OKAbL348LKt8va1ok
	aKSVg6JumoxRhbeUydIJnLCYaUZl1g3qyRWzBYmuyhOu/Iqm6w+cA2tmqB2KV7rna+FWdP
	5QoUGw+Hj0IkXGCzjaLre2twvGqg3tg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 5/5] memcg: make memcg_rstat_updated nmi safe
Date: Fri, 16 May 2025 11:32:31 -0700
Message-ID: <20250516183231.1615590-6-shakeel.butt@linux.dev>
In-Reply-To: <20250516183231.1615590-1-shakeel.butt@linux.dev>
References: <20250516183231.1615590-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently kernel maintains memory related stats updates per-cgroup to
optimize stats flushing. The stats_updates is defined as atomic64_t
which is not nmi-safe on some archs. Actually we don't really need 64bit
atomic as the max value stats_updates can get should be less than
nr_cpus * MEMCG_CHARGE_BATCH. A normal atomic_t should suffice.

Also the function cgroup_rstat_updated() is still not nmi-safe but there
is parallel effort to make it nmi-safe, so until then let's ignore it in
the nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e96c5d1ca912..2ace30fcd0e6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -533,7 +533,7 @@ struct memcg_vmstats {
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
 
 	/* Stats updates since the last flush */
-	atomic64_t		stats_updates;
+	atomic_t		stats_updates;
 };
 
 /*
@@ -559,7 +559,7 @@ static u64 flush_last_time;
 
 static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 {
-	return atomic64_read(&vmstats->stats_updates) >
+	return atomic_read(&vmstats->stats_updates) >
 		MEMCG_CHARGE_BATCH * num_online_cpus();
 }
 
@@ -573,7 +573,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+	/* TODO: add to cgroup update tree once it is nmi-safe. */
+	if (!in_nmi())
+		cgroup_rstat_updated(memcg->css.cgroup, cpu);
 	statc_pcpu = memcg->vmstats_percpu;
 	for (; statc_pcpu; statc_pcpu = statc->parent_pcpu) {
 		statc = this_cpu_ptr(statc_pcpu);
@@ -591,7 +593,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
 			continue;
 
 		stats_updates = this_cpu_xchg(statc_pcpu->stats_updates, 0);
-		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
+		atomic_add(stats_updates, &statc->vmstats->stats_updates);
 	}
 }
 
@@ -599,7 +601,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 {
 	bool needs_flush = memcg_vmstats_needs_flush(memcg->vmstats);
 
-	trace_memcg_flush_stats(memcg, atomic64_read(&memcg->vmstats->stats_updates),
+	trace_memcg_flush_stats(memcg, atomic_read(&memcg->vmstats->stats_updates),
 		force, needs_flush);
 
 	if (!force && !needs_flush)
@@ -4132,8 +4134,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	}
 	WRITE_ONCE(statc->stats_updates, 0);
 	/* We are in a per-cpu loop here, only do the atomic write once */
-	if (atomic64_read(&memcg->vmstats->stats_updates))
-		atomic64_set(&memcg->vmstats->stats_updates, 0);
+	if (atomic_read(&memcg->vmstats->stats_updates))
+		atomic_set(&memcg->vmstats->stats_updates, 0);
 }
 
 static void mem_cgroup_fork(struct task_struct *task)
-- 
2.47.1


