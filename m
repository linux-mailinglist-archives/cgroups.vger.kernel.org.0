Return-Path: <cgroups+bounces-16093-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLchOTCfDGq8jwUAu9opvQ
	(envelope-from <cgroups+bounces-16093-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 19:34:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7058324B
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA778307374C
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358583FC5D4;
	Tue, 19 May 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2jCGvBq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983C29ACDD;
	Tue, 19 May 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211905; cv=none; b=tYLywOIYaw8KhkcmG/MMWYRTWa80U7iNwfYAY7ACVRD0epvVej6LLheFBGA9JLrzl1dAoWTNNRHr1kV+jwti19i5cSZd7IZ832LzIevyHVmd/SmEzQvQOug1Yn7K1i5V3FZYBBfJPBs0g7J6TLpBQ7rRUl1FbhvQmbG5WTg9TUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211905; c=relaxed/simple;
	bh=V2C7BZkPFcoOezNCIfmh4zbGH2BkM3WPTC+0RlZjf/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=at8iFLizpcNMYLeFsxrgvA0BV1x8OBuZQgg1cigpUKbB2GClzQlDgE6HU++bLltYeUBuShQoBoKgRPneg56Q/fVzZc9YWFxbYOdIYJFCcMILhkGFjgcR9EorG4fHca9nzdat1wlpHVrc8bSiedJQS91riTEP57GaOdRvVHZBK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2jCGvBq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779211903; x=1810747903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V2C7BZkPFcoOezNCIfmh4zbGH2BkM3WPTC+0RlZjf/A=;
  b=X2jCGvBqfGyffq0fnG0btQuflakK8VFJwaKnK3nTfA595FCGr6h2DSzT
   ZhSiRcKWp0erc5yWcPHBI4aQ9tD/6n/+vMH2sRhhLQKBDWL3Jry5Fe5X3
   WrigFKGv/PBaei23eXZ9NKAXBdLJs8H4z3E6qKeYiyc4RvH7NOqYpfPGG
   WA2sLIUgoclHBnoo7finwhg2FUpg9LZZ9R3UkFrcAxOwiGav5Aa5YTvAj
   RdZ3S7Hdh7MNKEVbG0nx0jA8U0A4Z3msSQ8kwIjbQGEwCQrkjLMcRJnyA
   HPGC+9oIkrX/gsnyS5WIT+PyjfE5abEQj/NWsu2m6zQHnfiEEcXYboE4d
   A==;
X-CSE-ConnectionGUID: g9EiYjoYQEGHckFEIg2etw==
X-CSE-MsgGUID: S0HOeanIQ/GH1M7sTi09Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83954883"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83954883"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:31:42 -0700
X-CSE-ConnectionGUID: qLoJWYohRKa35NRwgH/hQQ==
X-CSE-MsgGUID: kS5N1TT8R7uHGQCxAajXQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="236837191"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.238])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:31:42 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cgroup/rstat: convert rstat lock from spinlock to rwlock
Date: Tue, 19 May 2026 12:31:34 -0500
Message-ID: <20260519173134.1486365-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16093-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.falcon@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5FE7058324B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement rstat_ss_lock and rstat_base_lock as read-write locks
instead of spinlocks. In addition, update tracing to reflect new
locking implementation.

The benchmark below, meant to simulate a workload performing many
concurrent cgroup cpu.stat reads, completes in 134 seconds on an Intel
Xeon Platinum 8568Y with 144 cpus compared to 241 seconds when
using spinlocks.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
Initially discussed here: https://lore.kernel.org/cgroups/20250617102644.752201-2-bertrand.wlodarczyk@intel.com/
Benchmark: https://gist.github.com/bwlodarcz/c955b36b5667f0167dffcff23953d1da
musl-gcc -o benchmark -static -g3 -DNUM_THREADS=10 -DNUM_ITER=10000 -O2 -Wall benchmark.c -pthread
---
include/linux/cgroup-defs.h   |  2 +-
 include/trace/events/cgroup.h | 22 ++++++++--------
 kernel/cgroup/rstat.c         | 47 ++++++++++++++++++++++-------------
 3 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 50a784da7a81..8609d6f6b29f 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -861,7 +861,7 @@ struct cgroup_subsys {
 	 */
 	unsigned int depends_on;
 
-	spinlock_t rstat_ss_lock;
+	rwlock_t rstat_ss_lock;
 	struct llist_head __percpu *lhead; /* lockless update list head */
 };
 
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index b736da06340a..1bd80a08c116 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -206,15 +206,16 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
 
 DECLARE_EVENT_CLASS(cgroup_rstat,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, int cpu, const char *type, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended),
+	TP_ARGS(cgrp, cpu, type, contended),
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
 		__field(	int,		level			)
 		__field(	u64,		id			)
 		__field(	int,		cpu			)
+		__string(	type,		type			)
 		__field(	bool,		contended		)
 	),
 
@@ -223,12 +224,13 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
 		__entry->id = cgroup_id(cgrp);
 		__entry->level = cgrp->level;
 		__entry->cpu = cpu;
+		__assign_str(type);
 		__entry->contended = contended;
 	),
 
-	TP_printk("root=%d id=%llu level=%d cpu=%d lock contended:%d",
+	TP_printk("root=%d id=%llu level=%d cpu=%d lock-type=%s lock contended:%d",
 		  __entry->root, __entry->id, __entry->level,
-		  __entry->cpu, __entry->contended)
+		  __entry->cpu, __get_str(type), __entry->contended)
 );
 
 /*
@@ -238,23 +240,23 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
  */
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, int cpu, const char *type, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended)
+	TP_ARGS(cgrp, cpu, type, contended)
 );
 
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_locked,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, int cpu, const char *type, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended)
+	TP_ARGS(cgrp, cpu, type, contended)
 );
 
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, int cpu, const char *type, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended)
+	TP_ARGS(cgrp, cpu, type, contended)
 );
 
 #endif /* _TRACE_CGROUP_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 150e5871e66f..e33f31914b7d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,7 +9,7 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(rstat_base_lock);
+static DEFINE_RWLOCK(rstat_base_lock);
 static DEFINE_PER_CPU(struct llist_head, rstat_backlog_list);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
@@ -37,7 +37,7 @@ static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
 	return per_cpu_ptr(cgrp->rstat_base_cpu, cpu);
 }
 
-static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
+static rwlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
 {
 	if (ss)
 		return &ss->rstat_ss_lock;
@@ -356,32 +356,45 @@ __bpf_hook_end();
  * number processed last.
  */
 static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
-		int cpu_in_loop)
+				    int cpu_in_loop, bool write)
 	__acquires(ss_rstat_lock(css->ss))
 {
+	const char *type = write ? "write" : "read";
 	struct cgroup *cgrp = css->cgroup;
-	spinlock_t *lock;
+	rwlock_t *lock;
 	bool contended;
 
 	lock = ss_rstat_lock(css->ss);
-	contended = !spin_trylock_irq(lock);
+
+	local_irq_disable();
+	contended = write ? !write_trylock(lock) : !read_trylock(lock);
 	if (contended) {
-		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
-		spin_lock_irq(lock);
+		local_irq_enable();
+		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, type, contended);
+		if (write)
+			write_lock_irq(lock);
+		else
+			read_lock_irq(lock);
 	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
+
+	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, type, contended);
 }
 
 static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
-				      int cpu_in_loop)
+				      int cpu_in_loop, bool write)
 	__releases(ss_rstat_lock(css->ss))
 {
+	const char *type = write ? "write" : "read";
 	struct cgroup *cgrp = css->cgroup;
-	spinlock_t *lock;
+	rwlock_t *lock;
 
 	lock = ss_rstat_lock(css->ss);
-	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(lock);
+	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, type, false);
+
+	if (write)
+		write_unlock_irq(lock);
+	else
+		read_unlock_irq(lock);
 }
 
 /**
@@ -414,7 +427,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 		struct cgroup_subsys_state *pos;
 
 		/* Reacquire for each CPU to avoid disabling IRQs too long */
-		__css_rstat_lock(css, cpu);
+		__css_rstat_lock(css, cpu, true);
 		pos = css_rstat_updated_list(css, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
 			if (is_self) {
@@ -424,7 +437,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 			} else
 				pos->ss->css_rstat_flush(pos, cpu);
 		}
-		__css_rstat_unlock(css, cpu);
+		__css_rstat_unlock(css, cpu, true);
 		if (!cond_resched())
 			cpu_relax();
 	}
@@ -525,7 +538,7 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 			return -ENOMEM;
 	}
 
-	spin_lock_init(ss_rstat_lock(ss));
+	rwlock_init(ss_rstat_lock(ss));
 	for_each_possible_cpu(cpu)
 		init_llist_head(ss_lhead_cpu(ss, cpu));
 
@@ -717,11 +730,11 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 
 	if (cgroup_parent(cgrp)) {
 		css_rstat_flush(&cgrp->self);
-		__css_rstat_lock(&cgrp->self, -1);
+		__css_rstat_lock(&cgrp->self, -1, false);
 		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &bstat.cputime.utime, &bstat.cputime.stime);
-		__css_rstat_unlock(&cgrp->self, -1);
+		__css_rstat_unlock(&cgrp->self, -1, false);
 	} else {
 		root_cgroup_cputime(&bstat);
 	}
-- 
2.43.0


